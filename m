Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC5756848B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbiGFKD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiGFKDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:03:52 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E6824F13;
        Wed,  6 Jul 2022 03:03:51 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id he28so17481259qtb.13;
        Wed, 06 Jul 2022 03:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=moQR5LBdu+yLzctPNV/vOqPzvGKHHurzxQlNOu9l9Us=;
        b=EesshI2dz2nUcJOk+dJEmUXSyU3cxFbAF3MTtcsDp8HC89WnRnXWqs0B8xNoeB/GgQ
         Kk1KCc2xbvizzIvOcX53AE81Pn48RcI4/2BIrsQEMGWaEnc747JN4TZc+Fvyx6WdrMQE
         vapVQPFTaYrfLaAbQjPi0EDAIsQpB9A+KwjUqDu5dk36lixxywxCGSLhD0FHIsXYSWHX
         GoacpeCU5MfZjeNzf3VFoqUSw4P/zzx3XsYYCof4DeGjAVGDjlz9NatrkO7l6oOGJSmk
         V7buL3P6KGmMvhVXceC+0aTfruI1pFkCMFIDpubvvjZy8xWRy+lZFR64CCA9SfJs1Tdz
         26Yw==
X-Gm-Message-State: AJIora/0pgAHSDr5Jl9M1QDs/X9epQp27h5YxkSx5DiIofUd8y/wcu5b
        ahSInx7/NhO1sWkaCJ6AyqB53qqMEp9SM9VC
X-Google-Smtp-Source: AGRyM1u7clC6UC8AqvqBpVgGP0o5aTr2tLeLXw6o3mv3Gm2SPqaW5OaIs1i60ABw/dE1xxaHAT911A==
X-Received: by 2002:a05:622a:83:b0:31d:3362:7ef4 with SMTP id o3-20020a05622a008300b0031d33627ef4mr25065824qtw.32.1657101830944;
        Wed, 06 Jul 2022 03:03:50 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id fw3-20020a05622a4a8300b0031e7b06edbasm4844135qtb.67.2022.07.06.03.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 03:03:49 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-31c8a1e9e33so82387417b3.5;
        Wed, 06 Jul 2022 03:03:49 -0700 (PDT)
X-Received: by 2002:a0d:c787:0:b0:31b:a963:e1de with SMTP id
 j129-20020a0dc787000000b0031ba963e1demr44581975ywd.283.1657101828958; Wed, 06
 Jul 2022 03:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220630051630.1718927-1-anshuman.khandual@arm.com> <20220630051630.1718927-22-anshuman.khandual@arm.com>
In-Reply-To: <20220630051630.1718927-22-anshuman.khandual@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 Jul 2022 12:03:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX_Ji7dCzzCc3xw5ic6J=0PaPkyzXKpOgUFjjEkR+yJOw@mail.gmail.com>
Message-ID: <CAMuHMdX_Ji7dCzzCc3xw5ic6J=0PaPkyzXKpOgUFjjEkR+yJOw@mail.gmail.com>
Subject: Re: [PATCH V6 21/26] m68k/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Christoph Hellwig <hch@infradead.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On Thu, Jun 30, 2022 at 7:19 AM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
> This enables ARCH_HAS_VM_GET_PAGE_PROT on the platform and exports standard
> vm_get_page_prot() implementation via DECLARE_VM_GET_PAGE_PROT, which looks
> up a private and static protection_map[] array. Subsequently all __SXXX and
> __PXXX macros can be dropped which are no longer needed.
>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Thanks for your patch!

> --- a/arch/m68k/include/asm/mcf_pgtable.h
> +++ b/arch/m68k/include/asm/mcf_pgtable.h
> @@ -91,60 +91,6 @@
>   * for use. In general, the bit positions are xwr, and P-items are
>   * private, the S-items are shared.
>   */

The comment above should be removed, too.

> -#define __P000         PAGE_NONE
> -#define __P001         __pgprot(CF_PAGE_VALID \
> -                                | CF_PAGE_ACCESSED \
> -                                | CF_PAGE_READABLE)

> --- a/arch/m68k/include/asm/motorola_pgtable.h
> +++ b/arch/m68k/include/asm/motorola_pgtable.h
> @@ -83,28 +83,6 @@ extern unsigned long mm_cachebits;
>  #define PAGE_COPY_C    __pgprot(_PAGE_PRESENT | _PAGE_RONLY | _PAGE_ACCESSED)
>  #define PAGE_READONLY_C        __pgprot(_PAGE_PRESENT | _PAGE_RONLY | _PAGE_ACCESSED)

You might move the *_C definitions above into arch/m68k/mm/motorola.c
as well, as they are only used in the latter.

>
> -/*
> - * The m68k can't do page protection for execute, and considers that the same are read.
> - * Also, write permissions imply read permissions. This is the closest we can get..
> - */
> -#define __P000 PAGE_NONE_C
> -#define __P001 PAGE_READONLY_C
> -#define __P010 PAGE_COPY_C
> -#define __P011 PAGE_COPY_C
> -#define __P100 PAGE_READONLY_C
> -#define __P101 PAGE_READONLY_C
> -#define __P110 PAGE_COPY_C
> -#define __P111 PAGE_COPY_C
> -
> -#define __S000 PAGE_NONE_C
> -#define __S001 PAGE_READONLY_C
> -#define __S010 PAGE_SHARED_C
> -#define __S011 PAGE_SHARED_C
> -#define __S100 PAGE_READONLY_C
> -#define __S101 PAGE_READONLY_C
> -#define __S110 PAGE_SHARED_C
> -#define __S111 PAGE_SHARED_C
> -
>  #define pmd_pgtable(pmd) ((pgtable_t)pmd_page_vaddr(pmd))
>
>  /*
> diff --git a/arch/m68k/include/asm/sun3_pgtable.h b/arch/m68k/include/asm/sun3_pgtable.h
> index 5e4e753f0d24..9d919491765b 100644
> --- a/arch/m68k/include/asm/sun3_pgtable.h
> +++ b/arch/m68k/include/asm/sun3_pgtable.h
> @@ -71,23 +71,6 @@
>   * protection settings, valid (implying read and execute) and writeable. These
>   * are as close as we can get...
>   */

The comment above should be removed, too.

> -#define __P000 PAGE_NONE
> -#define __P001 PAGE_READONLY

With the above fixed:
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
