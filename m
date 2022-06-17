Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160F354FADB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 18:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383199AbiFQQKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 12:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383145AbiFQQKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 12:10:05 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7899236156;
        Fri, 17 Jun 2022 09:10:04 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id o7so9678514eja.1;
        Fri, 17 Jun 2022 09:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2dFjnX3mVMF7xL9NmgRQYKF7e0pvRvIc8LSD1srOJHY=;
        b=PwqIy/KzvDlBICWRZtbd3mTtnJRtiZvU8g7ENRe2/TFZyNMuDzoxk30fsp8TvpB6NW
         fKpjQ9U6KEW4Z3QVDAhbkUSt+DU1o1wkuFzfv5M7Id8UCdUOsLfr07Cf6XYlSNqy/c1j
         iLz6kqCIDwb4LVc7h4gRTFTKTUOxyYbk6uBJnTBXQwgqH7FkwGHm7RJIGyuUZByDL7Eq
         pQxchUHRvV1rsBa0N8gIBU9qR2crDHa7/xz1r5qPOHDF/iDJJgJJDP8wDXjalEImyshw
         aoobTO9jvWuy8+tCKqJKsQLm0cCh9uMcq53T47uhAf3PXmuUoft7TBK29Li/3Hhb/CVo
         dnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2dFjnX3mVMF7xL9NmgRQYKF7e0pvRvIc8LSD1srOJHY=;
        b=7D3MRQKp57MjsxUZaTruRrEIU5O8mTArpgiZ73Px+yFoL7+sNHDG220oXesNf9wC0u
         BukdN2b3WP/GBgm4vS3u6aOh2/OX/Nuqkx8+gNHLhZS7Q/TMBOLLh5qU98MVagoI3amG
         bXoM9WidqjdNS+8yUrSRAL5cyRsuJQuamPL5re6LcV1K5+sTpTMiZDeGTTAfMjA4y0u6
         vAKGcJDPnxMoT+nBjSw4uve8FWopFCWVZzH/GbBJxrfQ0TGy21Rrh2ExWN35TaIECUcG
         8WXRfBDubCXUHlTRtuPQQ+8ji5fzk56VTY/0pAMeUTKAkXdXMfCZXV9vxBvbW/h9dM6d
         JRcQ==
X-Gm-Message-State: AJIora83/bJ3gw/4hwhzgybOpGrvNC38GZSluIPxN45Ft4OqOEoPu6nL
        oyTnSQveqR9jOUC1fe0mmUFi3XWxyvQVWCoOHBE=
X-Google-Smtp-Source: AGRyM1vxFS3gGLoZx15i7W1dVsgyO/gYWKvfpvn09x+q2qxkH0jSJjyUOERWSIlx6JuwS5rJDsFA39oGWrcfC5GonAA=
X-Received: by 2002:a17:906:c7c1:b0:711:d2e9:99d0 with SMTP id
 dc1-20020a170906c7c100b00711d2e999d0mr9974582ejb.639.1655482202936; Fri, 17
 Jun 2022 09:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220617122855.739190-1-aidanmacdonald.0x0@gmail.com> <20220617122855.739190-2-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220617122855.739190-2-aidanmacdonald.0x0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Jun 2022 18:09:26 +0200
Message-ID: <CAHp75VdwYgx1H5+Ak4xXuzrBQ8AoM0=FPKtHdoyF2jHbY3QbgQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pinctrl: ingenic: Use irqd_to_hwirq()
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Marc Zyngier <maz@kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, Jun 17, 2022 at 2:27 PM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:
>
> Instead of accessing ->hwirq directly, use irqd_to_hwirq().

