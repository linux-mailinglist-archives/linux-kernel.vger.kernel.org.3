Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F02254EBAF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 22:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378755AbiFPU5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 16:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiFPU5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:57:48 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BF018394
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:57:47 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id a17so235592pls.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uN2MkJ4nUIty1Sor4XqPwun1hGLUtXm8GHd5WHbkewo=;
        b=zmokaMcV6kyTpb28Gi8AD+sXGgk4clAe1LHnxikamybHWfRzKloNw5d4MWaKqb4XbY
         jlGKGQGnK1+nTTbvlabT9aHoYZuc505lAG259+1EmeINJXzmI4JBxUAmP44mQN90TIq4
         gizXW/SlGVlxdozS8yAGTFUxL1LuxTds/q4S45sRsTv0u5XF8po7XTE4AmauyBnlJhi+
         SJRPwyFqQ1fXzVhySp7YU3Ga7bWRWiFHzr8g5ViteJbC1zKTEvDx0i61atSLq1PcAj05
         K1r6xkTydF05AiQ0iOCv0Wtb7L2iTl6KkXKH9k7vNro8CApVaLUZq0UFouNGx5ght+p5
         oJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uN2MkJ4nUIty1Sor4XqPwun1hGLUtXm8GHd5WHbkewo=;
        b=qufE6hnsGfYJqqhnC2LVgIeXMzo9YcepSUyz2sPMu/5EdK0sxgAlpSWhhF2qRDt3wD
         qVSKOnhdTL8nUVhjMXDJpeEHmn/C60oc9AH92LPc/96JRsWLkrVovsDPiRt1MTtNGL4F
         PamhANiGqBC9iApTiI/H4FUIioGSNnW096B6WKr/vy70OPzaaE0gyE44QaRliIw9LDXy
         g+8ENXz7llt6Dgqh6TKP4KdFMrf5mhA8ja/zYBJrazyD2/3n4GSnohaZcgyLUoq+n8qu
         IphYPmPUwfQ2EBYfWaIJ7+G8sNFQq1Syq3ffmBaO4qyEGsBt8HA1vZU31n2VEY+LtCmt
         Ji5A==
X-Gm-Message-State: AJIora95hrmh4pKPyVGGa8EvSFEYzOMgJQzfTsIlg8iBuA5Zqdq4pXR1
        AkWNpbWAlCLwLviMsD+KKQ8Snw==
X-Google-Smtp-Source: AGRyM1szMaJdSd7SItitiXJ+irqerxl/VV72VGGcecE6fpqRMun7pj6i2ii9M2C6slr8LD0+Sn2s0Q==
X-Received: by 2002:a17:90a:aa96:b0:1ea:3780:c3dc with SMTP id l22-20020a17090aaa9600b001ea3780c3dcmr17901042pjq.241.1655413066683;
        Thu, 16 Jun 2022 13:57:46 -0700 (PDT)
Received: from google.com ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902f7ca00b001621ce92196sm2046829plw.86.2022.06.16.13.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 13:57:45 -0700 (PDT)
Date:   Thu, 16 Jun 2022 21:57:41 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com
Subject: Re: [PATCH V15 6/9] mfd: pm8008: Use i2c_new_dummy_device() API
Message-ID: <YquZRcuRCrdF+Q1z@google.com>
References: <1655200111-18357-1-git-send-email-quic_c_skakit@quicinc.com>
 <1655200111-18357-7-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1655200111-18357-7-git-send-email-quic_c_skakit@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jun 2022, Satya Priya wrote:

