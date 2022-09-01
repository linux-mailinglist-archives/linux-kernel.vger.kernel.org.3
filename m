Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745D75A9877
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbiIANXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbiIANWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:22:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF11513F2A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 06:21:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 598E961F52
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 13:21:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD809C43148
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 13:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662038475;
        bh=nDXzklRc+sK26N6ixMCfRzyKwyZFZkTPPxwPBTRopmU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dHD4qRVoLYYEzjg5FYo902H7yN0QeV0ggXWmDqWmAEZtzwNAVZfajtjN0zytMYDnp
         LmEt9s6Fqpzox1D6ar8+KgUJZrabtlHs64u4h/h7eunxqq6+Ib+lpQ3Y4W+FVQc7mk
         sycikozRjjc+XX/0bT6fTuBzhOsa33SNTBfHhCv8XnSPRIQ0zelzge2Dx33ZiblJC4
         TGPUvUXV+968mXG6cxLIIMfwMlNFgc9vZiHHM8986CEEVwjnp1W9t4qqXHyMq/Kd7d
         NU02FhWeo9/djAw9baANbguBTarHORknHLlFI50dOyiHWbp8C5+xrFiA//eY+VGnEf
         UA6kyjHeiCRHQ==
Received: by mail-vk1-f172.google.com with SMTP id x66so8229852vkb.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 06:21:15 -0700 (PDT)
X-Gm-Message-State: ACgBeo2g76MSaFKdGr6SPC3pL9aIrhwEhrOrxctBF0fZxfNe/XW2MQ3V
        EP1OJby1HI1X7Tv+BsUOLF+F2U55Oi/ARdxt6g==
X-Google-Smtp-Source: AA6agR7LIB/XF3yfBOGSCexMSd6RVkp0XmXs3cv36zfG9f1NFCoHtgShUSmbVhcb88Y3IJlGjbu2TIRcdfY9CAr3MpE=
X-Received: by 2002:a05:6122:d86:b0:37d:3fe:df43 with SMTP id
 bc6-20020a0561220d8600b0037d03fedf43mr8392063vkb.15.1662038474465; Thu, 01
 Sep 2022 06:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220316023356.120595-1-victor@allwinnertech.com>
 <CGME20220831115257eucas1p20d37a01c51e42767860920a936255bd7@eucas1p2.samsung.com>
 <9a425a51-9460-6c4d-e331-5cd5873f8a43@samsung.com> <dda053b1-2d4f-153b-b811-78021eae3882@allwinnertech.com>
 <6c14e174-cdb6-c1fc-58cc-d579111d2328@allwinnertech.com>
In-Reply-To: <6c14e174-cdb6-c1fc-58cc-d579111d2328@allwinnertech.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 1 Sep 2022 08:21:02 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKEEc=sWdNURUoM8mR675Fz-4VfsFQXxnPCtiOQ5QfM0w@mail.gmail.com>
Message-ID: <CAL_JsqKEEc=sWdNURUoM8mR675Fz-4VfsFQXxnPCtiOQ5QfM0w@mail.gmail.com>
Subject: Re: [PATCH] ARM: mmu: fix access to illegal address when using
 earlycon & memblock=debug
To:     Victor Hassan <victor@allwinnertech.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        yanfei.xu@windriver.com, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 1, 2022 at 7:54 AM Victor Hassan <victor@allwinnertech.com> wrote:
>
>
>
> On 2022/8/31 20:37, Victor Hassan wrote:
> > On 8/31/2022 7:52 PM, Marek Szyprowski wrote:
> >> Hi Victor,
> >>
> >> On 16.03.2022 03:33, Victor Hassan wrote:
> >>> earlycon uses fixmap to create a memory map,
> >>> So we need to close earlycon before closing fixmap,
> >>> otherwise printk will access illegal addresses.

How? Due to recent changes in how printk and the consoles work or just
because create_mapping() can print? In the latter case, the only
variable input is the phys address. I think most if not all prints
cannot occur.

