Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BDF50D8F2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 07:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbiDYFxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 01:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiDYFxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 01:53:19 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E3E22530;
        Sun, 24 Apr 2022 22:50:16 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d15so24604037pll.10;
        Sun, 24 Apr 2022 22:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QtDanb++15hBXNtBohBibz08hgDs29LL2PnLGIAiZD8=;
        b=ky0IXZBBsPIDqP7EVAQluRnJOVYLTSPPI4fvbyU4LCSr5qMPTKPvpGtijHGkr3ex7M
         o7jr/Gm2KwS2UqeZmgoz/1fErqEGvfp8u8K2a0hLxzr/uqqcpJS3Ee6kLcLOUhvFrtIa
         E1XfoHdm4auPynYE3pM1bsTVSbQj6fBXWQ3bylXzdCIxeVo8Igz3ZIJzqKykggs7AP9+
         8yA6BKOEE40a37fLEt0OU+bBK7oBkiczHDGo/bAHbu8HHOQzZ7dwMFLu26acZ3YC+51D
         Xxa3IT02NkKZa9b5jy1+zO4Urpco+PMJrK/3rUpFbSdNv4l0oSIriH1lI1+TC0VmnTMd
         NJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QtDanb++15hBXNtBohBibz08hgDs29LL2PnLGIAiZD8=;
        b=IlpdQWcc7/vsCOlC1nojfZOai/HNq5P6Ol9UjR0PZ3DFXSSf/J8Ge3vW65d/S7db8F
         ZJHfr94Il+LE02I0f4sCtzcyM4P3FVG4+BgoAolFWNkSPEFqSmkg5t0s2JbW1Kag66Ku
         qz8LypeE84YdhXM2Z9WQz3dK2yRN/PG9wzqrhihoXENW76vZBCO2R3r2kI3S0xe1PoWg
         B0uFQPp6RBlNrU+PJ+kzxFbH5k86DhLZn5PBKlI5MlwV40/GX5gYofADEz3BWu6ldZ9K
         ETAnlVzXtro7iuLqJ+Tn1XIKJ3tEVWBNvyry4/dTjL6BPX94FMstGLL4KO2WZ5lFHZTq
         c1ng==
X-Gm-Message-State: AOAM530slL1rj2rjLQNu2uamrEfKLjs6kHNmZZTASMUwdB13c+uuN1sb
        MtujyfV48rijsb2cAEsyq+F+kl8vheQ=
X-Google-Smtp-Source: ABdhPJzfsCJlnygDTA3grtoAOGlWYa2odyE4V9vfonHtKHDtQ9xY3Krf9kJeLnbaJfay6azSUfxHJg==
X-Received: by 2002:a17:902:a987:b0:158:b020:e5b8 with SMTP id bh7-20020a170902a98700b00158b020e5b8mr16375807plb.103.1650865815433;
        Sun, 24 Apr 2022 22:50:15 -0700 (PDT)
Received: from cyhuang-hp-elitebook-840-g3.rt ([2402:7500:46a:c2e1:d402:1333:c60b:f1a1])
        by smtp.gmail.com with ESMTPSA id k10-20020a056a00168a00b004f7e2a550ccsm10029597pfc.78.2022.04.24.22.50.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Apr 2022 22:50:10 -0700 (PDT)
Date:   Mon, 25 Apr 2022 13:49:53 +0800
From:   ChiYuan Huang <u0084500@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] regulator: richtek,rt4801: use existing ena_gpiod
 feature
Message-ID: <20220425054943.GA3993@cyhuang-hp-elitebook-840-g3.rt>
References: <20220423181419.19397-1-krzysztof.kozlowski@linaro.org>
 <20220423181419.19397-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220423181419.19397-3-krzysztof.kozlowski@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 08:14:19PM +0200, Krzysztof Kozlowski wrote:
