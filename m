Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918325A38D8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 18:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbiH0Qnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 12:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiH0Qno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 12:43:44 -0400
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FB3474D6;
        Sat, 27 Aug 2022 09:43:43 -0700 (PDT)
Received: from localhost.localdomain (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 27RGfBPI000611;
        Sun, 28 Aug 2022 01:41:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 27RGfBPI000611
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1661618473;
        bh=+GhN5QiWk8VZrsPB7KRVM8ziElAEYMkGxB8N3aqbfbA=;
        h=From:To:Cc:Subject:Date:From;
        b=wow0twov1tOYfhfBWw3b+32Zrm/G3bdf9F7iFroPW/Z6t0so1GOsdJXwBfs3ovRM9
         7WRVpZuCLVm+8mx5OiE57OGePMReAnAsUp2hUhH15ybhqWrfyjh0Coawe5jgqKJW1H
         13KMbG8bkA6YoQ/m3kDNbF1lkRtD3SyhiBAKzQBibFpl0tNwLs0O6fkUbejiXPthqE
         WHTGpbRnkWJ9i4oACKbUzmbl0q9c0ZuS4+/Ps14O7b1ZTxc43XugUsz5gGPY3pxRAw
         LVG1/EBV7B9JOCktDqG35C5IqSJgUr4T2cBX/u+8xRh/KX0F7ZEirwZPAGo3VquVou
         Abyatq9iw6TKQ==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Cc:     linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Daniel Axtens <dja@axtens.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: clean up binutils version check
Date:   Sun, 28 Aug 2022 01:40:56 +0900
Message-Id: <20220827164056.3365356-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
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

The checkbin in arch/powerpc/Makefile errors out if ld <= 2.24.
So, the requirement on PPC is binutils >= 2.25. It is cleaner to
specify it in scripts/min-tool-version.sh. If binutils < 2.25 is
used, the toolchain check will fail in the Kconfig stage going
forward.

Since binutils >= 2.25 is already required, another version test
for --save-restore-funcs on PPC64 is always met.

PPC is the last user of ld-ifversion. With all the callers removed,
the macro definition in scripts/Makefile.compiler can go away.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/powerpc/Makefile       | 21 ---------------------
 arch/powerpc/lib/Makefile   |  8 --------
 scripts/Makefile.compiler   |  4 ----
 scripts/min-tool-version.sh |  8 +++++++-
 4 files changed, 7 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 02742facf895..fb607758eeca 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -46,13 +46,7 @@ UTS_MACHINE := $(subst $(space),,$(machine-y))
 ifdef CONFIG_PPC32
 KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
 else
-ifeq ($(call ld-ifversion, -ge, 22500, y),y)
-# Have the linker provide sfpr if possible.
-# There is a corresponding test in arch/powerpc/lib/Makefile
 KBUILD_LDFLAGS_MODULE += --save-restore-funcs
-else
-KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
-endif
 endif
 
 ifdef CONFIG_CPU_LITTLE_ENDIAN
@@ -395,8 +389,6 @@ vdso_prepare: prepare0
 		$(build)=arch/powerpc/kernel/vdso include/generated/vdso64-offsets.h)
 endif
 
-archprepare: checkbin
-
 archheaders:
 	$(Q)$(MAKE) $(build)=arch/powerpc/kernel/syscalls all
 
@@ -411,16 +403,3 @@ else
 	$(eval KBUILD_CFLAGS += -mstack-protector-guard-offset=$(shell awk '{if ($$2 == "TASK_CANARY") print $$3;}' include/generated/asm-offsets.h))
 endif
 endif
-
-PHONY += checkbin
-# Check toolchain versions:
-# - gcc-4.6 is the minimum kernel-wide version so nothing required.
-checkbin:
-	@if test "x${CONFIG_LD_IS_LLD}" != "xy" -a \
-		"x$(call ld-ifversion, -le, 22400, y)" = "xy" ; then \
-		echo -n '*** binutils 2.24 miscompiles weak symbols ' ; \
-		echo 'in some circumstances.' ; \
-		echo    '*** binutils 2.23 do not define the TOC symbol ' ; \
-		echo -n '*** Please use a different binutils version.' ; \
-		false ; \
-	fi
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 8560c912186d..5eb3971ccb9c 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -38,14 +38,6 @@ obj-$(CONFIG_PPC32)	+= div64.o copy_32.o crtsavres.o
 
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION)	+= error-inject.o
 
-# See corresponding test in arch/powerpc/Makefile
-# 64-bit linker creates .sfpr on demand for final link (vmlinux),
-# so it is only needed for modules, and only for older linkers which
-# do not support --save-restore-funcs
-ifeq ($(call ld-ifversion, -lt, 22500, y),y)
-extra-$(CONFIG_PPC64)	+= crtsavres.o
-endif
-
 obj-$(CONFIG_PPC_BOOK3S_64) += copyuser_power7.o copypage_power7.o \
 			       memcpy_power7.o restart_table.o
 
diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
index 94d0d40cddb3..63e7d79dd877 100644
--- a/scripts/Makefile.compiler
+++ b/scripts/Makefile.compiler
@@ -68,7 +68,3 @@ cc-ifversion = $(shell [ $(CONFIG_GCC_VERSION)0 $(1) $(2)000 ] && echo $(3) || e
 # ld-option
 # Usage: KBUILD_LDFLAGS += $(call ld-option, -X, -Y)
 ld-option = $(call try-run, $(LD) $(KBUILD_LDFLAGS) $(1) -v,$(1),$(2),$(3))
-
-# ld-ifversion
-# Usage:  $(call ld-ifversion, -ge, 22252, y)
-ld-ifversion = $(shell [ $(CONFIG_LD_VERSION)0 $(1) $(2)0 ] && echo $(3) || echo $(4))
diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
index 250925aab101..7df9f2150ea1 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -14,7 +14,13 @@ fi
 
 case "$1" in
 binutils)
-	echo 2.23.0
+	if [ "$SRCARCH" = powerpc ]; then
+		# binutils 2.24 miscompiles weak symbols in some circumstances
+		# binutils 2.23 do not define the TOC symbol
+		echo 2.25.0
+	else
+		echo 2.23.0
+	fi
 	;;
 gcc)
 	echo 5.1.0
-- 
2.34.1

