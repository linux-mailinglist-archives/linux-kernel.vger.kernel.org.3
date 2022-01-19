Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A914939F1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 12:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354355AbiASLxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 06:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241852AbiASLw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 06:52:59 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D22CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 03:52:59 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id x11so8391386lfa.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 03:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2bteeIda4c+eNcsA/B6zD+D2tkbELFzss74tXqHPrIA=;
        b=O7bH3YqXlUl34bgmaS4HVlZYcGkj32K8DUZlOtKqNpMgJx8pMgrlfnjcJfCkTfQI5e
         E7ZX2vIwtx86WRugIG9UPcx9t9tEeygHZLCAxv9O0Ccod/BgQLKEaCCiv+sslzsTCLO4
         zHsIQxsMUKKIWnIhWD74Qw/3Rkbhlj5wcM6kWS4G31a0ksGSJmaJzJLvt7gC+5nazHEM
         dsC0sR9E3hMvZJaNalX34z/xb/Zq6TXUSyLWymx3K3kLRAn9x5jRGyLyzPMRUJtROwAf
         DpmYUQnmi6gftjqJU/LNhrEXmaGqvZ87pajjkcJeCZO9K0oJeEqt/anYEVJN20J1Wxkk
         JVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2bteeIda4c+eNcsA/B6zD+D2tkbELFzss74tXqHPrIA=;
        b=ErIVGlbzCplNnZtCuxln0C2Zc9d/ZWgCmRbw1oW5VRPfAxfMEX6RdsYO7WjGxBYI6o
         7YN7lrNXgQTu1kwnBOYe0WGF4J/Noyz9Xu9GX2HrCEsGOEQL3o8vg2YgGXwxj6lT+PbK
         mZmBqhfpaZdQEaFjIGIlbH+8Ao4UhmhX3i2AZYrY/4+veunhu/IQ1jkcWUvcw65GLyaH
         jtgIX7erA8q3u07BkmiJG26ZwbrInq6pasyBiRDS15+3/iIID9bnDEmMbT7p7c9govp3
         g/ZR/MsmItfbPXMeZEfs1Cuhfa8G5RORtsdDHAlC6C6e6JXDJ0C/IB9mlcGkIQFTE60t
         utNg==
X-Gm-Message-State: AOAM5331v+T0qiD/sDKLNHVWXbY/KCd6sqDe1+QZQJNn3fkkO2ES0Cmg
        Sf4RJdSv5puPGhyBMRP7vQKxsA==
X-Google-Smtp-Source: ABdhPJz4cumdLEOteqehuM37VwBZg6pMyOTtn3WZ/i2PcPd/BviJcrlhmE9PlQ9BOSuvJVCvmpOfLw==
X-Received: by 2002:a05:6512:6c5:: with SMTP id u5mr14862948lff.322.1642593177294;
        Wed, 19 Jan 2022 03:52:57 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v21sm1992560lfd.227.2022.01.19.03.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 03:52:56 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 2EC3F10369E; Wed, 19 Jan 2022 14:53:26 +0300 (+03)
Date:   Wed, 19 Jan 2022 14:53:26 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/26] x86/tdx: Support TDX guest port I/O at
 decompression time
Message-ID: <20220119115326.rw2aj3ho2mct4xxv@box.shutemov.name>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-11-kirill.shutemov@linux.intel.com>
 <YeAuehoOEjUH3vZ3@zn.tnic>
 <20220115010155.ss2hnyotw4a3nljf@black.fi.intel.com>
 <YeK7AJXGN5GVGkRV@zn.tnic>
 <20220117143920.3umnnlx7dl27cm5z@box.shutemov.name>
 <YeW2U9vH65NcLHtY@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeW2U9vH65NcLHtY@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 07:32:51PM +0100, Borislav Petkov wrote:
