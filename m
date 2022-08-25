Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7135A17C9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 19:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241441AbiHYRPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 13:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242131AbiHYRPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 13:15:13 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B616864C7;
        Thu, 25 Aug 2022 10:15:04 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27PHEhOQ067619;
        Thu, 25 Aug 2022 12:14:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661447683;
        bh=Gtbfykr4ysLPVXpXudMSxZDjICmcGtmUlUXBeruNnac=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=DrNdaBMBYaxTlBWgKJ1t+CAZXc1aVTr3nwW4BrNAM35czo8U2XO056t9AXaOJHP/S
         MFahJonMg58mVOojpOzm5QGWJxUBhG71KP74mVRxQultRm9TBIv+FlE9Pjyv2xg5hf
         hz/L7mw4StqQVPImVPwIpJ4ow0xR/VZMScWBAF6U=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27PHEhok084452
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Aug 2022 12:14:43 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 25
 Aug 2022 12:14:42 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 25 Aug 2022 12:14:42 -0500
Received: from [10.250.32.193] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27PHEfNm043475;
        Thu, 25 Aug 2022 12:14:41 -0500
Message-ID: <3c802196-bd18-7caa-0a26-d3e935325e50@ti.com>
Date:   Thu, 25 Aug 2022 12:14:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 4/6] mfd: drivers: Add TI TPS65219 PMIC support
Content-Language: en-US
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee@kernel.org>, Tony Lindgren <tony@atomide.com>,
        <nm@ti.com>, <kristo@kernel.org>
CC:     Jerome Neanne <jneanne@baylibre.com>, <khilman@baylibre.com>,
        <narmstrong@baylibre.com>, <j-keerthy@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-input@vger.kernel.org>, <linux-omap@vger.kernel.org>
References: <20220825150224.826258-1-msp@baylibre.com>
 <20220825150224.826258-5-msp@baylibre.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20220825150224.826258-5-msp@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/22 10:02 AM, Markus Schneider-Pargmann wrote:
