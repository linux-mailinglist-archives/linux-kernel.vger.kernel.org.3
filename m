Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D794C3C58
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 04:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237013AbiBYDYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 22:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiBYDYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 22:24:54 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13D71F6BDC;
        Thu, 24 Feb 2022 19:24:21 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0V5QtHnc_1645759451;
Received: from localhost(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0V5QtHnc_1645759451)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 25 Feb 2022 11:24:17 +0800
From:   Dan Li <ashimida@linux.alibaba.com>
To:     catalin.marinas@arm.com, will@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        masahiroy@kernel.org, tglx@linutronix.de,
        akpm@linux-foundation.org, mark.rutland@arm.com,
        samitolvanen@google.com, npiggin@gmail.com, linux@roeck-us.net,
        mhiramat@kernel.org, ojeda@kernel.org, luc.vanoostenryck@gmail.com,
        elver@google.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org,
        Dan Li <ashimida@linux.alibaba.com>
Subject: [PATCH] [PATCH v2] AARCH64: Add gcc Shadow Call Stack support
Date:   Thu, 24 Feb 2022 19:24:10 -0800
Message-Id: <20220225032410.25622-1-ashimida@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shadow call stacks will be available in GCC >= 12, this patch makes
the corresponding kernel configuration available when compiling
the kernel with the gcc.

Note that the implementation in GCC is slightly different from Clang.
With SCS enabled, functions will only pop x30 once in the epilogue,
like:

   str     x30, [x18], #8
   stp     x29, x30, [sp, #-16]!
   ......
-  ldp     x29, x30, [sp], #16	  //clang
+  ldr     x29, [sp], #16	  //GCC
   ldr     x30, [x18, #-8]!

Link: https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=ce09ab17ddd21f73ff2caf6eec3b0ee9b0e1a11e

Signed-off-by: Dan Li <ashimida@linux.alibaba.com>
---
FYI:
This function can be used to test if the shadow call stack works:
//noinline void __noscs scs_test(void)
noinline void scs_test(void)
{
    unsigned long * lr = (unsigned long *)__builtin_frame_address(0) + 1;

    asm volatile("str xzr, [%0]\n\t": : "r"(lr) : "x30");
}                                                         

ffff800008012770 <scs_test>:
ffff800008012770:       d503245f        bti     c
ffff800008012774:       d503233f        paciasp
ffff800008012778:       f800865e        str     x30, [x18], #8
ffff80000801277c:       a9bf7bfd        stp     x29, x30, [sp, #-16]!
ffff800008012780:       910003fd        mov     x29, sp
ffff800008012784:       910023a0        add     x0, x29, #0x8
ffff800008012788:       f900001f        str     xzr, [x0]
ffff80000801278c:       f85f8e5e        ldr     x30, [x18, #-8]!
ffff800008012790:       f84107fd        ldr     x29, [sp], #16
ffff800008012794:       d50323bf        autiasp
ffff800008012798:       d65f03c0        ret

If SCS protection is enabled, this function will return normally.
If the function has __noscs attribute (scs disabled), it will crash due to 0
address access.

 arch/Kconfig                 | 19 ++++++++++---------
 arch/arm64/Kconfig           |  2 +-
 include/linux/compiler-gcc.h |  4 ++++
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 678a80713b21..c92683362ac2 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -599,21 +599,22 @@ config STACKPROTECTOR_STRONG
 config ARCH_SUPPORTS_SHADOW_CALL_STACK
 	bool
 	help
-	  An architecture should select this if it supports Clang's Shadow
-	  Call Stack and implements runtime support for shadow stack
+	  An architecture should select this if it supports the compiler's
+	  Shadow Call Stack and implements runtime support for shadow stack
 	  switching.
 
 config SHADOW_CALL_STACK
-	bool "Clang Shadow Call Stack"
-	depends on CC_IS_CLANG && ARCH_SUPPORTS_SHADOW_CALL_STACK
+	bool "Shadow Call Stack"
+	depends on ARCH_SUPPORTS_SHADOW_CALL_STACK
 	depends on DYNAMIC_FTRACE_WITH_REGS || !FUNCTION_GRAPH_TRACER
 	help
-	  This option enables Clang's Shadow Call Stack, which uses a
-	  shadow stack to protect function return addresses from being
-	  overwritten by an attacker. More information can be found in
-	  Clang's documentation:
+	  This option enables the compiler's Shadow Call Stack, which
+	  uses a shadow stack to protect function return addresses from
+	  being overwritten by an attacker. More information can be found
+	  in the compiler's documentation:
 
-	    https://clang.llvm.org/docs/ShadowCallStack.html
+	  - Clang (https://clang.llvm.org/docs/ShadowCallStack.html)
+	  - GCC (https://gcc.gnu.org/onlinedocs/gcc/Instrumentation-Options.html#Instrumentation-Options)
 
 	  Note that security guarantees in the kernel differ from the
 	  ones documented for user space. The kernel must store addresses
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 09b885cc4db5..b7145337efae 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1255,7 +1255,7 @@ config HW_PERF_EVENTS
 config ARCH_HAS_FILTER_PGPROT
 	def_bool y
 
-# Supported by clang >= 7.0
+# Supported by clang >= 7.0 or GCC >= 12.0.0
 config CC_HAVE_SHADOW_CALL_STACK
 	def_bool $(cc-option, -fsanitize=shadow-call-stack -ffixed-x18)
 
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index ccbbd31b3aae..deff5b308470 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -97,6 +97,10 @@
 #define KASAN_ABI_VERSION 4
 #endif
 
+#ifdef CONFIG_SHADOW_CALL_STACK
+#define __noscs __attribute__((__no_sanitize__("shadow-call-stack")))
+#endif
+
 #if __has_attribute(__no_sanitize_address__)
 #define __no_sanitize_address __attribute__((no_sanitize_address))
 #else
-- 
2.17.1

