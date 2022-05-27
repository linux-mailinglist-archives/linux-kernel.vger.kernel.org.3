Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD33535DE6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350884AbiE0KFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350791AbiE0KE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:04:56 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F28B1116EA;
        Fri, 27 May 2022 03:04:46 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 24RA2hPU029808;
        Fri, 27 May 2022 19:02:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 24RA2hPU029808
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653645768;
        bh=63AM9Y7KFJuXBvKXOmj6kJdz+ZNVbwHrp42ZdIFptX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RW1wttQF3Oea8ArmryxA7c5OlRphy4XLSdTGnKXoDhQDvP5OS0CvMg6u22wNMneYx
         MmO+ShRV77S1L7Kw29gY8hdiRenlRehQa9VP/A7EW8Q74MIo5gh55tpvyRw/EjcNDt
         FtZa4M+gKZRkV1J7Xeaw1CpPiJZPNC+qWSvPi6SIOT+q7f3UQqnuWYNdCbUsSk7eeK
         VXAsUTwKMj0SR86wH6e551ECa1syR07zSaD6957dxD4pxsoSxokifNvrkHppOu8zAW
         mngXMEsnyFXgvcZ5tdQ8cgd6TbzUkBzBfMsFXGJzFu11tESBdN4bw0fStXUmgTILtj
         rmlIrYn4jxCTQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, llvm@lists.linux.dev,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v7 4/8] kbuild: check static EXPORT_SYMBOL* by script instead of modpost
Date:   Fri, 27 May 2022 19:01:51 +0900
Message-Id: <20220527100155.1996314-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220527100155.1996314-1-masahiroy@kernel.org>
References: <20220527100155.1996314-1-masahiroy@kernel.org>
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

The 'static' specifier and EXPORT_SYMBOL() are an odd combination.

Commit 15bfc2348d54 ("modpost: check for static EXPORT_SYMBOL*
functions") tried to detect it, but this check has false negatives.

Here is the sample code.

  Makefile:

    obj-y += foo1.o foo2.o

  foo1.c:

    #include <linux/export.h>
    static void foo(void) {}
    EXPORT_SYMBOL(foo);

  foo2.c:

    void foo(void) {}

foo1.c exports the static symbol 'foo', but modpost cannot catch it
because it is fooled by foo2.c, which has a global symbol with the
same name.

s->is_static is cleared if a global symbol with the same name is found
somewhere, but EXPORT_SYMBOL() and the global symbol do not necessarily
belong to the same compilation unit.

This check should be done per compilation unit, but I do not know how
to do it in modpost. modpost runs against vmlinux.o or modules, which
merges multiple objects, then forgets their origin.

modpost cannot parse individual objects because they may not be ELF but
LLVM IR when CONFIG_LTO_CLANG=y.

Add a simple bash script to parse the output from ${NM}. This works for
CONFIG_LTO_CLANG=y because llvm-nm can dump symbols of LLVM IR files.

Revert 15bfc2348d54.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM-14 (x86-64)
---

Changes in v7:
  - Fix sparc64 build (skip the line if the number of fields is less than 3)

Changes in v5:
  - Add more comments in the script

Changes in v4:
  - New patch

 scripts/Makefile.build     |  4 +++
 scripts/check-local-export | 65 ++++++++++++++++++++++++++++++++++++++
 scripts/mod/modpost.c      | 28 +---------------
 3 files changed, 70 insertions(+), 27 deletions(-)
 create mode 100755 scripts/check-local-export

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 23e1fb19f9ad..0135b4e7f78b 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -248,9 +248,12 @@ cmd_gen_ksymdeps = \
 	$(CONFIG_SHELL) $(srctree)/scripts/gen_ksymdeps.sh $@ >> $(dot-target).cmd
 endif
 
+cmd_check_local_export = $(srctree)/scripts/check-local-export $@
+
 define rule_cc_o_c
 	$(call cmd_and_fixdep,cc_o_c)
 	$(call cmd,gen_ksymdeps)
+	$(call cmd,check_local_export)
 	$(call cmd,checksrc)
 	$(call cmd,checkdoc)
 	$(call cmd,gen_objtooldep)
@@ -261,6 +264,7 @@ endef
 define rule_as_o_S
 	$(call cmd_and_fixdep,as_o_S)
 	$(call cmd,gen_ksymdeps)
+	$(call cmd,check_local_export)
 	$(call cmd,gen_objtooldep)
 	$(call cmd,gen_symversions_S)
 endef
diff --git a/scripts/check-local-export b/scripts/check-local-export
new file mode 100755
index 000000000000..017119d89cd2
--- /dev/null
+++ b/scripts/check-local-export
@@ -0,0 +1,65 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (C) 2022 Masahiro Yamada <masahiroy@kernel.org>
+#
+# Exit with error if a local exported symbol is found.
+# EXPORT_SYMBOL should be used for global symbols.
+
+set -e
+
+declare -A symbol_types
+declare -a export_symbols
+
+exit_code=0
+
+while read value type name
+do
+	# Skip the number of fields is less than 3.
+	#
+	# case 1)
+	#   For undefined symbols, the first field (value) is empty.
+	#   The outout looks like this:
+	#     "                 U _printk"
+	#   It is unneeded to record undefined symbols.
+	#
+	# case 2)
+	#   For Clang LTO, llvm-nm outputs a line with type 't' but empty name:
+	#     "---------------- t"
+	if [[ -z ${name} ]]; then
+		continue
+	fi
+
+	# save (name, type) in the associative array
+	symbol_types[${name}]=${type}
+
+	# append the exported symbol to the array
+	if [[ ${name} == __ksymtab_* ]]; then
+		export_symbols+=(${name#__ksymtab_})
+	fi
+
+	# If there is no symbol in the object, ${NM} (both GNU nm and llvm-nm)
+	# shows 'no symbols' diagnostic (but exits with 0). It is harmless and
+	# hidden by '2>/dev/null'. However, it suppresses real error messages
+	# as well. Add a hand-crafted error message here.
+	#
+	# Use --quiet instead of 2>/dev/null when we upgrade the minimum version
+	# of binutils to 2.37, llvm to 13.0.0.
+	#
+	# Then, the following line will be really simple:
+	#   done < <(${NM} --quiet ${1})
+done < <(${NM} ${1} 2>/dev/null || { echo "${0}: ${NM} failed" >&2; false; } )
+
+# Catch error in the process substitution
+wait $!
+
+for name in "${export_symbols[@]}"
+do
+	# nm(3) says "If lowercase, the symbol is usually local"
+	if [[ ${symbol_types[$name]} =~ [a-z] ]]; then
+		echo "$@: error: local symbol '${name}' was exported" >&2
+		exit_code=1
+	fi
+done
+
+exit ${exit_code}
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index e74224a6a8e8..9269735f85c5 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -212,7 +212,6 @@ struct symbol {
 	unsigned int crc;
 	bool crc_valid;
 	bool weak;
-	bool is_static;		/* true if symbol is not global */
 	bool is_gpl_only;	/* exported by EXPORT_SYMBOL_GPL */
 	char name[];
 };
@@ -242,7 +241,7 @@ static struct symbol *alloc_symbol(const char *name)
 
 	memset(s, 0, sizeof(*s));
 	strcpy(s->name, name);
-	s->is_static = true;
+
 	return s;
 }
 
@@ -2064,20 +2063,6 @@ static void read_symbols(const char *modname)
 					     sym_get_data(&info, sym));
 	}
 
