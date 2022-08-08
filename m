Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19EA58C73C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 13:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242836AbiHHLHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 07:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242833AbiHHLGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 07:06:50 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB8430C
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 04:06:35 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id 129so8416704vsq.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 04:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=EKDuEzuYuS3Cn+cVBzFlo28JwfDrSsg2ekxgT/POVi4=;
        b=bv3KtoCdU1EhsjEuzz99Z9MXv4XnT0woULl+KhEy5ebb6SreqE/1G6Iz4YM1JMNHRf
         JcGzcGHKAyadmopDVWR4AwxNymx13VsBxuZ7Uu4v2hg9NLV3jj1hyYcMRjNo4bb2kTQP
         2KwRTIwRbUms/DB+2YFAWpn3WpnMbUVxOmZHk+GBk/UDbhMBHn/1JwNotL0woMP7uFZM
         yWsIT/Kzedj3U7RfbO0f713fejHS46SJitgJkL/sBlRCulFvHx9GdjzjsjfsvUBk5rp+
         LP51V8W3yZW4uJ9FzFjlX7eVW8LwCKBHNUnEkgNrUBdrA89H4zkHlb1DdKqX17Zb8MlJ
         E53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=EKDuEzuYuS3Cn+cVBzFlo28JwfDrSsg2ekxgT/POVi4=;
        b=jRS5cPjKt91P66yzsAkMJ+pNM+3OlmPQc1OgOLE4e46VcsXSQxELKy8OxDFMM/HrJf
         GkaX2zxvJL8760rAUNfhBoUO0THEC5jc/i9keDHF4Qfs2P/a4qumTwLh34hDF8fWVds1
         YSOxmJLKtgvtDAymrteZadHdI1rKtvk0x2s7JPNaL0oRbd1MwH9TS+H93gXfN5LMl9UL
         OFK6DOjrhO+kTrEN820e46+MG33rX7gnOaGkLmGPNIpqg3/FR9MT8jWR9xy4pz+NecEz
         9kVGh5BRULJx71Lo7ttsFSvF6D0UFxq+laKDM7klunUnKhwEeIJuP9WbcBXv75iZCS8I
         craw==
X-Gm-Message-State: ACgBeo0Z/v2psKHIDuJXTNI7/Qaaci0dUx0FmxFf3oWCw96/MPgtnZWi
        cRgDIFYGontH42mMDbeWKh8zFcn4VgWdP2iqsH0=
X-Google-Smtp-Source: AA6agR6cLG+sEF6owJf3VKUO7FR5SO8vGXL5FKw/wJBmI/gk/uVmcwHjtG7Y6xU1N4c8tpk2JWOhOas4DxSLhv/QjdU=
X-Received: by 2002:a67:d595:0:b0:388:4392:e067 with SMTP id
 m21-20020a67d595000000b003884392e067mr7719285vsj.78.1659956794405; Mon, 08
 Aug 2022 04:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220808085319.3350111-1-chenhuacai@loongson.cn> <87edxrvymh.wl-maz@kernel.org>
In-Reply-To: <87edxrvymh.wl-maz@kernel.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Mon, 8 Aug 2022 19:06:23 +0800
Message-ID: <CAAhV-H43WQhdnn-QjEAu4gPVt9u7b5hfBXHM6jH2Tt08cBY0eg@mail.gmail.com>
Subject: Re: [PATCH] irqchip: Select downstream irqchip drivers for LoongArch CPU
To:     Marc Zyngier <maz@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        kernel test robot <lkp@intel.com>
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

Hi, Marc,

On Mon, Aug 8, 2022 at 6:05 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 08 Aug 2022 09:53:19 +0100,
> Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > LoongArch irqchips have a fixed hierarchy which currently can't be
> > described by ACPI tables, so upstream irqchip drivers call downstream
> > irqchip drivers' initialization directly. As a result, the top level
> > (CPU-level) irqchip driver should explicitly select downstream drivers
> > to avoid build errors.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/irqchip/Kconfig | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > index 66b9fa408bf2..2549daa859d6 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -561,6 +561,11 @@ config IRQ_LOONGARCH_CPU
> >       select GENERIC_IRQ_CHIP
> >       select IRQ_DOMAIN
> >       select GENERIC_IRQ_EFFECTIVE_AFF_MASK
> > +     select LOONGSON_LIOINTC
> > +     select LOONGSON_EIOINTC
> > +     select LOONGSON_PCH_PIC
> > +     select LOONGSON_PCH_MSI
> > +     select LOONGSON_PCH_LPC
>
> This triggers tons of pretty bad compilation and configuration issues,
> as PCI still isn't selectable, even in Linus' tree (see below). I'm
> guessing you still have local patches that hide this issue.
>
> Please test your patches on an upstream tree in the future.
I'm very sorry for that. I think this patch should be delayed after
5.20-rc1, then PCI code will have been merged.

