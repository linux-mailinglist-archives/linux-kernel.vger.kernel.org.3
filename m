Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FADA493D9C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 16:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355926AbiASPs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 10:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242648AbiASPs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 10:48:58 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B15C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 07:48:58 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id bu18so11120685lfb.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 07:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R+4t5f/zyll/gWbtTqvgeeqVCnyKasN4Ii9l/HMT2Tk=;
        b=TMzPs+a/8Mz1umsLBLY+bu7mWlQI3MwFlGjaVnXi+BuG88uMc1FpIavgVTX8Ws+bAN
         vVcCJ7QiIC2i0BDTcVdZ6cstNf17yRthpV9GPDL4+EwObBcX3xKyEl4Oe90DWipimEYL
         buVfkFyinGP/1SMjtHcpRlDkOiu1WXBifJR7EGmpRKh1SF9vdRhMHQnl1qbjjyKthd4g
         KJdmLNHpOyikOy/VbGB65T2/ydZQrYBIe1Nfcf4v4aHfrk35/KHJzRpxR6CvmycSTKM1
         T+nJX47pZ5CLYVoi9CHKkFwQCfypZDZzB+Ycg7Eu0+w+w1PYPxbGw9t+2Td3r6Skekn9
         3zUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R+4t5f/zyll/gWbtTqvgeeqVCnyKasN4Ii9l/HMT2Tk=;
        b=e/XnKCwgSg2zpTv62vaMWSiGqSpGhHx7PESGsFIzneeynBcFeYxsertWrV80j2qTQ0
         OwQILJ3/XnHLWPUzZEncMEApXqqA8sc+UehBzIs+O0R9q/7Pa5qAvdcjYWPAHvq0/lw9
         nQ9ZRvjLQ5sFk60/uQfzleA3gEC4r71AYogleZhML6S7e8CNwZo+vQpoDsbFyL0prQEX
         c3BG6/MFVUSuRdj/5/01Y8WIjxjhK/e2CiIHGcqvMeN20L9lAZsDHG4SrPPpuQji1OEc
         TYQc/44IsQIi91eKm68E1QykfcEbliOcwjT6DNcAaOwrJuOEOJiRH+Y8Rrtt5YEt2cxv
         wTlg==
X-Gm-Message-State: AOAM532d6rxsVU0qRBT/kcZ5BHyOoMYTgadO5P77+1TuAujSUE5bey2t
        CJYqffhQS0AmAQjxx5d28XWN4Q==
X-Google-Smtp-Source: ABdhPJxgUnMJjcNa6ne8P94rFGJMH6fKCcA6etigJEmnKd1TkiWladZjZSEqUw15Dt8wPN/qbmIrgg==
X-Received: by 2002:a2e:5457:: with SMTP id y23mr25124524ljd.384.1642607336522;
        Wed, 19 Jan 2022 07:48:56 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id r11sm3297ljk.59.2022.01.19.07.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 07:48:55 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 6EAEC10369E; Wed, 19 Jan 2022 18:49:25 +0300 (+03)
Date:   Wed, 19 Jan 2022 18:49:25 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        mingo@redhat.com, dave.hansen@intel.com, luto@kernel.org,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        david@redhat.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/26] x86/tdx: Support TDX guest port I/O at
 decompression time
Message-ID: <20220119154925.mzri4zaz3o477e3k@box.shutemov.name>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-11-kirill.shutemov@linux.intel.com>
 <YeAuehoOEjUH3vZ3@zn.tnic>
 <20220115010155.ss2hnyotw4a3nljf@black.fi.intel.com>
 <YeK7AJXGN5GVGkRV@zn.tnic>
 <20220117143920.3umnnlx7dl27cm5z@box.shutemov.name>
 <YeW2U9vH65NcLHtY@zn.tnic>
 <20220119115326.rw2aj3ho2mct4xxv@box.shutemov.name>
 <YegTjdltOFBIDlf2@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YegTjdltOFBIDlf2@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 02:35:09PM +0100, Borislav Petkov wrote:
