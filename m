Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7E2543D12
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 21:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbiFHTmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 15:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiFHTmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 15:42:35 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603F460F7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 12:42:33 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id f9-20020a9d2c09000000b0060bf1fa91f4so8609080otb.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 12:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=/tgjH9mFdfvMGKoTcSwglUP7+Zl5pVfpIKW93n2nUZk=;
        b=IjgzC9DLdUtW+ScdWa7zZTdP0ua6Oe5FJ6F5MYRowLOTlysZhiZX2FARdp0zwj1rb0
         GSGzLVgBKfHbNw1rakz425yBP2+LJmAfJpXrSIExQ2uPs7cufg2kONR3AplWwQDjDJGU
         xxPIqNkcIUE67yC7Ye/LBYlUGKfjcsgQp8o5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=/tgjH9mFdfvMGKoTcSwglUP7+Zl5pVfpIKW93n2nUZk=;
        b=g2jN1ySsQTNCFUp+jFirlxpD/Y3EGsFirVZ2X9qdvHGmXB5cqyQ72NWVJelxajHema
         bb8cZIartes1tPrvl9wRygihq8wy2UPKzyms4qlyNjcRM5gu8oER60eUUMKvH17W0usr
         Dl8l139WXZzbpcta0B5sfK10oJQtpdNrSM9rlGDY0QTtDXqepeF1h/SeFprowV6hPqvN
         HoDjcCX9giTxWIxeJPleUYTLmfS+ek5jW0oRmjHW6lv4q7dK/+D7nKbMf1I6GzfGSFMj
         mr+SBuEzwjrLM7ejG/VL+Els8Ea9Wai/2UQjW3guiA4OPENJecN69SH1VAwYoJqr5Z5p
         CPzQ==
X-Gm-Message-State: AOAM533lrlNAZmMtptFfCeFvTqjabsKChGqVekQxOGLwLUASYaTFoeYq
        E52x01idTat8ff6gQL82iXoo0rJKI+giYGl2xKJaDA==
X-Google-Smtp-Source: ABdhPJwjCG+CwZWvg902g0alknSaarK/lRkMXJPhsKVBSrQCa48DDOgEor0STgV+nlSx2ftFeBsSRdizIn98jCKfAwk=
X-Received: by 2002:a9d:729b:0:b0:60c:21bd:97c0 with SMTP id
 t27-20020a9d729b000000b0060c21bd97c0mr464708otj.77.1654717352641; Wed, 08 Jun
 2022 12:42:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jun 2022 12:42:32 -0700
MIME-Version: 1.0
In-Reply-To: <1654602615-28849-8-git-send-email-quic_c_skakit@quicinc.com>
References: <1654602615-28849-1-git-send-email-quic_c_skakit@quicinc.com> <1654602615-28849-8-git-send-email-quic_c_skakit@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 8 Jun 2022 12:42:32 -0700
Message-ID: <CAE-0n53iZk3U3ZWHj8VBUn2gi1KzFz0ZdxABiZvTPzK=cKu1Ng@mail.gmail.com>
Subject: Re: [PATCH V14 7/9] regulator: Add a regulator driver for the PM8008 PMIC
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
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Satya Priya (2022-06-07 04:50:13)
> diff --git a/drivers/regulator/qcom-pm8008-regulator.c b/drivers/regulator/qcom-pm8008-regulator.c
> new file mode 100644
> index 0000000..71cb95c
> --- /dev/null
> +++ b/drivers/regulator/qcom-pm8008-regulator.c
> @@ -0,0 +1,248 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/qcom_pm8008.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
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
> +#define NLDO_MIN_UV                    528000
> +#define NLDO_MAX_UV                    1504000
> +
> +#define PLDO_MIN_UV                    1504000
> +#define PLDO_MAX_UV                    3400000
> +
> +struct pm8008_regulator_data {
> +       const char                      *name;
> +       const char                      *supply_name;
> +       int                             min_dropout_uv;
> +       const struct linear_range       *voltage_range;
> +};
> +
> +struct pm8008_regulator {
> +       struct device           *dev;

Is this used anywhere?

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
> +static_assert(ARRAY_SIZE(pldo_ranges) == 1 && ARRAY_SIZE(nldo_ranges) == 1);

Can this static_assert be placed next to the assignment of
n_linear_ranges in probe?

> +
> +static const struct pm8008_regulator_data reg_data[] = {
> +       /* name  parent       headroom_uv voltage_range */
> +       { "ldo1", "vdd_l1_l2", 225000, nldo_ranges, },
> +       { "ldo2", "vdd_l1_l2", 225000, nldo_ranges, },
> +       { "ldo3", "vdd_l3_l4", 300000, pldo_ranges, },
> +       { "ldo4", "vdd_l3_l4", 300000, pldo_ranges, },
> +       { "ldo5", "vdd_l5",    200000, pldo_ranges, },
> +       { "ldo6", "vdd_l6",    200000, pldo_ranges, },
> +       { "ldo7", "vdd_l7",    200000, pldo_ranges, },
> +};
> +
> +static int pm8008_regulator_get_voltage(struct regulator_dev *rdev)
> +{
> +       struct pm8008_regulator *pm8008_reg = rdev_get_drvdata(rdev);
> +       __le16 mV;
> +       int rc, uV;
> +
> +       regmap_bulk_read(pm8008_reg->regmap,
> +                       LDO_VSET_LB_REG(pm8008_reg->base), (void *)&mV, 2);
> +
> +       uV = le16_to_cpu(mV) * 1000;
> +       return (uV - pm8008_reg->rdesc.min_uV) / pm8008_reg->rdesc.uV_step;
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
> +       rc = regulator_list_voltage_linear_range(rdev, selector);
> +       if (rc < 0)
> +               return rc;
> +
> +       /* voltage control register is set with voltage in millivolts */
> +       mV = DIV_ROUND_UP(rc, 1000);
> +
> +       rc = pm8008_write_voltage(pm8008_reg, mV);
> +       if (rc < 0)
> +               return rc;
> +
> +       pm8008_reg->voltage_selector = selector;

Is this used anywhere? I think not so remove it and the struct member?

> +
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
> +       pm8008_reg->rdesc.supply_name = reg_data[i].supply_name;
> +       pm8008_reg->rdesc.of_match = reg_data[i].name;
> +       pm8008_reg->rdesc.uV_step = VSET_STEP_UV;
> +       pm8008_reg->rdesc.linear_ranges = reg_data[i].voltage_range;
> +       pm8008_reg->rdesc.n_linear_ranges = 1;
> +

Ideally the static assert is right here.
