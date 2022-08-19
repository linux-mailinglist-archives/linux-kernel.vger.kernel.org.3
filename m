Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA1659A729
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 22:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351759AbiHSUtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 16:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351317AbiHSUtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 16:49:12 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A186A061E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:49:07 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id b9so4121447qka.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=JSZQFOSju4bKCbYuTUWbkQrUq8c2e+wetnXoNQ/tht0=;
        b=caHyO3BmP+0RpkPUaYE04/HYeqfdQU2RKMn4DwMgWRu0rJG/nRGkA7j1MqVK/EpFbb
         MWetztEvdSaiHrkbE47XvgxtC269jGLU6f/T21p4Anh9Y2NO/LbAaJpaZ/IKiYkfSDpE
         wM5Pb01twdId5UQJU4Fqnah2YU2iVXgl5uccM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=JSZQFOSju4bKCbYuTUWbkQrUq8c2e+wetnXoNQ/tht0=;
        b=XRa3qquv5fncSqK1ZNG/1DoDOoyQnStxsyn4btlUvV0A+t1ZAK2V5DDtgXAvgubgzB
         EwIYfMca1jFbnAZ0E4NYDi9Yef7Z4ni/e1XoW8K8/f2qQbXAMwYHaRZZkoCBS1dBXt59
         fvyUiYd6GbeIAPSAM8pFt6dZnejGmIuvwoDExA5/WTUs/U1gOGdXtvsC62KThKtDc0R0
         9+TF8dknPa+nGzjGsgEJKZpvnCs4sZAH/2eROOJuuCVgiLjZmTNx52WtLD7mxEhIKJvg
         45GU4k/u6YWpI/oPJ+IDTzkS794oTKTUW7CChuFxn8L8XgjfDlkDAZqav4qV5fbQz6gi
         8SWw==
X-Gm-Message-State: ACgBeo0pOfPQO6/37C+vwWBgQQtBmRnCKSgRZQuF5ivN1hMtC7EN6aJv
        KnxCOV/i5jpzNvLPo9w98WFA+vdsel9zxA==
X-Google-Smtp-Source: AA6agR4z4jgkFfg7uRkEkkb5jX+zLRAP7ehrAQSepSz3xp65zrEriNppnDOFer4fL5iBHOMoaipLQA==
X-Received: by 2002:a05:620a:1a13:b0:6b8:bd72:a0b2 with SMTP id bk19-20020a05620a1a1300b006b8bd72a0b2mr6209407qkb.229.1660942146313;
        Fri, 19 Aug 2022 13:49:06 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id x8-20020a05620a258800b006b9a89d408csm4377123qko.100.2022.08.19.13.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:49:06 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        paulmck@kernel.org,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, vineeth@bitbyteword.org
Subject: [PATCH v4 03/14] rcuscale: Add laziness and kfree tests
Date:   Fri, 19 Aug 2022 20:48:46 +0000
Message-Id: <20220819204857.3066329-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
In-Reply-To: <20220819204857.3066329-1-joel@joelfernandes.org>
References: <20220819204857.3066329-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We aad 2 tests to rcuscale, first one is a startup test to check whether
we are not too lazy or too hard working. Two, emulate kfree_rcu() itself
to use call_rcu_lazy() and check memory pressure. In my testing,
call_rcu_lazy() does well to keep memory pressure under control, similar
to kfree_rcu().

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcuscale.c | 74 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 277a5bfb37d4..ed5544227f4d 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -95,6 +95,7 @@ torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
 torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
 torture_param(int, kfree_rcu_test, 0, "Do we run a kfree_rcu() scale test?");
 torture_param(int, kfree_mult, 1, "Multiple of kfree_obj size to allocate.");
+torture_param(int, kfree_rcu_by_lazy, 0, "Use call_rcu_lazy() to emulate kfree_rcu()?");
 
 static char *scale_type = "rcu";
 module_param(scale_type, charp, 0444);
