Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977624874D8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 10:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236971AbiAGJgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 04:36:42 -0500
Received: from mail-ua1-f46.google.com ([209.85.222.46]:34308 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346482AbiAGJgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 04:36:25 -0500
Received: by mail-ua1-f46.google.com with SMTP id y4so9213305uad.1;
        Fri, 07 Jan 2022 01:36:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xs5sARW7mpfzDA0KwWiz8yZyJQ7czca4eMuvBIQUrKc=;
        b=zoaa7OyJa1OgsfkA4h6N2EnPfJ99FtaL2s/ybK/hz1ZIczbYjrfKFhNfJeBGqCgyZj
         tNBkaB+EjjbevED0wKtUX4Vf5SYDzSQH2wBr1qFjtzxVYpLXj7CeoxQNRmcC8oEJX1GH
         JdQkSiOtRkn2WiUg3eH7omcGWOhDV3HWu0xyo1NlA59dJsQpCLPfrtPEdOWG9LW7xvB4
         BzqM60Y8u7UzcbkTkPIH7FkQsmlpfGf+Xfdh9P6peKE1PpheAL3UBZhM2sktVPtG33WK
         a+eoFEZ8d/pizOwvjIgInLEIsta6I1N6mCn4+LxeYijM2yk00k3p2qnnV8imURm7F6au
         As3g==
X-Gm-Message-State: AOAM533ZSjclzHdkXsaD1UTMFT/05dKPoZFqv2Nc/+J1Tdyx8qXFHRNM
        wgjphB5/NFKToUwOV0/TteKPnHr5/d3wEg==
X-Google-Smtp-Source: ABdhPJwYFwF4jsFgKBpxI/AHtYDqxp0T1psqtf+9OE/vDHWVlpF03Griu5wja/kSDL4ozhSj64UJWg==
X-Received: by 2002:a05:6102:38ce:: with SMTP id k14mr20332637vst.70.1641548184771;
        Fri, 07 Jan 2022 01:36:24 -0800 (PST)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id k15sm3211134vsj.3.2022.01.07.01.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 01:36:24 -0800 (PST)
Received: by mail-vk1-f181.google.com with SMTP id o2so3360135vkn.0;
        Fri, 07 Jan 2022 01:36:23 -0800 (PST)
X-Received: by 2002:a05:6122:189e:: with SMTP id bi30mr6708723vkb.0.1641548183865;
 Fri, 07 Jan 2022 01:36:23 -0800 (PST)
MIME-Version: 1.0
References: <20220106174803.1773876-1-gsomlo@gmail.com> <20220106174803.1773876-4-gsomlo@gmail.com>
 <CAHp75Ve_jWmo3+Es0G5SyMpcdC_=hWfxHoa866Difd+X3F0uxg@mail.gmail.com> <YddyMI7hJE7u0jQ/@errol.ini.cmu.edu>
In-Reply-To: <YddyMI7hJE7u0jQ/@errol.ini.cmu.edu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 7 Jan 2022 10:36:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX2ujViu9GivVHtgAqC6AdiL3CvdJM58pVteJe9KdvdqQ@mail.gmail.com>
Message-ID: <CAMuHMdX2ujViu9GivVHtgAqC6AdiL3CvdJM58pVteJe9KdvdqQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] mmc: Add driver for LiteX's LiteSDCard interface
To:     "Gabriel L. Somlo" <gsomlo@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
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
        Joel Stanley <joel@jms.id.au>,
        Stafford Horne <shorne@gmail.com>,
        david.abdurachmanov@sifive.com,
        Florent Kermarrec <florent@enjoy-digital.fr>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gabriel,

On Thu, Jan 6, 2022 at 11:50 PM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> On Thu, Jan 06, 2022 at 08:19:39PM +0200, Andy Shevchenko wrote:
> > On Thu, Jan 6, 2022 at 7:48 PM Gabriel Somlo <gsomlo@gmail.com> wrote:
> > >
> > > LiteX (https://github.com/enjoy-digital/litex) is a SoC framework
> > > that targets FPGAs. LiteSDCard is a small footprint, configurable
> > > SDCard core commonly used in LiteX designs.
> > >
> > > The driver was first written in May 2020 and has been maintained
> > > cooperatively by the LiteX community. Thanks to all contributors!
> >
> > > +config MMC_LITEX
> > > +       tristate "LiteX MMC Host Controller support"
> > > +       depends on OF
> > > +       depends on PPC_MICROWATT || LITEX || COMPILE_TEST
> > > +       help
> > > +         This selects support for the MMC Host Controller found in LiteX SoCs.
> > > +
> > > +         If unsure, say N.
> >
> > What would be the module name if built as a module?
>
> litex_mmc.ko -- why are you asking? I.e., should I mention that anywhere
> in the Kconfig blurb (I don't see other blurbs doing that, fwiw)?

Many (most?) blurbs do mention the module name.

> > > +       div = min(max(div, 2U), 256U);
> >
> > clamp_t() / clamp_val() ?
>
> OK, changed to `div = clamp_val(div, 2U, 256U);`

Please use clamp() instead of clamp_val(), as all three parameters
have the same type (clamp_val() uses casts to align all parameters;
casts are evil).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
