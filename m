Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45878580DD9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbiGZHe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238342AbiGZHeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:34:09 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E7B2B634;
        Tue, 26 Jul 2022 00:31:17 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id m8so16668530edd.9;
        Tue, 26 Jul 2022 00:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tGKM8TxdBMi0PkUssZOOQckwTpSbR7y+SZZIKa/SWFE=;
        b=NWLwDpDGpk70FKVxZ6gOMDaO8pthO+KcyrH8OWvzNXp+tmRsrpQIY9x8LSPaU2lQOb
         kYPum3tYWz7hUhuw9lBBPfcEOjhr+DxWTL7t5sT5RkwRuqaYeVjfdSep+Pn7tWfIQiAP
         PvOtuTeQQp6myRbeo/IwT3hOdZlgrYow3mcdWB82P5In9I0cZp0TvTTaWZxH4UDtFrVz
         WkGEUAiJPBBuciCGdhM6hF1naan7wltNU8toT8+dk9F4BNgMweObyAjF7byhLF12zzZo
         SqSdPp/ZhW3ZhAnFa6+p3ZHiFe60MnEFJqQZG2cWZjYBrvKeK3iEFGhYCCZXrRsCu/qn
         C7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tGKM8TxdBMi0PkUssZOOQckwTpSbR7y+SZZIKa/SWFE=;
        b=gz/Nj6B0YBjSrwu8hTvg3pShqxE3UKP+nO1/B1DwnfHOsIT08vvgmHg+ZAo0DQ8j+h
         ho9U5Q0U1lHQmAQKs+SCpeyKw2INMgfhiNCXly/KAhMWQaGGIaDm64glsKReMhlXGxxP
         C4M6Jk+yipDyMbElYlnn1qKymRyzrUA2KghyJ0D8hYhC6cytriiWZPuUKKwb6aMulMQT
         F75LA95232wqzrfcx1ylOKriPa2bN3iznpY38SbF6M8zzE5TRqoUS33QPCNJD4Vkp2n5
         YJZ2PYeE9JUV0jtfIL4rCwHMUHfrmha/RFWCe3TXVCRB/GeUJvK5vhqutx8B+5UkzKpi
         aGHw==
X-Gm-Message-State: AJIora8gd+khSRLz7D4GC79PYyUD6ThTobYY823V7ASY2nX2iV9ZrfnW
        hVI6GAbsoFAKIzBaO8/RhRDqLfuzV4T44FS0dnydpGXuuT22iA==
X-Google-Smtp-Source: AGRyM1tRZ+Uehibz/P+j0POwO8fqc9b5rSGx+1hEyYF+upGgOaKaIy+v67KBUr7aro4jOv4v++rVPoI2rKZ0DgfBVTU=
X-Received: by 2002:a05:6402:5c8:b0:433:545f:a811 with SMTP id
 n8-20020a05640205c800b00433545fa811mr17043040edx.101.1658820676077; Tue, 26
 Jul 2022 00:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220721093422.2173982-1-marcus.folkesson@gmail.com>
 <CAHp75VddBhc9peHXfNfTyTNni246kC8CyLqCrMFadn67LGDarQ@mail.gmail.com>
 <CACRpkdaczrU1tM5Yt7P-Q2h+ge8STOi6HvvYeTM-g+JwS8_gZw@mail.gmail.com>
 <CAHp75VfaExrFYto7LWa5Vnbm6JbiAqtutKmk0HzfeHmmi3PwOg@mail.gmail.com>
 <CACRpkdYHgD-fmt_2PWJrmyGY=AOP0Z+4jTkH=n3wJ+a0aApqcg@mail.gmail.com>
 <CAHp75Vf_aDSocdB7R6zKFwEOBRwq0w2m6GdCM-5ujKoz4bGiqQ@mail.gmail.com> <CACRpkdbTypeq0M8VNb491GaZdBLyE9_TFpCDn5omnTe8D+BU7w@mail.gmail.com>
In-Reply-To: <CACRpkdbTypeq0M8VNb491GaZdBLyE9_TFpCDn5omnTe8D+BU7w@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 Jul 2022 09:30:38 +0200
Message-ID: <CAHp75Vfrgkq+yTtFxjkvUMnVOHCL+VyHGXPn4BN7i6C1cA=Uuw@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: gpio-74x164: add support for CDx4HC4094
To:     Linus Walleij <linus.walleij@linaro.org>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 9:23 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Jul 26, 2022 at 8:55 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, Jul 26, 2022 at 12:22 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> > > Well it will work, because all values come out, however *during*
> > > the transfer, not *after* the transfer as intended with the
> > > STR signal.
> >
> > No. I think you missed one little but crucial detail. The strobe is
> > edge, not level, while you consider CS as a level signal (only).
>
> Aha! Then it works :)
>
> > See Figure 7 and Table 9 in the datasheet you linked to. When STR is
> > low, the data is not changed. Maybe it's not clear in this datasheet,
> > I found somewhere
> > in a more clear table.
> >
> > > At least how I see it ...?
> >
> > If what you are saying is true, the hardware is totally broken and I
> > wouldn't use it. I.o.w. if the strobe passes all data when it's at low
> > level and latches at low-to-high, it's broken by definition in my
> > point of view.
>
> I have seen strobes that are level-active in my life, but if you
> say this one isn't then all is fine!

It's rather my common sense, because we have a clock here to shift a
register. It's kinda obvious *to me* that when we have a latch, that
latch shouldn't pass data on a level. Yes, there are buffers with
level strobe, but it's different. So, as I said, the oscilloscope can
finish our discussion one way or the other, but I believe it will be
my way ;) I will very (badly) surprised if it becomes your way. It
will ruin my beliefs in humanity. Not less.

-- 
With Best Regards,
Andy Shevchenko
