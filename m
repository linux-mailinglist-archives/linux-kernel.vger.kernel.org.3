Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23192528DA0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 21:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345251AbiEPTDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 15:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345238AbiEPTDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 15:03:11 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5452F3EB82
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 12:03:10 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id y20-20020a056830071400b00606a2ebd91bso10683736ots.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 12:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=V4GahDx2+UnkOWB2njUSr2HS/Dy+k/intVgLF5yRzLM=;
        b=QP66kbFap0dA2vLnSmHdxk2AoXOTdqe7hb6v4tnSQW8iqhqaz7qNKz9OLoio6gX7Cj
         BqXaUE6kVM+ivPQf2VZUtfYbN1PZrrSOWIiRlwwYRuSAXD8IQ3tIUVtR+4L/ETIV280S
         M94XYinqs+gK3IV95dVEbmtTOSLiN0/w2ovvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=V4GahDx2+UnkOWB2njUSr2HS/Dy+k/intVgLF5yRzLM=;
        b=y39n9/LdteQWFQwvL9I64BnTTr+8Ue/hwZuZc4FGgaPz9IqmiSnKx7TpsbSZ0Sk5wU
         2NmWbZXDHfDUq79ANgdXRTwjxh6dnyv/A9yfNOyP5SjwWI/itbwNMW7hOMtsf/MzjuiP
         9syqnfrIuKoI/TJvUecDSJ1GaC5ig7GEQW66Ljj0ZUxG/N8sOgT0Kj73qXU4U3F5VF5X
         7KKJvPTExJcdO+1b+Zj53tBPdjrAwMtsVf6mp6+LdX0urldwNKyhDEkko6wN2ZUdwjpL
         x6SLlal9T6+5ni3GU41PdBK0NsAt1RTboh6K7wbmOij1fqFF2KlOD5gqjxmjO2t1DrGy
         XHzA==
X-Gm-Message-State: AOAM5311KyemcLGWTYi3L5KKI3VYTFZ8Zsd3wN37/gSRZuonpGzCVpq/
        si1ft4J3/SUkoqmC+s87XzLLt7oKUZM+l3y8kl+Hpg==
X-Google-Smtp-Source: ABdhPJzIraMdyy+cf5N3cn2fEi0wvFOaIMKvaCnp5/je8pQqGNGQmIISz4raYx080wid7tlfrVJ4iY97vl4x2QO9CtI=
X-Received: by 2002:a05:6830:13ce:b0:606:702b:87f0 with SMTP id
 e14-20020a05683013ce00b00606702b87f0mr6480452otq.159.1652727789630; Mon, 16
 May 2022 12:03:09 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 May 2022 12:03:08 -0700
MIME-Version: 1.0
In-Reply-To: <1652275113-10277-8-git-send-email-quic_c_skakit@quicinc.com>
References: <1652275113-10277-1-git-send-email-quic_c_skakit@quicinc.com> <1652275113-10277-8-git-send-email-quic_c_skakit@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 16 May 2022 12:03:08 -0700
Message-ID: <CAE-0n51JeC7oobCYNCJ-rOi3n_FVPBjz7yFmtwKEDeqWcX0vFw@mail.gmail.com>
Subject: Re: [PATCH V12 7/9] regulator: Add a regulator driver for the PM8008 PMIC
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
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Satya Priya (2022-05-11 06:18:31)
> diff --git a/drivers/regulator/qcom-pm8008-regulator.c b/drivers/regulator/qcom-pm8008-regulator.c
> new file mode 100644
> index 0000000..0361f02
> --- /dev/null
> +++ b/drivers/regulator/qcom-pm8008-regulator.c
> @@ -0,0 +1,221 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2022, The Linux Foundation. All rights reserved. */
> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/qcom_pm8008.h>
> +#include <linux/module.h>
> +#include <linux/of.h>

Is this include used?

> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/of_regulator.h>

Is this include used?

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
> +};
> +
> +static int pm8008_regulator_get_voltage(struct regulator_dev *rdev)
> +{
> +       struct pm8008_regulator *pm8008_reg = rdev_get_drvdata(rdev);
> +
> +       return pm8008_reg->voltage_selector;
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

Does sparse complain about casting away __le16?

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
