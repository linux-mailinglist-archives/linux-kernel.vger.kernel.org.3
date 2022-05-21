Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E7452F7CA
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 04:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239501AbiEUC4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 22:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239452AbiEUC4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 22:56:49 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E258CCDA
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 19:56:46 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id m6-20020a05683023a600b0060612720715so6633053ots.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 19:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=+fFcBjSAf87UPP4n61BZh84pFQOLteecqDYIAnGnP44=;
        b=UXCHYgV8LaiNYBX3aKHW32IpE+/JK3Gs2fh7pNcCj0hhgsb9Vy6/3HDiDiSK5hAgd3
         iNKcpdKWUjylyxk5nx6xrQDFbtAoAOp2UBcvKee8vGG1FXK3+WgLUHVvdjbH/1GEy2E0
         I8suv6pmxfgrg7eO3dcuuny3+AlmHGY1bTXaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=+fFcBjSAf87UPP4n61BZh84pFQOLteecqDYIAnGnP44=;
        b=HVYIitNZe2eAvC4CY66wkSruD4BrS1LEv08Vx7UG3ueeBTAMoMXTLZ9i/SjZIiP8BE
         UHllkupv84V0ZSzUGDwfO3qHWb4CtwdnAk4oFXBZ9lJFGE+95HHANyU3Uq2Vk8jQ7uBU
         EzfpCiOKAWcwXWZVbXVh/4YHz12xCfpTevTco3acvf5bpbK7gQc21pDJxZwYHscsqZiQ
         LdJ0zUzjX2VNT0ZZGJb0C0AzBNvk6sV5RNeaao0Nyd+YcgUCQuraK5R9nvl8gpbGmviA
         FMMW4wf/P/ggD892wSppAzqRdQvwz18Z/JvkRgfGvvUltb6BPd4O/swQO8xmbD5hymqy
         ZZ6g==
X-Gm-Message-State: AOAM530zw4p06IlaZYOLlzG2yYk3IKqN9IOF2/m767Jk+nhMtFpUEubh
        fx83nA6RPtqivUtXpmX78zZ60QIbmRJ9xJ3g5WL5jQ==
X-Google-Smtp-Source: ABdhPJyUCFPlWbeQHF0wnCW4EeqrHUI8rKoFENV7Tv3m3t2Am+k4t7VXLbQT6TsrVp2Fm8jo9Di1GQVefUdMKmGciT4=
X-Received: by 2002:a9d:63cd:0:b0:606:9e7f:79f8 with SMTP id
 e13-20020a9d63cd000000b006069e7f79f8mr5186433otl.77.1653101805482; Fri, 20
 May 2022 19:56:45 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 May 2022 19:56:45 -0700
MIME-Version: 1.0
In-Reply-To: <1653043777-24003-8-git-send-email-quic_c_skakit@quicinc.com>
References: <1653043777-24003-1-git-send-email-quic_c_skakit@quicinc.com> <1653043777-24003-8-git-send-email-quic_c_skakit@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 20 May 2022 19:56:44 -0700
Message-ID: <CAE-0n53WLYR1pjnr6wASVmXXQ7xTq5n2Q7GdeKOCkWf4H4n=0A@mail.gmail.com>
Subject: Re: [PATCH V13 7/9] regulator: Add a regulator driver for the PM8008 PMIC
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
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Satya Priya (2022-05-20 03:49:35)
> diff --git a/drivers/regulator/qcom-pm8008-regulator.c b/drivers/regulator/qcom-pm8008-regulator.c
> new file mode 100644
> index 0000000..6e815c6
> --- /dev/null
> +++ b/drivers/regulator/qcom-pm8008-regulator.c
> @@ -0,0 +1,225 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2022, The Linux Foundation. All rights reserved. */
> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/qcom_pm8008.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>

What in of_device.h is used?

> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/driver.h>
> +
> +#define VSET_STEP_MV                   8
> +#define VSET_STEP_UV                   (VSET_STEP_MV * 1000)
> +
> +#define LDO_ENABLE_REG(base)           ((base) + 0x46)
> +#define ENABLE_BIT                     BIT(7)
> +
> +#define LDO_VSET_LB_REG(base)          ((base) + 0x40)
> +
> +#define LDO_STEPPER_CTL_REG(base)      ((base) + 0x3b)
> +#define DEFAULT_VOLTAGE_STEPPER_RATE   38400
> +#define STEP_RATE_MASK                 GENMASK(1, 0)
> +
> +struct pm8008_regulator_data {
> +       const char                      *name;
> +       const char                      *supply_name;
> +       int                             min_uv;
> +       int                             max_uv;
> +       int                             min_dropout_uv;
> +       const struct linear_range       *voltage_range;
> +};
> +
> +struct pm8008_regulator {
> +       struct device           *dev;
> +       struct regmap           *regmap;
> +       struct regulator_desc   rdesc;
> +       u16                     base;
> +       int                     step_rate;
> +       int                     voltage_selector;
> +};
> +
> +static const struct linear_range nldo_ranges[] = {
> +       REGULATOR_LINEAR_RANGE(528000, 0, 122, 8000),
> +};
> +
> +static const struct linear_range pldo_ranges[] = {
> +       REGULATOR_LINEAR_RANGE(1504000, 0, 237, 8000),
> +};
> +
> +static const struct pm8008_regulator_data reg_data[] = {
> +       /* name  parent       min_uv  max_uv  headroom_uv voltage_range */
> +       { "ldo1", "vdd_l1_l2", 528000, 1504000, 225000, nldo_ranges, },
> +       { "ldo2", "vdd_l1_l2", 528000, 1504000, 225000, nldo_ranges, },
> +       { "ldo3", "vdd_l3_l4", 1504000, 3400000, 300000, pldo_ranges, },
> +       { "ldo4", "vdd_l3_l4", 1504000, 3400000, 300000, pldo_ranges, },
> +       { "ldo5", "vdd_l5",    1504000, 3400000, 200000, pldo_ranges, },
> +       { "ldo6", "vdd_l6",    1504000, 3400000, 200000, pldo_ranges, },
> +       { "ldo7", "vdd_l7",    1504000, 3400000, 200000, pldo_ranges, },

If min/max_uv isn't changing per voltage_range maybe we can compare the
voltage_range pointer and set the min/max based on the pointer. That
would save some space in this table.

> +};
> +
> +static int pm8008_regulator_get_voltage(struct regulator_dev *rdev)
> +{
> +       struct pm8008_regulator *pm8008_reg = rdev_get_drvdata(rdev);
> +
> +       return pm8008_reg->voltage_selector;

Can this read the hardware instead of caching the value from
pm8008_regulator_set_voltage()?

> +}
> +
> +static inline int pm8008_write_voltage(struct pm8008_regulator *pm8008_reg,
> +                                                       int mV)
> +{
> +       __le16 vset_raw;
> +
> +       vset_raw = cpu_to_le16(mV);
> +
> +       return regmap_bulk_write(pm8008_reg->regmap,
> +                       LDO_VSET_LB_REG(pm8008_reg->base),
> +                       (const void *)&vset_raw, sizeof(vset_raw));
> +}
> +
> +static int pm8008_regulator_set_voltage_time(struct regulator_dev *rdev,
> +                               int old_uV, int new_uv)
> +{
> +       struct pm8008_regulator *pm8008_reg = rdev_get_drvdata(rdev);
> +
> +       return DIV_ROUND_UP(abs(new_uv - old_uV), pm8008_reg->step_rate);
> +}
> +
> +static int pm8008_regulator_set_voltage(struct regulator_dev *rdev,
> +                                       unsigned int selector)
> +{
> +       struct pm8008_regulator *pm8008_reg = rdev_get_drvdata(rdev);
> +       int rc, mV;
> +
> +       /* voltage control register is set with voltage in millivolts */
> +       mV = DIV_ROUND_UP(regulator_list_voltage_linear_range(rdev, selector),

If regulator_list_voltage_linear_range() returns an error value then
we're going to div round up by 1000 and return it? Will it even be an
error value anymore?

Check for an error before div round up I suspect.

> +                                               1000);
> +       if (mV < 0)
> +               return mV;
> +
> +       rc = pm8008_write_voltage(pm8008_reg, mV);
> +       if (rc < 0)
> +               return rc;
> +
> +       pm8008_reg->voltage_selector = selector;
> +       dev_dbg(&rdev->dev, "voltage set to %d\n", mV * 1000);

We have tracepoints for this, right? Remove the debug printk please and
use tracepoints instead.

> +       return 0;
> +}
> +
> +static const struct regulator_ops pm8008_regulator_ops = {
> +       .enable                 = regulator_enable_regmap,
> +       .disable                = regulator_disable_regmap,
> +       .is_enabled             = regulator_is_enabled_regmap,
> +       .set_voltage_sel        = pm8008_regulator_set_voltage,
> +       .get_voltage_sel        = pm8008_regulator_get_voltage,
> +       .list_voltage           = regulator_list_voltage_linear,
> +       .set_voltage_time       = pm8008_regulator_set_voltage_time,
> +};
> +
> +static int pm8008_regulator_probe(struct platform_device *pdev)
> +{
> +       int rc, i;
> +       u32 base;
> +       unsigned int reg;
> +       const char *name;
> +       struct device *dev = &pdev->dev;
> +       struct regulator_config reg_config = {};
> +       struct regulator_dev    *rdev;
> +       const struct pm8008_data *chip = dev_get_drvdata(pdev->dev.parent);
> +       struct pm8008_regulator *pm8008_reg;
> +
> +       pm8008_reg = devm_kzalloc(dev, sizeof(*pm8008_reg), GFP_KERNEL);
> +       if (!pm8008_reg)
> +               return -ENOMEM;
> +
> +       pm8008_reg->regmap = pm8008_get_regmap(chip);
> +       if (!pm8008_reg->regmap) {
> +               dev_err(dev, "parent regmap is missing\n");
> +               return -EINVAL;
> +       }
> +
> +       pm8008_reg->dev = dev;
> +
> +       rc = of_property_read_string(dev->of_node, "regulator-name", &name);
> +       if (rc)
> +               return rc;
> +
> +       /* get the required regulator data */
> +       for (i = 0; i < ARRAY_SIZE(reg_data); i++)
> +               if (strstr(name, reg_data[i].name))

Why not find this via reg/address instead? It would save storing the
regulator name in the reg_data table.

> +                       break;
> +
> +       if (i == ARRAY_SIZE(reg_data)) {
> +               dev_err(dev, "Invalid regulator name %s\n", name);
> +               return -EINVAL;
> +       }
> +
> +       rc = of_property_read_u32_index(dev->of_node, "reg", 1, &base);
> +       if (rc < 0) {
> +               dev_err(dev, "%s: failed to get regulator base rc=%d\n", name, rc);
> +               return rc;
> +       }
> +       pm8008_reg->base = base;
> +
> +       /* get slew rate */
> +       rc = regmap_bulk_read(pm8008_reg->regmap,
> +                       LDO_STEPPER_CTL_REG(pm8008_reg->base), &reg, 1);
> +       if (rc < 0) {
> +               dev_err(dev, "failed to read step rate configuration rc=%d\n", rc);
> +               return rc;
> +       }
> +       reg &= STEP_RATE_MASK;
> +       pm8008_reg->step_rate = DEFAULT_VOLTAGE_STEPPER_RATE >> reg;
> +
> +       pm8008_reg->rdesc.type = REGULATOR_VOLTAGE;
> +       pm8008_reg->rdesc.ops = &pm8008_regulator_ops;
> +       pm8008_reg->rdesc.name = reg_data[i].name;

The name could be set via dev_name()?

> +       pm8008_reg->rdesc.supply_name = reg_data[i].supply_name;
> +       pm8008_reg->rdesc.of_match = reg_data[i].name;

Is this used?

> +       pm8008_reg->rdesc.uV_step = VSET_STEP_UV;
> +       pm8008_reg->rdesc.min_uV = reg_data[i].min_uv;
> +       pm8008_reg->rdesc.n_voltages
> +               = ((reg_data[i].max_uv - reg_data[i].min_uv)
> +                       / pm8008_reg->rdesc.uV_step) + 1;
> +       pm8008_reg->rdesc.linear_ranges = reg_data[i].voltage_range;
> +       pm8008_reg->rdesc.n_linear_ranges = 1;

We should make sure nldo_ranges and pldo_ranges doesn't become larger
and we forget to update this. Can we use some static assert?

	static_assert(ARRAY_SIZE(pldo_ranges) == 1 && ARRAY_SIZE(nldo_ranges) == 1);

> +       pm8008_reg->rdesc.enable_reg = LDO_ENABLE_REG(pm8008_reg->base);
> +       pm8008_reg->rdesc.enable_mask = ENABLE_BIT;
> +       pm8008_reg->rdesc.min_dropout_uV = reg_data[i].min_dropout_uv;
> +       pm8008_reg->voltage_selector = -ENOTRECOVERABLE;
> +
> +       reg_config.dev = dev->parent;
> +       reg_config.driver_data = pm8008_reg;
> +       reg_config.regmap = pm8008_reg->regmap;
> +
> +       rdev = devm_regulator_register(dev, &pm8008_reg->rdesc, &reg_config);
> +       if (IS_ERR(rdev)) {
> +               rc = PTR_ERR(rdev);
> +               dev_err(dev, "%s: failed to register regulator rc=%d\n",
> +                               reg_data[i].name, rc);
> +               return rc;
> +       }
> +
> +       return 0;
> +}
> +
