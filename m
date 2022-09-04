Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5BE5AC712
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbiIDVm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiIDVmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:42:25 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF3A2F000
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:42:21 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id a9so3885307ilh.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=UryXZ8MRQvm9M8ywPbYKJOd9IzaI7xdASsleEmdDI64=;
        b=muSWjLs7x00fb34NXmJsZan+xUhIQRfkeBRQvGNO6EFtSqDV4gjF1KMkI8Bqak2VBg
         M+SglSeYYC0OIZzXmOEj02FMTLSgdMYfMKEdDLaaJuUeMzg1y8KursXgroBhEJhRXtPE
         ES3Dwgi1AQvCREt4K2pjDPVYOugleYpu5qaUw9tS2HWryERwvYXOQYwsEa82WRrrUjO/
         yp7b0DPlePFOgcmNGO1FDSg1nPI3ICuWkKnZ9YbEBpQ3YvU6cljVk8CuOS4yIAP4Zg5S
         dnOYXunWEY24yxfgLxp+iCfDjBKFKOLqcksfSprGowZrq59RNyZHdmnZQ7ThwtBHf/Qg
         N9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=UryXZ8MRQvm9M8ywPbYKJOd9IzaI7xdASsleEmdDI64=;
        b=tXhDYGDP55SN9Od+/MzWscWb3TvnMqTqlzwa7+/6LhAFXzHD7f0vMzY7dh7VC1LTpF
         wdo/+Xo0PcYFSGKd+6OaD4qHOx6YuQKp+wrl5xj9KqHzLoHM4CE0HVOCpss54EYntoHz
         vV3h1yOvf//e93N0OLp7pt5zTL0cWdIMhk8ws82JOkE1P+sfglSNfXGrFEJAXCTs1nP5
         eSm9i7WyRFQExA0Qntepy2cUBC7dHEmoXJpkOHM8Ftql4iVQGzPij5maMndRASntVlgl
         FMRBvhHeY9qTKdHslBs/atWm+rVWZoO/aU2u0Ib6+KONnRBCCnzDCLa1YBlPyiHmtl9u
         9dyQ==
X-Gm-Message-State: ACgBeo0Yj1XGtKTeSf8ggw2oYD4pvw4Z/GPj3ul35eTk9wEiAUmv/OeL
        2SuAX4yKe1usoOvzn5OLJUw=
X-Google-Smtp-Source: AA6agR4xCBLCNJuB54OnGN7VtAxvyEt+vNDQxb7qX+QcTnPDx6k921Txd/smbqxpe7ugLH91cljdjg==
X-Received: by 2002:a05:6e02:15c4:b0:2e1:986c:91a1 with SMTP id q4-20020a056e0215c400b002e1986c91a1mr24412890ilu.22.1662327740646;
        Sun, 04 Sep 2022 14:42:20 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:42:20 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v6 11/57] dyndbg: gather __dyndbg[] state into struct _ddebug_info
Date:   Sun,  4 Sep 2022 15:40:48 -0600
Message-Id: <20220904214134.408619-12-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220904214134.408619-1-jim.cromie@gmail.com>
References: <20220904214134.408619-1-jim.cromie@gmail.com>
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

This new struct composes the linker provided (vector,len) section,
and provides a place to add other __dyndbg[] state-data later:

  descs - the vector of descriptors in __dyndbg section.
  num_descs - length of the data/section.

Use it, in several different ways, as follows:

In lib/dynamic_debug.c:

ddebug_add_module(): Alter params-list, replacing 2 args (array,index)
with a struct _ddebug_info * containing them both, with room for
expansion.  This helps future-proof the function prototype against the
looming addition of class-map info into the dyndbg-state, by providing
a place to add more member fields later.

NB: later add static struct _ddebug_info builtins_state declaration,
not needed yet.

ddebug_add_module() is called in 2 contexts:

In dynamic_debug_init(), declare, init a struct _ddebug_info di
auto-var to use as a cursor.  Then iterate over the prdbg blocks of
the builtin modules, and update the di cursor before calling
_add_module for each.

Its called from kernel/module/main.c:load_info() for each loaded
module:

In internal.h, alter struct load_info, replacing the dyndbg array,len
fields with an embedded _ddebug_info containing them both; and
populate its members in find_module_sections().

The 2 calling contexts differ in that _init deals with contiguous
subranges of __dyndbgs[] section, packed together, while loadable
modules are added one at a time.

So rename ddebug_add_module() into outer/__inner fns, call __inner
from _init, and provide the offset into the builtin __dyndbgs[] where
the module's prdbgs reside.  The cursor provides start, len of the
subrange for each.  The offset will be used later to pack the results
of builtin __dyndbg_sites[] de-duplication, and is 0 and unneeded for
loadable modules,

Note:

kernel/module/main.c includes <dynamic_debug.h> for struct
_ddeubg_info.  This might be prone to include loops, since its also
included by printk.h.  Nothing has broken in robot-land on this.

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
index 680d980a4fb2..2e2bf236f558 100644
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
index a4e4d84b6f4e..4c20bc3ff203 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1598,16 +1598,16 @@ static void free_modinfo(struct module *mod)
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
 
@@ -2111,8 +2111,8 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 	if (section_addr(info, "__obsparm"))
 		pr_warn("%s: Ignoring obsolete parameters\n", mod->name);
 
-	info->debug = section_objs(info, "__dyndbg",
-				   sizeof(*info->debug), &info->num_debug);
+	info->dyndbg.descs = section_objs(info, "__dyndbg",
+					sizeof(*info->dyndbg.descs), &info->dyndbg.num_descs);
 
 	return 0;
 }
@@ -2807,7 +2807,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	}
 
 	init_build_id(mod, info);
-	dynamic_debug_setup(mod, info->debug, info->num_debug);
+	dynamic_debug_setup(mod, &info->dyndbg);
 
 	/* Ftrace init must be called in the MODULE_STATE_UNFORMED state */
 	ftrace_module_init(mod);
@@ -2871,7 +2871,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 
  ddebug_cleanup:
 	ftrace_release_mod(mod);
-	dynamic_debug_remove(mod, info->debug);
+	dynamic_debug_remove(mod, &info->dyndbg);
 	synchronize_rcu();
 	kfree(mod->args);
  free_arch_cleanup:
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 2e8ebef3bd0d..c358ccdf4a39 100644
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
+			ret = __ddebug_add_module(&di, i - mod_sites, modname);
 			if (ret)
 				goto out_err;
 
@@ -1091,7 +1111,9 @@ static int __init dynamic_debug_init(void)
 			iter_mod_start = iter;
 		}
 	}
-	ret = ddebug_add_module(iter_mod_start, mod_sites, modname);
+	di.num_descs = mod_sites;
+	di.descs = iter_mod_start;
+	ret = __ddebug_add_module(&di, i - mod_sites, modname);
 	if (ret)
 		goto out_err;
 
-- 
2.37.2

