Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE9357FF60
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 14:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbiGYMz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 08:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbiGYMzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 08:55:53 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D713DB1FA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 05:55:51 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id e69so8687297iof.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 05:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=H9ottcv2Ksz0B+4pJCK3xpnZJpAvCKLgMsQNt3fRODU=;
        b=irqzMeXyJAkiNze/TqgZt5WRBDgkHI24zJTp2KdxtJbkBIql0GIz6hlkJbIE/NFIXL
         QLxBu7UGVKxTCdvJS2SzpaRAwEM5fMwRIki2unw+CoaYltOL3gQmtEGRXmJIUeFKFKET
         ZLdkq2d9JX1TfED5OzBAfRRdcS8DPZzsnGFd420qxd4XLGq0itPlmXY3aRePxCLEBqzq
         eGnXCeT38lk06CWOHH6GjJCUv7CUl1stbmbrC2GxAAcTCRlOgw/DzqImyvJ3teBlIc9C
         si1xxu8X3JDop5H6xVt7580mx7ig0hB4MVDAO/UACy9Ei7AXJo645DIAfKDGo8BaGJT/
         ZY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=H9ottcv2Ksz0B+4pJCK3xpnZJpAvCKLgMsQNt3fRODU=;
        b=i75OkanpflCrFvAhXFJYhhjw+JK5v5xsNNzvgYjOZIrnZ+vyqCPt+F5D/Bk6v7vrW0
         0kBWFs1jNOpTa/uw9jiVT/o4VYXbVgt7l1jLqNUCDhKHyjssCfucpwPjMBLPOa+951QI
         5UtI9qYLbj6qMuoxmKJs1RMHFrJjoYd5d5BzkAFHAXrGsdXT0TgykmBA58jB8r+tBBHQ
         svWcBa9v+qg5QgI3UKZLxds3Ce2RCqcM1TDZHc8+xWiQmINTdd0fCoth4mve3Prjduzb
         d9GVDdW5hW700XponPavKMRvKP5pln1mcLxtZu+JJbwSen1im3C08eVM0Y7u4XePexKG
         TVTg==
X-Gm-Message-State: AJIora+PnifslIuhDnGF3Txiwq2nOa7/Do6qisZbLDZe3bN1NeyJWEa0
        sXO3buvc7BGApSRbjYj6+6mKddfUv+wWExppRgfFD28nEqE=
X-Google-Smtp-Source: AGRyM1sf5HEJpYc6fVapLWQURfRQVyT/5HkLC19aRxU2ZVeneO2D9qlHj5/KcqS8VEVZ2Xo8xWrw6Srx7aUabOTwLqo=
X-Received: by 2002:a02:c722:0:b0:33f:393d:d198 with SMTP id
 h2-20020a02c722000000b0033f393dd198mr4948737jao.22.1658753751071; Mon, 25 Jul
 2022 05:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220725083904.56552-1-huangjie.albert@bytedance.com> <20220725083904.56552-5-huangjie.albert@bytedance.com>
In-Reply-To: <20220725083904.56552-5-huangjie.albert@bytedance.com>
From:   =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date:   Mon, 25 Jul 2022 20:55:39 +0800
Message-ID: <CABKxMyNcuHE4iEWLHdGZw-O4g8zaj9CvXWNQ7fqBkZV0mNWVfQ@mail.gmail.com>
Subject: Fwd: [PATCH 4/4] x86: boot: avoid memory copy if kernel is uncompressed
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
Subject: [PATCH 4/4] x86: boot: avoid memory copy if kernel is uncompressed
To:
Cc: huangjie.albert <huangjie.albert@bytedance.com>, Thomas Gleixner
<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
<x86@kernel.org>, H. Peter Anvin <hpa@zytor.com>, Eric Biederman
<ebiederm@xmission.com>, Masahiro Yamada <masahiroy@kernel.org>,
Michal Marek <michal.lkml@markovi.net>, Nick Desaulniers
<ndesaulniers@google.com>, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com>, Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com>, Michael Roth
<michael.roth@amd.com>, Nathan Chancellor <nathan@kernel.org>, Ard
Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
Sean Christopherson <seanjc@google.com>, Peter Zijlstra
<peterz@infradead.org>, Kees Cook <keescook@chromium.org>, Tony Luck
<tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
<kexec@lists.infradead.org>, <linux-kbuild@vger.kernel.org>


