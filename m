Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D16F552E27
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347873AbiFUJWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347951AbiFUJWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:22:43 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC6A1FCCE;
        Tue, 21 Jun 2022 02:22:41 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id h23so26109904ejj.12;
        Tue, 21 Jun 2022 02:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nwSBD3PTloVRfceK56G2aCfoof4Hwc6nnq2tpaiVX1E=;
        b=SZC4AJowoOWLiXUnJNCXlRo+Fy21+43HuGqupG34NYAHev8FNX9LB4nFwui2g2ERc/
         2nAJjFE7gSxwK3AKqYoV1+xDYo3j7xKpCHwaEkBrfpjwItcvjJqbKZBmsBC6S6wk0LeP
         jECzrOFPrp+pM5SPwC+6kLb36nf+Eql2JHp+xmKVEp9KBopfkHCProz5vj1URUzLxuOc
         2gtMsViSY39FbLby9xOKwyFIHQnssNg0xndDzN3H/27fb1evpypF3YvV3oswAKpp+Rdc
         8SQN3kqU5KrBqva1r+R8tUi0Xkhp826IwLzXg6j6O1xwnr3vjRymNISR9wMWgtdGEpu5
         ffSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nwSBD3PTloVRfceK56G2aCfoof4Hwc6nnq2tpaiVX1E=;
        b=cBgAbuZo65rfgvivd9KbCbX7qu+EESGr1UGiiZk3ZnMl+R9dP4aOT3+gt3e6+ijiHS
         1MJB4SwoI4cjGTxh/iPsamTQmele4Ww2JgOS+YLpdL1/a3wFgkS8v7AP+CL2vxSIsLjr
         ITKolee/Z67GROdOPdnNV34NtnhAL+13UbHVyNvbLpZ3w2+UJZbWx9XhHWG0ABQNP4ve
         SVjk+IPj84C+TWF56A4WxdfUYgzShjBi0SIoHPiRBLcUnYC6o47IC0DFZpdSQjNEMpoE
         mWPfKm9h2cX3OMLiFG7LO7MizQ8OqTDEi8P/rz5VJAjl1B4bK83zCuaNauKrUYshIa0h
         hYnA==
X-Gm-Message-State: AJIora99Yf/xDgksfJnGnPDpQcxiyEo6xvVwUcstPyQ2H+Dj6XlaMyg/
        Nxo2yABJ2hmL+25WcWz+18KtjuB5rQbwXu0Prqo=
X-Google-Smtp-Source: AGRyM1st5l8YH2ggqJetd23NizO1SBXRfCSKIN2Ag6+snWa4U1k/4MnJ2Of8mZI6rssF1UlaIrePIaWD6CbQW7kd1/8=
X-Received: by 2002:a17:906:149:b0:711:fca6:bc2f with SMTP id
 9-20020a170906014900b00711fca6bc2fmr25088970ejh.497.1655803360410; Tue, 21
 Jun 2022 02:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com> <20220620200644.1961936-5-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220620200644.1961936-5-aidanmacdonald.0x0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Jun 2022 11:22:03 +0200
Message-ID: <CAHp75VePD-ROfnFtwU33Jt_h9a-qBC0QwRQcQfgmEbyOV22CKA@mail.gmail.com>
Subject: Re: [PATCH 04/49] regmap-irq: Introduce config registers for irq types
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
> Config registers provide a more uniform approach to handling irq type
> registers. They are essentially an extension of the virtual registers
> used by the qcom-pm8008 driver.
>
> Config registers can be represented as a 2D array:
>
>     config_base[0]      reg0,0      reg0,1      reg0,2      reg0,3
>     config_base[1]      reg1,0      reg1,1      reg1,2      reg1,3
>     config_base[2]      reg2,0      reg2,1      reg2,2      reg2,3
>
> There are 'num_config_bases' base registers, each of which is used to
> address 'num_config_regs' registers. The addresses are calculated in
> the same way as for other bases. It is assumed that an irq's type is
> controlled by one column of registers; that column is identified by
> the irq's 'type_reg_offset'.
>
> The set_type_config() callback is responsible for updating the config
> register contents. It receives an array of buffers (each represents a
> row of registers) and the index of the column to update, along with
> the 'struct regmap_irq' description and requested irq type.
>
> Buffered values are written to registers in regmap_irq_sync_unlock().
> Note that the entire register contents are overwritten, which is a
> minor change in behavior from type registers via 'type_base'.

...

> +                       ret = regmap_write(map, reg, d->config_buf[i][j]);
> +                       if (ret != 0)

if (ret)

> +                               dev_err(d->map->dev,
> +                                       "Failed to write config %x: %d\n",
> +                                       reg, ret);
> +               }

...

> + * regmap_irq_set_type_config_simple() - Simple IRQ type configuration callback.

> + *

Redundant line.

...

> +               d->config_buf = kcalloc(chip->num_config_bases,
> +                                       sizeof(*d->config_buf), GFP_KERNEL);
> +               if (!d->config_buf)
> +                       goto err_alloc;
> +
> +               for (i = 0; i < chip->num_config_regs; i++) {
> +                       d->config_buf[i] = kcalloc(chip->num_config_regs,
> +                                                  sizeof(unsigned int),

Can it be sizeof(**d->config_buf) ?

> +                                                  GFP_KERNEL);
> +                       if (!d->config_buf[i])
> +                               goto err_alloc;
> +               }

-- 
With Best Regards,
Andy Shevchenko
