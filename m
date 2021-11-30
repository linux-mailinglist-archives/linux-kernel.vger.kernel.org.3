Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68E9463B9E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243331AbhK3QYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:24:38 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51598 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243034AbhK3QYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:24:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D817FB817FA;
        Tue, 30 Nov 2021 16:21:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43730C53FCD;
        Tue, 30 Nov 2021 16:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638289275;
        bh=/nrsI8u9KiV6D9wKyCt4jEF4zLbK0cDtpbiJJgjYZ/I=;
        h=From:To:Cc:Subject:Date:From;
        b=IE+AhUdVxHgJjF/BD9vSFxqTJaiqIUB2PQ18YFvZekhYAVoZnIE7c0WXOLi+txlPc
         uklWSV32cEkjaTho2jMUKCmUqIac56e1gXfd9rMXLSuBy6Sa+ou+fkBBGNwrg2+DsQ
         lj+OZkU3WnYjCNSOYiie7iaqfFbShPARccfi5UUkuffwKC5fJfq/9w46FXSRlHU2JK
         S6aRH2DUa4oo4m5Bq7JtZbmnIpbdFtcse/OEjY9xHhJBBKnoBDZjEoS3SkXJCY7gfu
         hIbkB8Zglh+kT1z2syY9wAMDBeyl+5oYNRXn0lcai6Gr6auH4ag3qqmVF7r572fzfN
         8QZJ+QSvY0sMg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH] rcu/exp: Mark current CPU as exp-QS in IPI loop second pass
Date:   Tue, 30 Nov 2021 17:21:08 +0100
Message-Id: <20211130162108.605092-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While looping through the rnp's CPUs to IPI for an expedited grace
period, a first pass excludes the current CPU and the CPUs in dynticks
idle mode. The workqueue will report their QS on their behalf later.

The second pass processes the IPIs and also ignores the current CPU,
assuming it has been previously included in the group of CPUs whose
QS are to be reported by the workqueue.

Unfortunately the current CPU may have changed between the first and
second pass, due to the rnp lock being dropped, re-enabling preemption.
As a result the current CPU, if different in the second pass, may be
ignored by the expedited grace period. No IPI will be sent to it
so it won't be requested to report an expedited quiescent state.

This ends up in an expedited grace period stall.

Fix this with including the current CPU in the second round in the group
of CPUs to report a QS for by the workqueue.

Fixes: b9ad4d6ed18e ("rcu: Avoid self-IPI in sync_rcu_exp_select_node_cpus()")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 kernel/rcu/tree_exp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index a96d17206d87..237a79989aba 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -387,6 +387,7 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 			continue;
 		}
 		if (get_cpu() == cpu) {
+			mask_ofl_test |= mask;
 			put_cpu();
 			continue;
 		}
-- 
2.25.1

