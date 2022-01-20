Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FC54945BC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 03:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbiATCPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 21:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbiATCPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 21:15:20 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0ABAC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 18:15:19 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id br17so15879113lfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 18:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F41wqRuoTliwixqmGlbc3/VX+xczGBMnjcJRQTe/kME=;
        b=RH4pseH3xaeDZKzj8dcIkQZNNXUiNkTqOg3SiGHhUqykXt6UoUV/U/AkVvFnU/Jkw+
         b7I9A6Ncp/k9aCW3bLSN7R77YBZGnXHtCspdhd7Z2QfizkLZ+aM3abMkKP/Magi2sQOw
         EISPGIyQt/pA2FW4kwRziNLNcvFT1VZnm34jxA6aujOX+DbU70LlkO7/hZI3e62RlQYY
         XlcdaFLkBT159TCBqo+JBENtZdEl7GK5yqPyf/pK65KJD/vWzNEYR3sxl7G4ll7i23Bb
         LIWFfU8GVmH+Ob2jVnrB5pjNg/ee2ELDVtwTuXRS3Gr71Esq7kBkXy4+oyipgi0ItBvz
         phhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F41wqRuoTliwixqmGlbc3/VX+xczGBMnjcJRQTe/kME=;
        b=4pbflzlDqo2rXutLqfH2H6UJQmMZD8YGqx/vCIVZZzhw5598x4Md7NN12wrZUq7FX9
         HfVB0jpiwApQZndHJuVumZQtZxpuPR6hqA8IWWSuYEUmhyfT2c6rxCRnwmMnZoEtHm29
         74M1kEZ5owtyPOovrGNP7sV78AR7ZXjVOXj7zJGHZrkgumdUf+u78Arx+x01zLaz/XY3
         z0jEYIz466DnqgyLdmp8fayd7UeK+R8ZozS9qIw+NMEMWmp8VRInJ+X+8c807VCLKCZK
         Qi0XYybI0fBKeK6kIw7fYDmsrBgczGeXtav4Hngi2jw/3oXc8tYKfvhHYQG1txQhdG00
         UWpA==
X-Gm-Message-State: AOAM531dET1UlurEWTfWbY5M3D3Pk/bAl38gNOomwq/EntDPgXgNB8tw
        qIXHUAWjxTXNjZz5juOkU6E02w==
X-Google-Smtp-Source: ABdhPJwv7qKj7Qa0BAzvu72YKYhf67jjTFj0tva2VAEuSA6oaCa076/RB6mruyLvLswZMkRvACVSzg==
X-Received: by 2002:a05:6512:3e02:: with SMTP id i2mr29949339lfv.667.1642644918044;
        Wed, 19 Jan 2022 18:15:18 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id m9sm24714lfk.233.2022.01.19.18.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 18:15:17 -0800 (PST)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 17A6710369A; Thu, 20 Jan 2022 05:15:47 +0300 (+03)
To:     bp@alien8.de
Cc:     aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, david@redhat.com, hpa@zytor.com,
        jgross@suse.com, jmattson@google.com, joro@8bytes.org,
        jpoimboe@redhat.com, kirill.shutemov@linux.intel.com,
        kirill@shutemov.name, knsathya@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, sdeep@vmware.com,
        seanjc@google.com, tglx@linutronix.de, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
Subject: [PATCH 1/3] x86: Consolidate port I/O helpers
Date:   Thu, 20 Jan 2022 05:15:42 +0300
Message-Id: <20220120021545.7786-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Yehz3eqq670WRVJE@zn.tnic>
References: <Yehz3eqq670WRVJE@zn.tnic>
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

