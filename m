Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F3B4945B9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 03:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbiATCPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 21:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbiATCPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 21:15:20 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE04C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 18:15:19 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id d3so15786607lfv.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 18:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jcP/Dq7CNHrVi+EJfNOLtF0PWZTMduwjMXBOhAVR1/s=;
        b=gzLN7RqgJ4yut51OaXRkypVjOpJvJ/w6M5oZZs5U7GrQfif7TirPD42byUTgWdq0mZ
         ppYMx349I7NgmCYI+OynG2n1czbdP4gNWIsoj6wV7YxX0Vyxu/oSwSBoHzEE2Sv0mOcH
         np74EwoB4T2jYLIXcPQo1SlWX7Y3EtZdXu31qqj00quy+zWFAfePnC7t+M3I+p4eGClo
         NoRYTBfXVxZ0xzR9LgCvOfmm95Z17vn2jw9+Tf2Pq5kThzW3h/py55HgcgDjcLxjlp7R
         xVPMm7goz28l2SR5a9tUc3tAw+UKQLCxRE2miDe4PFUFkGtPI6KOazusEp/AMTbgAhsH
         1EWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jcP/Dq7CNHrVi+EJfNOLtF0PWZTMduwjMXBOhAVR1/s=;
        b=F29ExLJjTsHanPNxQo+hrMQUh3RxZhlXMqGeyT/El71WHSZbwF2yI9xRsnsvIExcpx
         5d15beuqhFXGw8l13vRWERs43hLBwoUlIuSj4CD4IRBtsv5zgxjnjtxp42aAlrG88JlI
         KHDQsFawKKeFiy5aKxBHUcbzVRbxGEZdmtO6s3VXDWqhfV/33SJqzELv7wmauGpAN8uK
         Y2pBtb0BKU76nhO5bemKSroJWYrrAmLZjuRIGd59XE9ZQ/Ltolp4bt0AkaBSa4qd+qWT
         2tpDpAFGKit+nIv05mlyJlHqFX8atN8a1zuWg6rwrBYHH2OPXbi4ixQGjCKWa1dltQ1K
         N4xg==
X-Gm-Message-State: AOAM531XO9dWyAPB31CrfBSvY2Q7WoYLMjdT/Fs2cxrBiOygF+zIs3zx
        HKawwep88VtxEQvmrgaaEFcy5A==
X-Google-Smtp-Source: ABdhPJzMkT4hZhQrb9XOFnanK+fAiWGecsaKbHj5nFJfu5Io6FC6LxQosqp1iWtDM5BLp7CX8ZKmDQ==
X-Received: by 2002:a19:ac0a:: with SMTP id g10mr30749343lfc.138.1642644917903;
        Wed, 19 Jan 2022 18:15:17 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id t12sm149862lfr.197.2022.01.19.18.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 18:15:17 -0800 (PST)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 283D6103E5D; Thu, 20 Jan 2022 05:15:47 +0300 (+03)
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
Subject: [PATCH 3/3] x86/boot/compressed: Support TDX guest port I/O at decompression time
Date:   Thu, 20 Jan 2022 05:15:44 +0300
Message-Id: <20220120021545.7786-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220120021545.7786-1-kirill.shutemov@linux.intel.com>
References: <Yehz3eqq670WRVJE@zn.tnic>
 <20220120021545.7786-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Port I/O instructions trigger #VE in the TDX environment. In response to
the exception, kernel emulates these instructions using hypercalls.

But during early boot, on the decompression stage, it is cumbersome to
deal with #VE. It is cleaner to go to hypercalls directly, bypassing #VE
handling.

Hook up TDX-specific port I/O helpers if booting in TDX environment.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/boot/compressed/Makefile |  2 +-
 arch/x86/boot/compressed/tdcall.S |  3 ++
 arch/x86/boot/compressed/tdx.c    | 62 +++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/boot/compressed/tdcall.S

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 22a2a6cc2ab4..3215442d8d2d 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -98,7 +98,7 @@ ifdef CONFIG_X86_64
 endif
 
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
-vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o
+vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o
 
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
 efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
diff --git a/arch/x86/boot/compressed/tdcall.S b/arch/x86/boot/compressed/tdcall.S
new file mode 100644
index 000000000000..aafadc136c88
--- /dev/null
+++ b/arch/x86/boot/compressed/tdcall.S
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include "../../kernel/tdcall.S"
diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
index ae8c57ea00d8..265359131b92 100644
--- a/arch/x86/boot/compressed/tdx.c
+++ b/arch/x86/boot/compressed/tdx.c
@@ -5,6 +5,11 @@
 
 #include "../cpuflags.h"
 #include "../string.h"
+#include "../io.h"
+
+#include <vdso/limits.h>
+#include <uapi/asm/vmx.h>
+#include <asm/tdx.h>
 
 #define TDX_CPUID_LEAF_ID	0x21
 #define TDX_IDENT		"IntelTDX    "
@@ -16,6 +21,54 @@ bool early_is_tdx_guest(void)
 	return tdx_guest_detected;
 }
 
+static inline unsigned int tdx_io_in(int size, int port)
+{
+	struct tdx_hypercall_output out;
+
+	__tdx_hypercall(TDX_HYPERCALL_STANDARD, EXIT_REASON_IO_INSTRUCTION,
+			size, 0, port, 0, &out);
+
+	return out.r10 ? UINT_MAX : out.r11;
+}
+
+static inline void tdx_io_out(int size, int port, u64 value)
+{
+	struct tdx_hypercall_output out;
+
+	__tdx_hypercall(TDX_HYPERCALL_STANDARD, EXIT_REASON_IO_INSTRUCTION,
+			size, 1, port, value, &out);
+}
+
+static inline unsigned char tdx_inb(int port)
+{
+	return tdx_io_in(1, port);
+}
+
+static inline unsigned short tdx_inw(int port)
+{
+	return tdx_io_in(2, port);
+}
+
+static inline unsigned int tdx_inl(int port)
+{
+	return tdx_io_in(4, port);
+}
+
+static inline void tdx_outb(unsigned char value, int port)
+{
+	tdx_io_out(1, port, value);
+}
+
+static inline void tdx_outw(unsigned short value, int port)
+{
+	tdx_io_out(2, port, value);
+}
+
+static inline void tdx_outl(unsigned int value, int port)
+{
+	tdx_io_out(4, port, value);
+}
+
 void early_tdx_detect(void)
 {
 	u32 eax, sig[3];
@@ -27,4 +80,13 @@ void early_tdx_detect(void)
 
 	/* Cache TDX guest feature status */
 	tdx_guest_detected = true;
+
+	pio_ops = (struct port_io_ops) {
+		.inb = tdx_inb,
+		.inw = tdx_inw,
+		.inl = tdx_inl,
+		.outb = tdx_outb,
+		.outw = tdx_outw,
+		.outl = tdx_outl,
+	};
 }
-- 
2.34.1

