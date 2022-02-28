Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6164C7E99
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 00:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbiB1Xoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 18:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiB1XoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 18:44:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7CBEEDF11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 15:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646091817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eMk2ddem3feNmKWVGBt5fQ2XD1104DD2sU5e2PuX3nw=;
        b=LVQvThpEjWQiw9dI9Bx/jjzN46S/mnd4Zo3BKgnZiSDrgjzDxeCkwV30OQlpclS/EFuzOy
        kzd/Opw6pNfPI6J+FqM8/DZGiRcJV/JhOhjDrdIkYsk4b65/7DN3N0XPZ9/wVEwAKK/Yt2
        4vKGIMqnKdhpVcLyNv1se1hMV2RZpeE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-62-oYajmxhvNxiN5ogUVcPInQ-1; Mon, 28 Feb 2022 18:43:36 -0500
X-MC-Unique: oYajmxhvNxiN5ogUVcPInQ-1
Received: by mail-wm1-f72.google.com with SMTP id c62-20020a1c3541000000b003815245c642so316776wma.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 15:43:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eMk2ddem3feNmKWVGBt5fQ2XD1104DD2sU5e2PuX3nw=;
        b=TJnFKozKLyLBQAPANCPwisRXU1jOySPMqBHTS0Utep1CnCofacNK2QQduUx4TW7ykt
         mitS9GpguLX+nBtzB/PxPybSVvGVrQ3AxMbfZSWJ02Ll5VHWQgJO6YdddZsVPTd+fsMb
         6uMT+Eu/zrFnXAFbAT7zCyYYhe4l4ZT5oOaJuVgptBzZ7q2/bSvGFrnRAN0vR8rhLAn+
         sJUjRqLE8+OOQC/wATjg37ve22zbLzF9xjLLokeHsyt6opo9VVP4lAkYPLSbyRfSPPWG
         FkAC/L0g2MrB0azM6WP+u8OOtDYL20rDd74nkYbDp47yWe3xXTjMKeO1iTSk6XgU1+qV
         OGuQ==
X-Gm-Message-State: AOAM532PIvzUgviqSxAi34+6QrNnkkzEG1KJflQUBqfNBpXAnae3Di5y
        wsglEHmSspiXpCfe/wXShpZcAKyfJorT8cJWzps56jE/LhVLrUla/JQAdkTf1nI3MqgfGfki1Kw
        zBE3NCyedgXpUpU1xrWWVS/g=
X-Received: by 2002:adf:f04f:0:b0:1ef:7e8b:2c34 with SMTP id t15-20020adff04f000000b001ef7e8b2c34mr10816421wro.325.1646091815185;
        Mon, 28 Feb 2022 15:43:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxovzP0OTDqVhVx9LX8HMZz7Ivh55sTaWfDjmfdCuStPKCXTnfhVKYEkcLBy1I1hUo4tcenOg==
X-Received: by 2002:adf:f04f:0:b0:1ef:7e8b:2c34 with SMTP id t15-20020adff04f000000b001ef7e8b2c34mr10816399wro.325.1646091814979;
        Mon, 28 Feb 2022 15:43:34 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id j7-20020adff547000000b001e3241df64bsm11622701wrp.112.2022.02.28.15.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 15:43:34 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu, pmladek@suse.com
Cc:     cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, daniel.thompson@linaro.org
Subject: [PATCH v9 05/14] module: Move latched RB-tree support to a separate file
Date:   Mon, 28 Feb 2022 23:43:13 +0000
Message-Id: <20220228234322.2073104-6-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220228234322.2073104-1-atomlin@redhat.com>
References: <20220228234322.2073104-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

This patch migrates module latched RB-tree support
(e.g. see __module_address()) from core module code
into kernel/module/tree_lookup.c.

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/Makefile      |   1 +
 kernel/module/internal.h    |  33 +++++++++
 kernel/module/main.c        | 130 ++----------------------------------
 kernel/module/tree_lookup.c | 109 ++++++++++++++++++++++++++++++
 4 files changed, 147 insertions(+), 126 deletions(-)
 create mode 100644 kernel/module/tree_lookup.c

diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index ed3aacb04f17..88774e386276 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -11,3 +11,4 @@ obj-y += main.o
 obj-$(CONFIG_MODULE_DECOMPRESS) += decompress.o
 obj-$(CONFIG_MODULE_SIG) += signing.o
 obj-$(CONFIG_LIVEPATCH) += livepatch.o
+obj-$(CONFIG_MODULES_TREE_LOOKUP) += tree_lookup.o
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index ad7a444253ed..f1682e3677be 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -9,6 +9,7 @@
 #include <linux/compiler.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/rculist.h>
 
 #ifndef ARCH_SHF_SMALL
 #define ARCH_SHF_SMALL 0
