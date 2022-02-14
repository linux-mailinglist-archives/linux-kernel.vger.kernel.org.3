Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C70B4B43FC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 09:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242114AbiBNIVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 03:21:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241958AbiBNIVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:21:12 -0500
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AD525C50;
        Mon, 14 Feb 2022 00:21:03 -0800 (PST)
Received: by mail-vk1-f174.google.com with SMTP id j201so1284560vke.11;
        Mon, 14 Feb 2022 00:21:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/wocXln3OZyzUJ8vGAcSbzur2Qk8XU2C//sjVsqiZdk=;
        b=NVQjmn0QyroeKSZU4E3NtQ5dYmq1DUR/y65n5QyJq8FZwM+I/2de3KVc2eW2DzFUJf
         6COjUIADRYFLVrKCeefDccdb1pf6vSR39EsBr6O/q39AnGLMZTzjjog8zkDnQmsCswmB
         dZXykX31199jBURoK1LzjQ5bqkJKSc8witio7l+WfBQno50W2ly3U/uF5Cn6yIjqrXiK
         /ExRt9HT0xV7BIL0mKHKaW6zx3zv1pvQ3RpnqgAUoytPHHhuQt5F626+GXUD5G8r20c/
         9BZM/qJuoA+PoFOt4LaTqArUR1djJIr+moKUc++jkAuZMGsV1NFmNWR9fKuilpLU7A0P
         +e3Q==
X-Gm-Message-State: AOAM531Q+bEeiogsOlNa5iG3Gi+k3I6UwXtBEH2vs7c0Rjcay3Y+vjuk
        eXZD5YhGP4n2pnEEN0UTwRXyqptR/TX9dg==
X-Google-Smtp-Source: ABdhPJx2mBWqH4U/meWSL7xcgGpcjIcevsE8C6AbZOTJe/t4Ykw47p8SRbwXWdSwc8zz4LeT4zczOQ==
X-Received: by 2002:a05:6122:90a:: with SMTP id j10mr3456759vka.5.1644826861235;
        Mon, 14 Feb 2022 00:21:01 -0800 (PST)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id dc4sm4851132vsb.31.2022.02.14.00.21.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 00:21:00 -0800 (PST)
Received: by mail-vk1-f181.google.com with SMTP id t19so7238523vkl.0;
        Mon, 14 Feb 2022 00:21:00 -0800 (PST)
X-Received: by 2002:a05:6122:c8f:: with SMTP id ba15mr3700134vkb.39.1644826860129;
 Mon, 14 Feb 2022 00:21:00 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2202122313460.34636@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2202122313460.34636@angie.orcam.me.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Feb 2022 09:20:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW-utcFzCZTgqONjxs=U662nF0=aBQu7Zi7FBQouwiA3g@mail.gmail.com>
Message-ID: <CAMuHMdW-utcFzCZTgqONjxs=U662nF0=aBQu7Zi7FBQouwiA3g@mail.gmail.com>
Subject: Re: [PATCH] parport_pc: Also enable driver for PCI systems
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
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

Hi Maciej,

CC Niklas

On Sun, Feb 13, 2022 at 1:45 PM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
> Nowadays PC-style parallel ports come in the form of PCI and PCIe option
> cards and there are some combined parallel/serial option cards as well
> that we handle in the parport subsystem.  There is nothing in particular
> that would prevent them from being used in any system equipped with PCI
> or PCIe connectivity, except that we do not permit the PARPORT_PC config
> option to be selected for platforms for which ARCH_MIGHT_HAVE_PC_PARPORT
> has not been set for.
>
> The only PCI platforms that actually can't make use of PC-style parallel
> port hardware are those newer PCIe systems that have no support for I/O
> cycles in the host bridge, required by such parallel ports.  An example
> of such a host bridge is the POWER9 PHB4 device, but it is an exception
> rather than the norm.  Also it is not clear whether the serial port side

Note that this hardware dependency is being addressed in
"[RFC 00/32] Kconfig: Introduce HAS_IOPORT and LEGACY_PCI options"
https://lore.kernel.org/all/20211227164317.4146918-1-schnelle@linux.ibm.com/

> --- linux-macro.orig/drivers/parport/Kconfig
> +++ linux-macro/drivers/parport/Kconfig
> @@ -42,7 +42,7 @@ if PARPORT
>
>  config PARPORT_PC
>         tristate "PC-style hardware"
> -       depends on ARCH_MIGHT_HAVE_PC_PARPORT
> +       depends on ARCH_MIGHT_HAVE_PC_PARPORT || PCI
>         help
>           You should say Y here if you have a PC-style parallel port. All
>           IBM PC compatible computers and some Alphas have PC-style
> @@ -77,7 +77,7 @@ config PARPORT_PC_FIFO
>
>  config PARPORT_PC_SUPERIO
>         bool "SuperIO chipset support"
> -       depends on PARPORT_PC && !PARISC
> +       depends on ARCH_MIGHT_HAVE_PC_PARPORT && PARPORT_PC && !PARISC
>         help
>           Saying Y here enables some probes for Super-IO chipsets in order to
>           find out things like base addresses, IRQ lines and DMA channels.  It
>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
