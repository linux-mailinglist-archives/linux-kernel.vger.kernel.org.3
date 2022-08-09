Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE1E58D270
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 05:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbiHIDps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 23:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbiHIDpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 23:45:30 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEA1E11
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 20:45:26 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id ct13so7734141qvb.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 20:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5MABIRG6nEm+OGiGPNxYVuccSF7gvfiyC3wg2ETXvDw=;
        b=wZvnPLKS6/ywdXbZJhDoSvzkqPjlw1D3n0vkx0NvRZ4XY5R3+/f5vbNZt2sqa7SXnp
         g3f0l0lIxwILo85Cth+STI+mCu7p5k6NRKh1X1NxVwEBOMPfQRG+3yNl6TqQm3GtLDMW
         LbzAD8u9gU+mSq9YNbZp2kNrzclNMfdo8foyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5MABIRG6nEm+OGiGPNxYVuccSF7gvfiyC3wg2ETXvDw=;
        b=6UO+gVgFVUr/nyoAnBdIwmgU+f1qlfJl0GCGOXAME/ENkTExr88Yoi093KfYI38H7j
         qdMlstMd0F5p+5sMidcpdSc4Ux2KURlPdayhNEy+b6ejOJBGyBVhPQ1922Zl2u8/5RiY
         jQQHfXlRJjnOpfgEc9jPxKGQxrXenXvwg2hoxUuyrhmaZvo+BhIiEYMw1qZg2I0qo4rR
         chjO4s4qGOysQYrT/7zJclI0XOpmQozcXPf6ApXFsuDZxU9ICdRQXdO7CoRPbn/vVYHu
         R1l1W8G7xZFxDCP/ZfCHUU8pWcTZqwT+08YWSe25aW9+5fypH7QpYOiGvVJ/aXSRbmoP
         rY1Q==
X-Gm-Message-State: ACgBeo38u5u5Uppcsoo2RB78GkynnzVgDeuEj0HfcciYVKMHdz2UQPxM
        ckt0mqiQuoKGvJTYCKRwI1rMWbN3ZfVp8w==
X-Google-Smtp-Source: AA6agR7Cy9WbXMYdrEpzIPcjUfm7pClgb6Yqm9vNW9tmJ4nCKz7Zx9Nf8+93x7UVE1IZ93zZ/z7nNg==
X-Received: by 2002:a05:6214:20a2:b0:476:9071:2e60 with SMTP id 2-20020a05621420a200b0047690712e60mr17928197qvd.110.1660016725089;
        Mon, 08 Aug 2022 20:45:25 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id ca8-20020a05622a1f0800b0031f0b43629dsm9170979qtb.23.2022.08.08.20.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 20:45:24 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org, rcu@vger.kernel.org
Subject: [PATCH v3 resend 3/6] rcuscale: Add laziness and kfree tests
Date:   Tue,  9 Aug 2022 03:45:14 +0000
Message-Id: <20220809034517.3867176-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
In-Reply-To: <20220809034517.3867176-1-joel@joelfernandes.org>
References: <20220809034517.3867176-1-joel@joelfernandes.org>
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

We had 2 tests to rcuscale, one is a startup test to check whether we
are not too lazy or too hard working. Two, emulate kfree_rcu() itself to
use call_rcu_lazy() and check memory pressure. In my testing,
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
2.37.1.559.g78731f0fdb-goog

