Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B733490AA4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 15:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbiAQOi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 09:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbiAQOiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 09:38:55 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A447C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 06:38:55 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id m1so58431387lfq.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 06:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YTbFxKFtP6VC8EJbPZUXEwEsiyRahEoV9KQwNLkzBSU=;
        b=oWDSankRHuF+Vm4yXUlmPZJNE2iMwjyvNiik4A0xtP7nHVv79sIGiH07zxaDZjKNVu
         XniTdtFYGHca51Ag8GoD/aTtaxtAQNTE4sb2XOV9FpVB8Xx1LIf279FJW1q66UcAIfvH
         KjezUTcrg29uYbDhNLS7Vk2PhgNe7L6PMcjNVwDZMMjAvN0A4jWynG9PUgHDcbP8jzbU
         qia4XqYeCkuAcMKcIwOfPwtpw81Qzj5okn4QHrRwV+CwnMLosm56Ml66eecVxN4G/438
         X3QljW7DKGU5lBDI53RKu5Xji321IAFGbMNy53bMo1pRhln8b0WXlHGx4NdQfe1DCSJX
         nqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YTbFxKFtP6VC8EJbPZUXEwEsiyRahEoV9KQwNLkzBSU=;
        b=mpihHeH2ogDqUubYAL4P61Y2h2EahkC51yR0xvrhWnUVcxF0CJAHSVTwFoMzVn7EuJ
         SLfU7DGZ+ULTniw2z3VBw+zxMfmLLB6OPZ6BTfZc/xz+soN0mNti/AATDa8m7NseZWdY
         nqtBunVe1wINXjNf5vAAwB/B8jFNy+ijRAowV6O4vYxIHy6rbSqbvbLon9ygDZnJ7dhJ
         4rltPORHruh7HvIBin8izUjBZZQzif+qkH8zGdn2YBjLmOF2+YEIGHtZ30PTCDbcXaOs
         Iaz+0uOrvTH7neqQ9SWhQTPnazufYuWSN2aJ4SaD34FFn2xRYA6gOtW3xudjMdGhaEbP
         nNUQ==
X-Gm-Message-State: AOAM5329Hy3/XuebIIJZjgmdBQfWbupD5tkv+Y/2muS37720XGN5X+DB
        ChSNvvafiuLV8lKtFc9z6vZxTw==
X-Google-Smtp-Source: ABdhPJwf6OmyCDJaP5dzRA2pj/War0ryajg+7Eg+Qeb50OSn6HhVPEqOfGSlYfXNH6bFbqhxOFJfeQ==
X-Received: by 2002:ac2:4c56:: with SMTP id o22mr17345879lfk.558.1642430333351;
        Mon, 17 Jan 2022 06:38:53 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id m7sm1388315ljb.59.2022.01.17.06.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 06:38:52 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 9F06910387E; Mon, 17 Jan 2022 17:39:20 +0300 (+03)
Date:   Mon, 17 Jan 2022 17:39:20 +0300
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
Message-ID: <20220117143920.3umnnlx7dl27cm5z@box.shutemov.name>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-11-kirill.shutemov@linux.intel.com>
 <YeAuehoOEjUH3vZ3@zn.tnic>
 <20220115010155.ss2hnyotw4a3nljf@black.fi.intel.com>
 <YeK7AJXGN5GVGkRV@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeK7AJXGN5GVGkRV@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2022 at 01:16:00PM +0100, Borislav Petkov wrote:
> On Sat, Jan 15, 2022 at 04:01:55AM +0300, Kirill A. Shutemov wrote:
> > Do you see it differently? Do you want to switch to #VE here?
> 
> I'm just comparing to what SEV does and wondering why you guys do it
> differently. But if you think hypercalls is easier, fine by me.
> 
> The thing I don't like about that patch is you mixing up kernel proper
> io helpers with the decompressor code instead of modifying the ones in
> arch/x86/boot/boot.h.

arch/x86/boot and arch/x86/boot/compressed are separate linking domains.
boot/ uses own implementation while boot/compressed uses implementation
from <asm/io.h>. Decopliing boot/compressed from <asm/io.h> requires hack.
See #define _ACPI_IO_H_ below.

