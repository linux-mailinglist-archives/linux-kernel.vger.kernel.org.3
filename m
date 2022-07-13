Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D381A57338E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbiGMJyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbiGMJyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:54:33 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3946B1CD4;
        Wed, 13 Jul 2022 02:54:32 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 6so18394784ybc.8;
        Wed, 13 Jul 2022 02:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sPSIxVNqSB9G6SRgGp4hjqBXmPGfCStVgCLOhu5E9sY=;
        b=GJ3HcaOWlpP40hbU/+p0Cf8DX90GQmn0aUsoMMXrVSg3WjgE/THWJUp72nHPRF1V2i
         h1PJug/F0rU0uqjSfLe1Df4ete5iAKUHmO/dcw7hISBkASfVGB80X6exxuGSHFCtnbc7
         aaquWzA8IYx5sKGfl5QJuLpQqW2BerSiFqOMTSFMljXMUjKUakWXjMl4eaG5rvhyfzEc
         tu/zlkRn2yUsx2VjFHbhDQ090+inDXH2uQ0oE/+hwNfKhi5bK878Gg6x9olUc1cuSPdY
         jjpQ9dsBH1eKQ7MuYo4hur5HEnn+Cq27wjVMc5Rj7FG3U3AOqeRR7h4EsDxmZABG3wNI
         bA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sPSIxVNqSB9G6SRgGp4hjqBXmPGfCStVgCLOhu5E9sY=;
        b=6P54VVhPE/9lNi+94zXwsbYcAi9h5Fsysisyt1omxsp4eqe38fFMtuNI6SImyv/Dra
         cOzDqxDSeNV3RXVUL3GCjbOB4u/j8Iyyw8g0ergBCJd87sMwjPO+a5HsWM/84rCz+k/a
         dYflGx6x5EZwSQJXMBJankMgNmGhDW8OzKgIP6tnWhRI2viS/QgMe2fCiC2m1DmQ/Vd8
         A6BnPLAq2BbtwerErRas2B5GwpQMP+dAX0vlpATnWJwlQ1+JvvG7cy441G4aQoKU/qh9
         30UpbiTKq1nqg4w5v7Pe91A8x0XnQXcJCyq/T565b8jScEqzcHxhnJrQl6UhFEc8Xdu0
         QuFw==
X-Gm-Message-State: AJIora8rCxLeFr4U9ssVeluHU4Ngmv9rhYgOJpoanjKzvx5+gIb8XyNU
        vIfHHDzuy3Pihnap2jNaq39amK+ylqPC/0jQytxXbckY+BLnLQ==
X-Google-Smtp-Source: AGRyM1vW6EzHFn8SmAqc0MGiAqqOrlbY41AYPMgRFDLYsDM6DU6s5kp/eDr1PcDAn6dFj5Tvca3Ta1GpQT5zj6tjSGM=
X-Received: by 2002:a25:cbcf:0:b0:66e:8893:a02c with SMTP id
 b198-20020a25cbcf000000b0066e8893a02cmr2813539ybg.460.1657706071710; Wed, 13
 Jul 2022 02:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220712195043.3842081-1-horatiu.vultur@microchip.com> <20220712195043.3842081-2-horatiu.vultur@microchip.com>
In-Reply-To: <20220712195043.3842081-2-horatiu.vultur@microchip.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Jul 2022 11:53:55 +0200
Message-ID: <CAHp75VepPJXCiwW+Ztw6awoXwL-d3Sr=TF8xkLyg9uR-bzFxRQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] pinctrl: ocelot: Fix pincfg for lan966x
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        kavyasree.kotagiri@microchip.com,
        Colin Foster <colin.foster@in-advantage.com>,
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

On Tue, Jul 12, 2022 at 9:46 PM Horatiu Vultur
<horatiu.vultur@microchip.com> wrote:
>
> The blamed commit introduce support for lan966x which use the same
> pinconf_ops as sparx5. The problem is that pinconf_ops is specific to
> sparx5. More precisely the offset of the bits in the pincfg register are
> different and also lan966x doesn't have support for
> PIN_CONFIG_INPUT_SCHMITT_ENABLE.
>
> Fix this by making pinconf_ops more generic such that it can be also
> used by lan966x. This is done by introducing 'ocelot_pincfg_data' which
> contains the offset and what is supported for each SOC.

Looks better, my comments below.

...

> +               const struct ocelot_pincfg_data *opd = info->pincfg_data;

This one...

...

> @@ -1425,17 +1436,20 @@ static int ocelot_pinconf_get(struct pinctrl_dev *pctldev,

...can also be applied here...

...

>                 case PIN_CONFIG_BIAS_PULL_DOWN:
>                         arg = (param == PIN_CONFIG_BIAS_DISABLE) ? 0 :
> -                       (param == PIN_CONFIG_BIAS_PULL_UP) ? BIAS_PU_BIT :
> -                       BIAS_PD_BIT;
> +                       (param == PIN_CONFIG_BIAS_PULL_UP) ? info->pincfg_data->pu_bit :
> +                       info->pincfg_data->pd_bit;

...which in particular may help to sort out this indentation mess.

-- 
With Best Regards,
Andy Shevchenko
