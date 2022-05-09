Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6648C5204FA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 21:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240434AbiEITLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 15:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240409AbiEITLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 15:11:21 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F76D299554
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 12:07:26 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652123244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BhK1H3z2+ketkqp1P4tC+AWEWt56i9Blt1MkSXijGcg=;
        b=bftOT1PvyHkYOE23vuQLyxrSngQURm20m3FRrBKqH+wvVgBhN7ZgNdudkMkF1idLHPCHcp
        tiNo2gP8dQDVVxL9H6s9cF/GzELp64ssO5uAZ5rPchdVlS02o2CpuWoeZxF2ljhhNjsw/l
        NJIsrHhWt/dnBxp/1UX4Jqziu4EEMvc=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 3/3] kasan: clean-up kconfig options descriptions
Date:   Mon,  9 May 2022 21:07:19 +0200
Message-Id: <47afaecec29221347bee49f58c258ac1ced3b429.1652123204.git.andreyknvl@google.com>
In-Reply-To: <5bd58ebebf066593ce0e1d265d60278b5f5a1874.1652123204.git.andreyknvl@google.com>
References: <5bd58ebebf066593ce0e1d265d60278b5f5a1874.1652123204.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Various readability clean-ups of KASAN Kconfig options.

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/Kconfig.kasan | 168 ++++++++++++++++++++++------------------------
 1 file changed, 82 insertions(+), 86 deletions(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 1f3e620188a2..f0973da583e0 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
 # This config refers to the generic KASAN mode.
 config HAVE_ARCH_KASAN
 	bool
@@ -15,9 +16,8 @@ config HAVE_ARCH_KASAN_VMALLOC
 config ARCH_DISABLE_KASAN_INLINE
 	bool
 	help
-	  An architecture might not support inline instrumentation.
-	  When this option is selected, inline and stack instrumentation are
-	  disabled.
+	  Disables both inline and stack instrumentation. Selected by
+	  architectures that do not support these instrumentation types.
 
 config CC_HAS_KASAN_GENERIC
 	def_bool $(cc-option, -fsanitize=kernel-address)
@@ -26,13 +26,13 @@ config CC_HAS_KASAN_SW_TAGS
 	def_bool $(cc-option, -fsanitize=kernel-hwaddress)
 
 # This option is only required for software KASAN modes.
-# Old GCC versions don't have proper support for no_sanitize_address.
+# Old GCC versions do not have proper support for no_sanitize_address.
 # See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=89124 for details.
 config CC_HAS_WORKING_NOSANITIZE_ADDRESS
 	def_bool !CC_IS_GCC || GCC_VERSION >= 80300
 
 menuconfig KASAN
-	bool "KASAN: runtime memory debugger"
+	bool "KASAN: dynamic memory safety error detector"
 	depends on (((HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC) || \
 		     (HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS)) && \
 		    CC_HAS_WORKING_NOSANITIZE_ADDRESS) || \
@@ -40,10 +40,13 @@ menuconfig KASAN
 	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
 	select STACKDEPOT_ALWAYS_INIT
 	help
-	  Enables KASAN (KernelAddressSANitizer) - runtime memory debugger,
-	  designed to find out-of-bounds accesses and use-after-free bugs.
+	  Enables KASAN (Kernel Address Sanitizer) - a dynamic memory safety
+	  error detector designed to find out-of-bounds and use-after-free bugs.
+
 	  See Documentation/dev-tools/kasan.rst for details.
 
+	  For better error reports, also enable CONFIG_STACKTRACE.
+
 if KASAN
 
 choice
@@ -51,75 +54,71 @@ choice
 	default KASAN_GENERIC
 	help
 	  KASAN has three modes:
-	  1. generic KASAN (similar to userspace ASan,
-	     x86_64/arm64/xtensa, enabled with CONFIG_KASAN_GENERIC),
-	  2. software tag-based KASAN (arm64 only, based on software
-	     memory tagging (similar to userspace HWASan), enabled with
-	     CONFIG_KASAN_SW_TAGS), and
-	  3. hardware tag-based KASAN (arm64 only, based on hardware
-	     memory tagging, enabled with CONFIG_KASAN_HW_TAGS).
 
-	  All KASAN modes are strictly debugging features.
+	  1. Generic KASAN (supported by many architectures, enabled with
+	     CONFIG_KASAN_GENERIC, similar to userspace ASan),
+	  2. Software Tag-Based KASAN (arm64 only, based on software memory
+	     tagging, enabled with CONFIG_KASAN_SW_TAGS, similar to userspace
+	     HWASan), and
+	  3. Hardware Tag-Based KASAN (arm64 only, based on hardware memory
+	     tagging, enabled with CONFIG_KASAN_HW_TAGS).
 
-	  For better error reports enable CONFIG_STACKTRACE.
+	  See Documentation/dev-tools/kasan.rst for details about each mode.
 
 config KASAN_GENERIC
-	bool "Generic mode"
+	bool "Generic KASAN"
 	depends on HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC
 	depends on CC_HAS_WORKING_NOSANITIZE_ADDRESS
 	select SLUB_DEBUG if SLUB
 	select CONSTRUCTORS
 	help
-	  Enables generic KASAN mode.
+	  Enables Generic KASAN.
 
-	  This mode is supported in both GCC and Clang. With GCC it requires
-	  version 8.3.0 or later. Any supported Clang version is compatible,
-	  but detection of out-of-bounds accesses for global variables is
-	  supported only since Clang 11.
+	  Requires GCC 8.3.0+ or Clang.
 
-	  This mode consumes about 1/8th of available memory at kernel start
-	  and introduces an overhead of ~x1.5 for the rest of the allocations.
+	  Consumes about 1/8th of available memory at kernel start and adds an
+	  overhead of ~50% for dynamic allocations.
 	  The performance slowdown is ~x3.
 
-	  Currently CONFIG_KASAN_GENERIC doesn't work with CONFIG_DEBUG_SLAB
-	  (the resulting kernel does not boot).
+	  (Incompatible with CONFIG_DEBUG_SLAB: the kernel does not boot.)
 
 config KASAN_SW_TAGS
-	bool "Software tag-based mode"
+	bool "Software Tag-Based KASAN"
 	depends on HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS
 	depends on CC_HAS_WORKING_NOSANITIZE_ADDRESS
 	select SLUB_DEBUG if SLUB
 	select CONSTRUCTORS
 	help
-	  Enables software tag-based KASAN mode.
+	  Enables Software Tag-Based KASAN.
 
-	  This mode require software memory tagging support in the form of
-	  HWASan-like compiler instrumentation.
+	  Requires GCC 11+ or Clang.
 
-	  Currently this mode is only implemented for arm64 CPUs and relies on
-	  Top Byte Ignore. This mode requires Clang.
+	  Supported only on arm64 CPUs and relies on Top Byte Ignore.
 
-	  This mode consumes about 1/16th of available memory at kernel start
-	  and introduces an overhead of ~20% for the rest of the allocations.
-	  This mode may potentially introduce problems relating to pointer
-	  casting and comparison, as it embeds tags into the top byte of each
-	  pointer.
+	  Consumes about 1/16th of available memory at kernel start and
+	  add an overhead of ~20% for dynamic allocations.
 
-	  Currently CONFIG_KASAN_SW_TAGS doesn't work with CONFIG_DEBUG_SLAB
-	  (the resulting kernel does not boot).
+	  May potentially introduce problems related to pointer casting and
+	  comparison, as it embeds a tag into the top byte of each pointer.
+
+	  (Incompatible with CONFIG_DEBUG_SLAB: the kernel does not boot.)
 
 config KASAN_HW_TAGS
-	bool "Hardware tag-based mode"
+	bool "Hardware Tag-Based KASAN"
 	depends on HAVE_ARCH_KASAN_HW_TAGS
 	depends on SLUB
 	help
-	  Enables hardware tag-based KASAN mode.
+	  Enables Hardware Tag-Based KASAN.
+
+	  Requires GCC 10+ or Clang 12+.
 
-	  This mode requires hardware memory tagging support, and can be used
-	  by any architecture that provides it.
+	  Supported only on arm64 CPUs starting from ARMv8.5 and relies on
+	  Memory Tagging Extension and Top Byte Ignore.
 
-	  Currently this mode is only implemented for arm64 CPUs starting from
-	  ARMv8.5 and relies on Memory Tagging Extension and Top Byte Ignore.
+	  Consumes about 1/32nd of available memory.
+
+	  May potentially introduce problems related to pointer casting and
+	  comparison, as it embeds a tag into the top byte of each pointer.
 
 endchoice
 
@@ -131,83 +130,80 @@ choice
 config KASAN_OUTLINE
 	bool "Outline instrumentation"
 	help
-	  Before every memory access compiler insert function call
-	  __asan_load*/__asan_store*. These functions performs check
-	  of shadow memory. This is slower than inline instrumentation,
-	  however it doesn't bloat size of kernel's .text section so
-	  much as inline does.
+	  Makes the compiler insert function calls that check whether the memory
+	  is accessible before each memory access. Slower than KASAN_INLINE, but
+	  does not bloat the size of the kernel's .text section so much.
 
 config KASAN_INLINE
 	bool "Inline instrumentation"
 	depends on !ARCH_DISABLE_KASAN_INLINE
 	help
-	  Compiler directly inserts code checking shadow memory before
-	  memory accesses. This is faster than outline (in some workloads
-	  it gives about x2 boost over outline instrumentation), but
-	  make kernel's .text size much bigger.
+	  Makes the compiler directly insert memory accessibility checks before
+	  each memory access. Faster than KASAN_OUTLINE (gives ~x2 boost for
+	  some workloads), but makes the kernel's .text size much bigger.
 
 endchoice
 
 config KASAN_STACK
-	bool "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
+	bool "Stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
 	depends on KASAN_GENERIC || KASAN_SW_TAGS
 	depends on !ARCH_DISABLE_KASAN_INLINE
 	default y if CC_IS_GCC
 	help
-	  The LLVM stack address sanitizer has a know problem that
-	  causes excessive stack usage in a lot of functions, see
-	  https://bugs.llvm.org/show_bug.cgi?id=38809
-	  Disabling asan-stack makes it safe to run kernels build
-	  with clang-8 with KASAN enabled, though it loses some of
-	  the functionality.
-	  This feature is always disabled when compile-testing with clang
-	  to avoid cluttering the output in stack overflow warnings,
-	  but clang users can still enable it for builds without
-	  CONFIG_COMPILE_TEST.	On gcc it is assumed to always be safe
-	  to use and enabled by default.
-	  If the architecture disables inline instrumentation, stack
-	  instrumentation is also disabled as it adds inline-style
-	  instrumentation that is run unconditionally.
+	  Disables stack instrumentation and thus KASAN's ability to detect
+	  out-of-bounds bugs in stack variables.
+
+	  With Clang, stack instrumentation has a problem that causes excessive
+	  stack usage, see https://bugs.llvm.org/show_bug.cgi?id=38809. Thus,
+	  with Clang, this option is deemed unsafe.
+
+	  This option is always disabled when compile-testing with Clang to
+	  avoid cluttering the log with stack overflow warnings.
+
+	  With GCC, enabling stack instrumentation is assumed to be safe.
+
+	  If the architecture disables inline instrumentation via
+	  ARCH_DISABLE_KASAN_INLINE, stack instrumentation gets disabled
+	  as well, as it adds inline-style instrumentation that is run
+	  unconditionally.
 
 config KASAN_TAGS_IDENTIFY
-	bool "Enable memory corruption identification"
+	bool "Memory corruption type identification"
 	depends on KASAN_SW_TAGS || KASAN_HW_TAGS
 	help
-	  This option enables best-effort identification of bug type
-	  (use-after-free or out-of-bounds) at the cost of increased
-	  memory consumption.
+	  Enables best-effort identification of the bug types (use-after-free
+	  or out-of-bounds) at the cost of increased memory consumption.
+	  Only applicable for the tag-based KASAN modes.
 
 config KASAN_VMALLOC
 	bool "Check accesses to vmalloc allocations"
 	depends on HAVE_ARCH_KASAN_VMALLOC
 	help
-	  This mode makes KASAN check accesses to vmalloc allocations for
-	  validity.
+	  Makes KASAN check the validity of accesses to vmalloc allocations.
 
-	  With software KASAN modes, checking is done for all types of vmalloc
-	  allocations. Enabling this option leads to higher memory usage.
+	  With software KASAN modes, all types vmalloc allocations are
+	  checked. Enabling this option leads to higher memory usage.
 
-	  With hardware tag-based KASAN, only VM_ALLOC mappings are checked.
-	  There is no additional memory usage.
+	  With Hardware Tag-Based KASAN, only non-executable VM_ALLOC mappings
+	  are checked. There is no additional memory usage.
 
 config KASAN_KUNIT_TEST
 	tristate "KUnit-compatible tests of KASAN bug detection capabilities" if !KUNIT_ALL_TESTS
 	depends on KASAN && KUNIT
 	default KUNIT_ALL_TESTS
 	help
-	  This is a KUnit test suite doing various nasty things like
-	  out of bounds and use after free accesses. It is useful for testing
-	  kernel debugging features like KASAN.
+	  A KUnit-based KASAN test suite. Triggers different kinds of
+	  out-of-bounds and use-after-free accesses. Useful for testing whether
+	  KASAN can detect certain bug types.
 
 	  For more information on KUnit and unit tests in general, please refer
-	  to the KUnit documentation in Documentation/dev-tools/kunit.
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
 
 config KASAN_MODULE_TEST
 	tristate "KUnit-incompatible tests of KASAN bug detection capabilities"
 	depends on m && KASAN && !KASAN_HW_TAGS
 	help
-	  This is a part of the KASAN test suite that is incompatible with
-	  KUnit. Currently includes tests that do bad copy_from/to_user
-	  accesses.
+	  A part of the KASAN test suite that is not integrated with KUnit.
+	  Incompatible with Hardware Tag-Based KASAN.
 
 endif # KASAN
-- 
2.25.1

