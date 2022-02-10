Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB1D4B0262
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 02:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbiBJBcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 20:32:17 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbiBJBcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:32:10 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F7D2252B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 17:32:06 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id ay7so4432496oib.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 17:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=JA8SYVMxaUyH4YyZJM0C21azBYEMmi2Y1kxP1Lk2Sfc=;
        b=O3c6mAlIw3LJ6tHGeInotdtty8m394xV0O/zN1i5RWCIhhfLgZUgyenmomq+2yAdtF
         lkBG5v1vqioAZDjPgTKmVulcUw7dq6qMEQs0O+YK8Al8OES0a8R9wNGRfl/NqhBso73B
         aZdSh1Vr0PxzlbkLbNsRCwjITa6mtVVMmdZHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=JA8SYVMxaUyH4YyZJM0C21azBYEMmi2Y1kxP1Lk2Sfc=;
        b=Iw1sT4eGRnR0b02Ki7QwuvjETE5Q6Yaj2G5nVfXIlJCL6mFHRrYnWxK4ZUi5GQSJE8
         TB7W7SPjjU/VeJ9+nBoFRzqhwmk+5m+18cDc1ov8ibrRwTOnIpqQGRxcITsc0reojQCl
         6K1qvWredOwBCxWDOdY5qgROeBkLDFnANI4QKxky8nI+8ZocuzQeikYgYvPU5tCkiXvF
         IdWfJNw4bpP17jIypGlQgBO2jCBFe4IjRIuD21AT+ml+JO7eQeWFGrAFoymy5iiGZx5y
         vTA3UulzOL1vTjvDsgjjfd9dqumOWMRrD+ZPbGqDD5wbWVOh6gLVRVXBkYSc0zSY2sgj
         p3ow==
X-Gm-Message-State: AOAM532SGpwtIVJHYZu9iYoozktrzO/tx97o1LNii7rraelgPLXWFEDp
        ktae3FcdcUyc3EnaMf3X8CEfGbvjJ8yTSfWoNpeb4Q==
X-Google-Smtp-Source: ABdhPJzzlx3EUJerFZaJLb5bo/Ioe6tDfoil/nNDn7PZlJm3As5kujrEC2xVsGqaKf2pGVwpd8IFLA4u8yQTkDzY6KU=
X-Received: by 2002:aca:ad97:: with SMTP id w145mr76985oie.238.1644456725843;
 Wed, 09 Feb 2022 17:32:05 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Feb 2022 17:32:05 -0800
MIME-Version: 1.0
In-Reply-To: <1644331940-18986-4-git-send-email-quic_c_skakit@quicinc.com>
References: <1644331940-18986-1-git-send-email-quic_c_skakit@quicinc.com> <1644331940-18986-4-git-send-email-quic_c_skakit@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 9 Feb 2022 17:32:05 -0800
Message-ID: <CAE-0n52B4heY5fcbz71JPOqvMVvmqsXO94V+Z0qTTw_XXextJw@mail.gmail.com>
Subject: Re: [PATCH V5 3/6] mfd: pm8008: Add mfd cell struct to register LDOs
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com
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

Quoting Satya Priya (2022-02-08 06:52:17)
> diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
> index c472d7f..e8569cc 100644
> --- a/drivers/mfd/qcom-pm8008.c
> +++ b/drivers/mfd/qcom-pm8008.c
> @@ -8,6 +8,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/irqdomain.h>
> +#include <linux/mfd/core.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/of_platform.h>
> @@ -27,6 +28,37 @@
>  #define INT_EN_CLR_OFFSET              0x16
>  #define INT_LATCHED_STS_OFFSET         0x18
>
> +static const struct mfd_cell pm8008_regulator_devs[] = {

Is there some way to not allocate this structure statically forever?

> +       {
> +               .name = "qcom,pm8008-regulators",
> +               .id = 0,
> +       },
> +       {
> +               .name = "qcom,pm8008-regulators",
> +               .id = 1,
> +       },
> +       {
> +               .name = "qcom,pm8008-regulators",
> +               .id = 2,
> +       },
> +       {
> +               .name = "qcom,pm8008-regulators",
> +               .id = 3,
> +       },
> +       {
> +               .name = "qcom,pm8008-regulators",
> +               .id = 4,
> +       },
> +       {
> +               .name = "qcom,pm8008-regulators",
> +               .id = 5,
> +       },
> +       {
> +               .name = "qcom,pm8008-regulators",
> +               .id = 6,
> +       },
> +};
> +
>  enum {
>         PM8008_MISC,
>         pm8008_temp_alarm,
> @@ -35,6 +67,17 @@ enum {
>         PM8008_NUM_PERIPHS,
>  };
>
> +enum {
> +       PM8008_INFRA,
> +       PM8008_REGULATORS,
> +};
> +
> +static const struct of_device_id pm8008_match[] = {
> +       { .compatible = "qcom,pm8008", .data = (void *)PM8008_INFRA},
> +       { .compatible = "qcom,pm8008-regulators", .data = (void *)PM8008_REGULATORS},
> +       { },

Nitpick: Drop , on {} so nothing can come after without causing compile
error.

> +};
> +
>  #define PM8008_PERIPH_0_BASE   0x900
>  #define PM8008_PERIPH_1_BASE   0x2400
>  #define PM8008_PERIPH_2_BASE   0xC000
> @@ -221,6 +264,7 @@ static int pm8008_probe(struct i2c_client *client)
>  {
>         int rc;
>         struct pm8008_data *chip;
> +       const struct of_device_id *id;
>
>         chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
>         if (!chip)
> @@ -239,14 +283,19 @@ static int pm8008_probe(struct i2c_client *client)
>                         dev_err(chip->dev, "Failed to probe irq periphs: %d\n", rc);
>         }
>
> +       id = of_match_node(pm8008_match, chip->dev->of_node);

Use device_get_match_data()? And then use (uintptr_t) casts to check for
the enum? Using device_get_match_data() allows us to avoid moving the
pm8008_match table.

> +       if (id->data == (void *)PM8008_REGULATORS) {

	enum <your_name_here> dev_type = device_get_match_data(dev);

	if (dev_type == PM8008_REGULATORS)

> +               rc = mfd_add_devices(chip->dev, 0, pm8008_regulator_devs,

Why not devm_mfd_add_devices()?

> +                               ARRAY_SIZE(pm8008_regulator_devs), NULL, 0, NULL);
> +               if (rc) {
> +                       dev_err(chip->dev, "Failed to add children: %d\n", rc);
> +                       return rc;
> +               }
> +       }
> +
>         return devm_of_platform_populate(chip->dev);
>  }
>
> -static const struct of_device_id pm8008_match[] = {
> -       { .compatible = "qcom,pm8008", },
> -       { },
> -};

This should have a MODULE_DEVICE_TABLE(of, pm8008_match) here.

> -
>  static struct i2c_driver pm8008_mfd_driver = {
>         .driver = {
>                 .name = "pm8008",
