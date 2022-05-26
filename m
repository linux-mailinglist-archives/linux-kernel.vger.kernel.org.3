Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAA55350E3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 16:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244732AbiEZOmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 10:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238154AbiEZOmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 10:42:01 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF45CC156;
        Thu, 26 May 2022 07:41:59 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 7E6601F4577D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653576117;
        bh=vAFw8+2qPZ+c4Cprg32SSa269UWt67TgyN1vuKY+TrQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=h8SGmDH83pnNejNfrEdvI9tgD/OeT1C4WW9gP8F/0OBxiU5P7ohfOuPXTXfPLUHXy
         szGfoMwT85K++zq3BHveQw4QYv5IdVhxatGEOtobWmqmvYvoM5ov83EyvaTR6fhHwq
         fQxrG+9jcj+5DDGZpRmYmozhmZw1nXMhau+VogHwWlgrjtWExEqtHrAVujHZ7W8xDI
         hj3raBk9L2igDghl4I5K53SWajkHm9oB5cGGVbFZO62k5NKZTWbSPPKjf5R2iRWiOd
         Sgr7Zlc73NtbahH/gP6WqFFnbFBbPMq9nM36G1v5gPjyXfCRU+miavxd5F+nX1HBqF
         uhVoL90IDU+VQ==
Message-ID: <64fcc07e-e4b7-823c-2c5f-078e090e95fc@collabora.com>
Date:   Thu, 26 May 2022 16:41:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v7 3/6] thermal: mediatek: Add LVTS drivers for SoC
 theraml zones
Content-Language: en-US
To:     Alexandre Bailon <abailon@baylibre.com>, rafael@kernel.org,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, Michael Kao <michael.kao@mediatek.com>,
        Yu-Chia Chang <ethan.chang@mediatek.com>,
        Ben Tseng <ben.tseng@mediatek.com>
References: <20220524152552.246193-1-abailon@baylibre.com>
 <20220524152552.246193-4-abailon@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220524152552.246193-4-abailon@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 24/05/22 17:25, Alexandre Bailon ha scritto:
> From: Michael Kao <michael.kao@mediatek.com>
> 
> Add a LVTS (Low voltage thermal sensor) driver to report junction
> temperatures in Mediatek SoC and register the maximum temperature
> of sensors and each sensor as a thermal zone.
> 
> Signed-off-by: Yu-Chia Chang <ethan.chang@mediatek.com>
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>

Hello Alexandre,
thanks for the patch! However, there are a few things to improve...

First, a very important issue to uncover:

The MediaTek SVS driver's iospace conflicts with this driver, at least
for the LVTS-1 instance:

SVS iospace:    0x1100bc00, length 0x400
LVTS-1 iospace: 0x1100b000, length 0x1000

The main issue resides in the fact that the SVS driver reads registers
before and after THERMINTST (but not THERMINTST itself), for now it's
only about INTST (at 0x1100bf08), but more are defined in that driver
and I really expect them to be used sooner or later.

There are multiple solutions to this, from defining two iospaces, where
one is start->svs, one is only including THERMINTST... or a syscon, but
the issue with this would be that we wouldn't be able to mix writel() and
writel_relaxed(), as regmap doesn't support this kind of mix (it's either
always or never relaxed).


Also, this driver should register only one LVTS sensor - and then register
(with the aid of devicetrees) multiple driver instances, one for each LVTS
sensor.... check my dt-bindings comment for that.

