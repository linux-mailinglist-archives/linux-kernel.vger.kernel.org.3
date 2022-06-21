Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75B2552EFC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349427AbiFUJnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349385AbiFUJnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:43:10 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AEC16591;
        Tue, 21 Jun 2022 02:43:08 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id cw10so2512323ejb.3;
        Tue, 21 Jun 2022 02:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7W8pS4HaYS/K/F5s5QPICn7aqLZXMuTyRRVdAfsAcPg=;
        b=XoZerS+qv1R28f40K6hoLnLM4Ct5C+e/yqRmtv+kzV9PCDFL/LS7bsUEdldOD+RyHB
         ukczq/1O7qTvO3tyrlZrzFhXQ33KoFDifHZODZVFjJ3TigoHkBk7geFdz+QWVVDhdZd0
         4QXA3Mcp4UOLWIVfOEaXgpOhro4R7EyEOzGxZz//6kMGNLexIQ1RMMhIHoy6Fmqp95s3
         edH6j4r60Egf0+IoooN2Kl4dh1amXJKmc5SerDqp0IPAetq8boVtQMtd1V4UihFiytjO
         i7exWG8M8Vy6qOonHlsopob38cCHeq//DmG2j5wMnELgMi7YdE2S591sC4Eqab5J28+F
         vr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7W8pS4HaYS/K/F5s5QPICn7aqLZXMuTyRRVdAfsAcPg=;
        b=EN4KTb12zFCgRCKjayRRLDTvs4wJ1cnJ8uu+JrJX83p5emApSz+eW5PXD/gqtCPK3Q
         d6Vlzp/KGvYTii3zzQ9Dw8YxruLfgxWql4pCia9boDNdVze0dshqQpfiN+4EKrcxJlTU
         jdYV63IsJE/l4VEL9UYWFE2Sc3UJ+5nv0p6HET8X9GkbKuIuvDs1hnPa6Stz9Eij4zKy
         YuX1PufQv96qOx9rgqNUqAtsVq2+S2roXso8i8+jPukPNjf63HXkbtPzdHyelIs8z9QM
         YHeC1R2rYhk5m/c6r5V9+UO3gbvnTx42f6c4J7u+bxUv6QAc805UqhIO/h+HAHnvhq5X
         5Y7w==
X-Gm-Message-State: AJIora8HTIHa1XvgZ3Gb6pn3v5VjanwJPE0fZ7gg4ekVcejTHtTPw7Mw
        sXdBCRTPkCLfPTwDsrrFCMRzOjgDw/G5Pc5kY+c=
X-Google-Smtp-Source: AGRyM1uYARWsSweZJveSPRopcUyqQF9g3LZ0zGnE7aD5N8bF+zyg2cKewkA1ySgZCwIP7Hmn7pVNYQGyGOFlItx8/YQ=
X-Received: by 2002:a17:906:434f:b0:711:eb76:c320 with SMTP id
 z15-20020a170906434f00b00711eb76c320mr24832521ejm.636.1655804587541; Tue, 21
 Jun 2022 02:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com> <20220620200644.1961936-40-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220620200644.1961936-40-aidanmacdonald.0x0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Jun 2022 11:42:31 +0200
Message-ID: <CAHp75VfYebbY47_jOmyC0PapZB=ne1XA4gfV4OPuHcurFR6JCA@mail.gmail.com>
Subject: Re: [PATCH 39/49] gpio: sl28cpld: replace irqchip mask_invert with unmask_base
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

On Mon, Jun 20, 2022 at 10:10 PM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:
>
> An inverted mask register can be described more directly
> as an unmask register.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  drivers/gpio/gpio-sl28cpld.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-sl28cpld.c b/drivers/gpio/gpio-sl28cpld.c
> index 52404736ac86..2195f88c2048 100644
> --- a/drivers/gpio/gpio-sl28cpld.c
> +++ b/drivers/gpio/gpio-sl28cpld.c
> @@ -70,8 +70,7 @@ static int sl28cpld_gpio_irq_init(struct platform_device *pdev,
>         irq_chip->num_irqs = ARRAY_SIZE(sl28cpld_gpio_irqs);
>         irq_chip->num_regs = 1;
>         irq_chip->status_base = base + GPIO_REG_IP;
> -       irq_chip->mask_base = base + GPIO_REG_IE;
> -       irq_chip->mask_invert = true;
> +       irq_chip->unmask_base = base + GPIO_REG_IE;
>         irq_chip->ack_base = base + GPIO_REG_IP;
>
>         ret = devm_regmap_add_irq_chip_fwnode(dev, dev_fwnode(dev),
> --
> 2.35.1
>


-- 
With Best Regards,
Andy Shevchenko
