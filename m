Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7909848EEE4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 18:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243689AbiANRAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 12:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243672AbiANRAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 12:00:52 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26652C06173F
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 09:00:52 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id y4so18019955uad.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 09:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oKmCN3yojMQ2wi56P4UR8ruDKIpKUs7zR5mIdUilTLs=;
        b=c/em2xklv+/oiPVG3wTsLIBI/PYz+iiwoQwDyRu0z2WGsetY8k58VlWYjZ74jknml7
         6Km598wDrpzl0CGzCrAAR0yygQgYzQ70RNZmob1m3aoLEx7l4GAI2MsvP59jQoQuy2Ev
         q4UZ6uROQCaS4wDF1vEQWhZr42h6gvMrUReP4y2T+g/YFirmZyzn1NT0at9oT5nU6Mwz
         ONVcyHYScnayivUGaX9SjAgUUCbcHcJ27ckCH4T659y6ApgoD7aJZfjZVgfJLKDKLY7m
         BahChZQZ20cJ2K/Iq7ycKTmXSrs5eMoA4S3dRodPxwbKWs+uKs15irLcXcp0Ub6akDqb
         BGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oKmCN3yojMQ2wi56P4UR8ruDKIpKUs7zR5mIdUilTLs=;
        b=HTruWq1njO5mZbKHsJlyZmb0G9n86ooYfWK2jOPwjv5gPhbT8KbKA8EV0LwUDd2mR/
         45lE7X0MiVZKKi+9XObfQW44EVx/Uk98t+57Nac6wSIpI5OEKEcWGUbkEfAXB3GEd97M
         kkpmtt54gsNtyPC2+eseswJa27RQjd0BWydyFa6Pswb28ixkjtgL4Nadz1GtBl27hZJi
         0v8IfK2Mu6RZQaxp+Ulhl/VW7nu7x8r8h/krVMjCf6fAU3vPysPAxn93UshG9Ahrsffi
         CtZle9tSg/RGKEssT25TIbg6klHgxHTciTXSZ07TadrHPBq7RPDyQDdfGadNzp0FpGjq
         i+QA==
X-Gm-Message-State: AOAM533fUKfc0RVmdwlQWT4xFW2PWAxliQ9AgL+GUBsEiXxcXwU8vSEV
        39RNcjvzch000Ix2Up+qoFFXoNnf38yxVLlbzkZEow==
X-Google-Smtp-Source: ABdhPJzfMi5FAUwNLZJsBuj9+B3iYoKBkW9szO1rxl+UwYt/p1RLjf/xabkqjabSLUaCla5a0sBWNjE9cL/zlpKHmDk=
X-Received: by 2002:ab0:5a46:: with SMTP id m6mr4357760uad.104.1642179651179;
 Fri, 14 Jan 2022 09:00:51 -0800 (PST)
MIME-Version: 1.0
References: <20220111201426.326777-1-krzysztof.kozlowski@canonical.com> <20220111201426.326777-3-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220111201426.326777-3-krzysztof.kozlowski@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Fri, 14 Jan 2022 19:00:39 +0200
Message-ID: <CAPLW+4=TMyytDPO0t4c0Kayy9HAAja6dVq9L8_ic3vf_1LpSRA@mail.gmail.com>
Subject: Re: [PATCH v2 02/28] pinctrl: samsung: accept GPIO bank nodes with a suffix
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Alim Akhtar <alim.akhtar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 at 22:15, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> Existing dt-bindings expected that each GPIO/pin bank within pin
> controller has its own node with name matching the bank (e.g. gpa0,
> gpx2) and "gpio-controller" property.  The node name is then used for
> matching between driver data and DTS.
>
> Newly introduced dtschema expects to have nodes ending with "-gpio-bank"
> suffix, so rewrite bank-devicetree matching to look for old and new
> style of naming.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/pinctrl/samsung/pinctrl-samsung.c | 57 ++++++++++++++++++-----
>  1 file changed, 45 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
> index b19ebc43d886..b3a5bc473841 100644
> --- a/drivers/pinctrl/samsung/pinctrl-samsung.c
> +++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
> @@ -1012,13 +1012,56 @@ static void samsung_banks_of_node_put(struct samsung_pinctrl_drv_data *d)
>                 of_node_put(bank->of_node);
>  }
>
> +/*
> + * Iterate over all driver pin banks to find one matching the name of node,
> + * skipping optional "-gpio" node suffix. When found, assign node to the bank.
> + */
> +static void samsung_banks_of_node_get(struct device *dev,
> +                                     struct samsung_pinctrl_drv_data *d,
> +                                     struct device_node *node)
> +{
> +       const char *suffix = "-gpio-bank";
> +       struct samsung_pin_bank *bank;
> +       struct device_node *child;
> +       /* Pin bank names are up to 4 characters */
> +       char node_name[20];
> +       unsigned int i;
> +       size_t len;
> +
> +       bank = d->pin_banks;
> +       for (i = 0; i < d->nr_banks; ++i, ++bank) {
> +               strscpy(node_name, bank->name, sizeof(node_name));
> +               len = strlcat(node_name, suffix, sizeof(node_name));
> +               if (len >= sizeof(node_name)) {
> +                       dev_err(dev, "Too long pin bank name '%s', ignoring\n",
> +                               bank->name);
> +                       continue;
> +               }
> +
> +               for_each_child_of_node(node, child) {
> +                       if (!of_find_property(child, "gpio-controller", NULL))
> +                               continue;
> +                       if (of_node_name_eq(child, node_name))
> +                               break;
> +                       else if (of_node_name_eq(child, bank->name))
> +                               break;
> +               }
> +
> +               if (child)
> +                       bank->of_node = child;
> +               else
> +                       dev_warn(dev, "Missing node for bank %s - invalid DTB\n",
> +                                bank->name);
> +               /* child reference dropped in samsung_drop_banks_of_node() */
> +       }
> +}
> +
>  /* retrieve the soc specific data */
>  static const struct samsung_pin_ctrl *
>  samsung_pinctrl_get_soc_data(struct samsung_pinctrl_drv_data *d,
>                              struct platform_device *pdev)
>  {
>         struct device_node *node = pdev->dev.of_node;
> -       struct device_node *np;
>         const struct samsung_pin_bank_data *bdata;
>         const struct samsung_pin_ctrl *ctrl;
>         struct samsung_pin_bank *bank;
> @@ -1082,17 +1125,7 @@ samsung_pinctrl_get_soc_data(struct samsung_pinctrl_drv_data *d,
>          */
>         d->virt_base = virt_base[0];
>
> -       for_each_child_of_node(node, np) {
> -               if (!of_find_property(np, "gpio-controller", NULL))
> -                       continue;
> -               bank = d->pin_banks;
> -               for (i = 0; i < d->nr_banks; ++i, ++bank) {
> -                       if (of_node_name_eq(np, bank->name)) {
> -                               bank->of_node = np;
> -                               break;
> -                       }
> -               }
> -       }
> +       samsung_banks_of_node_get(&pdev->dev, d, node);
>
>         d->pin_base = pin_base;
>         pin_base += d->nr_pins;
> --
> 2.32.0
>
