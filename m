Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC0A5A4F99
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiH2Otg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiH2Ote (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:49:34 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35958E4E1;
        Mon, 29 Aug 2022 07:49:32 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27TEnHIi073878;
        Mon, 29 Aug 2022 09:49:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661784557;
        bh=FoXNyfRjgjyPoCNjOb/Mvqix4kUOCCWbuQiTqN/J5/o=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=hQS5gjFUO7rYtIP5lyWpka+V3Z+m0dtbnTx8wQoH+s2HCnEweeRsjyZK1QXmQIIx6
         IPbh1ZHeLdfGw/8selep8Ock6BGHQHMrN4Elqa5pZe8JfIg5/WZ3aMTwmQPWL5B512
         5xZ1Fw7HfZMFTDG1zJykq6M7Ib8olzzYFyHSW4FY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27TEnHxX058414
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Aug 2022 09:49:17 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 29
 Aug 2022 09:49:17 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 29 Aug 2022 09:49:17 -0500
Received: from [10.250.32.193] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27TEnFqA017620;
        Mon, 29 Aug 2022 09:49:16 -0500
Message-ID: <f042acf5-aab3-5356-7656-2d55edfb29eb@ti.com>
Date:   Mon, 29 Aug 2022 09:49:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 4/6] mfd: drivers: Add TI TPS65219 PMIC support
Content-Language: en-US
To:     Markus Schneider-Pargmann <msp@baylibre.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee@kernel.org>, Tony Lindgren <tony@atomide.com>,
        <nm@ti.com>, <kristo@kernel.org>,
        Jerome Neanne <jneanne@baylibre.com>, <khilman@baylibre.com>,
        <narmstrong@baylibre.com>, <j-keerthy@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-input@vger.kernel.org>, <linux-omap@vger.kernel.org>
References: <20220825150224.826258-1-msp@baylibre.com>
 <20220825150224.826258-5-msp@baylibre.com>
 <3c802196-bd18-7caa-0a26-d3e935325e50@ti.com>
 <20220829073940.g7weogfgh3zr3u24@blmsp>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20220829073940.g7weogfgh3zr3u24@blmsp>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/22 2:39 AM, Markus Schneider-Pargmann wrote:
> Hi Andrew,
> 
> On Thu, Aug 25, 2022 at 12:14:41PM -0500, Andrew Davis wrote:
>> On 8/25/22 10:02 AM, Markus Schneider-Pargmann wrote:
> 
> ...
> 
>>> diff --git a/drivers/mfd/tps65219.c b/drivers/mfd/tps65219.c
>>> new file mode 100644
>>> index 000000000000..f3883911de37
>>> --- /dev/null
>>> +++ b/drivers/mfd/tps65219.c
> 
> ...
> 
>>> +
>>> +	sys_pwr = of_property_read_bool(tps->dev->of_node, "system-power-controller");
>>> +
>>> +	if (!sys_pwr)
>>> +		return 0;
>>
>>
>> I'm not liking these non-error short circut returns. Will lead to things getting
>> missed should they be added below this point. Prefer:
>>
>>
>> 	sys_pwr = of_property_read_bool(tps->dev->of_node, "system-power-controller");
>> 	if (sys_pwr) {
>> 		if (pm_power_off) {
>> 			dev_warn(tps->dev, "system-power-controller requested but pm_power_off function already registered\n");
>> 		} else {
>> 			tps65219_i2c_client = client;
>> 			pm_power_off = &tps65219_pm_power_off;
>> 		}
>> 	}
>>
>> 	tps65219_i2c_client = client;
>>
>> 	return 0;
>> }
> 
> Good point, I actually just changed it because of a review suggesting
> this. I will change it back.
> 
>>
>> Or even better, just drop all this "system-power-controller" stuff until we figure
>> out how we will handle it. The systems today using this PMIC will have PSCI
>> being the pm_power_off controller, so we always go down the error/warn path here.
> 
> I think I would prefer to keep the code. Once this is figured out all
> the drivers using pm_power_off will need to be updated anyways so I
> guess it's easy for this to be adjusted at that point IMHO.
> 


It is already well figured out, ARM64 processors should use PSCI to handle powerdown.
This code might be useful for other architectures sure, but this PMIC was designed
specifically for powering ARM64 SoCs.


