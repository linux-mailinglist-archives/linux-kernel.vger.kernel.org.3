Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2ED2517DF6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 08:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiECHCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiECHCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:02:08 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1229326D9;
        Mon,  2 May 2022 23:58:37 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id k2so6312041qtp.1;
        Mon, 02 May 2022 23:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AUzmMTUgoKr9MNwCNeWZmLPFdTrfpCaN2IVTJcYaoss=;
        b=jT7FNUlL2KmKGgUwwiRTCi6RkXeWMwQe6xByLGKyobiAhhComRz0oU4XsXtk1gOMWu
         wso8eFo7FYLxeDj7pHVVJ5t3qnJr1BUJdJ86cdKsNXXR9UV1JlARi8UQfyOcdmmq3Hey
         Lbof27+VUBQzOUApSlKF5ItoQUgT8+Y21qxHRlfbB2QQ4nrheQ6MHVgpKur5fmANfYyv
         FVniyAxIrBPr/ZEbDXUoTEYFdJYX3grpilN6gj3LMkEkpmV9HimDUpV8AjBKD+268JEz
         zAaIWLLwGfArmv9OiWH+41CN+tdg+znR4SCfZDdQ5yZJ2HjtVf9Kq3SVzexF608Gy2qT
         SHbw==
X-Gm-Message-State: AOAM532S9X7kTlE8XXI3RhBggYwSHyhx8PrfAL92kwS5yZff+tChefIs
        BqEX9342hAxlzAZmUOatJfcgSnxbYW2whg==
X-Google-Smtp-Source: ABdhPJyen2DRnuIlJmSY/3HLHL85whQ/No7lVhkGL06oylpP7qVa/wv6ESZVJWYngn5pymalpwpl2w==
X-Received: by 2002:ac8:110a:0:b0:2f1:ea84:b84 with SMTP id c10-20020ac8110a000000b002f1ea840b84mr13444274qtj.463.1651561116480;
        Mon, 02 May 2022 23:58:36 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id fp35-20020a05622a50a300b002f39b99f67asm5206624qtb.20.2022.05.02.23.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 23:58:35 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id h10so628893ybc.4;
        Mon, 02 May 2022 23:58:35 -0700 (PDT)
X-Received: by 2002:a25:6157:0:b0:645:8d0e:f782 with SMTP id
 v84-20020a256157000000b006458d0ef782mr13768923ybb.36.1651561115076; Mon, 02
 May 2022 23:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <2584ba18-9653-9310-efc1-8b3b3e221eea@omp.ru> <11021433-66c0-3c56-42bd-207a5ae8d267@physik.fu-berlin.de>
 <2ebef1ac-e5c5-980c-9413-22a6cccdfa1d@landley.net> <CAMuHMdWN0vRYhK7O0MgOSCtisw3RDvp4vxSS2VF-9uGDdOEb7g@mail.gmail.com>
 <59faed1d-3878-ce75-9f62-aaf4338d0ad1@omp.ru>
In-Reply-To: <59faed1d-3878-ce75-9f62-aaf4338d0ad1@omp.ru>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 May 2022 08:58:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWv_DK_h6eoemNbOqbErmWbVuv+r5qTC0=APNwV=vYNzQ@mail.gmail.com>
Message-ID: <CAMuHMdWv_DK_h6eoemNbOqbErmWbVuv+r5qTC0=APNwV=vYNzQ@mail.gmail.com>
Subject: Re: [PATCH v3] sh: avoid using IRQ0 on SH3/4
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Rob Landley <rob@landley.net>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

On Mon, May 2, 2022 at 10:56 PM Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
> On 5/2/22 11:37 AM, Geert Uytterhoeven wrote:
> >>>> Using IRQ0 by the platform devices is going to be disallowed soon (see [1])
> >>>> and even now, when IRQ0 is about to be returned by platfrom_get_irq(), you
> >>>> see a big warning.  The code supporting SH3/4 SoCs maps the IRQ #s starting
> >>>> at 0 -- modify that code to start the IRQ #s from 16 instead.
> >>>>
> >>>> The patch should mostly affect the AP-SH4A-3A/AP-SH4AD-0A boards as they
> >>>> indeed use IRQ0 for the SMSC911x compatible Ethernet chip...
> >
> >> As I told him in IRC, the problem is still that sh4 never gives me a shell
> >> prompt with this patch applied. I just reconfirmed it against current git:
> >>
> >> Freeing unused kernel image (initmem) memory: 124K
> >> This architecture does not have kernel memory protection.
> >> Run /init as init process
> >> mountpoint: dev/pts: No such file or directory
> >> 8139cp 0000:00:02.0 eth0: link up, 100Mbps, full-duplex, lpa 0x05E1
> >>
> >> It makes it partway through the init script, but it hangs with qemu-system-sh4
> >> stuck in a CPU-eating loop before finishing. Without the patch, I get a shell
> >> prompt.
> >
> > I regularly test on qemu rts7751r2d, but couldn't produce your
> > issue.  Until I tried "ifconfig eth0 up", which causes a lock-up.
> > Interestingly, the 8139 irq was 112 with and without Sergey's patch,
> > so there must be an irq remapping missing.
> >
> > I also test regularly on landisk, where 8139 Ethernet works fine.
> > Turns out landisk uses arch/sh/drivers/pci/fixups-landisk.c to fixup
> > the irq...
> >
> > arch/sh/include/mach-common/mach/r2d.h has:
> > #define R2D_FPGA_IRQ_BASE       100
> > Subtracting 16 here does not help.
>
>    Why subtract when you contrariwise need to add? :-)

Thanks, adding 16 here fixed the issue:

/ # ifconfig eth0 up
8139cp 0000:00:02.0 eth0: link up, 100Mbps, full-duplex, lpa 0x05E1

> > With this (gmail-whitespace-damaged) patch:
> >
> > --- a/arch/sh/drivers/pci/fixups-rts7751r2d.c
> > +++ b/arch/sh/drivers/pci/fixups-rts7751r2d.c
> > @@ -31,9 +31,9 @@ static char lboxre2_irq_tab[] = {
> >  int pcibios_map_platform_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
> >  {
> >         if (mach_is_lboxre2())
> > -               return lboxre2_irq_tab[slot];
> > +               return lboxre2_irq_tab[slot] - 16;
>
>    This table contains the values #define'd via evt2irq(), so
> shouldn't need to subtract anything...
>
> >         else
> > -               return rts7751r2d_irq_tab[slot];
> > +               return rts7751r2d_irq_tab[slot] - 16;
>
>    How about + 16?

Doesn't work, but changing R2D_FPGA_IRQ_BASE does work, see
above.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
