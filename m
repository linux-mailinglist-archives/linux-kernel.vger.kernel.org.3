Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84024CA825
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243133AbiCBOay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243123AbiCBO3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:29:53 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE6555769
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 06:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646231316; x=1677767316;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dssmTF2/Efup6H50u/WDiNUqY08JOsX/5fqKg56PU14=;
  b=R7WhvnJ3glu+YYI/lT11IGoUxybAut5pIYaaQ1ZjaJ9Bz+QcaA6tGeh8
   /mVR1R2CSrFTbLu6bRIQPbW6oBicfplmCJwZmHMglYymq0XEFBXCO3mii
   YCBYyuHT0hFQG8Ws8ULs34xG0K7/bCem+DjBP8AbZNL6DxuDuivSk7Z0P
   YDS4vo+UrGilPlRI2l1IKH5D2mIQiZMlFVe1eHZWK5cJB3REAv66/w9cG
   xer4Cgd9U4uEzBVWtk4gHlNCo9M5x+HvwRvL7Bd7iQA/IPrNc3D+EFYpS
   mDhMa94PxSi2hESmPl+t7pPJ06XE18uUOMILwQ6Kw+u8hTJhMRosxr5Ix
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="252239436"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="252239436"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 06:28:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="609215472"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 02 Mar 2022 06:28:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 908BC411; Wed,  2 Mar 2022 16:28:12 +0200 (EET)
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCHv5 15/30] x86/boot: Port I/O: allow to hook up alternative helpers
Date:   Wed,  2 Mar 2022 17:27:51 +0300
Message-Id: <20220302142806.51844-16-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Port I/O instructions trigger #VE in the TDX environment. In response to
the exception, kernel emulates these instructions using hypercalls.

But during early boot, on the decompression stage, it is cumbersome to
deal with #VE. It is cleaner to go to hypercalls directly, bypassing #VE
handling.

Add a way to hook up alternative port I/O helpers in the boot stub with
a new pio_ops structure.  For now, set the ops structure to just call
the normal I/O operation functions.

The approach has down sides: TDX boot will fail if any code bypass
pio_ops and go for direct port I/O helper. The failure will only be
visible on TDX boot (or other user of alternative pio_ops).

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/boot/a20.c                  | 14 ++++++------
 arch/x86/boot/boot.h                 |  2 +-
 arch/x86/boot/compressed/misc.c      | 18 ++++++++++------
 arch/x86/boot/compressed/misc.h      |  2 +-
 arch/x86/boot/early_serial_console.c | 28 ++++++++++++------------
 arch/x86/boot/io.h                   | 32 ++++++++++++++++++++++++++++
 arch/x86/boot/main.c                 |  4 ++++
 arch/x86/boot/pm.c                   | 10 ++++-----
 arch/x86/boot/tty.c                  |  4 ++--
 arch/x86/boot/video-vga.c            |  6 +++---
 arch/x86/boot/video.h                |  8 ++++---
 arch/x86/realmode/rm/wakemain.c      | 14 +++++++-----
 12 files changed, 95 insertions(+), 47 deletions(-)
 create mode 100644 arch/x86/boot/io.h

