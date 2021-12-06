Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7986D46AEA3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 00:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377605AbhLFXzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 18:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377635AbhLFXzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 18:55:06 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B80C061746;
        Mon,  6 Dec 2021 15:51:37 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id m17so11449060qvx.8;
        Mon, 06 Dec 2021 15:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=irxdvYSeAdtdlqYqZPtlOv4U0i5Fz2HAUzP2/GQnZ7o=;
        b=NarHRNNY3zmdDjao/09C3SOmn/+Ta3Pdhvyo9ztKamruOrHXEicP5DSpy6YzI3Cigj
         yum/jpZfNhtj1XVeRSX3sy8IYol8JOJZdT57sB8801Z0DzX3GPO98IPMQbIHuiuL8MuF
         DYI6DFmiZVm6HGtc7Byu2amBgL5EGYoHKfZxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=irxdvYSeAdtdlqYqZPtlOv4U0i5Fz2HAUzP2/GQnZ7o=;
        b=iKnNp/24SBmnb+/f3E0f4PQc/dCBR1IgM/9XScyH7xqX6egUTLmp7fXXvTECHqTEwR
         vIqrr3G1aTqEhxUhDUHp96TG3LokAXN+2xKzbKKHNEutf8WgedaixQyagsDgh1FmlL3U
         Y4/rQOzbWpqKjlV2mEM0LDBnxkDzAoFocVq+Kk3jTINyasSI2aHJxfE/lrRzSZHNagw9
         RlLAPG+8OHuXH2CTKW+tvjDdg2GPVrRlm33D6bnY9A1HMHnFelyOZfV9OTwXgqKDldO0
         oOeo2kNcE3jEt7riOtTqOQAqDnhe1ZZbk9BLRw5MhcDIAkiO403+zXHQgN0ox09PsaSj
         0NjA==
X-Gm-Message-State: AOAM5303rkIDb0omN4d/Oe5tgP5nQG0VhZYHovlNnM0KJM3/meq8X7zH
        OefbA6v0xwEfDe3SDeAUppKjRJ2of24DARmePQE=
X-Google-Smtp-Source: ABdhPJzm8mA7wmNlXOpZ/141+GMdDuCroCHT1aZ4XA3yEiqKTvaonCc/SHd8mjMJ+tONbkBnaVC/ADrd6mTnhNm9puY=
X-Received: by 2002:ad4:5ce8:: with SMTP id iv8mr41121845qvb.21.1638834696527;
 Mon, 06 Dec 2021 15:51:36 -0800 (PST)
MIME-Version: 1.0
References: <20211203234155.2319803-1-gsomlo@gmail.com> <20211203234155.2319803-4-gsomlo@gmail.com>
 <CACPK8XfO_8=vgedmZddz1YmWbyxiM1-azF_j88wEBHzXnP6y_g@mail.gmail.com> <CAMuHMdXxO-CP0Ao8q8r4Gw5e5FzCznhSxt2JWz13zbnt2tnzVQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXxO-CP0Ao8q8r4Gw5e5FzCznhSxt2JWz13zbnt2tnzVQ@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 6 Dec 2021 23:51:22 +0000
Message-ID: <CACPK8XdF6WQDj9X1Nr0Hf6EzPkQtXBo75dj_WPsFq6nzfWPUrA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] mmc: Add driver for LiteX's LiteSDCard interface
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
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

On Mon, 6 Dec 2021 at 12:16, Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> > > +       depends on OF && LITEX
> >
> > I don't like having litex drivers depend on the LITEX kconfig. The
> > symbol is not user visible, and to enable it we need to build in the
> > litex controller driver, which platforms may or may not have.
> >
> > The microwatt platform is an example of a SoC that embeds some LITEX
> > IP, but may or may not be a litex SoC.
>
> I do like the LITEX dependency, as it allows us to gate off a bunch of
> related drivers, and avoid annoying users with questions about them,
> using a single symbol.

I appreciate your concern.

We could do this:

        depends on PPC_MICROWATT || LITEX || COMPILE_TEST

It's unfortunate that kconfig doesn't let us describe the difference
between "this driver requires this symbol" as it won't build and "this
driver is only useful when this symbol is enabled". Traditionally I
write kconfig to represent only the former, whereas you prefer both.

> Originally, people told me the system controller is always present,
> hence the current logic to have LITEX_SOC_CONTROLLER visible, and
> an invisible LITEX (which is shorter to type) for individual drivers
> to depend on.

That's another option. I think LITEX either needs to become visible,
become selected by microwatt, or we adopt the proposal I made above
for the litex drivers that the microwatt soc uses.
