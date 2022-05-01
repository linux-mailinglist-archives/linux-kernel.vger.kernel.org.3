Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D8251632F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 10:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344235AbiEAIsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 04:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344110AbiEAIqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 04:46:15 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307EE4D631;
        Sun,  1 May 2022 01:42:42 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 2418f2S5008518;
        Sun, 1 May 2022 17:41:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 2418f2S5008518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651394474;
        bh=OyKvp23sdelZsluPike7CG+SfbuhHZjsYt7Vq53BKNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tFehZzoHaxBb/9YnjIwh2SNKBigsaYdWXBvJmhQMVYSxFMupgkQiWGw16ZwSQp1+U
         sISjvu4zxG31OdAkFiJ7jSBVpqEi2QcK7rEQjEMw9sG3sW3WxN6Zh6B/8U44/JQjRC
         lkDUt7UYRsQ5gkB353lD1seRAHVQh9FqZt4VIdlRDuC83og7x8G+zFahadXdoHz0KE
         tjxkYytQQligIQas7L5RAGIbxNQs+3SvbTgcZFNaqp3Iby0X6PHdGRbPpmt3K4edYb
         DUm4xB4pASpDXgK82pFoK/QMpTglzzjIS/KTdzmez9215af7vZIP2R0qmoH3+ihCQK
         I3rVWHhpl2ohg==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH v2 18/26] modpost: generate linker script to collect symbol versions
Date:   Sun,  1 May 2022 17:40:24 +0900
Message-Id: <20220501084032.1025918-19-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220501084032.1025918-1-masahiroy@kernel.org>
References: <20220501084032.1025918-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge version CRCs per vmlinux or per module.

These linker scripts will be fed to the final link stage.

Add the new option, -r,  to modpost. This is needed to output the
linker scripts in a different format when CONFIG_MODULE_REL_CRCS=y.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - Fix CONFIG_MODULE_REL_CRCS=y case

 .gitignore               |  1 +
 Makefile                 |  1 +
 scripts/Makefile.modpost |  1 +
 scripts/mod/modpost.c    | 37 ++++++++++++++++++++++++++++++++++---
 4 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/.gitignore b/.gitignore
index 265959544978..f9dad6b917e6 100644
--- a/.gitignore
+++ b/.gitignore
@@ -42,6 +42,7 @@
 *.so.dbg
 *.su
 *.symtypes
+*.symver.lds
 *.symversions
 *.tab.[ch]
 *.tar
diff --git a/Makefile b/Makefile
index 7a82bbc505f8..79a69ffd5379 100644
--- a/Makefile
+++ b/Makefile
@@ -1867,6 +1867,7 @@ clean: $(clean-dirs)
 		-o -name '*.c.[012]*.*' \
 		-o -name '*.ll' \
 		-o -name '*.gcno' \
+		-o -name '*.symver.lds' \
 		-o -name '*.*.symversions' \) -type f -print | xargs rm -f
 
 # Generate tags for editors
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 48585c4d04ad..fecd721537c9 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -46,6 +46,7 @@ include $(srctree)/scripts/Makefile.lib
 
 MODPOST = scripts/mod/modpost								\
 	$(if $(CONFIG_MODVERSIONS),-m)							\
+	$(if $(CONFIG_MODULE_REL_CRCS),-r)						\
 	$(if $(CONFIG_MODULE_SRCVERSION_ALL),-a)					\
 	$(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),,-E)					\
 	-o $@
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index d8df0f8d3def..935f57f73e40 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -24,6 +24,8 @@
 
 /* Are we using CONFIG_MODVERSIONS? */
 static bool modversions;
+/* Is CONFIG_MODULE_REL_CRCS enabled? */
+static bool modversions_rel_crcs;
 /* Is CONFIG_MODULE_SRCVERSION_ALL set? */
 static bool all_versions;
 /* If we are modposting external module set to 1 */
@@ -2554,9 +2556,21 @@ static void write_dump(const char *fname)
 	free(buf.p);
 }
 
-static void check_symversions(struct module *mod)
+static void write_symversions_lds(struct module *mod)
 {
+	struct buffer buf = { };
 	struct symbol *sym;
+	char lds_file[PATH_MAX];
+	int ret;
+
+	ret = snprintf(lds_file, sizeof(lds_file), "%s.symver.lds", mod->name);
+	if (ret >= sizeof(lds_file)) {
+		error("%s: too long path was truncated\n", lds_file);
+		return;
+	}
+
+	if (modversions_rel_crcs)
+		buf_printf(&buf, "SECTIONS { .rodata : ALIGN(4) {\n");
 
 	list_for_each_entry(sym, &mod->exported_symbols, list) {
 		if (!sym->crc_valid) {
@@ -2564,8 +2578,22 @@ static void check_symversions(struct module *mod)
 			     "Is \"%s\" prototyped in <asm/asm-prototypes.h>?\n",
 			     sym->name, mod->name, mod->is_vmlinux ? "" : ".ko",
 			     sym->name);
+			continue;
 		}
+
+		if (modversions_rel_crcs)
+			buf_printf(&buf, "__crc_%s = .; LONG(0x%08x);\n",
+				   sym->name, sym->crc);
+		else
+			buf_printf(&buf, "__crc_%s = 0x%08x;\n",
+				   sym->name, sym->crc);
 	}
+
+	if (modversions_rel_crcs)
+		buf_printf(&buf, "} }\n");
+
+	write_if_changed(&buf, lds_file);
+	free(buf.p);
 }
 
 static void write_namespace_deps_files(const char *fname)
@@ -2606,7 +2634,7 @@ int main(int argc, char **argv)
 	LIST_HEAD(dump_lists);
 	struct dump_list *dl, *dl2;
 
-	while ((opt = getopt(argc, argv, "ei:mnT:o:awENd:")) != -1) {
+	while ((opt = getopt(argc, argv, "ei:mrnT:o:awENd:")) != -1) {
 		switch (opt) {
 		case 'e':
 			external_module = true;
@@ -2619,6 +2647,9 @@ int main(int argc, char **argv)
 		case 'm':
 			modversions = true;
 			break;
+		case 'r':
+			modversions_rel_crcs = true;
+			break;
 		case 'n':
 			ignore_missing_files = true;
 			break;
@@ -2665,7 +2696,7 @@ int main(int argc, char **argv)
 		int ret;
 
 		if (modversions && !mod->from_dump)
-			check_symversions(mod);
+			write_symversions_lds(mod);
 
 		if (mod->is_vmlinux || mod->from_dump)
 			continue;
-- 
2.32.0

