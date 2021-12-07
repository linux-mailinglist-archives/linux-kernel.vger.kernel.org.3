Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5816E46B507
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhLGIFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:05:25 -0500
Received: from mail-ua1-f51.google.com ([209.85.222.51]:35717 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbhLGIFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:05:24 -0500
Received: by mail-ua1-f51.google.com with SMTP id l24so24938571uak.2;
        Tue, 07 Dec 2021 00:01:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KcN9ex+/pkEUzYHt8cZEAymXHVVW/XeHcDIVVJmtosQ=;
        b=3ou7026aCzMbupKxsaxruMUPEjUE2p0n5TvMtRmTJ+eU6ZB2N+bxTZEHLWypwyNnXb
         PSlW3LSMT8WIxBC6ZyhbfgeqQIFsjU0YH+PPOc21NsXUshZQCAby1C3+EXQ88iqDeMi0
         idbM6D7geAWDWATzVYcF9K7GpWsv5TkWVBgkfNjXxhwRkWBe1Uwy8EhpcZwk7Maq7r6n
         nTUN3UVrVcJkH0UIaachMAgxyx+e1gWCYR9iQYYKyqYeN4vcQKY9Ll3iFzgrx+3HZNNI
         RT931vB+b/Aoyw9QUpYiumxSoO2Oz6hD9r83MpJcOaz6rQ1wxGr52ChkpKTNO7pCk5pX
         IlCw==
X-Gm-Message-State: AOAM533IHl0T2AWLOERgTEKoluWWGr2g54syf9n/c6nPNiKUSWxKiW9R
        YRLx8ls8Sq2PdZtmJImQOMgKyLlqZx9+sA==
X-Google-Smtp-Source: ABdhPJydBKYqevBdzHMgW/m6kC9Fo9xXsIpa+uAeautL6qV1lVBcBEiALuPk9xTzp30sDKyFGuINdg==
X-Received: by 2002:a67:6187:: with SMTP id v129mr42218061vsb.68.1638864114049;
        Tue, 07 Dec 2021 00:01:54 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id f132sm5790722vkf.18.2021.12.07.00.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 00:01:53 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id t13so24817604uad.9;
        Tue, 07 Dec 2021 00:01:53 -0800 (PST)
X-Received: by 2002:a67:c106:: with SMTP id d6mr43341091vsj.77.1638864113376;
 Tue, 07 Dec 2021 00:01:53 -0800 (PST)
MIME-Version: 1.0
References: <20211203234155.2319803-1-gsomlo@gmail.com> <20211203234155.2319803-4-gsomlo@gmail.com>
 <CACPK8XfO_8=vgedmZddz1YmWbyxiM1-azF_j88wEBHzXnP6y_g@mail.gmail.com>
 <CAMuHMdXxO-CP0Ao8q8r4Gw5e5FzCznhSxt2JWz13zbnt2tnzVQ@mail.gmail.com> <CACPK8XdF6WQDj9X1Nr0Hf6EzPkQtXBo75dj_WPsFq6nzfWPUrA@mail.gmail.com>
In-Reply-To: <CACPK8XdF6WQDj9X1Nr0Hf6EzPkQtXBo75dj_WPsFq6nzfWPUrA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Dec 2021 09:01:41 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXvHYB++NDCxgBkyhvxu57pGYVGUN4rcr=g+pXoUK+ZQw@mail.gmail.com>
Message-ID: <CAMuHMdXvHYB++NDCxgBkyhvxu57pGYVGUN4rcr=g+pXoUK+ZQw@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] mmc: Add driver for LiteX's LiteSDCard interface
To:     Joel Stanley <joel@jms.id.au>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Gabriel Somlo <gsomlo@gmail.com>,
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

On Tue, Dec 7, 2021 at 12:51 AM Joel Stanley <joel@jms.id.au> wrote:
> On Mon, 6 Dec 2021 at 12:16, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > +       depends on OF && LITEX
> > >
> > > I don't like having litex drivers depend on the LITEX kconfig. The
> > > symbol is not user visible, and to enable it we need to build in the
> > > litex controller driver, which platforms may or may not have.
> > >
> > > The microwatt platform is an example of a SoC that embeds some LITEX
> > > IP, but may or may not be a litex SoC.
> >
> > I do like the LITEX dependency, as it allows us to gate off a bunch of
> > related drivers, and avoid annoying users with questions about them,
> > using a single symbol.
>
> I appreciate your concern.
>
> We could do this:
>
>         depends on PPC_MICROWATT || LITEX || COMPILE_TEST
>
> It's unfortunate that kconfig doesn't let us describe the difference
> between "this driver requires this symbol" as it won't build and "this
> driver is only useful when this symbol is enabled". Traditionally I
> write kconfig to represent only the former, whereas you prefer both.

The former is expressed using:

    depends on FOO

The latter using:

    depends on BAR || COMPILE_TEST

Traditionally we only had the former. But with the introduction of
more and more dummy symbols for the !CONFIG_BAR case, the amount of
questions asked during configuration has become overwhelming.  At the
current pace, we'll reach 20K config symbols by v5.24 or so...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
