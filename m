Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3300D5A6CD0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiH3TKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiH3TKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:10:32 -0400
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC37925C74
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 12:10:30 -0700 (PDT)
Received: from grover.sesame (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 27UJ8ZDM014149;
        Wed, 31 Aug 2022 04:08:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 27UJ8ZDM014149
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1661886516;
        bh=t6DIbr1IDWpT0lqcKO3t7PGRcyr9N1NHL0EgAGmnfbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c5L6Tcp9xyYkrBi2N0bkaidBeq2lHcIOWncoXMDzNLVc9vAvKt7GOCjYcOxy+EKGd
         KoVN0wcbRvZaWaaBnf5/T0ZuH7cv6g0J2ClDzfGMFsJ/FpJW0byn9A17A0paX1NrQ3
         nJoEuHhnE4wtiOkK3y99dqMgwfNGW7h5T7sXFVoKYieB4DufV5W3x5cRb1j9Lnwqwm
         k7+n7GmLHJqI23M7xbcW/wQPx2PTc0wG7LwjtG4uCpOV553Z1QsDhdnI6xwjkpwvaa
         3ZBxTsAGPzIh/z6FrHtJRVWtddmfnR6WP6jjg11YwJXy31MzunwBqM9xBtz1D/A79z
         slz6SgdtEj3Jg==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/2] powerpc: remove old code for binutils < 2.25
Date:   Wed, 31 Aug 2022 04:08:11 +0900
Message-Id: <20220830190811.323760-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220830190811.323760-1-masahiroy@kernel.org>
References: <20220830190811.323760-1-masahiroy@kernel.org>
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

The minimum supported version of binutils has been raised to 2.25.1.
Drop the old code.

PPC is the last user of ld-ifversion. With all the callers removed,
the macro definition in scripts/Makefile.compiler can go away.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/powerpc/Makefile     | 21 ---------------------
 arch/powerpc/lib/Makefile |  8 --------
 scripts/Makefile.compiler |  4 ----
 3 files changed, 33 deletions(-)

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
-- 
2.34.1