From: "huangjie.albert" <huangjie.albert@bytedance.com>

1=E3=80=81if kernel is uncompressed. we do not need to relocate
kernel image for decompression

2=E3=80=81if kaslr is disabled, we do not need to do a memory copy
before prase_elf.

Two memory copies can be skipped with this patch. this can
save aboat 20ms during booting.

Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
---
 arch/x86/boot/compressed/head_64.S |  8 ++++++--
 arch/x86/boot/compressed/misc.c    | 22 +++++++++++++++++-----
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S
b/arch/x86/boot/compressed/head_64.S
index d33f060900d2..9e7770c7047b 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -398,10 +398,13 @@ SYM_CODE_START(startup_64)
 1:

        /* Target address to relocate to for decompression */
+#ifdef CONFIG_KERNEL_UNCOMPRESSED
+       movq %rbp, %rbx
+#else
        movl    BP_init_size(%rsi), %ebx
        subl    $ rva(_end), %ebx
        addq    %rbp, %rbx
-
+#endif
        /* Set up the stack */
        leaq    rva(boot_stack_end)(%rbx), %rsp

@@ -522,6 +525,7 @@ trampoline_return:
  * Copy the compressed kernel to the end of our buffer
  * where decompression in place becomes safe.
  */
+#ifndef CONFIG_KERNEL_UNCOMPRESSED
        pushq   %rsi
        leaq    (_bss-8)(%rip), %rsi
        leaq    rva(_bss-8)(%rbx), %rdi
@@ -531,7 +535,7 @@ trampoline_return:
        rep     movsq
        cld
        popq    %rsi
-
+#endif
        /*
         * The GDT may get overwritten either during the copy we just did o=
r
         * during extract_kernel below. To avoid any issues, repoint the GD=
TR
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/mis=
c.c
index c23c0f525d93..d8445562d4e9 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -290,7 +290,7 @@ static inline void handle_relocations(void
*output, unsigned long output_len,
 { }
 #endif

-static void parse_elf(void *output)
+static void parse_elf(void *output, void *input)
 {
 #ifdef CONFIG_X86_64
        Elf64_Ehdr ehdr;
@@ -302,7 +302,7 @@ static void parse_elf(void *output)
        void *dest;
        int i;

-       memcpy(&ehdr, output, sizeof(ehdr));
+       memcpy(&ehdr, input, sizeof(ehdr));
        if (ehdr.e_ident[EI_MAG0] !=3D ELFMAG0 ||
           ehdr.e_ident[EI_MAG1] !=3D ELFMAG1 ||
           ehdr.e_ident[EI_MAG2] !=3D ELFMAG2 ||
@@ -317,7 +317,7 @@ static void parse_elf(void *output)
        if (!phdrs)
                error("Failed to allocate space for phdrs");

-       memcpy(phdrs, output + ehdr.e_phoff, sizeof(*phdrs) * ehdr.e_phnum)=
;
+       memcpy(phdrs, input + ehdr.e_phoff, sizeof(*phdrs) * ehdr.e_phnum);

        for (i =3D 0; i < ehdr.e_phnum; i++) {
                phdr =3D &phdrs[i];
@@ -334,7 +334,7 @@ static void parse_elf(void *output)
 #else
                        dest =3D (void *)(phdr->p_paddr);
 #endif
-                       memmove(dest, output + phdr->p_offset, phdr->p_file=
sz);
+                       memmove(dest, input + phdr->p_offset, phdr->p_files=
z);
                        break;
                default: /* Ignore other PT_* */ break;
                }
@@ -467,9 +467,21 @@ asmlinkage __visible void *extract_kernel(void
*rmode, memptr heap,
 #endif

        debug_putstr("\nDecompressing Linux... ");
+
+#ifdef CONFIG_KERNEL_UNCOMPRESSED
+       if (cmdline_find_option_bool("nokaslr")) {
+               parse_elf(output, input_data);
+       } else {
+               __decompress(input_data, input_len, NULL, NULL,
output, output_len,
+                               NULL, error);
+               parse_elf(output, output);
+       }
+#else
        __decompress(input_data, input_len, NULL, NULL, output, output_len,
                        NULL, error);
-       parse_elf(output);
+       parse_elf(output, output);
+#endif
+
        handle_relocations(output, output_len, virt_addr);
        debug_putstr("done.\nBooting the kernel.\n");

--
2.31.1
