Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC82465B47
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344725AbhLBAsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:48:38 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39260 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344523AbhLBArF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:47:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D477BB821A5;
        Thu,  2 Dec 2021 00:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7522C58326;
        Thu,  2 Dec 2021 00:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405818;
        bh=Qzqztv8FrhL/cwpGA1IO0f3L9VhLXs9fpNRz0N3MM7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qp3S3P8ySom5S1ArxKmK9rq3X0EwtSGgPpIuCIISZPlqpewA5r4opxnvnLQ4J12cf
         Xn9ODc4HffNve9O/3gJ6WPUkD/IFbKCp9RVMlHH3FfGddu5FMny3zbdu9YQz2Asu5I
         xhbU1e3yM8J9mvYmRBodazlvqx1kofU2DANCVpjiH6Iuz358f7J3w2/Mr/wQigmiUI
         6C7KsjryoYdKs1NIVzOy1QDtnX4hUwZaZ3FjSOm4JfF9AwdZzg4ovbY9rqx3prGKNj
         uzyrE5l0Vno2TIR3P37f9+pZ00LZlJhbiai8mb9VaiY92A7xEIpJ7mcjED3j5vAGiT
         F1I9NAKJxkF6A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5CBBC5C12E4; Wed,  1 Dec 2021 16:43:38 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Li Zhijian <zhijianx.li@intel.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 12/17] locktorture,rcutorture,torture: Always log error message
Date:   Wed,  1 Dec 2021 16:43:31 -0800
Message-Id: <20211202004337.3130175-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202004245.GA3129966@paulmck-ThinkPad-P17-Gen-1>
References: <20211202004245.GA3129966@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Zhijian <zhijianx.li@intel.com>

Unconditionally log messages corresponding to errors.

Acked-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Li Zhijian <zhijianx.li@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/torture.h      | 9 ++-------
 kernel/locking/locktorture.c | 4 ++--
 kernel/rcu/rcutorture.c      | 8 ++++----
 kernel/torture.c             | 4 ++--
 4 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/include/linux/torture.h b/include/linux/torture.h
index 24f58e50a94b8..63fa4196e51cb 100644
--- a/include/linux/torture.h
+++ b/include/linux/torture.h
@@ -38,13 +38,8 @@ do {										\
 		pr_alert("%s" TORTURE_FLAG " %s\n", torture_type, s);		\
 	}									\
 } while (0)
-#define VERBOSE_TOROUT_ERRSTRING(s) \
-do {										\
-	if (verbose) {								\
-		verbose_torout_sleep();						\
-		pr_alert("%s" TORTURE_FLAG "!!! %s\n", torture_type, s);	\
-	}									\
-} while (0)
+#define TOROUT_ERRSTRING(s) \
+	pr_alert("%s" TORTURE_FLAG "!!! %s\n", torture_type, s)
 void verbose_torout_sleep(void);
 
 #define torture_init_error(firsterr)						\
diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 397ac13d2ef75..9c2fb613a55d2 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -1047,7 +1047,7 @@ static int __init lock_torture_init(void)
 				       sizeof(writer_tasks[0]),
 				       GFP_KERNEL);
 		if (writer_tasks == NULL) {
-			VERBOSE_TOROUT_ERRSTRING("writer_tasks: Out of memory");
+			TOROUT_ERRSTRING("writer_tasks: Out of memory");
 			firsterr = -ENOMEM;
 			goto unwind;
 		}
@@ -1058,7 +1058,7 @@ static int __init lock_torture_init(void)
 				       sizeof(reader_tasks[0]),
 				       GFP_KERNEL);
 		if (reader_tasks == NULL) {
-			VERBOSE_TOROUT_ERRSTRING("reader_tasks: Out of memory");
+			TOROUT_ERRSTRING("reader_tasks: Out of memory");
 			kfree(writer_tasks);
 			writer_tasks = NULL;
 			firsterr = -ENOMEM;
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 503e14e62e8f2..36a273589a35c 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2774,7 +2774,7 @@ static int rcu_torture_read_exit(void *unused)
 				     &trs, "%s",
 				     "rcu_torture_read_exit_child");
 		if (IS_ERR(tsp)) {
-			VERBOSE_TOROUT_ERRSTRING("out of memory");
+			TOROUT_ERRSTRING("out of memory");
 			errexit = true;
 			tsp = NULL;
 			break;
@@ -3101,7 +3101,7 @@ rcu_torture_init(void)
 					   sizeof(fakewriter_tasks[0]),
 					   GFP_KERNEL);
 		if (fakewriter_tasks == NULL) {
-			VERBOSE_TOROUT_ERRSTRING("out of memory");
+			TOROUT_ERRSTRING("out of memory");
 			firsterr = -ENOMEM;
 			goto unwind;
 		}
@@ -3117,7 +3117,7 @@ rcu_torture_init(void)
 	rcu_torture_reader_mbchk = kcalloc(nrealreaders, sizeof(*rcu_torture_reader_mbchk),
 					   GFP_KERNEL);
 	if (!reader_tasks || !rcu_torture_reader_mbchk) {
-		VERBOSE_TOROUT_ERRSTRING("out of memory");
+		TOROUT_ERRSTRING("out of memory");
 		firsterr = -ENOMEM;
 		goto unwind;
 	}
@@ -3136,7 +3136,7 @@ rcu_torture_init(void)
 	if (nrealnocbers > 0) {
 		nocb_tasks = kcalloc(nrealnocbers, sizeof(nocb_tasks[0]), GFP_KERNEL);
 		if (nocb_tasks == NULL) {
-			VERBOSE_TOROUT_ERRSTRING("out of memory");
+			TOROUT_ERRSTRING("out of memory");
 			firsterr = -ENOMEM;
 			goto unwind;
 		}
diff --git a/kernel/torture.c b/kernel/torture.c
index bb8f411c974b8..ef27a6c824514 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -570,7 +570,7 @@ int torture_shuffle_init(long shuffint)
 	shuffle_idle_cpu = -1;
 
 	if (!alloc_cpumask_var(&shuffle_tmp_mask, GFP_KERNEL)) {
-		VERBOSE_TOROUT_ERRSTRING("Failed to alloc mask");
+		TOROUT_ERRSTRING("Failed to alloc mask");
 		return -ENOMEM;
 	}
 
@@ -934,7 +934,7 @@ int _torture_create_kthread(int (*fn)(void *arg), void *arg, char *s, char *m,
 	*tp = kthread_run(fn, arg, "%s", s);
 	if (IS_ERR(*tp)) {
 		ret = PTR_ERR(*tp);
-		VERBOSE_TOROUT_ERRSTRING(f);
+		TOROUT_ERRSTRING(f);
 		*tp = NULL;
 	}
 	torture_shuffle_task_register(*tp);
-- 
2.31.1.189.g2e36527f23

