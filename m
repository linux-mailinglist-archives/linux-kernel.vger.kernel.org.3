Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A01556EAC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 00:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbiFVWwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 18:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235515AbiFVWvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 18:51:48 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE9240A3E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 15:51:47 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id n197so13716696qke.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 15:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VLpRj7ISmpLc7bYzOd0iAFFn8wSs/6G7/zuKg/d2BV4=;
        b=uUovH7zphZj5j44vTCjc6fQKvn5vsTqcZUI+oVj1KSCucV7WrcEJQ8xUffNEA3EpXw
         GDZIrTbjd/nV4pr6O7V+SKKTEYqB8ykmpL9P4Z5A7FiTLFLHAH9e+1C715gu+U1RgZmp
         p9M3xiILqZ6xnVI8MP1Vs70BvMK0jUzTgAYIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VLpRj7ISmpLc7bYzOd0iAFFn8wSs/6G7/zuKg/d2BV4=;
        b=aQoHLfViZY6ZNlZV9A1caPmqaB5nNB7I7UAsVzP/+lOyD1QRfL8yaT+gFcSY6Y9K3Q
         UiNNc1oH6TA9HU2bL0PwFt0s/L3by4dfWmASOpCwRU9bXOOn8apKi07umeruGpxYYiQj
         x+jRlcCTgLqdbFtFr8DAzEOCZhgqLwJpg9Mwb/+/FPh3S3gEX9SwefSDswKeZjhZ9u5s
         9F1u/0kCQzHmcwYqFzz0O2CMboAO3Edgq8VYsfk7DhZnakzogVc0eoHjR3NJ02bLtmc3
         7vp3Ldk/bSElWirllL3zlvyjq9EIo6P/cD0XmmkpU16crZdDo6Rw4nkyHXp6mbNxAIc9
         Xksw==
X-Gm-Message-State: AJIora/o/5pgCrlo6nNb3NyUcUWeN+q2Wxac7FV6tKwxvl8z6kTQsA3S
        bmYuallLLEdI4VcNh/0McLRZCA==
X-Google-Smtp-Source: AGRyM1sPh4hJnzcz0VNfhHC4UeQg+s3UcijJzqY655+yVI85xyoOc6cAptRFlkJHV19NUU17LL9gZg==
X-Received: by 2002:a37:c86:0:b0:6ae:ded5:2002 with SMTP id 128-20020a370c86000000b006aeded52002mr3616328qkm.594.1655938306664;
        Wed, 22 Jun 2022 15:51:46 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id k66-20020a37a145000000b006ab91fd03fasm1794022qke.19.2022.06.22.15.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 15:51:46 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v2 6/8] rcuscale: Add test for using call_rcu_lazy() to emulate kfree_rcu()
Date:   Wed, 22 Jun 2022 22:51:00 +0000
Message-Id: <20220622225102.2112026-8-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
In-Reply-To: <20220622225102.2112026-1-joel@joelfernandes.org>
References: <20220622225102.2112026-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reuse the kfree_rcu() test in order to be able to compare the memory reclaiming
properties of call_rcu_lazy() with kfree_rcu().

With this test, we find similar memory footprint and time call_rcu_lazy()
free'ing takes compared to kfree_rcu(). Also we confirm that call_rcu_lazy()
can survive OOM during extremely frequent calls.

If we really push it, i.e. boot system with low memory and compare
kfree_rcu() with call_rcu_lazy(), I find that call_rcu_lazy() is more
resilient and is much harder to produce OOM as compared to kfree_rcu().

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcu.h       |  6 ++++
 kernel/rcu/rcuscale.c  | 64 +++++++++++++++++++++++++++++++++++++++++-
 kernel/rcu/tree_nocb.h | 17 ++++++++++-
 3 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 71c0f45e70c3..436faf80a66b 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -473,6 +473,12 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
 			       unsigned long c);
 void rcu_gp_set_torture_wait(int duration);
 void rcu_force_call_rcu_to_lazy(bool force);
+
+#if IS_ENABLED(CONFIG_RCU_SCALE_TEST)
+unsigned long rcu_scale_get_jiffies_till_flush(void);
+void rcu_scale_set_jiffies_till_flush(unsigned long j);
+#endif
+
 #else
 static inline void rcutorture_get_gp_data(enum rcutorture_type test_type,
 					  int *flags, unsigned long *gp_seq)
diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 277a5bfb37d4..58ee5c2cb37b 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -95,6 +95,7 @@ torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
 torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
 torture_param(int, kfree_rcu_test, 0, "Do we run a kfree_rcu() scale test?");
 torture_param(int, kfree_mult, 1, "Multiple of kfree_obj size to allocate.");
+torture_param(int, kfree_rcu_by_lazy, 0, "Use call_rcu_lazy() to emulate kfree_rcu()?");
 
 static char *scale_type = "rcu";
 module_param(scale_type, charp, 0444);
@@ -658,6 +659,13 @@ struct kfree_obj {
 	struct rcu_head rh;
 };
 