@@ -93,3 +94,35 @@ static inline void module_decompress_cleanup(struct load_info *info)
 {
 }
 #endif
+
+#ifdef CONFIG_MODULES_TREE_LOOKUP
+struct mod_tree_root {
+	struct latch_tree_root root;
+	unsigned long addr_min;
+	unsigned long addr_max;
+};
+
+extern struct mod_tree_root mod_tree;
+
+void mod_tree_insert(struct module *mod);
+void mod_tree_remove_init(struct module *mod);
+void mod_tree_remove(struct module *mod);
+struct module *mod_find(unsigned long addr);
+#else /* !CONFIG_MODULES_TREE_LOOKUP */
+
+static inline void mod_tree_insert(struct module *mod) { }
+static inline void mod_tree_remove_init(struct module *mod) { }
+static inline void mod_tree_remove(struct module *mod) { }
+static inline struct module *mod_find(unsigned long addr)
+{
+	struct module *mod;
+
+	list_for_each_entry_rcu(mod, &modules, list,
+				lockdep_is_held(&module_mutex)) {
+		if (within_module(addr, mod))
+			return mod;
+	}
+
+	return NULL;
+}
+#endif /* CONFIG_MODULES_TREE_LOOKUP */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 3596ebf3a6c3..76b53880ad91 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -90,138 +90,16 @@ static DECLARE_WORK(init_free_wq, do_free_init);
 static LLIST_HEAD(init_free_list);
 
 #ifdef CONFIG_MODULES_TREE_LOOKUP
