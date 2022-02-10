Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE954B0297
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 03:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbiBJCAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 21:00:36 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbiBJB7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:59:23 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D138A2AAAC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 17:40:17 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id c7-20020a4ad207000000b002e7ab4185d2so4630349oos.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 17:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=xiMygS5GCAC4R42Lq/IZA4PNsqGvlfOWFaspwPB3zd4=;
        b=GDyRGUOiPVTELBOLuWceTs67AV5WGP9ASQIzh/UJirlP8awCGqcWU51IAygUD5QxrU
         U0qcljs5KaoeP8J113/DiGI2Tdd9uU/ymVfRd+FXMyKG1DGR+9FmkS/tahmtzHqTyFg+
         8HGC8XHsISG11qfPA/mdGtyvfmkZ9mW/FakUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=xiMygS5GCAC4R42Lq/IZA4PNsqGvlfOWFaspwPB3zd4=;
        b=qDFUBvll4EifH7/I3kAQX2LCiEMqOqfvxbUmxUE4MLgXD0IgfXJTUgS+LyVQMJ5irr
         Iq8Ra2Qz5ZJFTrTmFHYE8r9gbHmD4ABdOrFFNTg3tEegfeWAxQTnRDMwQdU5INGxBJqo
         0fs/d82KyYC2tP+PswEGcI5QXVDH6FnxPu4NA0EhH4DZ4EZa0HpMxpHn0+5o/sRP2u9+
         bhY0S4QjKFRIiAgY/9IzyW40M8kvTJ2UIvvFX9HcBwhqejaYlstlUXmtFsWzKMUj8DHT
         rbsKObAL1PE03IWweOiUEI2sOZycRNMPXSCNBQ4pvFZVe6I+O9R2BLWvSSxUUvPjBjRs
         ZuXQ==
X-Gm-Message-State: AOAM532pmdz/91FFPmPgKolYOLvTeHPa0BND4OmjLImoI4rSUI+ftxvD
        52qw/s3+lF2LA3TcPqc3ODATY7AM9uZWYJ+Pf66ASZqiTDM=
X-Google-Smtp-Source: ABdhPJy/vSbbs6NItTc17HLseFMtls6jhLxHfN9IoMajlkunPEPYPnJ3PT/NC7DSxTm6/4WL66QOH6XkRo6PMp+BL1U=
X-Received: by 2002:a05:6870:305:: with SMTP id m5mr66766oaf.200.1644457216837;
 Wed, 09 Feb 2022 17:40:16 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Feb 2022 17:40:16 -0800
