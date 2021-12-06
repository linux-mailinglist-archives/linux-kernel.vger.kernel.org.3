Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF17469586
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243008AbhLFMU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:20:28 -0500
Received: from mail-ua1-f42.google.com ([209.85.222.42]:39499 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242106AbhLFMU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:20:27 -0500
Received: by mail-ua1-f42.google.com with SMTP id i6so19026765uae.6;
        Mon, 06 Dec 2021 04:16:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Srd3grpzyUdIJ0E+3EKXjRD/brJ/Q2nJ/VLii3fnOLY=;
        b=AUbgqZvdUIdwMKzKHTs6U4lsRraRt44Cw4J1J5U1Cn6Sv0SxZR5eGzutOMz7llMR+m
         30HcWyTyabIb4vl78Eekq2e5Apr6OSh8sz+sxIH8teoJzGaCNS4NB7e6uUalQvjdcCnA
         2KzPedC9utK2ZfImAR4Kb7ml4nNGMwR0PONd+PKzw4J6HD2+DVa9+fR5writQ/tdLGEK
         24Py5XExh4y4TK/wiywtaTKLmJHnLykoMK7JlgHVml+4hdV0iM5UNckGtPXefGob9yRM
         MZ0cu5RfXarGrKfbcakrZ4vZOJ4X9lm3YhIWJUebO4nN9+cb3fDsmG7nNbF3vPnIw2v2
         hCjw==
X-Gm-Message-State: AOAM531YVF0HogVeFdkfyvddyKnf3GpSkflyYzKodsC9xRqSc2dca9eW
        PSFiEvd4Uz8td3NkGAg5Hs8y/p+PLENu8Q==
X-Google-Smtp-Source: ABdhPJwRXdyEkS2Yqv3ENDo/UZef/nujrSH39Br+EY5GLQULX/inCPumwGj3enaswMwfn5NrVqpfdQ==
X-Received: by 2002:a05:6102:e88:: with SMTP id l8mr35465943vst.55.1638793012861;
        Mon, 06 Dec 2021 04:16:52 -0800 (PST)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id h7sm4069346vkk.2.2021.12.06.04.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 04:16:52 -0800 (PST)
Received: by mail-ua1-f42.google.com with SMTP id ay21so18996254uab.12;
        Mon, 06 Dec 2021 04:16:52 -0800 (PST)
X-Received: by 2002:a05:6102:c89:: with SMTP id f9mr35536042vst.68.1638793011850;
 Mon, 06 Dec 2021 04:16:51 -0800 (PST)
MIME-Version: 1.0
References: <20211203234155.2319803-1-gsomlo@gmail.com> <20211203234155.2319803-4-gsomlo@gmail.com>
 <CACPK8XfO_8=vgedmZddz1YmWbyxiM1-azF_j88wEBHzXnP6y_g@mail.gmail.com>
In-Reply-To: <CACPK8XfO_8=vgedmZddz1YmWbyxiM1-azF_j88wEBHzXnP6y_g@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 6 Dec 2021 13:16:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXxO-CP0Ao8q8r4Gw5e5FzCznhSxt2JWz13zbnt2tnzVQ@mail.gmail.com>
Message-ID: <CAMuHMdXxO-CP0Ao8q8r4Gw5e5FzCznhSxt2JWz13zbnt2tnzVQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] mmc: Add driver for LiteX's LiteSDCard interface
To:     Joel Stanley <joel@jms.id.au>
Cc:     Gabriel Somlo <gsomlo@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Kamil Rakoczy <krakoczy@antmicro.com>,
        mdudek@internships.antmicro.com,
        Paul Mackerras <paulus@ozlabs.org>,
        Stafford Horne <shorne@gmail.com>,
        david.abdurachmanov@sifive.com,
        Florent Kermarrec <florent@enjoy-digital.fr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

On Mon, Dec 6, 2021 at 11:53 AM Joel Stanley <joel@jms.id.au> wrote:
>  On Fri, 3 Dec 2021 at 23:42, Gabriel Somlo <gsomlo@gmail.com> wrote:
> > LiteX (https://github.com/enjoy-digital/litex) is a SoC framework
> > that targets FPGAs. LiteSDCard is a small footprint, configurable
> > SDCard core commonly used in LiteX designs.
> >
> > The driver was first written in May 2020 and has been maintained
> > cooperatively by the LiteX community. Thanks to all contributors!
> >
> > Co-developed-by: Kamil Rakoczy <krakoczy@antmicro.com>
> > Signed-off-by: Kamil Rakoczy <krakoczy@antmicro.com>
> > Co-developed-by: Maciej Dudek <mdudek@internships.antmicro.com>
> > Signed-off-by: Maciej Dudek <mdudek@internships.antmicro.com>
> > Co-developed-by: Paul Mackerras <paulus@ozlabs.org>
> > Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>

> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig

> Did you test using this as a module?
>
> > +       depends on OF && LITEX
>
> I don't like having litex drivers depend on the LITEX kconfig. The
> symbol is not user visible, and to enable it we need to build in the
> litex controller driver, which platforms may or may not have.
>
> The microwatt platform is an example of a SoC that embeds some LITEX
> IP, but may or may not be a litex SoC.

I do like the LITEX dependency, as it allows us to gate off a bunch of
related drivers, and avoid annoying users with questions about them,
using a single symbol.

Originally, people told me the system controller is always present,
hence the current logic to have LITEX_SOC_CONTROLLER visible, and
an invisible LITEX (which is shorter to type) for individual drivers
to depend on.

Perhaps the logic should be reworked, now the old assumptions are no
longer true?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
