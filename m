Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52E7536D9E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 17:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351005AbiE1PtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 11:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344876AbiE1PtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 11:49:14 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840F412A;
        Sat, 28 May 2022 08:49:11 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 24SFlthN010610;
        Sun, 29 May 2022 00:47:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 24SFlthN010610
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653752878;
        bh=5leKPORFlta7S8/2ppM4PVrBXwYq/YHCsbo5q5GZZGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YVczqZLK4g5wTY9Zadm4ebIhkk1uqTE+rV5SA6qD97oyeL9tcX+GdHlD4skCKnK31
         02fuOs9PiJFaF+x8fUtmWzZrDsUxfkYEi26YF1zt3X3ya7hBqrK0L155wyyijZIFx5
         /+cOMffA7wD7gyvhu0n3EK84jplYza5HQswZmyWhWLIa6od8L/LxJmgXCTS6hR5hWd
         dM0yGJTCZEnCC5gACR1gf0coCzB3dZr3Nnn8YLaN73H3RzkwwOhp2QEIhncbcysXFl
         JFf03uoZdyY7FKBw7xORc3D5oNtgbsUb4Wz/A3Hpi7qQ3lpY76RALE481k5yaBrsqg
         gLmkUxeVSNnlA==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH 4/4] kbuild: factor out the common objtool arguments
Date:   Sun, 29 May 2022 00:47:04 +0900
Message-Id: <20220528154704.2576290-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220528154704.2576290-1-masahiroy@kernel.org>
References: <20220528154704.2576290-1-masahiroy@kernel.org>
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

scripts/Makefile.build and scripts/link-vmlinux.sh have similar setups
for the objtool arguments.

It is difficult to factor out them because the vmlinux build rule is
written in a shell script. It is somewhat tedious to touch the two
files every time a new objtool option is supported.

To reduce the code duplication, implement everything about objtool in
Makefile.

Move the objtool for vmlinux.o into scripts/Makefile.vmlinux_o.

Move the common macros to Makefile.lib so they are shared by
Makefile.build and Makefile.vmlinux_o.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.build     | 26 --------------
 scripts/Makefile.lib       | 26 ++++++++++++++
 scripts/Makefile.vmlinux_o | 26 ++++++++++++++
 scripts/link-vmlinux.sh    | 71 --------------------------------------
 4 files changed, 52 insertions(+), 97 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 4cb7145071b9..1f01ac65c0cd 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -210,38 +210,12 @@ cmd_record_mcount = $(if $(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags)),
 	$(sub_cmd_record_mcount))
 endif # CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT
 
-ifdef CONFIG_OBJTOOL
-
-objtool := $(objtree)/tools/objtool/objtool
-
-objtool_args =								\
-	$(if $(CONFIG_HAVE_JUMP_LABEL_HACK), --hacks=jump_label)	\
-	$(if $(CONFIG_HAVE_NOINSTR_HACK), --hacks=noinstr)		\
-	$(if $(CONFIG_X86_KERNEL_IBT), --ibt)				\
-	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
-	$(if $(CONFIG_UNWINDER_ORC), --orc)				\
-	$(if $(CONFIG_RETPOLINE), --retpoline)				\
-	$(if $(CONFIG_SLS), --sls)					\
-	$(if $(CONFIG_STACK_VALIDATION), --stackval)			\
-	$(if $(CONFIG_HAVE_STATIC_CALL_INLINE), --static-call)		\
-	--uaccess							\
-	$(if $(delay-objtool), --link)					\
-	$(if $(part-of-module), --module)				\
-	$(if $(CONFIG_GCOV_KERNEL), --no-unreachable)
-
-cmd_objtool = $(if $(objtool-enabled), ; $(objtool) $(objtool_args) $@)
-cmd_gen_objtooldep = $(if $(objtool-enabled), { echo ; echo '$@: $$(wildcard $(objtool))' ; } >> $(dot-target).cmd)
-
-endif # CONFIG_OBJTOOL
-
 # 'OBJECT_FILES_NON_STANDARD := y': skip objtool checking for a directory
 # 'OBJECT_FILES_NON_STANDARD_foo.o := 'y': skip objtool checking for a file
 # 'OBJECT_FILES_NON_STANDARD_foo.o := 'n': override directory skip for a file
 
 is-standard-object = $(if $(filter-out y%, $(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)n),y)
 