> On Mon, Jan 17, 2022 at 05:39:20PM +0300, Kirill A. Shutemov wrote:
> > arch/x86/boot and arch/x86/boot/compressed are separate linking domains.
> > boot/ uses own implementation while boot/compressed uses implementation
> > from <asm/io.h>. Decopliing boot/compressed from <asm/io.h> requires hack.
> > See #define _ACPI_IO_H_ below.
> 
> I am painfully aware. And the need to share code with kernel proper has
> grown quite the nasties in the meantime.
> 
> So, we talked about what to do here recently and the suggestion was to
> librarize common functionality so that
> 
> 1. it can be shared between the two.
> 2. changes in the kernel proper headers do not break the boot stubs.
> 
> So, instead of yet another duplication, I think what we should do is
> start growing a shared/ header namespace, i.e.,
> 
> arch/x86/include/asm/shared/
> 
> for example, and put there common, well, shared, functionality between
> boot stubs and kernel proper. Stuff which is basic and generic enough so
> that it can be shared by both.
> 
> That would be a prepatch.
> 
> Then, ontop, I'm wondering if it would be cleaner to have in/out
> function pointers in the boot stub which are assigned by default to
> those __in/__out generic shared handlers and then early_tdx_detect()
> would assign to them tdx_io_{in,out} when it detects it is running as a
> TDX guest.

Could you take a look if the diff below is the right direction?

If yes, I will prepare a proper patches. My plan is 3 patches: introduce
<asm/shared/io.h>, add 'struct port_io_ops' for early boot, hook up
alternative 'struct port_io_ops' for TDX.

diff --git a/arch/x86/boot/a20.c b/arch/x86/boot/a20.c
index a2b6b428922a..c83a0ae0d1df 100644
--- a/arch/x86/boot/a20.c
+++ b/arch/x86/boot/a20.c
@@ -12,6 +12,7 @@
  */
 
 #include "boot.h"
+#include "io.h"
 
 #define MAX_8042_LOOPS	100000
 #define MAX_8042_FF	32