-
-/*
- * Use a latched RB-tree for __module_address(); this allows us to use
- * RCU-sched lookups of the address from any context.
- *
- * This is conditional on PERF_EVENTS || TRACING because those can really hit
- * __module_address() hard by doing a lot of stack unwinding; potentially from
- * NMI context.
- */
-
-static __always_inline unsigned long __mod_tree_val(struct latch_tree_node *n)
-{
-	struct module_layout *layout = container_of(n, struct module_layout, mtn.node);
-
-	return (unsigned long)layout->base;
-}
-
-static __always_inline unsigned long __mod_tree_size(struct latch_tree_node *n)
-{
-	struct module_layout *layout = container_of(n, struct module_layout, mtn.node);
-
-	return (unsigned long)layout->size;
-}
-
-static __always_inline bool
-mod_tree_less(struct latch_tree_node *a, struct latch_tree_node *b)
-{
-	return __mod_tree_val(a) < __mod_tree_val(b);
-}
-
-static __always_inline int
-mod_tree_comp(void *key, struct latch_tree_node *n)
-{
-	unsigned long val = (unsigned long)key;
-	unsigned long start, end;
-
-	start = __mod_tree_val(n);
-	if (val < start)
-		return -1;
-
-	end = start + __mod_tree_size(n);
-	if (val >= end)
-		return 1;
-
-	return 0;
-}
-
-static const struct latch_tree_ops mod_tree_ops = {
-	.less = mod_tree_less,
-	.comp = mod_tree_comp,
-};
-
-static struct mod_tree_root {
-	struct latch_tree_root root;
-	unsigned long addr_min;
-	unsigned long addr_max;
-} mod_tree __cacheline_aligned = {
+struct mod_tree_root mod_tree __cacheline_aligned = {
 	.addr_min = -1UL,
 };
 
 #define module_addr_min mod_tree.addr_min
 #define module_addr_max mod_tree.addr_max
 
-static noinline void __mod_tree_insert(struct mod_tree_node *node)
-{
-	latch_tree_insert(&node->node, &mod_tree.root, &mod_tree_ops);
-}
-
-static void __mod_tree_remove(struct mod_tree_node *node)
-{
-	latch_tree_erase(&node->node, &mod_tree.root, &mod_tree_ops);
-}
-
-/*
- * These modifications: insert, remove_init and remove; are serialized by the
- * module_mutex.
- */
-static void mod_tree_insert(struct module *mod)
-{
-	mod->core_layout.mtn.mod = mod;
-	mod->init_layout.mtn.mod = mod;
-
-	__mod_tree_insert(&mod->core_layout.mtn);
-	if (mod->init_layout.size)
-		__mod_tree_insert(&mod->init_layout.mtn);
-}
-
-static void mod_tree_remove_init(struct module *mod)
-{
-	if (mod->init_layout.size)
-		__mod_tree_remove(&mod->init_layout.mtn);
-}
-
-static void mod_tree_remove(struct module *mod)
-{
-	__mod_tree_remove(&mod->core_layout.mtn);
-	mod_tree_remove_init(mod);
-}
-
-static struct module *mod_find(unsigned long addr)
-{
-	struct latch_tree_node *ltn;
-
-	ltn = latch_tree_find((void *)addr, &mod_tree.root, &mod_tree_ops);
-	if (!ltn)
-		return NULL;
-
-	return container_of(ltn, struct mod_tree_node, node)->mod;
-}
-
-#else /* MODULES_TREE_LOOKUP */
-
-static unsigned long module_addr_min = -1UL, module_addr_max = 0;
-
-static void mod_tree_insert(struct module *mod) { }
-static void mod_tree_remove_init(struct module *mod) { }
-static void mod_tree_remove(struct module *mod) { }
-
-static struct module *mod_find(unsigned long addr)
-{
-	struct module *mod;
-
-	list_for_each_entry_rcu(mod, &modules, list,
-				lockdep_is_held(&module_mutex)) {
-		if (within_module(addr, mod))
-			return mod;
-	}
-
-	return NULL;
-}
-
-#endif /* MODULES_TREE_LOOKUP */
+#else /* !CONFIG_MODULES_TREE_LOOKUP */
+static unsigned long module_addr_min = -1UL, module_addr_max;
+#endif /* CONFIG_MODULES_TREE_LOOKUP */
 
 /*
  * Bounds of module text, for speeding up __module_address.
diff --git a/kernel/module/tree_lookup.c b/kernel/module/tree_lookup.c
new file mode 100644
index 000000000000..0bc4ec3b22ce
--- /dev/null
+++ b/kernel/module/tree_lookup.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Modules tree lookup
+ *
+ * Copyright (C) 2015 Peter Zijlstra
+ * Copyright (C) 2015 Rusty Russell
+ */
+
+#include <linux/module.h>
+#include <linux/rbtree_latch.h>
+#include "internal.h"
+
+/*
+ * Use a latched RB-tree for __module_address(); this allows us to use
+ * RCU-sched lookups of the address from any context.
+ *
+ * This is conditional on PERF_EVENTS || TRACING because those can really hit
+ * __module_address() hard by doing a lot of stack unwinding; potentially from
+ * NMI context.
+ */
+
+static __always_inline unsigned long __mod_tree_val(struct latch_tree_node *n)
+{
+	struct module_layout *layout = container_of(n, struct module_layout, mtn.node);
+
+	return (unsigned long)layout->base;
+}
+
+static __always_inline unsigned long __mod_tree_size(struct latch_tree_node *n)
+{
+	struct module_layout *layout = container_of(n, struct module_layout, mtn.node);
+
+	return (unsigned long)layout->size;
+}
+
+static __always_inline bool
+mod_tree_less(struct latch_tree_node *a, struct latch_tree_node *b)
+{
+	return __mod_tree_val(a) < __mod_tree_val(b);
+}
+
+static __always_inline int
+mod_tree_comp(void *key, struct latch_tree_node *n)
+{
+	unsigned long val = (unsigned long)key;
+	unsigned long start, end;
+
+	start = __mod_tree_val(n);
+	if (val < start)
+		return -1;
+
+	end = start + __mod_tree_size(n);
+	if (val >= end)
+		return 1;
+
+	return 0;
+}
+
+static const struct latch_tree_ops mod_tree_ops = {
+	.less = mod_tree_less,
+	.comp = mod_tree_comp,
+};
+
+static noinline void __mod_tree_insert(struct mod_tree_node *node)
+{
+	latch_tree_insert(&node->node, &mod_tree.root, &mod_tree_ops);
+}
+
+static void __mod_tree_remove(struct mod_tree_node *node)
+{
+	latch_tree_erase(&node->node, &mod_tree.root, &mod_tree_ops);
+}
+
+/*
+ * These modifications: insert, remove_init and remove; are serialized by the
+ * module_mutex.
+ */
+void mod_tree_insert(struct module *mod)
+{
+	mod->core_layout.mtn.mod = mod;
+	mod->init_layout.mtn.mod = mod;
+
+	__mod_tree_insert(&mod->core_layout.mtn);
+	if (mod->init_layout.size)
+		__mod_tree_insert(&mod->init_layout.mtn);
+}
+
+void mod_tree_remove_init(struct module *mod)
+{
+	if (mod->init_layout.size)
+		__mod_tree_remove(&mod->init_layout.mtn);
+}
+
+void mod_tree_remove(struct module *mod)
+{
+	__mod_tree_remove(&mod->core_layout.mtn);
+	mod_tree_remove_init(mod);
+}
+
+struct module *mod_find(unsigned long addr)
+{
+	struct latch_tree_node *ltn;
+
+	ltn = latch_tree_find((void *)addr, &mod_tree.root, &mod_tree_ops);
+	if (!ltn)
+		return NULL;
+
+	return container_of(ltn, struct mod_tree_node, node)->mod;
+}
-- 
2.34.1