> >>> After creating a new memory map, we open earlycon again.
> >>>
> >>> Signed-off-by: Victor Hassan <victor@allwinnertech.com>
> >>
> >> This patch landed in linux next-20220831 as commit a76886d117cb ("ARM:
> >> 9223/1: mmu: fix access to illegal address when using earlycon &
> >> memblock=debug"). Unfortunately it breaks booting of all my test boards
> >> which *do not* use earlycon. It can be easily reproduced even with QEMU.
> >>
> >> With kernel compiled from multi_v7_defconfig the following setup boots:
> >>
> >> $ qemu-system-arm -nographic -kernel arch/arm/boot/zImage -append
> >> "console=ttyAMA0 earlycon" -M virt -smp 2 -m 512
> >>
> >> while this one doesn't:
> >>
> >> $ qemu-system-arm -nographic -kernel arch/arm/boot/zImage -append
> >> "console=ttyAMA0" -M virt -smp 2 -m 512
> >>
> >>
> >>> ---
> >>>    arch/arm/mm/mmu.c | 7 +++++++
> >>>    1 file changed, 7 insertions(+)
> >>>
> >>> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> >>> index 274e4f73fd33..f3511f07a7d0 100644
> >>> --- a/arch/arm/mm/mmu.c
> >>> +++ b/arch/arm/mm/mmu.c
> >>> @@ -14,6 +14,7 @@
> >>>    #include <linux/fs.h>
> >>>    #include <linux/vmalloc.h>
> >>>    #include <linux/sizes.h>
> >>> +#include <linux/console.h>
> >>>    #include <asm/cp15.h>
> >>>    #include <asm/cputype.h>
> >>> @@ -1695,6 +1696,9 @@ static void __init early_fixmap_shutdown(void)
> >>>        pmd_clear(fixmap_pmd(va));
> >>>        local_flush_tlb_kernel_page(va);
> >>> +#ifdef CONFIG_FIX_EARLYCON_MEM
> >>> +    console_stop(console_drivers);
> >>> +#endif
> >>>        for (i = 0; i < __end_of_permanent_fixed_addresses; i++) {
> >>>            pte_t *pte;
> >>>            struct map_desc map;
> >>> @@ -1713,6 +1717,9 @@ static void __init early_fixmap_shutdown(void)
> >>>            create_mapping(&map);
> >>>        }
> >>> +#ifdef CONFIG_FIX_EARLYCON_MEM
> >>> +    console_start(console_drivers);
> >>> +#endif
> >>>    }
> >>>    /*
> >>
> >> Best regards
> >
> > Dear Marek,
> > Thank you for the notice. I'll figure it out and feed back to you as
> > soon as possible.
> >
> > Regards,
> > Victor
>
> Hi Marek,
>
> Sorry, didn't take into account that console_drivers is NULL when
> earlycon is not used.
>
> Here is the patch-v2. Please review:
>
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index a49f0b9..a240f38 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -14,6 +14,7 @@
>   #include <linux/fs.h>
>   #include <linux/vmalloc.h>
>   #include <linux/sizes.h>
> +#include <linux/console.h>
>
>   #include <asm/cp15.h>
>   #include <asm/cputype.h>
> @@ -1730,6 +1731,10 @@
>         pmd_clear(fixmap_pmd(va));
>         local_flush_tlb_kernel_page(va);
>
> +#ifdef CONFIG_FIX_EARLYCON_MEM

This is always true for CONFIG_MMU and this file is only built for
CONFIG_MMU. So you don't need it.

> +       if (console_drivers)
> +               console_stop(console_drivers);

console_drivers is a list, so you are only stopping the 1st one.
Couldn't console_lock() be used here?

Also, this should be before pmd_clear().

> +#endif
>         for (i = 0; i < __end_of_permanent_fixed_addresses; i++) {
>                 pte_t *pte;
>                 struct map_desc map;
> @@ -1748,6 +1753,10 @@
>
>                 create_mapping(&map);
>         }
> +#ifdef CONFIG_FIX_EARLYCON_MEM
> +       if (console_drivers)
> +               console_start(console_drivers);
> +#endif
>   }
>
> BTW, should I resend the patch-v2 through the site
> (https://www.armlinux.org.uk/developer/patches/add.php), or should I
> send the patch-v2 through E-mail to Linux-Mainline?
>
> Thanks you.
>
> Regards,
> Victor
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
