Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7239C501D4F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 23:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346864AbiDNVV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 17:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345666AbiDNVVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 17:21:23 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AAFE6159
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:18:56 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id c15so7575134ljr.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ufxYIOwf0J693O+/j0nztdscn7O3zFr17OcsXCTFd2A=;
        b=Zk6oHfUomwUd26LNJQK4KaU2ifbDnt/zijM3TxgAahrDWK010devX3SknCi4s/XrEH
         oy4r8mL84+4zTzAU8VSaWWH5qeRz42KVA783zXnCpTQOlFiG7JkiWfboSGbgaD/PbFuZ
         Iqv2z1Fwk5hdYim/ya0Pv56zidniWDo88+0xuGJThORubgRolgqNlJtvZxGgYY1N/6wC
         OjV7LoJiYUq5ZlAOO2jgRUu26sEDg4IWZNskZkc/sUyWFx7N9SSMGLTkfX5ZuSd5Wool
         pMjJh3Ky2x1xckyyh/zLmbO7BajES4LvZxc5GNrGI2BeQJcRpCYLctVdR+BicaFjigOw
         u95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ufxYIOwf0J693O+/j0nztdscn7O3zFr17OcsXCTFd2A=;
        b=XjmpZPdO94tYxmMWnAaD+/UwMuKvSICmCdkbBky5+kzDqW/8MJ4PP2aSya9zKFVx1t
         DL3K3VhG4vB5viqHA7Za2+nPg2pH3lOxuw8trD/HUwaBNRIfHqNegzX5OMx9laW4AU4E
         +kZ02f2efoMy6huruznh6CQLGp6DKN23/rgX9uo1x9CHplJe57k1frqrgSWp6ohRi8Dp
         XLuOVNjBGxEr2FWICNVVyYoLoExf/c5EMT9Wez2ofbYQfqycGrBKBfswDGirW037zHnh
         WNWuI6k9jIPbUtBv041HKGuGW68dzYG6ka5TZkIhXdsmiRPdnwnCOJDAh7Gw5J+J+Jd6
         ovqQ==
X-Gm-Message-State: AOAM531eLRfOQqgMtwGInmvraAixO+R17EFRGvjcZ7E2jmwrQBq5BNYw
        N8yJdhw8jAYHyd4eZJrO/20I9A==
X-Google-Smtp-Source: ABdhPJyIPE/Lbzs1ZBnIcuuv9dXN0SCDY55qJ+MFI/XPq9gB4WFlhElfu5uB1F9JSt//Cy5lkYATKw==
X-Received: by 2002:a05:651c:893:b0:249:4023:3818 with SMTP id d19-20020a05651c089300b0024940233818mr2748589ljq.44.1649971134550;
        Thu, 14 Apr 2022 14:18:54 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id s6-20020ac25fa6000000b0044313e88020sm111871lfe.202.2022.04.14.14.18.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 14:18:54 -0700 (PDT)
Message-ID: <d9afa206-7f57-81bb-8c69-5928dccd41b5@linaro.org>
Date:   Fri, 15 Apr 2022 00:18:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v5 3/5] input: misc: pm8941-pwrkey: add support for PON
 GEN3 base addresses
Content-Language: en-GB
To:     Anjelique Melendez <quic_amelende@quicinc.com>,
        dmitry.torokhov@gmail.com, corbet@lwn.net, sre@kernel.org,
        robh+dt@kernel.org
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, collinsd@codeaurora.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org,
        skakit@codeaurora.org, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
References: <20220411200506.22891-1-quic_amelende@quicinc.com>
 <20220411200506.22891-4-quic_amelende@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220411200506.22891-4-quic_amelende@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2022 23:05, Anjelique Melendez wrote:
