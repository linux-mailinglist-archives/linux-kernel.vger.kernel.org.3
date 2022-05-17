Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6E052A45D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348471AbiEQOKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243867AbiEQOKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:10:36 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B30F4C79F
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:10:35 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 06B7D3F164
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1652796634;
        bh=yOmIQV7BcBAp90/q1B0jTphrdJB1/ISskz5/i7iqJeg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=iaXu4Ok1pYDxewMHem2S/cFWEHujfDoPtjuEdYUg8/U06ju6JN+XwhofUVuOi+gx3
         jPk6m/4U/nYiQQUtja5voaOfUGDumSA6Lm5rXcQRl/09tsYtEOpB+E5j8+WsEkOoWk
         EYHTQrJan90J2bIKcYk52m39JwCNde0aA9CmqXutAFh8ZI174+KXhSR49cELyG2trE
         VNyAIZZI97dyIM4wFLyEE7F8oP9ieK5ey0HY2Xe7OyyCH8Z5ALcdmsTcM4WNTV1jRU
         acz86J4WqfWvjqmhPEMZ86y5reMFTm/r/7dfSnfu5YPo1XcE00mJEj7V3bnStJ9+K5
         XeOHegvv8Y2YA==
Received: by mail-ej1-f70.google.com with SMTP id nb10-20020a1709071c8a00b006e8f89863ceso7449314ejc.18
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yOmIQV7BcBAp90/q1B0jTphrdJB1/ISskz5/i7iqJeg=;
        b=uHh0TMiuL9XYTQsZQkkoyOU6qw2NBH8eLrYwOTMVToOZSQgdROFMtu8ZypWbJFa3Or
         NVRX/mHXRtStMlEbp5JlJvSCDSlF/plQa/BrHn6eRBin/hU8HScf4x9s7F6DNbKrW2uB
         liyDKuGsO64NIFSK5ezTdsK6reo5nbS/tq0RsRMGqzVfaJhfm0LrM3yED5zsApR9cpBu
         zoI3Obbq7elK3mVyH7/VnRpl/29afcARz1g0s7ZjwVxGABJt/bzI3rSYDyW7QbqkMQ2Y
         6ogsafJJxCROlwEPrdW+41V97XaUhex+bnniwY42KxNzTQgk/6R4b2conPVFipnMuEGN
         MSOQ==
X-Gm-Message-State: AOAM53348qFwtI8/713aGh4tlVl+Ox+egMlNv7pJ/FCmHwDe+DwKXTbj
        SQbLKTjzTE4XUZ6rEN752DfusRBpAzk7xKX6aMm8PE167imj4a33scMH2d8+zW4fQ2jFKvGrnE+
        nqqX9WAGDnxFjJNiAofKTC3rx0QQeNm7GGaDj1xAHjQ==
X-Received: by 2002:a05:6402:50c7:b0:427:c764:9331 with SMTP id h7-20020a05640250c700b00427c7649331mr18762438edb.228.1652796633633;
        Tue, 17 May 2022 07:10:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx09WCsBFqGzeCNao834/cLQzbbihNanQhAUe+x69haYCImPCV9At3gxnQBC/+eCh3es8RjGw==
X-Received: by 2002:a05:6402:50c7:b0:427:c764:9331 with SMTP id h7-20020a05640250c700b00427c7649331mr18762414edb.228.1652796633398;
        Tue, 17 May 2022 07:10:33 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id o23-20020a50fd97000000b0042aaaf3f41csm4373017edt.4.2022.05.17.07.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 07:10:32 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        llvm@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH] ARM: Kconfig: Fix indentation and add comments
Date:   Tue, 17 May 2022 16:10:24 +0200
Message-Id: <20220517141024.331475-1-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

While add it, add trailing comments to endmenu statements for better
readability.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 arch/Kconfig | 130 +++++++++++++++++++++++++--------------------------
 1 file changed, 65 insertions(+), 65 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 31c4fdc4a4ba..65091088b1fd 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -28,7 +28,7 @@ config HOTPLUG_SMT
 	bool
 
 config GENERIC_ENTRY
-       bool
+	bool
 
 config KPROBES
 	bool "Kprobes"
@@ -47,26 +47,26 @@ config JUMP_LABEL
 	depends on HAVE_ARCH_JUMP_LABEL
 	depends on CC_HAS_ASM_GOTO
 	help
