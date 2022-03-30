Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6FC4EC495
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 14:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345581AbiC3Mmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 08:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345435AbiC3Mm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 08:42:26 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8468C70CF0;
        Wed, 30 Mar 2022 05:33:31 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22U8wGPF017422;
        Wed, 30 Mar 2022 14:32:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=DEbaSZyL8lbefk5CRO35jWnVS3Bv29rcUXbGK60WGmM=;
 b=57rSGjYYJp3c8dBzu91WPJMLV7bf4spkB5sQ0aOnYE3qMTtdiFXMGbn5Kig5CJH9qBhG
 8N6nwFQOCu1yGjABNWfNUqmBWLjgg+BL96eJDEQo++p9RS7BcMVJhicxv1sbliFQQZiH
 Fm00eO0pYQ9MeTR0lfwOrvGBPmLdn+MufBA2Aif7NByJJbQ51iw6k03JpcjIxK0SctNj
 Qz3rNk/ZAtMmxUENMM2mWMtt7IxXeifPge1+4necc1dDQl8YkX1EZNVkzvHshcgcdId0
 bZwF1cbB+q11aKWRHP06bQ+mc5k0/Q+gJeoJ5s9dhHo4n4zbxgHvE4Jmc7ERK2VAFwMG hQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3f1tkmhg8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Mar 2022 14:32:43 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B283210002A;
        Wed, 30 Mar 2022 14:32:38 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 937A7221780;
        Wed, 30 Mar 2022 14:32:38 +0200 (CEST)
Received: from [10.211.7.4] (10.75.127.51) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 30 Mar
 2022 14:32:36 +0200
Message-ID: <ec5a56e6-9402-f80f-3c86-1820e39fec27@foss.st.com>
Date:   Wed, 30 Mar 2022 14:32:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 04/13] pinctrl: stm32: Switch to use
 for_each_gpiochip_node() helper
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Qianggui Song <qianggui.song@amlogic.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>
References: <20220329152926.50958-1-andriy.shevchenko@linux.intel.com>
 <20220329152926.50958-5-andriy.shevchenko@linux.intel.com>
From:   Fabien DESSENNE <fabien.dessenne@foss.st.com>
In-Reply-To: <20220329152926.50958-5-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-30_04,2022-03-30_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy


Thank you for the patch.

Fabien

On 29/03/2022 17:29, Andy Shevchenko wrote:
> Switch the code to use for_each_gpiochip_node() helper.
> 
> While at it, in order to avoid additional churn in the future,
> switch to fwnode APIs where it makes sense.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Fabien Dessenne <fabien.dessenne@foss.st.com>

