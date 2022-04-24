Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E4650D4BE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 21:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239272AbiDXTQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 15:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238674AbiDXTOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 15:14:12 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AEE186F6;
        Sun, 24 Apr 2022 12:10:19 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 23OJ8o6H019069;
        Mon, 25 Apr 2022 04:09:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 23OJ8o6H019069
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1650827345;
        bh=+yEXW56Av2KPDdnQt9MAFWt+h+ms9x9av68qeW9IT0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xjag+FWZ3e7U5HpF5rFliUAOCZoAUnVr1nHZF++WkIU2qPrYdx910ejilCrDfqOHq
         WY1RXzj9kCTYbc+/aX79KONu8j0bZHO2QX7KXFRkxI6fSkSrPLpa+Pa0pMv8ebUo/l
         ZtrcfdyjSxFfDFl41dhq/18ozV9/2QfEfX5iG0zNtsBFeMDSO9QoJV2IkL0j+6y71V
         4CqEfeFUEugHK3zrfMLVKbaTLftcSqT9XjRXwgKJ45zpmSDqogpPWFFAwUjbGq9b45
         Ak6q6CfoeM7hqXrdVgSZTs60zx0Uvrfl+Tj/LlPVLBLW21L8EP3CLSWslGd0NnJTzG
         AsNougBzyCmFA==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Subject: [PATCH 23/27] modpost: retrieve symbol versions by parsing *.cmd files
Date:   Mon, 25 Apr 2022 04:08:07 +0900
Message-Id: <20220424190811.1678416-24-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220424190811.1678416-1-masahiroy@kernel.org>
References: <20220424190811.1678416-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, CONFIG_MODVERSIONS needs extra link to embed the symbol
versions into objects. Then, modpost parses the ELF objects to retrieve
the version CRCs.

See the current build flow below.

Current implementation
======================

                  embed CRC        |---------|              |------------|
       $(CC)        $(LD)          |         |              | final link |
  *.c ------> *.o --------> *.o -->| modpost |-- *.o ------>| for        |
                      /            |         |              | vmlinux    |
     genksyms        /             |         |-- *.mod.c -->| or module  |
  *.c ------> *.symversions        |---------|              |------------|

Genksyms outputs the calculated CRCs in the form of linker script
(*.symversions), which is used by $(LD) to update the object.

If CONFIG_LTO_CLANG=y, the build process becomes much more complex.
Embedding the CRCs is postponed until the LLVM bitcode is converted
into ELF, creating another intermediate *.prelink.o.

However, this complexity is unneeded in the first place. There is no
reason why we must embed version CRCs in objects so early.

There is final link stage for vmlinux (scripts/link-vmlinux.sh) and
modules (scripts/Makefile.modfinal). We can embed CRCs at the very
last moment.

See the following figure, which explains what I want to do.

New implementation
==================

       $(CC)           |---------|                    |------------|
  *.c ------> *.o  --->|         |-- *.o ------------>| final link |
                       | modpost |-- *.mod.c -------->| for        |
      genksyms         |         |-- *.symver.lds --->| vmlinux    |
  *.c ------> *.cmd -->|         |                    | or module  |
                       |---------|                    |------------|

We can pass the symbol versions to modpost as separate text data.
(The previous commit output the versions in *.cmd files.)

This commit changes modpost to retrieve CRCs from *.cmd files instead
of from ELF objects.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 177 ++++++++++++++++++++++++++++++++----------
 1 file changed, 136 insertions(+), 41 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index fb50927cd241..43ab4f000ae3 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -246,6 +246,9 @@ static inline unsigned int tdb_hash(const char *name)
 /* hash table of all exported symbols */
 HASHTABLE_DECLARE(exported_symbols, 8192);
 