-	 This option enables a transparent branch optimization that
-	 makes certain almost-always-true or almost-always-false branch
-	 conditions even cheaper to execute within the kernel.
+	  This option enables a transparent branch optimization that
+	  makes certain almost-always-true or almost-always-false branch
+	  conditions even cheaper to execute within the kernel.
 
-	 Certain performance-sensitive kernel code, such as trace points,
-	 scheduler functionality, networking code and KVM have such
-	 branches and include support for this optimization technique.
+	  Certain performance-sensitive kernel code, such as trace points,
+	  scheduler functionality, networking code and KVM have such
+	  branches and include support for this optimization technique.
 
-	 If it is detected that the compiler has support for "asm goto",
-	 the kernel will compile such branches with just a nop
-	 instruction. When the condition flag is toggled to true, the
-	 nop will be converted to a jump instruction to execute the
-	 conditional block of instructions.
+	  If it is detected that the compiler has support for "asm goto",
+	  the kernel will compile such branches with just a nop
+	  instruction. When the condition flag is toggled to true, the
+	  nop will be converted to a jump instruction to execute the
+	  conditional block of instructions.
 
-	 This technique lowers overhead and stress on the branch prediction
-	 of the processor and generally makes the kernel faster. The update
-	 of the condition is slower, but those are always very rare.
+	  This technique lowers overhead and stress on the branch prediction
+	  of the processor and generally makes the kernel faster. The update
+	  of the condition is slower, but those are always very rare.
 
-	 ( On 32-bit x86, the necessary options added to the compiler
-	   flags may increase the size of the kernel slightly. )
+	  ( On 32-bit x86, the necessary options added to the compiler
+	    flags may increase the size of the kernel slightly. )
 
 config STATIC_KEYS_SELFTEST
 	bool "Static key selftest"
@@ -90,9 +90,9 @@ config KPROBES_ON_FTRACE
 	depends on KPROBES && HAVE_KPROBES_ON_FTRACE
 	depends on DYNAMIC_FTRACE_WITH_REGS
 	help
-	 If function tracer is enabled and the arch supports full
-	 passing of pt_regs to function tracing, then kprobes can
-	 optimize on top of function tracing.
+	  If function tracer is enabled and the arch supports full
+	  passing of pt_regs to function tracing, then kprobes can
+	  optimize on top of function tracing.
 
 config UPROBES
 	def_bool n
@@ -146,21 +146,21 @@ config HAVE_EFFICIENT_UNALIGNED_ACCESS
 config ARCH_USE_BUILTIN_BSWAP
 	bool
 	help
-	 Modern versions of GCC (since 4.4) have builtin functions
-	 for handling byte-swapping. Using these, instead of the old
-	 inline assembler that the architecture code provides in the
-	 __arch_bswapXX() macros, allows the compiler to see what's
-	 happening and offers more opportunity for optimisation. In
-	 particular, the compiler will be able to combine the byteswap
-	 with a nearby load or store and use load-and-swap or
-	 store-and-swap instructions if the architecture has them. It
-	 should almost *never* result in code which is worse than the
-	 hand-coded assembler in <asm/swab.h>.  But just in case it
-	 does, the use of the builtins is optional.
+	  Modern versions of GCC (since 4.4) have builtin functions
+	  for handling byte-swapping. Using these, instead of the old
+	  inline assembler that the architecture code provides in the
+	  __arch_bswapXX() macros, allows the compiler to see what's
+	  happening and offers more opportunity for optimisation. In
+	  particular, the compiler will be able to combine the byteswap
+	  with a nearby load or store and use load-and-swap or
+	  store-and-swap instructions if the architecture has them. It
+	  should almost *never* result in code which is worse than the
+	  hand-coded assembler in <asm/swab.h>.  But just in case it
+	  does, the use of the builtins is optional.
 
-	 Any architecture with load-and-swap or store-and-swap
-	 instructions should set this. And it shouldn't hurt to set it
-	 on architectures that don't have such instructions.
+	  Any architecture with load-and-swap or store-and-swap
+	  instructions should set this. And it shouldn't hurt to set it
+	  on architectures that don't have such instructions.
 
 config KRETPROBES
 	def_bool y
@@ -686,13 +686,13 @@ config LTO_CLANG_FULL
 	depends on !COMPILE_TEST
 	select LTO_CLANG
 	help