MIME-Version: 1.0
In-Reply-To: <1644331940-18986-5-git-send-email-quic_c_skakit@quicinc.com>
References: <1644331940-18986-1-git-send-email-quic_c_skakit@quicinc.com> <1644331940-18986-5-git-send-email-quic_c_skakit@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 9 Feb 2022 17:40:16 -0800
Message-ID: <CAE-0n53kLn1t6HU9LHBMv6fRnjUj9NTtmRS8uKrwkWL0gzpAsQ@mail.gmail.com>
Subject: Re: [PATCH V5 4/6] regulator: Add a regulator driver for the PM8008 PMIC
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Satya Priya (2022-02-08 06:52:18)
> diff --git a/drivers/regulator/qcom-pm8008-regulator.c b/drivers/regulator/qcom-pm8008-regulator.c
> new file mode 100644
> index 0000000..86043b4
> --- /dev/null
> +++ b/drivers/regulator/qcom-pm8008-regulator.c
> @@ -0,0 +1,234 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2021, The Linux Foundation. All rights reserved. */
> +
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>
> +
> +#define STARTUP_DELAY_USEC             20
> +#define VSET_STEP_MV                   8
> +#define VSET_STEP_UV                   (VSET_STEP_MV * 1000)
> +
> +#define LDO_ENABLE_REG(base)           ((base) + 0x46)
> +#define ENABLE_BIT                     BIT(7)
> +
> +#define LDO_STATUS1_REG(base)          ((base) + 0x08)
> +#define VREG_READY_BIT                 BIT(7)
> +
> +#define LDO_VSET_LB_REG(base)          ((base) + 0x40)
> +
> +#define LDO_STEPPER_CTL_REG(base)      ((base) + 0x3b)
> +#define DEFAULT_VOLTAGE_STEPPER_RATE   38400
> +#define STEP_RATE_MASK                 GENMASK(1, 0)
> +
> +#define PM8008_NUM_LDOS                        7
> +
> +struct regulator_data {
> +       const char                      *name;
> +       const char                      *supply_name;
> +       u16                             base;
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
> +static const struct regulator_data reg_data[] = {
> +       /* name  parent       base   min_uv  max_uv  headroom_uv voltage_range */
> +       { "LDO1", "vdd_l1_l2", 0x4000,  528000, 1504000, 225000, nldo_ranges, },
> +       { "LDO2", "vdd_l1_l2", 0x4100,  528000, 1504000, 225000, nldo_ranges, },
> +       { "LDO3", "vdd_l3_l4", 0x4200, 1504000, 3400000, 300000, pldo_ranges, },
> +       { "LDO4", "vdd_l3_l4", 0x4300, 1504000, 3400000, 300000, pldo_ranges, },
> +       { "LDO5", "vdd_l5",    0x4400, 1504000, 3400000, 200000, pldo_ranges, },
> +       { "LDO6", "vdd_l6",    0x4500, 1504000, 3400000, 200000, pldo_ranges, },
> +       { "LDO7", "vdd_l7",    0x4600, 1504000, 3400000, 200000, pldo_ranges, },
> +};
> +
> +static int pm8008_regulator_get_voltage(struct regulator_dev *rdev)
> +{
> +       struct pm8008_regulator *pm8008_reg = rdev_get_drvdata(rdev);
> +       __le16 mV;
> +       int rc;
> +
> +       rc = regmap_bulk_read(pm8008_reg->regmap,
> +                       LDO_VSET_LB_REG(pm8008_reg->base), (void *)&mV, 2);
> +       if (rc < 0) {
> +               dev_err(&rdev->dev, "failed to read regulator voltage rc=%d\n", rc);
> +               return rc;
> +       }
> +
> +       return le16_to_cpu(mV) * 1000;
> +}
> +
> +static inline int pm8008_write_voltage(struct pm8008_regulator *pm8008_reg,
> +                                                       int mV)
> +{
> +       int rc;
> +       u16 vset_raw;
> +
> +       vset_raw = cpu_to_le16(mV);

sparse should complain here that an le16 is degrading to a u16. Please
make vset_raw an __le16 as well.

> +
> +       rc = regmap_bulk_write(pm8008_reg->regmap,
> +                       LDO_VSET_LB_REG(pm8008_reg->base),
> +                       (const void *)&vset_raw, sizeof(vset_raw));
> +       if (rc < 0) {
> +               dev_err(pm8008_reg->dev, "failed to write voltage rc=%d\n", rc);

Do we really need this? It could spam the logs in theory. We have
tracepoints on regmap that could be used to figure out that some
read/write failed. I'd like to see a plain

	return regmap_bulk_write(...)

> +               return rc;
> +       }
> +
> +       return 0;
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
> +                                               1000);

Aren't there linear range APIs that can avoid any div roundups here?

> +       if (mV < 0)
> +               return mV;
> +
> +       rc = pm8008_write_voltage(pm8008_reg, mV);
> +       if (rc < 0)
> +               return rc;
> +
> +       dev_dbg(&rdev->dev, "voltage set to %d\n", mV * 1000);
> +       return 0;
> +}
> +
> +static const struct regulator_ops pm8008_regulator_ops = {
> +       .enable                 = regulator_enable_regmap,
> +       .disable                = regulator_disable_regmap,
> +       .is_enabled             = regulator_is_enabled_regmap,
> +       .set_voltage_sel        = pm8008_regulator_set_voltage,
> +       .get_voltage            = pm8008_regulator_get_voltage,
> +       .list_voltage           = regulator_list_voltage_linear,
> +       .set_voltage_time       = pm8008_regulator_set_voltage_time,
> +};
> +
> +static int pm8008_regulator_of_parse(struct device_node *node,
> +                       const struct regulator_desc *desc,
> +                       struct regulator_config *config)
> +{
> +       struct pm8008_regulator *pm8008_reg = config->driver_data;
> +       int rc;
> +       unsigned int reg;
> +
> +       /* get slew rate */
> +       rc = regmap_bulk_read(pm8008_reg->regmap,
> +                       LDO_STEPPER_CTL_REG(pm8008_reg->base), &reg, 1);
> +       if (rc < 0) {
> +               dev_err(pm8008_reg->dev,
> +                       "%s: failed to read step rate configuration rc=%d\n",
> +                       pm8008_reg->rdesc.name, rc);
> +               return rc;
> +       }
> +       reg &= STEP_RATE_MASK;
> +       pm8008_reg->step_rate = DEFAULT_VOLTAGE_STEPPER_RATE >> reg;
> +
> +       return 0;
> +}
> +
> +static int pm8008_regulator_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       int id = pdev->id % PM8008_NUM_LDOS;
> +       struct regulator_dev    *rdev;
> +       struct pm8008_regulator *pm8008_reg;
> +       struct regmap *regmap;
> +       struct regulator_config reg_config = {};
> +       int rc;
> +
> +       dev_dbg(dev, "DEBUG: Probing LDO%d\n", id + 1);

Why can't we probe one regulators (plural) platform device instead of 8
regulator platform devices? A 'struct device' isn't exactly small and
it would be simpler to probe all the regulators in a single loop.

> +
> +       regmap = dev_get_regmap(dev->parent, NULL);
> +       if (!regmap) {
> +               dev_err(dev, "parent regmap is missing\n");