@@ -658,6 +659,14 @@ struct kfree_obj {
 	struct rcu_head rh;
 };
 
+/* Used if doing RCU-kfree'ing via call_rcu_lazy(). */
+static void kfree_rcu_lazy(struct rcu_head *rh)
+{
+	struct kfree_obj *obj = container_of(rh, struct kfree_obj, rh);
+
+	kfree(obj);
+}
+
 static int
 kfree_scale_thread(void *arg)
 {
@@ -695,6 +704,11 @@ kfree_scale_thread(void *arg)
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
@@ -737,6 +751,9 @@ kfree_scale_cleanup(void)
 {
 	int i;
 
+	if (kfree_rcu_by_lazy)
+		rcu_force_call_rcu_to_lazy(false);
+
 	if (torture_cleanup_begin())
 		return;
 
@@ -766,11 +783,64 @@ kfree_scale_shutdown(void *arg)
 	return -EINVAL;
 }
 
+// Used if doing RCU-kfree'ing via call_rcu_lazy().
+static unsigned long jiffies_at_lazy_cb;
+static struct rcu_head lazy_test1_rh;
+static int rcu_lazy_test1_cb_called;
+static void call_rcu_lazy_test1(struct rcu_head *rh)
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
+	// If lazy-rcu based kfree'ing is requested, then for kernels that
+	// support it, force all call_rcu() to call_rcu_lazy() so that non-lazy
+	// CBs do not remove laziness of the lazy ones (since the test tries to
+	// stress call_rcu_lazy() for OOM).
+	//
+	// Also, do a quick self-test to ensure laziness is as much as
+	// expected.
+	if (kfree_rcu_by_lazy && !IS_ENABLED(CONFIG_RCU_LAZY)) {
+		pr_alert("CONFIG_RCU_LAZY is disabled, falling back to kfree_rcu() "
+			 "for delayed RCU kfree'ing\n");
+		kfree_rcu_by_lazy = 0;
+	}
+
+	if (kfree_rcu_by_lazy) {
+		/* do a test to check the timeout. */
+		orig_jif = rcu_lazy_get_jiffies_till_flush();
+
+		rcu_force_call_rcu_to_lazy(true);
+		rcu_lazy_set_jiffies_till_flush(2 * HZ);
+		rcu_barrier();
+
+		jif_start = jiffies;
+		jiffies_at_lazy_cb = 0;
+		call_rcu_lazy(&lazy_test1_rh, call_rcu_lazy_test1);
+
+		smp_cond_load_relaxed(&rcu_lazy_test1_cb_called, VAL == 1);
+
+		rcu_lazy_set_jiffies_till_flush(orig_jif);
+
+		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start < 2 * HZ)) {
+			pr_alert("ERROR: Lazy CBs are not being lazy as expected!\n");
+			WARN_ON_ONCE(1);
+			return -1;
+		}
+
+		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start > 3 * HZ)) {
+			pr_alert("ERROR: Lazy CBs are being too lazy!\n");
+			WARN_ON_ONCE(1);
+			return -1;
+		}
+	}
 
 	kfree_nrealthreads = compute_real(kfree_nthreads);
 	/* Start up the kthreads. */
@@ -783,7 +853,9 @@ kfree_scale_init(void)
 		schedule_timeout_uninterruptible(1);
 	}
 
-	pr_alert("kfree object size=%zu\n", kfree_mult * sizeof(struct kfree_obj));
+	pr_alert("kfree object size=%zu, kfree_rcu_by_lazy=%d\n",
+			kfree_mult * sizeof(struct kfree_obj),
+			kfree_rcu_by_lazy);
 
 	kfree_reader_tasks = kcalloc(kfree_nrealthreads, sizeof(kfree_reader_tasks[0]),
 			       GFP_KERNEL);
-- 
2.37.2.609.g9ff673ca1a-goog