-          This option enables Clang's full Link Time Optimization (LTO), which
-          allows the compiler to optimize the kernel globally. If you enable
-          this option, the compiler generates LLVM bitcode instead of ELF
-          object files, and the actual compilation from bitcode happens at
-          the LTO link step, which may take several minutes depending on the
-          kernel configuration. More information can be found from LLVM's
-          documentation:
+	  This option enables Clang's full Link Time Optimization (LTO), which
+	  allows the compiler to optimize the kernel globally. If you enable
+	  this option, the compiler generates LLVM bitcode instead of ELF
+	  object files, and the actual compilation from bitcode happens at
+	  the LTO link step, which may take several minutes depending on the
+	  kernel configuration. More information can be found from LLVM's
+	  documentation:
 
 	    https://llvm.org/docs/LinkTimeOptimization.html
 
@@ -1284,9 +1284,9 @@ config ARCH_HAS_CC_PLATFORM
 	bool
 
 config HAVE_SPARSE_SYSCALL_NR
-       bool
-       help
-          An architecture should select this if its syscall numbering is sparse
+	bool
+	help
+	  An architecture should select this if its syscall numbering is sparse
 	  to save space. For example, MIPS architecture has a syscall array with
 	  entries at 4000, 5000 and 6000 locations. This option turns on syscall
 	  related optimizations for a given architecture.
@@ -1309,35 +1309,35 @@ config HAVE_PREEMPT_DYNAMIC_CALL
 	depends on HAVE_STATIC_CALL
 	select HAVE_PREEMPT_DYNAMIC
 	help
-	   An architecture should select this if it can handle the preemption
-	   model being selected at boot time using static calls.
+	  An architecture should select this if it can handle the preemption
+	  model being selected at boot time using static calls.
 
-	   Where an architecture selects HAVE_STATIC_CALL_INLINE, any call to a
-	   preemption function will be patched directly.
+	  Where an architecture selects HAVE_STATIC_CALL_INLINE, any call to a
+	  preemption function will be patched directly.
 
-	   Where an architecture does not select HAVE_STATIC_CALL_INLINE, any
-	   call to a preemption function will go through a trampoline, and the
-	   trampoline will be patched.
+	  Where an architecture does not select HAVE_STATIC_CALL_INLINE, any
+	  call to a preemption function will go through a trampoline, and the
+	  trampoline will be patched.
 
-	   It is strongly advised to support inline static call to avoid any
-	   overhead.
+	  It is strongly advised to support inline static call to avoid any
+	  overhead.
 
 config HAVE_PREEMPT_DYNAMIC_KEY
 	bool
 	depends on HAVE_ARCH_JUMP_LABEL && CC_HAS_ASM_GOTO
 	select HAVE_PREEMPT_DYNAMIC
 	help
-	   An architecture should select this if it can handle the preemption
-	   model being selected at boot time using static keys.
+	  An architecture should select this if it can handle the preemption
+	  model being selected at boot time using static keys.
 
-	   Each preemption function will be given an early return based on a
-	   static key. This should have slightly lower overhead than non-inline
-	   static calls, as this effectively inlines each trampoline into the
-	   start of its callee. This may avoid redundant work, and may
-	   integrate better with CFI schemes.
+	  Each preemption function will be given an early return based on a
+	  static key. This should have slightly lower overhead than non-inline
+	  static calls, as this effectively inlines each trampoline into the
+	  start of its callee. This may avoid redundant work, and may
+	  integrate better with CFI schemes.
 
-	   This will have greater overhead than using inline static calls as
-	   the call to the preemption function cannot be entirely elided.
+	  This will have greater overhead than using inline static calls as
+	  the call to the preemption function cannot be entirely elided.
 
 config ARCH_WANT_LD_ORPHAN_WARN
 	bool
@@ -1360,8 +1360,8 @@ config ARCH_SUPPORTS_PAGE_TABLE_CHECK
 config ARCH_SPLIT_ARG64
 	bool
 	help
-	   If a 32-bit architecture requires 64-bit arguments to be split into
-	   pairs of 32-bit arguments, select this option.
+	  If a 32-bit architecture requires 64-bit arguments to be split into
+	  pairs of 32-bit arguments, select this option.
 
 config ARCH_HAS_ELFCORE_COMPAT
 	bool
@@ -1380,4 +1380,4 @@ source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
 
-endmenu
+endmenu # "General architecture-dependent options"
-- 
2.32.0

