Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BF7552E55
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348871AbiFUJaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348739AbiFUJaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:30:02 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCDC26103;
        Tue, 21 Jun 2022 02:30:01 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id c13so14050383eds.10;
        Tue, 21 Jun 2022 02:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eVfQd3XPechRFli107C/XOXRbeHsShcnB7OFUBR1wN4=;
        b=SkWmIxEV+ESyHsCbsR1Xt7I9SQuAWrV1KNmPiHSefbw6tjpPMuthp3LqtVQ2N+GIyh
         BF0EUqeIjZ/fTFqxBB6wXJ7xGaqQxl7IRe8eZi1sO2oZD7dNwzX7VC5QBndK7WTzX8pW
         ar9X/Z0jZRtZLQ6fUs2aQmiDZ2d91v914nUh+KGkyPNtXOmVVYNnVMMqb+EzlDt8o66V
         a0FVH1Zp8dBl16N3CmVzQ4p+Wj0SgKmTk9HwQkqHXo0LNrXTGtskvMPd3alLj3K0vLA/
         //ny6WHJ/gvkwxF84HzdQy++kjBUu8yXxysyZC5+Z+VkMghwv8Mv/zySzZVeO0ePODU+
         GlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eVfQd3XPechRFli107C/XOXRbeHsShcnB7OFUBR1wN4=;
        b=2s3Zqa675upJTh6G69MjRIf79fYt619yMAGRheYVAhOZxjvDQh/V5uRTW8KkHbokA9
         ouiE/OmoB1XtzoRptaBOv3XKHuuPiD3Ns1Sr1EuADusJC11+tn4AT+SubnHGt2nLFF3w
         Ok1r8qNq3D4rPcrUp9jsp2RNFD/CsMHaaOUefgvn5v/3vOPT7ypff/YLKGRakBLrxc61
         fG1G29jntFiqR1FkfILkZF4NHwCA3RMc6IFpkQt2UqL3kczeBE4SV1ywrCqFnNMd+3xq
         m8Ww+dr8eipGBkP8yHtJ3bKLHKyUF6SkHIzyEktfgJ+lORTsUhGskbsoc0ugoVeqFgzv
         jJrQ==
X-Gm-Message-State: AJIora+lp2mb37z0mB42PIvjXoc2uJaTNpKki3+MO19gWE/TkME7EI89
        i7MERN6dXbTg17CxZHU5EB+6jwIQ0Ci/+uavlCk=
X-Google-Smtp-Source: AGRyM1tM0xU4gMjk8srBUxoaihaU7C2henLT+DWnWAydDDa7goTMcwvw8+NLuBGCqmwgWP4p2sY0HbLwAwb7ohmPFDY=
X-Received: by 2002:a05:6402:4390:b0:42e:b7e:e9ac with SMTP id
 o16-20020a056402439000b0042e0b7ee9acmr34685476edc.97.1655803800295; Tue, 21
 Jun 2022 02:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com> <20220620200644.1961936-16-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220620200644.1961936-16-aidanmacdonald.0x0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Jun 2022 11:29:23 +0200
Message-ID: <CAHp75Vd7Sq9RMqin_y-8qUEAJLaGfuqxAbe+qcMB22=bqkyZqg@mail.gmail.com>
Subject: Re: [PATCH 15/49] regmap-irq: Change the behavior of mask_writeonly
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
> No drivers currently use mask_writeonly, and in its current form
> it seems a bit misleading. When set, mask registers will be
> updated with regmap_write_bits() instead of regmap_update_bits(),
> but regmap_write_bits() still does a read-modify-write under the
> hood. It's not a write-only operation.
>
> Performing a simple regmap_write() is probably more useful, since
> it can be used for chips that have separate set & clear registers
> for controlling mask bits. Such registers are normally volatile
> and read as 0, so avoiding a register read minimizes bus traffic.

Reading your explanations and the code, I would rather think about
fixing the regmap_write_bits() to be writeonly op.

Otherwise it's unclear what's the difference between
regmap_write_bits() vs. regmap_update_bits().

...

>         if (d->chip->mask_writeonly)
> -               return regmap_write_bits(d->map, reg, mask, val);
> +               return regmap_write(d->map, reg, val & mask);
>         else
>                 return regmap_update_bits(d->map, reg, mask, val);

-- 
With Best Regards,
Andy Shevchenko
