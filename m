Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DE34F47B0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376283AbiDEVP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384218AbiDEM1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 08:27:16 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0984E72E1B;
        Tue,  5 Apr 2022 04:35:50 -0700 (PDT)
Received: from grover.. (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 235BYCGu000464;
        Tue, 5 Apr 2022 20:34:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 235BYCGu000464
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649158458;
        bh=xHw08sV1P7djqAfiHb5ZZpE2FCl7EdNPfQ2AKXOC1LQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tg5lQO4MTmYIwmMFvfiphHN64ZDtYzZrRaOVeSlwLV1dzrrb78p68cE9PM67D4obJ
         wsGrh6fee1th0zcYazx2Nr7lBvlLaQUbGWe7StvUw4d0qDdJN/zdDPZWUrjCWZvXJk
         JQUt8NeeQX1ghIZWPw0R59LyRx4+E5Zs1VyTy066BERqDhkfpHwXLItA4Hit3hhPiM
         ebpysZFpK0nRtmFIuz8W3Ua7vz2apvuBB79fEjUuHOLyDETSlcWCietxKc+yN438nZ
         JgmdY80OpYgjZfoR+Oy47a4tymUxC+BdgwKLpRVNdqigq39pGF/SdrFlJYQ2oV2K8W
         Drk2PNJNjC+qQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <n.schier@avm.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: [PATCH v2 08/10] kbuild: split the second line of *.mod into *.usyms
Date:   Tue,  5 Apr 2022 20:33:56 +0900
Message-Id: <20220405113359.2880241-9-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220405113359.2880241-1-masahiroy@kernel.org>
References: <20220405113359.2880241-1-masahiroy@kernel.org>
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

The *.mod files have two lines; the first line lists the member objects
of the module, and the second line, if CONFIG_TRIM_UNUSED_KSYMS=y, lists
the undefined symbols.

These two are orthogonal. For further cleanups, lets' split the second
line out to separate *.usyms files, which are generated only when
CONFIG_TRIM_UNUSED_KSYMS=y.

Previously, the list of undefined symbols ended up with a very long
line, but now symbols are split by new lines.

Use 'sed' like we did before commit 7d32358be8ac ("kbuild: avoid split
lines in .mod files").

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - new

 .gitignore                  |  1 +
 Makefile                    |  2 +-
 scripts/Makefile.build      | 17 +++++++++--------
 scripts/adjust_autoksyms.sh |  2 +-
 scripts/gen_autoksyms.sh    | 18 +++++++++++-------
 scripts/mod/sumversion.c    | 11 ++---------
 6 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/.gitignore b/.gitignore
index 7afd412dadd2..265959544978 100644
--- a/.gitignore
+++ b/.gitignore
@@ -45,6 +45,7 @@
 *.symversions
 *.tab.[ch]
 *.tar
+*.usyms
 *.xz
 *.zst
 Module.symvers
diff --git a/Makefile b/Makefile
index d9336e783be3..82ee893909e9 100644
--- a/Makefile
+++ b/Makefile
@@ -1848,7 +1848,7 @@ clean: $(clean-dirs)
 		-o -name '*.ko.*' \
 		-o -name '*.dtb' -o -name '*.dtbo' -o -name '*.dtb.S' -o -name '*.dt.yaml' \
 		-o -name '*.dwo' -o -name '*.lst' \
-		-o -name '*.su' -o -name '*.mod' \
+		-o -name '*.su' -o -name '*.mod' -o -name '*.usyms' \
 		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \
 		-o -name '*.lex.c' -o -name '*.tab.[ch]' \
 		-o -name '*.asn1.[ch]' \
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 63625877aeae..d934bdf84de4 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -85,7 +85,8 @@ ifdef need-builtin
 targets-for-builtin += $(obj)/built-in.a
 endif
 
-targets-for-modules := $(patsubst %.o, %.mod, $(filter %.o, $(obj-m)))
+targets-for-modules := $(foreach suffix, mod $(if $(CONFIG_TRIM_UNUSED_KSYMS), usyms), \
+				$(patsubst %.o, %.$(suffix), $(filter %.o, $(obj-m))))
 
 ifneq ($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT),)
 targets-for-modules += $(patsubst %.o, %.prelink.o, $(filter %.o, $(obj-m)))
@@ -260,9 +261,6 @@ endif
 ifdef CONFIG_TRIM_UNUSED_KSYMS
 cmd_gen_ksymdeps = \
 	$(CONFIG_SHELL) $(srctree)/scripts/gen_ksymdeps.sh $@ >> $(dot-target).cmd
-
-# List module undefined symbols
-undefined_syms = $(NM) $< | $(AWK) '$$1 == "U" { printf("%s%s", x++ ? " " : "", $$2) }';
 endif
 
 define rule_cc_o_c
@@ -309,14 +307,17 @@ endif
 
 multi-m-prereqs = $(sort $(addprefix $(obj)/, $($*-objs) $($*-y) $($*-m)))
 
-cmd_mod = { \
-	echo $(if $(multi-m-prereqs), $(multi-m-prereqs), $(@:.mod=.o)); \
-	$(undefined_syms) echo; \
-	} > $@
+cmd_mod = echo $(if $(multi-m-prereqs), $(multi-m-prereqs), $(@:.mod=.o)) > $@
 
 $(obj)/%.mod: $(obj)/%$(mod-prelink-ext).o FORCE
 	$(call if_changed,mod)
 
+# List module undefined symbols
+cmd_undefined_syms = $(NM) $< | sed -n 's/^  *U //p' > $@
+
+$(obj)/%.usyms: $(obj)/%$(mod-prelink-ext).o FORCE
+	$(call if_changed,undefined_syms)
+
 quiet_cmd_cc_lst_c = MKLST   $@
       cmd_cc_lst_c = $(CC) $(c_flags) -g -c -o $*.o $< && \
 		     $(CONFIG_SHELL) $(srctree)/scripts/makelst $*.o \
diff --git a/scripts/adjust_autoksyms.sh b/scripts/adjust_autoksyms.sh
index 59fdb875e818..f1b5ac818411 100755
--- a/scripts/adjust_autoksyms.sh
+++ b/scripts/adjust_autoksyms.sh
@@ -35,7 +35,7 @@ case "$KBUILD_VERBOSE" in
 esac
 
 # Generate a new symbol list file
-$CONFIG_SHELL $srctree/scripts/gen_autoksyms.sh "$new_ksyms_file"
+$CONFIG_SHELL $srctree/scripts/gen_autoksyms.sh --modorder "$new_ksyms_file"
 
 # Extract changes between old and new list and touch corresponding
 # dependency files.
diff --git a/scripts/gen_autoksyms.sh b/scripts/gen_autoksyms.sh
index 120225c541c5..faacf7062122 100755
--- a/scripts/gen_autoksyms.sh
+++ b/scripts/gen_autoksyms.sh
@@ -2,13 +2,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 # Create an autoksyms.h header file from the list of all module's needed symbols
-# as recorded on the second line of *.mod files and the user-provided symbol
-# whitelist.
+# as recorded in *.usyms files and the user-provided symbol whitelist.
 
 set -e
 
-output_file="$1"
-
 # Use "make V=1" to debug this script.
 case "$KBUILD_VERBOSE" in
 *1*)
