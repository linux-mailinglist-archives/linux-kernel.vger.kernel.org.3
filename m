Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C8557FF5E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 14:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbiGYMzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 08:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbiGYMzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 08:55:31 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56784B48C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 05:55:30 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id y197so7836157iof.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 05:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=PfNbdom0DB4m2QIENdfTeF60j7cydsj3toNrOxaNArE=;
        b=Pwj3KTL9++ZDByxhe6A8L7sjOy0OInAZTR0X/ICWzSYHhGfQTjYg6FEOo04NzP35Qr
         kk4WkVfjiQwKwpfq+S5n3mJjMNTkb807v0YE5sKPSzwACxUuSy2lP/8O5pZ9DrkqGxTA
         dA9g0pEBOj2h06z27DEfViBhRxHw6Lc9VQwDWso7TnlSU7TAhRa2AffpJ3xwP0gDxoYm
         0IF5R4z9WPR/xn8ZCYAqjaYdfN81zL+dKk4KLZS7plqqpYSrz0Mov3+Md32TW9S6Gvzv
         3gBDZCspWKnO0sRwAPnTz8+j0zVjwa+ep2TxloTLk0/VAFbYDgO2RV2Kopb+3SSIDx+e
         lL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=PfNbdom0DB4m2QIENdfTeF60j7cydsj3toNrOxaNArE=;
        b=VQLiDSIQkynIMxLsJVnCvFJATe6bHpYF9d/3ln4YXxJlKDnBFCqybXMnEd44v4kM+C
         ujsIErD9mY96VpwoF3x7GE6maKG6SlkKYS3i/IuyqDfyj1g5mf7Dil9ltPDY+AJQL4c8
         G9fN5AqXl18O4TtG+MhHFyOJS3QJE5dkJGDZYOubCJgXF7A6DF/4SJJKERrSRYR3D5lV
         IY+DO0mDpLRUqf4B/c48KnY7H/cOrXfiy9zGXa53RafbgUvehgrVsEJUS5wpB1ieJYlL
         MC+2xWmhNSEzCsQ2HbQuTupjRT8nL32dbqH3CLZYbSN+WmkVo3j2m3qC6wwEtJhnO21W
         cKwA==
X-Gm-Message-State: AJIora/2bcUBipVwBcS+21gaUzDoSZ7uCm9QQnnogtEYWGmgRD3tqTLT
        dBwAsRZE0hVVe0jqdbEzULQPdDp37nez47uPk7O+M73GAuM=
X-Google-Smtp-Source: AGRyM1ser6jq9raL4EvRVV0XP3C7YUUhI4C0SMWJcV+tTuakx6tGMifHAoqGaIWPscf8uGaP3y0oyHhprI87a8MF2DY=
X-Received: by 2002:a05:6638:14cd:b0:341:46ad:f3da with SMTP id
 l13-20020a05663814cd00b0034146adf3damr5112612jak.36.1658753729457; Mon, 25
 Jul 2022 05:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220725083904.56552-1-huangjie.albert@bytedance.com> <20220725083904.56552-4-huangjie.albert@bytedance.com>
In-Reply-To: <20220725083904.56552-4-huangjie.albert@bytedance.com>
From:   =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date:   Mon, 25 Jul 2022 20:55:18 +0800
Message-ID: <CABKxMyM89vRT3wbKSPcoH+zZ7Lx+rpTaxfTi98xakGRhsYBv0g@mail.gmail.com>
Subject: Fwd: [PATCH 3/4] x86: Support the uncompressed kernel to speed up booting
To:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---------- Forwarded message ---------
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A Albert Huang <huangjie.albert@bytedanc=
e.com>
Date: 2022=E5=B9=B47=E6=9C=8825=E6=97=A5=E5=91=A8=E4=B8=80 16:40
Subject: [PATCH 3/4] x86: Support the uncompressed kernel to speed up booti=
ng
To:
Cc: huangjie.albert <huangjie.albert@bytedance.com>, Thomas Gleixner
<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
<x86@kernel.org>, H. Peter Anvin <hpa@zytor.com>, Eric Biederman
<ebiederm@xmission.com>, Masahiro Yamada <masahiroy@kernel.org>,
Michal Marek <michal.lkml@markovi.net>, Nick Desaulniers
<ndesaulniers@google.com>, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com>, Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com>, Tony Luck
<tony.luck@intel.com>, Michael Roth <michael.roth@amd.com>, Nathan
Chancellor <nathan@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark
Rutland <mark.rutland@arm.com>, Joerg Roedel <jroedel@suse.de>, Sean
Christopherson <seanjc@google.com>, Peter Zijlstra
<peterz@infradead.org>, Kees Cook <keescook@chromium.org>,
<linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
<linux-kbuild@vger.kernel.org>