-delay-objtool := $(or $(CONFIG_LTO_CLANG),$(CONFIG_X86_KERNEL_IBT))
-
 $(obj)/%.o: objtool-enabled = $(if $(is-standard-object),$(if $(delay-objtool),$(is-single-obj-m),y))
 
 ifdef CONFIG_TRIM_UNUSED_KSYMS
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index f75138385449..f691fb231ce5 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -225,6 +225,32 @@ dtc_cpp_flags  = -Wp,-MMD,$(depfile).pre.tmp -nostdinc                    \
 		 $(addprefix -I,$(DTC_INCLUDE))                          \
 		 -undef -D__DTS__
 
+ifdef CONFIG_OBJTOOL
+
+objtool := $(objtree)/tools/objtool/objtool
+
+objtool_args =								\
+	$(if $(CONFIG_HAVE_JUMP_LABEL_HACK), --hacks=jump_label)	\
+	$(if $(CONFIG_HAVE_NOINSTR_HACK), --hacks=noinstr)		\
+	$(if $(CONFIG_X86_KERNEL_IBT), --ibt)				\
+	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
+	$(if $(CONFIG_UNWINDER_ORC), --orc)				\
+	$(if $(CONFIG_RETPOLINE), --retpoline)				\
+	$(if $(CONFIG_SLS), --sls)					\
+	$(if $(CONFIG_STACK_VALIDATION), --stackval)			\
+	$(if $(CONFIG_HAVE_STATIC_CALL_INLINE), --static-call)		\
+	--uaccess							\
+	$(if $(delay-objtool), --link)					\
+	$(if $(part-of-module), --module)				\
+	$(if $(CONFIG_GCOV_KERNEL), --no-unreachable)
+
+delay-objtool := $(or $(CONFIG_LTO_CLANG),$(CONFIG_X86_KERNEL_IBT))
+
+cmd_objtool = $(if $(objtool-enabled), ; $(objtool) $(objtool_args) $@)
+cmd_gen_objtooldep = $(if $(objtool-enabled), { echo ; echo '$@: $$(wildcard $(objtool))' ; } >> $(dot-target).cmd)
+
+endif # CONFIG_OBJTOOL
+
 # Useful for describing the dependency of composite objects
 # Usage:
 #   $(call multi_depend, multi_used_targets, suffix_to_remove, suffix_to_add)
diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index a9b375ca86d5..3c97a1564947 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -6,6 +6,9 @@ __default: vmlinux.o
 include include/config/auto.conf
 include $(srctree)/scripts/Kbuild.include
 
+# for objtool
+include $(srctree)/scripts/Makefile.lib
+
 # Generate a linker script to ensure correct ordering of initcalls for Clang LTO
 # ---------------------------------------------------------------------------
 
@@ -24,6 +27,27 @@ ifdef CONFIG_LTO_CLANG
 initcalls-lds := .tmp_initcalls.lds
 endif
 
+# objtool for vmlinux.o
+# ---------------------------------------------------------------------------
+#
+# For LTO and IBT, objtool doesn't run on individual translation units.
+# Run everything on vmlinux instead.
+
+objtool-enabled := $(or $(delay-objtool),$(CONFIG_NOINSTR_VALIDATION))
+
+# Reuse objtool_args defined in scripts/Makefile.lib if LTO or IBT is enabled.
+#
+# Add some more flags as needed.
+# --no-unreachable and --link might be added twice, but it is fine.
+#
+# Expand objtool_args to a simple variable to avoid circular reference.
+
+objtool_args := \
+	$(if $(delay-objtool),$(objtool_args)) \
+	$(if $(CONFIG_NOINSTR_VALIDATION), --noinstr) \
+	$(if $(CONFIG_GCOV_KERNEL), --no-unreachable) \
+	--link
+
 # Link of vmlinux.o used for section mismatch analysis
 # ---------------------------------------------------------------------------
 