> The driver duplicated regulator core feature of controlling
> regulators with GPIOs (of_parse_cb + ena_gpiod) and created its own
> enable-gpios property with multiple GPIOs.
> 
> The core already does it. Keep old method for backwards compatibility.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/regulator/rt4801-regulator.c | 68 ++++++++++++++++++++++++----
>  1 file changed, 58 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/regulator/rt4801-regulator.c b/drivers/regulator/rt4801-regulator.c
> index 7a87788d3f09..22efe44cd3a0 100644
> --- a/drivers/regulator/rt4801-regulator.c
> +++ b/drivers/regulator/rt4801-regulator.c
> @@ -29,17 +29,71 @@
>  
>  struct rt4801_priv {
>  	struct device *dev;
> +	/*
> +	 * Driver supports enable GPIOs in two ways:
> +	 * 1. Legacy enable-gpios property with multiple entries and enable
> +	 *    control handled by the driver.
> +	 * 2. Per-regulator enable-gpios property with enable control handled by
> +	 *    the regulator core.
> +	 *
> +	 * The enable_gpios and enable_flag properties are for the (1) case.
> +	 */
>  	struct gpio_descs *enable_gpios;
>  	unsigned int enable_flag;
>  	unsigned int volt_sel[DSV_OUT_MAX];
>  };
>  
> +static int rt4801_of_parse_cb(struct device_node *np,
> +			      const struct regulator_desc *desc,
> +			      struct regulator_config *config)
> +{
> +	struct rt4801_priv *priv = config->driver_data;
> +
> +	if (priv->enable_gpios) {
> +		dev_warn(priv->dev, "duplicated enable-gpios property\n");
> +		return 0;
> +	}
> +	config->ena_gpiod = fwnode_gpiod_get_index(of_fwnode_handle(np),
> +						   "enable-gpios",
'enable' only, gpiod API will automatically concat it to 'enable-gpios'.
> +						   0,
> +						   GPIOD_OUT_HIGH |
> +						   GPIOD_FLAGS_BIT_NONEXCLUSIVE,
> +						   "rt4801");
> +	if (IS_ERR(config->ena_gpiod))
> +		config->ena_gpiod = NULL;
> +
> +	return 0;
> +}
> +
> +/*
> + * regulator_ops->is_enabled() implementation
> + */
> +static int rt4801_is_enabled(struct regulator_dev *rdev)
> +{
> +	struct rt4801_priv *priv = rdev_get_drvdata(rdev);
> +	int id = rdev_get_id(rdev);
> +
> +	return !!(priv->enable_flag & BIT(id));
> +}
> +
> +/*
> + * Internally used only is_enabled() implementation using also ena_pin from
> + * regulator core.
> + */
> +static bool rt4801_is_enabled_ena_pin(struct regulator_dev *rdev)
> +{
> +	if (rdev->ena_pin)
> +		return rdev->ena_gpio_state;
> +
> +	return rt4801_is_enabled(rdev);
> +}
> +
>  static int rt4801_set_voltage_sel(struct regulator_dev *rdev, unsigned int selector)
>  {
>  	struct rt4801_priv *priv = rdev_get_drvdata(rdev);
>  	int id = rdev_get_id(rdev), ret;
>  
> -	if (priv->enable_flag & BIT(id)) {
> +	if (rt4801_is_enabled_ena_pin(rdev)) {
>  		ret = regulator_set_voltage_sel_regmap(rdev, selector);
>  		if (ret)
>  			return ret;
> @@ -54,7 +108,7 @@ static int rt4801_get_voltage_sel(struct regulator_dev *rdev)
>  	struct rt4801_priv *priv = rdev_get_drvdata(rdev);
>  	int id = rdev_get_id(rdev);
>  
> -	if (priv->enable_flag & BIT(id))
> +	if (rt4801_is_enabled_ena_pin(rdev))
>  		return regulator_get_voltage_sel_regmap(rdev);
>  
>  	return priv->volt_sel[id];
> @@ -100,14 +154,6 @@ static int rt4801_disable(struct regulator_dev *rdev)
>  	return 0;
>  }
>  
> -static int rt4801_is_enabled(struct regulator_dev *rdev)
> -{
> -	struct rt4801_priv *priv = rdev_get_drvdata(rdev);
> -	int id = rdev_get_id(rdev);
> -
> -	return !!(priv->enable_flag & BIT(id));
> -}
> -
>  static const struct regulator_ops rt4801_regulator_ops = {
>  	.list_voltage = regulator_list_voltage_linear,
>  	.set_voltage_sel = rt4801_set_voltage_sel,
> @@ -122,6 +168,7 @@ static const struct regulator_desc rt4801_regulator_descs[] = {
>  		.name = "DSVP",
>  		.ops = &rt4801_regulator_ops,
>  		.of_match = of_match_ptr("DSVP"),
> +		.of_parse_cb = rt4801_of_parse_cb,
>  		.type = REGULATOR_VOLTAGE,
>  		.id = DSV_OUT_POS,
>  		.min_uV = MIN_UV,
> @@ -135,6 +182,7 @@ static const struct regulator_desc rt4801_regulator_descs[] = {
>  		.name = "DSVN",
>  		.ops = &rt4801_regulator_ops,
>  		.of_match = of_match_ptr("DSVN"),
> +		.of_parse_cb = rt4801_of_parse_cb,
>  		.type = REGULATOR_VOLTAGE,
>  		.id = DSV_OUT_NEG,
>  		.min_uV = MIN_UV,

There's one problem.
If 'ena_gpiod' is specified, it cannot be conexisted with ops
'enable/disable/is_enabled' by regulator framework.
It will cause no one to recover the voltage back.
You can check the original 'enable' ops.

How about to only parse gpio in 'of_parse_cb' and put it all into the
driver data, not to use regulator framework 'ena_gpiod'?

Best regards,
ChiYuan Huang.
> -- 
> 2.32.0
> 