> ---
>   drivers/thermal/mediatek/Kconfig         |   10 +
>   drivers/thermal/mediatek/Makefile        |    1 +
>   drivers/thermal/mediatek/soc_temp.c      |    2 +-
>   drivers/thermal/mediatek/soc_temp_lvts.c | 1261 ++++++++++++++++++++++
>   drivers/thermal/mediatek/soc_temp_lvts.h |  304 ++++++
>   5 files changed, 1577 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/thermal/mediatek/soc_temp_lvts.c
>   create mode 100644 drivers/thermal/mediatek/soc_temp_lvts.h
> 
> diff --git a/drivers/thermal/mediatek/Kconfig b/drivers/thermal/mediatek/Kconfig
> index 592c849b9fed..4839aefeacb3 100644
> --- a/drivers/thermal/mediatek/Kconfig
> +++ b/drivers/thermal/mediatek/Kconfig
> @@ -20,4 +20,14 @@ config MTK_SOC_THERMAL
>   	  configures thermal controllers to collect temperature
>   	  via AUXADC interface.
>   
> +config MTK_SOC_THERMAL_LVTS
> +        tristate "LVTS (Low voltage thermal sensor) driver for Mediatek SoCs"
> +        depends on HAS_IOMEM
> +        depends on NVMEM
> +        depends on RESET_TI_SYSCON
> +        help
> +          Enable this option if you want to get SoC temperature
> +          information for MediaTek platforms. This driver
> +          configures LVTS thermal controllers to collect temperatures
> +          via Analog Serial Interface(ASIF).
>   endif
> diff --git a/drivers/thermal/mediatek/Makefile b/drivers/thermal/mediatek/Makefile
> index f75313ddce5e..16ce166e5916 100644
> --- a/drivers/thermal/mediatek/Makefile
> +++ b/drivers/thermal/mediatek/Makefile
> @@ -1 +1,2 @@
>   obj-$(CONFIG_MTK_SOC_THERMAL)	+= soc_temp.o
> +obj-$(CONFIG_MTK_SOC_THERMAL_LVTS)	+= soc_temp_lvts.o
> diff --git a/drivers/thermal/mediatek/soc_temp.c b/drivers/thermal/mediatek/soc_temp.c
> index 79d592f3f60d..4ed78bbadd62 100644
> --- a/drivers/thermal/mediatek/soc_temp.c
> +++ b/drivers/thermal/mediatek/soc_temp.c
> @@ -23,7 +23,7 @@
>   #include <linux/reset.h>
>   #include <linux/types.h>
>   
> -#include "thermal_hwmon.h"
> +#include "../thermal_hwmon.h"
>   
>   /* AUXADC Registers */
>   #define AUXADC_CON1_SET_V	0x008
> diff --git a/drivers/thermal/mediatek/soc_temp_lvts.c b/drivers/thermal/mediatek/soc_temp_lvts.c
> new file mode 100644
> index 000000000000..4b8c4c419f8e
> --- /dev/null
> +++ b/drivers/thermal/mediatek/soc_temp_lvts.c
> @@ -0,0 +1,1261 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020 MediaTek Inc.
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/thermal.h>
> +#include "soc_temp_lvts.h"
> +
> +#define STOP_COUNTING_V4 (DEVICE_WRITE | RG_TSFM_CTRL_0 << 8 | 0x00)
> +#define SET_RG_TSFM_LPDLY_V4 (DEVICE_WRITE | RG_TSFM_CTRL_4 << 8 | 0xA6)
> +#define SET_COUNTING_WINDOW_20US1_V4 (DEVICE_WRITE | RG_TSFM_CTRL_2 << 8 | 0x00)
> +#define SET_COUNTING_WINDOW_20US2_V4 (DEVICE_WRITE | RG_TSFM_CTRL_1 << 8 | 0x20)
> +#define TSV2F_CHOP_CKSEL_AND_TSV2F_EN_V4 (DEVICE_WRITE | RG_TSV2F_CTRL_2 << 8 | 0x84)
> +#define TSBG_DEM_CKSEL_X_TSBG_CHOP_EN_V4 (DEVICE_WRITE | RG_TSV2F_CTRL_4 << 8 | 0x7C)
> +#define SET_TS_RSV_V4 (DEVICE_WRITE | RG_TSV2F_CTRL_1 << 8 | 0x8D)
> +#define SET_TS_EN_V4 (DEVICE_WRITE | RG_TSV2F_CTRL_0 << 8 | 0xF4)
> +#define TOGGLE_RG_TSV2F_VCO_RST1_V4 (DEVICE_WRITE | RG_TSV2F_CTRL_0 << 8 | 0xFC)
> +#define TOGGLE_RG_TSV2F_VCO_RST2_V4 (DEVICE_WRITE | RG_TSV2F_CTRL_0 << 8 | 0xF4)
> +
> +#define SET_LVTS_AUTO_RCK_V4 (DEVICE_WRITE | RG_TSV2F_CTRL_6 << 8 | 0x01)
> +#define SELECT_SENSOR_RCK_V4(id) (DEVICE_WRITE | RG_TSV2F_CTRL_5 << 8 | (id))
> +#define SET_DEVICE_SINGLE_MODE_V4 (DEVICE_WRITE | RG_TSFM_CTRL_3 << 8 | 0x78)
> +#define KICK_OFF_RCK_COUNTING_V4 (DEVICE_WRITE | RG_TSFM_CTRL_0 << 8 | 0x02)
> +#define SET_SENSOR_NO_RCK_V4 (DEVICE_WRITE | RG_TSV2F_CTRL_5 << 8 | 0x10)
> +#define SET_DEVICE_LOW_POWER_SINGLE_MODE_V4 (DEVICE_WRITE | RG_TSFM_CTRL_3 << 8	| 0xB8)


You can simplify these definitions a lot: you've got a lvts_write_device() helper
function that can .. help with that.
Drop DEVICE_WRITE from the definitions, add it to the lvts_write_device() function.

Also, from how I get it... DEVICE_WRITE or DEVICE_READ are definitions that will
set the required bits for I/O, and these are all in the first 16 bits of register
LVTS_CONFIG_0.... which seems to be a I/O wrapper for the various registers of the
controller.

At this point, I would do *at least* something like..

           In *soc_temp_lvts.h*:
/* register definitions */
#define SCK_ONLY		BIT(31) /* you missed this definition! */
#define DEVICE_ADDRESS		GENMASK(23, 18) /* device id for access */
#define READ_32BIT_ACCESS	BIT(17) /* ..and this one too */
#define DEVICE_REG_INDEX	GENMASK(15, 8) /* Register index */
#define DEVICE_REG_DATA		GENMASK(7, 0)  /* Data to write @ register */

/* helper macros */
#define DEVICE_ACCESS	(SCK_ONLY | CK26M_ACTIVE | DEVICE_ACCESS_START)
#define DEVICE_READ	(DEVICE_ACCESS | READ_32BIT_ACCESS)
#define DEVICE_WRITE	(DEVICE_ACCESS | READ_32BIT_ACCESS | WRITE_ACCESS)

         In * this file * :
#define GET_BASE_ADDR(lvts_data, tc)	<---- Don't enforce variable names!!!!!!!!

static void lvts_write_device(....)
{
	void __iomem *base = GET_BASE_ADDR(lvts_data, tc_id);

	writel(DEVICE_WRITE | data, base + LVTS_CONFIG_0);
}

...same for read_device.


*************** BUT! ***************

Since the register has DEVICE_REG_DATA in 7:0:
  1. Why are you hardcoding the data to write to these registers!?
  2. What is that data? I see only magic numbers, if something stops working, or
     doesn't work as expected, this driver is going to be a maintenance HELL...


> +
> +#define ENABLE_FEATURE(feature)		(lvts_data->feature_bitmap |= (feature))
> +#define DISABLE_FEATURE(feature)	(lvts_data->feature_bitmap &= (~(feature)))
> +#define IS_ENABLE(feature)		(lvts_data->feature_bitmap & (feature))

IS_ENABLE => HAS_FEATURE

