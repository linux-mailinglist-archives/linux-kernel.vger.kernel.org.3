Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F111C465B33
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240641AbhLBArT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344179AbhLBArC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:47:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D599C061574;
        Wed,  1 Dec 2021 16:43:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D921CB8219A;
        Thu,  2 Dec 2021 00:43:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881E2C53FD0;
        Thu,  2 Dec 2021 00:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405818;
        bh=L7SE/GrqWx2gqKn883A6xZadTZz51AxngoJZVux8K7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WYhamq5rEY/Z3xRjPNV7NBZf3va1LgtuWaqhCkAk+Re0YutLrMW3qrP9cND4nm8oD
         GB8cFOsBlTqBlm6lGV6zAAtkQ9XE6Mj/3gQusZ1/Wt8XZZ9ug1HwYq2TdnQcS8wxCX
         +l7RI4HuuejsdDk+HIUD7grxxJXe2jZUWtSGqCKUuKYb1c/rzti8jNcAjwRfjJZfBv
         ybUjRv/sTwaUrt159F9Z0z4Z5crP8x8qFvJSpp1a2GBLVeIL+K5uD6ZGrGdKB0FY4a
         Ak/Hzr0zvso+jQi7I3J+kvRN8khm9onqhpFHBSAFjSrAhlpQ6DgfrxIpxilFuJQk9O
         uCX9tPLbqHnjw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 502935C110A; Wed,  1 Dec 2021 16:43:38 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Li Zhijian <lizhijian@cn.fujitsu.com>,
        Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 05/17] refscale: Prevent buffer to pr_alert() being too long
Date:   Wed,  1 Dec 2021 16:43:24 -0800
Message-Id: <20211202004337.3130175-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202004245.GA3129966@paulmck-ThinkPad-P17-Gen-1>
References: <20211202004245.GA3129966@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Zhijian <lizhijian@cn.fujitsu.com>

0Day/LKP observed that the refscale results fail to complete when larger
values of nrun (such as 300) are specified.  The problem is that printk()
can accept at most a 1024-byte buffer.  This commit therefore prints
the buffer whenever its length exceeds 800 bytes.

CC: Philip Li <philip.li@intel.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refscale.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index b59457cef88d5..d8ed1ca3adc04 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -604,7 +604,7 @@ static u64 process_durations(int n)
 	char *buf;
 	u64 sum = 0;
 
-	buf = kmalloc(128 + nreaders * 32, GFP_KERNEL);
+	buf = kmalloc(800 + 64, GFP_KERNEL);
 	if (!buf)
 		return 0;
 	buf[0] = 0;
@@ -617,13 +617,15 @@ static u64 process_durations(int n)
 
 		if (i % 5 == 0)
 			strcat(buf, "\n");
+		if (strlen(buf) >= 800) {
+			pr_alert("%s", buf);
+			buf[0] = 0;
+		}
 		strcat(buf, buf1);
 
 		sum += rt->last_duration_ns;
 	}
-	strcat(buf, "\n");
-
-	SCALEOUT("%s\n", buf);
+	pr_alert("%s\n", buf);
 
 	kfree(buf);
 	return sum;
@@ -647,7 +649,7 @@ static int main_func(void *arg)
 
 	VERBOSE_SCALEOUT("main_func task started");
 	result_avg = kzalloc(nruns * sizeof(*result_avg), GFP_KERNEL);
-	buf = kzalloc(64 + nruns * 32, GFP_KERNEL);
+	buf = kzalloc(800 + 64, GFP_KERNEL);
 	if (!result_avg || !buf) {
 		VERBOSE_SCALEOUT_ERRSTRING("out of memory");
 		goto oom_exit;
@@ -695,10 +697,7 @@ static int main_func(void *arg)
 	// Print the average of all experiments
 	SCALEOUT("END OF TEST. Calculating average duration per loop (nanoseconds)...\n");
 
-	buf[0] = 0;
-	strcat(buf, "\n");
-	strcat(buf, "Runs\tTime(ns)\n");
-
+	pr_alert("Runs\tTime(ns)\n");
 	for (exp = 0; exp < nruns; exp++) {
 		u64 avg;
 		u32 rem;
@@ -706,9 +705,13 @@ static int main_func(void *arg)
 		avg = div_u64_rem(result_avg[exp], 1000, &rem);
 		sprintf(buf1, "%d\t%llu.%03u\n", exp + 1, avg, rem);
 		strcat(buf, buf1);
+		if (strlen(buf) >= 800) {
+			pr_alert("%s", buf);
+			buf[0] = 0;
+		}
 	}
 
-	SCALEOUT("%s", buf);
+	pr_alert("%s", buf);
 
 oom_exit:
 	// This will shutdown everything including us.
-- 
2.31.1.189.g2e36527f23