@@ -16,6 +13,15 @@ case "$KBUILD_VERBOSE" in
 	;;
 esac
 
+read_modorder=
+
+if [ "$1" = --modorder ]; then
+	shift
+	read_modorder=1
+fi
+
+output_file="$1"
+
 needed_symbols=
 
 # Special case for modversions (see modpost.c)
@@ -41,10 +47,8 @@ cat > "$output_file" << EOT
 
 EOT
 
-[ -f modules.order ] && modlist=modules.order || modlist=/dev/null
-
 {
-	sed 's/ko$/mod/' $modlist | xargs -n1 sed -n -e '2p'
+	[ -n "${read_modorder}" ] && sed 's/ko$/usyms/' modules.order | xargs cat
 	echo "$needed_symbols"
 	[ -n "$ksym_wl" ] && cat "$ksym_wl"
 } | sed -e 's/ /\n/g' | sed -n -e '/^$/!p' |
diff --git a/scripts/mod/sumversion.c b/scripts/mod/sumversion.c
index 905c0ec291e1..0125698f2037 100644
--- a/scripts/mod/sumversion.c
+++ b/scripts/mod/sumversion.c
@@ -387,7 +387,7 @@ static int parse_source_files(const char *objfile, struct md4_ctx *md)
 /* Calc and record src checksum. */
 void get_src_version(const char *modname, char sum[], unsigned sumlen)
 {
-	char *buf, *pos, *firstline;
+	char *buf;
 	struct md4_ctx md;
 	char *fname;
 	char filelist[PATH_MAX + 1];
@@ -397,15 +397,8 @@ void get_src_version(const char *modname, char sum[], unsigned sumlen)
 
 	buf = read_text_file(filelist);
 
-	pos = buf;
-	firstline = get_line(&pos);
-	if (!firstline) {
-		warn("bad ending versions file for %s\n", modname);
-		goto free;
-	}
-
 	md4_init(&md);
-	while ((fname = strsep(&firstline, " "))) {
+	while ((fname = strsep(&buf, " \n"))) {
 		if (!*fname)
 			continue;
 		if (!(is_static_library(fname)) &&
-- 
2.32.0

