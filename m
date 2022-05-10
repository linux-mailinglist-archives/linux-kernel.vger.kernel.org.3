Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5394F52225D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241928AbiEJR0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347950AbiEJRZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:25:51 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48D74C79A
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:21:52 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652203310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TdNiqWhpZufDoMx0oKIsYQnIokRP5yv39jDeARXG8jk=;
        b=f2Wdt4rQtSC/GGt52bk+SILnh0dXO4pxwIToCQ+e86didQNAUkF1dp3YyO/J6gQ6qdQ90w
        QkPaAwVnRQoO9CFCMhrRrYf6wv4lb8WWioUItH6JDXVfNZYVQnLQHz18mXdm/tJ8hCvITH
        5dg4Y+PfEG3/GHEgsQ7T/JLvEQYmQPs=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 1/3] kasan: update documentation
Date:   Tue, 10 May 2022 19:21:46 +0200
Message-Id: <896b2d914d6b50d677fd7b38f76967cc705c01ba.1652203271.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Do assorted clean-ups and improvements to KASAN documentation, including:

- Describe each mode in a dedicated paragraph.
- Split out a Support section that describes in details which compilers,
  architectures and memory types each mode requires/supports.
- Capitalize the first letter in the names of each KASAN mode.

Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 Documentation/dev-tools/kasan.rst | 150 ++++++++++++++++++------------
 1 file changed, 90 insertions(+), 60 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index 7614a1fc30fa..2ed0b77d1db6 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -4,39 +4,76 @@ The Kernel Address Sanitizer (KASAN)
 Overview
 --------
 
-KernelAddressSANitizer (KASAN) is a dynamic memory safety error detector
-designed to find out-of-bound and use-after-free bugs. KASAN has three modes:
+Kernel Address Sanitizer (KASAN) is a dynamic memory safety error detector
+designed to find out-of-bounds and use-after-free bugs.
 
-1. generic KASAN (similar to userspace ASan),
-2. software tag-based KASAN (similar to userspace HWASan),
-3. hardware tag-based KASAN (based on hardware memory tagging).
+KASAN has three modes:
 
-Generic KASAN is mainly used for debugging due to a large memory overhead.
-Software tag-based KASAN can be used for dogfood testing as it has a lower
-memory overhead that allows using it with real workloads. Hardware tag-based
-KASAN comes with low memory and performance overheads and, therefore, can be
-used in production. Either as an in-field memory bug detector or as a security
-mitigation.
+1. Generic KASAN
+2. Software Tag-Based KASAN
+3. Hardware Tag-Based KASAN
 