> Currently, PON address is read from the "reg" property. For PON GEN3,
> which starts with PMK8350, the "reg" property will have both the PON
> HLOS and PON PBS addesses defined. Add support so that all PON
> generations can be configured.
> 
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
>   drivers/input/misc/pm8941-pwrkey.c | 31 +++++++++++++++++++++++-------
>   1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
> index e0240db12d4f..43106e4cfd23 100644
> --- a/drivers/input/misc/pm8941-pwrkey.c
> +++ b/drivers/input/misc/pm8941-pwrkey.c
> @@ -12,6 +12,7 @@
>   #include <linux/log2.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
> +#include <linux/of_address.h>
>   #include <linux/of_device.h>
>   #include <linux/platform_device.h>
>   #include <linux/reboot.h>
> @@ -44,6 +45,7 @@ struct pm8941_data {
>   	unsigned int	status_bit;
>   	bool		supports_ps_hold_poff_config;
>   	bool		supports_debounce_config;
> +	bool		has_pon_pbs;
>   	const char	*name;
>   	const char	*phys;
>   };
> @@ -52,6 +54,7 @@ struct pm8941_pwrkey {
>   	struct device *dev;
>   	int irq;
>   	u32 baseaddr;
> +	u32 pon_pbs_baseaddr;
>   	struct regmap *regmap;
>   	struct input_dev *input;
>   
> @@ -167,6 +170,8 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
>   	struct pm8941_pwrkey *pwrkey;
>   	bool pull_up;
>   	struct device *parent;
> +	struct device_node *regmap_node;
> +	const __be32 *addr;
>   	u32 req_delay;
>   	int error;
>   
> @@ -188,8 +193,10 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
>   	pwrkey->data = of_device_get_match_data(&pdev->dev);
>   
>   	parent = pdev->dev.parent;
> +	regmap_node = pdev->dev.of_node;
>   	pwrkey->regmap = dev_get_regmap(parent, NULL);
>   	if (!pwrkey->regmap) {
> +		regmap_node = parent->of_node;
>   		/*
>   		 * We failed to get regmap for parent. Let's see if we are
>   		 * a child of pon node and read regmap and reg from its
> @@ -200,15 +207,21 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
>   			dev_err(&pdev->dev, "failed to locate regmap\n");
>   			return -ENODEV;
>   		}
> +	}
>   
> -		error = of_property_read_u32(parent->of_node,
> -					     "reg", &pwrkey->baseaddr);
> -	} else {
> -		error = of_property_read_u32(pdev->dev.of_node, "reg",
> -					     &pwrkey->baseaddr);
> +	addr = of_get_address(regmap_node, 0, NULL, NULL);
> +	if (!addr) {
> +		dev_err(&pdev->dev, "reg property missing\n");
> +		return -EINVAL;
> +	}
> +	pwrkey->baseaddr = be32_to_cpup(addr);
> +
> +	if (pwrkey->data->has_pon_pbs) {
> +		/* PON_PBS base address is optional */
> +		addr = of_get_address(regmap_node, 1, NULL, NULL);
> +		if (addr)
> +			pwrkey->pon_pbs_baseaddr = be32_to_cpup(addr);
>   	}
> -	if (error)
> -		return error;
>   
>   	pwrkey->irq = platform_get_irq(pdev, 0);
>   	if (pwrkey->irq < 0)
> @@ -316,6 +329,7 @@ static const struct pm8941_data pwrkey_data = {
>   	.phys = "pm8941_pwrkey/input0",
>   	.supports_ps_hold_poff_config = true,
>   	.supports_debounce_config = true,
> +	.has_pon_pbs = false,
>   };
>   
>   static const struct pm8941_data resin_data = {
> @@ -325,6 +339,7 @@ static const struct pm8941_data resin_data = {
>   	.phys = "pm8941_resin/input0",
>   	.supports_ps_hold_poff_config = true,
>   	.supports_debounce_config = true,
> +	.has_pon_pbs = false,

No need to declare that a field is false. Just skip this completely.

>   };
>   
>   static const struct pm8941_data pon_gen3_pwrkey_data = {
> @@ -333,6 +348,7 @@ static const struct pm8941_data pon_gen3_pwrkey_data = {
>   	.phys = "pmic_pwrkey/input0",
>   	.supports_ps_hold_poff_config = false,
>   	.supports_debounce_config = false,
> +	.has_pon_pbs = true,
>   };
>   
>   static const struct pm8941_data pon_gen3_resin_data = {
> @@ -341,6 +357,7 @@ static const struct pm8941_data pon_gen3_resin_data = {
>   	.phys = "pmic_resin/input0",
>   	.supports_ps_hold_poff_config = false,
>   	.supports_debounce_config = false,
> +	.has_pon_pbs = true,
>   };
>   
>   static const struct of_device_id pm8941_pwr_key_id_table[] = {


-- 
With best wishes
Dmitry