> Raise hpa and tglx to To: for the general direction.
> 
> Full mail is at
> 
> https://lore.kernel.org/r/20220119115326.rw2aj3ho2mct4xxv@box.shutemov.name
> 
> On Wed, Jan 19, 2022 at 02:53:26PM +0300, Kirill A. Shutemov wrote:
> > Could you take a look if the diff below is the right direction?
> > 
> > If yes, I will prepare a proper patches. My plan is 3 patches: introduce
> > <asm/shared/io.h>, add 'struct port_io_ops' for early boot, hook up
> > alternative 'struct port_io_ops' for TDX.
> 
> Makes sense.
> 
> > diff --git a/arch/x86/boot/boot.h b/arch/x86/boot/boot.h
> > index 34c9dbb6a47d..27ce7cef13aa 100644
> > --- a/arch/x86/boot/boot.h
> > +++ b/arch/x86/boot/boot.h
> > @@ -18,11 +18,14 @@
> >  
> >  #ifndef __ASSEMBLY__
> >  
> > +#undef CONFIG_PARAVIRT
> 
> Yeah, this is the stuff I'd like to avoid in boot/. Can we get rid of
> any ifdeffery in the shared/ namespace?
> 
> I see this slow_down_io()-enforced CONFIG_PARAVIRT ifdeffery and that
> should not be there but in the ...asm/io.h kernel proper header. In the
> shared header we should have only basic functions which are shared by
> all.
> 
> For the same reason I don't think the shared header should have those
> if (cc_platform_has... branches but just the basic bits with the asm
> wrappers.

Okay, makes sense. See the patch below.

> > @@ -370,6 +377,15 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
> >  	lines = boot_params->screen_info.orig_video_lines;
> >  	cols = boot_params->screen_info.orig_video_cols;
> >  
> > +	port_io_ops = (const struct port_io_ops){
> > +		.inb = inb,
> > +		.inw = inw,
> > +		.inl = inl,
> > +		.outb = outb,
> > +		.outw = outw,
> > +		.outl = outl,
> > +	};
> 
> Why here and not statically defined above?

I tried to define

const struct port_io_ops default_pio_ops = {
	.inb = inb,
	.inw = inw,
	.inl = inl,
	.outb = outb,
	.outw = outw,
	.outl = outl,
};

make pio_ops a pointer and assign it here:

	pio_ops = &default_pio_ops;

But it leads to an issue on linking:

ld.lld: error: Unexpected run-time relocations (.rela) detected!

I'm not sure how to deal with it. Any clues?

An updated patch:

diff --git a/arch/x86/boot/a20.c b/arch/x86/boot/a20.c
index a2b6b428922a..506e4dc0d519 100644
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
+		status = pio_ops.inb(0x64);
 		if (status == 0xff) {
 			/* FF is a plausible, but very unlikely status */
 			if (!--ffs)
@@ -34,7 +35,7 @@ static int empty_8042(void)
 		if (status & 1) {
 			/* Read and discard input data */
 			io_delay();
-			(void)inb(0x60);
+			(void)pio_ops.inb(0x60);
 		} else if (!(status & 2)) {
 			/* Buffers empty, finished! */
 			return 0;
@@ -99,13 +100,13 @@ static void enable_a20_kbc(void)
 {
 	empty_8042();
 
-	outb(0xd1, 0x64);	/* Command write */
+	pio_ops.outb(0xd1, 0x64);	/* Command write */
 	empty_8042();
 
-	outb(0xdf, 0x60);	/* A20 on */
+	pio_ops.outb(0xdf, 0x60);	/* A20 on */
 	empty_8042();
 
-	outb(0xff, 0x64);	/* Null command, but UHCI wants it */
+	pio_ops.outb(0xff, 0x64);	/* Null command, but UHCI wants it */
 	empty_8042();
 }
 
@@ -113,10 +114,10 @@ static void enable_a20_fast(void)
 {
 	u8 port_a;
 
-	port_a = inb(0x92);	/* Configuration port A */
+	port_a = pio_ops.inb(0x92);	/* Configuration port A */
 	port_a |=  0x02;	/* Enable A20 */
 	port_a &= ~0x01;	/* Do not reset machine */
-	outb(port_a, 0x92);
+	pio_ops.outb(port_a, 0x92);
 }
 
 /*
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
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 22a2a6cc2ab4..1bfe30ebadbe 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -99,6 +99,7 @@ endif
 
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o
+vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdcall.o
 
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
 efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index d8373d766672..f0906b39d3d7 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -15,9 +15,11 @@
 #include "misc.h"
 #include "error.h"
 #include "pgtable.h"
+#include "tdx.h"
 #include "../string.h"
 #include "../voffset.h"
 #include <asm/bootparam_utils.h>
+#include <asm/shared/io.h>
 
 /*
  * WARNING!!
@@ -47,6 +49,8 @@ void *memmove(void *dest, const void *src, size_t n);
  */
 struct boot_params *boot_params;
 
+struct port_io_ops pio_ops;
+
 memptr free_mem_ptr;
 memptr free_mem_end_ptr;
 
@@ -103,10 +107,12 @@ static void serial_putchar(int ch)
 {
 	unsigned timeout = 0xffff;
 
-	while ((inb(early_serial_base + LSR) & XMTRDY) == 0 && --timeout)
+	while ((pio_ops.inb(early_serial_base + LSR) & XMTRDY) == 0 &&
+	       --timeout) {
 		cpu_relax();
+	}
 
-	outb(ch, early_serial_base + TXR);
+	pio_ops.outb(ch, early_serial_base + TXR);
 }
 
 void __putstr(const char *s)
@@ -152,10 +158,10 @@ void __putstr(const char *s)
 	boot_params->screen_info.orig_y = y;
 
 	pos = (x + cols * y) * 2;	/* Update cursor position */
-	outb(14, vidport);
-	outb(0xff & (pos >> 9), vidport+1);
-	outb(15, vidport);
-	outb(0xff & (pos >> 1), vidport+1);
+	pio_ops.outb(14, vidport);
+	pio_ops.outb(0xff & (pos >> 9), vidport+1);
+	pio_ops.outb(15, vidport);
+	pio_ops.outb(0xff & (pos >> 1), vidport+1);
 }
 
 void __puthex(unsigned long value)
@@ -370,6 +376,15 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	lines = boot_params->screen_info.orig_video_lines;
 	cols = boot_params->screen_info.orig_video_cols;
 
+	pio_ops = (const struct port_io_ops){
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
index 0d8e275a9d96..bf0fd98d5ce7 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -22,19 +22,17 @@
 #include <linux/linkage.h>
 #include <linux/screen_info.h>
 #include <linux/elf.h>
-#include <linux/io.h>
 #include <asm/page.h>
 #include <asm/boot.h>
 #include <asm/bootparam.h>
 #include <asm/desc_defs.h>
 
-#include "tdx.h"
-
 #define BOOT_CTYPE_H
 #include <linux/acpi.h>
 
 #define BOOT_BOOT_H
 #include "../ctype.h"
+#include "../io.h"
 
 #ifdef CONFIG_X86_64
 #define memptr long
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
index 50c8145bd0f3..07357147753f 100644
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
+	pio_ops = (struct port_io_ops) {
+		.inb = tdx_inb,
+		.inw = tdx_inw,
+		.inl = tdx_inl,
+		.outb = tdx_outb,
+		.outw = tdx_outw,
+		.outl = tdx_outl,
+	};
 }
diff --git a/arch/x86/boot/early_serial_console.c b/arch/x86/boot/early_serial_console.c
index 023bf1c3de8b..5ccc3d1b8f97 100644
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
+	pio_ops.outb(0x3, port + LCR);	/* 8n1 */
+	pio_ops.outb(0, port + IER);	/* no interrupt */
+	pio_ops.outb(0, port + FCR);	/* no fifo */
+	pio_ops.outb(0x3, port + MCR);	/* DTR + RTS */
 
 	divisor	= 115200 / baud;
-	c = inb(port + LCR);
-	outb(c | DLAB, port + LCR);
-	outb(divisor & 0xff, port + DLL);
-	outb((divisor >> 8) & 0xff, port + DLH);
-	outb(c & ~DLAB, port + LCR);
+	c = pio_ops.inb(port + LCR);
+	pio_ops.outb(c | DLAB, port + LCR);
+	pio_ops.outb(divisor & 0xff, port + DLL);
+	pio_ops.outb((divisor >> 8) & 0xff, port + DLH);
+	pio_ops.outb(c & ~DLAB, port + LCR);
 
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
+	lcr = pio_ops.inb(port + LCR);
+	pio_ops.outb(lcr | DLAB, port + LCR);
+	dll = pio_ops.inb(port + DLL);
+	dlh = pio_ops.inb(port + DLH);
+	pio_ops.outb(lcr, port + LCR);
 	quot = (dlh << 8) | dll;
 
 	return BASE_BAUD / quot;
diff --git a/arch/x86/boot/io.h b/arch/x86/boot/io.h
new file mode 100644
index 000000000000..f75edad63eaa
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
+extern struct port_io_ops pio_ops;
+
+#endif
diff --git a/arch/x86/boot/main.c b/arch/x86/boot/main.c
index e3add857c2c9..ae2eed21f62e 100644
--- a/arch/x86/boot/main.c
+++ b/arch/x86/boot/main.c
@@ -13,10 +13,13 @@
 #include <linux/build_bug.h>
 
 #include "boot.h"
+#include "io.h"
 #include "string.h"
 
 struct boot_params boot_params __attribute__((aligned(16)));
 
+struct port_io_ops pio_ops;
+
 char *HEAP = _end;
 char *heap_end = _end;		/* Default end of heap = no heap */
 
@@ -133,6 +136,15 @@ static void init_heap(void)
 
 void main(void)
 {
+	pio_ops = (struct port_io_ops){
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
index 40031a614712..26d9c5b34b9f 100644
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
+		pio_ops.outb(0x80, 0x70); /* Disable NMI */
 		io_delay();
 	}
 }
@@ -35,9 +36,9 @@ static void realmode_switch_hook(void)
  */
 static void mask_all_interrupts(void)
 {
-	outb(0xff, 0xa1);	/* Mask all interrupts on the secondary PIC */
+	pio_ops.outb(0xff, 0xa1);	/* Mask all interrupts on the secondary PIC */
 	io_delay();
-	outb(0xfb, 0x21);	/* Mask all but cascade on the primary PIC */
+	pio_ops.outb(0xfb, 0x21);	/* Mask all but cascade on the primary PIC */
 	io_delay();
 }
 
@@ -46,9 +47,9 @@ static void mask_all_interrupts(void)
  */
 static void reset_coprocessor(void)
 {
-	outb(0, 0xf0);
+	pio_ops.outb(0, 0xf0);
 	io_delay();
-	outb(0, 0xf1);
+	pio_ops.outb(0, 0xf1);
 	io_delay();
 }
 
diff --git a/arch/x86/boot/tty.c b/arch/x86/boot/tty.c
index f7eb976b0a4b..7675ed9afa55 100644
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
+	while ((pio_ops.inb(early_serial_base + LSR) & XMTRDY) == 0 && --timeout)
 		cpu_relax();
 
-	outb(ch, early_serial_base + TXR);
+	pio_ops.outb(ch, early_serial_base + TXR);
 }
 
 static void __section(".inittext") bios_putchar(int ch)
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
 Kirill A. Shutemov
