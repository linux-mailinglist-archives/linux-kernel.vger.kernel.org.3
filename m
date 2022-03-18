Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7874DDCF7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 16:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238089AbiCRPcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 11:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238035AbiCRPcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:32:14 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7AD187BAC
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 08:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647617447; x=1679153447;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MrbfU+2Ld2oSKZSOCd/qGfZ6MHnP7qtA9jz4VC0Pg0E=;
  b=hrSHZKx9HuMnCvO4eUZroEqEn/zfc5tMkyBNHBmTXdQB/jPehDJL2n1d
   P8D1UF8I/Phi0ur+vs4t4TrcZorIAwZdAc33pDob+FaBtQYS4iAljlowu
   iYGAl75SBVM1q7YRDWB/XlQBF9MAoSpS+53Jh+Dp2UzKPL8EOeUnZk7u2
   ePxmFzYsiL7K/hZm27w6vmhw5eouYZhG3pXUIOYyVGf1Hqaz7Ndadoqxr
   yWiQWyxG3T+Z/C86efItLHwBcpjA3wAsmiQmARn/Fkbtz42F2I10jyzYw
   hVLL0ova8FQLMoCo/6IQIma8cyjlL2XQzQLx307/5JrmEf5tF9K49+B2d
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="281967573"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="281967573"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 08:30:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="691353416"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 18 Mar 2022 08:30:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 6597571E; Fri, 18 Mar 2022 17:30:50 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv7 14/30] x86: Consolidate port I/O helpers
Date:   Fri, 18 Mar 2022 18:30:32 +0300
Message-Id: <20220318153048.51177-15-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220318153048.51177-1-kirill.shutemov@linux.intel.com>
References: <20220318153048.51177-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two implementations of port I/O helpers: one in the kernel and
one in the boot stub.

Move the helpers required for both to <asm/shared/io.h> and use the one
implementation everywhere.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/boot/boot.h             | 35 +-------------------------------
 arch/x86/boot/compressed/misc.h  |  2 +-
 arch/x86/include/asm/io.h        | 22 ++------------------
 arch/x86/include/asm/shared/io.h | 34 +++++++++++++++++++++++++++++++
 4 files changed, 38 insertions(+), 55 deletions(-)
 create mode 100644 arch/x86/include/asm/shared/io.h

diff --git a/arch/x86/boot/boot.h b/arch/x86/boot/boot.h
index 34c9dbb6a47d..22a474c5b3e8 100644
--- a/arch/x86/boot/boot.h
+++ b/arch/x86/boot/boot.h
@@ -23,6 +23,7 @@
 #include <linux/edd.h>
 #include <asm/setup.h>
 #include <asm/asm.h>
+#include <asm/shared/io.h>
 #include "bitops.h"
 #include "ctype.h"
 #include "cpuflags.h"
@@ -35,40 +36,6 @@ extern struct boot_params boot_params;
 
 #define cpu_relax()	asm volatile("rep; nop")
 
-/* Basic port I/O */
-static inline void outb(u8 v, u16 port)
-{
-	asm volatile("outb %0,%1" : : "a" (v), "dN" (port));
-}
-static inline u8 inb(u16 port)
-{
-	u8 v;
-	asm volatile("inb %1,%0" : "=a" (v) : "dN" (port));
-	return v;
-}
-
-static inline void outw(u16 v, u16 port)
-{
-	asm volatile("outw %0,%1" : : "a" (v), "dN" (port));
-}
-static inline u16 inw(u16 port)
-{
-	u16 v;
-	asm volatile("inw %1,%0" : "=a" (v) : "dN" (port));
-	return v;
-}
-
-static inline void outl(u32 v, u16 port)
-{
-	asm volatile("outl %0,%1" : : "a" (v), "dN" (port));
-}
-static inline u32 inl(u16 port)
-{
-	u32 v;
-	asm volatile("inl %1,%0" : "=a" (v) : "dN" (port));
-	return v;
-}
-
 static inline void io_delay(void)
 {
 	const u16 DELAY_PORT = 0x80;
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 0d8e275a9d96..8a253e85f990 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -22,11 +22,11 @@
 #include <linux/linkage.h>
 #include <linux/screen_info.h>
 #include <linux/elf.h>
-#include <linux/io.h>
 #include <asm/page.h>
 #include <asm/boot.h>
 #include <asm/bootparam.h>
 #include <asm/desc_defs.h>
+#include <asm/shared/io.h>
 
 #include "tdx.h"
 
diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 638c1a2a82e0..a1eb218a49f8 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -44,6 +44,7 @@
 #include <asm/page.h>
 #include <asm/early_ioremap.h>
 #include <asm/pgtable_types.h>
+#include <asm/shared/io.h>
 
 #define build_mmio_read(name, size, type, reg, barrier) \
 static inline type name(const volatile void __iomem *addr) \
@@ -258,20 +259,6 @@ static inline void slow_down_io(void)
 #endif
 
 #define BUILDIO(bwl, bw, type)						\
-static inline void out##bwl(type value, u16 port)			\
-{									\
-	asm volatile("out" #bwl " %" #bw "0, %w1"			\
-		     : : "a"(value), "Nd"(port));			\
-}									\
-									\
-static inline type in##bwl(u16 port)					\
-{									\
-	type value;							\
-	asm volatile("in" #bwl " %w1, %" #bw "0"			\
-		     : "=a"(value) : "Nd"(port));			\
-	return value;							\
-}									\
-									\
 static inline void out##bwl##_p(type value, u16 port)			\
 {									\
 	out##bwl(value, port);						\
@@ -320,10 +307,8 @@ static inline void ins##bwl(u16 port, void *addr, unsigned long count)	\
 BUILDIO(b, b, u8)
 BUILDIO(w, w, u16)
 BUILDIO(l,  , u32)
+#undef BUILDIO
 
-#define inb inb
-#define inw inw
-#define inl inl
 #define inb_p inb_p
 #define inw_p inw_p
 #define inl_p inl_p
@@ -331,9 +316,6 @@ BUILDIO(l,  , u32)
 #define insw insw
 #define insl insl
 
-#define outb outb
-#define outw outw
-#define outl outl
 #define outb_p outb_p
 #define outw_p outw_p
 #define outl_p outl_p
diff --git a/arch/x86/include/asm/shared/io.h b/arch/x86/include/asm/shared/io.h
new file mode 100644
index 000000000000..c0ef921c0586
--- /dev/null
+++ b/arch/x86/include/asm/shared/io.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_SHARED_IO_H
+#define _ASM_X86_SHARED_IO_H
+
+#include <linux/types.h>
+
+#define BUILDIO(bwl, bw, type)						\
+static inline void __out##bwl(type value, u16 port)			\
+{									\
+	asm volatile("out" #bwl " %" #bw "0, %w1"			\
+		     : : "a"(value), "Nd"(port));			\
+}									\
+									\
+static inline type __in##bwl(u16 port)					\
+{									\
+	type value;							\
+	asm volatile("in" #bwl " %w1, %" #bw "0"			\
+		     : "=a"(value) : "Nd"(port));			\
+	return value;							\
+}
+
+BUILDIO(b, b, u8)
+BUILDIO(w, w, u16)
+BUILDIO(l,  , u32)
+#undef BUILDIO
+
+#define inb __inb
+#define inw __inw
+#define inl __inl
+#define outb __outb
+#define outw __outw
+#define outl __outl
+
+#endif
-- 
2.34.1

