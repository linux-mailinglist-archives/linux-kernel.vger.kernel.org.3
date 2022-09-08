Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA82A5B176F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiIHIpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiIHIpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:45:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B18CA77576;
        Thu,  8 Sep 2022 01:45:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64A1914BF;
        Thu,  8 Sep 2022 01:45:21 -0700 (PDT)
Received: from [10.57.15.197] (unknown [10.57.15.197])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47F3F3F73D;
        Thu,  8 Sep 2022 01:45:06 -0700 (PDT)
Message-ID: <818a7891-b5c8-beb6-5ccd-e1c0d1c22a23@arm.com>
Date:   Thu, 8 Sep 2022 09:45:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCHv2 02/13] mfd: rk808: use dev_err_probe
Content-Language: en-GB
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20220908003107.220143-1-sebastian.reichel@collabora.com>
 <20220908003107.220143-3-sebastian.reichel@collabora.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220908003107.220143-3-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-08 01:30, Sebastian Reichel wrote:
> Use dev_err_probe instead of dev_err in probe function,
> which simplifies code a little bit and prints the error
> code.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>   drivers/mfd/rk808.c | 50 ++++++++++++++++-----------------------------
>   1 file changed, 18 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
> index c17fea1d48ca..e793de9146f7 100644
> --- a/drivers/mfd/rk808.c
> +++ b/drivers/mfd/rk808.c
> @@ -650,18 +650,14 @@ static int rk808_probe(struct i2c_client *client,
>   
>   	/* Read chip variant */
>   	msb = i2c_smbus_read_byte_data(client, pmic_id_msb);
> -	if (msb < 0) {
> -		dev_err(&client->dev, "failed to read the chip id at 0x%x\n",
> -			RK808_ID_MSB);
> -		return msb;
> -	}
> +	if (msb < 0)
> +		return dev_err_probe(&client->dev, msb, "failed to read the chip id at 0x%x\n",
> +				     RK808_ID_MSB);
>   
>   	lsb = i2c_smbus_read_byte_data(client, pmic_id_lsb);
> -	if (lsb < 0) {
> -		dev_err(&client->dev, "failed to read the chip id at 0x%x\n",
> -			RK808_ID_LSB);
> -		return lsb;
> -	}
> +	if (lsb < 0)
> +		return dev_err_probe(&client->dev, lsb, "failed to read the chip id at 0x%x\n",
> +				     RK808_ID_LSB);

Hmm, refactoring these is probably a good opportunity to fix them as 
well - I'm not sure printing the register offset is really all that 
useful, but particularly not when it's hard-coded and may not correspond 
to the actual access that failed.

Robin.

>   
>   	rk808->variant = ((msb << 8) | lsb) & RK8XX_ID_MSK;
>   	dev_info(&client->dev, "chip id: 0x%x\n", (unsigned int)rk808->variant);
> @@ -710,44 +706,34 @@ static int rk808_probe(struct i2c_client *client,
>   	i2c_set_clientdata(client, rk808);
>   
>   	rk808->regmap = devm_regmap_init_i2c(client, rk808->regmap_cfg);
> -	if (IS_ERR(rk808->regmap)) {
> -		dev_err(&client->dev, "regmap initialization failed\n");
> -		return PTR_ERR(rk808->regmap);
> -	}
> +	if (IS_ERR(rk808->regmap))
> +		return dev_err_probe(&client->dev, PTR_ERR(rk808->regmap),
> +				     "regmap initialization failed\n");
>   
> -	if (!client->irq) {
> -		dev_err(&client->dev, "No interrupt support, no core IRQ\n");
> -		return -EINVAL;
> -	}
> +	if (!client->irq)
> +		return dev_err_probe(&client->dev, -EINVAL, "No interrupt support, no core IRQ\n");
>   
>   	ret = devm_regmap_add_irq_chip(&client->dev, rk808->regmap, client->irq,
>   				       IRQF_ONESHOT, -1,
>   				       rk808->regmap_irq_chip, &rk808->irq_data);
> -	if (ret) {
> -		dev_err(&client->dev, "Failed to add irq_chip %d\n", ret);
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret, "Failed to add irq_chip\n");
>   
>   	for (i = 0; i < nr_pre_init_regs; i++) {
>   		ret = regmap_update_bits(rk808->regmap,
>   					pre_init_reg[i].addr,
>   					pre_init_reg[i].mask,
>   					pre_init_reg[i].value);
> -		if (ret) {
> -			dev_err(&client->dev,
> -				"0x%x write err\n",
> -				pre_init_reg[i].addr);
> -			return ret;
> -		}
> +		if (ret)
> +			return dev_err_probe(&client->dev, ret, "0x%x write err\n",
> +					     pre_init_reg[i].addr);
>   	}
>   
>   	ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
>   			      cells, nr_cells, NULL, 0,
>   			      regmap_irq_get_domain(rk808->irq_data));
> -	if (ret) {
> -		dev_err(&client->dev, "failed to add MFD devices %d\n", ret);
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret, "failed to add MFD devices\n");
>   
>   	if (of_property_read_bool(np, "rockchip,system-power-controller")) {
>   		ret = devm_register_sys_off_handler(&client->dev,