@@ -25,7 +26,7 @@ static int empty_8042(void)
 	while (loops--) {
 		io_delay();
 
-		status = inb(0x64);
+		status = port_io_ops.inb(0x64);
 		if (status == 0xff) {
 			/* FF is a plausible, but very unlikely status */
 			if (!--ffs)
@@ -34,7 +35,7 @@ static int empty_8042(void)
 		if (status & 1) {
 			/* Read and discard input data */
 			io_delay();
-			(void)inb(0x60);
+			(void)port_io_ops.inb(0x60);
 		} else if (!(status & 2)) {
 			/* Buffers empty, finished! */
 			return 0;
@@ -99,13 +100,13 @@ static void enable_a20_kbc(void)
 {
 	empty_8042();
 
-	outb(0xd1, 0x64);	/* Command write */
+	port_io_ops.outb(0xd1, 0x64);	/* Command write */
 	empty_8042();
 
-	outb(0xdf, 0x60);	/* A20 on */
+	port_io_ops.outb(0xdf, 0x60);	/* A20 on */
 	empty_8042();
 
-	outb(0xff, 0x64);	/* Null command, but UHCI wants it */
+	port_io_ops.outb(0xff, 0x64);	/* Null command, but UHCI wants it */
 	empty_8042();
 }
 
@@ -113,10 +114,10 @@ static void enable_a20_fast(void)
 {
 	u8 port_a;
 
-	port_a = inb(0x92);	/* Configuration port A */
+	port_a = port_io_ops.inb(0x92);	/* Configuration port A */
 	port_a |=  0x02;	/* Enable A20 */
 	port_a &= ~0x01;	/* Do not reset machine */
-	outb(port_a, 0x92);
+	port_io_ops.outb(port_a, 0x92);
 }
 
 /*
diff --git a/arch/x86/boot/boot.h b/arch/x86/boot/boot.h
index 34c9dbb6a47d..27ce7cef13aa 100644
--- a/arch/x86/boot/boot.h
+++ b/arch/x86/boot/boot.h
@@ -18,11 +18,14 @@
 
 #ifndef __ASSEMBLY__
 
+#undef CONFIG_PARAVIRT
+
 #include <linux/stdarg.h>
 #include <linux/types.h>
 #include <linux/edd.h>
 #include <asm/setup.h>
 #include <asm/asm.h>
+#include <asm/shared/io.h>
 #include "bitops.h"
 #include "ctype.h"
 #include "cpuflags.h"
@@ -35,40 +38,6 @@ extern struct boot_params boot_params;
 
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
diff --git a/arch/x86/boot/compressed/io.h b/arch/x86/boot/compressed/io.h
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index d8373d766672..48de56f2219d 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -15,9 +15,12 @@
 #include "misc.h"
 #include "error.h"
 #include "pgtable.h"
+#include "tdx.h"
+#include "io.h"
 #include "../string.h"
 #include "../voffset.h"
 #include <asm/bootparam_utils.h>
+#include <asm/shared/io.h>
 
 /*
  * WARNING!!
@@ -47,6 +50,8 @@ void *memmove(void *dest, const void *src, size_t n);
  */
 struct boot_params *boot_params;
 
+struct port_io_ops port_io_ops;
+
 memptr free_mem_ptr;
 memptr free_mem_end_ptr;
 
@@ -103,10 +108,12 @@ static void serial_putchar(int ch)
 {
 	unsigned timeout = 0xffff;
 
-	while ((inb(early_serial_base + LSR) & XMTRDY) == 0 && --timeout)
+	while ((port_io_ops.inb(early_serial_base + LSR) & XMTRDY) == 0 &&
+	       --timeout) {
 		cpu_relax();
+	}
 
-	outb(ch, early_serial_base + TXR);
+	port_io_ops.outb(ch, early_serial_base + TXR);
 }
 
 void __putstr(const char *s)
@@ -152,10 +159,10 @@ void __putstr(const char *s)
 	boot_params->screen_info.orig_y = y;
 
 	pos = (x + cols * y) * 2;	/* Update cursor position */
-	outb(14, vidport);
-	outb(0xff & (pos >> 9), vidport+1);
-	outb(15, vidport);
-	outb(0xff & (pos >> 1), vidport+1);
+	port_io_ops.outb(14, vidport);
+	port_io_ops.outb(0xff & (pos >> 9), vidport+1);
+	port_io_ops.outb(15, vidport);
+	port_io_ops.outb(0xff & (pos >> 1), vidport+1);
 }
 
 void __puthex(unsigned long value)
@@ -370,6 +377,15 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	lines = boot_params->screen_info.orig_video_lines;
 	cols = boot_params->screen_info.orig_video_cols;
 
+	port_io_ops = (const struct port_io_ops){
+		.inb = inb,
+		.inw = inw,
+		.inl = inl,
+		.outb = outb,
+		.outw = outw,
+		.outl = outl,
+	};
+
 	/*
 	 * Detect TDX guest environment.
 	 *
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 6502adf71a2f..74951befb240 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -19,26 +19,23 @@
 /* cpu_feature_enabled() cannot be used this early */
 #define USE_EARLY_PGTABLE_L5
 
-/*
- * Redefine __in/__out macros via tdx.h before including
- * linux/io.h.
- */
-#include "tdx.h"
-
 #include <linux/linkage.h>
 #include <linux/screen_info.h>
 #include <linux/elf.h>
-#include <linux/io.h>
 #include <asm/page.h>
 #include <asm/boot.h>
 #include <asm/bootparam.h>
 #include <asm/desc_defs.h>
 
+/* Avoid pulling outb()/inb() from <asm/io.h> */
+#define _ACPI_IO_H_
+
 #define BOOT_CTYPE_H
 #include <linux/acpi.h>
 
 #define BOOT_BOOT_H
 #include "../ctype.h"
+#include "../io.h"
 
 #ifdef CONFIG_X86_64
 #define memptr long
diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
index 50c8145bd0f3..e0a8b054006f 100644
--- a/arch/x86/boot/compressed/tdx.c
+++ b/arch/x86/boot/compressed/tdx.c
@@ -5,12 +5,71 @@
 
 #include "../cpuflags.h"
 #include "../string.h"
+#include "../io.h"
+
+#include <vdso/limits.h>
+#include <uapi/asm/vmx.h>
+#include <asm/shared/io.h>
+#include <asm/tdx.h>
 
 #define TDX_CPUID_LEAF_ID	0x21
 #define TDX_IDENT		"IntelTDX    "
 
 static bool tdx_guest_detected;
 
+bool early_is_tdx_guest(void)
+{
+	return tdx_guest_detected;
+}
+
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
@@ -22,9 +81,13 @@ void early_tdx_detect(void)
 
 	/* Cache TDX guest feature status */
 	tdx_guest_detected = true;
-}
 
-bool early_is_tdx_guest(void)
-{
-	return tdx_guest_detected;
+	port_io_ops = (struct port_io_ops) {
+		.inb = tdx_inb,
+		.inw = tdx_inw,
+		.inl = tdx_inl,
+		.outb = tdx_outb,
+		.outw = tdx_outw,
+		.outl = tdx_outl,
+	};
 }
diff --git a/arch/x86/boot/compressed/tdx.h b/arch/x86/boot/compressed/tdx.h
index 5d39608a2af4..613b2aa0986f 100644
--- a/arch/x86/boot/compressed/tdx.h
+++ b/arch/x86/boot/compressed/tdx.h
@@ -7,51 +7,9 @@
 
 #ifdef CONFIG_INTEL_TDX_GUEST
 
-#include <vdso/limits.h>
-#include <uapi/asm/vmx.h>
-#include <asm/tdx.h>
-
 void early_tdx_detect(void);
 bool early_is_tdx_guest(void);
 
-static inline unsigned int tdx_io_in(int size, int port)
-{
-	struct tdx_hypercall_output out;
-
-	__tdx_hypercall(TDX_HYPERCALL_STANDARD, EXIT_REASON_IO_INSTRUCTION,
-			size, 0, port, 0, &out);
-
-	return out.r10 ? UINT_MAX : out.r11;
-}
-
-static inline void tdx_io_out(int size, int port, u64 value)
-{
-	struct tdx_hypercall_output out;
-
-	__tdx_hypercall(TDX_HYPERCALL_STANDARD, EXIT_REASON_IO_INSTRUCTION,
-			size, 1, port, value, &out);
-}
-
-#define __out(bwl, bw, sz)						\
-do {									\
-	if (early_is_tdx_guest()) {					\
-		tdx_io_out(sz, port, value);				\
-	} else {							\
-		asm volatile("out" #bwl " %" #bw "0, %w1" : :		\
-				"a"(value), "Nd"(port));		\
-	}								\
-} while (0)
-
-#define __in(bwl, bw, sz)						\
-do {									\
-	if (early_is_tdx_guest()) {					\
-		value = tdx_io_in(sz, port);				\
-	} else {							\
-		asm volatile("in" #bwl " %w1, %" #bw "0" :		\
-				"=a"(value) : "Nd"(port));		\
-	}								\
-} while (0)
-
 #else
 static inline void early_tdx_detect(void) { };
 static inline bool early_is_tdx_guest(void) { return false; }
diff --git a/arch/x86/boot/early_serial_console.c b/arch/x86/boot/early_serial_console.c
index 023bf1c3de8b..0afe624db9f6 100644
--- a/arch/x86/boot/early_serial_console.c
+++ b/arch/x86/boot/early_serial_console.c
@@ -4,6 +4,7 @@
  * included from both the compressed kernel and the regular kernel.
  */
 #include "boot.h"
+#include "io.h"
 
 #define DEFAULT_SERIAL_PORT 0x3f8 /* ttyS0 */
 
@@ -28,17 +29,17 @@ static void early_serial_init(int port, int baud)
 	unsigned char c;
 	unsigned divisor;
 
-	outb(0x3, port + LCR);	/* 8n1 */
-	outb(0, port + IER);	/* no interrupt */
-	outb(0, port + FCR);	/* no fifo */
-	outb(0x3, port + MCR);	/* DTR + RTS */
+	port_io_ops.outb(0x3, port + LCR);	/* 8n1 */
+	port_io_ops.outb(0, port + IER);	/* no interrupt */
+	port_io_ops.outb(0, port + FCR);	/* no fifo */
+	port_io_ops.outb(0x3, port + MCR);	/* DTR + RTS */
 
 	divisor	= 115200 / baud;
-	c = inb(port + LCR);
-	outb(c | DLAB, port + LCR);
-	outb(divisor & 0xff, port + DLL);
-	outb((divisor >> 8) & 0xff, port + DLH);
-	outb(c & ~DLAB, port + LCR);
+	c = port_io_ops.inb(port + LCR);
+	port_io_ops.outb(c | DLAB, port + LCR);
+	port_io_ops.outb(divisor & 0xff, port + DLL);
+	port_io_ops.outb((divisor >> 8) & 0xff, port + DLH);
+	port_io_ops.outb(c & ~DLAB, port + LCR);
 
 	early_serial_base = port;
 }