diff --git a/arch/x86/boot/a20.c b/arch/x86/boot/a20.c
index a2b6b428922a..7f6dd5cc4670 100644
--- a/arch/x86/boot/a20.c
+++ b/arch/x86/boot/a20.c
@@ -25,7 +25,7 @@ static int empty_8042(void)
 	while (loops--) {
 		io_delay();
 
-		status = inb(0x64);
+		status = pio_ops.inb(0x64);
 		if (status == 0xff) {
 			/* FF is a plausible, but very unlikely status */
 			if (!--ffs)
@@ -34,7 +34,7 @@ static int empty_8042(void)
 		if (status & 1) {
 			/* Read and discard input data */
 			io_delay();
-			(void)inb(0x60);
+			(void)pio_ops.inb(0x60);
 		} else if (!(status & 2)) {
 			/* Buffers empty, finished! */
 			return 0;
@@ -99,13 +99,13 @@ static void enable_a20_kbc(void)
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
 
@@ -113,10 +113,10 @@ static void enable_a20_fast(void)
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
index 22a474c5b3e8..bd8f640ca15f 100644
--- a/arch/x86/boot/boot.h
+++ b/arch/x86/boot/boot.h
@@ -23,10 +23,10 @@
 #include <linux/edd.h>
 #include <asm/setup.h>
 #include <asm/asm.h>
-#include <asm/shared/io.h>
 #include "bitops.h"
 #include "ctype.h"
 #include "cpuflags.h"
+#include "io.h"
 
 /* Useful macros */
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 2b1169869b96..ff0e1b977514 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -47,6 +47,8 @@ void *memmove(void *dest, const void *src, size_t n);
  */
 struct boot_params *boot_params;
 
+struct port_io_ops pio_ops;
+
 memptr free_mem_ptr;
 memptr free_mem_end_ptr;
 
@@ -103,10 +105,12 @@ static void serial_putchar(int ch)
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
@@ -152,10 +156,10 @@ void __putstr(const char *s)
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
@@ -370,6 +374,8 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	lines = boot_params->screen_info.orig_video_lines;
 	cols = boot_params->screen_info.orig_video_cols;
 
+	init_default_io_ops();
+
 	/*
 	 * Detect TDX guest environment.
 	 *
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 8a253e85f990..ea71cf3d64e1 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -26,7 +26,6 @@
 #include <asm/boot.h>
 #include <asm/bootparam.h>
 #include <asm/desc_defs.h>
-#include <asm/shared/io.h>
 
 #include "tdx.h"
 
@@ -35,6 +34,7 @@
 
 #define BOOT_BOOT_H
 #include "../ctype.h"
+#include "../io.h"
 
 #ifdef CONFIG_X86_64
 #define memptr long
diff --git a/arch/x86/boot/early_serial_console.c b/arch/x86/boot/early_serial_console.c
index 023bf1c3de8b..03e43d770571 100644
--- a/arch/x86/boot/early_serial_console.c
+++ b/arch/x86/boot/early_serial_console.c
@@ -28,17 +28,17 @@ static void early_serial_init(int port, int baud)
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
@@ -104,11 +104,11 @@ static unsigned int probe_baud(int port)
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
index 000000000000..87dc8ee5d15f
--- /dev/null
+++ b/arch/x86/boot/io.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef BOOT_IO_H
+#define BOOT_IO_H
+
+#include <asm/shared/io.h>
+
+struct port_io_ops {
+	u8 (*inb)(u16 port);
+	u16 (*inw)(u16 port);
+	u32 (*inl)(u16 port);
+	void (*outb)(u8 v, u16 port);
+	void (*outw)(u16 v, u16 port);
+	void (*outl)(u32 v, u16 port);
+};
+
+extern struct port_io_ops pio_ops;
+
+/*
+ * Use the normal I/O instructions by default.
+ * TDX guests override these to use hypercalls.
+ */
+static inline void init_default_io_ops(void)
+{
+	pio_ops.inb = inb;
+	pio_ops.inw = inw;
+	pio_ops.inl = inl;
+	pio_ops.outb = outb;
+	pio_ops.outw = outw;
+	pio_ops.outl = outl;
+}
+
+#endif
diff --git a/arch/x86/boot/main.c b/arch/x86/boot/main.c
index e3add857c2c9..1202d4f8a390 100644
--- a/arch/x86/boot/main.c
+++ b/arch/x86/boot/main.c
@@ -17,6 +17,8 @@
 
 struct boot_params boot_params __attribute__((aligned(16)));
 
+struct port_io_ops pio_ops;
+
 char *HEAP = _end;
 char *heap_end = _end;		/* Default end of heap = no heap */
 
@@ -133,6 +135,8 @@ static void init_heap(void)
 
 void main(void)
 {
+	init_default_io_ops();
+
 	/* First, copy the boot header into the "zeropage" */
 	copy_boot_params();
 
diff --git a/arch/x86/boot/pm.c b/arch/x86/boot/pm.c
index 40031a614712..4180b6a264c9 100644
--- a/arch/x86/boot/pm.c
+++ b/arch/x86/boot/pm.c
@@ -25,7 +25,7 @@ static void realmode_switch_hook(void)
 			     : "eax", "ebx", "ecx", "edx");
 	} else {
 		asm volatile("cli");
-		outb(0x80, 0x70); /* Disable NMI */
+		pio_ops.outb(0x80, 0x70); /* Disable NMI */
 		io_delay();
 	}
 }
@@ -35,9 +35,9 @@ static void realmode_switch_hook(void)
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
 
@@ -46,9 +46,9 @@ static void mask_all_interrupts(void)
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
index f7eb976b0a4b..ee8700682801 100644
--- a/arch/x86/boot/tty.c
+++ b/arch/x86/boot/tty.c
@@ -29,10 +29,10 @@ static void __section(".inittext") serial_putchar(int ch)
 {
 	unsigned timeout = 0xffff;
 
-	while ((inb(early_serial_base + LSR) & XMTRDY) == 0 && --timeout)
+	while ((pio_ops.inb(early_serial_base + LSR) & XMTRDY) == 0 && --timeout)
 		cpu_relax();
 
-	outb(ch, early_serial_base + TXR);
+	pio_ops.outb(ch, early_serial_base + TXR);
 }
 
 static void __section(".inittext") bios_putchar(int ch)
diff --git a/arch/x86/boot/video-vga.c b/arch/x86/boot/video-vga.c
index 4816cb9cf996..17baac542ee7 100644
--- a/arch/x86/boot/video-vga.c
+++ b/arch/x86/boot/video-vga.c
@@ -131,7 +131,7 @@ static void vga_set_80x43(void)
 /* I/O address of the VGA CRTC */
 u16 vga_crtc(void)
 {
-	return (inb(0x3cc) & 1) ? 0x3d4 : 0x3b4;
+	return (pio_ops.inb(0x3cc) & 1) ? 0x3d4 : 0x3b4;
 }
 
 static void vga_set_480_scanlines(void)
@@ -148,10 +148,10 @@ static void vga_set_480_scanlines(void)
 	out_idx(0xdf, crtc, 0x12); /* Vertical display end */
 	out_idx(0xe7, crtc, 0x15); /* Vertical blank start */
 	out_idx(0x04, crtc, 0x16); /* Vertical blank end */
-	csel = inb(0x3cc);
+	csel = pio_ops.inb(0x3cc);
 	csel &= 0x0d;
 	csel |= 0xe2;
-	outb(csel, 0x3c2);
+	pio_ops.outb(csel, 0x3c2);
 }
 
 static void vga_set_vertical_end(int lines)