> +
> +#define DISABLE_THERMAL_HW_REBOOT (-274000)
> +
> +#define CLOCK_26MHZ_CYCLE_NS	(38)
> +#define BUS_ACCESS_US		(2)
> +
> +#define FEATURE_DEVICE_AUTO_RCK	(BIT(0))
> +#define FEATURE_CK26M_ACTIVE	(BIT(1))
> +#define CK26M_ACTIVE   (((lvts_data->feature_bitmap & FEATURE_CK26M_ACTIVE)    \
> +			? 1 : 0) << 30)

Do *NOT* hardcode variable names in macros!!!!!! This means that all functions that
will use these macros *need to* have a variable with that name, and that it also
has to be the struct that you expect. Just NO!

> +#define GET_BASE_ADDR(tc_id)	\
> +	(lvts_data->domain[lvts_data->tc[tc_id].domain_index].base	\
> +	+ lvts_data->tc[tc_id].addr_offset)
> +

Do **NOT** hardcode variable names in macros!!!!!!

> +#define SET_TC_SPEED_IN_US(pu, gd, fd, sd) \
> +	{	\
> +		.period_unit = (((pu) * 1000) / (256 * CLOCK_26MHZ_CYCLE_NS)),	\
> +		.group_interval_delay = ((gd) / (pu)),	\
> +		.filter_interval_delay = ((fd) / (pu)),	\
> +		.sensor_interval_delay = ((sd) / (pu)),	\
> +	}
> +
> +#define GET_CAL_DATA_BITMASK(index, h, l)	\
> +	(((index) < lvts_data->num_efuse_addr)	\
> +	? ((lvts_data->efuse[(index)] & GENMASK(h, l)) >> l)	\
> +	: 0)
> +

Do ***NOT*** hardcode variable names in macros!!!!!!

> +#define GET_CAL_DATA_BIT(index, bit)	\
> +	(((index) < lvts_data->num_efuse_addr)	\
> +	? ((lvts_data->efuse[index] & BIT(bit)) >> (bit))	\
> +	: 0)
> +

Do ****NOT**** hardcode variable names in macros!!!!!!

> +#define GET_TC_SENSOR_NUM(tc_id)	\
> +	(lvts_data->tc[tc_id].num_sensor)
> +

Do... N.. :-)

> +#define ONE_SAMPLE (lvts_data->counting_window_us + 2 * BUS_ACCESS_US)
> +
> +#define NUM_OF_SAMPLE(tc_id)	\
> +	((lvts_data->tc[tc_id].hw_filter < LVTS_FILTER_2) ? 1 :	\
> +	((lvts_data->tc[tc_id].hw_filter > LVTS_FILTER_16_OF_18) ? 1 :	\
> +	((lvts_data->tc[tc_id].hw_filter == LVTS_FILTER_16_OF_18) ? 18 :\
> +	((lvts_data->tc[tc_id].hw_filter == LVTS_FILTER_8_OF_10) ? 10 :	\
> +	(lvts_data->tc[tc_id].hw_filter * 2)))))
> +
> +#define PERIOD_UNIT_US(tc_id)	\
> +	((lvts_data->tc[tc_id].tc_speed.period_unit * 256 *	\
> +	CLOCK_26MHZ_CYCLE_NS) / 1000)
> +#define FILTER_INT_US(tc_id)	\
> +	(lvts_data->tc[tc_id].tc_speed.filter_interval_delay	\
> +	* PERIOD_UNIT_US(tc_id))
> +#define SENSOR_INT_US(tc_id)	\
> +	(lvts_data->tc[tc_id].tc_speed.sensor_interval_delay	\
> +	* PERIOD_UNIT_US(tc_id))
> +#define GROUP_INT_US(tc_id)	\
> +	(lvts_data->tc[tc_id].tc_speed.group_interval_delay	\
> +	* PERIOD_UNIT_US(tc_id))
> +
> +#define SENSOR_LATENCY_US(tc_id) \
> +	((NUM_OF_SAMPLE(tc_id) - 1) * FILTER_INT_US(tc_id)	\
> +	+ NUM_OF_SAMPLE(tc_id) * ONE_SAMPLE)
> +
> +#define GROUP_LATENCY_US(tc_id)	\
> +	(GET_TC_SENSOR_NUM(tc_id) * SENSOR_LATENCY_US(tc_id)	\
> +	+ (GET_TC_SENSOR_NUM(tc_id) - 1) * SENSOR_INT_US(tc_id)	\
> +	+ GROUP_INT_US(tc_id))
> +
> +static int lvts_raw_to_temp(struct formula_coeff *co, unsigned int msr_raw)
> +{
> +	/* This function returns degree mC */
> +
> +	int temp;
> +
> +	temp = (co->a * ((unsigned long long)msr_raw)) >> 14;
> +	temp = temp + co->golden_temp * 500 + co->b;
> +
> +	return temp;
> +}
> +
> +static unsigned int lvts_temp_to_raw(struct formula_coeff *co, int temp)
> +{
> +	unsigned int msr_raw;
> +
> +	msr_raw = div_s64((s64)((co->golden_temp * 500 + co->b - temp)) << 14,
> +			 (-1 * co->a));
> +
> +	return msr_raw;
> +}
> +
> +static int soc_temp_lvts_read_temp(void *data, int *temperature)
> +{
> +	struct soc_temp_tz *lvts_tz = (struct soc_temp_tz *)data;
> +	struct lvts_data *lvts_data = lvts_tz->lvts_data;
> +	unsigned int msr_raw;
> +
> +	msr_raw = readl(lvts_data->reg[lvts_tz->id]) & MRS_RAW_MASK;
> +	if (msr_raw == 0)
> +		return -EINVAL;
> +
> +	*temperature = lvts_raw_to_temp(&lvts_data->coeff, msr_raw);
> +
> +	return 0;
> +}
> +
> +static const struct thermal_zone_of_device_ops soc_temp_lvts_ops = {
> +	.get_temp = soc_temp_lvts_read_temp,
> +};
> +
> +static void lvts_write_device(struct lvts_data *lvts_data, unsigned int data,
> +			      int tc_id)
> +{
> +	void __iomem *base;
> +
> +	base = GET_BASE_ADDR(tc_id);
> +
> +	writel(data, LVTS_CONFIG_0 + base);
> +
> +	usleep_range(5, 15);
> +}
> +
> +static unsigned int lvts_read_device(struct lvts_data *lvts_data,
> +				     unsigned int reg_idx, int tc_id)
> +{
> +	struct device *dev = lvts_data->dev;
> +	void __iomem *base;
> +	unsigned int data;
> +	int ret;
> +
> +	base = GET_BASE_ADDR(tc_id);
> +	writel(READ_DEVICE_REG(reg_idx), LVTS_CONFIG_0 + base);
> +
> +	ret = readl_poll_timeout(LVTS_CONFIG_0 + base, data,
> +				 !(data & DEVICE_ACCESS_STARTUS),
> +				 2, 200);
> +	if (ret)
> +		dev_err(dev,
> +			"Error: LVTS %d DEVICE_ACCESS_START didn't ready\n", tc_id);
> +
> +	data = readl(LVTSRDATA0_0 + base);
> +
> +	return data;
> +}
> +
> +static void wait_all_tc_sensing_point_idle(struct lvts_data *lvts_data)
> +{
> +	struct device *dev = lvts_data->dev;
> +	unsigned int mask, error_code, is_error;
> +	void __iomem *base;
> +	int i, cnt, ret;
> +
> +	mask = BIT(10) | BIT(7) | BIT(0);
> +
> +	for (cnt = 0; cnt < 2; cnt++) {
> +		is_error = 0;
> +		for (i = 0; i < lvts_data->num_tc; i++) {
> +			base = GET_BASE_ADDR(i);
> +			ret = readl_poll_timeout(LVTSMSRCTL1_0 + base, error_code,
> +						 !(error_code & mask), 2, 200);
> +			/*
> +			 * Error code
> +			 * 000: IDLE
> +			 * 001: Write transaction
> +			 * 010: Waiting for read after Write
> +			 * 011: Disable Continue fetching on Device
> +			 * 100: Read transaction
> +			 * 101: Set Device special Register for Voltage threshold
> +			 * 111: Set TSMCU number for Fetch
> +			 */

enum lvts_error_codes {
	IDLE = 0,
	ERR_WR_TRANSACTION,
	ERR_DEV_CNTFETCH_DIS,
	ERR_RD_TRANSACTION,
	......
};

static const char * const lvts_error_table[] = all error codes in strings here.


> +			error_code = ((error_code & BIT(10)) >> 8) +
> +				((error_code & BIT(7)) >> 6) +
> +				(error_code & BIT(0));
> +
> +			if (ret)
> +				dev_err(dev,
> +					"Error LVTS %d sensing points aren't idle, error_code %d\n",
> +					i, error_code);

				dev_err(dev, "LVTS %d error: %s\n",
					lvts_error_table[error_code]);

... that works better.

> +
> +			if (error_code != 0)
> +				is_error = 1;
> +		}
> +
> +		if (is_error == 0)
> +			break;
> +	}
> +}
> +