From: "huangjie.albert" <huangjie.albert@bytedance.com>

Although the compressed kernel can save the time of loading the
kernel into the memory and save the disk space for storing the kernel,
but in some time-sensitive scenarios, the time for decompressing the
kernel is intolerable. Therefore, it is necessary to support uncompressed
kernel images, so that the time of kernel decompression can be saved when
the kernel is started.

This part of the time on my machine is approximately:
image type      image  size      times
compressed(gzip) 8.5M            159ms
uncompressed     53M             8.5ms

Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
---
 arch/x86/Kconfig                  |  1 +
 arch/x86/boot/compressed/Makefile |  5 ++++-
 arch/x86/boot/compressed/misc.c   | 13 +++++++++++++
 scripts/Makefile.lib              |  5 +++++
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index adbd3a2bd60f..231187624c68 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -221,6 +221,7 @@ config X86
        select HAVE_KERNEL_LZO
        select HAVE_KERNEL_XZ
        select HAVE_KERNEL_ZSTD
+       select HAVE_KERNEL_UNCOMPRESSED
        select HAVE_KPROBES
        select HAVE_KPROBES_ON_FTRACE
        select HAVE_FUNCTION_ERROR_INJECTION
diff --git a/arch/x86/boot/compressed/Makefile
b/arch/x86/boot/compressed/Makefile
index 19e1905dcbf6..0c8417a2f792 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -26,7 +26,7 @@ OBJECT_FILES_NON_STANDARD     :=3D y
 KCOV_INSTRUMENT                :=3D n

 targets :=3D vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2
vmlinux.bin.lzma \
-       vmlinux.bin.xz vmlinux.bin.lzo vmlinux.bin.lz4 vmlinux.bin.zst
+       vmlinux.bin.xz vmlinux.bin.lzo vmlinux.bin.lz4 vmlinux.bin.zst
vmlinux.bin.none

 # CLANG_FLAGS must come before any cc-disable-warning or cc-option calls i=
n
 # case of cross compiling, as it has the '--target=3D' flag, which is need=
ed to
@@ -139,6 +139,8 @@ $(obj)/vmlinux.bin.lz4: $(vmlinux.bin.all-y) FORCE
        $(call if_changed,lz4_with_size)
 $(obj)/vmlinux.bin.zst: $(vmlinux.bin.all-y) FORCE
        $(call if_changed,zstd22_with_size)
+$(obj)/vmlinux.bin.none: $(vmlinux.bin.all-y) FORCE
+       $(call if_changed,none)

 suffix-$(CONFIG_KERNEL_GZIP)   :=3D gz
 suffix-$(CONFIG_KERNEL_BZIP2)  :=3D bz2
@@ -147,6 +149,7 @@ suffix-$(CONFIG_KERNEL_XZ)  :=3D xz
 suffix-$(CONFIG_KERNEL_LZO)    :=3D lzo
 suffix-$(CONFIG_KERNEL_LZ4)    :=3D lz4
 suffix-$(CONFIG_KERNEL_ZSTD)   :=3D zst
+suffix-$(CONFIG_KERNEL_UNCOMPRESSED)   :=3D none

 quiet_cmd_mkpiggy =3D MKPIGGY $@
       cmd_mkpiggy =3D $(obj)/mkpiggy $< > $@
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/mis=
c.c
index cf690d8712f4..c23c0f525d93 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -181,6 +181,19 @@ void __puthex(unsigned long value)
        }
 }

+#ifdef CONFIG_KERNEL_UNCOMPRESSED
+#include <linux/decompress/mm.h>
+static int __decompress(unsigned char *buf, long len,
+                               long (*fill)(void*, unsigned long),
+                               long (*flush)(void*, unsigned long),
+                               unsigned char *outbuf, long olen,
+                               long *pos, void (*error)(char *x))
+{
+       memcpy(outbuf, buf, olen);
+       return 0;
+}
+#endif
+
 #ifdef CONFIG_X86_NEED_RELOCS
 static void handle_relocations(void *output, unsigned long output_len,
                               unsigned long virt_addr)
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 3fb6a99e78c4..c89d5466c617 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -438,6 +438,11 @@ quiet_cmd_lz4 =3D LZ4     $@
 quiet_cmd_lz4_with_size =3D LZ4     $@
       cmd_lz4_with_size =3D { cat $(real-prereqs) | $(LZ4) -l -c1 stdin st=
dout; \
                   $(size_append); } > $@
+# none
+quiet_cmd_none =3D NONE     $@
+      cmd_none =3D (cat $(filter-out FORCE,$^) && \
+      $(call size_append, $(filter-out FORCE,$^))) > $@ || \
+      (rm -f $@ ; false)

 # U-Boot mkimage
 # ------------------------------------------------------------------------=
---
--
2.31.1
