Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE30526132
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 13:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379976AbiEMLmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 07:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379933AbiEMLmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:42:14 -0400
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A0C5AA79;
        Fri, 13 May 2022 04:42:12 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 24DBeEwf008349;
        Fri, 13 May 2022 20:40:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 24DBeEwf008349
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652442021;
        bh=cqElzDKYpcUrgO4yHYvWdPTzjbjG7knRZ4i2745IA+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sc3Y3caE/J1wed4rFYZnaCpQhbTPOPyo6Eo0nM+FrQSyiMx9UMcAK4hL4C/M5w8Ze
         oLEckYtJTNT6qK4yaUuHkqrpjubN5bDQ47zCTsArPk352eWo2JqJVkCejliOY0ZDAQ
         a5jNXw0kyOkiYbsbMQKHs9i1LjATm9v7pj0z5/1aXLsZxDhNNV3ViOdeG8S1jZrodG
         bxHebxebti4fji1Czx/yAHQSgu6OMbfYJzhpyhLUBtwrEgt4lcrFcDhjA7rZs8RvLa
         ba2itORo7C46mX1ysaHXHu73CYPEcGlmaXkBJs8//kpYZyYQYsqtLiLKtrHey91YRo
         P7yxqNo9PrLsQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules@vger.kernel.org, llvm@lists.linux.dev,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v6 06/10] kbuild: check static EXPORT_SYMBOL* by script instead of modpost
Date:   Fri, 13 May 2022 20:39:26 +0900
Message-Id: <20220513113930.10488-7-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220513113930.10488-1-masahiroy@kernel.org>
References: <20220513113930.10488-1-masahiroy@kernel.org>
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

It is true modpost gets access to the lists of all the member objects
(.vmlinux.objs and *.mod), but modpost cannot parse individual objects
because they may not be ELF but LLVM IR when CONFIG_LTO_CLANG=y.

Add a simple bash script to parse the output from ${NM}. This works for
CONFIG_LTO_CLANG=y because llvm-nm can dump symbols of LLVM IR files.

Revert 15bfc2348d54.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---

(no changes since v5)

Changes in v5:
  - Add more comments in the script

Changes in v4:
  - New patch

 scripts/Makefile.build     |  4 +++
 scripts/check-local-export | 64 ++++++++++++++++++++++++++++++++++++++
 scripts/mod/modpost.c      | 28 +----------------
 3 files changed, 69 insertions(+), 27 deletions(-)
 create mode 100755 scripts/check-local-export

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 838ea5e83174..c2a173b3fd60 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -244,9 +244,12 @@ cmd_gen_ksymdeps = \
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
@@ -257,6 +260,7 @@ endef
 define rule_as_o_S
 	$(call cmd_and_fixdep,as_o_S)
 	$(call cmd,gen_ksymdeps)
+	$(call cmd,check_local_export)
 	$(call cmd,gen_objtooldep)
 	$(call cmd,gen_symversions_S)
 endef
diff --git a/scripts/check-local-export b/scripts/check-local-export
new file mode 100755
index 000000000000..829e0591c0be
--- /dev/null
+++ b/scripts/check-local-export
@@ -0,0 +1,64 @@
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
+	# Exceptional case for Clang LTO.
+	# llvm-nm outputs this:
+	#   "---------------- t"
+	# Skip this line because the name is empty.
+	if [[ ${value} = -* && -z ${name} ]]; then
+		continue
+	fi
+
+	# For undefined symbols, the first field (value) is empty.
+	# The outout looks like this:
+	#   "                 U _printk"
+	# Shift the fields.
+	if [[ -z ${name} ]]; then
+	   name=${type}
+	   type=${value}
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
+	# Use -q instead of 2>/dev/null when we upgrade the minimum version of
+	# binutils to 2.37, llvm to 13.0.0.
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
index 27c45427d989..2328522f8a78 100644
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
 
@@ -877,20 +876,6 @@ static void read_symbols(const char *modname)
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
 	check_sec_ref(mod, modname, &info);
 
 	if (!mod->is_vmlinux) {
@@ -1320,7 +1305,6 @@ static void read_dump(const char *fname)
 			mod->from_dump = true;
 		}
 		s = sym_add_exported(symname, mod, gpl_only);
-		s->is_static = false;
 		sym_set_crc(s, crc);
 		sym_update_namespace(symname, namespace);
 	}
@@ -1385,7 +1369,6 @@ int main(int argc, char **argv)
 	char *missing_namespace_deps = NULL;
 	char *dump_write = NULL, *files_source = NULL;
 	int opt;
-	int n;
 	LIST_HEAD(dump_lists);
 	struct dump_list *dl, *dl2;
 
@@ -1461,15 +1444,6 @@ int main(int argc, char **argv)
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