+/* Used if doing RCU-kfree'ing via call_rcu_lazy(). */
+void kfree_rcu_lazy(struct rcu_head *rh)
+{
+	struct kfree_obj *obj = container_of(rh, struct kfree_obj, rh);
+	kfree(obj);
+}
+
 static int
 kfree_scale_thread(void *arg)
 {
@@ -695,6 +703,11 @@ kfree_scale_thread(void *arg)
 			if (!alloc_ptr)
 				return -ENOMEM;
 
+			if (kfree_rcu_by_lazy) {
+				call_rcu_lazy(&(alloc_ptr->rh), kfree_rcu_lazy);
+				continue;
+			}
+
 			// By default kfree_rcu_test_single and kfree_rcu_test_double are
 			// initialized to false. If both have the same value (false or true)
 			// both are randomly tested, otherwise only the one with value true
@@ -737,6 +750,9 @@ kfree_scale_cleanup(void)
 {
 	int i;
 
+	if (kfree_rcu_by_lazy)
+		rcu_force_call_rcu_to_lazy(false);
+
 	if (torture_cleanup_begin())
 		return;
 
@@ -766,11 +782,55 @@ kfree_scale_shutdown(void *arg)
 	return -EINVAL;
 }
 
+// Used if doing RCU-kfree'ing via call_rcu_lazy().
+unsigned long jiffies_at_lazy_cb;
+struct rcu_head lazy_test1_rh;
+int rcu_lazy_test1_cb_called;
+void call_rcu_lazy_test1(struct rcu_head *rh)
+{
+	jiffies_at_lazy_cb = jiffies;
+	WRITE_ONCE(rcu_lazy_test1_cb_called, 1);
+}
+
 static int __init
 kfree_scale_init(void)
 {
 	long i;
 	int firsterr = 0;
+	unsigned long orig_jif, jif_start;
+
+	// Force all call_rcu() to call_rcu_lazy() so that non-lazy CBs
+	// do not remove laziness of the lazy ones (since the test tries
+	// to stress call_rcu_lazy() for OOM).
+	//
+	// Also, do a quick self-test to ensure laziness is as much as
+	// expected.
+	if (kfree_rcu_by_lazy) {
+		/* do a test to check the timeout. */
+		orig_jif = rcu_scale_get_jiffies_till_flush();
+
+		rcu_force_call_rcu_to_lazy(true);
+		rcu_scale_set_jiffies_till_flush(2 * HZ);
+		rcu_barrier();
+
+		jif_start = jiffies;
+		jiffies_at_lazy_cb = 0;
+		call_rcu_lazy(&lazy_test1_rh, call_rcu_lazy_test1);
+
+		smp_cond_load_relaxed(&rcu_lazy_test1_cb_called, VAL == 1);
+
+		rcu_scale_set_jiffies_till_flush(orig_jif);
+
+		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start < 2 * HZ)) {
+			pr_alert("Lazy CBs are not being lazy as expected!\n");
+			return -1;
+		}
+
+		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start > 3 * HZ)) {
+			pr_alert("Lazy CBs are being too lazy!\n");
+			return -1;
+		}
+	}
 
 	kfree_nrealthreads = compute_real(kfree_nthreads);
 	/* Start up the kthreads. */
@@ -783,7 +843,9 @@ kfree_scale_init(void)
 		schedule_timeout_uninterruptible(1);
 	}
 
-	pr_alert("kfree object size=%zu\n", kfree_mult * sizeof(struct kfree_obj));
+	pr_alert("kfree object size=%zu, kfree_rcu_by_lazy=%d\n",
+			kfree_mult * sizeof(struct kfree_obj),
+			kfree_rcu_by_lazy);
 
 	kfree_reader_tasks = kcalloc(kfree_nrealthreads, sizeof(kfree_reader_tasks[0]),
 			       GFP_KERNEL);
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index b481f1ea57c0..255f2945b0fc 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -257,6 +257,21 @@ static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
 }
 
 #define LAZY_FLUSH_JIFFIES (10 * HZ)
+unsigned long jiffies_till_flush = LAZY_FLUSH_JIFFIES;
+
+#ifdef CONFIG_RCU_SCALE_TEST
+void rcu_scale_set_jiffies_till_flush(unsigned long jif)
+{
+	jiffies_till_flush = jif;
+}
+EXPORT_SYMBOL(rcu_scale_set_jiffies_till_flush);
+
+unsigned long rcu_scale_get_jiffies_till_flush(void)
+{
+	return jiffies_till_flush;
+}
+EXPORT_SYMBOL(rcu_scale_get_jiffies_till_flush);
+#endif
 
 /*
  * Arrange to wake the GP kthread for this NOCB group at some future
@@ -275,7 +290,7 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
 	 * of callback storm, no need to wake up too early.
 	 */
 	if (waketype == RCU_NOCB_WAKE_LAZY) {
-		mod_timer(&rdp_gp->nocb_timer, jiffies + LAZY_FLUSH_JIFFIES);
+		mod_timer(&rdp_gp->nocb_timer, jiffies + jiffies_till_flush);
 		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
 	} else if (waketype == RCU_NOCB_WAKE_BYPASS) {
 		mod_timer(&rdp_gp->nocb_timer, jiffies + 2);
-- 
2.37.0.rc0.104.g0611611a94-goog