@@ -104,11 +105,11 @@ static unsigned int probe_baud(int port)
 	unsigned char lcr, dll, dlh;
 	unsigned int quot;
 
-	lcr = inb(port + LCR);
-	outb(lcr | DLAB, port + LCR);
-	dll = inb(port + DLL);
-	dlh = inb(port + DLH);
-	outb(lcr, port + LCR);
+	lcr = port_io_ops.inb(port + LCR);
+	port_io_ops.outb(lcr | DLAB, port + LCR);
+	dll = port_io_ops.inb(port + DLL);
+	dlh = port_io_ops.inb(port + DLH);
+	port_io_ops.outb(lcr, port + LCR);
 	quot = (dlh << 8) | dll;
 
 	return BASE_BAUD / quot;
diff --git a/arch/x86/boot/io.h b/arch/x86/boot/io.h
new file mode 100644
index 000000000000..934666ec8a22
--- /dev/null
+++ b/arch/x86/boot/io.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef BOOT_IO_H
+#define BOOT_IO_H
+
+#include <linux/compiler_attributes.h>
+
+struct port_io_ops {
+	unsigned char (*inb)(int port);
+	unsigned short (*inw)(int port);
+	unsigned int (*inl)(int port);
+	void (*outb)(unsigned char v, int port);
+	void (*outw)(unsigned short v, int port);
+	void (*outl)(unsigned int v, int port);
+};
+
+extern struct port_io_ops port_io_ops;
+
+#endif
diff --git a/arch/x86/boot/main.c b/arch/x86/boot/main.c
index e3add857c2c9..f0b8539d9a62 100644
--- a/arch/x86/boot/main.c
+++ b/arch/x86/boot/main.c
@@ -13,10 +13,13 @@
 #include <linux/build_bug.h>
 
 #include "boot.h"