> From: Jerome Neanne <jneanne@baylibre.com>
> 
> The TPS65219 is a power management IC PMIC designed to supply a wide
> range of SoCs in both portable and stationary applications. Any SoC can
> control TPS65219 over a standard I2C interface.
> 
> It contains the following components:
> - Regulators.
> - Over Temperature warning and Shut down.
> - GPIOs
> - Multi Function Pins (MFP)
> - power-button
> 
> This patch adds support for tps65219 PMIC. At this time only
> the functionalities listed below are made available:
> 
> - Regulators probe and functionalities
> - warm and cold reset support
> - SW shutdown support
> - Regulator warnings via IRQs
> - Power-button via IRQ
> 
> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
> 
> Notes:
>      Changes in v4:
>      - Removed unused fields from struct tps65219
>      - Added description for the fields in struct tps65219
>      - Fixed coding style
>      - Squash all patches into one mfd patch
>      - Call devm_mfd_add_devices multiple times to clean up the code
>      - Remove debug prints and fixup other messages
>      - Use new_probe instead of probe
> 
>   MAINTAINERS                  |   1 +
>   drivers/mfd/Kconfig          |  14 ++
>   drivers/mfd/Makefile         |   1 +
>   drivers/mfd/tps65219.c       | 357 +++++++++++++++++++++++++++++++++++
>   include/linux/mfd/tps65219.h | 345 +++++++++++++++++++++++++++++++++
>   5 files changed, 718 insertions(+)
>   create mode 100644 drivers/mfd/tps65219.c
>   create mode 100644 include/linux/mfd/tps65219.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f35b29ffd5fb..960df879c635 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14926,6 +14926,7 @@ F:	drivers/mfd/menelaus.c
>   F:	drivers/mfd/palmas.c
>   F:	drivers/mfd/tps65217.c
>   F:	drivers/mfd/tps65218.c
> +F:	drivers/mfd/tps65219.c
>   F:	drivers/mfd/tps65910.c
>   F:	drivers/mfd/twl-core.[ch]
>   F:	drivers/mfd/twl4030*.c
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index abb58ab1a1a4..1a846c7dd0c2 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1576,6 +1576,20 @@ config MFD_TPS65218
>   	  This driver can also be built as a module.  If so, the module
>   	  will be called tps65218.
>   
> +config MFD_TPS65219
> +	tristate "TI TPS65219 Power Management IC"
> +	depends on I2C && OF
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	select REGMAP_IRQ
> +	help
> +	  If you say yes here you get support for the TPS65219 series of Power
> +	  Management ICs. These include voltage regulators, GPIOs and
> +	  push/power button that are often used in portable devices.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called tps65219.
> +
>   config MFD_TPS6586X
>   	bool "TI TPS6586x Power Management chips"
>   	depends on I2C=y
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 858cacf659d6..a8ff3d6ea3ab 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -101,6 +101,7 @@ obj-$(CONFIG_TPS6507X)		+= tps6507x.o
>   obj-$(CONFIG_MFD_TPS65086)	+= tps65086.o
>   obj-$(CONFIG_MFD_TPS65217)	+= tps65217.o
>   obj-$(CONFIG_MFD_TPS65218)	+= tps65218.o
> +obj-$(CONFIG_MFD_TPS65219)	+= tps65219.o
>   obj-$(CONFIG_MFD_TPS65910)	+= tps65910.o
>   obj-$(CONFIG_MFD_TPS65912)	+= tps65912-core.o
>   obj-$(CONFIG_MFD_TPS65912_I2C)	+= tps65912-i2c.o
> diff --git a/drivers/mfd/tps65219.c b/drivers/mfd/tps65219.c
> new file mode 100644
> index 000000000000..f3883911de37
> --- /dev/null
> +++ b/drivers/mfd/tps65219.c
> @@ -0,0 +1,357 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Driver for TPS65219 Integrated Power Management Integrated Chips (PMIC)
> +//
> +// Copyright (C) 2022 BayLibre Incorporated - https://www.baylibre.com/
> +
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reboot.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/tps65219.h>
> +
> +static struct i2c_client *tps65219_i2c_client;
> +
> +static int tps65219_warm_reset(struct tps65219 *tps)
> +{
> +	return regmap_update_bits(tps->regmap, TPS65219_REG_MFP_CTRL,
> +				  TPS65219_MFP_WARM_RESET_I2C_CTRL_MASK,
> +				  TPS65219_MFP_WARM_RESET_I2C_CTRL_MASK);
> +}
> +
> +static int tps65219_cold_reset(struct tps65219 *tps)
> +{
> +	return regmap_update_bits(tps->regmap, TPS65219_REG_MFP_CTRL,
> +				  TPS65219_MFP_COLD_RESET_I2C_CTRL_MASK,
> +				  TPS65219_MFP_COLD_RESET_I2C_CTRL_MASK);
> +}
> +
> +static int tps65219_soft_shutdown(struct tps65219 *tps)
> +{
> +	return regmap_update_bits(tps->regmap, TPS65219_REG_MFP_CTRL,
> +				  TPS65219_MFP_I2C_OFF_REQ_MASK,
> +				  TPS65219_MFP_I2C_OFF_REQ_MASK);
> +}
> +
> +static int tps65219_restart(struct notifier_block *this,
> +			    unsigned long reboot_mode, void *cmd)
> +{
> +	struct tps65219 *tps;
> +
> +	tps = container_of(this, struct tps65219, nb);
> +	if (!tps) {
> +		pr_err("tps65219: Restarting failed because the pointer to tps65219 is invalid\n");
> +		return -ENODEV;
> +	}
> +	if (reboot_mode == REBOOT_WARM)
> +		tps65219_warm_reset(tps);
> +	else
> +		tps65219_cold_reset(tps);
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block pmic_rst_restart_nb = {
> +	.notifier_call = tps65219_restart,
> +	.priority = 200,
> +};
> +
> +static void tps65219_pm_power_off(void)
> +{
> +	struct tps65219 *tps;
> +
> +	tps = dev_get_drvdata(&tps65219_i2c_client->dev);
> +	tps65219_soft_shutdown(tps);
> +}
> +
> +static const struct resource tps65219_pwrbutton_resources[] = {
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_PB_FALLING_EDGE_DETECT, "falling"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_PB_RISING_EDGE_DETECT, "rising"),
> +};
> +
> +static const struct resource tps65219_regulator_resources[] = {
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO3_SCG, "LDO3_SCG"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO3_OC, "LDO3_OC"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO3_UV, "LDO3_UV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO4_SCG, "LDO4_SCG"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO4_OC, "LDO4_OC"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO4_UV, "LDO4_UV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO1_SCG, "LDO1_SCG"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO1_OC, "LDO1_OC"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO1_UV, "LDO1_UV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO2_SCG, "LDO2_SCG"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO2_OC, "LDO2_OC"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO2_UV, "LDO2_UV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK3_SCG, "BUCK3_SCG"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK3_OC, "BUCK3_OC"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK3_NEG_OC, "BUCK3_NEG_OC"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK3_UV, "BUCK3_UV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK1_SCG, "BUCK1_SCG"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK1_OC, "BUCK1_OC"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK1_NEG_OC, "BUCK1_NEG_OC"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK1_UV, "BUCK1_UV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK2_SCG, "BUCK2_SCG"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK2_OC, "BUCK2_OC"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK2_NEG_OC, "BUCK2_NEG_OC"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK2_UV, "BUCK2_UV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK1_RV, "BUCK1_RV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK2_RV, "BUCK2_RV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK3_RV, "BUCK3_RV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO1_RV, "LDO1_RV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO2_RV, "LDO2_RV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO3_RV, "LDO3_RV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO4_RV, "LDO4_RV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK1_RV_SD, "BUCK1_RV_SD"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK2_RV_SD, "BUCK2_RV_SD"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK3_RV_SD, "BUCK3_RV_SD"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO1_RV_SD, "LDO1_RV_SD"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO2_RV_SD, "LDO2_RV_SD"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO3_RV_SD, "LDO3_RV_SD"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO4_RV_SD, "LDO4_RV_SD"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_TIMEOUT, "TIMEOUT"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_SENSOR_3_WARM, "SENSOR_3_WARM"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_SENSOR_2_WARM, "SENSOR_2_WARM"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_SENSOR_1_WARM, "SENSOR_1_WARM"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_SENSOR_0_WARM, "SENSOR_0_WARM"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_SENSOR_3_HOT, "SENSOR_3_HOT"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_SENSOR_2_HOT, "SENSOR_2_HOT"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_SENSOR_1_HOT, "SENSOR_1_HOT"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_SENSOR_0_HOT, "SENSOR_0_HOT"),
> +};
> +
> +static const struct mfd_cell tps65219_cells[] = {
> +	{
> +		.name = "tps65219-regulator",
> +		.resources = tps65219_regulator_resources,
> +		.num_resources = ARRAY_SIZE(tps65219_regulator_resources),
> +	}, {
> +		.name = "tps65219-gpios",
> +	},
> +};
> +
> +static const struct mfd_cell tps65219_pwrbutton_cell = {
> +	.name = "tps65219-pwrbutton",
> +	.resources = tps65219_pwrbutton_resources,
> +	.num_resources = ARRAY_SIZE(tps65219_pwrbutton_resources),
> +};
> +
> +static const struct regmap_config tps65219_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = TPS65219_REG_FACTORY_CONFIG_2,
> +};
> +
> +/*
> + * Mapping of main IRQ register bits to sub-IRQ register offsets so that we can
> + * access corect sub-IRQ registers based on bits that are set in main IRQ
> + * register.
> + */
> +/* Timeout Residual Voltage Shutdown */
> +static unsigned int bit0_offsets[] = { TPS65219_REG_INT_TO_RV_POS };
> +static unsigned int bit1_offsets[] = { TPS65219_REG_INT_RV_POS };	/* Residual Voltage */
> +static unsigned int bit2_offsets[] = { TPS65219_REG_INT_SYS_POS };	/* System */
> +static unsigned int bit3_offsets[] = { TPS65219_REG_INT_BUCK_1_2_POS };	/* Buck 1-2 */
> +static unsigned int bit4_offsets[] = { TPS65219_REG_INT_BUCK_3_POS };	/* Buck 3 */
> +static unsigned int bit5_offsets[] = { TPS65219_REG_INT_LDO_1_2_POS };	/* LDO 1-2 */
> +static unsigned int bit6_offsets[] = { TPS65219_REG_INT_LDO_3_4_POS };	/* LDO 3-4 */
> +static unsigned int bit7_offsets[] = { TPS65219_REG_INT_PB_POS };	/* Power Button */
> +
> +static struct regmap_irq_sub_irq_map tps65219_sub_irq_offsets[] = {
> +	REGMAP_IRQ_MAIN_REG_OFFSET(bit0_offsets),
> +	REGMAP_IRQ_MAIN_REG_OFFSET(bit1_offsets),
> +	REGMAP_IRQ_MAIN_REG_OFFSET(bit2_offsets),
> +	REGMAP_IRQ_MAIN_REG_OFFSET(bit3_offsets),
> +	REGMAP_IRQ_MAIN_REG_OFFSET(bit4_offsets),
> +	REGMAP_IRQ_MAIN_REG_OFFSET(bit5_offsets),
> +	REGMAP_IRQ_MAIN_REG_OFFSET(bit6_offsets),
> +	REGMAP_IRQ_MAIN_REG_OFFSET(bit7_offsets),
> +};
> +
> +#define TPS65219_REGMAP_IRQ_REG(int_name, register_position) \
> +	REGMAP_IRQ_REG(int_name, register_position, int_name##_MASK)
> +
> +static struct regmap_irq tps65219_irqs[] = {
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO3_SCG, TPS65219_REG_INT_LDO_3_4_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO3_OC, TPS65219_REG_INT_LDO_3_4_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO3_UV, TPS65219_REG_INT_LDO_3_4_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO4_SCG, TPS65219_REG_INT_LDO_3_4_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO4_OC, TPS65219_REG_INT_LDO_3_4_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO4_UV, TPS65219_REG_INT_LDO_3_4_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO1_SCG, TPS65219_REG_INT_LDO_1_2_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO1_OC, TPS65219_REG_INT_LDO_1_2_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO1_UV, TPS65219_REG_INT_LDO_1_2_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO2_SCG, TPS65219_REG_INT_LDO_1_2_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO2_OC, TPS65219_REG_INT_LDO_1_2_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO2_UV, TPS65219_REG_INT_LDO_1_2_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_BUCK3_SCG, TPS65219_REG_INT_BUCK_3_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_BUCK3_OC, TPS65219_REG_INT_BUCK_3_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_BUCK3_NEG_OC, TPS65219_REG_INT_BUCK_3_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_BUCK3_UV, TPS65219_REG_INT_BUCK_3_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_BUCK2_SCG, TPS65219_REG_INT_BUCK_1_2_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_BUCK2_OC, TPS65219_REG_INT_BUCK_1_2_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_BUCK2_NEG_OC, TPS65219_REG_INT_BUCK_1_2_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_BUCK2_UV, TPS65219_REG_INT_BUCK_1_2_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_BUCK1_SCG, TPS65219_REG_INT_BUCK_1_2_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_BUCK1_OC, TPS65219_REG_INT_BUCK_1_2_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_BUCK1_NEG_OC, TPS65219_REG_INT_BUCK_1_2_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_BUCK1_UV, TPS65219_REG_INT_BUCK_1_2_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_SENSOR_3_WARM, TPS65219_REG_INT_SYS_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_SENSOR_2_WARM, TPS65219_REG_INT_SYS_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_SENSOR_1_WARM, TPS65219_REG_INT_SYS_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_SENSOR_0_WARM, TPS65219_REG_INT_SYS_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_SENSOR_3_HOT, TPS65219_REG_INT_SYS_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_SENSOR_2_HOT, TPS65219_REG_INT_SYS_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_SENSOR_1_HOT, TPS65219_REG_INT_SYS_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_SENSOR_0_HOT, TPS65219_REG_INT_SYS_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_BUCK1_RV, TPS65219_REG_INT_RV_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_BUCK2_RV, TPS65219_REG_INT_RV_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_BUCK3_RV, TPS65219_REG_INT_RV_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO1_RV, TPS65219_REG_INT_RV_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO2_RV, TPS65219_REG_INT_RV_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO3_RV, TPS65219_REG_INT_RV_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO4_RV, TPS65219_REG_INT_RV_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_BUCK1_RV_SD, TPS65219_REG_INT_TO_RV_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_BUCK2_RV_SD, TPS65219_REG_INT_TO_RV_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_BUCK3_RV_SD, TPS65219_REG_INT_TO_RV_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO1_RV_SD, TPS65219_REG_INT_TO_RV_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO2_RV_SD, TPS65219_REG_INT_TO_RV_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO3_RV_SD, TPS65219_REG_INT_TO_RV_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO4_RV_SD, TPS65219_REG_INT_TO_RV_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_TIMEOUT, TPS65219_REG_INT_TO_RV_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_PB_FALLING_EDGE_DETECT, TPS65219_REG_INT_PB_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_PB_RISING_EDGE_DETECT, TPS65219_REG_INT_PB_POS),
> +};
> +
> +static struct regmap_irq_chip tps65219_irq_chip = {
> +	.name = "tps65219_irq",
> +	.main_status = TPS65219_REG_INT_SOURCE,
> +	.num_main_regs = 1,
> +	.num_main_status_bits = 8,
> +	.irqs = tps65219_irqs,
> +	.num_irqs = ARRAY_SIZE(tps65219_irqs),
> +	.status_base = TPS65219_REG_INT_LDO_3_4,
> +	.ack_base = TPS65219_REG_INT_LDO_3_4,
> +	.clear_ack = 1,
> +	.num_regs = 8,
> +	.sub_reg_offsets = tps65219_sub_irq_offsets,
> +};
> +
> +static int tps65219_probe(struct i2c_client *client)
> +{
> +	struct tps65219 *tps;
> +	unsigned int chipid;
> +	bool pwr_button;
> +	bool sys_pwr;
> +	int ret;
> +
> +	tps = devm_kzalloc(&client->dev, sizeof(*tps), GFP_KERNEL);
> +	if (!tps)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, tps);
> +
> +	tps->dev = &client->dev;
> +
> +	tps->regmap = devm_regmap_init_i2c(client, &tps65219_regmap_config);
> +	if (IS_ERR(tps->regmap)) {
> +		ret = PTR_ERR(tps->regmap);
> +		dev_err(tps->dev, "Failed to allocate register map: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = devm_regmap_add_irq_chip(&client->dev, tps->regmap, client->irq,
> +				       IRQF_ONESHOT, 0, &tps65219_irq_chip,
> +				       &tps->irq_data);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(tps->regmap, TPS65219_REG_TI_DEV_ID, &chipid);
> +	if (ret) {
> +		dev_err(tps->dev, "Failed to read device ID: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = devm_mfd_add_devices(tps->dev, PLATFORM_DEVID_AUTO,
> +				   tps65219_cells, ARRAY_SIZE(tps65219_cells),
> +				   NULL, 0, regmap_irq_get_domain(tps->irq_data));
> +	if (ret) {
> +		dev_err(tps->dev, "Failed to add child devices: %d\n", ret);
> +		return ret;
> +	}
> +
> +	pwr_button = of_property_read_bool(tps->dev->of_node, "ti,power-button");
> +	if (pwr_button) {
> +		ret = devm_mfd_add_devices(tps->dev, PLATFORM_DEVID_AUTO,
> +					   &tps65219_pwrbutton_cell, 1, NULL, 0,
> +					   regmap_irq_get_domain(tps->irq_data));
> +		if (ret) {
> +			dev_err(tps->dev, "Failed to add power-button: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	tps->nb = pmic_rst_restart_nb;
> +	ret = register_restart_handler(&tps->nb);
> +	if (ret) {
> +		dev_err(tps->dev, "cannot register restart handler, %d\n", ret);
> +		return ret;
> +	}
> +
> +	sys_pwr = of_property_read_bool(tps->dev->of_node, "system-power-controller");
> +
> +	if (!sys_pwr)
> +		return 0;


I'm not liking these non-error short circut returns. Will lead to things getting
missed should they be added below this point. Prefer:


	sys_pwr = of_property_read_bool(tps->dev->of_node, "system-power-controller");
	if (sys_pwr) {
		if (pm_power_off) {
			dev_warn(tps->dev, "system-power-controller requested but pm_power_off function already registered\n");
		} else {
			tps65219_i2c_client = client;
			pm_power_off = &tps65219_pm_power_off;
		}
	}

	tps65219_i2c_client = client;

	return 0;
}

Or even better, just drop all this "system-power-controller" stuff until we figure
out how we will handle it. The systems today using this PMIC will have PSCI
being the pm_power_off controller, so we always go down the error/warn path here.

Andrew


> +
> +	if (pm_power_off) {
> +		dev_err(tps->dev, "system-power-controller requested but pm_power_off function already registered\n");
> +		return 0;
> +	}
> +
> +	tps65219_i2c_client = client;
> +	pm_power_off = &tps65219_pm_power_off;
> +
> +	return 0;
> +}
> +
> +static int tps65219_remove(struct i2c_client *client)
> +{
> +	struct tps65219 *tps = i2c_get_clientdata(client);
> +
> +	if (tps65219_i2c_client == client) {
> +		pm_power_off = NULL;
> +		tps65219_i2c_client = NULL;
> +	}
> +
> +	return unregister_restart_handler(&tps->nb);
> +}
> +
> +static const struct of_device_id of_tps65219_match_table[] = {
> +	{ .compatible = "ti,tps65219", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, of_tps65219_match_table);
> +
> +static struct i2c_driver tps65219_driver = {
> +	.driver		= {
> +		.name	= "tps65219",
> +		.of_match_table = of_tps65219_match_table,
> +	},
> +	.probe_new	= tps65219_probe,
> +	.remove		= tps65219_remove,
> +};
> +module_i2c_driver(tps65219_driver);
> +
> +MODULE_AUTHOR("Jerome Neanne <jneanne@baylibre.com>");
> +MODULE_DESCRIPTION("TPS65219 power management IC driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/tps65219.h b/include/linux/mfd/tps65219.h
> new file mode 100644
> index 000000000000..2c1cf92e92ac
> --- /dev/null
> +++ b/include/linux/mfd/tps65219.h
> @@ -0,0 +1,345 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Functions to access TPS65219 power management IC.
> + *
> + * Copyright (C) 2022 BayLibre Incorporated - https://www.baylibre.com/
> + */
> +
> +#ifndef MFD_TPS65219_H
> +#define MFD_TPS65219_H
> +
> +#include <linux/bitops.h>
> +#include <linux/notifier.h>
> +#include <linux/regulator/driver.h>
> +
> +struct regmap;
> +struct regmap_irq_chip_data;
> +
> +#define TPS65219_1V35					1350000
> +#define TPS65219_1V8					1800000
> +
> +/* TPS chip id list */
> +#define TPS65219					0xF0
> +
> +/* I2C ID for TPS65219 part */
> +#define TPS65219_I2C_ID					0x24
> +
> +/* All register addresses */
> +#define TPS65219_REG_TI_DEV_ID				0x00
> +#define TPS65219_REG_NVM_ID				0x01
> +#define TPS65219_REG_ENABLE_CTRL			0x02
> +#define TPS65219_REG_BUCKS_CONFIG			0x03
> +#define TPS65219_REG_LDO4_VOUT				0x04
> +#define TPS65219_REG_LDO3_VOUT				0x05
> +#define TPS65219_REG_LDO2_VOUT				0x06
> +#define TPS65219_REG_LDO1_VOUT				0x07
> +#define TPS65219_REG_BUCK3_VOUT				0x8
> +#define TPS65219_REG_BUCK2_VOUT				0x9
> +#define TPS65219_REG_BUCK1_VOUT				0xA
> +#define TPS65219_REG_LDO4_SEQUENCE_SLOT			0xB
> +#define TPS65219_REG_LDO3_SEQUENCE_SLOT			0xC
> +#define TPS65219_REG_LDO2_SEQUENCE_SLOT			0xD
> +#define TPS65219_REG_LDO1_SEQUENCE_SLOT			0xE
> +#define TPS65219_REG_BUCK3_SEQUENCE_SLOT		0xF
> +#define TPS65219_REG_BUCK2_SEQUENCE_SLOT		0x10
> +#define TPS65219_REG_BUCK1_SEQUENCE_SLOT		0x11
> +#define TPS65219_REG_nRST_SEQUENCE_SLOT			0x12
> +#define TPS65219_REG_GPIO_SEQUENCE_SLOT			0x13
> +#define TPS65219_REG_GPO2_SEQUENCE_SLOT			0x14
> +#define TPS65219_REG_GPO1_SEQUENCE_SLOT			0x15
> +#define TPS65219_REG_POWER_UP_SLOT_DURATION_1		0x16
> +#define TPS65219_REG_POWER_UP_SLOT_DURATION_2		0x17
> +#define TPS65219_REG_POWER_UP_SLOT_DURATION_3		0x18
> +#define TPS65219_REG_POWER_UP_SLOT_DURATION_4		0x19
> +#define TPS65219_REG_POWER_DOWN_SLOT_DURATION_1		0x1A
> +#define TPS65219_REG_POWER_DOWN_SLOT_DURATION_2		0x1B
> +#define TPS65219_REG_POWER_DOWN_SLOT_DURATION_3		0x1C
> +#define TPS65219_REG_POWER_DOWN_SLOT_DURATION_4		0x1D
> +#define TPS65219_REG_GENERAL_CONFIG			0x1E
> +#define TPS65219_REG_MFP_1_CONFIG			0x1F
> +#define TPS65219_REG_MFP_2_CONFIG			0x20
> +#define TPS65219_REG_STBY_1_CONFIG			0x21
> +#define TPS65219_REG_STBY_2_CONFIG			0x22
> +#define TPS65219_REG_OC_DEGL_CONFIG			0x23
> +/* 'sub irq' MASK registers */
> +#define TPS65219_REG_INT_MASK_UV			0x24
> +#define TPS65219_REG_MASK_CONFIG			0x25
> +
> +#define TPS65219_REG_I2C_ADDRESS_REG			0x26
> +#define TPS65219_REG_USER_GENERAL_NVM_STORAGE		0x27
> +#define TPS65219_REG_MANUFACTURING_VER			0x28
> +#define TPS65219_REG_MFP_CTRL				0x29
> +#define TPS65219_REG_DISCHARGE_CONFIG			0x2A
> +/* main irq registers */
> +#define TPS65219_REG_INT_SOURCE				0x2B
> +/* 'sub irq' registers */
> +#define TPS65219_REG_INT_LDO_3_4			0x2C
> +#define TPS65219_REG_INT_LDO_1_2			0x2D
> +#define TPS65219_REG_INT_BUCK_3				0x2E
> +#define TPS65219_REG_INT_BUCK_1_2			0x2F
> +#define TPS65219_REG_INT_SYSTEM				0x30
> +#define TPS65219_REG_INT_RV				0x31
> +#define TPS65219_REG_INT_TIMEOUT_RV_SD			0x32
> +#define TPS65219_REG_INT_PB				0x33
> +
> +#define TPS65219_REG_INT_LDO_3_4_POS			0
> +#define TPS65219_REG_INT_LDO_1_2_POS			1
> +#define TPS65219_REG_INT_BUCK_3_POS			2
> +#define TPS65219_REG_INT_BUCK_1_2_POS			3
> +#define TPS65219_REG_INT_SYS_POS			4
> +#define TPS65219_REG_INT_RV_POS				5
> +#define TPS65219_REG_INT_TO_RV_POS			6
> +#define TPS65219_REG_INT_PB_POS				7
> +
> +#define TPS65219_REG_USER_NVM_CMD			0x34
> +#define TPS65219_REG_POWER_UP_STATUS			0x35
> +#define TPS65219_REG_SPARE_2				0x36
> +#define TPS65219_REG_SPARE_3				0x37
> +#define TPS65219_REG_FACTORY_CONFIG_2			0x41
> +
> +/* Register field definitions */
> +#define TPS65219_DEVID_REV_MASK				GENMASK(7, 0)
> +#define TPS65219_BUCKS_LDOS_VOUT_VSET_MASK		GENMASK(5, 0)
> +#define TPS65219_BUCKS_UV_THR_SEL_MASK			BIT(6)
> +#define TPS65219_BUCKS_BW_SEL_MASK			BIT(7)
> +#define LDO_BYP_SHIFT					6
> +#define TPS65219_LDOS_BYP_CONFIG_MASK			BIT(LDO_BYP_SHIFT)
> +#define TPS65219_LDOS_LSW_CONFIG_MASK			BIT(7)
> +/* Regulators enable control */
> +#define TPS65219_ENABLE_BUCK1_EN_MASK			BIT(0)
> +#define TPS65219_ENABLE_BUCK2_EN_MASK			BIT(1)
> +#define TPS65219_ENABLE_BUCK3_EN_MASK			BIT(2)
> +#define TPS65219_ENABLE_LDO1_EN_MASK			BIT(3)
> +#define TPS65219_ENABLE_LDO2_EN_MASK			BIT(4)
> +#define TPS65219_ENABLE_LDO3_EN_MASK			BIT(5)
> +#define TPS65219_ENABLE_LDO4_EN_MASK			BIT(6)
> +/* power ON-OFF sequence slot */
> +#define TPS65219_BUCKS_LDOS_SEQUENCE_OFF_SLOT_MASK	GENMASK(3, 0)
> +#define TPS65219_BUCKS_LDOS_SEQUENCE_ON_SLOT_MASK	GENMASK(7, 4)
> +/* TODO: Not needed, same mapping as TPS65219_ENABLE_REGNAME_EN, factorize */
> +#define TPS65219_STBY1_BUCK1_STBY_EN_MASK		BIT(0)
> +#define TPS65219_STBY1_BUCK2_STBY_EN_MASK		BIT(1)
> +#define TPS65219_STBY1_BUCK3_STBY_EN_MASK		BIT(2)
> +#define TPS65219_STBY1_LDO1_STBY_EN_MASK		BIT(3)
> +#define TPS65219_STBY1_LDO2_STBY_EN_MASK		BIT(4)
> +#define TPS65219_STBY1_LDO3_STBY_EN_MASK		BIT(5)
> +#define TPS65219_STBY1_LDO4_STBY_EN_MASK		BIT(6)
> +/* STBY_2 config */
> +#define TPS65219_STBY2_GPO1_STBY_EN_MASK		BIT(0)
> +#define TPS65219_STBY2_GPO2_STBY_EN_MASK		BIT(1)
> +#define TPS65219_STBY2_GPIO_STBY_EN_MASK		BIT(2)
> +/* MFP Control */
> +#define TPS65219_MFP_I2C_OFF_REQ_MASK			BIT(0)
> +#define TPS65219_MFP_STBY_I2C_CTRL_MASK			BIT(1)
> +#define TPS65219_MFP_COLD_RESET_I2C_CTRL_MASK		BIT(2)
> +#define TPS65219_MFP_WARM_RESET_I2C_CTRL_MASK		BIT(3)
> +#define TPS65219_MFP_GPIO_STATUS_MASK			BIT(4)
> +/* MFP_1 Config */
> +#define TPS65219_MFP_1_VSEL_DDR_SEL_MASK		BIT(0)
> +#define TPS65219_MFP_1_VSEL_SD_POL_MASK			BIT(1)
> +#define TPS65219_MFP_1_VSEL_RAIL_MASK			BIT(2)
> +/* MFP_2 Config */
> +#define TPS65219_MFP_2_MODE_STBY_MASK			GENMASK(1, 0)
> +#define TPS65219_MFP_2_MODE_RESET_MASK			BIT(2)
> +#define TPS65219_MFP_2_EN_PB_VSENSE_DEGL_MASK		BIT(3)
> +#define TPS65219_MFP_2_EN_PB_VSENSE_MASK		GENMASK(5, 4)
> +#define TPS65219_MFP_2_WARM_COLD_RESET_MASK		BIT(6)
> +#define TPS65219_MFP_2_PU_ON_FSD_MASK			BIT(7)
> +#define TPS65219_MFP_2_EN				0
> +#define TPS65219_MFP_2_PB				BIT(4)
> +#define TPS65219_MFP_2_VSENSE				BIT(5)
> +/* MASK_UV Config */
> +#define TPS65219_REG_MASK_UV_LDO1_UV_MASK		BIT(0)
> +#define TPS65219_REG_MASK_UV_LDO2_UV_MASK		BIT(1)
> +#define TPS65219_REG_MASK_UV_LDO3_UV_MASK		BIT(2)
> +#define TPS65219_REG_MASK_UV_LDO4_UV_MASK		BIT(3)
> +#define TPS65219_REG_MASK_UV_BUCK1_UV_MASK		BIT(4)
> +#define TPS65219_REG_MASK_UV_BUCK2_UV_MASK		BIT(5)
> +#define TPS65219_REG_MASK_UV_BUCK3_UV_MASK		BIT(6)
> +#define TPS65219_REG_MASK_UV_RETRY_MASK			BIT(7)
> +/* MASK Config */
> +// SENSOR_N_WARM_MASK already defined in Thermal
> +#define TPS65219_REG_MASK_INT_FOR_RV_MASK		BIT(4)
> +#define TPS65219_REG_MASK_EFFECT_MASK			GENMASK(2, 1)
> +#define TPS65219_REG_MASK_INT_FOR_PB_MASK		BIT(7)
> +/* UnderVoltage - Short to GND - OverCurrent*/
> +/* LDO3-4 */
> +#define TPS65219_INT_LDO3_SCG_MASK			BIT(0)
> +#define TPS65219_INT_LDO3_OC_MASK			BIT(1)
> +#define TPS65219_INT_LDO3_UV_MASK			BIT(2)
> +#define TPS65219_INT_LDO4_SCG_MASK			BIT(3)
> +#define TPS65219_INT_LDO4_OC_MASK			BIT(4)
> +#define TPS65219_INT_LDO4_UV_MASK			BIT(5)
> +/* LDO1-2 */
> +#define TPS65219_INT_LDO1_SCG_MASK			BIT(0)
> +#define TPS65219_INT_LDO1_OC_MASK			BIT(1)
> +#define TPS65219_INT_LDO1_UV_MASK			BIT(2)
> +#define TPS65219_INT_LDO2_SCG_MASK			BIT(3)
> +#define TPS65219_INT_LDO2_OC_MASK			BIT(4)
> +#define TPS65219_INT_LDO2_UV_MASK			BIT(5)
> +/* BUCK3 */
> +#define TPS65219_INT_BUCK3_SCG_MASK			BIT(0)
> +#define TPS65219_INT_BUCK3_OC_MASK			BIT(1)
> +#define TPS65219_INT_BUCK3_NEG_OC_MASK			BIT(2)
> +#define TPS65219_INT_BUCK3_UV_MASK			BIT(3)
> +/* BUCK1-2 */
> +#define TPS65219_INT_BUCK1_SCG_MASK			BIT(0)
> +#define TPS65219_INT_BUCK1_OC_MASK			BIT(1)
> +#define TPS65219_INT_BUCK1_NEG_OC_MASK			BIT(2)
> +#define TPS65219_INT_BUCK1_UV_MASK			BIT(3)
> +#define TPS65219_INT_BUCK2_SCG_MASK			BIT(4)
> +#define TPS65219_INT_BUCK2_OC_MASK			BIT(5)
> +#define TPS65219_INT_BUCK2_NEG_OC_MASK			BIT(6)
> +#define TPS65219_INT_BUCK2_UV_MASK			BIT(7)
> +/* Thermal Sensor  */
> +#define TPS65219_INT_SENSOR_3_WARM_MASK			BIT(0)
> +#define TPS65219_INT_SENSOR_2_WARM_MASK			BIT(1)
> +#define TPS65219_INT_SENSOR_1_WARM_MASK			BIT(2)
> +#define TPS65219_INT_SENSOR_0_WARM_MASK			BIT(3)
> +#define TPS65219_INT_SENSOR_3_HOT_MASK			BIT(4)
> +#define TPS65219_INT_SENSOR_2_HOT_MASK			BIT(5)
> +#define TPS65219_INT_SENSOR_1_HOT_MASK			BIT(6)
> +#define TPS65219_INT_SENSOR_0_HOT_MASK			BIT(7)
> +/* Residual Voltage */
> +#define TPS65219_INT_BUCK1_RV_MASK			BIT(0)
> +#define TPS65219_INT_BUCK2_RV_MASK			BIT(1)
> +#define TPS65219_INT_BUCK3_RV_MASK			BIT(2)
> +#define TPS65219_INT_LDO1_RV_MASK			BIT(3)
> +#define TPS65219_INT_LDO2_RV_MASK			BIT(4)
> +#define TPS65219_INT_LDO3_RV_MASK			BIT(5)
> +#define TPS65219_INT_LDO4_RV_MASK			BIT(6)
> +/* Residual Voltage ShutDown */
> +#define TPS65219_INT_BUCK1_RV_SD_MASK			BIT(0)
> +#define TPS65219_INT_BUCK2_RV_SD_MASK			BIT(1)
> +#define TPS65219_INT_BUCK3_RV_SD_MASK			BIT(2)
> +#define TPS65219_INT_LDO1_RV_SD_MASK			BIT(3)
> +#define TPS65219_INT_LDO2_RV_SD_MASK			BIT(4)
> +#define TPS65219_INT_LDO3_RV_SD_MASK			BIT(5)
> +#define TPS65219_INT_LDO4_RV_SD_MASK			BIT(6)
> +#define TPS65219_INT_TIMEOUT_MASK			BIT(7)
> +/* Power Button */
> +#define TPS65219_INT_PB_FALLING_EDGE_DETECT_MASK	BIT(0)
> +#define TPS65219_INT_PB_RISING_EDGE_DETECT_MASK		BIT(1)
> +#define TPS65219_INT_PB_REAL_TIME_STATUS_MASK		BIT(2)
> +
> +#define TPS65219_PB_POS					7
> +#define TPS65219_TO_RV_POS				6
> +#define TPS65219_RV_POS					5
> +#define TPS65219_SYS_POS				4
> +#define TPS65219_BUCK_1_2_POS				3
> +#define TPS65219_BUCK_3_POS				2
> +#define TPS65219_LDO_1_2_POS				1
> +#define TPS65219_LDO_3_4_POS				0
> +
> +/* IRQs */
> +enum {
> +	/* LDO3-4 register IRQs */
> +	TPS65219_INT_LDO3_SCG,
> +	TPS65219_INT_LDO3_OC,
> +	TPS65219_INT_LDO3_UV,
> +	TPS65219_INT_LDO4_SCG,
> +	TPS65219_INT_LDO4_OC,
> +	TPS65219_INT_LDO4_UV,
> +	/* LDO1-2 */
> +	TPS65219_INT_LDO1_SCG,
> +	TPS65219_INT_LDO1_OC,
> +	TPS65219_INT_LDO1_UV,
> +	TPS65219_INT_LDO2_SCG,
> +	TPS65219_INT_LDO2_OC,
> +	TPS65219_INT_LDO2_UV,
> +	/* BUCK3 */
> +	TPS65219_INT_BUCK3_SCG,
> +	TPS65219_INT_BUCK3_OC,
> +	TPS65219_INT_BUCK3_NEG_OC,
> +	TPS65219_INT_BUCK3_UV,
> +	/* BUCK1-2 */
> +	TPS65219_INT_BUCK1_SCG,
> +	TPS65219_INT_BUCK1_OC,
> +	TPS65219_INT_BUCK1_NEG_OC,
> +	TPS65219_INT_BUCK1_UV,
> +	TPS65219_INT_BUCK2_SCG,
> +	TPS65219_INT_BUCK2_OC,
> +	TPS65219_INT_BUCK2_NEG_OC,
> +	TPS65219_INT_BUCK2_UV,
> +	/* Thermal Sensor  */
> +	TPS65219_INT_SENSOR_3_WARM,
> +	TPS65219_INT_SENSOR_2_WARM,
> +	TPS65219_INT_SENSOR_1_WARM,
> +	TPS65219_INT_SENSOR_0_WARM,
> +	TPS65219_INT_SENSOR_3_HOT,
> +	TPS65219_INT_SENSOR_2_HOT,
> +	TPS65219_INT_SENSOR_1_HOT,
> +	TPS65219_INT_SENSOR_0_HOT,
> +	/* Residual Voltage */
> +	TPS65219_INT_BUCK1_RV,
> +	TPS65219_INT_BUCK2_RV,
> +	TPS65219_INT_BUCK3_RV,
> +	TPS65219_INT_LDO1_RV,
> +	TPS65219_INT_LDO2_RV,
> +	TPS65219_INT_LDO3_RV,
> +	TPS65219_INT_LDO4_RV,
> +	/* Residual Voltage ShutDown */
> +	TPS65219_INT_BUCK1_RV_SD,
> +	TPS65219_INT_BUCK2_RV_SD,
> +	TPS65219_INT_BUCK3_RV_SD,
> +	TPS65219_INT_LDO1_RV_SD,
> +	TPS65219_INT_LDO2_RV_SD,
> +	TPS65219_INT_LDO3_RV_SD,
> +	TPS65219_INT_LDO4_RV_SD,
> +	TPS65219_INT_TIMEOUT,
> +	/* Power Button */
> +	TPS65219_INT_PB_FALLING_EDGE_DETECT,
> +	TPS65219_INT_PB_RISING_EDGE_DETECT,
> +};
> +
> +enum tps65219_regulator_id {
> +	/* DCDC's */
> +	TPS65219_BUCK_1,
> +	TPS65219_BUCK_2,
> +	TPS65219_BUCK_3,
> +	/* LDOs */
> +	TPS65219_LDO_1,
> +	TPS65219_LDO_2,
> +	TPS65219_LDO_3,
> +	TPS65219_LDO_4,
> +};
> +
> +/* Number of step-down converters available */
> +#define TPS65219_NUM_DCDC		3
> +/* Number of LDO voltage regulators available */
> +#define TPS65219_NUM_LDO		4
> +/* Number of total regulators available */
> +#define TPS65219_NUM_REGULATOR		(TPS65219_NUM_DCDC + TPS65219_NUM_LDO)
> +
> +/* Define the TPS65219 IRQ numbers */
> +enum tps65219_irqs {
> +	/* INT source registers */
> +	TPS65219_TO_RV_SD_SET_IRQ,
> +	TPS65219_RV_SET_IRQ,
> +	TPS65219_SYS_SET_IRQ,
> +	TPS65219_BUCK_1_2_SET_IRQ,
> +	TPS65219_BUCK_3_SET_IRQ,
> +	TPS65219_LDO_1_2_SET_IRQ,
> +	TPS65219_LDO_3_4_SET_IRQ,
> +	TPS65219_PB_SET_IRQ,
> +};
> +
> +/**
> + * struct tps65219 - tps65219 sub-driver chip access routines
> + *
> + * Device data may be used to access the TPS65219 chip
> + *
> + * @dev MFD device
> + * @regmap Regmap for accessing the device registers
> + * @irq_data Regmap irq data used for the irq chip
> + * @nb notifier block for the restart handler
> + */
> +struct tps65219 {
> +	struct device *dev;
> +	struct regmap *regmap;
> +
> +	struct regmap_irq_chip_data *irq_data;
> +	struct notifier_block nb;
> +};
> +
> +#endif /*  MFD_TPS65219_H */
