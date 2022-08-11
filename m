Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B980E5905F0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbiHKRgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234961AbiHKRgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:36:10 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F016A6CF54
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 10:36:05 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id z145so15181621iof.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 10:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Gia1w3Dp2zEfxEzad+9CAcTqHJ7ru207Rscme2dIBl8=;
        b=pMCdqrocfucaYbsa3wxbODeRLJ84EYnW/5POItGcPE6gY1ai2AFKTHKCghSKmOY3B4
         cB9sSWYGkuMrTklGUiGXFJSKtupGmyUPwy/Eh50qY0KtSzqQ97xIDXInZeeqAT9WQgvb
         sV9+twxAzD8X+nR8QPxlSobEzUrBP1UxBwGVUyKh2hrW7noXsjpOJhgI2hDxKKi71p/t
         fXmijkXwkg+oQWF/KcQQg2OBLpeKsxDo6mLAPm9dYGOWfP0bvWdIEWhrm8Ckx5gm0FeY
         Yx6h0RBpcRf5lDOMVx/4gBij7OyD89Pntc22gW96T4OUT6YwoAfN63yhtuBlFosOVUS0
         B/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Gia1w3Dp2zEfxEzad+9CAcTqHJ7ru207Rscme2dIBl8=;
        b=mYWUdj6/yVLHtSomAks2Dya+YFYcMQH9ielUSJvls6exP7CT2oaMJypSXAHFrTOX9g
         /elveb4hqqnS4b5JPyRi2zdPIpglAnSH5qH6Da/C1JgY2+8k7+woDNxnwv2AlBT1cwIE
         PtWLpeyTjwNzKrqNQJ+unOYK5ZnCIJydVDCwUvEwrMqKepJWLmJueCyHiGFVmH2wo8gz
         fqIzKv80GCHWbrDPUA9NmVaoHwWPH9GSnAtx2onuDy7Dfavb8jYDJGHLDZ5s9FcHg9NO
         qSLOcUZoPerLNznCW3jnMFbEub5dd9aknXZSF5/vNI+/lODo0apYnl0cQAQ9DG2zGc44
         +Q6w==
X-Gm-Message-State: ACgBeo2phFXMJeOJk51VGWohGcmTYY7eoxtxlfU6JLRnw7kS0RWqr+Hr
        02GWtPXU5UaavVf/rqS7ZxcZlL+kouU=
X-Google-Smtp-Source: AA6agR6tqK6PXU5XsVDUpp/9pOm2Xg9ZowN7LFolM7AqpKB64mRege6gD2/RXYjrt0QrD0dplHQ/8A==
X-Received: by 2002:a05:6638:1496:b0:342:873b:a07c with SMTP id j22-20020a056638149600b00342873ba07cmr187696jak.236.1660239364646;
        Thu, 11 Aug 2022 10:36:04 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id n9-20020a056638110900b003435e8635bbsm27928jal.77.2022.08.11.10.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 10:36:04 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jbaron@akamai.com
Cc:     Jim Cromie <jim.cromie@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 11/11] dyndbg: create and use struct _ddebug_info
Date:   Thu, 11 Aug 2022 11:35:41 -0600
Message-Id: <20220811173541.2901122-12-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220811173541.2901122-1-jim.cromie@gmail.com>
References: <20220811173541.2901122-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this new struct gathers the linker provided vectors/sections:

  descs - the vector of descriptors in __dyndbg section.
  num_descs - length of the data/section

Use it as follows:

In lib/dynamic_debug.c:

Alter ddebug_add_module() params-list, replacing descriptor-table and
its length with a single _ddebug_info object containing them.  This
future-proofs the function against the looming addition of class-map
info, for either the builtin module set, or the loaded module.

In dynamic_debug_init(): add & initialize an auto struct _ddebug_info
var, and use it like a cursor / multi-part iterator.  Re-initialize
the var's component values before each call to ddebug_add_module().
This gives us an explicit by-module walk thru the built-in __dyndbgs
data section.

