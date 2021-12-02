Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F4D465B48
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354817AbhLBAsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:48:42 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39264 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344508AbhLBArE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:47:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7913B821A6;
        Thu,  2 Dec 2021 00:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB998C5832A;
        Thu,  2 Dec 2021 00:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405818;
        bh=CDWYIZN0egYDtkPi1rKVE2ouFIuZD+ikXLuy7Mkx7HY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Toi8sGV9mzgN4A0RiwkSn5IZB2iNxN5uND65xOJGkTJOwFwjcq7/wYmd1Eq9j/Jh7
         RAJ+AvCilxyZg+VspEtGCLW7o7aqwRkmOqeDTC9nD7T0tGPD7Y06v/X0rWqRj+kJTu
         jO4otO6ico3SpvKoJPCzKdEGJilL+XtiXfF1Y7RRmuKrupRKaAOiSVst3w4dB86a3l
         +IazD3XkRIdLOAB4ouc2zbxVtKO517WCP3KLbiEk9uJAL/M+vREG1uW0E+AqRnEipq
         /6eVSKFcHv0pARzm5ZteDy11zhQ9sto8Tw6wsO+V1Yj3KI5AL8/jrckzWkH9wOkIC3
         6j0JEdEI0hjyw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 603975C1339; Wed,  1 Dec 2021 16:43:38 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Subject: [PATCH rcu 14/17] rcutorture: Test RCU-tasks multiqueue callback queueing
Date:   Wed,  1 Dec 2021 16:43:33 -0800
Message-Id: <20211202004337.3130175-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202004245.GA3129966@paulmck-ThinkPad-P17-Gen-1>
References: <20211202004245.GA3129966@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit modifies the TASKS01 scenario to use four callback queues
and the TRACE01 scenario to use two queues, thus providing testing of
multiple queues by default.

Cc: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TASKS01.boot | 1 +
 tools/testing/selftests/rcutorture/configs/rcu/TRACE01.boot | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TASKS01.boot b/tools/testing/selftests/rcutorture/configs/rcu/TASKS01.boot
index 22cdeced98ea8..30ca5b493c4b1 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TASKS01.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TASKS01.boot
@@ -1,2 +1,3 @@
 rcutorture.torture_type=tasks
 rcutree.use_softirq=0
+rcupdate.rcu_task_enqueue_lim=4
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRACE01.boot b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01.boot
index 9675ad632dcc2..ba6d636a48564 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TRACE01.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01.boot
@@ -1 +1,2 @@
 rcutorture.torture_type=tasks-tracing
+rcupdate.rcu_task_enqueue_lim=2
-- 
2.31.1.189.g2e36527f23