-Software KASAN modes (#1 and #2) use compile-time instrumentation to insert
-validity checks before every memory access and, therefore, require a compiler
-version that supports that.
+Generic KASAN, enabled with CONFIG_KASAN_GENERIC, is the mode intended for
+debugging, similar to userspace ASan. This mode is supported on many CPU
+architectures, but it has significant performance and memory overheads.
 
-Generic KASAN is supported in GCC and Clang. With GCC, it requires version
-8.3.0 or later. Any supported Clang version is compatible, but detection of
-out-of-bounds accesses for global variables is only supported since Clang 11.
+Software Tag-Based KASAN or SW_TAGS KASAN, enabled with CONFIG_KASAN_SW_TAGS,
+can be used for both debugging and dogfood testing, similar to userspace HWASan.
+This mode is only supported for arm64, but its moderate memory overhead allows
+using it for testing on memory-restricted devices with real workloads.
 
-Software tag-based KASAN mode is only supported in Clang.
+Hardware Tag-Based KASAN or HW_TAGS KASAN, enabled with CONFIG_KASAN_HW_TAGS,
+is the mode intended to be used as an in-field memory bug detector or as a
+security mitigation. This mode only works on arm64 CPUs that support MTE
+(Memory Tagging Extension), but it has low memory and performance overheads and
+thus can be used in production.
 
-The hardware KASAN mode (#3) relies on hardware to perform the checks but
-still requires a compiler version that supports memory tagging instructions.
-This mode is supported in GCC 10+ and Clang 12+.
+For details about the memory and performance impact of each KASAN mode, see the
+descriptions of the corresponding Kconfig options.
 
-Both software KASAN modes work with SLUB and SLAB memory allocators,
-while the hardware tag-based KASAN currently only supports SLUB.
+The Generic and the Software Tag-Based modes are commonly referred to as the
+software modes. The Software Tag-Based and the Hardware Tag-Based modes are
+referred to as the tag-based modes.
 
-Currently, generic KASAN is supported for the x86_64, arm, arm64, xtensa, s390,
-and riscv architectures, and tag-based KASAN modes are supported only for arm64.
+Support
+-------
+
+Architectures
+~~~~~~~~~~~~~
+
+Generic KASAN is supported on x86_64, arm, arm64, powerpc, riscv, s390, and
+xtensa, and the tag-based KASAN modes are supported only on arm64.
+
+Compilers
+~~~~~~~~~
+
+Software KASAN modes use compile-time instrumentation to insert validity checks
+before every memory access and thus require a compiler version that provides
+support for that. The Hardware Tag-Based mode relies on hardware to perform
+these checks but still requires a compiler version that supports the memory
+tagging instructions.
+
+Generic KASAN requires GCC version 8.3.0 or later
+or any Clang version supported by the kernel.
+
+Software Tag-Based KASAN requires GCC 11+
+or any Clang version supported by the kernel.
+
+Hardware Tag-Based KASAN requires GCC 10+ or Clang 12+.
+
+Memory types
+~~~~~~~~~~~~
+
+Generic KASAN supports finding bugs in all of slab, page_alloc, vmap, vmalloc,
+stack, and global memory.
+
+Software Tag-Based KASAN supports slab, page_alloc, vmalloc, and stack memory.
+
+Hardware Tag-Based KASAN supports slab, page_alloc, and non-executable vmalloc
+memory.
+
+For slab, both software KASAN modes support SLUB and SLAB allocators, while
+Hardware Tag-Based KASAN only supports SLUB.
 
 Usage
 -----
@@ -45,13 +82,13 @@ To enable KASAN, configure the kernel with::
 
 	  CONFIG_KASAN=y
 
-and choose between ``CONFIG_KASAN_GENERIC`` (to enable generic KASAN),
-``CONFIG_KASAN_SW_TAGS`` (to enable software tag-based KASAN), and
-``CONFIG_KASAN_HW_TAGS`` (to enable hardware tag-based KASAN).
+and choose between ``CONFIG_KASAN_GENERIC`` (to enable Generic KASAN),
+``CONFIG_KASAN_SW_TAGS`` (to enable Software Tag-Based KASAN), and
+``CONFIG_KASAN_HW_TAGS`` (to enable Hardware Tag-Based KASAN).
 
-For software modes, also choose between ``CONFIG_KASAN_OUTLINE`` and
+For the software modes, also choose between ``CONFIG_KASAN_OUTLINE`` and
 ``CONFIG_KASAN_INLINE``. Outline and inline are compiler instrumentation types.
-The former produces a smaller binary while the latter is 1.1-2 times faster.
+The former produces a smaller binary while the latter is up to 2 times faster.
 
 To include alloc and free stack traces of affected slab objects into reports,
 enable ``CONFIG_STACKTRACE``. To include alloc and free stack traces of affected
@@ -146,7 +183,7 @@ is either 8 or 16 aligned bytes depending on KASAN mode. Each number in the
 memory state section of the report shows the state of one of the memory
 granules that surround the accessed address.
 
-For generic KASAN, the size of each memory granule is 8. The state of each
+For Generic KASAN, the size of each memory granule is 8. The state of each
 granule is encoded in one shadow byte. Those 8 bytes can be accessible,
 partially accessible, freed, or be a part of a redzone. KASAN uses the following
 encoding for each shadow byte: 00 means that all 8 bytes of the corresponding
@@ -181,14 +218,14 @@ By default, KASAN prints a bug report only for the first invalid memory access.
 With ``kasan_multi_shot``, KASAN prints a report on every invalid access. This
 effectively disables ``panic_on_warn`` for KASAN reports.
 
-Alternatively, independent of ``panic_on_warn`` the ``kasan.fault=`` boot
+Alternatively, independent of ``panic_on_warn``, the ``kasan.fault=`` boot
 parameter can be used to control panic and reporting behaviour:
 
 - ``kasan.fault=report`` or ``=panic`` controls whether to only print a KASAN
   report or also panic the kernel (default: ``report``). The panic happens even
   if ``kasan_multi_shot`` is enabled.
 
-Hardware tag-based KASAN mode (see the section about various modes below) is
+Hardware Tag-Based KASAN mode (see the section about various modes below) is
 intended for use in production as a security mitigation. Therefore, it supports
 additional boot parameters that allow disabling KASAN or controlling features:
 
@@ -250,49 +287,46 @@ outline-instrumented kernel.
 Generic KASAN is the only mode that delays the reuse of freed objects via
 quarantine (see mm/kasan/quarantine.c for implementation).
 
-Software tag-based KASAN
+Software Tag-Based KASAN
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
-Software tag-based KASAN uses a software memory tagging approach to checking
+Software Tag-Based KASAN uses a software memory tagging approach to checking
 access validity. It is currently only implemented for the arm64 architecture.
 
-Software tag-based KASAN uses the Top Byte Ignore (TBI) feature of arm64 CPUs
+Software Tag-Based KASAN uses the Top Byte Ignore (TBI) feature of arm64 CPUs
 to store a pointer tag in the top byte of kernel pointers. It uses shadow memory
 to store memory tags associated with each 16-byte memory cell (therefore, it
 dedicates 1/16th of the kernel memory for shadow memory).
 
-On each memory allocation, software tag-based KASAN generates a random tag, tags
+On each memory allocation, Software Tag-Based KASAN generates a random tag, tags
 the allocated memory with this tag, and embeds the same tag into the returned
 pointer.
 
-Software tag-based KASAN uses compile-time instrumentation to insert checks
+Software Tag-Based KASAN uses compile-time instrumentation to insert checks
 before each memory access. These checks make sure that the tag of the memory
 that is being accessed is equal to the tag of the pointer that is used to access
-this memory. In case of a tag mismatch, software tag-based KASAN prints a bug
+this memory. In case of a tag mismatch, Software Tag-Based KASAN prints a bug
 report.
 
-Software tag-based KASAN also has two instrumentation modes (outline, which
+Software Tag-Based KASAN also has two instrumentation modes (outline, which
 emits callbacks to check memory accesses; and inline, which performs the shadow
 memory checks inline). With outline instrumentation mode, a bug report is
 printed from the function that performs the access check. With inline
 instrumentation, a ``brk`` instruction is emitted by the compiler, and a
 dedicated ``brk`` handler is used to print bug reports.
 
-Software tag-based KASAN uses 0xFF as a match-all pointer tag (accesses through
+Software Tag-Based KASAN uses 0xFF as a match-all pointer tag (accesses through
 pointers with the 0xFF pointer tag are not checked). The value 0xFE is currently
 reserved to tag freed memory regions.
 
-Software tag-based KASAN currently only supports tagging of slab, page_alloc,
-and vmalloc memory.
-
-Hardware tag-based KASAN
+Hardware Tag-Based KASAN
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
-Hardware tag-based KASAN is similar to the software mode in concept but uses
+Hardware Tag-Based KASAN is similar to the software mode in concept but uses
 hardware memory tagging support instead of compiler instrumentation and
 shadow memory.
 
-Hardware tag-based KASAN is currently only implemented for arm64 architecture
+Hardware Tag-Based KASAN is currently only implemented for arm64 architecture
 and based on both arm64 Memory Tagging Extension (MTE) introduced in ARMv8.5
 Instruction Set Architecture and Top Byte Ignore (TBI).
 
@@ -302,21 +336,18 @@ access, hardware makes sure that the tag of the memory that is being accessed is
 equal to the tag of the pointer that is used to access this memory. In case of a
 tag mismatch, a fault is generated, and a report is printed.
 
-Hardware tag-based KASAN uses 0xFF as a match-all pointer tag (accesses through
+Hardware Tag-Based KASAN uses 0xFF as a match-all pointer tag (accesses through
 pointers with the 0xFF pointer tag are not checked). The value 0xFE is currently
 reserved to tag freed memory regions.
 
-Hardware tag-based KASAN currently only supports tagging of slab, page_alloc,
-and VM_ALLOC-based vmalloc memory.
-
-If the hardware does not support MTE (pre ARMv8.5), hardware tag-based KASAN
+If the hardware does not support MTE (pre ARMv8.5), Hardware Tag-Based KASAN
 will not be enabled. In this case, all KASAN boot parameters are ignored.
 
 Note that enabling CONFIG_KASAN_HW_TAGS always results in in-kernel TBI being
 enabled. Even when ``kasan.mode=off`` is provided or when the hardware does not
 support MTE (but supports TBI).
 
-Hardware tag-based KASAN only reports the first found bug. After that, MTE tag
+Hardware Tag-Based KASAN only reports the first found bug. After that, MTE tag
 checking gets disabled.
 
 Shadow memory
@@ -414,19 +445,18 @@ generic ``noinstr`` one.
 Note that disabling compiler instrumentation (either on a per-file or a
 per-function basis) makes KASAN ignore the accesses that happen directly in
 that code for software KASAN modes. It does not help when the accesses happen
-indirectly (through calls to instrumented functions) or with the hardware
-tag-based mode that does not use compiler instrumentation.
+indirectly (through calls to instrumented functions) or with Hardware
+Tag-Based KASAN, which does not use compiler instrumentation.
 
 For software KASAN modes, to disable KASAN reports in a part of the kernel code
 for the current task, annotate this part of the code with a
 ``kasan_disable_current()``/``kasan_enable_current()`` section. This also
 disables the reports for indirect accesses that happen through function calls.
 
-For tag-based KASAN modes (include the hardware one), to disable access
-checking, use ``kasan_reset_tag()`` or ``page_kasan_tag_reset()``. Note that
-temporarily disabling access checking via ``page_kasan_tag_reset()`` requires
-saving and restoring the per-page KASAN tag via
-``page_kasan_tag``/``page_kasan_tag_set``.
+For tag-based KASAN modes, to disable access checking, use
+``kasan_reset_tag()`` or ``page_kasan_tag_reset()``. Note that temporarily
+disabling access checking via ``page_kasan_tag_reset()`` requires saving and
+restoring the per-page KASAN tag via ``page_kasan_tag``/``page_kasan_tag_set``.
 
 Tests
 ~~~~~
-- 
2.25.1