In kernel/module/{main.c,internal.h}:

Embed a struct _ddebug_info into struct load_info, replacing the 2 fields it
contains.  Populate its members in find_module_sections.

Also adjust dynamic_debug_setup/remove() to match the change to
ddebug_add_module().

Note: this adds an include dynamic_debug, and might be prone to
include loops, since its also smuggled in by printk.h.  Nothing has
puked in robot-land.

cc: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 13 +++++++-----
 kernel/module/internal.h      |  4 ++--
 kernel/module/main.c          | 18 ++++++++--------
 lib/dynamic_debug.c           | 40 +++++++++++++++++++++++++++--------
 4 files changed, 50 insertions(+), 25 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 8d9eec5f6d8b..6a2001250da1 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -51,12 +51,16 @@ struct _ddebug {
 #endif
 } __attribute__((aligned(8)));
 
-
+/* encapsulate linker provided built-in (or module) dyndbg data */
+struct _ddebug_info {
+	struct _ddebug *descs;
+	unsigned int num_descs;
+};
 
 #if defined(CONFIG_DYNAMIC_DEBUG_CORE)
 
-int ddebug_add_module(struct _ddebug *tab, unsigned int n,
-				const char *modname);
+int ddebug_add_module(struct _ddebug_info *dyndbg, const char *modname);
+
 extern int ddebug_remove_module(const char *mod_name);
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);
@@ -184,8 +188,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 #include <linux/errno.h>
 #include <linux/printk.h>
 
-static inline int ddebug_add_module(struct _ddebug *tab, unsigned int n,
-				    const char *modname)
+static inline int ddebug_add_module(struct _ddebug_info *dinfo, const char *modname)
 {
 	return 0;
 }
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index ec104c2950c3..ce42b5b8b4da 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -53,6 +53,7 @@ extern const struct kernel_symbol __stop___ksymtab_gpl[];
 extern const s32 __start___kcrctab[];
 extern const s32 __start___kcrctab_gpl[];
 
+#include <linux/dynamic_debug.h>
 struct load_info {
 	const char *name;
 	/* pointer to module in temporary copy, freed at end of load_module() */
@@ -62,8 +63,7 @@ struct load_info {
 	Elf_Shdr *sechdrs;
 	char *secstrings, *strtab;
 	unsigned long symoffs, stroffs, init_typeoffs, core_typeoffs;
-	struct _ddebug *debug;
-	unsigned int num_debug;
+	struct _ddebug_info dyndbg;
 	bool sig_ok;
 #ifdef CONFIG_KALLSYMS
 	unsigned long mod_kallsyms_init_off;
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 0548151dd933..cfe10356793d 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1593,16 +1593,16 @@ static void free_modinfo(struct module *mod)
 	}
 }
 
-static void dynamic_debug_setup(struct module *mod, struct _ddebug *debug, unsigned int num)
+static void dynamic_debug_setup(struct module *mod, struct _ddebug_info *dyndbg)
 {
-	if (!debug)
+	if (!dyndbg->num_descs)
 		return;
-	ddebug_add_module(debug, num, mod->name);
+	ddebug_add_module(dyndbg, mod->name);
 }
 
-static void dynamic_debug_remove(struct module *mod, struct _ddebug *debug)
+static void dynamic_debug_remove(struct module *mod, struct _ddebug_info *dyndbg)
 {
-	if (debug)
+	if (dyndbg->num_descs)
 		ddebug_remove_module(mod->name);
 }
 
@@ -2093,8 +2093,8 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 	if (section_addr(info, "__obsparm"))
 		pr_warn("%s: Ignoring obsolete parameters\n", mod->name);
 
-	info->debug = section_objs(info, "__dyndbg",
-				   sizeof(*info->debug), &info->num_debug);
+	info->dyndbg.descs = section_objs(info, "__dyndbg",
+					sizeof(*info->dyndbg.descs), &info->dyndbg.num_descs);
 
 	return 0;
 }