+/* hash table of CRCs */
+HASHTABLE_DECLARE(crc_symbols, 1024);
+
 /**
  * Allocate a new symbols for use in the hash of exported symbols or
  * the list of unresolved symbols per module
@@ -420,7 +423,27 @@ static void sym_add_exported(const char *name, struct module *mod,
 		      s->module->is_vmlinux ? "" : ".ko");
 	}
 
-	s = alloc_symbol(name);
+	s = NULL;
+
+	if (modversions) {
+		struct hlist_node *n;
+
+		hash_for_matched_symbol_safe(s, n, crc_symbols, name) {
+			if (s->module == mod)
+				hash_del_symbol(s);
+			break;
+		}
+
+		if (!s)
+			warn("EXPORT symbol \"%s\" [%s%s] version generation failed, symbol will not be versioned.\n"
+			     "Is \"%s\" prototyped in <asm/asm-prototypes.h>?\n",
+			     name, mod->name, mod->is_vmlinux ? "" : ".ko",
+			     name);
+	}
+
+	if (!s)
+		s = alloc_symbol(name);
+
 	s->module = mod;
 	s->is_static = !mod->from_dump;
 	s->export    = export;
@@ -428,19 +451,116 @@ static void sym_add_exported(const char *name, struct module *mod,
 	hash_add_symbol(s, exported_symbols);
 }
 
-static void sym_set_crc(const char *name, unsigned int crc)
+static void sym_add_crc(const char *name, unsigned int crc, struct module *mod)
 {
-	struct symbol *s = find_symbol(name);
+	struct symbol *sym;
 
-	/*
-	 * Ignore stand-alone __crc_*, which might be auto-generated symbols
-	 * such as __*_veneer in ARM ELF.
-	 */
-	if (!s)
+	sym = alloc_symbol(name);
+
+	sym->crc = crc;
+	sym->crc_valid = true;
+	sym->module = mod;
+
+	hash_add_symbol(sym, crc_symbols);
+}
+
+/*
+ * The CRCs are recorded in .*.cmd files in the form of:
+ * #__crc_<name>=<crc>
+ */
+static void retrieve_crcs_from_cmdfile(const char *object, struct module *mod)
+{
+	char cmd_file[PATH_MAX];
+	char *buf, *p;
+	const char *base;
+	int dirlen, ret;
+
+	base = strrchr(object, '/');
+	if (base) {
+		base++;
+		dirlen = base - object;
+	} else {
+		dirlen = 0;
+		base = object;
+	}
+
+	ret = snprintf(cmd_file, sizeof(cmd_file), "%.*s.%s.cmd",
+		       dirlen, object, base);
+	if (ret >= sizeof(cmd_file)) {
+		error("%s: too long path was truncated\n", cmd_file);
 		return;
+	}
+
+	buf = read_text_file(cmd_file);
+	p = buf;
+
+	while ((p = strstr(p, "\n#__crc_"))) {
+		char *name;
+		size_t namelen;
+		unsigned int crc;
+		char *end;
+
+		name = p + strlen("\n#__crc_");
+
+		p = strchr(name, '=');
+		if (!p) {
+			error("invalid\n");
+			goto out;
+		}
+
+		namelen = p - name;
+
+		p++;
 
-	s->crc = crc;
-	s->crc_valid = true;
+		if (!isdigit(*p)) {
+			error("invalid\n");
+			goto out;
+		}
+
+		crc = strtol(p, &end, 0);
+		p = end;
+
+		if (*p != '\n') {
+			error("invalid\n");
+			goto out;
+		}
+
+		name[namelen] = '\0';
+		sym_add_crc(name, crc, mod);
+	}
+
+out:
+	free(buf);
+}
+
+/*
+ * The symbol versions (CRC) are recorded in the .*.cmd files.
+ * Parse them to retrieve CRCs for the current module.
+ */
+static void retrieve_crcs(struct module *mod)
+{
+	char objlist[PATH_MAX];
+	char *buf, *p, *obj;
+	int ret;
+
+	if (mod->is_vmlinux) {
+		strcpy(objlist, ".vmlinux.objs");
+	} else {
+		/* objects for a module are listed in the *.mod file. */
+		ret = snprintf(objlist, sizeof(objlist), "%s.mod", mod->name);
+		if (ret >= sizeof(objlist)) {
+			error("%s: too long path was truncated\n", objlist);
+			return;
+		}
+	}
+
+	buf = read_text_file(objlist);
+	p = buf;
+
+	while ((obj = strsep(&p, "\n")) && obj[0])
+		retrieve_crcs_from_cmdfile(obj, mod);
+
+	free(buf);
 }
 
 static void *grab_file(const char *filename, size_t *size)
@@ -663,33 +783,6 @@ static int ignore_undef_symbol(struct elf_info *info, const char *symname)
 	return 0;
 }
 
-static void handle_modversion(const struct module *mod,
-			      const struct elf_info *info,
-			      const Elf_Sym *sym, const char *symname)
-{
-	unsigned int crc;
-
-	if (sym->st_shndx == SHN_UNDEF) {
-		warn("EXPORT symbol \"%s\" [%s%s] version generation failed, symbol will not be versioned.\n"
-		     "Is \"%s\" prototyped in <asm/asm-prototypes.h>?\n",
-		     symname, mod->name, mod->is_vmlinux ? "" : ".ko",
-		     symname);
-
-		return;
-	}
-
-	if (sym->st_shndx == SHN_ABS) {
-		crc = sym->st_value;
-	} else {
-		unsigned int *crcp;
-
-		/* symbol points to the CRC in the ELF object */
-		crcp = sym_get_data(info, sym);
-		crc = TO_NATIVE(*crcp);
-	}
-	sym_set_crc(symname, crc);
-}
-
 static void handle_symbol(struct module *mod, struct elf_info *info,
 			  const Elf_Sym *sym, const char *symname)
 {
@@ -2019,6 +2112,10 @@ static void read_symbols(const char *modname)
 		if (strends(tmp, ".prelink"))
 			tmp[strlen(tmp) - 8] = '\0';
 		mod = new_module(tmp);
+
+		if (modversions)
+			retrieve_crcs(mod);
+
 		free(tmp);
 	}
 
@@ -2058,9 +2155,6 @@ static void read_symbols(const char *modname)
 		if (strstarts(symname, "__kstrtabns_"))
 			sym_update_namespace(symname + strlen("__kstrtabns_"),
 					     sym_get_data(&info, sym));
-		if (strstarts(symname, "__crc_"))
-			handle_modversion(mod, &info, sym,
-					  symname + strlen("__crc_"));
 	}
 
 	// check for static EXPORT_SYMBOL_* functions && global vars
@@ -2451,8 +2545,9 @@ static void read_dump(const char *fname)
 			mod = new_module(modname);
 			mod->from_dump = true;
 		}
+
+		sym_add_crc(symname, crc, mod);
 		sym_add_exported(symname, mod, export_no(export));
-		sym_set_crc(symname, crc);
 		sym_update_namespace(symname, namespace);
 	}
 	free(buf);
-- 
2.32.0