Huacai
>
>         M.
>
> <log>
> $ make ARCH=loongarch CROSS_COMPILE=loongarch64-linux- -j 20 vmlinux
>   SYNC    include/config/auto.conf.cmd
>
> WARNING: unmet direct dependencies detected for LOONGSON_PCH_MSI
>   Depends on [n]: MACH_LOONGSON64 [=y] && PCI [=n]
>   Selected by [y]:
>   - IRQ_LOONGARCH_CPU [=y]
>
> WARNING: unmet direct dependencies detected for LOONGSON_PCH_MSI
>   Depends on [n]: MACH_LOONGSON64 [=y] && PCI [=n]
>   Selected by [y]:
>   - IRQ_LOONGARCH_CPU [=y]
>
> WARNING: unmet direct dependencies detected for LOONGSON_PCH_MSI
>   Depends on [n]: MACH_LOONGSON64 [=y] && PCI [=n]
>   Selected by [y]:
> [...]
> drivers/irqchip/irq-loongson-pch-msi.c:88:15: error: variable 'pch_msi_domain_info' has initializer but incomplete type
>    88 | static struct msi_domain_info pch_msi_domain_info = {
>       |               ^~~~~~~~~~~~~~~
> drivers/irqchip/irq-loongson-pch-msi.c:89:10: error: 'struct msi_domain_info' has no member named 'flags'
>    89 |         .flags  = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
>       |          ^~~~~
>   CC      mm/page-writeback.o
>   CC      io_uring/advise.o
> drivers/irqchip/irq-loongson-pch-msi.c:89:19: error: 'MSI_FLAG_USE_DEF_DOM_OPS' undeclared here (not in a function)
>    89 |         .flags  = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
>       |                   ^~~~~~~~~~~~~~~~~~~~~~~~
>   CC      fs/char_dev.o
>   CC      fs/stat.o
> drivers/irqchip/irq-loongson-pch-msi.c:89:46: error: 'MSI_FLAG_USE_DEF_CHIP_OPS' undeclared here (not in a function)
>    89 |         .flags  = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
>       |                                              ^~~~~~~~~~~~~~~~~~~~~~~~~
>   CC      security/security.o
>   AS      arch/loongarch/kernel/switch.o
>   CC      kernel/softirq.o
> drivers/irqchip/irq-loongson-pch-msi.c:90:19: error: 'MSI_FLAG_MULTI_PCI_MSI' undeclared here (not in a function)
>    90 |                   MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
>       |                   ^~~~~~~~~~~~~~~~~~~~~~
>   CC      crypto/dh_helper.o
>   CC      arch/loongarch/kernel/elf.o
> drivers/irqchip/irq-loongson-pch-msi.c:90:44: error: 'MSI_FLAG_PCI_MSIX' undeclared here (not in a function)
>    90 |                   MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
>       |                                            ^~~~~~~~~~~~~~~~~
> drivers/irqchip/irq-loongson-pch-msi.c:89:19: warning: excess elements in struct initializer
>    89 |         .flags  = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
>       |                   ^~~~~~~~~~~~~~~~~~~~~~~~
> drivers/irqchip/irq-loongson-pch-msi.c:89:19: note: (near initialization for 'pch_msi_domain_info')
> drivers/irqchip/irq-loongson-pch-msi.c:91:10: error: 'struct msi_domain_info' has no member named 'chip'
>    91 |         .chip   = &pch_msi_irq_chip,
>       |          ^~~~
> drivers/irqchip/irq-loongson-pch-msi.c:91:19: warning: excess elements in struct initializer
>    91 |         .chip   = &pch_msi_irq_chip,
>       |                   ^
> drivers/irqchip/irq-loongson-pch-msi.c:91:19: note: (near initialization for 'pch_msi_domain_info')
>   CC      sound/core/device.o
>   CC      drivers/gpio/gpiolib-sysfs.o
>   CC      io_uring/filetable.o
> drivers/irqchip/irq-loongson-pch-msi.c: In function 'pch_msi_init_domains':
> drivers/irqchip/irq-loongson-pch-msi.c:178:22: error: implicit declaration of function 'pci_msi_create_irq_domain'; did you mean 'pci_msi_get_device_domain'? [-Werror=implicit-function-declaration]
>   178 |         msi_domain = pci_msi_create_irq_domain(domain_handle,
>       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~
>       |                      pci_msi_get_device_domain
> drivers/irqchip/irq-loongson-pch-msi.c:178:20: warning: assignment to 'struct irq_domain *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>   178 |         msi_domain = pci_msi_create_irq_domain(domain_handle,
>       |                    ^
> drivers/irqchip/irq-loongson-pch-msi.c: At top level:
> drivers/irqchip/irq-loongson-pch-msi.c:88:31: error: storage size of 'pch_msi_domain_info' isn't known
>    88 | static struct msi_domain_info pch_msi_domain_info = {
>       |                               ^~~~~~~~~~~~~~~~~~~
> </log>
>
> --
> Without deviation from the norm, progress is not possible.