And even after that we cannot directly use implementation in boot/ since
we would need to make aware about TDX. That's not needed beyond
boot/comressed.

> We need to hammer out how the code sharing between kernel proper and the
> decompressor should be done but that ain't it, especially if there are
> already special io helpers in the decompressor.

What about the patch below?

I've added another (yes, third) implementation of outb()/inb() for
boot/compressed (we don't need the rest io helpers there).

Looks cleaner to me.

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
diff --git a/arch/x86/boot/compressed/early_serial_console.c b/arch/x86/boot/compressed/early_serial_console.c
index 261e81fb9582..1b842d04e687 100644
--- a/arch/x86/boot/compressed/early_serial_console.c
+++ b/arch/x86/boot/compressed/early_serial_console.c
@@ -1,4 +1,5 @@
 #include "misc.h"
+#include "io.h"
 
 int early_serial_base;
 
diff --git a/arch/x86/boot/compressed/io.h b/arch/x86/boot/compressed/io.h
new file mode 100644
index 000000000000..5e9de1e781d7
--- /dev/null
+++ b/arch/x86/boot/compressed/io.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef BOOT_COMPRESSED_IO_H
+#define BOOT_COMPRESSED_IO_H
+
+#include "tdx.h"
+
+static inline void outb(u8 v, u16 port)
+{
+	if (early_is_tdx_guest())
+		tdx_io_out(1, port, v);
+	else
+		asm volatile("outb %0,%1" : : "a" (v), "dN" (port));
+}
+
+static inline u8 inb(u16 port)
+{
+	u8 v;
+	if (early_is_tdx_guest())
+		v = tdx_io_in(1, port);
+	else
+		asm volatile("inb %1,%0" : "=a" (v) : "dN" (port));
+	return v;
+}
+
+#endif
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index d8373d766672..dd97d9ca73db 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -15,6 +15,8 @@
 #include "misc.h"
 #include "error.h"
 #include "pgtable.h"
+#include "tdx.h"
+#include "io.h"
 #include "../string.h"
 #include "../voffset.h"
 #include <asm/bootparam_utils.h>
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 0d8e275a9d96..f3c10ae33c45 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -22,13 +22,13 @@
 #include <linux/linkage.h>
 #include <linux/screen_info.h>
 #include <linux/elf.h>
-#include <linux/io.h>
 #include <asm/page.h>
 #include <asm/boot.h>
 #include <asm/bootparam.h>
 #include <asm/desc_defs.h>
 
-#include "tdx.h"
+/* Avoid pulling outb()/inb() from <asm/io.h> */
+#define _ACPI_IO_H_
 
 #define BOOT_CTYPE_H
 #include <linux/acpi.h>
diff --git a/arch/x86/boot/compressed/tdcall.S b/arch/x86/boot/compressed/tdcall.S
new file mode 100644
index 000000000000..aafadc136c88
--- /dev/null
+++ b/arch/x86/boot/compressed/tdcall.S
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include "../../kernel/tdcall.S"
diff --git a/arch/x86/boot/compressed/tdx.h b/arch/x86/boot/compressed/tdx.h
index 18970c09512e..6d6799c1daec 100644
--- a/arch/x86/boot/compressed/tdx.h
+++ b/arch/x86/boot/compressed/tdx.h
@@ -6,11 +6,37 @@
 #include <linux/types.h>
 
 #ifdef CONFIG_INTEL_TDX_GUEST
+
+#include <vdso/limits.h>
+#include <uapi/asm/vmx.h>
+#include <asm/tdx.h>
+
 void early_tdx_detect(void);
 bool early_is_tdx_guest(void);
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
 #else
 static inline void early_tdx_detect(void) { };
 static inline bool early_is_tdx_guest(void) { return false; }
+static inline unsigned int tdx_io_in(int size, int port) { return 0; }
+static inline void tdx_io_out(int size, int port, u64 value) { }
 #endif
 
 #endif
-- 
 Kirill A. Shutemov
