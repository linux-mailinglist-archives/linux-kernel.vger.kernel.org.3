Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F635AC72D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbiIDVpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbiIDVoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:44:22 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043E9303E2
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:42:49 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id h78so5628555iof.13
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=PMiB8rnsUQPju8onoOnVuDb8slfA1llOhn686i4QNvM=;
        b=DhIMTIMuvABAe+Hzd9rSSdXTPFxO/+q5Cm+yD63nUFOoFZNB03XM5qcqbF65z2kAOS
         pOUh728z1/u5qw1UKGnSRJFv2eNFfmUNZA9Pr33CoridKkhzO3KHRwUivKPaXWPPvzes
         FIn2lGCuNdFOJuALDBDiHixeO3RwF3TScUe2Ec35/WnTE4/rWPnUBReM+TT+MGZi7UiP
         8A62RK0snL+KInTqxx0ss+pLhLEPD3uKBa3QC0t9/c7eRXT2KH3ogGVGBr2JOf5Y5Y/C
         0o98zKU/C2FCWYR/3SSsXNl5sS/BSOlPYUBKDAmomW9+bzVniS+aWFgMzIAaLAguaPjr
         OsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=PMiB8rnsUQPju8onoOnVuDb8slfA1llOhn686i4QNvM=;
        b=m20xHcPVMP2LtqP5uqeHDyMCk59i1+XcN1UR193jmtrCqrXtR2WUU2jeVk4c27QDGd
         SlE5IiCVHgAr7scW+qc2wVB6aYxlGsGtyNDyXG11c6f37g1B7usQzWG9HjZUm4aQ0boF
         9bX043U8r+CrtldKKchHnCa3HhgQQHWF/6eQzEpASAHTb74NNJKX4HbPQj+aoeGJsnWP
         Pj/X8f1iM8xs/EE0OM3QQE7nXkTrMuG4SAHdnKxEVVk3fnfwJSt81VjkRjLGWoFqz3Uo
         365pXojinNLke/kmHzbkSg/foYG+5O4xx5myr3fdbMdRKDBV6TdTukh1OTTulqvx2G9n
         YOqw==
X-Gm-Message-State: ACgBeo0lLUn/kY0zN4IyFU/cSwoDHz1DV0Jx7rwEc3u/fqwAzq00NxrL
        xW1shZlQzGFvIMTAJnHADU4=
X-Google-Smtp-Source: AA6agR6INbA193jAVbdMDiyXOsWP4jHkkUZzNXaQ1TrC3Xmxtj8ovg2eyPEHbVIhKzd3D9P88Hc01A==
X-Received: by 2002:a6b:7b41:0:b0:689:2648:9ce9 with SMTP id m1-20020a6b7b41000000b0068926489ce9mr21451384iop.185.1662327769373;
        Sun, 04 Sep 2022 14:42:49 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:42:49 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 41/57] dyndbg: split repeating columns to new struct _ddebug_site
Date:   Sun,  4 Sep 2022 15:41:18 -0600
Message-Id: <20220904214134.408619-42-jim.cromie@gmail.com>
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

Struct _ddebug has 3 RO-data fields: _module, _file, _function, which
have significant repetition in the builtins: 4222 unique records /
8920 callsites on a recent laptop build.  Thats just 47% unique, on
24/56 of the unitary record.

The quick path to excising this redundancy is:
 1- split the table in 2, link 1st to 2nd	(done here)
 2- de-duplicate the 2nd table.			(soon)

So split struct _ddebug, move the 3 fields to a new struct
_ddebug_site, and add a pointer from _ddebug to _debug_sites.  The
lineno field stays in _ddebug, so all _sites in a fn are identical.

The new ptr from _ddebug -> _ddebug_site increases memory footprint,
until step 2 is completed, at which point:

  old = 56	  * 8920
  new = (56-24+8) * 8920 + 24 * 4222
IE:
  DB<2> p 56 * 8920
499520
  DB<3> p 40*8920 + 24 * 4222