+#include "io.h"
 #include "string.h"
 
 struct boot_params boot_params __attribute__((aligned(16)));
 
+struct port_io_ops port_io_ops;
+
 char *HEAP = _end;
 char *heap_end = _end;		/* Default end of heap = no heap */
 
@@ -133,6 +136,15 @@ static void init_heap(void)
 
 void main(void)
 {
+	port_io_ops = (struct port_io_ops){
+		.inb = inb,
+		.inw = inw,
+		.inl = inl,
+		.outb = outb,
+		.outw = outw,
+		.outl = outl,
+	};
+
 	/* First, copy the boot header into the "zeropage" */
 	copy_boot_params();
 
diff --git a/arch/x86/boot/pm.c b/arch/x86/boot/pm.c
index 40031a614712..b25e21a1e0c9 100644
--- a/arch/x86/boot/pm.c
+++ b/arch/x86/boot/pm.c
@@ -11,6 +11,7 @@
  */
 
 #include "boot.h"
+#include "io.h"
 #include <asm/segment.h>
 
 /*
@@ -25,7 +26,7 @@ static void realmode_switch_hook(void)
 			     : "eax", "ebx", "ecx", "edx");
 	} else {
 		asm volatile("cli");
-		outb(0x80, 0x70); /* Disable NMI */
+		port_io_ops.outb(0x80, 0x70); /* Disable NMI */
 		io_delay();
 	}
 }
@@ -35,9 +36,9 @@ static void realmode_switch_hook(void)
  */
 static void mask_all_interrupts(void)
 {
-	outb(0xff, 0xa1);	/* Mask all interrupts on the secondary PIC */
+	port_io_ops.outb(0xff, 0xa1);	/* Mask all interrupts on the secondary PIC */
 	io_delay();
-	outb(0xfb, 0x21);	/* Mask all but cascade on the primary PIC */
+	port_io_ops.outb(0xfb, 0x21);	/* Mask all but cascade on the primary PIC */
 	io_delay();
 }
 
