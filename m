Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04924982DC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240343AbiAXPCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:02:53 -0500
Received: from mga02.intel.com ([134.134.136.20]:19111 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239003AbiAXPC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:02:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643036546; x=1674572546;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qHjdp065/pE2dGbXagUIgqF5Caf1mnBv+CAb9DUvCm4=;
  b=CZr6FmxHiajhsW3ltsN0+BzL+4sj4ug/EVS3cHkkv87UW6Q1rAT0dPGn
   gKClei+tPWUaBrSyCuLdvuZ6AiGvXfVtJzrj+N/RKM1WLkRdqEbhK41Ik
   P2Et2s108uPNAsxjheLjzuiGS64vjOIMeC2vY1/84u19VsEAKbQ/KiQSQ
   hwRphSf/mGwUe4dbukODaEEkq11r2BedN5YpztoYp4Un42stY/WdJ1g6S
   bIicOGjyZcVKmE301rRLOvS7GgHIQfrOWZysA7iOy2xqDj4uUcpbqYIFd
   jMYSREzeS1v3r5SQlwT6mx7DH67IwnnszgBKMn8CyPlgi77Zua3sNIX8z
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="233423270"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="233423270"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 07:02:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="766422581"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 24 Jan 2022 07:02:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id CA4F15E4; Mon, 24 Jan 2022 17:02:19 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 10/29] x86: Consolidate port I/O helpers
Date:   Mon, 24 Jan 2022 18:01:56 +0300
Message-Id: <20220124150215.36893-11-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two implementations of port I/O helpers: one in the kernel and
one in the boot stub.

Move the helpers required for both to <asm/shared/io.h> and use the one
implementation everywhere.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/boot/boot.h             | 35 +-------------------------------
 arch/x86/boot/compressed/misc.h  |  2 +-
 arch/x86/include/asm/io.h        | 22 ++------------------
 arch/x86/include/asm/shared/io.h | 32 +++++++++++++++++++++++++++++
 4 files changed, 36 insertions(+), 55 deletions(-)
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
index f6d91ecb8026..8ce0a40379de 100644
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
-static inline void out##bwl(unsigned type value, int port)		\
-{									\
-	asm volatile("out" #bwl " %" #bw "0, %w1"			\
-		     : : "a"(value), "Nd"(port));			\
-}									\
-									\
-static inline unsigned type in##bwl(int port)				\
-{									\
-	unsigned type value;						\
-	asm volatile("in" #bwl " %w1, %" #bw "0"			\
-		     : "=a"(value) : "Nd"(port));			\
-	return value;							\
-}									\
-									\
 static inline void out##bwl##_p(unsigned type value, int port)		\
 {									\
 	out##bwl(value, port);						\
@@ -320,10 +307,8 @@ static inline void ins##bwl(int port, void *addr, unsigned long count)	\
 BUILDIO(b, b, char)
 BUILDIO(w, w, short)
 BUILDIO(l, , int)
+#undef BUILDIO
 
-#define inb inb
-#define inw inw
-#define inl inl
 #define inb_p inb_p
 #define inw_p inw_p
 #define inl_p inl_p
@@ -331,9 +316,6 @@ BUILDIO(l, , int)
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
index 000000000000..f17247f6c471
--- /dev/null
+++ b/arch/x86/include/asm/shared/io.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_SHARED_IO_H
+#define _ASM_X86_SHARED_IO_H
+
+#define BUILDIO(bwl, bw, type)						\
+static inline void out##bwl(unsigned type value, int port)		\
+{									\
+	asm volatile("out" #bwl " %" #bw "0, %w1"			\
+		     : : "a"(value), "Nd"(port));			\
+}									\
+									\
+static inline unsigned type in##bwl(int port)				\
+{									\
+	unsigned type value;						\
+	asm volatile("in" #bwl " %w1, %" #bw "0"			\
+		     : "=a"(value) : "Nd"(port));			\
+	return value;							\
+}
+
+BUILDIO(b, b, char)
+BUILDIO(w, w, short)
+BUILDIO(l, , int)
+#undef BUILDIO
+
+#define inb inb
+#define inw inw
+#define inl inl
+#define outb outb
+#define outw outw
+#define outl outl
+
+#endif
-- 
2.34.1