458128

Thats 41392 saved, or ~8.3%

Further, the site pointer is just temporary scaffolding:

 - descriptors are in a vector.
 - new desc._idx field (from spare bits) can get us to 0.
   set during _init, not by linker
 - add a header record in front of vector (.gnu.linkonce.dyndbg*)
   point it up to struct dyndbg_info
 - dyndbg_info has .sites
 - same desc._idx gets us sites[._idx]
 - new desc._map field, gives sites[._map]
   this allows de-duplication and packing.

Once that is done, the savings increases:

  DB<7> p  (56 * 8920) - (((56-24) *8920) + 24*4222)
  112752 saved, or 22%

STEP 1:

dynamic_debug.h:

This cuts struct _ddebug in half, renames the top-half to
_ddebug_site, keeps __align(8) for both halves.  Adds a forward decl
for a unified comment for both halves, and added _ddebug.site field to
point at a site record.

Rework DEFINE_DYNAMIC_DEBUG_METADATA_CLS macro to declare & initialize
the 2 static/private struct vars together, and link them together.  It
places each struct into its own section, so the linker packs 2
parallel arrays, and links them like a ladder.

struct _ddebug_info is extended to track _ddebug_site[] just like it
does for _ddebug[] and _ddebug_classes[].

The accessor macros desc_{module,filename,function} follow the
field-moves with added '->site->' references, and return "_nope_" or
"_na_" if the desc or site are null.  This makes those ptrs nullable,
and their referents recoverable (nothing tries to use this yet).
NB: the "_na_" is undone temporarily later, for dev shortcut.

Also add const to lineno field.  It is set by compiler.

In struct ddebug_table, add struct _ddebug_site *sites, to treat new
vector just like the module's _ddebug[]s (its __dyndbg section, for
loadable mods).  While we don't need it now, we will need it to
de-scaffold (drop the _ddebug.site).

dynamic_debug.c:

extern declarations of the section start/end symbols named and
initialized in vmlinux.lds.h

dynamic_debug_init():

Initialize global builtin_state from initialized cursor var.  Trying
to do so statically gave:
   "error: initializer element is not computable at load time"

Check (num-descs == num-sites), and quit early otherwise.  This is an
important precondition, w/o it, we cannot really continue confidently.

I inadvertently created the situation by having __used on 1/2 of the
_ddebug{,_site} pair created by DECLARE_DYNAMIC_DEBUG_METADATA; this
created ~70/ extra site records.  This "worked", but was unnerving
until I tracked it down.

Add site iterator & site_mod_start marker, recapping iter/_mod_start.

Inside the main loop, validate (site == iter->site).  This is the
full/proper precondition for the expected section contents and
inter-linkage; the (num-descs == num-sites) check is just a quick
necessary-but-not-sufficient version of this.

NOTE: this check could be a BUG_ON, esp as any mismatch should have
been caught by the quick-check.  ATM it is just a pr_err; Id prefer to
see errors rather than crashes.

Demotes iter->site by replacing iter->site->_module by site->_module.
This is a small step towards dropping it entirely.

vmlinux.lds.h:

add __dyndbg_sites section and start/end symbols, with the same
align(8) and KEEP as used in the __dyndbg section.

kernel/module/main.c:load_info():

Initialize _ddebug_info.sites with new section address.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/vmlinux.lds.h |  3 +++
 include/linux/dynamic_debug.h     | 37 +++++++++++++++++++++---------
 kernel/module/main.c              |  2 ++
 lib/dynamic_debug.c               | 38 +++++++++++++++++++++++--------
 4 files changed, 60 insertions(+), 20 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 9b8bd5504ad9..1e7ee65e8591 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -351,6 +351,9 @@
 	__start___dyndbg = .;						\
 	KEEP(*(__dyndbg))						\
 	__stop___dyndbg = .;						\
