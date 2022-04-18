Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DB3505EB0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 21:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242112AbiDRTuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 15:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbiDRTuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 15:50:35 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F5727FF0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 12:47:55 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g20so18602812edw.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 12:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NXg16T5RHzmRSU7fzbqLl5dRDSsIh5leaaKIVXJix2Y=;
        b=n6TH58tO6Jf+8u5wbFfxZZ1rGSt9UpKEMo4zwn5SrzJg5kBLgAnwKPjEFKGOn1AsVS
         BlTUiehQ1Zjs+vmeVNX+gknbYOIT7noOyWXV3+LClR4fl7XiIIaS/9Cc1rxU22dCtuaK
         pQ/b93oy/yreNJvMQcrLjfcxDGUaFW/7+1GLVBne6lfgv+anTs0MIp60sRbuPxKfMUTS
         mAdwxkPpboKUwwoyDwxwYgC5LimvdLfbqffeEt/evWZRKSDezMKAsw3qP4hQgLnBorKX
         ND5e4C+abAw+VaSHw4ACJGqoi5sIyB7YGM8tQwYQ2tdzkxbJwnwNtfd2/1CkMBa6U87y
         8F9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NXg16T5RHzmRSU7fzbqLl5dRDSsIh5leaaKIVXJix2Y=;
        b=oK3M0/WS02Ty6uuuQ1vTTb2Umo/mNGh5x0M/Wasf6higp8ORMaiNdTO2JbQ4BM6rqe
         A6dv8wkntPl8z3oJpXlGbESIbn/FRJRAaEHCX8ozQ7Y18sC4OsOpeSHqtp12ny1vZIq+
         gnFhhkZ5eb4PDHAfrw32QzM3RbsrC0xSF0P8b4duqzlVtrMO/fCJypANlj1Q6I+VQEKV
         iZgVcif511qEATw4UE3u8NmZDLm7Fh2h7HSSSwUM6F4/6PkbHtlM182oN8MQTVMSOQTk
         5kYOksVCuEQY27H6qCEbJi5shh9C6iyo9aKXcPxCdAKttVqObuhC1yPMHh+xNS6jAMMg
         DhJw==
X-Gm-Message-State: AOAM531MGhGAEMKlActprbw3M8Si2/whyKoqJHWfaDUNYtboxAftOjZO
        LWLsuLyZSaQ/3IBe1Y0m9luNn4Kl5wbLrll1XR63bQ==
X-Google-Smtp-Source: ABdhPJwvoJ8S2SQnY/koE4FsNKMAxVbvlxW9QX5pT4ZaYsnS74IHedJObRxq4/ya8URo4hGKRxRf5E8Bb0WAjXdhtak=
X-Received: by 2002:a05:6402:128f:b0:41d:7e85:8421 with SMTP id
 w15-20020a056402128f00b0041d7e858421mr13502922edv.352.1650311273941; Mon, 18
 Apr 2022 12:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220328005005.72492-1-kc@postmarketos.org> <20220328005005.72492-4-kc@postmarketos.org>
In-Reply-To: <20220328005005.72492-4-kc@postmarketos.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 18 Apr 2022 21:47:43 +0200
Message-ID: <CAMRc=MfmaW7QX6Q8JFi2-32E_JvE=z6EspnpiHD+4JjeNGFT4g@mail.gmail.com>
Subject: Re: [PATCH 3/4] gpio/rockchip: handle deferring input-enable pinconfs
To:     Caleb Connolly <kc@postmarketos.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, martijn@brixit.nl,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 2:50 AM Caleb Connolly <kc@postmarketos.org> wrote:
>
> Add support for deferred PIN_CONFIG_INPUT_ENABLE handling.
>
> Signed-off-by: Caleb Connolly <kc@postmarketos.org>
> ---
>  drivers/gpio/gpio-rockchip.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
> index bcf5214e3586..e342a6dc4c6c 100644
> --- a/drivers/gpio/gpio-rockchip.c
> +++ b/drivers/gpio/gpio-rockchip.c
> @@ -760,6 +760,11 @@ static int rockchip_gpio_probe(struct platform_device *pdev)
>                                 dev_warn(dev, "setting output pin %u to %u failed\n", cfg->pin,
>                                          cfg->arg);
>                         break;
> +               case PIN_CONFIG_INPUT_ENABLE:
> +                       ret = rockchip_gpio_direction_input(&bank->gpio_chip, cfg->pin);
> +                       if (ret)
> +                               dev_warn(dev, "setting input pin %u failed\n", cfg->pin);
> +                       break;
>                 default:
>                         dev_warn(dev, "unknown deferred config param %d\n", cfg->param);
>                         break;
> --
> 2.35.1
>

Does this depend on patches 1 & 2 or does patch 4 depend on this one? If so:

Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>

Otherwise I can take it through the GPIO tree.

Bart
