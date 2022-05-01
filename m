Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B115162F6
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 10:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbiEAIrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 04:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343569AbiEAIpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 04:45:53 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCE14C7AA;
        Sun,  1 May 2022 01:42:25 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 2418f2S4008518;
        Sun, 1 May 2022 17:41:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 2418f2S4008518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651394473;
        bh=Q4PI1sHZaxJQnV1PrMopJJ/MUAwlu29QQhVGT8He9pY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AdA7qWJhTr8FshmNKSr5/l+w58qGqCL50cofbYjqS0QKY8Bn3yDhLWK2IshSbdKy7
         QnjE8RuSXw7PBQa3iaknS59br9Zm3ZD/PisU/fGcYG7Qr57SHCW4pGLeyXW4/meLYc
         MAqQMBisgg1HYUFzFRaAfSx+CXasj+r10gjrupXNF0k+h3wSeZF/vLdfIej6SiqmLY
         E/pUOv4+3mRNnwm8zbSJovzJ+wrONxRtCrCvLK3xEu/zWo3oYBSCppbecvZWchz2rx
         RJwLx2XDUei89t9zlLFy3TtEbDLwwbC2JjALuB+2PX6BsEuO12Z9w/VUIYyQHWrE01
         aUq+1Wa2PNbUA==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Subject: [PATCH v2 17/26] modpost: extract symbol versions from *.cmd files
Date:   Sun,  1 May 2022 17:40:23 +0900
Message-Id: <20220501084032.1025918-18-masahiroy@kernel.org>
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

Currently, CONFIG_MODVERSIONS needs extra link to embed the symbol
versions into ELF objects. Then, modpost extracts the version CRCs
from them.

The following figures show how it currently works, and how I am trying
to change it.

Current implementation
======================

                  embed CRC        |---------|              |------------|
       $(CC)        $(LD)          |         |              | final link |
  *.c ------> *.o --------> *.o -->| modpost |-- *.o ------>| for        |
                      /            |         |-- *.mod.c -->| vmlinux    |
     genksyms        /             |         |              | or module  |
  *.c ------> *.symversions        |---------|              |------------|

Genksyms outputs the calculated CRCs in the form of linker script
(*.symversions), which is used by $(LD) to update the object.

If CONFIG_LTO_CLANG=y, the build process becomes much more complex.
Embedding the CRCs is postponed until the LLVM bitcode is converted
into ELF, creating another intermediate *.prelink.o.

However, this complexity is unneeded. There is no reason why we must
embed version CRCs in objects so early.

There is final link stage for vmlinux (scripts/link-vmlinux.sh) and
modules (scripts/Makefile.modfinal). We can embed CRCs at the very
last moment.

New implementation
==================

       $(CC)           |---------|                    |------------|
  *.c ------> *.o  --->|         |                    | final link |
                       | modpost |-- *.o ------------>| for        |
      genksyms         |         |-- *.mod.c -------->| vmlinux    |
  *.c ------> *.cmd -->|         |-- *.symver.lds --->| or module  |
                       |---------|                    |------------|

We can pass the symbol versions to modpost as separate text data.
(The previous commit output the versions in *.cmd files.)

This commit changes modpost to retrieve CRCs from *.cmd files instead
of from ELF objects.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - Simplify the implementation (parse .cmd files after ELF)

 scripts/mod/modpost.c | 184 +++++++++++++++++++++++++++++++-----------
 1 file changed, 136 insertions(+), 48 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 375b9463cb8a..d8df0f8d3def 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -429,19 +429,10 @@ static struct symbol *sym_add_exported(const char *name, struct module *mod,
 	return s;
 }
 
-static void sym_set_crc(const char *name, unsigned int crc)
+static void sym_set_crc(struct symbol *sym, unsigned int crc)
 {
-	struct symbol *s = find_symbol(name);
-
-	/*
-	 * Ignore stand-alone __crc_*, which might be auto-generated symbols
-	 * such as __*_veneer in ARM ELF.
-	 */
-	if (!s)
-		return;
-
-	s->crc = crc;
-	s->crc_valid = true;
+	sym->crc = crc;
+	sym->crc_valid = true;
 }
 
 static void *grab_file(const char *filename, size_t *size)
