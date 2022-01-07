Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F81A486DF3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 00:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343586AbiAFXnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 18:43:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37975 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245650AbiAFXn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 18:43:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641512607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qglGEuGp2EruX7zdhZlheeGYqPXPPaBDozoY2l4KtaY=;
        b=fRiXBdERw+yOpbiXjs0rDuYzJho8PVq//r1xlZxSgdPkLdzV3tJwFeDd8LlAcF//lp2Wxn
        5lOPEwbL7/2A5uJdF7Ha6vQZxMEMZ7VMBUi+AWMnYzKxz7cQhBhsFrbwkI0jcrhofepAVD
        2yETidL649csGFpwTyAPRZrO+jcy+Zg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-154-JJePATjMNeCysBN-ICrUxQ-1; Thu, 06 Jan 2022 18:43:26 -0500
X-MC-Unique: JJePATjMNeCysBN-ICrUxQ-1
Received: by mail-wm1-f72.google.com with SMTP id r2-20020a05600c35c200b00345c3b82b22so3752576wmq.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 15:43:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qglGEuGp2EruX7zdhZlheeGYqPXPPaBDozoY2l4KtaY=;
        b=zeii3xOmaCNk9AdDMW3AGQ2mgerOyjpw5SRJ3IkQD8yih74r/t8TpTlK+x07MwHLrt
         V8CbIFD5BhAie/Dsh7iEJKH52PQbrNn89evdCy2auXWne0/hpVwQl2LblsVBiH0XcHjV
         jKZ/V+UIdJKR3z32+3DrF36t5L8CzOb43iKQdxGclrPuSo+IwnQIqyTaXZdt1SHk8oHh
         73CfHM0JU+DTGDymjLuPsWYrIqEqgb7sb08e9mQBhmnjSdkTZbKlJmAr+tHgWWEwr8Hj
         LxwOT2QeX6915YpalUY8sP4rXiX1yoOT8XVuTlFLC5zwy5O2GnOA19h3yJHCXCFkFvzk
         z8nQ==
X-Gm-Message-State: AOAM5315/S8oXzxQYRBVBy4/xtsrsVriO2NAIaB0VEYdXuGRhFWF7ty3
        f8Y8ve9FTDZloQQBjS3F9Nl6ePUdrl14dETpY8e1rPp2QeXTS+rk9cVDfSVOJ3Jty/mXoXd2OPz
        Ol9A8hCmwsGFVAzNzkdYGXe0=
X-Received: by 2002:adf:97c2:: with SMTP id t2mr53067736wrb.577.1641512605074;
        Thu, 06 Jan 2022 15:43:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyb4oj3wkF4oYx2ADU9VzoIl9Qb8/mw1vDsbyho4Q3Ydy8hAL89v7A4cJPZMaqSI9XWPWKfkQ==
X-Received: by 2002:adf:97c2:: with SMTP id t2mr53067728wrb.577.1641512604823;
        Thu, 06 Jan 2022 15:43:24 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id r1sm3695775wrz.30.2022.01.06.15.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 15:43:24 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, allen.lkml@gmail.com
Subject: [RFC PATCH v2 04/13] module: Move latched RB-tree support to a separate file
Date:   Thu,  6 Jan 2022 23:43:10 +0000
Message-Id: <20220106234319.2067842-5-atomlin@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220106234319.2067842-1-atomlin@redhat.com>
References: <20220106234319.2067842-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

This patch migrates module latched RB-tree support
(e.g. see __module_address()) from core module code
into kernel/module/tree_lookup.c.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 include/linux/module.h      |  37 +++++++++-
 kernel/module/Makefile      |   1 +
 kernel/module/main.c        | 134 ------------------------------------
 kernel/module/tree_lookup.c | 108 +++++++++++++++++++++++++++++
 4 files changed, 144 insertions(+), 136 deletions(-)
 create mode 100644 kernel/module/tree_lookup.c

