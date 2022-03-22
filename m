Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A994E4021
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 15:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbiCVOFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 10:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbiCVOFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:05:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59A2130F4E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 07:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647957843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eMk2ddem3feNmKWVGBt5fQ2XD1104DD2sU5e2PuX3nw=;
        b=gXcJnfF/ZLzQ39lP94qsvjDKnrZ/U27m3+lwM8lH/RySjwP2rWAikpJnfUGz1Ms2aY6ZRh
        X+R5N447nreJknvTA5AnTZ0/iXSEwJ/jN/vMEWK+nElGdaF8NYQCNFFpVVqrhrbX/sT/4H
        /kNSUrjP5dempAyidfyB9WF/v6JWsJI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-499-b52uBvrqNqKL_GmUCzLsMw-1; Tue, 22 Mar 2022 10:04:02 -0400
X-MC-Unique: b52uBvrqNqKL_GmUCzLsMw-1
Received: by mail-wm1-f71.google.com with SMTP id 4-20020a05600c274400b0038c8ab2e835so979370wmw.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 07:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eMk2ddem3feNmKWVGBt5fQ2XD1104DD2sU5e2PuX3nw=;
        b=CouU0iBUbmnxTKtvdQ72ib/Zhh8ApDf5W3ivJXyAr+SXu1QoFTOVzdU/MESaoVccpU
         NT4R7drMCPOy5oHXoTANKAbeHykTDScuqs+q66vD0WWrPnciE+541fytN7bMYvw1PaUz
         thfpTxGzaFgVYx//wvhT1zvjdOs17VeHIiGc219E1ZIdfvpYX3sdAUjDgOGho6vQ7+dc
         cLXmXapn8AOX+nKpyjKcWyAOQMF2/rsNJ93cRefsYp8JPutM4i96jnfvDsJGzhMN939B
         4o13bZ2iLy2bVYRojEFB1IXiJ9VZGuJ2aqRG+gNJnzmICJeVlTqBiKTuny3EWXo6f5Rc
         qw4w==
X-Gm-Message-State: AOAM530Nlc63UAARqDrnu7JJg3u4l1NflqofDdueakabuyOHJyIyyU8A
        spqKfWFVkQUq53W54dsG6gV7piefPdBfdDFBugIgM4Az3zQ3jKd73QLOys5cKMs7n8EkcEMmcOm
        /yEM0N3W2pLx2ze3OtdpFFVU=
X-Received: by 2002:a05:600c:1d88:b0:38c:b121:c669 with SMTP id p8-20020a05600c1d8800b0038cb121c669mr4017593wms.150.1647957840802;
        Tue, 22 Mar 2022 07:04:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYDZtrq0KcgZFb1BRa+nmOiOaQKdbnDdqNAZJcf28mdBOAC6p4vwEljA8GHu5OfZuzxILyLA==
X-Received: by 2002:a05:600c:1d88:b0:38c:b121:c669 with SMTP id p8-20020a05600c1d8800b0038cb121c669mr4017559wms.150.1647957840501;
        Tue, 22 Mar 2022 07:04:00 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id n65-20020a1c2744000000b003862bfb509bsm2102403wmn.46.2022.03.22.07.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 07:03:59 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com,
        daniel.thompson@linaro.org, hch@infradead.org
Subject: [PATCH v12 05/14] module: Move latched RB-tree support to a separate file
Date:   Tue, 22 Mar 2022 14:03:35 +0000
Message-Id: <20220322140344.556474-6-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220322140344.556474-1-atomlin@redhat.com>
References: <20220322140344.556474-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

