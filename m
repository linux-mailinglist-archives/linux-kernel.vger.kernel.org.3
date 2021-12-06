Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5200B46AAF1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353736AbhLFVwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240900AbhLFVwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:52:33 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87796C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 13:49:04 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id t8so11712360ilu.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 13:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NRJ2Vq4GGEkOM9Z1L10C4gsdtd/cSS7963Dg1Lu81Vk=;
        b=O5oU/P9UojrjXnhFmSvebt4u3yIwBjy9ZlVDmW2FwCSlXQrNXuaD5T/r9nc5B38xCC
         UMw4UWCvWApqBXQs8X9vUho2pXiJ4diAJCIr8xX7ADGWbe4FgvqHeX46y5DNIL24PHuy
         KND30Hj31SIu/p3zJF9C6XBrKl1mLUuVXzlLthev7jJ3x/BuYvZhiRb2zPUL2H56ppZx
         y6Gdqj5bVS6v7rIjtVj5xZ2hTsPKnqoa/W76ijNxPLz6eNS3WJ9arjEZFwwflsbmOS9L
         mDNgAiqFm6UWSSn1UjRoKsP2Q8nKE5f3dVaHQMTa3Xiwg/GrkMABpHDz/c4kCfoFG+PN
         sW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NRJ2Vq4GGEkOM9Z1L10C4gsdtd/cSS7963Dg1Lu81Vk=;
        b=aJtPtKEwqc1Exau6uDlOfsqAbWbda3laJ/iYlH7jTm51HkRvw4Ymws/6MbOFWmExKf
         yfWDS3+ata4jFij7GknEkS6almqIKCS9Z+FsUqNWPPSJhWdpEJWc/iy0BtSNoqgjoSfu
         FFJfhkMjxUD8BIR/lSLvvX+GZ+L1RAPjEbw40hYqOQbcHnq6EFzy/+UEGFmQ0XhM/xDZ
         lBlCX22IkAjdbQt56nNFI4D0XX8no3GU6JDmZFOe/iXMSHk6tOYKX66obIE0F0MTFjn1
         o8oOqjgcqBcLGJ5TqKEwsAzQ1RBESRNjkLsJ5kZRp5+Wmh2jckyHJfsreWqRgDAmMw5h
         kuTw==
X-Gm-Message-State: AOAM53269zXl4JSHg+bOWTiU4zI5qWdQ+nbk1sldaIFdvlijR/eUslPT
        YATlHDQYpSOCB2yTne7qHE1oasujX46Ppp/ZV2s=
X-Google-Smtp-Source: ABdhPJyn5Di1ZCOMfCFI/yFYRKjnMDY8M7gCkGqKV4X0AyAj2tgSO/+Pf2Qsr1gPkUE3JoF1Ul+gUi8goVPxCOcZfqU=
X-Received: by 2002:a05:6e02:1605:: with SMTP id t5mr39279632ilu.233.1638827343979;
 Mon, 06 Dec 2021 13:49:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638825394.git.andreyknvl@google.com> <a1f0413493eb7db125c3f8086f5d8635b627fd2c.1638825394.git.andreyknvl@google.com>
In-Reply-To: <a1f0413493eb7db125c3f8086f5d8635b627fd2c.1638825394.git.andreyknvl@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 6 Dec 2021 22:48:52 +0100
Message-ID: <CA+fCnZezMmEtt1GKge_3JOudz+9SE_1fgVh1em+v10aNG6K5Gg@mail.gmail.com>
Subject: Re: [PATCH v2 24/34] kasan, vmalloc, arm64: mark vmalloc mappings as pgprot_tagged
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        andrey.konovalov@linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 10:46 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> HW_TAGS KASAN relies on ARM Memory Tagging Extension (MTE). With MTE,
> a memory region must be mapped as MT_NORMAL_TAGGED to allow setting
> memory tags via MTE-specific instructions.
>
> This change adds proper protection bits to vmalloc() allocations.
> These allocations are always backed by page_alloc pages, so the tags
> will actually be getting set on the corresponding physical memory.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Co-developed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/include/asm/vmalloc.h | 10 ++++++++++
>  include/linux/vmalloc.h          |  7 +++++++
>  mm/vmalloc.c                     |  2 ++
>  3 files changed, 19 insertions(+)
>
> diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
> index b9185503feae..3d35adf365bf 100644
> --- a/arch/arm64/include/asm/vmalloc.h
> +++ b/arch/arm64/include/asm/vmalloc.h
> @@ -25,4 +25,14 @@ static inline bool arch_vmap_pmd_supported(pgprot_t prot)
>
>  #endif
>
> +#define arch_vmalloc_pgprot_modify arch_vmalloc_pgprot_modify
> +static inline pgprot_t arch_vmalloc_pgprot_modify(pgprot_t prot)
> +{
> +       if (IS_ENABLED(CONFIG_KASAN_HW_TAGS) &&
> +                       (pgprot_val(prot) == pgprot_val(PAGE_KERNEL)))
> +               prot = pgprot_tagged(prot);
> +
> +       return prot;
> +}
> +
>  #endif /* _ASM_ARM64_VMALLOC_H */
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index b22369f540eb..965c4bf475f1 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -108,6 +108,13 @@ static inline int arch_vmap_pte_supported_shift(unsigned long size)
>  }
>  #endif
>
> +#ifndef arch_vmalloc_pgprot_modify
> +static inline pgprot_t arch_vmalloc_pgprot_modify(pgprot_t prot)
> +{
> +       return prot;
> +}
> +#endif
> +
>  /*
>   *     Highlevel APIs for driver use
>   */
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 7be18b292679..f37d0ed99bf9 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3033,6 +3033,8 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>                 return NULL;
>         }
>
> +       prot = arch_vmalloc_pgprot_modify(prot);
> +
>         if (vmap_allow_huge && !(vm_flags & VM_NO_HUGE_VMAP)) {
>                 unsigned long size_per_node;
>
> --
> 2.25.1
>

Hi Vincenzo,

This patch is based on an early version of the HW_TAGS series you had.
Could you PTAL and give your sign-off?

Thanks!
