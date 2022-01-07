Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA23487591
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 11:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346738AbiAGKaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 05:30:46 -0500
Received: from mail-ua1-f46.google.com ([209.85.222.46]:44597 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346741AbiAGKal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:30:41 -0500
Received: by mail-ua1-f46.google.com with SMTP id w20so1364317uau.11;
        Fri, 07 Jan 2022 02:30:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RGgP7y0aXiT4g111XoTwdiVxToHFrLX50wjMftuTpaI=;
        b=8Hu7ItbmZMv08MCdyyBdBYqu5suw/c4aTypKCXK2u1n+Y/FhSzcXjWmd3phM0UIZNw
         W0M+8c/z2AxtLa0ZtZoaMDOo9gFe9D3SmioUbZIk1KKWrmHliKMAN5PRa2udlXr/11ft
         /fC1eOMcQkANvFKRs/qN92aHoYU/xNNbfxvhu7jllJs9DYa1NbpgcMpZMBwtGRcpfWe4
         bAVSSQ06sHVLyrBKXaB6Sr2PtmstxE0HjfAcVsc7cx5/ZqDIZh7aKBq6y2XvLakXnDVO
         zH8MloUQdGL9SKbqCLBPsAZbDawiYV+qL1X12+8RKQMiCruYQqIC7sxp37bZV0L/RoBH
         nCsQ==
X-Gm-Message-State: AOAM530E9gu5knzsrxjFFb+SoL372XESkOzgV/ZAS93xwK5/d4O+jeGE
        o3hUGNADIXMuxWY6zPSphaukoeW5kbUIFg==
X-Google-Smtp-Source: ABdhPJyeX0xUlRutdnlkCSDhUAE2U4Sa0Xc2OjlBnn5vW7FXYd7GMVGa6fodTu7k9AAxr9v8Y8fhzQ==
X-Received: by 2002:a05:6102:304b:: with SMTP id w11mr19486061vsa.44.1641551440631;
        Fri, 07 Jan 2022 02:30:40 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id i28sm2805707vkr.16.2022.01.07.02.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 02:30:40 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id y4so9423124uad.1;
        Fri, 07 Jan 2022 02:30:39 -0800 (PST)
X-Received: by 2002:ab0:7450:: with SMTP id p16mr8676770uaq.14.1641551439366;
 Fri, 07 Jan 2022 02:30:39 -0800 (PST)
MIME-Version: 1.0
References: <20220106174803.1773876-1-gsomlo@gmail.com> <20220106174803.1773876-4-gsomlo@gmail.com>
 <CAHp75Ve_jWmo3+Es0G5SyMpcdC_=hWfxHoa866Difd+X3F0uxg@mail.gmail.com>
 <YddyMI7hJE7u0jQ/@errol.ini.cmu.edu> <CAMuHMdX2ujViu9GivVHtgAqC6AdiL3CvdJM58pVteJe9KdvdqQ@mail.gmail.com>
 <YdgSG7t2eG9YzkaG@antec> <CAHp75VdjP4jmUQHUV=eF2Ot+s=3==ZqUS7BFxMoPDw=NkCBm6Q@mail.gmail.com>
 <CAMuHMdU1UqwKzE=tT4fdJb9EjJRJTsG2fGoLrBSOs_K22rY-sQ@mail.gmail.com>
In-Reply-To: <CAMuHMdU1UqwKzE=tT4fdJb9EjJRJTsG2fGoLrBSOs_K22rY-sQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 7 Jan 2022 11:30:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUCsEHKRS1hayf_u4dY=_ZsPdoHjjDs-kzcR8A5Vvhb1Q@mail.gmail.com>
Message-ID: <CAMuHMdUCsEHKRS1hayf_u4dY=_ZsPdoHjjDs-kzcR8A5Vvhb1Q@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] mmc: Add driver for LiteX's LiteSDCard interface
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Stafford Horne <shorne@gmail.com>,
        "Gabriel L. Somlo" <gsomlo@gmail.com>,
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
        Joel Stanley <joel@jms.id.au>, david.abdurachmanov@sifive.com,
        Florent Kermarrec <florent@enjoy-digital.fr>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 7, 2022 at 11:29 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Fri, Jan 7, 2022 at 11:25 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Fri, Jan 7, 2022 at 12:12 PM Stafford Horne <shorne@gmail.com> wrote:
> > > On Fri, Jan 07, 2022 at 10:36:12AM +0100, Geert Uytterhoeven wrote:
> > > > On Thu, Jan 6, 2022 at 11:50 PM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> >
> > ...
> >
> > > > Many (most?) blurbs do mention the module name.
> > >
> > > I was doubting this as well, but I searched and its true.  The text 'module will
> > > be called' shows up many times, there is also different text.
> > >
> > >  $ grep -r 'module will be called' drivers/ | wc
> > >    1347    9023   9086
> > >
> > >  $ grep -r 'tristate \"' drivers/ | wc
> > >    7169   47486  521795
> >
> > Just a side note: `git grep ...` is much faster in the Git trees.
>
> Indeed.
>
> > And for this particular case I dare to advertise a script I wrote [1]
> > to help with recursive searches.
> >
> > [1]: https://github.com/andy-shev/home-bin-tools/blob/master/gl4func.sh
>
> Cool!
>
> My fingers are used to type
>
>     git grep -w <pat1> -- $(git grep -lw <pat2> -- ...)
>
> ;-)

Actually you can just use git grep --and?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
