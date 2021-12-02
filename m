Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A3E465A79
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354188AbhLBAPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:15:22 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51168 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354105AbhLBAOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:14:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0361EB8219B;
        Thu,  2 Dec 2021 00:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E2DC58324;
        Thu,  2 Dec 2021 00:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638403842;
        bh=y9EN+/OPkGO4O1mufKguG8R1zCHZiRRXgzOSedxyZGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YR7tp1ZnjwXf/3QqJvXXVPRwCFyfUUVk/xjVQzxrobJtt3Njt1yZC3lgIfoFIDzpZ
         rAMm/ezl3FnPazEjkbTQqXnOihQXWYDHVsfQrQst5xaXChPMkoPL0igywqRHh4XBAS
         qRi9z2SrvVHRVbCOGaGQ3j2NWV0I/txuJlCnWEFoWnfbCVPtiA68fNMK58fDLavI5B
         iaq1awGeHGwFpRW4Hx/NXGSmvMyYoxE9z+q4A/NN07SAljxNJ0gNnkzB92LjYHiplE
         kOqqhNjVpysSWFb584kYYMtubY3QvARbV/wTX72wvB/XzFe8+CXHVT/TyX51540Jh3
         SlKWaPPWfcjjw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 069645C1278; Wed,  1 Dec 2021 16:10:42 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 7/7] rcu/exp: Mark current CPU as exp-QS in IPI loop second pass
Date:   Wed,  1 Dec 2021 16:10:40 -0800
Message-Id: <20211202001040.3126390-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202001016.GA3126278@paulmck-ThinkPad-P17-Gen-1>
References: <20211202001016.GA3126278@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

Expedited RCU grace periods invoke sync_rcu_exp_select_node_cpus(), which
takes two passes over the leaf rcu_node structure's CPUs.  The first
pass gathers up the current CPU and CPUs that are in dynticks idle mode.
The workqueue will report a quiescent state on their behalf later.
The second pass sends IPIs to the rest of the CPUs, but excludes the
current CPU, incorrectly assuming it has been included in the first
pass's list of CPUs.

Unfortunately the current CPU may have changed between the first and
second pass, due to the fact that the various rcu_node structures'
->lock fields have been dropped, thus momentarily enabling preemption.
This means that if the second pass's CPU was not on the first pass's
list, it will be ignored completely.  There will be no IPI sent to
it, and there will be no reporting of quiescent states on its behalf.
Unfortunately, the expedited grace period will nevertheless be waiting
for that CPU to report a quiescent state, but with that CPU having no
reason to believe that such a report is needed.

The result will be an expedited grace period stall.

Fix this by no longer excluding the current CPU from consideration during
the second pass.

Fixes: b9ad4d6ed18e ("rcu: Avoid self-IPI in sync_rcu_exp_select_node_cpus()")
Reviewed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index a96d17206d87a..237a79989abae 100644
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
2.31.1.189.g2e36527f23