@@ -2783,7 +2783,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	}
 
 	init_build_id(mod, info);
-	dynamic_debug_setup(mod, info->debug, info->num_debug);
+	dynamic_debug_setup(mod, &info->dyndbg);
 
 	/* Ftrace init must be called in the MODULE_STATE_UNFORMED state */
 	ftrace_module_init(mod);
@@ -2845,7 +2845,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 
  ddebug_cleanup:
 	ftrace_release_mod(mod);
-	dynamic_debug_remove(mod, info->debug);
+	dynamic_debug_remove(mod, &info->dyndbg);
 	synchronize_rcu();
 	kfree(mod->args);
  free_arch_cleanup:
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 2e8ebef3bd0d..457ce936191a 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -923,14 +923,20 @@ static const struct proc_ops proc_fops = {
  * Allocate a new ddebug_table for the given module
  * and add it to the global list.
  */
-int ddebug_add_module(struct _ddebug *tab, unsigned int n,
-			     const char *name)
+static int __ddebug_add_module(struct _ddebug_info *di, unsigned int base,
+			       const char *modname)
 {
 	struct ddebug_table *dt;
 
+	v3pr_info("add-module: %s.%d sites\n", modname, di->num_descs);
+	if (!di->num_descs) {
+		v3pr_info(" skip %s\n", modname);
+		return 0;
+	}
+
 	dt = kzalloc(sizeof(*dt), GFP_KERNEL);
 	if (dt == NULL) {
-		pr_err("error adding module: %s\n", name);
+		pr_err("error adding module: %s\n", modname);
 		return -ENOMEM;
 	}
 	/*
@@ -939,18 +945,25 @@ int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 	 * member of struct module, which lives at least as long as
 	 * this struct ddebug_table.
 	 */
-	dt->mod_name = name;
-	dt->num_ddebugs = n;
-	dt->ddebugs = tab;
+	dt->mod_name = modname;
+	dt->ddebugs = di->descs;
+	dt->num_ddebugs = di->num_descs;
+
+	INIT_LIST_HEAD(&dt->link);
 
 	mutex_lock(&ddebug_lock);
 	list_add_tail(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
 
-	vpr_info("%3u debug prints in module %s\n", n, dt->mod_name);
+	vpr_info("%3u debug prints in module %s\n", di->num_descs, modname);
 	return 0;
 }
 
+int ddebug_add_module(struct _ddebug_info *di, const char *modname)
+{
+	return __ddebug_add_module(di, 0, modname);
+}
+
 /* helper for ddebug_dyndbg_(boot|module)_param_cb */
 static int ddebug_dyndbg_param_cb(char *param, char *val,
 				const char *modname, int on_err)
@@ -1064,6 +1077,11 @@ static int __init dynamic_debug_init(void)
 	const char *modname;
 	char *cmdline;
 
+	struct _ddebug_info di = {
+		.descs = __start___dyndbg,
+		.num_descs = __stop___dyndbg - __start___dyndbg,
+	};
+
 	if (&__start___dyndbg == &__stop___dyndbg) {
 		if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG)) {
 			pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
@@ -1082,7 +1100,9 @@ static int __init dynamic_debug_init(void)
 
 		if (strcmp(modname, iter->modname)) {
 			mod_ct++;
-			ret = ddebug_add_module(iter_mod_start, mod_sites, modname);
+			di.num_descs = mod_sites;
+			di.descs = iter_mod_start;
+			ret = __ddebug_add_module(&di, i, modname);
 			if (ret)
 				goto out_err;
 
@@ -1091,7 +1111,9 @@ static int __init dynamic_debug_init(void)
 			iter_mod_start = iter;
 		}
 	}
-	ret = ddebug_add_module(iter_mod_start, mod_sites, modname);
+	di.num_descs = mod_sites;
+	di.descs = iter_mod_start;
+	ret = __ddebug_add_module(&di, i, modname);
 	if (ret)
 		goto out_err;
 
-- 
2.37.1