LGTM,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  drivers/pinctrl/pinctrl-ingenic.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
> index 1ca11616db74..69e0d88665d3 100644
> --- a/drivers/pinctrl/pinctrl-ingenic.c
> +++ b/drivers/pinctrl/pinctrl-ingenic.c
> @@ -3393,7 +3393,7 @@ static void ingenic_gpio_irq_mask(struct irq_data *irqd)
>  {
>         struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
>         struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
> -       int irq = irqd->hwirq;
> +       irq_hw_number_t irq = irqd_to_hwirq(irqd);
>
>         if (is_soc_or_above(jzgc->jzpc, ID_JZ4740))
>                 ingenic_gpio_set_bit(jzgc, GPIO_MSK, irq, true);
> @@ -3405,7 +3405,7 @@ static void ingenic_gpio_irq_unmask(struct irq_data *irqd)
>  {
>         struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
>         struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
> -       int irq = irqd->hwirq;
> +       irq_hw_number_t irq = irqd_to_hwirq(irqd);
>
>         if (is_soc_or_above(jzgc->jzpc, ID_JZ4740))
>                 ingenic_gpio_set_bit(jzgc, GPIO_MSK, irq, false);
> @@ -3417,7 +3417,7 @@ static void ingenic_gpio_irq_enable(struct irq_data *irqd)
>  {
>         struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
>         struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
> -       int irq = irqd->hwirq;
> +       irq_hw_number_t irq = irqd_to_hwirq(irqd);
>
>         if (is_soc_or_above(jzgc->jzpc, ID_JZ4770))
>                 ingenic_gpio_set_bit(jzgc, JZ4770_GPIO_INT, irq, true);
> @@ -3433,7 +3433,7 @@ static void ingenic_gpio_irq_disable(struct irq_data *irqd)
>  {
>         struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
>         struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
> -       int irq = irqd->hwirq;
> +       irq_hw_number_t irq = irqd_to_hwirq(irqd);
>
>         ingenic_gpio_irq_mask(irqd);
>
> @@ -3449,7 +3449,7 @@ static void ingenic_gpio_irq_ack(struct irq_data *irqd)
>  {
>         struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
>         struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
> -       int irq = irqd->hwirq;
> +       irq_hw_number_t irq = irqd_to_hwirq(irqd);
>         bool high;
>
>         if ((irqd_get_trigger_type(irqd) == IRQ_TYPE_EDGE_BOTH) &&
> @@ -3477,6 +3477,7 @@ static int ingenic_gpio_irq_set_type(struct irq_data *irqd, unsigned int type)
>  {
>         struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
>         struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
> +       irq_hw_number_t irq = irqd_to_hwirq(irqd);
>
>         switch (type) {
>         case IRQ_TYPE_EDGE_BOTH:
> @@ -3498,12 +3499,12 @@ static int ingenic_gpio_irq_set_type(struct irq_data *irqd, unsigned int type)
>                  * best we can do is to set up a single-edge interrupt and then
>                  * switch to the opposing edge when ACKing the interrupt.
>                  */
> -               bool high = ingenic_gpio_get_value(jzgc, irqd->hwirq);
> +               bool high = ingenic_gpio_get_value(jzgc, irq);
>
>                 type = high ? IRQ_TYPE_LEVEL_LOW : IRQ_TYPE_LEVEL_HIGH;
>         }
>
> -       irq_set_type(jzgc, irqd->hwirq, type);
> +       irq_set_type(jzgc, irq, type);
>         return 0;
>  }
>
> @@ -3668,20 +3669,22 @@ static const struct pinctrl_ops ingenic_pctlops = {
>  static int ingenic_gpio_irq_request(struct irq_data *data)
>  {
>         struct gpio_chip *gpio_chip = irq_data_get_irq_chip_data(data);
> +       irq_hw_number_t irq = irqd_to_hwirq(data);
>         int ret;
>
> -       ret = ingenic_gpio_direction_input(gpio_chip, data->hwirq);
> +       ret = ingenic_gpio_direction_input(gpio_chip, irq);
>         if (ret)
>                 return ret;
>
> -       return gpiochip_reqres_irq(gpio_chip, data->hwirq);
> +       return gpiochip_reqres_irq(gpio_chip, irq);
>  }
>
>  static void ingenic_gpio_irq_release(struct irq_data *data)
>  {
>         struct gpio_chip *gpio_chip = irq_data_get_irq_chip_data(data);
> +       irq_hw_number_t irq = irqd_to_hwirq(data);
>
> -       return gpiochip_relres_irq(gpio_chip, data->hwirq);
> +       return gpiochip_relres_irq(gpio_chip, irq);
>  }
>
>  static int ingenic_pinmux_set_pin_fn(struct ingenic_pinctrl *jzpc,
> --
> 2.35.1
>


-- 
With Best Regards,
Andy Shevchenko