..snip..

> +
> +static void set_hw_filter(struct lvts_data *lvts_data, int tc_id)
> +{
> +	struct device *dev = lvts_data->dev;
> +	const struct tc_settings *tc = lvts_data->tc;
> +	unsigned int option;
> +	void __iomem *base;
> +
> +	base = GET_BASE_ADDR(tc_id);
> +	option = tc[tc_id].hw_filter & 0x7;
> +	/*
> +	 * hw filter
> +	 * 000: Get one sample
> +	 * 001: Get 2 samples and average them
> +	 * 010: Get 4 samples, drop max and min, then average the rest of 2 samples
> +	 * 011: Get 6 samples, drop max and min, then average the rest of 4 samples
> +	 * 100: Get 10 samples, drop max and min, then average the rest of 8 samples
> +	 * 101: Get 18 samples, drop max and min, then average the rest of 16 samples
> +	 */
> +	option = (option << 9) | (option << 6) | (option << 3) | option;
> +
> +	writel(option, LVTSMSRCTL0_0 + base);
> +	dev_info(dev, "%s %d, LVTSMSRCTL0_0= 0x%x\n",
> +		 __func__, tc_id, readl(LVTSMSRCTL0_0 + base));


That's not an informative message, it's for debugging purposes, so that's a
dev_dbg().

> +}
> +

..snip..


> +
> +static int prepare_calibration_data(struct lvts_data *lvts_data)
> +{
> +	struct device *dev = lvts_data->dev;
> +	struct sensor_cal_data *cal_data = &lvts_data->cal_data;
> +	struct platform_ops *ops = &lvts_data->ops;
> +	int i, offset, size;
> +	char buffer[512];
> +
> +	cal_data->count_r = devm_kcalloc(dev, lvts_data->num_sensor,
> +					 sizeof(*cal_data->count_r), GFP_KERNEL);
> +	if (!cal_data->count_r)
> +		return -ENOMEM;
> +
> +	cal_data->count_rc = devm_kcalloc(dev, lvts_data->num_sensor,
> +					  sizeof(*cal_data->count_rc), GFP_KERNEL);
> +	if (!cal_data->count_rc)
> +		return -ENOMEM;
> +
> +	if (ops->efuse_to_cal_data)
> +		ops->efuse_to_cal_data(lvts_data);
> +
> +	cal_data->use_fake_efuse = 1;
> +	if (cal_data->golden_temp != 0) {
> +		cal_data->use_fake_efuse = 0;
> +	} else {
> +		for (i = 0; i < lvts_data->num_sensor; i++) {
> +			if (cal_data->count_r[i] != 0 ||
> +			    cal_data->count_rc[i] != 0) {
> +				cal_data->use_fake_efuse = 0;
> +				break;
> +			}
> +		}
> +	}
> +
> +	if (cal_data->use_fake_efuse) {
> +		/* It means all efuse data are equal to 0 */
> +		dev_err(dev,
> +			"[lvts_cal] This sample is not calibrated, fake !!\n");
> +
> +		cal_data->golden_temp = cal_data->default_golden_temp;
> +		for (i = 0; i < lvts_data->num_sensor; i++) {
> +			cal_data->count_r[i] = cal_data->default_count_r;
> +			cal_data->count_rc[i] = cal_data->default_count_rc;
> +		}
> +	}
> +
> +	lvts_data->coeff.golden_temp = cal_data->golden_temp;
> +
> +	dev_info(dev, "[lvts_cal] golden_temp = %d\n", cal_data->golden_temp);

This is dev_dbg() again... please recheck all prints and use the appropriate
level.

> +
> +	size = sizeof(buffer);
> +	offset = snprintf(buffer, size, "[lvts_cal] num:g_count:g_count_rc ");
> +	for (i = 0; i < lvts_data->num_sensor; i++)
> +		offset += snprintf(buffer + offset, size - offset, "%d:%d:%d ",
> +				   i, cal_data->count_r[i], cal_data->count_rc[i]);
> +
> +	buffer[offset] = '\0';
> +	dev_info(dev, "%s\n", buffer);

...and this is very annoying to see: if you want this kind of debugging, use
debugfs.

> +
> +	return 0;
> +}
> +