> Use i2c_new_dummy_device() to register pm8008-regulator
> client present at a different address space, instead of
> defining a separate DT node. This avoids calling the probe
> twice for the same chip, once for each client pm8008-infra
> and pm8008-regulator.
> 
> As a part of this define pm8008_regmap_init() to do regmap
> init for both the clients and define pm8008_get_regmap() to
> pass the regmap to the regulator driver.
> 
> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
> Changes in V15:
>  - None.
> 
> Changes in V14:
>  - None.
> 
> Changes in V13:
>  - None.
> 
>  drivers/mfd/qcom-pm8008.c       | 34 ++++++++++++++++++++++++++++++++--
>  include/linux/mfd/qcom_pm8008.h |  9 +++++++++
>  2 files changed, 41 insertions(+), 2 deletions(-)
>  create mode 100644 include/linux/mfd/qcom_pm8008.h
> 
> diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
> index 569ffd50..55e2a8e 100644
> --- a/drivers/mfd/qcom-pm8008.c
> +++ b/drivers/mfd/qcom-pm8008.c
> @@ -9,6 +9,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/irqdomain.h>
> +#include <linux/mfd/qcom_pm8008.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/of_platform.h>
> @@ -57,6 +58,7 @@ enum {
>  
>  struct pm8008_data {
>  	struct device *dev;
> +	struct regmap *regulators_regmap;
>  	int irq;
>  	struct regmap_irq_chip_data *irq_data;
>  };
> @@ -150,6 +152,12 @@ static struct regmap_config qcom_mfd_regmap_cfg = {
>  	.max_register	= 0xFFFF,
>  };
>  
> +struct regmap *pm8008_get_regmap(const struct pm8008_data *chip)
> +{
> +	return chip->regulators_regmap;
> +}
> +EXPORT_SYMBOL_GPL(pm8008_get_regmap);

Seems like abstraction for the sake of abstraction.

Why not do the dereference inside the regulator driver?

>  static int pm8008_init(struct regmap *regmap)
>  {
>  	int rc;
> @@ -217,11 +225,25 @@ static int pm8008_probe_irq_peripherals(struct pm8008_data *chip,
>  	return 0;
>  }
>  
> +static struct regmap *pm8008_regmap_init(struct i2c_client *client,
> +							struct pm8008_data *chip)
> +{
> +	struct regmap *regmap;
> +
> +	regmap = devm_regmap_init_i2c(client, &qcom_mfd_regmap_cfg);
> +	if (!regmap)
> +		return NULL;
> +
> +	i2c_set_clientdata(client, chip);
> +	return regmap;
> +}

This function seems superfluous.

It's only called once and it contains a single call.

Just pop the call directly into probe.

>  static int pm8008_probe(struct i2c_client *client)
>  {
>  	int rc;
>  	struct pm8008_data *chip;
>  	struct gpio_desc *reset_gpio;
> +	struct i2c_client *regulators_client;
>  	struct regmap *regmap;
>  
>  	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
> @@ -229,11 +251,19 @@ static int pm8008_probe(struct i2c_client *client)
>  		return -ENOMEM;
>  
>  	chip->dev = &client->dev;
> -	regmap = devm_regmap_init_i2c(client, &qcom_mfd_regmap_cfg);
> +	regmap = pm8008_regmap_init(client, chip);
>  	if (!regmap)
>  		return -ENODEV;
>  
> -	i2c_set_clientdata(client, chip);
> +	regulators_client = i2c_new_dummy_device(client->adapter, client->addr + 1);
> +	if (IS_ERR(regulators_client)) {
> +		dev_err(&client->dev, "can't attach client\n");
> +		return PTR_ERR(regulators_client);
> +	}
> +
> +	chip->regulators_regmap = pm8008_regmap_init(regulators_client, chip);
> +	if (!chip->regulators_regmap)
> +		return -ENODEV;
>  
>  	reset_gpio = devm_gpiod_get(chip->dev, "reset", GPIOD_OUT_LOW);
>  	if (IS_ERR(reset_gpio))
> diff --git a/include/linux/mfd/qcom_pm8008.h b/include/linux/mfd/qcom_pm8008.h
> new file mode 100644
> index 0000000..3814bff
> --- /dev/null
> +++ b/include/linux/mfd/qcom_pm8008.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +// Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> +#ifndef __QCOM_PM8008_H__
> +#define __QCOM_PM8008_H__
> +
> +struct pm8008_data;
> +struct regmap *pm8008_get_regmap(const struct pm8008_data *chip);
> +
> +#endif

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
