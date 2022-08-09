Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E2A58E373
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiHIW5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiHIW5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:57:06 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5279E51A11;
        Tue,  9 Aug 2022 15:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=edVxyr423oZ8eji5jKyoqmmfbB+pc4gAM9RMUae1Dto=; b=LpQcDYU/3F7Iy9NfCPcFfpyNb+
        hVKw8Htc6GlIZFh9xN6vswp6mGCo1Odb2oINjPnuPLiuFtT3yC+leJ00zoDGOtPya8Rbkx38MUzip
        +8RHfiZSK/tFbM5UNdSxyZhAPizStbYzUNPhW7GOHHbIGMupJ9k5ciFbg49+VdD49OMKRk8rNjly5
        PkfMYdb+kuSEV89yrJgwtn9Wg27JzmklGnZL11yjwK64Xs6T9p02OW/X4IG0uYkBTIo9M9/GQEO0I
        kRlSHEMbj15jiRmi9GCSKIm357arVCmE8oUXXgXA1mQ6MHWs9sL8zW2POqlHNLmoQj0NC1Xgqd8HB
        9yXph8Gw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oLY9m-002w8U-TG;
        Tue, 09 Aug 2022 22:57:03 +0000
Date:   Tue, 9 Aug 2022 23:57:02 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [kconfig][RFC] getting things like CONFIG_ARCH_HAS_SYSCALL_WRAPPER
 without bothering with selects
Message-ID: <YvLmPl8sgR2q3WgE@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Sometimes we have situations when we want linux/foo.h
include asm/bar.h if the latter exists; one example is
includes of asm/syscall_wrapper.h.  Right now there are two
ways to do that:
	1) ARCH_HAS_BAR_H, explicitly selected by architectures
that have asm/bar.h and include guarded by #ifdef CONFIG_ARCH_HAS_BAR_H
	2) include/asm-default/bar.h, either empty or with
something like #define __ARCH_HAS_NO_BAR_H, with mandatory-y += bar.h
in include/asm-generic/Kbuild and unconditional includes of asm/bar.h,
possibly followed by #ifdef __ARCH_HAS_NO_BAR_H ... #endif

However, kconfig could do (1) without selects - something like
bool ARCH_HAS_BAR_H
	def_bool $(header-exists,bar.h)

Does anybody see problems with the patch below?

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1652a9800ebe..277437f329ce 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -42,7 +42,6 @@ config ARM64
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
-	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_TEARDOWN_DMA_OPS if IOMMU_SUPPORT
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_VM_GET_PAGE_PROT
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 91c0b80a8bf0..86e905b8462c 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -78,7 +78,6 @@ config S390
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
-	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAS_VDSO_DATA
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index be0b95e51df6..64592d027a0d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -92,7 +92,6 @@ config X86
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
-	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_HAS_DEBUG_WX
diff --git a/init/Kconfig b/init/Kconfig
index c7900e8975f1..ce88397c4e46 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2257,4 +2257,4 @@ config ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 # kernel/time/posix-stubs.c. All these overrides need to be available in
 # <asm/syscall_wrapper.h>.
 config ARCH_HAS_SYSCALL_WRAPPER
-	def_bool n
+	def_bool $(header-exists,syscall_wrapper.h)
diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
index 0496efd6e117..465bb836f82a 100644
--- a/scripts/Kconfig.include
+++ b/scripts/Kconfig.include
@@ -23,6 +23,10 @@ success = $(if-success,$(1),y,n)
 # Return n if <command> exits with 0, y otherwise
 failure = $(if-success,$(1),n,y)
 
+# $(header-exists,<header>)
+# Return y if arch/$(ARCH)/include/asm/<header> exists, n otherwise
+header-exists = $(success,test -e $(srctree)/arch/$(ARCH)/include/asm/$(1))
+
 # $(cc-option,<flag>)
 # Return y if the compiler supports <flag>, n otherwise
 cc-option = $(success,mkdir .tmp_$$$$; trap "rm -rf .tmp_$$$$" EXIT; $(CC) -Werror $(CLANG_FLAGS) $(1) -c -x c /dev/null -o .tmp_$$$$/tmp.o)