..snip..

> +static irqreturn_t irq_handler(int irq, void *dev_id)
> +{
> +	struct lvts_data *lvts_data = (struct lvts_data *)dev_id;
> +	struct device *dev = lvts_data->dev;
> +	const struct tc_settings *tc = lvts_data->tc;
> +	unsigned int i, *irq_bitmap;
> +	void __iomem *base;
> +
> +	irq_bitmap = kcalloc(lvts_data->num_domain, sizeof(*irq_bitmap), GFP_ATOMIC);
> +
> +	if (!irq_bitmap)
> +		return IRQ_NONE;
> +
> +	for (i = 0; i < lvts_data->num_domain; i++) {
> +		base = lvts_data->domain[i].base;
> +		irq_bitmap[i] = readl(THERMINTST + base);
> +		dev_info(dev, "%s : THERMINTST = 0x%x\n", __func__, irq_bitmap[i]);
> +	}
> +
> +	for (i = 0; i < lvts_data->num_tc; i++) {
> +		if ((irq_bitmap[tc[i].domain_index] & tc[i].irq_bit) == 0)
> +			tc_irq_handler(lvts_data, i);
> +	}
> +
> +	kfree(irq_bitmap);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int lvts_register_irq_handler(struct lvts_data *lvts_data)
> +{
> +	struct device *dev = lvts_data->dev;
> +	unsigned int i;
> +	int ret;
> +
> +	for (i = 0; i < lvts_data->num_domain; i++) {
> +		ret = devm_request_irq(dev, lvts_data->domain[i].irq_num, irq_handler,
> +				       IRQF_TRIGGER_HIGH, "mtk_lvts", lvts_data);
> +
> +		if (ret) {
> +			dev_err(dev, "Failed to register LVTS IRQ, ret %d, domain %d irq_num %d\n",
> +				ret, i, lvts_data->domain[i].irq_num);
> +			lvts_close(lvts_data);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int lvts_register_thermal_zones(struct lvts_data *lvts_data)
> +{
> +	struct device *dev = lvts_data->dev;
> +	struct thermal_zone *tzdev;
> +	struct soc_temp_tz *lvts_tz;
> +	int i, ret;
> +
> +	for (i = 0; i < lvts_data->num_sensor; i++) {
> +		lvts_tz = devm_kzalloc(dev, sizeof(*lvts_tz), GFP_KERNEL);
> +		if (!lvts_tz) {
> +			lvts_close(lvts_data);
> +			return -ENOMEM;
> +		}
> +
> +		lvts_tz->id = i;
> +		lvts_tz->lvts_data = lvts_data;
> +
> +		tzdev = devm_thermal_zone_of_sensor_register(dev, lvts_tz->id,
> +							     lvts_tz, &soc_temp_lvts_ops);
> +
> +		if (IS_ERR(tzdev)) {
> +			if (lvts_tz->id != 0)
> +				return 0;
> +
> +			ret = PTR_ERR(tzdev);
> +			dev_err(dev, "Error: Failed to register lvts tz %d, ret = %d\n",
> +				lvts_tz->id, ret);
> +			lvts_close(lvts_data);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int lvts_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct lvts_data *lvts_data;
> +	int ret;
> +
> +	lvts_data = (struct lvts_data *)of_device_get_match_data(dev);
> +
> +	if (!lvts_data)	{
> +		dev_err(dev, "Error: Failed to get lvts platform data\n");
> +		return -ENODATA;
> +	}
> +
> +	lvts_data->dev = &pdev->dev;
> +
> +	ret = of_update_lvts_data(lvts_data, pdev);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, lvts_data);
> +
> +	ret = lvts_init(lvts_data);
> +	if (ret)
> +		return ret;
> +
> +	ret = lvts_register_irq_handler(lvts_data);
> +	if (ret)
> +		return ret;
> +
> +	ret = lvts_register_thermal_zones(lvts_data);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int lvts_remove(struct platform_device *pdev)
> +{
> +	struct lvts_data *lvts_data;
> +
> +	lvts_data = (struct lvts_data *)platform_get_drvdata(pdev);
> +
> +	lvts_close(lvts_data);
> +
> +	return 0;
> +}
> +
> +static int lvts_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	struct lvts_data *lvts_data;
> +
> +	lvts_data = (struct lvts_data *)platform_get_drvdata(pdev);
> +
> +	lvts_close(lvts_data);
> +
> +	return 0;
> +}
> +
> +static int lvts_resume(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct lvts_data *lvts_data;
> +
> +	lvts_data = (struct lvts_data *)platform_get_drvdata(pdev);
> +
> +	ret = lvts_init(lvts_data);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static void device_enable_and_init_v4(struct lvts_data *lvts_data)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < lvts_data->num_tc; i++) {
> +		lvts_write_device(lvts_data, STOP_COUNTING_V4, i);
> +		lvts_write_device(lvts_data, SET_RG_TSFM_LPDLY_V4, i);
> +		lvts_write_device(lvts_data, SET_COUNTING_WINDOW_20US1_V4, i);
> +		lvts_write_device(lvts_data, SET_COUNTING_WINDOW_20US2_V4, i);
> +		lvts_write_device(lvts_data, TSV2F_CHOP_CKSEL_AND_TSV2F_EN_V4, i);
> +		lvts_write_device(lvts_data, TSBG_DEM_CKSEL_X_TSBG_CHOP_EN_V4, i);
> +		lvts_write_device(lvts_data, SET_TS_RSV_V4, i);
> +		lvts_write_device(lvts_data, SET_TS_EN_V4, i);
> +		lvts_write_device(lvts_data, TOGGLE_RG_TSV2F_VCO_RST1_V4, i);
> +		lvts_write_device(lvts_data, TOGGLE_RG_TSV2F_VCO_RST2_V4, i);
> +	}
> +
> +	lvts_data->counting_window_us = 20;
> +}
> +
> +static void device_enable_auto_rck_v4(struct lvts_data *lvts_data)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < lvts_data->num_tc; i++)
> +		lvts_write_device(lvts_data, SET_LVTS_AUTO_RCK_V4, i);
> +}
> +
> +static int device_read_count_rc_n_v4(struct lvts_data *lvts_data)
> +{
> +	/* Resistor-Capacitor Calibration */
> +	/* count_RC_N: count RC now */
> +	struct device *dev = lvts_data->dev;
> +	const struct tc_settings *tc = lvts_data->tc;
> +	struct sensor_cal_data *cal_data = &lvts_data->cal_data;
> +	unsigned int offset, size, s_index, data;
> +	void __iomem *base;
> +	int ret, i, j;
> +	char buffer[512];
> +
> +	cal_data->count_rc_now = devm_kcalloc(dev, lvts_data->num_sensor,
> +					      sizeof(*cal_data->count_rc_now), GFP_KERNEL);
> +	if (!cal_data->count_rc_now)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < lvts_data->num_tc; i++) {
> +		base = GET_BASE_ADDR(i);
> +		for (j = 0; j < tc[i].num_sensor; j++) {
> +			s_index = tc[i].sensor_map[j];
> +
> +			lvts_write_device(lvts_data, SELECT_SENSOR_RCK_V4(j), i);
> +			lvts_write_device(lvts_data, SET_DEVICE_SINGLE_MODE_V4, i);
> +			usleep_range(10, 20);
> +
> +			lvts_write_device(lvts_data, KICK_OFF_RCK_COUNTING_V4, i);
> +			usleep_range(30, 40);
> +
> +			ret = readl_poll_timeout(LVTS_CONFIG_0 + base, data,
> +						 !(data & DEVICE_SENSING_STATUS), 2, 200);
> +			if (ret)
> +				dev_err(dev,
> +					"Error: LVTS %d DEVICE_SENSING_STATUS didn't ready\n", i);
> +
> +			data = lvts_read_device(lvts_data, 0x00, i);
> +
> +			cal_data->count_rc_now[s_index] = (data & GENMASK(23, 0));
> +		}
> +
> +		/* Recover Setting for Normal Access on
> +		 * temperature fetch
> +		 */
> +		lvts_write_device(lvts_data, SET_SENSOR_NO_RCK_V4, i);
> +		lvts_write_device(lvts_data, SET_DEVICE_LOW_POWER_SINGLE_MODE_V4, i);
> +	}
> +
> +	size = sizeof(buffer);
> +	offset = snprintf(buffer, size, "[COUNT_RC_NOW] ");
> +	for (i = 0; i < lvts_data->num_sensor; i++)
> +		offset += snprintf(buffer + offset, size - offset, "%d:%d ",
> +				   i, cal_data->count_rc_now[i]);
> +
> +	buffer[offset] = '\0';
> +	dev_info(dev, "%s\n", buffer);
> +
> +	return 0;
> +}
> +
> +static void set_calibration_data_v4(struct lvts_data *lvts_data)
> +{
> +	const struct tc_settings *tc = lvts_data->tc;
> +	struct sensor_cal_data *cal_data = &lvts_data->cal_data;
> +	unsigned int i, j, s_index, e_data;
> +	void __iomem *base;
> +
> +	for (i = 0; i < lvts_data->num_tc; i++) {
> +		base = GET_BASE_ADDR(i);
> +
> +		for (j = 0; j < tc[i].num_sensor; j++) {
> +			s_index = tc[i].sensor_map[j];
> +			if (IS_ENABLE(FEATURE_DEVICE_AUTO_RCK))
> +				e_data = cal_data->count_r[s_index];
> +			else
> +				e_data = (((unsigned long long)
> +					cal_data->count_rc_now[s_index]) *
> +					cal_data->count_r[s_index]) >> 14;
> +
> +			writel(e_data, LVTSEDATA00_0 + base + 0x4 * j);
> +		}
> +	}
> +}
> +
> +static void init_controller_v4(struct lvts_data *lvts_data)
> +{
> +	struct device *dev = lvts_data->dev;
> +	unsigned int i;
> +	void __iomem *base;
> +
> +	for (i = 0; i < lvts_data->num_tc; i++) {
> +		base = GET_BASE_ADDR(i);
> +
> +		lvts_write_device(lvts_data, SET_DEVICE_LOW_POWER_SINGLE_MODE_V4, i);
> +
> +		writel(SET_SENSOR_INDEX, LVTSTSSEL_0 + base);
> +		writel(SET_CALC_SCALE_RULES, LVTSCALSCALE_0 + base);
> +
> +		set_polling_speed(lvts_data, i);
> +		set_hw_filter(lvts_data, i);
> +
> +		dev_info(dev, "lvts%d: read all %d sensors in %d us, one in %d us\n",
> +			 i, GET_TC_SENSOR_NUM(i), GROUP_LATENCY_US(i), SENSOR_LATENCY_US(i));
> +	}
> +}
> +
> +#define MT8192_NUM_LVTS (ARRAY_SIZE(mt8192_tc_settings))
> +

You don't need this definition.

> +enum mt8192_lvts_domain {
> +	MT8192_AP_DOMAIN,
> +	MT8192_MCU_DOMAIN,
> +	MT8192_NUM_DOMAIN
> +};
> +
> +enum mt8192_lvts_sensor_enum {
> +	MT8192_TS1_0,
> +	MT8192_TS1_1,
> +	MT8192_TS2_0,
> +	MT8192_TS2_1,
> +	MT8192_TS3_0,
> +	MT8192_TS3_1,
> +	MT8192_TS3_2,
> +	MT8192_TS3_3,
> +	MT8192_TS4_0,
> +	MT8192_TS4_1,
> +	MT8192_TS5_0,
> +	MT8192_TS5_1,
> +	MT8192_TS6_0,
> +	MT8192_TS6_1,
> +	MT8192_TS7_0,
> +	MT8192_TS7_1,
> +	MT8192_TS7_2,
> +	MT8192_NUM_TS
> +};
> +
> +static void mt8192_efuse_to_cal_data(struct lvts_data *lvts_data)
> +{
> +	struct sensor_cal_data *cal_data = &lvts_data->cal_data;
> +
> +	cal_data->golden_temp = GET_CAL_DATA_BITMASK(0, 31, 24);
> +	cal_data->count_r[MT8192_TS1_0] = GET_CAL_DATA_BITMASK(1, 23, 0);
> +	cal_data->count_r[MT8192_TS1_1] = GET_CAL_DATA_BITMASK(2, 23, 0);
> +	cal_data->count_r[MT8192_TS2_0] = GET_CAL_DATA_BITMASK(3, 23, 0);
> +	cal_data->count_r[MT8192_TS2_1] = GET_CAL_DATA_BITMASK(4, 23, 0);
> +	cal_data->count_r[MT8192_TS3_0] = GET_CAL_DATA_BITMASK(5, 23, 0);
> +	cal_data->count_r[MT8192_TS3_1] = GET_CAL_DATA_BITMASK(6, 23, 0);
> +	cal_data->count_r[MT8192_TS3_2] = GET_CAL_DATA_BITMASK(7, 23, 0);
> +	cal_data->count_r[MT8192_TS3_3] = GET_CAL_DATA_BITMASK(8, 23, 0);
> +	cal_data->count_r[MT8192_TS4_0] = GET_CAL_DATA_BITMASK(9, 23, 0);
> +	cal_data->count_r[MT8192_TS4_1] = GET_CAL_DATA_BITMASK(10, 23, 0);
> +	cal_data->count_r[MT8192_TS5_0] = GET_CAL_DATA_BITMASK(11, 23, 0);
> +	cal_data->count_r[MT8192_TS5_1] = GET_CAL_DATA_BITMASK(12, 23, 0);
> +	cal_data->count_r[MT8192_TS6_0] = GET_CAL_DATA_BITMASK(13, 23, 0);
> +	cal_data->count_r[MT8192_TS6_1] = GET_CAL_DATA_BITMASK(14, 23, 0);
> +	cal_data->count_r[MT8192_TS7_0] = GET_CAL_DATA_BITMASK(15, 23, 0);
> +	cal_data->count_r[MT8192_TS7_1] = GET_CAL_DATA_BITMASK(16, 23, 0);
> +	cal_data->count_r[MT8192_TS7_2] = GET_CAL_DATA_BITMASK(17, 23, 0);

A for loop is definitely appropriate here..

> +
> +	cal_data->count_rc[MT8192_TS1_0] = GET_CAL_DATA_BITMASK(21, 23, 0);

Here it's not...

> +
> +	cal_data->count_rc[MT8192_TS2_0] = (GET_CAL_DATA_BITMASK(1, 31, 24) << 16) +
> +					   (GET_CAL_DATA_BITMASK(2, 31, 24) << 8) +
> +					    GET_CAL_DATA_BITMASK(3, 31, 24);
> +
> +	cal_data->count_rc[MT8192_TS3_0] = (GET_CAL_DATA_BITMASK(4, 31, 24) << 16) +
> +					   (GET_CAL_DATA_BITMASK(5, 31, 24) << 8) +
> +					    GET_CAL_DATA_BITMASK(6, 31, 24);
> +
> +	cal_data->count_rc[MT8192_TS4_0] = (GET_CAL_DATA_BITMASK(7, 31, 24) << 16) +
> +					   (GET_CAL_DATA_BITMASK(8, 31, 24) << 8) +
> +					    GET_CAL_DATA_BITMASK(9, 31, 24);
> +
> +	cal_data->count_rc[MT8192_TS5_0] = (GET_CAL_DATA_BITMASK(10, 31, 24) << 16) +
> +					   (GET_CAL_DATA_BITMASK(11, 31, 24) << 8) +
> +					    GET_CAL_DATA_BITMASK(12, 31, 24);
> +
> +	cal_data->count_rc[MT8192_TS6_0] = (GET_CAL_DATA_BITMASK(13, 31, 24) << 16) +
> +					   (GET_CAL_DATA_BITMASK(14, 31, 24) << 8) +
> +					    GET_CAL_DATA_BITMASK(15, 31, 24);
> +
> +	cal_data->count_rc[MT8192_TS7_0] = (GET_CAL_DATA_BITMASK(16, 31, 24) << 16) +
> +					   (GET_CAL_DATA_BITMASK(17, 31, 24) << 8) +
> +					    GET_CAL_DATA_BITMASK(18, 31, 24);

Here it's appropriate again, and like that, you won't need to use this odd macro
anymore.

> +}
> +
> +static const struct tc_settings mt8192_tc_settings[] = {
> +	[0] = {
> +		.domain_index = MT8192_MCU_DOMAIN,
> +		.addr_offset = 0x0,
> +		.num_sensor = 2,
> +		.sensor_map = {MT8192_TS1_0, MT8192_TS1_1},
> +		.tc_speed = SET_TC_SPEED_IN_US(118, 118, 118, 118),

That tc_speed is a no-go... change it to a pointer and then...

static const struct tc_settings tc_speed_mt8192 = {
	.period_unit = 12,
	.group_interval_delay = 1,
	.filter_interval_delay = 1,
	.sensor_interval_delay = 1,
};

		.tc_speed = &tc_speed_mt8192,

> +		.hw_filter = LVTS_FILTER_2_OF_4,
> +		.dominator_sensing_point = SENSING_POINT1,
> +		.hw_reboot_trip_point = 117000,
> +		.irq_bit = BIT(3),
> +	},

..snip..

> +
> +static const struct lvts_data mt8192_lvts_data = {
> +	.num_domain = MT8192_NUM_DOMAIN,
> +	.num_tc = MT8192_NUM_LVTS,
> +	.tc = mt8192_tc_settings,
> +	.num_sensor = MT8192_NUM_TS,
> +	.ops = {
> +		.efuse_to_cal_data = mt8192_efuse_to_cal_data,
> +		.device_enable_and_init = device_enable_and_init_v4,
> +		.device_enable_auto_rck = device_enable_auto_rck_v4,
> +		.device_read_count_rc_n = device_read_count_rc_n_v4,
> +		.set_cal_data = set_calibration_data_v4,
> +		.init_controller = init_controller_v4,
> +	},
> +	.feature_bitmap = FEATURE_DEVICE_AUTO_RCK,
> +	.num_efuse_addr = 22,
> +	.num_efuse_block = 1,
> +	.cal_data = {
> +		.default_golden_temp = 50,
> +		.default_count_r = 35000,
> +		.default_count_rc = 2750,
> +	},
> +	.coeff = {
> +		.a = -250460,
> +		.b = 250460,
> +	},
> +};
> +
> +static const struct of_device_id lvts_of_match[] = {
> +	{
> +		.compatible = "mediatek,mt8192-lvts",
> +		.data = (void *)&mt8192_lvts_data,

You don't need a cast to void pointer... also, this fits in one line.

> +	},
> +	{
> +	},
> +};
> +MODULE_DEVICE_TABLE(of, lvts_of_match);
> +
> +static struct platform_driver soc_temp_lvts = {
> +	.probe = lvts_probe,
> +	.remove = lvts_remove,
> +	.suspend = lvts_suspend,
> +	.resume = lvts_resume,
> +	.driver = {
> +		.name = "mtk-soc-temp-lvts",
> +		.of_match_table = lvts_of_match,
> +	},
> +};
> +
> +module_platform_driver(soc_temp_lvts);
> +MODULE_AUTHOR("Yu-Chia Chang <ethan.chang@mediatek.com>");
> +MODULE_AUTHOR("Michael Kao <michael.kao@mediatek.com>");
> +MODULE_DESCRIPTION("MediaTek soc temperature driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/thermal/mediatek/soc_temp_lvts.h b/drivers/thermal/mediatek/soc_temp_lvts.h
> new file mode 100644
> index 000000000000..8fc0d114b8d0
> --- /dev/null
> +++ b/drivers/thermal/mediatek/soc_temp_lvts.h
> @@ -0,0 +1,304 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2020 MediaTek Inc.
> + */
> +
> +#ifndef __MTK_SOC_TEMP_LVTS_H__
> +#define __MTK_SOC_TEMP_LVTS_H__
> +
> +/*
> + * LVTS HW filter settings
> + * 000: Get one sample
> + * 001: Get 2 samples and average them
> + * 010: Get 4 samples, drop max and min, then average the rest of 2 samples
> + * 011: Get 6 samples, drop max and min, then average the rest of 4 samples
> + * 100: Get 10 samples, drop max and min, then average the rest of 8 samples
> + * 101: Get 18 samples, drop max and min, then average the rest of 16 samples
> + */
> +enum lvts_hw_filter {
> +	LVTS_FILTER_1,
> +	LVTS_FILTER_2,
> +	LVTS_FILTER_2_OF_4,
> +	LVTS_FILTER_4_OF_6,
> +	LVTS_FILTER_8_OF_10,
> +	LVTS_FILTER_16_OF_18
> +};
> +
> +enum lvts_sensing_point {
> +	SENSING_POINT0,
> +	SENSING_POINT1,
> +	SENSING_POINT2,
> +	SENSING_POINT3,
> +	ALL_SENSING_POINTS
> +};
> +
> +struct lvts_data;
> +

Add documentation to this struct that explains how to calculate the params:

/**
  * struct speed_settings - blah description
  * @period_unit: ....
  * @all the vars...
  *
  * Calculation is achieved with the following equations:
  * For the period unit: (period_us * 1000) / (256 * clock_26mhz_cycle_ns)
  * For the interval delays: delay / period_us
  */

> +struct speed_settings {
> +	unsigned int period_unit;
> +	unsigned int group_interval_delay;
> +	unsigned int filter_interval_delay;
> +	unsigned int sensor_interval_delay;
> +};
> +
> +struct tc_settings {
> +	unsigned int domain_index;
> +	unsigned int addr_offset;
> +	unsigned int num_sensor;
> +	unsigned int sensor_map[ALL_SENSING_POINTS]; /* In sensor ID */
> +	struct speed_settings tc_speed;

tc_speed becomes a pointer... :)

Regards,
Angelo