@@ -46,9 +47,9 @@ static void mask_all_interrupts(void)
  */
 static void reset_coprocessor(void)
 {
-	outb(0, 0xf0);
+	port_io_ops.outb(0, 0xf0);
 	io_delay();
-	outb(0, 0xf1);
+	port_io_ops.outb(0, 0xf1);
 	io_delay();
 }
 
diff --git a/arch/x86/boot/tty.c b/arch/x86/boot/tty.c
index f7eb976b0a4b..4134dee678f6 100644
--- a/arch/x86/boot/tty.c
+++ b/arch/x86/boot/tty.c
@@ -12,6 +12,7 @@
  */
 
 #include "boot.h"
+#include "io.h"
 
 int early_serial_base;
 
@@ -29,10 +30,10 @@ static void __section(".inittext") serial_putchar(int ch)
 {
 	unsigned timeout = 0xffff;
 
-	while ((inb(early_serial_base + LSR) & XMTRDY) == 0 && --timeout)
+	while ((port_io_ops.inb(early_serial_base + LSR) & XMTRDY) == 0 && --timeout)
 		cpu_relax();
 
-	outb(ch, early_serial_base + TXR);
+	port_io_ops.outb(ch, early_serial_base + TXR);
 }
 
 static void __section(".inittext") bios_putchar(int ch)
diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index f5bb8972b4b2..ceee33b07dbf 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -38,6 +38,7 @@
 #define ARCH_HAS_IOREMAP_WC
 #define ARCH_HAS_IOREMAP_WT
 
+#include <asm/shared/io.h>
 #include <linux/string.h>
 #include <linux/compiler.h>
 #include <linux/cc_platform.h>
@@ -241,114 +242,6 @@ extern void native_io_delay(void);
 extern int io_delay_type;
 extern void io_delay_init(void);
 