@@ -664,33 +655,6 @@ static int ignore_undef_symbol(struct elf_info *info, const char *symname)
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
@@ -1997,6 +1961,111 @@ static char *remove_dot(char *s)
 	return s;
 }
 
+/*
+ * The CRCs are recorded in .*.cmd files in the form of:
+ * #SYMVER <name> <crc>
+ */
+static void extract_crcs_from_cmdfile(const char *object, struct module *mod)
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
+		return;
+	}
+
+	buf = read_text_file(cmd_file);
+	p = buf;
+
+	while ((p = strstr(p, "\n#SYMVER "))) {
+		char *name;
+		size_t namelen;
+		unsigned int crc;
+		struct symbol *sym;
+
+		name = p + strlen("\n#SYMVER ");
+
+		p = strchr(name, ' ');
+		if (!p) {
+			error("invalid\n");
+			goto out;
+		}
+
+		namelen = p - name;
+
+		p++;
+
+		if (!isdigit(*p)) {
+			error("invalid\n");
+			goto out;
+		}
+
+		crc = strtol(p, &p, 0);
+
+		if (*p != '\n') {
+			error("invalid\n");
+			goto out;
+		}
+
+		name[namelen] = '\0';
+
+		sym = sym_find_with_module(name, mod);
+		if (!sym) {
+			warn("Skip the version for unexported symbol \"%s\" [%s%s]",
+			     name, mod->name, mod->is_vmlinux ? "" : ".ko");
+			continue;
+		}
+		sym_set_crc(sym, crc);
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
+static void mod_set_crcs(struct module *mod)
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
+		extract_crcs_from_cmdfile(obj, mod);
+
+	free(buf);
+}
+
 static void read_symbols(const char *modname)
 {
 	const char *symname;
@@ -2057,9 +2126,6 @@ static void read_symbols(const char *modname)
 		if (strstarts(symname, "__kstrtabns_"))
 			sym_update_namespace(symname + strlen("__kstrtabns_"),
 					     sym_get_data(&info, sym));
-		if (strstarts(symname, "__crc_"))
-			handle_modversion(mod, &info, sym,
-					  symname + strlen("__crc_"));
 	}
 
 	// check for static EXPORT_SYMBOL_* functions && global vars
@@ -2088,12 +2154,17 @@ static void read_symbols(const char *modname)
 
 	parse_elf_finish(&info);
 
-	/* Our trick to get versioning for module struct etc. - it's
-	 * never passed as an argument to an exported function, so
-	 * the automatic versioning doesn't pick it up, but it's really
-	 * important anyhow */
-	if (modversions)
+	if (modversions) {
+		/*
+		 * Our trick to get versioning for module struct etc. - it's
+		 * never passed as an argument to an exported function, so
+		 * the automatic versioning doesn't pick it up, but it's really
+		 * important anyhow
+		 */
 		sym_add_unresolved("module_layout", mod, false);
+
+		mod_set_crcs(mod);
+	}
 }
 
 static void read_symbols_from_files(const char *filename)
@@ -2453,7 +2524,7 @@ static void read_dump(const char *fname)
 		}
 		s = sym_add_exported(symname, mod, export_no(export));
 		s->is_static = false;
-		sym_set_crc(symname, crc);
+		sym_set_crc(s, crc);
 		sym_update_namespace(symname, namespace);
 	}
 	free(buf);
@@ -2483,6 +2554,20 @@ static void write_dump(const char *fname)
 	free(buf.p);
 }
 
+static void check_symversions(struct module *mod)
+{
+	struct symbol *sym;
+
+	list_for_each_entry(sym, &mod->exported_symbols, list) {
+		if (!sym->crc_valid) {
+			warn("EXPORT symbol \"%s\" [%s%s] version generation failed, symbol will not be versioned.\n"
+			     "Is \"%s\" prototyped in <asm/asm-prototypes.h>?\n",
+			     sym->name, mod->name, mod->is_vmlinux ? "" : ".ko",
+			     sym->name);
+		}
+	}
+}
+
 static void write_namespace_deps_files(const char *fname)
 {
 	struct module *mod;
@@ -2579,6 +2664,9 @@ int main(int argc, char **argv)
 		char fname[PATH_MAX];
 		int ret;
 
+		if (modversions && !mod->from_dump)
+			check_symversions(mod);
+
 		if (mod->is_vmlinux || mod->from_dump)
 			continue;
 
-- 
2.32.0