-	// check for static EXPORT_SYMBOL_* functions && global vars
-	for (sym = info.symtab_start; sym < info.symtab_stop; sym++) {
-		unsigned char bind = ELF_ST_BIND(sym->st_info);
-
-		if (bind == STB_GLOBAL || bind == STB_WEAK) {
-			struct symbol *s =
-				find_symbol(remove_dot(info.strtab +
-						       sym->st_name));
-
-			if (s)
-				s->is_static = false;
-		}
-	}
-
 	check_sec_ref(modname, &info);
 
 	if (!mod->is_vmlinux) {
@@ -2507,7 +2492,6 @@ static void read_dump(const char *fname)
 			mod->from_dump = true;
 		}
 		s = sym_add_exported(symname, mod, gpl_only);
-		s->is_static = false;
 		sym_set_crc(s, crc);
 		sym_update_namespace(symname, namespace);
 	}
@@ -2572,7 +2556,6 @@ int main(int argc, char **argv)
 	char *missing_namespace_deps = NULL;
 	char *dump_write = NULL, *files_source = NULL;
 	int opt;
-	int n;
 	LIST_HEAD(dump_lists);
 	struct dump_list *dl, *dl2;
 
@@ -2648,15 +2631,6 @@ int main(int argc, char **argv)
 	if (sec_mismatch_count && !sec_mismatch_warn_only)
 		error("Section mismatches detected.\n"
 		      "Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.\n");
-	for (n = 0; n < SYMBOL_HASH_SIZE; n++) {
-		struct symbol *s;
-
-		for (s = symbolhash[n]; s; s = s->next) {
-			if (s->is_static)
-				error("\"%s\" [%s] is a static EXPORT_SYMBOL\n",
-				      s->name, s->module->name);
-		}
-	}
 
 	if (nr_unresolved > MAX_UNRESOLVED_REPORTS)
 		warn("suppressed %u unresolved symbol warnings because there were too many)\n",
-- 
2.32.0

