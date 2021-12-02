Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D856465B32
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354791AbhLBArM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:47:12 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39208 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240698AbhLBArC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:47:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2D15B8219C;
        Thu,  2 Dec 2021 00:43:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C36C53FAD;
        Thu,  2 Dec 2021 00:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405818;
        bh=9biqP1RCTCgjkIN/qW+wkgcZ85SDs/sm55AE2Fvma1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IDLLH9Swz+GkIf0meOElMLyVlmeVd6SQaFkS9mPMf/YIR6R4TM7aossDf6bjFmM2b
         MtaqW8Y+YC5xCnh8+SfWvp5469L4M5Jt4ELe4cZUXhMATQImHZFkY9T+HdVfrI/lJ7
         RiFX/jGmLaLDz0yrvOGhftd9upsNpnTDvbD5wvEbj+wQpzeTcRe0LFbRR+cV8PP92Z
         dfZCHnfClcLOBy0ishflfKb7idtB6pqaRlxtfGgofb3GXNKyL1Q5GGXXlzibPLzGus
         ZIwFldvWH4rhjOm3X4Bmx5YOi5wjDj33yGGaQvA7LI8MarPNrGlkcywFzt7Hxk1hHP
         UouPkv9tPF7dA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4E3555C1109; Wed,  1 Dec 2021 16:43:38 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Li Zhijian <lizhijian@cn.fujitsu.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 04/17] refscale: Simplify the errexit checkpoint
Date:   Wed,  1 Dec 2021 16:43:23 -0800
Message-Id: <20211202004337.3130175-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202004245.GA3129966@paulmck-ThinkPad-P17-Gen-1>
References: <20211202004245.GA3129966@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Zhijian <lizhijian@cn.fujitsu.com>

There is only the one OOM error case in main_func(), so this commit
eliminates the errexit local variable in favor of a branch to cleanup
code.

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refscale.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 1631ef8a138db..b59457cef88d5 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -637,7 +637,6 @@ static u64 process_durations(int n)
 // point all the timestamps are printed.
 static int main_func(void *arg)
 {
-	bool errexit = false;
 	int exp, r;
 	char buf1[64];
 	char *buf;
@@ -651,7 +650,7 @@ static int main_func(void *arg)
 	buf = kzalloc(64 + nruns * 32, GFP_KERNEL);
 	if (!result_avg || !buf) {
 		VERBOSE_SCALEOUT_ERRSTRING("out of memory");
-		errexit = true;
+		goto oom_exit;
 	}
 	if (holdoff)
 		schedule_timeout_interruptible(holdoff * HZ);
@@ -663,8 +662,6 @@ static int main_func(void *arg)
 
 	// Start exp readers up per experiment
 	for (exp = 0; exp < nruns && !torture_must_stop(); exp++) {
-		if (errexit)
-			break;
 		if (torture_must_stop())
 			goto end;
 
@@ -698,26 +695,22 @@ static int main_func(void *arg)
 	// Print the average of all experiments
 	SCALEOUT("END OF TEST. Calculating average duration per loop (nanoseconds)...\n");
 
-	if (!errexit) {
-		buf[0] = 0;
-		strcat(buf, "\n");
-		strcat(buf, "Runs\tTime(ns)\n");
-	}
+	buf[0] = 0;
+	strcat(buf, "\n");
+	strcat(buf, "Runs\tTime(ns)\n");
 
 	for (exp = 0; exp < nruns; exp++) {
 		u64 avg;
 		u32 rem;
 
-		if (errexit)
-			break;
 		avg = div_u64_rem(result_avg[exp], 1000, &rem);
 		sprintf(buf1, "%d\t%llu.%03u\n", exp + 1, avg, rem);
 		strcat(buf, buf1);
 	}
 
-	if (!errexit)
-		SCALEOUT("%s", buf);
+	SCALEOUT("%s", buf);
 
+oom_exit:
 	// This will shutdown everything including us.
 	if (shutdown) {
 		shutdown_start = 1;
-- 
2.31.1.189.g2e36527f23