diff --git a/arch/x86/boot/video.h b/arch/x86/boot/video.h
index 04bde0bb2003..87a5f726e731 100644
--- a/arch/x86/boot/video.h
+++ b/arch/x86/boot/video.h
@@ -15,6 +15,8 @@
 
 #include <linux/types.h>
 
+#include "boot.h"
+
 /*
  * This code uses an extended set of video mode numbers. These include:
  * Aliases for standard modes
@@ -96,13 +98,13 @@ extern int graphic_mode;	/* Graphics mode with linear frame buffer */
 /* Accessing VGA indexed registers */
 static inline u8 in_idx(u16 port, u8 index)
 {
-	outb(index, port);
-	return inb(port+1);
+	pio_ops.outb(index, port);
+	return pio_ops.inb(port+1);
 }
 
 static inline void out_idx(u8 v, u16 port, u8 index)
 {
-	outw(index+(v << 8), port);
+	pio_ops.outw(index+(v << 8), port);
 }
 
 /* Writes a value to an indexed port and then reads the port again */
diff --git a/arch/x86/realmode/rm/wakemain.c b/arch/x86/realmode/rm/wakemain.c
index 1d6437e6d2ba..8c2eb2a829f1 100644
--- a/arch/x86/realmode/rm/wakemain.c
+++ b/arch/x86/realmode/rm/wakemain.c
@@ -17,18 +17,18 @@ static void beep(unsigned int hz)
 	} else {
 		u16 div = 1193181/hz;
 
-		outb(0xb6, 0x43);	/* Ctr 2, squarewave, load, binary */
+		pio_ops.outb(0xb6, 0x43);	/* Ctr 2, squarewave, load, binary */
 		io_delay();
-		outb(div, 0x42);	/* LSB of counter */
+		pio_ops.outb(div, 0x42);	/* LSB of counter */
 		io_delay();
-		outb(div >> 8, 0x42);	/* MSB of counter */
+		pio_ops.outb(div >> 8, 0x42);	/* MSB of counter */
 		io_delay();
 
 		enable = 0x03;		/* Turn on speaker */
 	}
-	inb(0x61);		/* Dummy read of System Control Port B */
+	pio_ops.inb(0x61);		/* Dummy read of System Control Port B */
 	io_delay();
-	outb(enable, 0x61);	/* Enable timer 2 output to speaker */
+	pio_ops.outb(enable, 0x61);	/* Enable timer 2 output to speaker */
 	io_delay();
 }
 
@@ -62,8 +62,12 @@ static void send_morse(const char *pattern)
 	}
 }
 
+struct port_io_ops pio_ops;
+
 void main(void)
 {
+	init_default_io_ops();
+
 	/* Kill machine if structures are wrong */
 	if (wakeup_header.real_magic != 0x12345678)
 		while (1)
-- 
2.34.1

