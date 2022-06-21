Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C919552EF6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349440AbiFUJlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349280AbiFUJlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:41:06 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AB027CE9;
        Tue, 21 Jun 2022 02:40:49 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id v1so26181519ejg.13;
        Tue, 21 Jun 2022 02:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yO9ZPtHQWlDG8pJW5AjR6r/iVBmTjGfBSQKVmAjwZYM=;
        b=MiT9YSgqAyyHbC2NgSFHcI9mU0I4SmbelZoevB0+h8amRGfyUTmMrWazwaITPEHarp
         ymKzl2T79u9M7zLSooXOXyVg4z58w0poQeJaq3PyZdrpSWwinByRfTzDd3MJMVKc+Jh1
         HrosNpkC9SLF6USdA/ZDhAg0uPAMPxz5wZw22PnS/SvBpuDabh76flqB27+QDjuz85Rk
         kVWCot5G6uKY0ebmYx0cAKxiYNCgHV9fAO4fsWARBr5Cz29I6Pl4NDihgDbx49z6TXgM
         upDr6OeHbZyVU5E1CaDMSJLWT9I584x/Nsc/beJSY8ZvpOWxhrcr5L3ty9BdiC7iyRCj
         44Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yO9ZPtHQWlDG8pJW5AjR6r/iVBmTjGfBSQKVmAjwZYM=;
        b=72p+hfbAgG0q3Zjoubg9e7dxYmKz6XT/m4ZYB8SpB5k7Axv5yzirZUYKo/gIAHUAr6
         M48BoTxiyxnh/0XpdYZOFvNB2bQKzs8Jxnk4J/c8qDKJy6rcRON2NYuVmar6bI69/uZF
         vs9YqRY99x4rq8O1v8e/CIKt7E5jgH4JHII/r/qDM5fnn9GmVfFTLWD2IfBH1CmSgzJ+
         TLPP6BDlmVz4JJXkZhpmxmVPQIvgnKW1B3798qzij+/xeQj8ak/doY7hPBOtHX6GP7Ad
         vPpUlDO4AUZgCbEXQgKavNK3up5/SW4Qai2Z3jY/AHGFVdVszHUdXYlO3B6lMvISqxn9
         5HhA==
X-Gm-Message-State: AJIora9yyA5F6lyThrVuvIJ6ouKgRvrOB6BNGTaL+v8nML4v6GVGTa6f
        WyPgTV/0SIVp/Mc3fsET2Vdrvx1wwNstAJaonq8=
X-Google-Smtp-Source: AGRyM1t+MEvnyKMMSOFbe0KDznz+llRYAN363T+/fom4dMy2mWe1LxJilznTSxS3mrmOTfCBkGAcauPWgPhktFyIGgA=
X-Received: by 2002:a17:907:72c7:b0:722:e5af:f666 with SMTP id
 du7-20020a17090772c700b00722e5aff666mr1301982ejc.44.1655804448287; Tue, 21
 Jun 2022 02:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com> <20220620200644.1961936-21-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220620200644.1961936-21-aidanmacdonald.0x0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Jun 2022 11:40:12 +0200
Message-ID: <CAHp75VdRC5_AUZttMqY8f9gBAct+q5sEUjqOAwVfdtCvwsE_dg@mail.gmail.com>
Subject: Re: [PATCH 20/49] regmap-irq: Fix inverted handling of unmask registers
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Michael Walle <michael@walle.cc>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, tharvey@gateworks.com,
        rjones@gateworks.com, Matti Vaittinen <mazziesaccount@gmail.com>,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-actions@lists.infradead.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
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

On Mon, Jun 20, 2022 at 10:08 PM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:
>
> To me "unmask" suggests that we write 1s to the register when
> an interrupt is enabled. This also makes sense because it's the
> opposite of what the "mask" register does (write 1s to disable
> an interrupt).
>
> But regmap-irq does the opposite: for a disabled interrupt, it
> writes 1s to "unmask" and 0s to "mask". This is surprising and
> deviates from the usual way mask registers are handled.
>
> Additionally, mask_invert didn't interact with unmask registers
> properly -- it caused them to be ignored entirely.
>
> Fix this by making mask and unmask registers orthogonal, using
> the following behavior:
>
> * Mask registers are written with 1s for disabled interrupts.
> * Unmask registers are written with 1s for enabled interrupts.
>
> This behavior supports both normal or inverted mask registers
> and separate set/clear registers via different combinations of
> mask_base/unmask_base. The mask_invert flag is made redundant,
> since an inverted mask register can be described more directly
> as an unmask register.
>
> To cope with existing drivers that rely on the old "backward"
> behavior, check for the broken_mask_unmask flag and swap the
> roles of mask/unmask registers. This is a compatibility measure
> which can be dropped once the drivers are updated to use the
> new, more consistent behavior.

...

> +                       if (ret != 0)

if (ret)

> +                               dev_err(d->map->dev, "Failed to sync masks in %x\n",
> +                                       reg);

...

> +                       if (ret != 0)

Ditto.

> +                               dev_err(d->map->dev, "Failed to sync masks in %x\n",

...

> +       /*
> +        * Swap role of mask_base and unmask_base if mask bits are inverted.

the roles

> +        *
> +        * Historically, chips that specify both mask_base and unmask_base
> +        * got inverted mask behavior; this was arguably a bug in regmap-irq
> +        * and there was no way to get the normal, non-inverted behavior.
> +        * Those chips will set the broken_mask_unmask flag. They don't set
> +        * mask_invert so there is no need to worry about interactions with
> +        * that flag.
> +        */

Reading this comment perhaps the code needs a validator part that will
issue a WARN_ON / dev_warn() / etc in case where the above is not
satisfied?

...

> +                       if (ret != 0) {

if (ret)


> +                               dev_err(map->dev, "Failed to set masks in 0x%x: %d\n",
> +                                       reg, ret);

...

> +                       if (ret != 0) {

Ditto.

> +                               dev_err(map->dev, "Failed to set masks in 0x%x: %d\n",
> +                                       reg, ret);

-- 
With Best Regards,
Andy Shevchenko
