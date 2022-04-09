Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814B64FA140
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 03:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240531AbiDIBcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 21:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240283AbiDIBaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 21:30:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E11110E062;
        Fri,  8 Apr 2022 18:27:33 -0700 (PDT)
Date:   Sat, 09 Apr 2022 01:27:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649467652;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4GvXpMOg42DXaxmueh7/fUq4R1vEJTZ/saFeOmNNPA0=;
        b=VMM1eAYPyAZjOpFD4P3ZlIaw6mqh/Ma7ii8+vf0pDdxPw0fz8178vyt4lcua1qDpFrflIx
        qtNrjq4H5dBDcObi8LSso+5uv7mrMcw5TaaqkIEzFnM9UhprQ5J0SVBab0M0iyzN6BV0yI
        5O5IZNlBVAkiW1O7mBMgQUd/3ghFBehKaLPrBAA+S+p9THlfuTViaymvUG2Lsy6tylycIU
        jBS77v2NL7l/dAtTQL2gdudnoqjrbRRRdWUFDDsMRYKVJk1LvHb1bT+K/B93PFMNIMxrzk
        Yr+ZLW4XY6KeXOrBvPtftdG0BKs0o9l4Y6sISn5hsZ5k9gWETJSMqZYT7Hcuxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649467652;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4GvXpMOg42DXaxmueh7/fUq4R1vEJTZ/saFeOmNNPA0=;
        b=IZEMDqZjTVXx9ozhPvJWMBS/U2XdKMmAD7H/OuAKcpNup4mQRrC94AujEnpetJv/EtMivs
        JIKwYJ3uayjNxECQ==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/boot: Port I/O: Allow to hook up alternative helpers
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220405232939.73860-16-kirill.shutemov@linux.intel.com>
References: <20220405232939.73860-16-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <164946765099.4207.3597180551147936295.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     eb4ea1ae8f45e3249e7586f30be8977478202a37
Gitweb:        https://git.kernel.org/tip/eb4ea1ae8f45e3249e7586f30be8977478202a37
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Wed, 06 Apr 2022 02:29:24 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Apr 2022 08:27:52 -07:00

x86/boot: Port I/O: Allow to hook up alternative helpers

Port I/O instructions trigger #VE in the TDX environment. In response to
the exception, kernel emulates these instructions using hypercalls.

But during early boot, on the decompression stage, it is cumbersome to
deal with #VE. It is cleaner to go to hypercalls directly, bypassing #VE
handling.

Add a way to hook up alternative port I/O helpers in the boot stub with
a new pio_ops structure.  For now, set the ops structure to just call
the normal I/O operation functions.

out*()/in*() macros redefined to use pio_ops callbacks. It eliminates
need in changing call sites. io_delay() changed to use port I/O helper
instead of inline assembly.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20220405232939.73860-16-kirill.shutemov@linux.intel.com
---
 arch/x86/boot/boot.h            |  4 +--
 arch/x86/boot/compressed/misc.c |  4 +++-
 arch/x86/boot/compressed/misc.h |  2 +-
 arch/x86/boot/io.h              | 41 ++++++++++++++++++++++++++++++++-
 arch/x86/boot/main.c            |  4 +++-
 arch/x86/realmode/rm/wakemain.c |  4 +++-
 6 files changed, 56 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/boot/io.h

diff --git a/arch/x86/boot/boot.h b/arch/x86/boot/boot.h
index 22a474c..b42b916 100644
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
@@ -39,7 +39,7 @@ extern struct boot_params boot_params;
 static inline void io_delay(void)
 {
 	const u16 DELAY_PORT = 0x80;
-	asm volatile("outb %%al,%0" : : "dN" (DELAY_PORT));
+	outb(0, DELAY_PORT);
 }
 
 /* These functions are used to reference data in other segments. */
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index e8142e9..fa8969f 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -48,6 +48,8 @@ void *memmove(void *dest, const void *src, size_t n);
  */
 struct boot_params *boot_params;
 
+struct port_io_ops pio_ops;
+
 memptr free_mem_ptr;
 memptr free_mem_end_ptr;
 
@@ -371,6 +373,8 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	lines = boot_params->screen_info.orig_video_lines;
 	cols = boot_params->screen_info.orig_video_cols;
 
+	init_default_io_ops();
+
 	/*
 	 * Detect TDX guest environment.
 	 *
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 8a253e8..ea71cf3 100644
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
diff --git a/arch/x86/boot/io.h b/arch/x86/boot/io.h
new file mode 100644
index 0000000..1108809
--- /dev/null
+++ b/arch/x86/boot/io.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef BOOT_IO_H
+#define BOOT_IO_H
+
+#include <asm/shared/io.h>
+
+#undef inb
+#undef inw
+#undef inl
+#undef outb
+#undef outw
+#undef outl
+
+struct port_io_ops {
+	u8	(*f_inb)(u16 port);
+	void	(*f_outb)(u8 v, u16 port);
+	void	(*f_outw)(u16 v, u16 port);
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
+	pio_ops.f_inb  = __inb;
+	pio_ops.f_outb = __outb;
+	pio_ops.f_outw = __outw;
+}
+
+/*
+ * Redirect port I/O operations via pio_ops callbacks.
+ * TDX guests override these callbacks with TDX-specific helpers.
+ */
+#define inb  pio_ops.f_inb
+#define outb pio_ops.f_outb
+#define outw pio_ops.f_outw
+
+#endif
diff --git a/arch/x86/boot/main.c b/arch/x86/boot/main.c
index e3add85..1202d4f 100644
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
 
diff --git a/arch/x86/realmode/rm/wakemain.c b/arch/x86/realmode/rm/wakemain.c
index 1d6437e..a6f4d83 100644
--- a/arch/x86/realmode/rm/wakemain.c
+++ b/arch/x86/realmode/rm/wakemain.c
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
