Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3D0523ACC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345113AbiEKQuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345030AbiEKQtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:49:46 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DC695DDE;
        Wed, 11 May 2022 09:49:41 -0700 (PDT)
Received: from grover.jp (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 24BGlWc3031975;
        Thu, 12 May 2022 01:47:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 24BGlWc3031975
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652287661;
        bh=JATy8zCouz8u3lhW7zZYODfMQ0k0TkdVWlfxnhpO/F4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hYZAunszaDmkR8soaFwivCZyB2gcI024RUh21imB4CWfb+Bwmx9tNQsKAgM209tzg
         7XAR5QNmNGgNjvjqAO9yEH6re6eojuiCM7gS95ilXpcaGZZLla3i3cJv/lwt0AedOx
         RD9/4GTHJJZZHkB2EXrX49SKZcLONqBMXpZ5Uoip4MiviB2VnYI8pRGOxgU38O8T81
         1IvpXi9zryrV5qzpWLF5nNDX2Zn+bXRAjfw+GWax93rqp4qm0hBl1tOyp2herg3Yma
         P/iuI3Zg65TFJz6xr888OucWIL2PaFUUnGRXJr50UPEXoK14xZRJ2pnyU3Sm5cuNln
         xNUiQuRvcJkiA==
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
Subject: [PATCH v5 08/12] kbuild: check static EXPORT_SYMBOL* by script instead of modpost
Date:   Thu, 12 May 2022 01:45:10 +0900
Message-Id: <20220511164514.2741934-9-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220511164514.2741934-1-masahiroy@kernel.org>
References: <20220511164514.2741934-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
---

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
index 18f4d4a5a0ee..50dbd2e9939c 100644
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
 
@@ -875,20 +874,6 @@ static void read_symbols(const char *modname)
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
@@ -1318,7 +1303,6 @@ static void read_dump(const char *fname)
 			mod->from_dump = true;
 		}
 		s = sym_add_exported(symname, mod, gpl_only);
-		s->is_static = false;
 		sym_set_crc(s, crc);
 		sym_update_namespace(symname, namespace);
 	}
@@ -1383,7 +1367,6 @@ int main(int argc, char **argv)
 	char *missing_namespace_deps = NULL;
 	char *dump_write = NULL, *files_source = NULL;
 	int opt;
-	int n;
 	LIST_HEAD(dump_lists);
 	struct dump_list *dl, *dl2;
 
@@ -1459,15 +1442,6 @@ int main(int argc, char **argv)
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

