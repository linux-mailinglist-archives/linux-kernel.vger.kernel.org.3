Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95284DDDBD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238522AbiCRQHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238595AbiCRQHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:07:16 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05112F5111
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 09:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647619507; x=1679155507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c/soEeVacw7xDSkPekbPEZAHfx0/hzEIFrSSXeEpsDw=;
  b=kGkknDTLmcfUMMTm/OzfNCJekG5r8FNz4W1Uomq8SFxlyepKbQGbGI/4
   W8UkezRGkNFZ4Y4Aulex22JOmGq4hkB9l/3rpGj7WrDLOhGMyQdQ33jfb
   9MQWibSc1Ysf6oWqVf8bwHLn7aB6vBLsKzri1uZVhxp1w/ElNuaq2YZy6
   F2Xr8XaMM+MP1n/ZzUf2mLgXNKup5qt8PiUYYkbDgKCAzD5KFSvkg+bm0
   dncmlX3jf0ggQQpOlRQDfnPqahJ/08Gi6HstZuqjeNRg9Rkl1X1k9vxNl
   jljWVLXvK1LLZWCdJJvSM2rM5UhUXHcBOh/oLha6VUlWd5PUmIRvrcSKp
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="257111498"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="257111498"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 09:04:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="645571491"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 18 Mar 2022 09:04:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 4475610E; Fri, 18 Mar 2022 18:04:50 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     kirill.shutemov@linux.intel.com
Cc:     aarcange@redhat.com, ak@linux.intel.com, bp@alien8.de,
        brijesh.singh@amd.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, dave.hansen@linux.intel.com,
        david@redhat.com, hpa@zytor.com, jgross@suse.com,
        jmattson@google.com, joro@8bytes.org, jpoimboe@redhat.com,
        knsathya@kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, sdeep@vmware.com,
        seanjc@google.com, tglx@linutronix.de, thomas.lendacky@amd.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org
Subject: [PATCHv7.1 15/30] x86/boot: Port I/O: allow to hook up alternative helpers
Date:   Fri, 18 Mar 2022 19:04:46 +0300
Message-Id: <20220318160446.66170-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220318153048.51177-16-kirill.shutemov@linux.intel.com>
References: <20220318153048.51177-16-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
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

out*()/in*() macros redefined to use pio_ops callbacks. It eliminates
need in changing call sites. io_delay() changed to use port I/O helper
instead of inline assembly.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 v7.1:
  - Rename fields of struct port_io_ops to avoid conficts with I/O
    helpers;
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
index 000000000000..110880907f87
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