@@ -33,9 +57,11 @@ quiet_cmd_ld_vmlinux.o = LD      $@
 	$(addprefix -T , $(initcalls-lds)) \
 	--whole-archive $(KBUILD_VMLINUX_OBJS) --no-whole-archive \
 	--start-group $(KBUILD_VMLINUX_LIBS) --end-group \
+	$(cmd_objtool)
 
 define rule_ld_vmlinux.o
 	$(call cmd_and_savecmd,ld_vmlinux.o)
+	$(call cmd,gen_objtooldep)
 endef
 
 vmlinux.o: $(initcalls-lds) $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS) FORCE
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 90680b6bd710..1ac4e180fa3f 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -45,76 +45,6 @@ info()
 	printf "  %-7s %s\n" "${1}" "${2}"
 }
 
-objtool_link()
-{
-	local objtoolcmd;
-	local objtoolopt;
-
-	if ! is_enabled CONFIG_OBJTOOL; then
-		return;
-	fi
-
-	if is_enabled CONFIG_LTO_CLANG || is_enabled CONFIG_X86_KERNEL_IBT; then
-
-		# For LTO and IBT, objtool doesn't run on individual
-		# translation units.  Run everything on vmlinux instead.
-
-		if is_enabled CONFIG_HAVE_JUMP_LABEL_HACK; then
-			objtoolopt="${objtoolopt} --hacks=jump_label"
-		fi
-
-		if is_enabled CONFIG_HAVE_NOINSTR_HACK; then
-			objtoolopt="${objtoolopt} --hacks=noinstr"
-		fi
-
-		if is_enabled CONFIG_X86_KERNEL_IBT; then
-			objtoolopt="${objtoolopt} --ibt"
-		fi
-
-		if is_enabled CONFIG_FTRACE_MCOUNT_USE_OBJTOOL; then
-			objtoolopt="${objtoolopt} --mcount"
-		fi
-
-		if is_enabled CONFIG_UNWINDER_ORC; then
-			objtoolopt="${objtoolopt} --orc"
-		fi
-
-		if is_enabled CONFIG_RETPOLINE; then
-			objtoolopt="${objtoolopt} --retpoline"
-		fi
-
-		if is_enabled CONFIG_SLS; then
-			objtoolopt="${objtoolopt} --sls"
-		fi
-
-		if is_enabled CONFIG_STACK_VALIDATION; then
-			objtoolopt="${objtoolopt} --stackval"
-		fi
-
-		if is_enabled CONFIG_HAVE_STATIC_CALL_INLINE; then
-			objtoolopt="${objtoolopt} --static-call"
-		fi
-
-		objtoolopt="${objtoolopt} --uaccess"
-	fi
-
-	if is_enabled CONFIG_NOINSTR_VALIDATION; then
-		objtoolopt="${objtoolopt} --noinstr"
-	fi
-
-	if [ -n "${objtoolopt}" ]; then
-
-		if is_enabled CONFIG_GCOV_KERNEL; then
-			objtoolopt="${objtoolopt} --no-unreachable"
-		fi
-
-		objtoolopt="${objtoolopt} --link"
-
-		info OBJTOOL ${1}
-		tools/objtool/objtool ${objtoolopt} ${1}
-	fi
-}
-
 # Link of vmlinux
 # ${1} - output file
 # ${2}, ${3}, ... - optional extra .o files
@@ -298,7 +228,6 @@ ${MAKE} -f "${srctree}/scripts/Makefile.build" obj=init need-builtin=1
 
 #link vmlinux.o
 ${MAKE} -f "${srctree}/scripts/Makefile.vmlinux_o"
-objtool_link vmlinux.o
 
 # Generate the list of objects in vmlinux
 for f in ${KBUILD_VMLINUX_OBJS} ${KBUILD_VMLINUX_LIBS}; do
-- 
2.32.0

