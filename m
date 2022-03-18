Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04F64DDD08
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 16:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238255AbiCRPeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 11:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238147AbiCRPcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:32:52 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5E81B694F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 08:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647617466; x=1679153466;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GPsonxD2SH/VQBEfitQ+ooyvb6UrqdA98KPm1ddBE5M=;
  b=Lxx20Sm2WDXNnX+1F4DCXwbi8XIcB5kXIdXcX9ZhmPw4V8YPG/AuepMC
   xyRNKJRR0386Ab5QfdnCNrQMNB9KimbWCmsD9LCMXmFqLBVvAUQlI5NLe
   Maof7eAPncXfgaglVaOHFHDblDohWCQ1mbHOrq5PgpMCzxFGdZ20wcCPs
   gJ2QFBIu35+3EimSbLyDdjWTW4MHE/ibJGV87PvnFfdwknPK0TGfYF51W
   JS625+/TDRdEd6xNLZHEOER3mqs6LBquMW6kvNpzsWp8gnbzV3Q/30byg
   nOHJ5YWlFTmF3ZB+PTBLMVJldsS+Mr+BEeVNlcg8m0O1xOHLnCr1We5eI
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="257344036"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="257344036"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 08:30:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="784269845"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 18 Mar 2022 08:30:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 73E5876F; Fri, 18 Mar 2022 17:30:50 +0200 (EET)
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
Subject: [PATCHv7 15/30] x86/boot: Port I/O: allow to hook up alternative helpers
Date:   Fri, 18 Mar 2022 18:30:33 +0300
Message-Id: <20220318153048.51177-16-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220318153048.51177-1-kirill.shutemov@linux.intel.com>
References: <20220318153048.51177-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

out*()/in*() macros redefined to use pio_ops callbacks. It eliminates
need in changing call sites. io_delay() changed to use port I/O helper
instead of inline assembly.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/boot/boot.h            |  4 ++--
 arch/x86/boot/compressed/misc.c |  4 ++++
 arch/x86/boot/compressed/misc.h |  2 +-
 arch/x86/boot/io.h              | 41 +++++++++++++++++++++++++++++++++
 arch/x86/boot/main.c            |  4 ++++
 arch/x86/realmode/rm/wakemain.c |  4 ++++
 6 files changed, 56 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/boot/io.h

diff --git a/arch/x86/boot/boot.h b/arch/x86/boot/boot.h
index 22a474c5b3e8..b42b91606ca8 100644
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
index 2b1169869b96..9fdef6af20a1 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -47,6 +47,8 @@ void *memmove(void *dest, const void *src, size_t n);
  */
 struct boot_params *boot_params;
 
+struct port_io_ops pio_ops;
+
 memptr free_mem_ptr;
 memptr free_mem_end_ptr;
 
@@ -370,6 +372,8 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
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
diff --git a/arch/x86/boot/io.h b/arch/x86/boot/io.h
new file mode 100644
index 000000000000..fd589ebcbd05
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
+	u8	(*inb)(u16 port);
+	void	(*outb)(u8 v, u16 port);
+	void	(*outw)(u16 v, u16 port);
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
+	pio_ops.inb = __inb;
+	pio_ops.outb = __outb;
+	pio_ops.outw = __outw;
+}
+
+/*
+ * Redirect port I/O operations via pio_ops callbacks.
+ * TDX guests override these callbacks with TDX-specific helpers.
+ */
+#define inb pio_ops.inb
+#define outb pio_ops.outb
+#define outw pio_ops.outw
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
 
diff --git a/arch/x86/realmode/rm/wakemain.c b/arch/x86/realmode/rm/wakemain.c
index 1d6437e6d2ba..a6f4d8388ad8 100644
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
-- 
2.34.1

