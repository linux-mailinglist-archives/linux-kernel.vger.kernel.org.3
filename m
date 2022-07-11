Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D0656D83E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiGKIhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiGKIgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:36:48 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A0712AB1;
        Mon, 11 Jul 2022 01:36:27 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id h62so4958839ybb.11;
        Mon, 11 Jul 2022 01:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/urHEMzh2bc5TwNR8Jg3HlbigYCzgoWwkXUrjrAfWC8=;
        b=XGmSAiIGZxYQeqyvett+yhyFmsQZIVbGMwwau29NqEDDZPY0DoB9heByadkEGBc83p
         l5oh2J4YHg2IziqPBXZiLKUyUW2PD9Xj6y9pN2AFk1LxWcDX29uChlfblfaMI6ChU+5a
         eEAN+gV66aQ9r7TPYbU8Q4C6W5HmboykOURNxDgEhuAQQ0X/Rkr4nl4XNxVnKLaRuesi
         2cJHC+XzmH6peK8BcO/O3VyhoyIMfRGnLAzFnbMPyCm/znRvt//8nJcWwP9NnXA9cLsn
         rVhIt6dYM+jz4jtZU47j2c9u7Xiny4kcW5uLj6V9Z8QaoBzgWO78hSx27k0gIw5JpxK/
         NgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/urHEMzh2bc5TwNR8Jg3HlbigYCzgoWwkXUrjrAfWC8=;
        b=XQNjZyRTi1brE0KeK19ifkfmD3xB0z7Q+hg7L8BD5Svh/f+B0xAcm/39mSAa1u7UC4
         KjtPittk3EFjFkKx0bEnED2RRhnihHHTDX6vAcc506V+cCk32eFCGfZquhZvTk1A5aQu
         urx9LLtahpCz9gw8y8A6WIUaa6YrsdNwpnkPA7t12CrK05h7OBonloo8w6oC/Mb0EKfz
         mt6y9+x2Erf1mWqvtMIdXoI+lJmeEjFsDtPD34yXP9QiO+xqeT/L0mJ5JmRBPBLZdxbl
         Tv+e6TUjlG0DUcrKi5DZfyK1d3yvGiR5i34kPjVxIb40CkavgbdLoDuTWydfy6Y6FxUk
         roTw==
X-Gm-Message-State: AJIora9kOiNb/OEGsTntGYrZiIPiNI/5ZNKeLlsVqzmpwzoZPyycMyPG
        +XENCdNeOeS2HzhVcOKjB417d3mJHJtJMQGfVA8=
X-Google-Smtp-Source: AGRyM1vzQAGVZ8apoNozUcEzZu+mjoPUu3+q9WkSyjYKuHvlYS46eciGCWtdJc855CKUdcMoEgpkfWpSFB+UmT0ASGk=
X-Received: by 2002:a05:6902:c4:b0:64b:4677:331b with SMTP id
 i4-20020a05690200c400b0064b4677331bmr15665437ybs.93.1657528586108; Mon, 11
 Jul 2022 01:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220708195510.2951661-1-horatiu.vultur@microchip.com>
 <20220708195510.2951661-3-horatiu.vultur@microchip.com> <YsiQhA9pHaX4s3R8@colin-ia-desktop>
 <CAHp75Vc0EasS2Z3x=cgTv==osXprPU3Zkc-Q9DMf4BMz2p6oLw@mail.gmail.com> <20220711065547.drpgq466ueujkxah@soft-dev3-1.localhost>
In-Reply-To: <20220711065547.drpgq466ueujkxah@soft-dev3-1.localhost>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Jul 2022 10:35:49 +0200
Message-ID: <CAHp75VcOY-fHMvdoazB+STYxGNCJTmpxN9yMaAvQAcVUn7yL7g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pinctrl: ocelot: Fix pincfg
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     Colin Foster <colin.foster@in-advantage.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        kavyasree.kotagiri@microchip.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Michael Walle <michael@walle.cc>
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

On Mon, Jul 11, 2022 at 8:51 AM Horatiu Vultur
<horatiu.vultur@microchip.com> wrote:
> The 07/09/2022 00:02, Andy Shevchenko wrote:
> > On Fri, Jul 8, 2022 at 10:17 PM Colin Foster
> > <colin.foster@in-advantage.com> wrote:
> > > On Fri, Jul 08, 2022 at 09:55:10PM +0200, Horatiu Vultur wrote:

Please, remove unneeded context when replying!

...

> > > > -             .max_register = 32,
> > >
> > > What happens in /sys/kernel/debug/regmap/*-pincfg/{range,registers} when
> > > there's no max register?
> >
> > Good question!
>
> If .max_register is missing then I got the following:
>
> # cd /sys/kernel/debug/regmap/e2004064.pinctrl-pincfg/
> # cat range
> 0-0
> # cat registers
> 0: 00000005

This is effectively a regression.

> > > Should it be this?
> > >
> > > struct regmap_config regmap_config = {
> > >     ...
> > > };
> > > regmap_config.max_register = info->desc->npins * regmap_config.reg_stride;
> > >
> > > >               .name = "pincfg",
> > > >       };
> >
> > If regmap configuration may be const, I would prefer to have a
> > hardcoded value and different configuration based on the chip, but if
> > it's not feasible, then this could suffice.
>
> What about if we do something like:
>
> const struct regmap_config regmap_config = {
>     ...
>     .max_register = info->desc->npins * 4,
>     ...
> };
>
> This is based on what Colin suggested only that we keep the const.

As long as it's const, I like it.

-- 
With Best Regards,
Andy Shevchenko