> I could make it an info message and rephrase it a bit so it's clear that
> this is kind of expected to happen. What do you think?
> 


That's fine with me if you really want to keep this code, but I'd make
the message even quieter, maybe even a debug message, since we will
always go down this message path should we set "system-power-controller"
in DT unless we do something hacky in our evil vendor tree.. For
upstream I don't see the point.

Andrew


> Thanks,
> Markus
> 
>>
>> Andrew
>>
>>
>>> +
>>> +	if (pm_power_off) {
>>> +		dev_err(tps->dev, "system-power-controller requested but pm_power_off function already registered\n");
>>> +		return 0;
>>> +	}
>>> +
>>> +	tps65219_i2c_client = client;
>>> +	pm_power_off = &tps65219_pm_power_off;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int tps65219_remove(struct i2c_client *client)
>>> +{
>>> +	struct tps65219 *tps = i2c_get_clientdata(client);
>>> +
>>> +	if (tps65219_i2c_client == client) {
>>> +		pm_power_off = NULL;
>>> +		tps65219_i2c_client = NULL;
>>> +	}
>>> +
>>> +	return unregister_restart_handler(&tps->nb);
>>> +}
>>> +
>>> +static const struct of_device_id of_tps65219_match_table[] = {
>>> +	{ .compatible = "ti,tps65219", },
>>> +	{}
>>> +};
>>> +MODULE_DEVICE_TABLE(of, of_tps65219_match_table);
>>> +
>>> +static struct i2c_driver tps65219_driver = {
>>> +	.driver		= {
>>> +		.name	= "tps65219",
>>> +		.of_match_table = of_tps65219_match_table,
>>> +	},
>>> +	.probe_new	= tps65219_probe,
>>> +	.remove		= tps65219_remove,
>>> +};
>>> +module_i2c_driver(tps65219_driver);
>>> +
>>> +MODULE_AUTHOR("Jerome Neanne <jneanne@baylibre.com>");
>>> +MODULE_DESCRIPTION("TPS65219 power management IC driver");
>>> +MODULE_LICENSE("GPL");
>>> diff --git a/include/linux/mfd/tps65219.h b/include/linux/mfd/tps65219.h
>>> new file mode 100644
>>> index 000000000000..2c1cf92e92ac
>>> --- /dev/null
>>> +++ b/include/linux/mfd/tps65219.h
>>> @@ -0,0 +1,345 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/*
>>> + * Functions to access TPS65219 power management IC.
>>> + *
>>> + * Copyright (C) 2022 BayLibre Incorporated - https://www.baylibre.com/
>>> + */
>>> +
>>> +#ifndef MFD_TPS65219_H
>>> +#define MFD_TPS65219_H
>>> +
>>> +#include <linux/bitops.h>
>>> +#include <linux/notifier.h>
>>> +#include <linux/regulator/driver.h>
>>> +
>>> +struct regmap;
>>> +struct regmap_irq_chip_data;
>>> +
>>> +#define TPS65219_1V35					1350000
>>> +#define TPS65219_1V8					1800000
>>> +
>>> +/* TPS chip id list */
>>> +#define TPS65219					0xF0
>>> +
>>> +/* I2C ID for TPS65219 part */
>>> +#define TPS65219_I2C_ID					0x24
>>> +
>>> +/* All register addresses */
>>> +#define TPS65219_REG_TI_DEV_ID				0x00
>>> +#define TPS65219_REG_NVM_ID				0x01
>>> +#define TPS65219_REG_ENABLE_CTRL			0x02
>>> +#define TPS65219_REG_BUCKS_CONFIG			0x03
>>> +#define TPS65219_REG_LDO4_VOUT				0x04
>>> +#define TPS65219_REG_LDO3_VOUT				0x05
>>> +#define TPS65219_REG_LDO2_VOUT				0x06
>>> +#define TPS65219_REG_LDO1_VOUT				0x07
>>> +#define TPS65219_REG_BUCK3_VOUT				0x8
>>> +#define TPS65219_REG_BUCK2_VOUT				0x9
>>> +#define TPS65219_REG_BUCK1_VOUT				0xA
>>> +#define TPS65219_REG_LDO4_SEQUENCE_SLOT			0xB
>>> +#define TPS65219_REG_LDO3_SEQUENCE_SLOT			0xC
>>> +#define TPS65219_REG_LDO2_SEQUENCE_SLOT			0xD
>>> +#define TPS65219_REG_LDO1_SEQUENCE_SLOT			0xE
>>> +#define TPS65219_REG_BUCK3_SEQUENCE_SLOT		0xF
>>> +#define TPS65219_REG_BUCK2_SEQUENCE_SLOT		0x10
>>> +#define TPS65219_REG_BUCK1_SEQUENCE_SLOT		0x11
>>> +#define TPS65219_REG_nRST_SEQUENCE_SLOT			0x12
>>> +#define TPS65219_REG_GPIO_SEQUENCE_SLOT			0x13
>>> +#define TPS65219_REG_GPO2_SEQUENCE_SLOT			0x14
>>> +#define TPS65219_REG_GPO1_SEQUENCE_SLOT			0x15
>>> +#define TPS65219_REG_POWER_UP_SLOT_DURATION_1		0x16
>>> +#define TPS65219_REG_POWER_UP_SLOT_DURATION_2		0x17
>>> +#define TPS65219_REG_POWER_UP_SLOT_DURATION_3		0x18
>>> +#define TPS65219_REG_POWER_UP_SLOT_DURATION_4		0x19
>>> +#define TPS65219_REG_POWER_DOWN_SLOT_DURATION_1		0x1A
>>> +#define TPS65219_REG_POWER_DOWN_SLOT_DURATION_2		0x1B
>>> +#define TPS65219_REG_POWER_DOWN_SLOT_DURATION_3		0x1C
>>> +#define TPS65219_REG_POWER_DOWN_SLOT_DURATION_4		0x1D
>>> +#define TPS65219_REG_GENERAL_CONFIG			0x1E
>>> +#define TPS65219_REG_MFP_1_CONFIG			0x1F
>>> +#define TPS65219_REG_MFP_2_CONFIG			0x20
>>> +#define TPS65219_REG_STBY_1_CONFIG			0x21
>>> +#define TPS65219_REG_STBY_2_CONFIG			0x22
>>> +#define TPS65219_REG_OC_DEGL_CONFIG			0x23
>>> +/* 'sub irq' MASK registers */
>>> +#define TPS65219_REG_INT_MASK_UV			0x24
>>> +#define TPS65219_REG_MASK_CONFIG			0x25
>>> +
>>> +#define TPS65219_REG_I2C_ADDRESS_REG			0x26
>>> +#define TPS65219_REG_USER_GENERAL_NVM_STORAGE		0x27
>>> +#define TPS65219_REG_MANUFACTURING_VER			0x28
>>> +#define TPS65219_REG_MFP_CTRL				0x29
>>> +#define TPS65219_REG_DISCHARGE_CONFIG			0x2A
>>> +/* main irq registers */
>>> +#define TPS65219_REG_INT_SOURCE				0x2B
>>> +/* 'sub irq' registers */
>>> +#define TPS65219_REG_INT_LDO_3_4			0x2C
>>> +#define TPS65219_REG_INT_LDO_1_2			0x2D
>>> +#define TPS65219_REG_INT_BUCK_3				0x2E
>>> +#define TPS65219_REG_INT_BUCK_1_2			0x2F
>>> +#define TPS65219_REG_INT_SYSTEM				0x30
>>> +#define TPS65219_REG_INT_RV				0x31
>>> +#define TPS65219_REG_INT_TIMEOUT_RV_SD			0x32
>>> +#define TPS65219_REG_INT_PB				0x33
>>> +
>>> +#define TPS65219_REG_INT_LDO_3_4_POS			0
>>> +#define TPS65219_REG_INT_LDO_1_2_POS			1
>>> +#define TPS65219_REG_INT_BUCK_3_POS			2
>>> +#define TPS65219_REG_INT_BUCK_1_2_POS			3
>>> +#define TPS65219_REG_INT_SYS_POS			4
>>> +#define TPS65219_REG_INT_RV_POS				5
>>> +#define TPS65219_REG_INT_TO_RV_POS			6
>>> +#define TPS65219_REG_INT_PB_POS				7
>>> +
>>> +#define TPS65219_REG_USER_NVM_CMD			0x34
>>> +#define TPS65219_REG_POWER_UP_STATUS			0x35
>>> +#define TPS65219_REG_SPARE_2				0x36
>>> +#define TPS65219_REG_SPARE_3				0x37
>>> +#define TPS65219_REG_FACTORY_CONFIG_2			0x41
>>> +
>>> +/* Register field definitions */
>>> +#define TPS65219_DEVID_REV_MASK				GENMASK(7, 0)
>>> +#define TPS65219_BUCKS_LDOS_VOUT_VSET_MASK		GENMASK(5, 0)
>>> +#define TPS65219_BUCKS_UV_THR_SEL_MASK			BIT(6)
>>> +#define TPS65219_BUCKS_BW_SEL_MASK			BIT(7)
>>> +#define LDO_BYP_SHIFT					6
>>> +#define TPS65219_LDOS_BYP_CONFIG_MASK			BIT(LDO_BYP_SHIFT)
>>> +#define TPS65219_LDOS_LSW_CONFIG_MASK			BIT(7)
>>> +/* Regulators enable control */
>>> +#define TPS65219_ENABLE_BUCK1_EN_MASK			BIT(0)
>>> +#define TPS65219_ENABLE_BUCK2_EN_MASK			BIT(1)
>>> +#define TPS65219_ENABLE_BUCK3_EN_MASK			BIT(2)
>>> +#define TPS65219_ENABLE_LDO1_EN_MASK			BIT(3)
>>> +#define TPS65219_ENABLE_LDO2_EN_MASK			BIT(4)
>>> +#define TPS65219_ENABLE_LDO3_EN_MASK			BIT(5)
>>> +#define TPS65219_ENABLE_LDO4_EN_MASK			BIT(6)
>>> +/* power ON-OFF sequence slot */
>>> +#define TPS65219_BUCKS_LDOS_SEQUENCE_OFF_SLOT_MASK	GENMASK(3, 0)
>>> +#define TPS65219_BUCKS_LDOS_SEQUENCE_ON_SLOT_MASK	GENMASK(7, 4)
>>> +/* TODO: Not needed, same mapping as TPS65219_ENABLE_REGNAME_EN, factorize */
>>> +#define TPS65219_STBY1_BUCK1_STBY_EN_MASK		BIT(0)
>>> +#define TPS65219_STBY1_BUCK2_STBY_EN_MASK		BIT(1)
>>> +#define TPS65219_STBY1_BUCK3_STBY_EN_MASK		BIT(2)
>>> +#define TPS65219_STBY1_LDO1_STBY_EN_MASK		BIT(3)
>>> +#define TPS65219_STBY1_LDO2_STBY_EN_MASK		BIT(4)
>>> +#define TPS65219_STBY1_LDO3_STBY_EN_MASK		BIT(5)
>>> +#define TPS65219_STBY1_LDO4_STBY_EN_MASK		BIT(6)
>>> +/* STBY_2 config */
>>> +#define TPS65219_STBY2_GPO1_STBY_EN_MASK		BIT(0)
>>> +#define TPS65219_STBY2_GPO2_STBY_EN_MASK		BIT(1)
>>> +#define TPS65219_STBY2_GPIO_STBY_EN_MASK		BIT(2)
>>> +/* MFP Control */
>>> +#define TPS65219_MFP_I2C_OFF_REQ_MASK			BIT(0)
>>> +#define TPS65219_MFP_STBY_I2C_CTRL_MASK			BIT(1)
>>> +#define TPS65219_MFP_COLD_RESET_I2C_CTRL_MASK		BIT(2)
>>> +#define TPS65219_MFP_WARM_RESET_I2C_CTRL_MASK		BIT(3)
>>> +#define TPS65219_MFP_GPIO_STATUS_MASK			BIT(4)
>>> +/* MFP_1 Config */
>>> +#define TPS65219_MFP_1_VSEL_DDR_SEL_MASK		BIT(0)
>>> +#define TPS65219_MFP_1_VSEL_SD_POL_MASK			BIT(1)
>>> +#define TPS65219_MFP_1_VSEL_RAIL_MASK			BIT(2)
>>> +/* MFP_2 Config */
>>> +#define TPS65219_MFP_2_MODE_STBY_MASK			GENMASK(1, 0)
>>> +#define TPS65219_MFP_2_MODE_RESET_MASK			BIT(2)
>>> +#define TPS65219_MFP_2_EN_PB_VSENSE_DEGL_MASK		BIT(3)
>>> +#define TPS65219_MFP_2_EN_PB_VSENSE_MASK		GENMASK(5, 4)
>>> +#define TPS65219_MFP_2_WARM_COLD_RESET_MASK		BIT(6)
>>> +#define TPS65219_MFP_2_PU_ON_FSD_MASK			BIT(7)
>>> +#define TPS65219_MFP_2_EN				0
>>> +#define TPS65219_MFP_2_PB				BIT(4)
>>> +#define TPS65219_MFP_2_VSENSE				BIT(5)
>>> +/* MASK_UV Config */
>>> +#define TPS65219_REG_MASK_UV_LDO1_UV_MASK		BIT(0)
>>> +#define TPS65219_REG_MASK_UV_LDO2_UV_MASK		BIT(1)
>>> +#define TPS65219_REG_MASK_UV_LDO3_UV_MASK		BIT(2)
>>> +#define TPS65219_REG_MASK_UV_LDO4_UV_MASK		BIT(3)
>>> +#define TPS65219_REG_MASK_UV_BUCK1_UV_MASK		BIT(4)
>>> +#define TPS65219_REG_MASK_UV_BUCK2_UV_MASK		BIT(5)
>>> +#define TPS65219_REG_MASK_UV_BUCK3_UV_MASK		BIT(6)
>>> +#define TPS65219_REG_MASK_UV_RETRY_MASK			BIT(7)
>>> +/* MASK Config */
>>> +// SENSOR_N_WARM_MASK already defined in Thermal
>>> +#define TPS65219_REG_MASK_INT_FOR_RV_MASK		BIT(4)
>>> +#define TPS65219_REG_MASK_EFFECT_MASK			GENMASK(2, 1)
>>> +#define TPS65219_REG_MASK_INT_FOR_PB_MASK		BIT(7)
>>> +/* UnderVoltage - Short to GND - OverCurrent*/
>>> +/* LDO3-4 */
>>> +#define TPS65219_INT_LDO3_SCG_MASK			BIT(0)
>>> +#define TPS65219_INT_LDO3_OC_MASK			BIT(1)
>>> +#define TPS65219_INT_LDO3_UV_MASK			BIT(2)
>>> +#define TPS65219_INT_LDO4_SCG_MASK			BIT(3)
>>> +#define TPS65219_INT_LDO4_OC_MASK			BIT(4)
>>> +#define TPS65219_INT_LDO4_UV_MASK			BIT(5)
>>> +/* LDO1-2 */
>>> +#define TPS65219_INT_LDO1_SCG_MASK			BIT(0)
>>> +#define TPS65219_INT_LDO1_OC_MASK			BIT(1)
>>> +#define TPS65219_INT_LDO1_UV_MASK			BIT(2)
>>> +#define TPS65219_INT_LDO2_SCG_MASK			BIT(3)
>>> +#define TPS65219_INT_LDO2_OC_MASK			BIT(4)
>>> +#define TPS65219_INT_LDO2_UV_MASK			BIT(5)
>>> +/* BUCK3 */
>>> +#define TPS65219_INT_BUCK3_SCG_MASK			BIT(0)
>>> +#define TPS65219_INT_BUCK3_OC_MASK			BIT(1)
>>> +#define TPS65219_INT_BUCK3_NEG_OC_MASK			BIT(2)
>>> +#define TPS65219_INT_BUCK3_UV_MASK			BIT(3)
>>> +/* BUCK1-2 */
>>> +#define TPS65219_INT_BUCK1_SCG_MASK			BIT(0)
>>> +#define TPS65219_INT_BUCK1_OC_MASK			BIT(1)
>>> +#define TPS65219_INT_BUCK1_NEG_OC_MASK			BIT(2)
>>> +#define TPS65219_INT_BUCK1_UV_MASK			BIT(3)
>>> +#define TPS65219_INT_BUCK2_SCG_MASK			BIT(4)
>>> +#define TPS65219_INT_BUCK2_OC_MASK			BIT(5)
>>> +#define TPS65219_INT_BUCK2_NEG_OC_MASK			BIT(6)
>>> +#define TPS65219_INT_BUCK2_UV_MASK			BIT(7)
>>> +/* Thermal Sensor  */
>>> +#define TPS65219_INT_SENSOR_3_WARM_MASK			BIT(0)
>>> +#define TPS65219_INT_SENSOR_2_WARM_MASK			BIT(1)
>>> +#define TPS65219_INT_SENSOR_1_WARM_MASK			BIT(2)
>>> +#define TPS65219_INT_SENSOR_0_WARM_MASK			BIT(3)
>>> +#define TPS65219_INT_SENSOR_3_HOT_MASK			BIT(4)
>>> +#define TPS65219_INT_SENSOR_2_HOT_MASK			BIT(5)
>>> +#define TPS65219_INT_SENSOR_1_HOT_MASK			BIT(6)
>>> +#define TPS65219_INT_SENSOR_0_HOT_MASK			BIT(7)
>>> +/* Residual Voltage */
>>> +#define TPS65219_INT_BUCK1_RV_MASK			BIT(0)
>>> +#define TPS65219_INT_BUCK2_RV_MASK			BIT(1)
>>> +#define TPS65219_INT_BUCK3_RV_MASK			BIT(2)
>>> +#define TPS65219_INT_LDO1_RV_MASK			BIT(3)
>>> +#define TPS65219_INT_LDO2_RV_MASK			BIT(4)
>>> +#define TPS65219_INT_LDO3_RV_MASK			BIT(5)
>>> +#define TPS65219_INT_LDO4_RV_MASK			BIT(6)
>>> +/* Residual Voltage ShutDown */
>>> +#define TPS65219_INT_BUCK1_RV_SD_MASK			BIT(0)
>>> +#define TPS65219_INT_BUCK2_RV_SD_MASK			BIT(1)
>>> +#define TPS65219_INT_BUCK3_RV_SD_MASK			BIT(2)
>>> +#define TPS65219_INT_LDO1_RV_SD_MASK			BIT(3)
>>> +#define TPS65219_INT_LDO2_RV_SD_MASK			BIT(4)
>>> +#define TPS65219_INT_LDO3_RV_SD_MASK			BIT(5)
>>> +#define TPS65219_INT_LDO4_RV_SD_MASK			BIT(6)
>>> +#define TPS65219_INT_TIMEOUT_MASK			BIT(7)
>>> +/* Power Button */
>>> +#define TPS65219_INT_PB_FALLING_EDGE_DETECT_MASK	BIT(0)
>>> +#define TPS65219_INT_PB_RISING_EDGE_DETECT_MASK		BIT(1)
>>> +#define TPS65219_INT_PB_REAL_TIME_STATUS_MASK		BIT(2)
>>> +
>>> +#define TPS65219_PB_POS					7
>>> +#define TPS65219_TO_RV_POS				6
>>> +#define TPS65219_RV_POS					5
>>> +#define TPS65219_SYS_POS				4
>>> +#define TPS65219_BUCK_1_2_POS				3
>>> +#define TPS65219_BUCK_3_POS				2
>>> +#define TPS65219_LDO_1_2_POS				1
>>> +#define TPS65219_LDO_3_4_POS				0
>>> +
>>> +/* IRQs */
>>> +enum {
>>> +	/* LDO3-4 register IRQs */
>>> +	TPS65219_INT_LDO3_SCG,
>>> +	TPS65219_INT_LDO3_OC,
>>> +	TPS65219_INT_LDO3_UV,
>>> +	TPS65219_INT_LDO4_SCG,
>>> +	TPS65219_INT_LDO4_OC,
>>> +	TPS65219_INT_LDO4_UV,
>>> +	/* LDO1-2 */
>>> +	TPS65219_INT_LDO1_SCG,
>>> +	TPS65219_INT_LDO1_OC,
>>> +	TPS65219_INT_LDO1_UV,
>>> +	TPS65219_INT_LDO2_SCG,
>>> +	TPS65219_INT_LDO2_OC,
>>> +	TPS65219_INT_LDO2_UV,
>>> +	/* BUCK3 */
>>> +	TPS65219_INT_BUCK3_SCG,
>>> +	TPS65219_INT_BUCK3_OC,
>>> +	TPS65219_INT_BUCK3_NEG_OC,
>>> +	TPS65219_INT_BUCK3_UV,
>>> +	/* BUCK1-2 */
>>> +	TPS65219_INT_BUCK1_SCG,
>>> +	TPS65219_INT_BUCK1_OC,
>>> +	TPS65219_INT_BUCK1_NEG_OC,
>>> +	TPS65219_INT_BUCK1_UV,
>>> +	TPS65219_INT_BUCK2_SCG,
>>> +	TPS65219_INT_BUCK2_OC,
>>> +	TPS65219_INT_BUCK2_NEG_OC,
>>> +	TPS65219_INT_BUCK2_UV,
>>> +	/* Thermal Sensor  */
>>> +	TPS65219_INT_SENSOR_3_WARM,
>>> +	TPS65219_INT_SENSOR_2_WARM,
>>> +	TPS65219_INT_SENSOR_1_WARM,
>>> +	TPS65219_INT_SENSOR_0_WARM,
>>> +	TPS65219_INT_SENSOR_3_HOT,
>>> +	TPS65219_INT_SENSOR_2_HOT,
>>> +	TPS65219_INT_SENSOR_1_HOT,
>>> +	TPS65219_INT_SENSOR_0_HOT,
>>> +	/* Residual Voltage */
>>> +	TPS65219_INT_BUCK1_RV,
>>> +	TPS65219_INT_BUCK2_RV,
>>> +	TPS65219_INT_BUCK3_RV,
>>> +	TPS65219_INT_LDO1_RV,
>>> +	TPS65219_INT_LDO2_RV,
>>> +	TPS65219_INT_LDO3_RV,
>>> +	TPS65219_INT_LDO4_RV,
>>> +	/* Residual Voltage ShutDown */
>>> +	TPS65219_INT_BUCK1_RV_SD,
>>> +	TPS65219_INT_BUCK2_RV_SD,
>>> +	TPS65219_INT_BUCK3_RV_SD,
>>> +	TPS65219_INT_LDO1_RV_SD,
>>> +	TPS65219_INT_LDO2_RV_SD,
>>> +	TPS65219_INT_LDO3_RV_SD,
>>> +	TPS65219_INT_LDO4_RV_SD,
>>> +	TPS65219_INT_TIMEOUT,
>>> +	/* Power Button */
>>> +	TPS65219_INT_PB_FALLING_EDGE_DETECT,
>>> +	TPS65219_INT_PB_RISING_EDGE_DETECT,
>>> +};
>>> +
>>> +enum tps65219_regulator_id {
>>> +	/* DCDC's */
>>> +	TPS65219_BUCK_1,
>>> +	TPS65219_BUCK_2,
>>> +	TPS65219_BUCK_3,
>>> +	/* LDOs */
>>> +	TPS65219_LDO_1,
>>> +	TPS65219_LDO_2,
>>> +	TPS65219_LDO_3,
>>> +	TPS65219_LDO_4,
>>> +};
>>> +
>>> +/* Number of step-down converters available */
>>> +#define TPS65219_NUM_DCDC		3
>>> +/* Number of LDO voltage regulators available */
>>> +#define TPS65219_NUM_LDO		4
>>> +/* Number of total regulators available */
>>> +#define TPS65219_NUM_REGULATOR		(TPS65219_NUM_DCDC + TPS65219_NUM_LDO)
>>> +
>>> +/* Define the TPS65219 IRQ numbers */
>>> +enum tps65219_irqs {
>>> +	/* INT source registers */
>>> +	TPS65219_TO_RV_SD_SET_IRQ,
>>> +	TPS65219_RV_SET_IRQ,
>>> +	TPS65219_SYS_SET_IRQ,
>>> +	TPS65219_BUCK_1_2_SET_IRQ,
>>> +	TPS65219_BUCK_3_SET_IRQ,
>>> +	TPS65219_LDO_1_2_SET_IRQ,
>>> +	TPS65219_LDO_3_4_SET_IRQ,
>>> +	TPS65219_PB_SET_IRQ,
>>> +};
>>> +
>>> +/**
>>> + * struct tps65219 - tps65219 sub-driver chip access routines
>>> + *
>>> + * Device data may be used to access the TPS65219 chip
>>> + *
>>> + * @dev MFD device
>>> + * @regmap Regmap for accessing the device registers
>>> + * @irq_data Regmap irq data used for the irq chip
>>> + * @nb notifier block for the restart handler
>>> + */
>>> +struct tps65219 {
>>> +	struct device *dev;
>>> +	struct regmap *regmap;
>>> +
>>> +	struct regmap_irq_chip_data *irq_data;
>>> +	struct notifier_block nb;
>>> +};
>>> +
>>> +#endif /*  MFD_TPS65219_H */
