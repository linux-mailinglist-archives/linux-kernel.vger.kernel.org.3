Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9DA4B1B65
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 02:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346914AbiBKBlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 20:41:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235662AbiBKBlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:41:39 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9AB559F;
        Thu, 10 Feb 2022 17:41:39 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id s18so9661084ioa.12;
        Thu, 10 Feb 2022 17:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g672afMOWPofXOHvvpzMvP9no/e9tuPgH5JHAmWPU8Y=;
        b=ndoVMRkaFlE5uP+00x6Ts/PUE4LWG3Od0SOLJomDYAqb3ExhfLwgb32rA1o8beLjTU
         669MmZKMX15+2uZ4xHxl/nuAiB4MC5f4GuqTd44R9Ccwp6W+NSAjFpoYPz1LiOj0/EGV
         pAJXYf7fLa3OWVsitFb3SATLm2AjkK+BmXKsIZTD2y8vV8wxMmUxBs4zQgaPRFn5USk9
         RRhd9aYY7jcQhPCEA48GHdkEJIqlW+PoQClKxy1hYn1m6XwVNnm25q/4XsLCuHKNK2gV
         /mQ/1sSrJg+/U583qtvsGhxdT4GYo2eU77OIYReybBY3h90tpeLH7GImTMCXBPRn1QoI
         L/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g672afMOWPofXOHvvpzMvP9no/e9tuPgH5JHAmWPU8Y=;
        b=UKIhDiZssm38K5pptJCB5FErO5kj8SKAbdAjHf8LJTRZPMwoiSX7wWkUnw4Qw6SCxZ
         ABO7Pfx9Kk5xUzmU5h6MMlqtV9RYf7bSxRhplTKDSo21gRsEaWO9SMdj9K7Au6ONpjp0
         E7qewWoBRNAmyvEwsGM8Sdc6Qt7WSfBdBambD+W2KZsifGOPZZdia5nv1wxe4UYeQlmT
         lXHqHfBHTNWi4xWnQAQ/SZfeWt/H/JrlbtSa07X5e75QdCphe9kvpWE0OPI6JoQj9FNN
         FcqKkkXBEAbAF/U7buGLs5o+v2Kubzc1PkZ5lkOhiKhPUCIsrdCMPWztH8L6wSXVowuH
         kgag==
X-Gm-Message-State: AOAM533XRp4fQ7v4dumPg3cKgn89k+2wIE9YXtcRCQQcB45pr3BXs/Bu
        AxuPX038iwUQogMQoRbx9mwktXK7aUQ3aUsFL9M=
X-Google-Smtp-Source: ABdhPJxC9eGByQeSdgYqYLzhyYHZME+2EFUVP1AXlEQbwcxc0ZAHjxxfggmaKLG8zVSb6vHb/m6iuUXgbaTmS/IX0qo=
X-Received: by 2002:a02:c8c8:: with SMTP id q8mr5164312jao.243.1644543698735;
 Thu, 10 Feb 2022 17:41:38 -0800 (PST)
MIME-Version: 1.0
References: <20220211001345.3429572-1-gch981213@gmail.com>
In-Reply-To: <20220211001345.3429572-1-gch981213@gmail.com>
From:   Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>
Date:   Thu, 10 Feb 2022 17:41:28 -0800
Message-ID: <CALCv0x3uYMovfqzobM6xfr8_apZQtz=DhyM-DsJe2L_rqAj65g@mail.gmail.com>
Subject: Re: [PATCH] MIPS: ralink: mt7621: do memory detection on KSEG1
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     "open list:MIPS" <linux-mips@vger.kernel.org>,
        Rui Salvaterra <rsalvaterra@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guo,

On Thu, Feb 10, 2022 at 4:14 PM Chuanhong Guo <gch981213@gmail.com> wrote:
>
> It's reported that current memory detection code occasionally detects
> larger memory under some bootloaders.
> Current memory detection code tests whether address space wraps around
> on KSEG0, which is unreliable because it's cached.
>
> Rewrite memory size detection to perform the same test on KSEG1 instead.
> While at it, this patch also does the following two things:
> 1. use a fixed pattern instead of a random function pointer as the magic
>    value.
> 2. add an additional memory write and a second comparison as part of the
>    test to prevent possible smaller memory detection result due to
>    leftover values in memory.
>
> Fixes: 139c949f7f0a MIPS: ("ralink: mt7621: add memory detection support")
> Reported-by: Rui Salvaterra <rsalvaterra@gmail.com>
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> ---
>  arch/mips/ralink/mt7621.c | 36 +++++++++++++++++++++++-------------
>  1 file changed, 23 insertions(+), 13 deletions(-)
>
> diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
> index d6efffd4dd20..12c8808e0dea 100644
> --- a/arch/mips/ralink/mt7621.c
> +++ b/arch/mips/ralink/mt7621.c
> @@ -22,7 +22,9 @@
>
>  #include "common.h"
>
> -static void *detect_magic __initdata = detect_memory_region;
> +#define MT7621_MEM_TEST_PATTERN         0xaa5555aa
> +
> +static u32 detect_magic __initdata;
>
>  int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
>  {
> @@ -58,24 +60,32 @@ phys_addr_t mips_cpc_default_phys_base(void)
>         panic("Cannot detect cpc address");
>  }
>
> +static bool __init mt7621_addr_wraparound_test(phys_addr_t size)
> +{
> +       void *dm = (void *)KSEG1ADDR(&detect_magic);
> +
> +       if (CPHYSADDR(dm + size) >= MT7621_LOWMEM_MAX_SIZE)
> +               return true;
> +       __raw_writel(MT7621_MEM_TEST_PATTERN, dm);
> +       if (__raw_readl(dm) != __raw_readl(dm + size))
> +               return false;
> +       __raw_writel(!MT7621_MEM_TEST_PATTERN, dm);
> +       return __raw_readl(dm) == __raw_readl(dm + size);
> +}
> +
>  static void __init mt7621_memory_detect(void)
>  {
> -       void *dm = &detect_magic;
>         phys_addr_t size;
>
> -       for (size = 32 * SZ_1M; size < 256 * SZ_1M; size <<= 1) {
> -               if (!__builtin_memcmp(dm, dm + size, sizeof(detect_magic)))
> -                       break;
> +       for (size = 32 * SZ_1M; size <= 256 * SZ_1M; size <<= 1) {
> +               if (mt7621_addr_wraparound_test(size)) {
> +                       memblock_add(MT7621_LOWMEM_BASE, size);
> +                       return;
> +               }
>         }
>
> -       if ((size == 256 * SZ_1M) &&
> -           (CPHYSADDR(dm + size) < MT7621_LOWMEM_MAX_SIZE) &&
> -           __builtin_memcmp(dm, dm + size, sizeof(detect_magic))) {
> -               memblock_add(MT7621_LOWMEM_BASE, MT7621_LOWMEM_MAX_SIZE);
> -               memblock_add(MT7621_HIGHMEM_BASE, MT7621_HIGHMEM_SIZE);
> -       } else {
> -               memblock_add(MT7621_LOWMEM_BASE, size);
> -       }
> +       memblock_add(MT7621_LOWMEM_BASE, MT7621_LOWMEM_MAX_SIZE);
> +       memblock_add(MT7621_HIGHMEM_BASE, MT7621_HIGHMEM_SIZE);
>  }
>
>  void __init ralink_of_remap(void)
> --
> 2.34.1
>
Thanks for your change. I think this will also fix
https://lore.kernel.org/lkml/202201191557.OISJHNMi-lkp@intel.com/
since you are removing __builtin_memcmp usage.

Ilya
