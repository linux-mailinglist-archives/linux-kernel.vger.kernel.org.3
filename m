Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50ACF501F8C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 02:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347962AbiDOAY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 20:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243569AbiDOAY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 20:24:26 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CA0A56C5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:21:59 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id q189so7101490oia.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=5IY6NjAmBdKOWKLPZC4vSegCFmTBaHiuffNg+ZPVhK8=;
        b=OpM/G7lrum+gAuf/Tgr7b+sNM4gBzyRjfd8kvR1GptQWN3t7mBFb/MReudzOES0WZW
         riaA6E3ew9i59KjjonWseF1NBr9MM6OTkEF+adgzoozTW4wIaPnmhnNWweJqhd7ahatF
         LhJXZbg/KCUNbw7jmLMXWqGHIBp/vHDu1tmKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=5IY6NjAmBdKOWKLPZC4vSegCFmTBaHiuffNg+ZPVhK8=;
        b=tnp066NlZCyPe9xOBAWibVNgrSbDOFk60g09sfpoYAkHZajvL4IlfvPZjBCBifBvQF
         zvQXBSusPx3A7MBbUsy3wWNjR5scrdDhubMPV6aOl50TUMrqzuwzdcuzQQDWx55TNSlg
         OEiUpqA0Jjfp4wPHVxIyW3akM0PtN5qLKxQrEXcuAZo+LbA+bflh61URXNEWvwSAaoRV
         ogXBYzE9zwta6hq5xAKVlBsQyWTzlEM4kI+DwGkrpgtmfpMK9mvT12pSjIJlIb1nXjl5
         QFME3S5NMiAKGfOAJmwZ+lVFlbxfVViNZHYvubCK2h/sVSL6g7g80BhG7pEFNvFwQPDh
         ayxA==
X-Gm-Message-State: AOAM533y9LHFA/7hrBQ2yu+TjAGIQngi8bQzBU0GRfsArpzls/UtUmE9
        ICt7BWtfqdmocydIc0V/n4fco9mVaJ3VuQL0UMLl9Ed3hlQ=
X-Google-Smtp-Source: ABdhPJypIgNktBkjnWGia6IlIC4oP1CFagyk369HzHgNIecVsreGAFXzA81xFS5Zq3NdSuja/lvLT8LdgX+fKFgpGUo=
X-Received: by 2002:aca:bd41:0:b0:2ec:ff42:814f with SMTP id
 n62-20020acabd41000000b002ecff42814fmr533554oif.63.1649982118589; Thu, 14 Apr
 2022 17:21:58 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 14 Apr 2022 17:21:58 -0700
MIME-Version: 1.0
In-Reply-To: <1649939418-19861-6-git-send-email-quic_c_skakit@quicinc.com>
References: <1649939418-19861-1-git-send-email-quic_c_skakit@quicinc.com> <1649939418-19861-6-git-send-email-quic_c_skakit@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 14 Apr 2022 17:21:57 -0700
Message-ID: <CAE-0n531GVMuuR6HM2ezjOPJCg7S-rD3eaEKWzrYsnM-jwQHKw@mail.gmail.com>
Subject: Re: [PATCH V10 5/9] mfd: pm8008: Use i2c_new_dummy_device() API
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_collinsd@quicinc.com, quic_subbaram@quicinc.com,
        quic_jprakash@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Satya Priya (2022-04-14 05:30:14)
> Use i2c_new_dummy_device() to register clients along with
> the main mfd device.

Why?