diff --git a/include/linux/module.h b/include/linux/module.h
index 8a298d820dbc..8b4d254a84c0 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -339,11 +339,44 @@ struct module_layout {
 };
 
 #ifdef CONFIG_MODULES_TREE_LOOKUP
+struct mod_tree_root {
+	struct latch_tree_root root;
+	unsigned long addr_min;
+	unsigned long addr_max;
+} mod_tree __cacheline_aligned = {
+	.addr_min = -1UL,
+};
+
+#define module_addr_min mod_tree.addr_min
+#define module_addr_max mod_tree.addr_max
+
+extern void mod_tree_insert(struct module *mod);
+extern void mod_tree_remove_init(struct module *mod);
+extern void mod_tree_remove(struct module *mod);
+extern struct module *mod_find(unsigned long addr);
 /* Only touch one cacheline for common rbtree-for-core-layout case. */
 #define __module_layout_align ____cacheline_aligned
-#else
+#else /* !CONFIG_MODULES_TREE_LOOKUP */
+
+static unsigned long module_addr_min = -1UL, module_addr_max = 0;
+
+static void mod_tree_insert(struct module *mod) { }
+static void mod_tree_remove_init(struct module *mod) { }
+static void mod_tree_remove(struct module *mod) { }
+static struct module *mod_find(unsigned long addr)
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
 #define __module_layout_align
-#endif
+#endif /* CONFIG_MODULES_TREE_LOOKUP */
 
 struct mod_kallsyms {
 	Elf_Sym *symtab;
diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index 47d70bb18da3..9d593362156d 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_MODULES) += main.o
 obj-$(CONFIG_MODULE_SIG) += signing.o
 obj-$(CONFIG_MODULE_SIG_FORMAT) += signature.o
 obj-$(CONFIG_LIVEPATCH) += livepatch.o
+obj-$(CONFIG_MODULES_TREE_LOOKUP) += tree_lookup.o
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 9bcaf251e109..692cc520420d 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -89,140 +89,6 @@ static void do_free_init(struct work_struct *w);
 static DECLARE_WORK(init_free_wq, do_free_init);
 static LLIST_HEAD(init_free_list);
 
-#ifdef CONFIG_MODULES_TREE_LOOKUP
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
-	.addr_min = -1UL,
-};
-
-#define module_addr_min mod_tree.addr_min
-#define module_addr_max mod_tree.addr_max
-
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
-
 /*
  * Bounds of module text, for speeding up __module_address.
  * Protected by module_mutex.
diff --git a/kernel/module/tree_lookup.c b/kernel/module/tree_lookup.c
new file mode 100644
index 000000000000..7703687c6e2e
--- /dev/null
+++ b/kernel/module/tree_lookup.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * kernel/module/tree_lookup.c - modules tree lookup
+ *
+ * Copyright (C) 2015 Peter Zijlstra
+ * Copyright (C) 2015 Rusty Russell
+ */
+
+#include <linux/module.h>
+#include <linux/rbtree_latch.h>
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
+__always_inline unsigned long __mod_tree_val(struct latch_tree_node *n)
+{
+	struct module_layout *layout = container_of(n, struct module_layout, mtn.node);
+
+	return (unsigned long)layout->base;
+}
+
+__always_inline unsigned long __mod_tree_size(struct latch_tree_node *n)
+{
+	struct module_layout *layout = container_of(n, struct module_layout, mtn.node);
+
+	return (unsigned long)layout->size;
+}
+
+__always_inline bool
+mod_tree_less(struct latch_tree_node *a, struct latch_tree_node *b)
+{
+	return __mod_tree_val(a) < __mod_tree_val(b);
+}
+
+__always_inline int
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
+const struct latch_tree_ops mod_tree_ops = {
+	.less = mod_tree_less,
+	.comp = mod_tree_comp,
+};
+
+noinline void __mod_tree_insert(struct mod_tree_node *node)
+{
+	latch_tree_insert(&node->node, &mod_tree.root, &mod_tree_ops);
+}
+
+void __mod_tree_remove(struct mod_tree_node *node)
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
2.31.1

