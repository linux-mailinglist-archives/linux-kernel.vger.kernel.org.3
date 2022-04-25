Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FA850DAC2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbiDYIBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241470AbiDYIBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:01:32 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56172A707;
        Mon, 25 Apr 2022 00:58:25 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id u7so9865765plg.13;
        Mon, 25 Apr 2022 00:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KDTbKI3K5FVIfCwkeglepXBfFcpQvboH+kkSLBKfWI8=;
        b=JauSAsMc3TC5iDNvqXSoUs/bnDjLrOIXsjWZI39ZbcbZxKx2HoOXVtPizCAHsAfkTl
         iNqwD3U1gk8iwWOyMzVcSUjp6pXlnQf95ahPsOX/wy5AOryKGgChcDWxX7AKNobQ/YU5
         96CHwqSArkELk7JGm31XDXCuNTW9bg/l9GStxCiwhQ6AspNsOpzKSpySx/JnVjor79zS
         vhrdlgYKY09HdnQUyacl/xDr8YFQhix40iEzwcpOgsSXREK7nyuq7kYreqYHIq1kc02e
         SzmZgkY8rbk+0+TFwKHKsYFPBtLlHV2U0ZMoHfqYnLKx8BW9JL3fENAMxjuzy2GoTGK6
         vulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KDTbKI3K5FVIfCwkeglepXBfFcpQvboH+kkSLBKfWI8=;
        b=UH/NRJTR82mGMkVhGY3+1G/7CMaLqaTE3AfBxkV/sruBB85C0MfYygogni1z96PHCQ
         14DDekORdzlqOOPg3yjGVXdoWj/VbChXGMibCSdj183G9okmaAEZa1qBB7m0hddSeNjg
         acRwFVl2RQg5XnyF2o85iz4QJTnbvJFamvIRjTV8OQ5PfYD0Rdac7lrK6QHnOoJq69bx
         1gJSPaaPvR0BkSnYrbOAv1aM/qd9elHu9wNdyLwB67aLK5iUnFSbNCBj0kDSOc4s8E80
         LQnEFKYYY2Bq2R5G+2W1KOA+TgaI1waQDRtrLn+Q3x8N1eW34QKm9oUJEnLkMEvIEIOX
         /0GA==
X-Gm-Message-State: AOAM532hEaElzed6gCk4IrI6xPBohQ9JiKhUq1qzwcSl3xqcwO6m0b32
        R0q1rbpU0Fzl+jnboZlrjyUxpwPmz3c=
X-Google-Smtp-Source: ABdhPJxQ6KTtMD8bj1IzxhJdoprHUsHnmaJsSnQFOT2UtgRmSXYSNyHcrEeDAVgoVnmR/nqrt0K3Mg==
X-Received: by 2002:a17:90b:4d11:b0:1d2:a600:3014 with SMTP id mw17-20020a17090b4d1100b001d2a6003014mr30889198pjb.108.1650873504824;
        Mon, 25 Apr 2022 00:58:24 -0700 (PDT)
Received: from cyhuang-hp-elitebook-840-g3.rt ([2402:7500:56b:75be:d402:1333:c60b:f1a1])
        by smtp.gmail.com with ESMTPSA id cm11-20020a17090afa0b00b001d9738fdf2asm2861903pjb.37.2022.04.25.00.58.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Apr 2022 00:58:24 -0700 (PDT)
Date:   Mon, 25 Apr 2022 15:58:17 +0800
From:   ChiYuan Huang <u0084500@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] regulator: richtek,rt4801: parse GPIOs per
 regulator
Message-ID: <20220425075812.GA29439@cyhuang-hp-elitebook-840-g3.rt>
References: <20220425072455.27356-1-krzysztof.kozlowski@linaro.org>
 <20220425072455.27356-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425072455.27356-3-krzysztof.kozlowski@linaro.org>
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

