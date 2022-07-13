Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15E3573FF1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 01:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiGMXJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 19:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiGMXJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 19:09:55 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CF73AB0D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 16:09:54 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id z3so64402ilz.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 16:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0U8OihvUY0SUbsVhJMk93wvVq/MDQBMWuuGkfgcpJNI=;
        b=ri0V2YOeCjfvOqrmWJm+IrvBhxy7ZpYljxqJxXFDrx+TLfSH2ULzrf1+YpV7n5U0em
         iwMXY/EZbIj5OVlzxT7/CWWsbBMsnXkqnAi9+GmaO/Jb1t37ykdOPGzL3oHsf+VZC81X
         NujbuvTTmvMr+fnAyRNLtx2BqbZA1LZyjylj+08U1bUReZxdzWeJR9NiTV8334QPFxE8
         6mbHS2Hl1YrEOOJukegyUiMPtzhqY6BUMJxCklmEp0Fdp7K4V889RhPtoRKpk4OY54kf
         VG703BPqtRDoZL1Dznu644MPt9bY3soG++Ly7F62P3S7jaAN3S8DAGOHn0e6asgo10ab
         M7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0U8OihvUY0SUbsVhJMk93wvVq/MDQBMWuuGkfgcpJNI=;
        b=g0/N+PJ9DmPPQKsyxreZvlhiejIRPwFt47o3bvRAllhqMC4nHeYGrx9gHboJLvFakk
         ZcaGl08LWqaNp/puX66cqN7RNOHvy3od7LlrsaL+3T+FrB6n9CI7moxhRA2uhNz4j/Dv
         /4FCrBIht8bPJp4kzzm7RgkUJnJL7Vfk3jWfpTfGkz3SMusgcqMcKShnqJI8q09+MJ27
         0zCIoZRSgUvXjE9QPiMrpYOdnSDq55Zl59QtQBElULKUVWBqrrPbCZ66vAroFnjQOEPO
         HE++Rkz/ZN5wl3D9iAtkM9wTf1/Bt+c9Ug3q4RgVuWCVEse3w3+Tvp5fdbFPoE/QQpzD
         fOWg==
X-Gm-Message-State: AJIora97uF/ApPmlNZkYgHR01NeJ1u74/d4dI3zBGsCn20K1R5AlLAhL
        ayAutMROhxtXvHvCRtea5EgUUBEXiR6qivR53roi9Q==
X-Google-Smtp-Source: AGRyM1sCXX1XB9VLVVGYYAYQMVYbA92oX/a1DOBsoCiqzI3zDdpGUemzbG6CEYUj+XfriHOeJgnVRqezKEXiJuswAOw=
X-Received: by 2002:a92:cda2:0:b0:2dc:7060:ef14 with SMTP id
 g2-20020a92cda2000000b002dc7060ef14mr3104693ild.56.1657753794115; Wed, 13 Jul
 2022 16:09:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220713225151.1476041-1-robert.marko@sartura.hr>
 <20220713225151.1476041-2-robert.marko@sartura.hr> <Ys+xTubC2iwetqYS@COLIN-DESKTOP1.localdomain>
In-Reply-To: <Ys+xTubC2iwetqYS@COLIN-DESKTOP1.localdomain>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Thu, 14 Jul 2022 01:09:43 +0200
Message-ID: <CA+HBbNGyA_+KqBWTpz+NMKs__UkB7Td-_w3aafQfYqnpW8N18g@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: ocelot: fix pinconf
To:     Colin Foster <colin.foster@in-advantage.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 1:01 AM Colin Foster
<colin.foster@in-advantage.com> wrote:
>
> Hi Robert,
>
> On Thu, Jul 14, 2022 at 12:51:51AM +0200, Robert Marko wrote:
> > Commit "pinctrl: ocelot: convert pinctrl to regmap" moved to using
> > regmap_read/write, however it neglected to also carry out alignment
> > to register stride of 4.
> >
> > This would cause the following error:
> > [    1.720873] pinctrl-ocelot 6110101e0.pinctrl: pin_config_set op failed for pin 34
> > [    1.728110] sdhci-sparx5 600800000.mmc: Error applying setting, reverse things back
> >
> > So, regmap_read would return -EINVAL as it was being passed address
> > of the pin without stride, so for example pin 34 would end up being
> > 0x22 in hex.
> >
> > Fix this by accouting for the stride in register address.
>
> Sorry for the bug. Horaitu found this as well and recently submitted
> patches:
>
> https://patchwork.ozlabs.org/project/linux-gpio/patch/20220713193750.4079621-3-horatiu.vultur@microchip.com/
>
> The second patch in his set fixes both of these issues (reg_stride and
> max_register).

Yeah, I noticed his patch only after sending this.
Sorry for the noise.

Regards,
Robert
>
> >
> > Fixes: 076d9e71bcf8 ("pinctrl: ocelot: convert pinctrl to regmap")
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > ---
> >  drivers/pinctrl/pinctrl-ocelot.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
> > index 84bfbe649b67..a71145367b15 100644
> > --- a/drivers/pinctrl/pinctrl-ocelot.c
> > +++ b/drivers/pinctrl/pinctrl-ocelot.c
> > @@ -1327,7 +1327,9 @@ static int ocelot_hw_get_value(struct ocelot_pinctrl *info,
> >       if (info->pincfg) {
> >               u32 regcfg;
> >
> > -             ret = regmap_read(info->pincfg, pin, &regcfg);
> > +             ret = regmap_read(info->pincfg,
> > +                               pin * regmap_get_reg_stride(info->pincfg),
> > +                               &regcfg);
> >               if (ret)
> >                       return ret;
> >
> > @@ -1359,14 +1361,18 @@ static int ocelot_pincfg_clrsetbits(struct ocelot_pinctrl *info, u32 regaddr,
> >       u32 val;
> >       int ret;
> >
> > -     ret = regmap_read(info->pincfg, regaddr, &val);
> > +     ret = regmap_read(info->pincfg,
> > +                       regaddr * regmap_get_reg_stride(info->pincfg),
> > +                       &val);
> >       if (ret)
> >               return ret;
> >
> >       val &= ~clrbits;
> >       val |= setbits;
> >
> > -     ret = regmap_write(info->pincfg, regaddr, val);
> > +     ret = regmap_write(info->pincfg,
> > +                        regaddr * regmap_get_reg_stride(info->pincfg),
> > +                        val);
> >
> >       return ret;
> >  }
> > --
> > 2.36.1
> >



-- 
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