+	__start___dyndbg_sites = .;					\
+	KEEP(*(__dyndbg_sites))						\
+	__stop___dyndbg_sites = .;					\
 	LIKELY_PROFILE()		       				\
 	BRANCH_PROFILE()						\
 	TRACE_PRINTKS()							\
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index e04f5b0a31e2..dcc0e8cc2ef0 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -9,20 +9,28 @@
 #include <linux/build_bug.h>
 
 /*
- * An instance of this structure is created in a special
- * ELF section at every dynamic debug callsite.  At runtime,
- * the special section is treated as an array of these.
+ * A pair of these structs are created in 2 special ELF sections
+ * (__dyndbg, __dyndbg_sites) for every dynamic debug callsite.
+ * At runtime, the sections are treated as arrays.
  */
-struct _ddebug {
+struct _ddebug;
+struct _ddebug_site {
 	/*
-	 * These fields are used to drive the user interface
-	 * for selecting and displaying debug callsites.
+	 * These fields (and lineno) are used to:
+	 * - decorate log messages per _ddebug.flags
+	 * - select callsites for modification via >control
+	 * - display callsites & settings in `cat control`
 	 */
 	const char *_modname;
 	const char *_function;
 	const char *_filename;
+} __aligned(8);
+
+struct _ddebug {
+	struct _ddebug_site *site;
+	/* format is always needed, lineno shares word with flags */
 	const char *format;
-	unsigned int lineno:18;
+	const unsigned lineno:18;
 #define CLS_BITS 6
 	unsigned int class_id:CLS_BITS;
 #define _DPRINTK_CLASS_DFLT		((1 << CLS_BITS) - 1)
@@ -58,7 +66,7 @@ struct _ddebug {
 		struct static_key_false dd_key_false;
 	} key;
 #endif
-} __attribute__((aligned(8)));
+} __aligned(8);
 
 enum class_map_type {
 	DD_CLASS_TYPE_DISJOINT_BITS,
@@ -118,8 +126,10 @@ struct ddebug_class_map {
 /* encapsulate linker provided built-in (or module) dyndbg data */
 struct _ddebug_info {
 	struct _ddebug *descs;
+	struct _ddebug_site *sites;
 	struct ddebug_class_map *classes;
 	unsigned int num_descs;
+	unsigned int num_sites;
 	unsigned int num_classes;
 };
 
@@ -137,6 +147,7 @@ struct ddebug_class_param {
 int ddebug_add_module(struct _ddebug_info *dyndbg, const char *modname);
 
 extern int ddebug_remove_module(const char *mod_name);
+
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);
 
@@ -164,11 +175,15 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 			 const char *fmt, ...);
 
 #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)	\
-	static struct _ddebug  __aligned(8)			\
-	__section("__dyndbg") name = {				\
+	static struct _ddebug_site  __aligned(8)		\
+	__section("__dyndbg_sites") name##_site = {		\
 		._modname = KBUILD_MODNAME,			\
-		._function = __func__,				\
 		._filename = __FILE__,				\
+		._function = __func__,				\
+	};							\
+	static struct _ddebug  __aligned(8)			\
+	__section("__dyndbg") name = {				\
+		.site = &name##_site,				\
 		.format = (fmt),				\
 		.lineno = __LINE__,				\
 		.flags = _DPRINTK_FLAGS_DEFAULT,		\
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 6aa6153aa6e0..5a80f18f8e4a 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2113,6 +2113,8 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 
 	info->dyndbg.descs = section_objs(info, "__dyndbg",
 					sizeof(*info->dyndbg.descs), &info->dyndbg.num_descs);
+	info->dyndbg.sites = section_objs(info, "__dyndbg_sites",
+					sizeof(*info->dyndbg.sites), &info->dyndbg.num_sites);
 	info->dyndbg.classes = section_objs(info, "__dyndbg_classes",
 					sizeof(*info->dyndbg.classes), &info->dyndbg.num_classes);
 
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 5a22708679a7..f1f354efed5a 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -44,6 +44,8 @@
 
 extern struct _ddebug __start___dyndbg[];
 extern struct _ddebug __stop___dyndbg[];
+extern struct _ddebug_site __start___dyndbg_sites[];
+extern struct _ddebug_site __stop___dyndbg_sites[];
 extern struct ddebug_class_map __start___dyndbg_classes[];
 extern struct ddebug_class_map __stop___dyndbg_classes[];
 
@@ -52,6 +54,7 @@ struct ddebug_table {
 	const char *mod_name;
 	unsigned int num_ddebugs;
 	struct _ddebug *ddebugs;
+	struct _ddebug_site *sites;
 };
 
 struct ddebug_query {
@@ -1487,20 +1490,27 @@ static int __init dynamic_debug_init_control(void)
 
 	return 0;
 }
+fs_initcall(dynamic_debug_init_control);
+
+static struct _ddebug_info builtin_state;
 
 static int __init dynamic_debug_init(void)
 {
 	struct _ddebug *iter, *iter_mod_start;
+	struct _ddebug_site *site, *site_mod_start;
 	int ret, i, mod_sites, mod_ct;
 	const char *modname;
 	char *cmdline;
 
 	struct _ddebug_info di = {
 		.descs = __start___dyndbg,
+		.sites = __start___dyndbg_sites,
 		.classes = __start___dyndbg_classes,
-		.num_descs = __stop___dyndbg - __start___dyndbg,
-		.num_classes = __stop___dyndbg_classes - __start___dyndbg_classes,
+		.num_descs	= __stop___dyndbg		- __start___dyndbg,
+		.num_sites	= __stop___dyndbg_sites		- __start___dyndbg_sites,
+		.num_classes	= __stop___dyndbg_classes	- __start___dyndbg_classes,
 	};
+	builtin_state = di;
 
 	if (&__start___dyndbg == &__stop___dyndbg) {
 		if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG)) {
@@ -1511,28 +1521,40 @@ static int __init dynamic_debug_init(void)
 		ddebug_init_success = 1;
 		return 0;
 	}
-
+	if (di.num_descs != di.num_sites) {
+		/* cant happen, unless site section has __used, desc does not */
+		pr_err("unequal vectors: descs/sites %d/%d\n", di.num_descs, di.num_sites);
+		return 1;
+	}
 	iter = iter_mod_start = __start___dyndbg;
-	modname = iter->_modname;
+	site = site_mod_start = __start___dyndbg_sites;
+	modname = iter->site->_modname;
 	i = mod_sites = mod_ct = 0;
 
-	for (; iter < __stop___dyndbg; iter++, i++, mod_sites++) {
+	for (; iter < __stop___dyndbg; iter++, site++, i++, mod_sites++) {
+
+		if (site != iter->site)
+			/* XXX: also cant happen, but lets see how it plays */
+			pr_err("linkage problem: site != iter->site\n");
 
-		if (strcmp(modname, iter->_modname)) {
+		if (strcmp(modname, site->_modname)) {
 			mod_ct++;
 			di.num_descs = mod_sites;
 			di.descs = iter_mod_start;
+			di.sites = site_mod_start;
 			ret = __ddebug_add_module(&di, i - mod_sites, modname);
 			if (ret)
 				goto out_err;
 
 			mod_sites = 0;
-			modname = iter->_modname;
+			modname = site->_modname;
 			iter_mod_start = iter;
+			site_mod_start = site;
 		}
 	}
 	di.num_descs = mod_sites;
 	di.descs = iter_mod_start;
+	di.sites = site_mod_start;
 	ret = __ddebug_add_module(&di, i - mod_sites, modname);
 	if (ret)
 		goto out_err;
@@ -1566,5 +1588,3 @@ static int __init dynamic_debug_init(void)
 /* Allow early initialization for boot messages via boot param */
 early_initcall(dynamic_debug_init);
 
-/* Debugfs setup must be done later */
-fs_initcall(dynamic_debug_init_control);
-- 
2.37.2

