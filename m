Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70294BC4A9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 02:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240921AbiBSBu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 20:50:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbiBSBu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 20:50:56 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABF625BD68
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 17:50:39 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id 13so4963583oiz.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 17:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=iQdqk3TnJErEbPNDiC4Mb5t6O95gNpK1dN2mo5Ib0wY=;
        b=WRYdTLyVGDcaLis/GHRSHAOoFFVnVeZi3whJAi6JIsiF9Ko/gL3HPr/3N5fKfwcFSk
         jmQGmDzHh7TilTCt6zObkTMDouUgSO6UM+9U7rZfhtaFXISd43V8VZK9+BB7iUBUDl7G
         Nvj/15HiMEY9jYoKp+0yF/A3yNJVVjGpusP6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=iQdqk3TnJErEbPNDiC4Mb5t6O95gNpK1dN2mo5Ib0wY=;
        b=I0+sQOXSsbhuys6+Tw36V3mT8x1nHWH7T8eKBbMwB4PfmZSaAgrNqcLd6dD+T6EtR0
         hkQbwd6Poi4jfcjdrbCKO5aEEPol2UlVSKMeUHq8ccW5Ro6nuRjTBkrsPxkaR+bVCTt7
         vAaiRscSOZLUK3a0QrNOS67ouAiuDw4yTAy6fqY06aCP9gDSVNBXF2FTXdUcwnOxKH8U
         fyTyaLUQ3Z25xqwkx3AwWRMbjYyjgzKRQJQMRUFHsakm4LuwdvpZbaUGv1wXjYqhmfou
         9A0fvUWW7umKrU6eIcP9efZMB3q7Ha3nNs/kwKDLU4lHbaFZr4mAG6c+7fbpWfeVJplt
         KE9w==
X-Gm-Message-State: AOAM530SCGOFBhFnAklhz1TETFO0ZpqBVPaTNM+Ohus5ZMojVbnXiJlN
        Qaq886YoVDJmI1wVKIlcgoTkXs7tE7D8up4wIjB/KQ==
X-Google-Smtp-Source: ABdhPJyBjVxmZ85zfetySH4t0ngAoSWvUFWgLABLiNdUWsdfWBzxvDturAoF83YxAK+5IcA1VhmUmMHth+830OCMGmY=
X-Received: by 2002:a05:6808:f88:b0:2d4:c8c2:b898 with SMTP id
 o8-20020a0568080f8800b002d4c8c2b898mr541902oiw.112.1645235438430; Fri, 18 Feb
 2022 17:50:38 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 18 Feb 2022 17:50:38 -0800
MIME-Version: 1.0
In-Reply-To: <1645182064-15843-4-git-send-email-quic_c_skakit@quicinc.com>
References: <1645182064-15843-1-git-send-email-quic_c_skakit@quicinc.com> <1645182064-15843-4-git-send-email-quic_c_skakit@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 18 Feb 2022 17:50:38 -0800
Message-ID: <CAE-0n50GRE1hUxpeLcv_jdNtxHuABMpGNJO5oMvMGimQHxAwHA@mail.gmail.com>
Subject: Re: [PATCH V7 3/5] regulator: Add a regulator driver for the PM8008 PMIC
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
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
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Satya Priya (2022-02-18 03:01:01)
> Qualcomm Technologies, Inc. PM8008 is an I2C controlled PMIC
> containing 7 LDO regulators.  Add a PM8008 regulator driver to
> support PMIC regulator management via the regulator framework.
>
> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>

> diff --git a/drivers/regulator/qcom-pm8008-regulator.c b/drivers/regulator/qcom-pm8008-regulator.c
> new file mode 100644
> index 0000000..1c52864
> --- /dev/null
> +++ b/drivers/regulator/qcom-pm8008-regulator.c
> @@ -0,0 +1,205 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2022, The Linux Foundation. All rights reserved. */
> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>
> +
> +#define VSET_STEP_MV                   8
> +#define VSET_STEP_UV                   (VSET_STEP_MV * 1000)
> +
> +#define LDO_ENABLE_REG(base)           ((base) + 0x46)
> +#define ENABLE_BIT                     BIT(7)

This is SPMI_COMMON_REG_ENABLE and SPMI_COMMON_ENABLE_MASK

> +
> +#define LDO_VSET_LB_REG(base)          ((base) + 0x40)
> +
> +#define LDO_STEPPER_CTL_REG(base)      ((base) + 0x3b)
> +#define DEFAULT_VOLTAGE_STEPPER_RATE   38400
> +#define STEP_RATE_MASK                 GENMASK(1, 0)
> +
> +struct regulator_data {

Please use a name like spmi_regulator_data :) Or pm8008_regulator_data?
Something that isn't so generic.

It seems similar to qcom_spmi-regulator.c so is there some reason we
can't shove this into there? Less code for things that aren't relevant I
guess?

> +       const char                      *name;
> +       const char                      *supply_name;
> +       u16                             base;
> +       int                             min_uv;
> +       int                             max_uv;
> +       int                             min_dropout_uv;
> +       const struct linear_range       *voltage_range;