> ---
>   drivers/pinctrl/stm32/pinctrl-stm32.c | 72 ++++++++++++---------------
>   1 file changed, 33 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
> index 4043a44211f0..3e2f1e3a84be 100644
> --- a/drivers/pinctrl/stm32/pinctrl-stm32.c
> +++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
> @@ -24,6 +24,7 @@
>   #include <linux/pinctrl/pinctrl.h>
>   #include <linux/pinctrl/pinmux.h>
>   #include <linux/platform_device.h>
> +#include <linux/property.h>
>   #include <linux/regmap.h>
>   #include <linux/reset.h>
>   #include <linux/slab.h>
> @@ -1215,13 +1216,12 @@ static const struct pinconf_ops stm32_pconf_ops = {
>   	.pin_config_dbg_show	= stm32_pconf_dbg_show,
>   };
>   
> -static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl,
> -	struct device_node *np)
> +static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl, struct fwnode_handle *fwnode)
>   {
>   	struct stm32_gpio_bank *bank = &pctl->banks[pctl->nbanks];
>   	int bank_ioport_nr;
>   	struct pinctrl_gpio_range *range = &bank->range;
> -	struct of_phandle_args args;
> +	struct fwnode_reference_args args;
>   	struct device *dev = pctl->dev;
>   	struct resource res;
>   	int npins = STM32_GPIO_PINS_PER_BANK;
> @@ -1230,7 +1230,7 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl,
>   	if (!IS_ERR(bank->rstc))
>   		reset_control_deassert(bank->rstc);
>   
> -	if (of_address_to_resource(np, 0, &res))
> +	if (of_address_to_resource(to_of_node(fwnode), 0, &res))
>   		return -ENODEV;
>   
>   	bank->base = devm_ioremap_resource(dev, &res);
> @@ -1245,15 +1245,15 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl,
>   
>   	bank->gpio_chip = stm32_gpio_template;
>   
> -	of_property_read_string(np, "st,bank-name", &bank->gpio_chip.label);
> +	fwnode_property_read_string(fwnode, "st,bank-name", &bank->gpio_chip.label);
>   
> -	if (!of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, i, &args)) {
> +	if (!fwnode_property_get_reference_args(fwnode, "gpio-ranges", NULL, 3, i, &args)) {
>   		bank_nr = args.args[1] / STM32_GPIO_PINS_PER_BANK;
>   		bank->gpio_chip.base = args.args[1];
>   
>   		/* get the last defined gpio line (offset + nb of pins) */
>   		npins = args.args[0] + args.args[2];
> -		while (!of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, ++i, &args))
> +		while (!fwnode_property_get_reference_args(fwnode, "gpio-ranges", NULL, 3, ++i, &args))
>   			npins = max(npins, (int)(args.args[0] + args.args[2]));
>   	} else {
>   		bank_nr = pctl->nbanks;
> @@ -1268,20 +1268,20 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl,
>   				       &pctl->banks[bank_nr].range);
>   	}
>   
> -	if (of_property_read_u32(np, "st,bank-ioport", &bank_ioport_nr))
> +	if (fwnode_property_read_u32(fwnode, "st,bank-ioport", &bank_ioport_nr))
>   		bank_ioport_nr = bank_nr;
>   
>   	bank->gpio_chip.base = bank_nr * STM32_GPIO_PINS_PER_BANK;
>   
>   	bank->gpio_chip.ngpio = npins;
> -	bank->gpio_chip.of_node = np;
> +	bank->gpio_chip.fwnode = fwnode;
>   	bank->gpio_chip.parent = dev;
>   	bank->bank_nr = bank_nr;
>   	bank->bank_ioport_nr = bank_ioport_nr;
>   	spin_lock_init(&bank->lock);
>   
>   	/* create irq hierarchical domain */
> -	bank->fwnode = of_node_to_fwnode(np);
> +	bank->fwnode = fwnode;
>   
>   	bank->domain = irq_domain_create_hierarchy(pctl->domain, 0,
>   					STM32_GPIO_IRQ_LINE, bank->fwnode,
> @@ -1418,7 +1418,7 @@ static int stm32_pctrl_create_pins_tab(struct stm32_pinctrl *pctl,
>   int stm32_pctl_probe(struct platform_device *pdev)
>   {
>   	struct device_node *np = pdev->dev.of_node;
> -	struct device_node *child;
> +	struct fwnode_handle *child;
>   	const struct of_device_id *match;
>   	struct device *dev = &pdev->dev;
>   	struct stm32_pinctrl *pctl;
> @@ -1525,40 +1525,34 @@ int stm32_pctl_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   
>   	i = 0;
> -	for_each_available_child_of_node(np, child) {
> +	for_each_gpiochip_node(dev, child) {
>   		struct stm32_gpio_bank *bank = &pctl->banks[i];
> +		struct device_node *np = to_of_node(child);
>   
> -		if (of_property_read_bool(child, "gpio-controller")) {
> -			bank->rstc = of_reset_control_get_exclusive(child,
> -								    NULL);
> -			if (PTR_ERR(bank->rstc) == -EPROBE_DEFER) {
> -				of_node_put(child);
> -				return -EPROBE_DEFER;
> -			}
> -
> -			bank->clk = of_clk_get_by_name(child, NULL);
> -			if (IS_ERR(bank->clk)) {
> -				if (PTR_ERR(bank->clk) != -EPROBE_DEFER)
> -					dev_err(dev,
> -						"failed to get clk (%ld)\n",
> -						PTR_ERR(bank->clk));
> -				of_node_put(child);
> -				return PTR_ERR(bank->clk);
> -			}
> -			i++;
> +		bank->rstc = of_reset_control_get_exclusive(np, NULL);
> +		if (PTR_ERR(bank->rstc) == -EPROBE_DEFER) {
> +			fwnode_handle_put(child);
> +			return -EPROBE_DEFER;
>   		}
> -	}
>   
> -	for_each_available_child_of_node(np, child) {
> -		if (of_property_read_bool(child, "gpio-controller")) {
> -			ret = stm32_gpiolib_register_bank(pctl, child);
> -			if (ret) {
> -				of_node_put(child);
> -				return ret;
> -			}
> +		bank->clk = of_clk_get_by_name(np, NULL);
> +		if (IS_ERR(bank->clk)) {
> +			if (PTR_ERR(bank->clk) != -EPROBE_DEFER)
> +				dev_err(dev, "failed to get clk (%ld)\n", PTR_ERR(bank->clk));
> +			fwnode_handle_put(child);
> +			return PTR_ERR(bank->clk);
> +		}
> +		i++;
> +	}
>   
> -			pctl->nbanks++;
> +	for_each_gpiochip_node(dev, child) {
> +		ret = stm32_gpiolib_register_bank(pctl, child);
> +		if (ret) {
> +			fwnode_handle_put(child);
> +			return ret;
>   		}
> +
> +		pctl->nbanks++;
>   	}
>   
>   	dev_info(dev, "Pinctrl STM32 initialized\n");