>
> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> ---
> Changes in V10:
>  - Implement i2c_new_dummy_device to register extra clients.
>
>  drivers/mfd/qcom-pm8008.c       | 54 +++++++++++++++++++++++++++++++++--------
>  include/linux/mfd/qcom_pm8008.h | 13 ++++++++++
>  2 files changed, 57 insertions(+), 10 deletions(-)
>  create mode 100644 include/linux/mfd/qcom_pm8008.h
>
> diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
> index 97a72da..ca5240d 100644
> --- a/drivers/mfd/qcom-pm8008.c
> +++ b/drivers/mfd/qcom-pm8008.c
> @@ -56,8 +57,10 @@ enum {
>  #define PM8008_PERIPH_OFFSET(paddr)    (paddr - PM8008_PERIPH_0_BASE)
>
>  struct pm8008_data {
> +       bool ready;
>         struct device *dev;
> -       struct regmap *regmap;
> +       struct i2c_client *clients[PM8008_NUM_CLIENTS];
> +       struct regmap *regmap[PM8008_NUM_CLIENTS];
>         struct gpio_desc *reset_gpio;
>         int irq;
>         struct regmap_irq_chip_data *irq_data;
> @@ -152,9 +155,20 @@ static struct regmap_config qcom_mfd_regmap_cfg = {
>         .max_register   = 0xFFFF,
>  };
>
> +struct regmap *pm8008_get_regmap(struct pm8008_data *chip, u8 sid)
> +{
> +       if (!chip || !chip->ready) {

Is it even possible?

> +               pr_err("pm8008 chip not initialized\n");
> +               return NULL;
> +       }
> +
> +       return chip->regmap[sid];
> +}
> +
>  static int pm8008_init(struct pm8008_data *chip)
>  {
>         int rc;
> +       struct regmap *regmap = pm8008_get_regmap(chip, PM8008_INFRA_SID);
>
>         /*
>          * Set TEMP_ALARM peripheral's TYPE so that the regmap-irq framework
> @@ -162,19 +176,19 @@ static int pm8008_init(struct pm8008_data *chip)
>          * This is required to enable the writing of TYPE registers in
>          * regmap_irq_sync_unlock().
>          */
> -       rc = regmap_write(chip->regmap,
> +       rc = regmap_write(regmap,
>                          (PM8008_TEMP_ALARM_ADDR | INT_SET_TYPE_OFFSET),
>                          BIT(0));
>         if (rc)
>                 return rc;
>
>         /* Do the same for GPIO1 and GPIO2 peripherals */
> -       rc = regmap_write(chip->regmap,
> +       rc = regmap_write(regmap,
>                          (PM8008_GPIO1_ADDR | INT_SET_TYPE_OFFSET), BIT(0));
>         if (rc)
>                 return rc;
>
> -       rc = regmap_write(chip->regmap,
> +       rc = regmap_write(regmap,
>                          (PM8008_GPIO2_ADDR | INT_SET_TYPE_OFFSET), BIT(0));
>
>         return rc;
> @@ -186,6 +200,7 @@ static int pm8008_probe_irq_peripherals(struct pm8008_data *chip,
>         int rc, i;
>         struct regmap_irq_type *type;
>         struct regmap_irq_chip_data *irq_data;
> +       struct regmap *regmap = pm8008_get_regmap(chip, PM8008_INFRA_SID);

Instead of calling pm8008_get_regmap() many times why not pass the
regmap through from pm8008_probe_irq_peripherals() called in probe? At
that point we could remove the regmap pointer from struct pm8008_data?

>
>         rc = pm8008_init(chip);
>         if (rc) {
> @@ -209,7 +224,7 @@ static int pm8008_probe_irq_peripherals(struct pm8008_data *chip,
>                                 IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW);
>         }
>
> -       rc = devm_regmap_add_irq_chip(chip->dev, chip->regmap, client_irq,
> +       rc = devm_regmap_add_irq_chip(chip->dev, regmap, client_irq,
>                         IRQF_SHARED, 0, &pm8008_irq_chip, &irq_data);
>         if (rc) {
>                 dev_err(chip->dev, "Failed to add IRQ chip: %d\n", rc);
> @@ -221,19 +236,38 @@ static int pm8008_probe_irq_peripherals(struct pm8008_data *chip,
>
>  static int pm8008_probe(struct i2c_client *client)
>  {
> -       int rc;
> +       int rc, i;
>         struct pm8008_data *chip;
> +       struct device_node *node = client->dev.of_node;
>
>         chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
>         if (!chip)
>                 return -ENOMEM;
>
>         chip->dev = &client->dev;
> -       chip->regmap = devm_regmap_init_i2c(client, &qcom_mfd_regmap_cfg);
> -       if (!chip->regmap)
> -               return -ENODEV;
>
> -       i2c_set_clientdata(client, chip);
> +       for (i = 0; i < PM8008_NUM_CLIENTS; i++) {

This is 2. Why do we have a loop? Just register the i2c client for
pm8008_infra first and then make a dummy for the second address without
the loop and the indentation. Are there going to be more i2c clients?

> +               if (i == 0) {
> +                       chip->clients[i] = client;
> +               } else {
> +                       chip->clients[i] = i2c_new_dummy_device(client->adapter,
> +                                                               client->addr + i);
> +                       if (IS_ERR(chip->clients[i])) {
> +                               dev_err(&client->dev, "can't attach client %d\n", i);
> +                               return PTR_ERR(chip->clients[i]);
> +                       }
> +                       chip->clients[i]->dev.of_node = of_node_get(node);
> +               }
> +
> +               chip->regmap[i] = devm_regmap_init_i2c(chip->clients[i],
> +                                                       &qcom_mfd_regmap_cfg);
> +               if (!chip->regmap[i])
> +                       return -ENODEV;
> +
> +               i2c_set_clientdata(chip->clients[i], chip);
> +       }
> +
> +       chip->ready = true;
>
>         if (of_property_read_bool(chip->dev->of_node, "interrupt-controller")) {
>                 rc = pm8008_probe_irq_peripherals(chip, client->irq);
> diff --git a/include/linux/mfd/qcom_pm8008.h b/include/linux/mfd/qcom_pm8008.h
> new file mode 100644
> index 0000000..bc64f01
> --- /dev/null
> +++ b/include/linux/mfd/qcom_pm8008.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __QCOM_PM8008_H__
> +#define __QCOM_PM8008_H__
> +
> +#define PM8008_INFRA_SID       0
> +#define PM8008_REGULATORS_SID  1
> +
> +#define PM8008_NUM_CLIENTS     2
> +
> +struct pm8008_data;
> +struct regmap *pm8008_get_regmap(struct pm8008_data *chip, u8 sid);

Could this be avoided if the regulator driver used
dev_get_regmap(&pdev->dev.parent, "regulator") to find the regmap named
"regulator" of the parent device, i.e. pm8008-infra.
