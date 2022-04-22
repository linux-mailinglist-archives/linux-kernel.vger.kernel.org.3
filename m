Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0553350C1DC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbiDVWG6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 22 Apr 2022 18:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiDVWGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:06:49 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457A1207141;
        Fri, 22 Apr 2022 13:51:04 -0700 (PDT)
Received: from [83.135.33.162] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1ni0Er-0006iV-Q4; Fri, 22 Apr 2022 22:50:49 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: Re: [PATCHv1 12/19] pinctrl/rockchip: add error handling for pull/drive register getters
Date:   Fri, 22 Apr 2022 22:50:47 +0200
Message-ID: <4833995.GXAFRqVoOG@phil>
In-Reply-To: <20220422170920.401914-13-sebastian.reichel@collabora.com>
References: <20220422170920.401914-1-sebastian.reichel@collabora.com> <20220422170920.401914-13-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 22. April 2022, 19:09:13 CEST schrieb Sebastian Reichel:
> Add error handling for the pull and driver register getters in preparation
> for RK3588 support.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Heiko Stübner <heiko@sntech.de>

> ---
>  drivers/pinctrl/pinctrl-rockchip.c | 168 ++++++++++++++++++-----------
>  drivers/pinctrl/pinctrl-rockchip.h |   4 +-
>  2 files changed, 109 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
> index a1b598b86aa9..012cd2f0d85b 100644
> --- a/drivers/pinctrl/pinctrl-rockchip.c
> +++ b/drivers/pinctrl/pinctrl-rockchip.c
> @@ -986,9 +986,9 @@ static int rockchip_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
>  #define PX30_PULL_PINS_PER_REG		8
>  #define PX30_PULL_BANK_STRIDE		16
>  
> -static void px30_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
> -				       int pin_num, struct regmap **regmap,
> -				       int *reg, u8 *bit)
> +static int px30_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
> +				      int pin_num, struct regmap **regmap,
> +				      int *reg, u8 *bit)
>  {
>  	struct rockchip_pinctrl *info = bank->drvdata;
>  
> @@ -1008,6 +1008,8 @@ static void px30_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
>  	*reg += ((pin_num / PX30_PULL_PINS_PER_REG) * 4);
>  	*bit = (pin_num % PX30_PULL_PINS_PER_REG);
>  	*bit *= PX30_PULL_BITS_PER_PIN;
> +
> +	return 0;
>  }
>  
>  #define PX30_DRV_PMU_OFFSET		0x20
> @@ -1016,9 +1018,9 @@ static void px30_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
>  #define PX30_DRV_PINS_PER_REG		8
>  #define PX30_DRV_BANK_STRIDE		16
>  
> -static void px30_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
> -				      int pin_num, struct regmap **regmap,
> -				      int *reg, u8 *bit)
> +static int px30_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
> +				     int pin_num, struct regmap **regmap,
> +				     int *reg, u8 *bit)
>  {
>  	struct rockchip_pinctrl *info = bank->drvdata;
>  
> @@ -1038,6 +1040,8 @@ static void px30_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
>  	*reg += ((pin_num / PX30_DRV_PINS_PER_REG) * 4);
>  	*bit = (pin_num % PX30_DRV_PINS_PER_REG);
>  	*bit *= PX30_DRV_BITS_PER_PIN;
> +
> +	return 0;
>  }
>  
>  #define PX30_SCHMITT_PMU_OFFSET			0x38
> @@ -1077,9 +1081,9 @@ static int px30_calc_schmitt_reg_and_bit(struct rockchip_pin_bank *bank,
>  #define RV1108_PULL_BITS_PER_PIN	2
>  #define RV1108_PULL_BANK_STRIDE		16
>  
> -static void rv1108_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
> -					 int pin_num, struct regmap **regmap,
> -					 int *reg, u8 *bit)
> +static int rv1108_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
> +					int pin_num, struct regmap **regmap,
> +					int *reg, u8 *bit)
>  {
>  	struct rockchip_pinctrl *info = bank->drvdata;
>  
> @@ -1098,6 +1102,8 @@ static void rv1108_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
>  	*reg += ((pin_num / RV1108_PULL_PINS_PER_REG) * 4);
>  	*bit = (pin_num % RV1108_PULL_PINS_PER_REG);
>  	*bit *= RV1108_PULL_BITS_PER_PIN;
> +
> +	return 0;
>  }
>  
>  #define RV1108_DRV_PMU_OFFSET		0x20
> @@ -1106,9 +1112,9 @@ static void rv1108_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
>  #define RV1108_DRV_PINS_PER_REG		8
>  #define RV1108_DRV_BANK_STRIDE		16
>  
> -static void rv1108_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
> -					int pin_num, struct regmap **regmap,
> -					int *reg, u8 *bit)
> +static int rv1108_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
> +				       int pin_num, struct regmap **regmap,
> +				       int *reg, u8 *bit)
>  {
>  	struct rockchip_pinctrl *info = bank->drvdata;
>  
> @@ -1128,6 +1134,8 @@ static void rv1108_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
>  	*reg += ((pin_num / RV1108_DRV_PINS_PER_REG) * 4);
>  	*bit = pin_num % RV1108_DRV_PINS_PER_REG;
>  	*bit *= RV1108_DRV_BITS_PER_PIN;
> +
> +	return 0;
>  }
>  
>  #define RV1108_SCHMITT_PMU_OFFSET		0x30
> @@ -1184,9 +1192,9 @@ static int rk3308_calc_schmitt_reg_and_bit(struct rockchip_pin_bank *bank,
>  #define RK2928_PULL_PINS_PER_REG	16
>  #define RK2928_PULL_BANK_STRIDE		8
>  
> -static void rk2928_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
> -				    int pin_num, struct regmap **regmap,
> -				    int *reg, u8 *bit)
> +static int rk2928_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
> +					int pin_num, struct regmap **regmap,
> +					int *reg, u8 *bit)
>  {
>  	struct rockchip_pinctrl *info = bank->drvdata;
>  
> @@ -1196,13 +1204,15 @@ static void rk2928_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
>  	*reg += (pin_num / RK2928_PULL_PINS_PER_REG) * 4;
>  
>  	*bit = pin_num % RK2928_PULL_PINS_PER_REG;
> +
> +	return 0;
>  };
>  
>  #define RK3128_PULL_OFFSET	0x118
>  
> -static void rk3128_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
> -					 int pin_num, struct regmap **regmap,
> -					 int *reg, u8 *bit)
> +static int rk3128_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
> +					int pin_num, struct regmap **regmap,
> +					int *reg, u8 *bit)
>  {
>  	struct rockchip_pinctrl *info = bank->drvdata;
>  
> @@ -1212,6 +1222,8 @@ static void rk3128_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
>  	*reg += ((pin_num / RK2928_PULL_PINS_PER_REG) * 4);
>  
>  	*bit = pin_num % RK2928_PULL_PINS_PER_REG;
> +
> +	return 0;
>  }
>  
>  #define RK3188_PULL_OFFSET		0x164
> @@ -1220,9 +1232,9 @@ static void rk3128_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
>  #define RK3188_PULL_BANK_STRIDE		16
>  #define RK3188_PULL_PMU_OFFSET		0x64
>  
> -static void rk3188_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
> -				    int pin_num, struct regmap **regmap,
> -				    int *reg, u8 *bit)
> +static int rk3188_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
> +					int pin_num, struct regmap **regmap,
> +					int *reg, u8 *bit)
>  {
>  	struct rockchip_pinctrl *info = bank->drvdata;
>  
> @@ -1252,12 +1264,14 @@ static void rk3188_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
>  		*bit = 7 - (pin_num % RK3188_PULL_PINS_PER_REG);
>  		*bit *= RK3188_PULL_BITS_PER_PIN;
>  	}
> +
> +	return 0;
>  }
>  
>  #define RK3288_PULL_OFFSET		0x140
> -static void rk3288_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
> -				    int pin_num, struct regmap **regmap,
> -				    int *reg, u8 *bit)
> +static int rk3288_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
> +					int pin_num, struct regmap **regmap,
> +					int *reg, u8 *bit)
>  {
>  	struct rockchip_pinctrl *info = bank->drvdata;
>  
> @@ -1281,6 +1295,8 @@ static void rk3288_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
>  		*bit = (pin_num % RK3188_PULL_PINS_PER_REG);
>  		*bit *= RK3188_PULL_BITS_PER_PIN;
>  	}
> +
> +	return 0;
>  }
>  
>  #define RK3288_DRV_PMU_OFFSET		0x70
> @@ -1289,9 +1305,9 @@ static void rk3288_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
>  #define RK3288_DRV_PINS_PER_REG		8
>  #define RK3288_DRV_BANK_STRIDE		16
>  
> -static void rk3288_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
> -				    int pin_num, struct regmap **regmap,
> -				    int *reg, u8 *bit)
> +static int rk3288_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
> +				       int pin_num, struct regmap **regmap,
> +				       int *reg, u8 *bit)
>  {
>  	struct rockchip_pinctrl *info = bank->drvdata;
>  
> @@ -1315,13 +1331,15 @@ static void rk3288_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
>  		*bit = (pin_num % RK3288_DRV_PINS_PER_REG);
>  		*bit *= RK3288_DRV_BITS_PER_PIN;
>  	}
> +
> +	return 0;
>  }
>  
>  #define RK3228_PULL_OFFSET		0x100
>  
> -static void rk3228_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
> -				    int pin_num, struct regmap **regmap,
> -				    int *reg, u8 *bit)
> +static int rk3228_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
> +					int pin_num, struct regmap **regmap,
> +					int *reg, u8 *bit)
>  {
>  	struct rockchip_pinctrl *info = bank->drvdata;
>  
> @@ -1332,13 +1350,15 @@ static void rk3228_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
>  
>  	*bit = (pin_num % RK3188_PULL_PINS_PER_REG);
>  	*bit *= RK3188_PULL_BITS_PER_PIN;
> +
> +	return 0;
>  }
>  
>  #define RK3228_DRV_GRF_OFFSET		0x200
>  
> -static void rk3228_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
> -				    int pin_num, struct regmap **regmap,
> -				    int *reg, u8 *bit)
> +static int rk3228_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
> +				       int pin_num, struct regmap **regmap,
> +				       int *reg, u8 *bit)
>  {
>  	struct rockchip_pinctrl *info = bank->drvdata;
>  
> @@ -1349,13 +1369,15 @@ static void rk3228_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
>  
>  	*bit = (pin_num % RK3288_DRV_PINS_PER_REG);
>  	*bit *= RK3288_DRV_BITS_PER_PIN;
> +
> +	return 0;
>  }
>  
>  #define RK3308_PULL_OFFSET		0xa0
>  
> -static void rk3308_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
> -				    int pin_num, struct regmap **regmap,
> -				    int *reg, u8 *bit)
> +static int rk3308_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
> +					int pin_num, struct regmap **regmap,
> +					int *reg, u8 *bit)
>  {
>  	struct rockchip_pinctrl *info = bank->drvdata;
>  
> @@ -1366,13 +1388,15 @@ static void rk3308_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
>  
>  	*bit = (pin_num % RK3188_PULL_PINS_PER_REG);
>  	*bit *= RK3188_PULL_BITS_PER_PIN;
> +
> +	return 0;
>  }
>  
>  #define RK3308_DRV_GRF_OFFSET		0x100
>  
> -static void rk3308_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
> -				    int pin_num, struct regmap **regmap,
> -				    int *reg, u8 *bit)
> +static int rk3308_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
> +				       int pin_num, struct regmap **regmap,
> +				       int *reg, u8 *bit)
>  {
>  	struct rockchip_pinctrl *info = bank->drvdata;
>  
> @@ -1383,14 +1407,16 @@ static void rk3308_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
>  
>  	*bit = (pin_num % RK3288_DRV_PINS_PER_REG);
>  	*bit *= RK3288_DRV_BITS_PER_PIN;
> +
> +	return 0;
>  }
>  
>  #define RK3368_PULL_GRF_OFFSET		0x100
>  #define RK3368_PULL_PMU_OFFSET		0x10
>  
> -static void rk3368_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
> -				    int pin_num, struct regmap **regmap,
> -				    int *reg, u8 *bit)
> +static int rk3368_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
> +					int pin_num, struct regmap **regmap,
> +					int *reg, u8 *bit)
>  {
>  	struct rockchip_pinctrl *info = bank->drvdata;
>  
> @@ -1414,14 +1440,16 @@ static void rk3368_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
>  		*bit = (pin_num % RK3188_PULL_PINS_PER_REG);
>  		*bit *= RK3188_PULL_BITS_PER_PIN;
>  	}
> +
> +	return 0;
>  }
>  
>  #define RK3368_DRV_PMU_OFFSET		0x20
>  #define RK3368_DRV_GRF_OFFSET		0x200
>  
> -static void rk3368_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
> -				    int pin_num, struct regmap **regmap,
> -				    int *reg, u8 *bit)
> +static int rk3368_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
> +				       int pin_num, struct regmap **regmap,
> +				       int *reg, u8 *bit)
>  {
>  	struct rockchip_pinctrl *info = bank->drvdata;
>  
> @@ -1445,15 +1473,17 @@ static void rk3368_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
>  		*bit = (pin_num % RK3288_DRV_PINS_PER_REG);
>  		*bit *= RK3288_DRV_BITS_PER_PIN;
>  	}
> +
> +	return 0;
>  }
>  
>  #define RK3399_PULL_GRF_OFFSET		0xe040
>  #define RK3399_PULL_PMU_OFFSET		0x40
>  #define RK3399_DRV_3BITS_PER_PIN	3
>  
> -static void rk3399_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
> -					 int pin_num, struct regmap **regmap,
> -					 int *reg, u8 *bit)
> +static int rk3399_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
> +					int pin_num, struct regmap **regmap,
> +					int *reg, u8 *bit)
>  {
>  	struct rockchip_pinctrl *info = bank->drvdata;
>  
> @@ -1479,11 +1509,13 @@ static void rk3399_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
>  		*bit = (pin_num % RK3188_PULL_PINS_PER_REG);
>  		*bit *= RK3188_PULL_BITS_PER_PIN;
>  	}
> +
> +	return 0;
>  }
>  
> -static void rk3399_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
> -					int pin_num, struct regmap **regmap,
> -					int *reg, u8 *bit)
> +static int rk3399_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
> +				       int pin_num, struct regmap **regmap,
> +				       int *reg, u8 *bit)
>  {
>  	struct rockchip_pinctrl *info = bank->drvdata;
>  	int drv_num = (pin_num / 8);
> @@ -1500,6 +1532,8 @@ static void rk3399_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
>  		*bit = (pin_num % 8) * 3;
>  	else
>  		*bit = (pin_num % 8) * 2;
> +
> +	return 0;
>  }
>  
>  #define RK3568_PULL_PMU_OFFSET		0x20
> @@ -1508,9 +1542,9 @@ static void rk3399_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
>  #define RK3568_PULL_PINS_PER_REG	8
>  #define RK3568_PULL_BANK_STRIDE		0x10
>  
> -static void rk3568_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
> -					 int pin_num, struct regmap **regmap,
> -					 int *reg, u8 *bit)
> +static int rk3568_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
> +					int pin_num, struct regmap **regmap,
> +					int *reg, u8 *bit)
>  {
>  	struct rockchip_pinctrl *info = bank->drvdata;
>  
> @@ -1531,6 +1565,8 @@ static void rk3568_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
>  		*bit = (pin_num % RK3568_PULL_PINS_PER_REG);
>  		*bit *= RK3568_PULL_BITS_PER_PIN;
>  	}
> +
> +	return 0;
>  }
>  
>  #define RK3568_DRV_PMU_OFFSET		0x70
> @@ -1539,9 +1575,9 @@ static void rk3568_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
>  #define RK3568_DRV_PINS_PER_REG		2
>  #define RK3568_DRV_BANK_STRIDE		0x40
>  
> -static void rk3568_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
> -					int pin_num, struct regmap **regmap,
> -					int *reg, u8 *bit)
> +static int rk3568_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
> +				       int pin_num, struct regmap **regmap,
> +				       int *reg, u8 *bit)
>  {
>  	struct rockchip_pinctrl *info = bank->drvdata;
>  
> @@ -1562,6 +1598,8 @@ static void rk3568_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
>  		*bit = (pin_num % RK3568_DRV_PINS_PER_REG);
>  		*bit *= RK3568_DRV_BITS_PER_PIN;
>  	}
> +
> +	return 0;
>  }
>  
>  static int rockchip_perpin_drv_list[DRV_TYPE_MAX][8] = {
> @@ -1584,7 +1622,9 @@ static int rockchip_get_drive_perpin(struct rockchip_pin_bank *bank,
>  	u8 bit;
>  	int drv_type = bank->drv[pin_num / 8].drv_type;
>  
> -	ctrl->drv_calc_reg(bank, pin_num, &regmap, &reg, &bit);
> +	ret = ctrl->drv_calc_reg(bank, pin_num, &regmap, &reg, &bit);
> +	if (ret)
> +		return ret;
>  
>  	switch (drv_type) {
>  	case DRV_TYPE_IO_1V8_3V0_AUTO:
> @@ -1664,7 +1704,9 @@ static int rockchip_set_drive_perpin(struct rockchip_pin_bank *bank,
>  	dev_dbg(dev, "setting drive of GPIO%d-%d to %d\n",
>  		bank->bank_num, pin_num, strength);
>  
> -	ctrl->drv_calc_reg(bank, pin_num, &regmap, &reg, &bit);
> +	ret = ctrl->drv_calc_reg(bank, pin_num, &regmap, &reg, &bit);
> +	if (ret)
> +		return ret;
>  	if (ctrl->type == RK3568) {
>  		rmask_bits = RK3568_DRV_BITS_PER_PIN;
>  		ret = (1 << (strength + 1)) - 1;
> @@ -1777,7 +1819,9 @@ static int rockchip_get_pull(struct rockchip_pin_bank *bank, int pin_num)
>  	if (ctrl->type == RK3066B)
>  		return PIN_CONFIG_BIAS_DISABLE;
>  
> -	ctrl->pull_calc_reg(bank, pin_num, &regmap, &reg, &bit);
> +	ret = ctrl->pull_calc_reg(bank, pin_num, &regmap, &reg, &bit);
> +	if (ret)
> +		return ret;
>  
>  	ret = regmap_read(regmap, reg, &data);
>  	if (ret)
> @@ -1824,7 +1868,9 @@ static int rockchip_set_pull(struct rockchip_pin_bank *bank,
>  	if (ctrl->type == RK3066B)
>  		return pull ? -EINVAL : 0;
>  
> -	ctrl->pull_calc_reg(bank, pin_num, &regmap, &reg, &bit);
> +	ret = ctrl->pull_calc_reg(bank, pin_num, &regmap, &reg, &bit);
> +	if (ret)
> +		return ret;
>  
>  	switch (ctrl->type) {
>  	case RK2928:
> diff --git a/drivers/pinctrl/pinctrl-rockchip.h b/drivers/pinctrl/pinctrl-rockchip.h
> index 91f10279d084..4992a048acbc 100644
> --- a/drivers/pinctrl/pinctrl-rockchip.h
> +++ b/drivers/pinctrl/pinctrl-rockchip.h
> @@ -230,10 +230,10 @@ struct rockchip_pin_ctrl {
>  	struct rockchip_mux_route_data *iomux_routes;
>  	u32				niomux_routes;
>  
> -	void	(*pull_calc_reg)(struct rockchip_pin_bank *bank,
> +	int	(*pull_calc_reg)(struct rockchip_pin_bank *bank,
>  				    int pin_num, struct regmap **regmap,
>  				    int *reg, u8 *bit);
> -	void	(*drv_calc_reg)(struct rockchip_pin_bank *bank,
> +	int	(*drv_calc_reg)(struct rockchip_pin_bank *bank,
>  				    int pin_num, struct regmap **regmap,
>  				    int *reg, u8 *bit);
>  	int	(*schmitt_calc_reg)(struct rockchip_pin_bank *bank,
> 




