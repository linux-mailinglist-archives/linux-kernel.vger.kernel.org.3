Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3380F577257
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbiGPXSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiGPXRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:17:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835B722512
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:17:38 -0700 (PDT)
Message-ID: <20220716230953.619868339@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=b2tVGWEEQxEmKYvEfnlf9eVD7BzXQkIgf4CQYJfSWA0=;
        b=O7UhPxkCkQ737zainAw9aArz/bddAcpJHPpiD5Kp9M06wleZTQfXgKqex/jnpymI24hM6Z
        pHp4/VaBZ1nFNw8I9aByaY+wi5ZNvE2VbtGNnNmt9/9B9n25wCQqYIxXJR1Vr7YsQsHaYD
        ysVTkZMsDXnOjp3rrvt5extlWht2WG7n/hzF/eEoxm+otTc6g+ERiTvTRF838F/cXMni09
        jKDhMKLDD4VAioO3tT9wiMIJWmZ/aCsMSq/siLBQ/hBXXLvS0ixCsKeUTxPDZ2RGgL3Ijs
        c7hQIDLhpu9ORGAwo2S+Yh5Y4pn85grwGXekmfbZU2rTSiN0FQbZ9grthbhf4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=b2tVGWEEQxEmKYvEfnlf9eVD7BzXQkIgf4CQYJfSWA0=;
        b=CZ1DNdoIuzBl9Kb+DEaHZJzoEGs0pd4Dzz4uhF8KABrtdFczi0jr29Z2877TXr23Ow/qON
        9fbK9FEBsGbTFRBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [patch 16/38] modules: Make struct module_layout unconditionally available
References: <20220716230344.239749011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Jul 2022 01:17:35 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To simplify the upcoming call thunk code it's desired to expose struct
module_layout even on !MDOULES builds. This spares conditionals and
#ifdeffery.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/module.h |   44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -67,6 +67,28 @@ struct module_version_attribute {
 	const char *version;
 };
 
+struct mod_tree_node {
+	struct module *mod;
+	struct latch_tree_node node;
+};
+
+struct module_layout {
+	/* The actual code + data. */
+	void *base;
+	/* Total size. */
+	unsigned int size;
+	/* The size of the executable code.  */
+	unsigned int text_size;
+	/* Size of RO section of the module (text+rodata) */
+	unsigned int ro_size;
+	/* Size of RO after init section */
+	unsigned int ro_after_init_size;
+
+#ifdef CONFIG_MODULES_TREE_LOOKUP
+	struct mod_tree_node mtn;
+#endif
+};
+
 extern ssize_t __modver_version_show(struct module_attribute *,
 				     struct module_kobject *, char *);
 
@@ -316,28 +338,6 @@ enum module_state {
 	MODULE_STATE_UNFORMED,	/* Still setting it up. */
 };
 
-struct mod_tree_node {
-	struct module *mod;
-	struct latch_tree_node node;
-};
-
-struct module_layout {
-	/* The actual code + data. */
-	void *base;
-	/* Total size. */
-	unsigned int size;
-	/* The size of the executable code.  */
-	unsigned int text_size;
-	/* Size of RO section of the module (text+rodata) */
-	unsigned int ro_size;
-	/* Size of RO after init section */
-	unsigned int ro_after_init_size;
-
-#ifdef CONFIG_MODULES_TREE_LOOKUP
-	struct mod_tree_node mtn;
-#endif
-};
-
 #ifdef CONFIG_MODULES_TREE_LOOKUP
 /* Only touch one cacheline for common rbtree-for-core-layout case. */
 #define __module_layout_align ____cacheline_aligned

