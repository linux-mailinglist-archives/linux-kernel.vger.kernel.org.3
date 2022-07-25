Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48648580742
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237195AbiGYWWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiGYWWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:22:32 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339F2252B6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:22:31 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id va17so23111254ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OfJ1ZIj7+bU5sV/7raydSeEf2mqO6FkBGPuruTLSHB8=;
        b=fODJuDVU6D+SDS2q/F+l/X08BfH6k6TCxnJEsdUKX6J0NqPl2fLBZMPLOOGyutqZu5
         Fxr0i674pMdM/W3P75tPF/Tym+Fa3rBFa6i5DAbJH6yp/gkibxQx7XnYRIXc/yaW2jEV
         hnnPdE/vdcuDkfUG+brbU9gJU1DD7ngEobjeNzBt/Z9cPECKdycmTyih0mJ+VoAOlHaM
         yxGs2d2SqR+gN3IUY/zjUk7xDeDHVwYmiv6T5Ov9v5Rcr3SYoXF/O6kr8hhMcKx/sETm
         9joPs+HPuIc62BLSHDU+MnrFc/eGlJl+o6R6FDsTRrtPK2wBRI2NF7yybrjKxXfg5suD
         5YbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OfJ1ZIj7+bU5sV/7raydSeEf2mqO6FkBGPuruTLSHB8=;
        b=1gwjSc4Bb5WMpvFvJxDasiLD5ZiHQGc0ef+ceE+tByjv2kaKh7whPgvfennRts/zi3
         nVNCzZX1ClVvJGgVjToT1cP10j6QGWhaA8m86xZ+oRvnDlQCKRQTCzHr6ko4IAco/C3P
         BEign1wn5jXexb5HW7kQsGth0hu88mpeEtmRGh6cBtrJR1dt4w1HeT2Qy4/dnzsrJO2K
         0oBj1Q1kL2RvUoGWgEFuc9f/CHkbMi4j8Rp27SlLs6zKgv4l9KVUuSL1bnQWa9A1Qc8r
         q/MiMm/E21PE0poAm+H92L4LjjOD2OojECHU3dBJvQdp41WLktjWeXxX/gflHh9N0Oap
         GpEg==
X-Gm-Message-State: AJIora+6GxkLlZ67TFOAaqMQXYWcCIznRUBgcyiJcFS24kaFGwBBQZFA
        XVx9XhSHSxy6TVm3ou3HBp2sZGtwGW40j3X3VPqYCw==
X-Google-Smtp-Source: AGRyM1sPpzasQVrKUvnOSqUPzsw2Lo2Bp+AJmvJzr+MjWG9dRwUvXpshqOSPRV70aCpQwrHv0rNTlsGDEYEXbfMv4sY=
X-Received: by 2002:a17:907:28c8:b0:72b:97cd:d628 with SMTP id
 en8-20020a17090728c800b0072b97cdd628mr11754787ejc.208.1658787749498; Mon, 25
 Jul 2022 15:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220721093422.2173982-1-marcus.folkesson@gmail.com>
 <CAHp75VddBhc9peHXfNfTyTNni246kC8CyLqCrMFadn67LGDarQ@mail.gmail.com>
 <CACRpkdaczrU1tM5Yt7P-Q2h+ge8STOi6HvvYeTM-g+JwS8_gZw@mail.gmail.com> <CAHp75VfaExrFYto7LWa5Vnbm6JbiAqtutKmk0HzfeHmmi3PwOg@mail.gmail.com>
In-Reply-To: <CAHp75VfaExrFYto7LWa5Vnbm6JbiAqtutKmk0HzfeHmmi3PwOg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 Jul 2022 00:22:17 +0200
Message-ID: <CACRpkdYHgD-fmt_2PWJrmyGY=AOP0Z+4jTkH=n3wJ+a0aApqcg@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: gpio-74x164: add support for CDx4HC4094
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 10:49 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Jul 25, 2022 at 3:54 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Mon, Jul 25, 2022 at 11:32 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Thu, Jul 21, 2022 at 11:32 AM Marcus Folkesson
> > > <marcus.folkesson@gmail.com> wrote:
>
> ...
>
> > > Sorry for my absence of understanding, but why?
> > > SPI has MOSI, CLK, CS, where the last one is exactly for that. No?
> >
> > Forgive me if I misunderstand, but if you use CS that
> > way, the way that the SPI framework works is to assert
> > CS then transfer a few chunks over SPI (MOSI/CLK)
> > then de-assert CS.
>
> No, CS here is used exactly for what it is designed for ("tell that
> this message is *for me*"). Yes, hardware implementation here is a
> latch register. Because otherwise ALL messages are "for me" which is
> wrong. Is it wrong interpretation of the hardware and SPI?

I was under the impression that the shift register has no idea
if the message is "for me", and that there can only be one shift register
on the bus if using ordinary SPI to control it.

I look at this data sheet:
https://www.farnell.com/datasheets/2030250.pdf

IIUC what you say is CS == STR?

> > If CS is used for strobe, it is constantly asserted
> > during transfer and the sequence will be latched
> > out immediately as you write the SPI transfers and
> > the data is clocked through the register, making the
> > whole train of zeroes and ones flash across the
> > output pins before they stabilize after the SPI
> > transfer is finished.
>
> I'm not sure I understand the stabilization issue here. It's how SPI
> normally works and we have a lot of delays here and there related to
> the phase of the CS in comparison to clock and data. We have a lot of
> time to stabilize the outputs of the shift register before latching
> it. Did I miss anything?

STR (strobe) is latching out the data, and how is that happening
when you connect it to CS? CS is asserted throughout the whole
transaction...

STR is supposed to be used like in the patch: to be toggled after
the transfer is complete. CS does not behave like this at all.

> > If you first do the SPI transfer, then strobe after
> > finished, this will not happen.
>
> I have hardware, I have tested it and I understand what you mean by
> "stabilizing", but finishing transfer _is_ CS toggling for _this_
> chip. No?

Well it will work, because all values come out, however *during*
the transfer, not *after* the transfer as intended with the
STR signal.

> > Then it should be a separate pin, so this doesn't
> > happen, right?
>
> I think no, you don't need it. I.o.w. either I'm missing something
> very interesting about both this kind of chips and SPI basics (shame
> on me in this case) or...?

SPI will assert CS, then make the transfer i.e. toggle the clock
a few times with new data on MOSI each clock cycle, then
de-assert CS.

STR is supposed to be toggled after all this happened to latch
out the data to the outputs, just like the patch does.

What happens if STR is connected to CS is that you will see
the shift register contents change on the output. It will be
fast so it will look fine if it is e.g. a LED. But if it is something
more sensitive, there will be chaos.

At least how I see it ...?

Yours,
Linus Walleij