-#if defined(CONFIG_PARAVIRT)
-#include <asm/paravirt.h>
-#else
-
-static inline void slow_down_io(void)
-{
-	native_io_delay();
-#ifdef REALLY_SLOW_IO
-	native_io_delay();
-	native_io_delay();
-	native_io_delay();
-#endif
-}
-
-#endif
-
-#ifndef __out
-#define __out(bwl, bw, sz)						\
-	asm volatile("out" #bwl " %" #bw "0, %w1" : : "a"(value), "Nd"(port))
-#endif
-
-#ifndef __in
-#define __in(bwl, bw, sz)						\
-	asm volatile("in" #bwl " %w1, %" #bw "0" : "=a"(value) : "Nd"(port))
-#endif
-
-#define BUILDIO(bwl, bw, type)						\
-static inline void out##bwl(unsigned type value, int port)		\
-{									\
-	__out(bwl, bw, sizeof(type));					\
-}									\
-									\
-static inline unsigned type in##bwl(int port)				\
-{									\
-	unsigned type value;						\
-	__in(bwl, bw, sizeof(type));					\
-	return value;							\
-}									\
-									\
-static inline void out##bwl##_p(unsigned type value, int port)		\
-{									\
-	out##bwl(value, port);						\
-	slow_down_io();							\
-}									\
-									\
-static inline unsigned type in##bwl##_p(int port)			\
-{									\
-	unsigned type value = in##bwl(port);				\
-	slow_down_io();							\
-	return value;							\
-}									\
-									\
-static inline void outs##bwl(int port, const void *addr, unsigned long count) \
-{									\
-	if (cc_platform_has(CC_ATTR_GUEST_UNROLL_STRING_IO)) {		\
-		unsigned type *value = (unsigned type *)addr;		\
-		while (count) {						\
-			out##bwl(*value, port);				\
-			value++;					\
-			count--;					\
-		}							\
-	} else {							\
-		asm volatile("rep; outs" #bwl				\
-			     : "+S"(addr), "+c"(count)			\
-			     : "d"(port) : "memory");			\
-	}								\
-}									\
-									\
-static inline void ins##bwl(int port, void *addr, unsigned long count)	\
-{									\
-	if (cc_platform_has(CC_ATTR_GUEST_UNROLL_STRING_IO)) {		\
-		unsigned type *value = (unsigned type *)addr;		\
-		while (count) {						\
-			*value = in##bwl(port);				\
-			value++;					\
-			count--;					\
-		}							\
-	} else {							\
-		asm volatile("rep; ins" #bwl				\
-			     : "+D"(addr), "+c"(count)			\
-			     : "d"(port) : "memory");			\
-	}								\
-}
-
-BUILDIO(b, b, char)
-BUILDIO(w, w, short)
-BUILDIO(l, , int)
-
-#define inb inb
-#define inw inw
-#define inl inl
-#define inb_p inb_p
-#define inw_p inw_p
-#define inl_p inl_p
-#define insb insb
-#define insw insw
-#define insl insl
-
-#define outb outb
-#define outw outw
-#define outl outl
-#define outb_p outb_p
-#define outw_p outw_p
-#define outl_p outl_p
-#define outsb outsb
-#define outsw outsw
-#define outsl outsl
-
 extern void *xlate_dev_mem_ptr(phys_addr_t phys);
 extern void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr);
 
diff --git a/arch/x86/include/asm/shared/io.h b/arch/x86/include/asm/shared/io.h
new file mode 100644
index 000000000000..12369bc72dcf
--- /dev/null
+++ b/arch/x86/include/asm/shared/io.h
@@ -0,0 +1,107 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_SHARED_IO_H
+#define _ASM_X86_SHARED_IO_H
+
+#include <linux/cc_platform.h>
+
+extern void native_io_delay(void);
+
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
+static inline void slow_down_io(void)
+{
+	native_io_delay();
+#ifdef REALLY_SLOW_IO
+	native_io_delay();
+	native_io_delay();
+	native_io_delay();
+#endif
+}
+#endif /* CONFIG_PARAVIRT */
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
+}									\
+									\
+static inline void out##bwl##_p(unsigned type value, int port)		\
+{									\
+	out##bwl(value, port);						\
+	slow_down_io();							\
+}									\
+									\
+static inline unsigned type in##bwl##_p(int port)			\
+{									\
+	unsigned type value = in##bwl(port);				\
+	slow_down_io();							\
+	return value;							\
+}									\
+									\
+static inline void outs##bwl(int port, const void *addr, unsigned long count) \
+{									\
+	if (cc_platform_has(CC_ATTR_GUEST_UNROLL_STRING_IO)) {		\
+		unsigned type *value = (unsigned type *)addr;		\
+		while (count) {						\
+			out##bwl(*value, port);				\
+			value++;					\
+			count--;					\
+		}							\
+	} else {							\
+		asm volatile("rep; outs" #bwl				\
+			     : "+S"(addr), "+c"(count)			\
+			     : "d"(port) : "memory");			\
+	}								\
+}									\
+									\
+static inline void ins##bwl(int port, void *addr, unsigned long count)	\
+{									\
+	if (cc_platform_has(CC_ATTR_GUEST_UNROLL_STRING_IO)) {		\
+		unsigned type *value = (unsigned type *)addr;		\
+		while (count) {						\
+			*value = in##bwl(port);				\
+			value++;					\
+			count--;					\
+		}							\
+	} else {							\
+		asm volatile("rep; ins" #bwl				\
+			     : "+D"(addr), "+c"(count)			\
+			     : "d"(port) : "memory");			\
+	}								\
+}
+
+BUILDIO(b, b, char)
+BUILDIO(w, w, short)
+BUILDIO(l, , int)
+
+#define inb inb
+#define inw inw
+#define inl inl
+#define inb_p inb_p
+#define inw_p inw_p
+#define inl_p inl_p
+#define insb insb
+#define insw insw
+#define insl insl
+
+#define outb outb
+#define outw outw
+#define outl outl
+#define outb_p outb_p
+#define outw_p outw_p
+#define outl_p outl_p
+#define outsb outsb
+#define outsw outsw
+#define outsl outsl
+
+#endif
-- 
 Kirill A. Shutemov
