Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F5C501F99
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 02:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347984AbiDOA2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 20:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbiDOA2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 20:28:17 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F093FA9968
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:25:50 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-e2afb80550so6894458fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=nDi5kwOy7lNxg1rPCpDpY+vlHxRzgGL9RfEW71hVFmI=;
        b=UE1h2v55obO467jKxFC252sCHQe8gN5MnbIHa4InNM/U6EEC/+k4P3pmwYiY5URYSf
         I3gz7BNcJIXPBTqus3wM4uvgN1bQQpRvkvg6uTwC3ID9tZEY8WMimnW8y6gIPFWY8OtP
         54/8mFCdLgLkjsgLwTu3/Ud0MN5+LytCoQJq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=nDi5kwOy7lNxg1rPCpDpY+vlHxRzgGL9RfEW71hVFmI=;
        b=5DMw/hFx/6Pnc4a8WnAWo2uX1wEA6FIfk5xqWEmWNtOmwPvOFndo+0XizwsGSmIB+j
         KrJLWuT6bfKlOYOXltYixQM+SqKiNMWd5UT6KciWGmGebN9eHZ9B2Z7QxWH2UMJSiimz
         f3ln3ZG4ufzxuO5sY6MvmjPCgbWKZVQbNYWQrs/ThlAaZ7NN8su7tICLYYVuChkIHMYf
         5a48wEJD2oK46Sl4e3v9rWuVHhE+wdT1vP5+gz5LZA2kS6rVIMLqpclzQ38WVsAphhK1
         A+72OAJ/LBp3cJteWnd45lkuePjB63UA/nTKkaNzDFHGbyr8Ti04rh4NgTh8QcXr5tzU
         IzvA==
X-Gm-Message-State: AOAM533PWgz/g3F5sy0iHuiK9ypG3chMQqeig0E+H8wDqEUEIMlwA/gv
        T4zkMU+O8LY9hpSSF/XEmc05eGEEYTBtFB9nVhY+gQ==
X-Google-Smtp-Source: ABdhPJx2X+BdJzsOSjtJvEXdjNSmAUEMcR+pBvIiBz9XWX7DDAc7MkzU4IKlTE67+bZo7AGoXjDi0B/dIVDkIBeyhQw=
X-Received: by 2002:a05:6870:e893:b0:e2:ecbc:e581 with SMTP id
 q19-20020a056870e89300b000e2ecbce581mr430663oan.193.1649982349783; Thu, 14
 Apr 2022 17:25:49 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 14 Apr 2022 17:25:49 -0700
MIME-Version: 1.0
In-Reply-To: <1649939418-19861-8-git-send-email-quic_c_skakit@quicinc.com>
References: <1649939418-19861-1-git-send-email-quic_c_skakit@quicinc.com> <1649939418-19861-8-git-send-email-quic_c_skakit@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 14 Apr 2022 17:25:49 -0700
Message-ID: <CAE-0n533obTi995x_rJG_ihUUquF3MQLJt6VMf7=oxyzMUL5DQ@mail.gmail.com>
Subject: Re: [PATCH V10 7/9] regulator: Add a regulator driver for the PM8008 PMIC
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Satya Priya (2022-04-14 05:30:16)
> diff --git a/drivers/regulator/qcom-pm8008-regulator.c b/drivers/regulator/qcom-pm8008-regulator.c
> new file mode 100644
> index 0000000..4375ac5
> --- /dev/null
> +++ b/drivers/regulator/qcom-pm8008-regulator.c
> @@ -0,0 +1,201 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2022, The Linux Foundation. All rights reserved. */
> +
[..]
> +
> +static int pm8008_regulator_probe(struct platform_device *pdev)
> +{
> +       struct pm8008_data *chip = dev_get_drvdata(pdev->dev.parent);
> +       struct device *dev = &pdev->dev;
> +       struct regulator_dev    *rdev;
> +       struct pm8008_regulator *pm8008_reg;
> +       struct regmap *regmap;
> +       struct regulator_config reg_config = {};
> +       int rc, i;
> +       unsigned int reg;
> +
> +       regmap = pm8008_get_regmap(chip, PM8008_REGULATORS_SID);

Can we use dev_get_regmap(pdev->dev.parent, "regulators") here
instead? The benefit to that is we don't tightly couple this driver to
the pm8008_data structure or header file.

> +       if (!regmap) {
> +               dev_err(dev, "parent regmap is missing\n");
> +               return -EINVAL;
> +       }
> +
> +       for (i = 0; i < ARRAY_SIZE(reg_data); i++) {
> +               pm8008_reg = devm_kzalloc(dev, sizeof(*pm8008_reg), GFP_KERNEL);
> +               if (!pm8008_reg)
> +                       return -ENOMEM;
> +
> +               pm8008_reg->regmap = regmap;
> +               pm8008_reg->dev = dev;
> +               pm8008_reg->base = reg_data[i].base;
> +
> +               /* get slew rate */
> +               rc = regmap_bulk_read(pm8008_reg->regmap,
> +                               LDO_STEPPER_CTL_REG(pm8008_reg->base), &reg, 1);
> +               if (rc < 0) {
> +                       dev_err(dev, "failed to read step rate configuration rc=%d\n", rc);
> +                       return rc;
> +               }
> +               reg &= STEP_RATE_MASK;
> +               pm8008_reg->step_rate = DEFAULT_VOLTAGE_STEPPER_RATE >> reg;
> +
> +               pm8008_reg->rdesc.type = REGULATOR_VOLTAGE;
> +               pm8008_reg->rdesc.ops = &pm8008_regulator_ops;
> +               pm8008_reg->rdesc.name = reg_data[i].name;
> +               pm8008_reg->rdesc.supply_name = reg_data[i].supply_name;
> +               pm8008_reg->rdesc.of_match = reg_data[i].name;
> +               pm8008_reg->rdesc.uV_step = VSET_STEP_UV;
> +               pm8008_reg->rdesc.min_uV = reg_data[i].min_uv;
> +               pm8008_reg->rdesc.n_voltages
> +                       = ((reg_data[i].max_uv - reg_data[i].min_uv)
> +                               / pm8008_reg->rdesc.uV_step) + 1;
> +               pm8008_reg->rdesc.linear_ranges = reg_data[i].voltage_range;
> +               pm8008_reg->rdesc.n_linear_ranges = 1;
> +               pm8008_reg->rdesc.enable_reg = LDO_ENABLE_REG(pm8008_reg->base);
> +               pm8008_reg->rdesc.enable_mask = ENABLE_BIT;
> +               pm8008_reg->rdesc.min_dropout_uV = reg_data[i].min_dropout_uv;
> +               pm8008_reg->voltage_selector = -ENOTRECOVERABLE;
> +               pm8008_reg->rdesc.regulators_node = of_match_ptr("regulators");
> +
> +               reg_config.dev = dev->parent;
> +               reg_config.driver_data = pm8008_reg;
> +
> +               rdev = devm_regulator_register(dev, &pm8008_reg->rdesc, &reg_config);
> +               if (IS_ERR(rdev)) {
> +                       rc = PTR_ERR(rdev);
> +                       dev_err(dev, "%s: failed to register regulator rc=%d\n",
> +                                       reg_data[i].name, rc);
> +                       return rc;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static struct platform_driver pm8008_regulator_driver = {
> +       .driver = {
> +               .name           = "qcom-pm8008-regulator",

I'd prefer to use an of_device_id table here. That would let us populate
a "qcom,pm8008-regulators" node that had the ldo nodes as children and
avoid mfd cells.