On Mon, Apr 25, 2022 at 09:24:55AM +0200, Krzysztof Kozlowski wrote:
> Having one enable-gpios property for all regulators is discouraged and
> instead, similarly to regulator core ena_gpiod feature, each GPIO should
> be present in each regulator node.  Add support for parsing such GPIOs,
> keeping backwards compatibility.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/regulator/rt4801-regulator.c | 49 +++++++++++++++++++++-------
>  1 file changed, 38 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/regulator/rt4801-regulator.c b/drivers/regulator/rt4801-regulator.c
> index 7a87788d3f09..563d79196fdd 100644
> --- a/drivers/regulator/rt4801-regulator.c
> +++ b/drivers/regulator/rt4801-regulator.c
> @@ -29,11 +29,33 @@
>  
>  struct rt4801_priv {
>  	struct device *dev;
> -	struct gpio_descs *enable_gpios;
> +	struct gpio_desc *enable_gpios[DSV_OUT_MAX];
>  	unsigned int enable_flag;
>  	unsigned int volt_sel[DSV_OUT_MAX];
>  };
>  
> +static int rt4801_of_parse_cb(struct device_node *np,
> +			      const struct regulator_desc *desc,
> +			      struct regulator_config *config)
> +{
> +	struct rt4801_priv *priv = config->driver_data;
> +	int id = desc->id;
> +
> +	if (priv->enable_gpios[id]) {
> +		dev_warn(priv->dev, "duplicated enable-gpios property\n");
> +		return 0;
> +	}
> +	priv->enable_gpios[id] = devm_fwnode_gpiod_get_index(priv->dev,
> +							     of_fwnode_handle(np),
> +							     "enable", 0,
> +							     GPIOD_OUT_HIGH,
> +							     "rt4801");
> +	if (IS_ERR(priv->enable_gpios[id]))
> +		priv->enable_gpios[id] = NULL;
> +
> +	return 0;
> +}
> +
>  static int rt4801_set_voltage_sel(struct regulator_dev *rdev, unsigned int selector)
>  {
>  	struct rt4801_priv *priv = rdev_get_drvdata(rdev);
> @@ -63,15 +85,14 @@ static int rt4801_get_voltage_sel(struct regulator_dev *rdev)
>  static int rt4801_enable(struct regulator_dev *rdev)
>  {
>  	struct rt4801_priv *priv = rdev_get_drvdata(rdev);
> -	struct gpio_descs *gpios = priv->enable_gpios;
>  	int id = rdev_get_id(rdev), ret;
>  
> -	if (!gpios || gpios->ndescs <= id) {
> +	if (!priv->enable_gpios[id]) {
>  		dev_warn(&rdev->dev, "no dedicated gpio can control\n");
>  		goto bypass_gpio;
>  	}
>  
> -	gpiod_set_value(gpios->desc[id], 1);
> +	gpiod_set_value(priv->enable_gpios[id], 1);
>  
>  bypass_gpio:
>  	ret = regmap_write(rdev->regmap, rdev->desc->vsel_reg, priv->volt_sel[id]);
> @@ -85,15 +106,14 @@ static int rt4801_enable(struct regulator_dev *rdev)
>  static int rt4801_disable(struct regulator_dev *rdev)
>  {
>  	struct rt4801_priv *priv = rdev_get_drvdata(rdev);
> -	struct gpio_descs *gpios = priv->enable_gpios;
>  	int id = rdev_get_id(rdev);
>  
> -	if (!gpios || gpios->ndescs <= id) {
> +	if (!priv->enable_gpios[id]) {
>  		dev_warn(&rdev->dev, "no dedicated gpio can control\n");
>  		goto bypass_gpio;
>  	}
>  
> -	gpiod_set_value(gpios->desc[id], 0);
> +	gpiod_set_value(priv->enable_gpios[id], 0);
>  
>  bypass_gpio:
>  	priv->enable_flag &= ~BIT(id);
> @@ -122,6 +142,7 @@ static const struct regulator_desc rt4801_regulator_descs[] = {
>  		.name = "DSVP",
>  		.ops = &rt4801_regulator_ops,
>  		.of_match = of_match_ptr("DSVP"),
> +		.of_parse_cb = rt4801_of_parse_cb,
>  		.type = REGULATOR_VOLTAGE,
>  		.id = DSV_OUT_POS,
>  		.min_uV = MIN_UV,
> @@ -135,6 +156,7 @@ static const struct regulator_desc rt4801_regulator_descs[] = {
>  		.name = "DSVN",
>  		.ops = &rt4801_regulator_ops,
>  		.of_match = of_match_ptr("DSVN"),
> +		.of_parse_cb = rt4801_of_parse_cb,
>  		.type = REGULATOR_VOLTAGE,
>  		.id = DSV_OUT_NEG,
>  		.min_uV = MIN_UV,
> @@ -172,10 +194,15 @@ static int rt4801_probe(struct i2c_client *i2c)
>  		return PTR_ERR(regmap);
>  	}
>  
> -	priv->enable_gpios = devm_gpiod_get_array_optional(&i2c->dev, "enable", GPIOD_OUT_HIGH);
> -	if (IS_ERR(priv->enable_gpios)) {
> -		dev_err(&i2c->dev, "Failed to get gpios\n");
> -		return PTR_ERR(priv->enable_gpios);
> +	for (i = 0; i < DSV_OUT_MAX; i++) {
> +		priv->enable_gpios[i] = devm_gpiod_get_index_optional(&i2c->dev,
> +								      "enable",
> +								      i,
> +								      GPIOD_OUT_HIGH);
> +		if (IS_ERR(priv->enable_gpios[i])) {
> +			dev_err(&i2c->dev, "Failed to get gpios\n");
> +			return PTR_ERR(priv->enable_gpios[i]);
> +		}
>  	}
You can directly removed all about 'enable-gpios' in probe phase.
Just keep of_parse_cb to get per regulator 'enable' gpio. 

The others looks fine.

Best regards,
ChiYuan Huang.
>  
>  	for (i = 0; i < DSV_OUT_MAX; i++) {
> -- 
> 2.32.0
> 
