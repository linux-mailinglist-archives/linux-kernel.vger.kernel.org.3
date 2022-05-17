Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688EE52A13E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238890AbiEQMNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbiEQMNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:13:17 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BF043384;
        Tue, 17 May 2022 05:13:13 -0700 (PDT)
X-UUID: 1153ef78b21f4191a0635ca177629de1-20220517
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:f0dd820b-c63b-4e20-addd-21843a2c0d1e,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:95cc8f79-5ef6-470b-96c9-bdb8ced32786,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: 1153ef78b21f4191a0635ca177629de1-20220517
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1644999673; Tue, 17 May 2022 20:13:09 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 17 May 2022 20:13:06 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 17 May 2022 20:13:06 +0800
Message-ID: <016589bba64bde5420ed3cb151aad5e970ddb98e.camel@mediatek.com>
Subject: Re: [PATCH v6 3/7] thermal: mediatek: Add LVTS drivers for SoC
 theraml zones
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Alexandre Bailon <abailon@baylibre.com>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>, <matthias.bgg@gmail.com>,
        <p.zabel@pengutronix.de>
CC:     <devicetree@vger.kernel.org>, <daniel.lezcano@linaro.org>,
        <rafael@kernel.org>, <khilman@baylibre.com>,
        <linux-pm@vger.kernel.org>, <amitk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <michael.kao@mediatek.com>,
        <ethan.chang@mediatek.com>, <linux-mediatek@lists.infradead.org>,
        <rui.zhang@intel.com>, <ben.tseng@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>, <james.lo@mediatek.com>,
        <fan.chen@mediatek.com>, <louis.yu@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Tue, 17 May 2022 20:13:06 +0800
In-Reply-To: <20220512122433.1399802-4-abailon@baylibre.com>
References: <20220512122433.1399802-1-abailon@baylibre.com>
         <20220512122433.1399802-4-abailon@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-05-12 at 14:24 +0200, Alexandre Bailon wrote:
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
> ---
>  drivers/thermal/mediatek/Kconfig         |   10 +
>  drivers/thermal/mediatek/Makefile        |    1 +
>  drivers/thermal/mediatek/soc_temp.c      |    2 +-
>  drivers/thermal/mediatek/soc_temp_lvts.c | 1280
> ++++++++++++++++++++++
>  drivers/thermal/mediatek/soc_temp_lvts.h |  312 ++++++
>  5 files changed, 1604 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/thermal/mediatek/soc_temp_lvts.c
>  create mode 100644 drivers/thermal/mediatek/soc_temp_lvts.h
> 
> diff --git a/drivers/thermal/mediatek/Kconfig
> b/drivers/thermal/mediatek/Kconfig
> index 0351e73170b7..d716d0372e1e 100644
> --- a/drivers/thermal/mediatek/Kconfig
> +++ b/drivers/thermal/mediatek/Kconfig
> @@ -20,4 +20,14 @@ config MTK_SOC_THERMAL
>  	  configures thermal controllers to collect temperature
>  	  via AUXADC interface.
>  
> +config MTK_SOC_THERMAL_LVTS
> +        tristate "LVTS (Low voltage thermal sensor) driver for
> Mediatek SoCs"
> +        depends on HAS_IOMEM
> +        depends on NVMEM
> +        depends on RESET_TI_SYSCON
> +        help
> +          Enable this option if you want to get SoC temperature
> +          information for Mediatek platforms. This driver
> +          configures LVTS thermal controllers to collect
> temperatures
> +          via Analog Serial Interface(ASIF).
>  endif
> diff --git a/drivers/thermal/mediatek/Makefile
> b/drivers/thermal/mediatek/Makefile
> index f75313ddce5e..16ce166e5916 100644
> --- a/drivers/thermal/mediatek/Makefile
> +++ b/drivers/thermal/mediatek/Makefile
> @@ -1 +1,2 @@
>  obj-$(CONFIG_MTK_SOC_THERMAL)	+= soc_temp.o
> +obj-$(CONFIG_MTK_SOC_THERMAL_LVTS)	+= soc_temp_lvts.o

Hello Alexandre,

Sorry, please ignore the " remain the original file "mtk_thermal.c" in
previous message, I do not notice this. But I think we still need to
rename these files.

> diff --git a/drivers/thermal/mediatek/soc_temp.c
> b/drivers/thermal/mediatek/soc_temp.c
> index 79d592f3f60d..4ed78bbadd62 100644
> --- a/drivers/thermal/mediatek/soc_temp.c
> +++ b/drivers/thermal/mediatek/soc_temp.c
> @@ -23,7 +23,7 @@
>  #include <linux/reset.h>
>  #include <linux/types.h>
>  
> -#include "thermal_hwmon.h"
> +#include "../thermal_hwmon.h"
>  
>  /* AUXADC Registers */
>  #define AUXADC_CON1_SET_V	0x008
> diff --git a/drivers/thermal/mediatek/soc_temp_lvts.c
> b/drivers/thermal/mediatek/soc_temp_lvts.c
> new file mode 100644
> index 000000000000..145ddd5fe409
> --- /dev/null
> +++ b/drivers/thermal/mediatek/soc_temp_lvts.c
> @@ -0,0 +1,1280 @@
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
> +/*==================================================
> + * Definition or macro function
> + *==================================================
> + */
> +#define STOP_COUNTING_V4 (DEVICE_WRITE | RG_TSFM_CTRL_0 << 8 | 0x00)
> +#define SET_RG_TSFM_LPDLY_V4 (DEVICE_WRITE | RG_TSFM_CTRL_4 << 8 |
> 0xA6)
> +#define SET_COUNTING_WINDOW_20US1_V4 (DEVICE_WRITE | RG_TSFM_CTRL_2
> << 8 | 0x00)
> +#define SET_COUNTING_WINDOW_20US2_V4 (DEVICE_WRITE | RG_TSFM_CTRL_1
> << 8 | 0x20)
> +#define TSV2F_CHOP_CKSEL_AND_TSV2F_EN_V4 (DEVICE_WRITE |
> RG_TSV2F_CTRL_2 << 8 | 0x84)
> +#define TSBG_DEM_CKSEL_X_TSBG_CHOP_EN_V4 (DEVICE_WRITE |
> RG_TSV2F_CTRL_4 << 8 | 0x7C)
> +#define SET_TS_RSV_V4 (DEVICE_WRITE | RG_TSV2F_CTRL_1 << 8 | 0x8D)
> +#define SET_TS_EN_V4 (DEVICE_WRITE | RG_TSV2F_CTRL_0 << 8 | 0xF4)
> +#define TOGGLE_RG_TSV2F_VCO_RST1_V4 (DEVICE_WRITE | RG_TSV2F_CTRL_0
> << 8 | 0xFC)
> +#define TOGGLE_RG_TSV2F_VCO_RST2_V4 (DEVICE_WRITE | RG_TSV2F_CTRL_0
> << 8 | 0xF4)
> +
> +#define SET_LVTS_AUTO_RCK_V4 (DEVICE_WRITE | RG_TSV2F_CTRL_6 << 8 |
> 0x01)
> +#define SELECT_SENSOR_RCK_V4(id) (DEVICE_WRITE | RG_TSV2F_CTRL_5 <<
> 8 | (id))
> +#define SET_DEVICE_SINGLE_MODE_V4 (DEVICE_WRITE | RG_TSFM_CTRL_3 <<
> 8 | 0x78)
> +#define KICK_OFF_RCK_COUNTING_V4 (DEVICE_WRITE | RG_TSFM_CTRL_0 << 8
> | 0x02)
> +#define SET_SENSOR_NO_RCK_V4 (DEVICE_WRITE | RG_TSV2F_CTRL_5 << 8 |
> 0x10)
> +#define SET_DEVICE_LOW_POWER_SINGLE_MODE_V4 (DEVICE_WRITE |
> RG_TSFM_CTRL_3 << 8	| 0xB8)
> +
> +#define ENABLE_FEATURE(feature)		(lvts_data-
> >feature_bitmap |= (feature))
> +#define DISABLE_FEATURE(feature)	(lvts_data->feature_bitmap &=
> (~(feature)))
> +#define IS_ENABLE(feature)		(lvts_data->feature_bitmap &
> (feature))
> +
> +#define DISABLE_THERMAL_HW_REBOOT (-274000)
> +
> +#define CLOCK_26MHZ_CYCLE_NS	(38)
> +#define BUS_ACCESS_US		(2)
> +
> +#define FEATURE_DEVICE_AUTO_RCK	(BIT(0))
> +#define FEATURE_CK26M_ACTIVE	(BIT(1))
> +#define CK26M_ACTIVE   (((lvts_data->feature_bitmap &
> FEATURE_CK26M_ACTIVE)    \
> +			? 1 : 0) << 30)
> +#define GET_BASE_ADDR(tc_id)	\
> +	(lvts_data->domain[lvts_data->tc[tc_id].domain_index].base	
> \
> +	+ lvts_data->tc[tc_id].addr_offset)
> +
> +#define SET_TC_SPEED_IN_US(pu, gd, fd, sd) \
> +	{	\
> +		.period_unit = (((pu) * 1000) / (256 *
> CLOCK_26MHZ_CYCLE_NS)),	\
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
> +#define GET_CAL_DATA_BIT(index, bit)	\
> +	(((index) < lvts_data->num_efuse_addr)	\
> +	? ((lvts_data->efuse[index] & BIT(bit)) >> (bit))	\
> +	: 0)
> +
> +#define GET_TC_SENSOR_NUM(tc_id)	\
> +	(lvts_data->tc[tc_id].num_sensor)
> +
> +#define ONE_SAMPLE (lvts_data->counting_window_us + 2 *
> BUS_ACCESS_US)
> +
> +#define NUM_OF_SAMPLE(tc_id)	\
> +	((lvts_data->tc[tc_id].hw_filter < LVTS_FILTER_2) ? 1 :	\
> +	((lvts_data->tc[tc_id].hw_filter > LVTS_FILTER_16_OF_18) ? 1 :	
> \
> +	((lvts_data->tc[tc_id].hw_filter == LVTS_FILTER_16_OF_18) ? 18
> :\
> +	((lvts_data->tc[tc_id].hw_filter == LVTS_FILTER_8_OF_10) ? 10 :
> 	\
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
> +/*==================================================
> + * LVTS local common code
> + *==================================================
> + */
> +static int lvts_raw_to_temp(struct formula_coeff *co, unsigned int
> msr_raw)
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
> +static unsigned int lvts_temp_to_raw(struct formula_coeff *co, int
> temp)
> +{
> +	unsigned int msr_raw;
> +
> +	msr_raw = div_s64((s64)((co->golden_temp * 500 + co->b - temp))
> << 14,
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
> +static void lvts_write_device(struct lvts_data *lvts_data, unsigned
> int data,
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
> +			"Error: LVTS %d DEVICE_ACCESS_START didn't
> ready\n", tc_id);
> +
> +	data = readl(LVTSRDATA0_0 + base);
> +
> +	return data;
> +}
> +
> +static void wait_all_tc_sensing_point_idle(struct lvts_data
> *lvts_data)
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
> +			ret = readl_poll_timeout(LVTSMSRCTL1_0 + base,
> error_code,
> +						 !(error_code & mask),
> 2, 200);
> +			/*
> +			 * Error code
> +			 * 000: IDLE
> +			 * 001: Write transaction
> +			 * 010: Waiting for read after Write
> +			 * 011: Disable Continue fetching on Device
> +			 * 100: Read transaction
> +			 * 101: Set Device special Register for Voltage
> threshold
> +			 * 111: Set TSMCU number for Fetch
> +			 */
> +			error_code = ((error_code & BIT(10)) >> 8) +
> +				((error_code & BIT(7)) >> 6) +
> +				(error_code & BIT(0));
> +
> +			if (ret)
> +				dev_err(dev,
> +					"Error LVTS %d sensing points
> aren't idle, error_code %d\n",
> +					i, error_code);
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
> +static void lvts_reset(struct lvts_data *lvts_data)
> +{
> +	int i;
> +
> +	for (i = 0; i < lvts_data->num_domain; i++) {
> +		if (lvts_data->domain[i].reset)
> +			reset_control_assert(lvts_data-
> >domain[i].reset);
> +
> +		if (lvts_data->domain[i].reset)
> +			reset_control_deassert(lvts_data-
> >domain[i].reset);
> +	}
> +}
> +
> +static void device_identification(struct lvts_data *lvts_data)
> +{
> +	struct device *dev = lvts_data->dev;
> +	unsigned int i, data;
> +	void __iomem *base;
> +
> +	for (i = 0; i < lvts_data->num_tc; i++) {
> +		base = GET_BASE_ADDR(i);
> +
> +		writel(ENABLE_LVTS_CTRL_CLK, LVTSCLKEN_0 + base);
> +
> +		lvts_write_device(lvts_data, RESET_ALL_DEVICES, i);
> +
> +		lvts_write_device(lvts_data, READ_BACK_DEVICE_ID, i);
> +
> +		/* Check LVTS device ID */
> +		data = (readl(LVTS_ID_0 + base) & GENMASK(7, 0));
> +		if (data != (0x81 + i))
> +			dev_err(dev, "LVTS_TC_%d, Device ID should be
> 0x%x, but 0x%x\n",
> +				i, (0x81 + i), data);
> +	}
> +}
> +
> +static void disable_all_sensing_points(struct lvts_data *lvts_data)
> +{
> +	unsigned int i;
> +	void __iomem *base;
> +
> +	for (i = 0; i < lvts_data->num_tc; i++) {
> +		base = GET_BASE_ADDR(i);
> +		writel(DISABLE_SENSING_POINT, LVTSMONCTL0_0 + base);
> +	}
> +}
> +
> +static void enable_all_sensing_points(struct lvts_data *lvts_data)
> +{
> +	struct device *dev = lvts_data->dev;
> +	struct tc_settings *tc = lvts_data->tc;
> +	unsigned int i, num;
> +	void __iomem *base;
> +
> +	for (i = 0; i < lvts_data->num_tc; i++) {
> +		base = GET_BASE_ADDR(i);
> +		num = tc[i].num_sensor;
> +
> +		if (num > ALL_SENSING_POINTS) {
> +			dev_err(dev,
> +				"%s, LVTS%d, illegal number of sensors:
> %d\n",
> +				__func__, i, tc[i].num_sensor);
> +			continue;
> +		}
> +
> +		writel(ENABLE_SENSING_POINT(num), LVTSMONCTL0_0 +
> base);
> +	}
> +}
> +
> +static void set_polling_speed(struct lvts_data *lvts_data, int
> tc_id)
> +{
> +	struct device *dev = lvts_data->dev;
> +	struct tc_settings *tc = lvts_data->tc;
> +	unsigned int lvts_mon_ctl_1, lvts_mon_ctl_2;
> +	void __iomem *base;
> +
> +	base = GET_BASE_ADDR(tc_id);
> +
> +	lvts_mon_ctl_1 = ((tc[tc_id].tc_speed.group_interval_delay <<
> 20) & GENMASK(29, 20)) |
> +			(tc[tc_id].tc_speed.period_unit & GENMASK(9,
> 0));
> +	lvts_mon_ctl_2 = ((tc[tc_id].tc_speed.filter_interval_delay <<
> 16) & GENMASK(25, 16)) |
> +			(tc[tc_id].tc_speed.sensor_interval_delay &
> GENMASK(9, 0));
> +	/*
> +	 * Clock source of LVTS thermal controller is 26MHz.
> +	 * Period unit is a base for all interval delays
> +	 * All interval delays must multiply it to convert a setting to
> time.
> +	 * Filter interval delay is a delay between two samples of the
> same sensor
> +	 * Sensor interval delay is a delay between two samples of
> differnet sensors
> +	 * Group interval delay is a delay between different rounds.
> +	 * For example:
> +	 *     If Period unit = C, filter delay = 1, sensor delay = 2,
> group delay = 1,
> +	 *     and two sensors, TS1 and TS2, are in a LVTS thermal
> controller
> +	 *     and then
> +	 *     Period unit = C * 1/26M * 256 = 12 * 38.46ns * 256 =
> 118.149us
> +	 *     Filter interval delay = 1 * Period unit = 118.149us
> +	 *     Sensor interval delay = 2 * Period unit = 236.298us
> +	 *     Group interval delay = 1 * Period unit = 118.149us
> +	 *
> +	 *     TS1    TS1 ... TS1    TS2    TS2 ... TS2    TS1...
> +	 *        <--> Filter interval delay
> +	 *                       <--> Sensor interval delay
> +	 *                                             <--> Group
> interval delay
> +	 */
> +	writel(lvts_mon_ctl_1, LVTSMONCTL1_0 + base);
> +	writel(lvts_mon_ctl_2, LVTSMONCTL2_0 + base);
> +
> +	dev_info(dev, "%s %d, LVTSMONCTL1_0= 0x%x,LVTSMONCTL2_0=
> 0x%x\n",
> +		 __func__, tc_id, readl(LVTSMONCTL1_0 + base),
> +		 readl(LVTSMONCTL2_0 + base));
> +}
> +
> +static void set_hw_filter(struct lvts_data *lvts_data, int tc_id)
> +{
> +	struct device *dev = lvts_data->dev;
> +	struct tc_settings *tc = lvts_data->tc;
> +	unsigned int option;
> +	void __iomem *base;
> +
> +	base = GET_BASE_ADDR(tc_id);
> +	option = tc[tc_id].hw_filter & 0x7;
> +	/* hw filter
> +	 * 000: Get one sample
> +	 * 001: Get 2 samples and average them
> +	 * 010: Get 4 samples, drop max and min, then average the rest
> of 2 samples
> +	 * 011: Get 6 samples, drop max and min, then average the rest
> of 4 samples
> +	 * 100: Get 10 samples, drop max and min, then average the rest
> of 8 samples
> +	 * 101: Get 18 samples, drop max and min, then average the rest
> of 16 samples
> +	 */
> +	option = (option << 9) | (option << 6) | (option << 3) |
> option;
> +
> +	writel(option, LVTSMSRCTL0_0 + base);
> +	dev_info(dev, "%s %d, LVTSMSRCTL0_0= 0x%x\n",
> +		 __func__, tc_id, readl(LVTSMSRCTL0_0 + base));
> +}
> +
> +static int get_dominator_index(struct lvts_data *lvts_data, int
> tc_id)
> +{
> +	struct device *dev = lvts_data->dev;
> +	struct tc_settings *tc = lvts_data->tc;
> +	int d_index;
> +
> +	if (tc[tc_id].dominator_sensing_point == ALL_SENSING_POINTS) {
> +		d_index = ALL_SENSING_POINTS;
> +	} else if (tc[tc_id].dominator_sensing_point <
> +		tc[tc_id].num_sensor){
> +		d_index = tc[tc_id].dominator_sensing_point;
> +	} else {
> +		dev_err(dev,
> +			"Error: LVTS%d, dominator_sensing_point= %d
> should smaller than num_sensor= %d\n",
> +			tc_id, tc[tc_id].dominator_sensing_point,
> +			tc[tc_id].num_sensor);
> +
> +		dev_err(dev, "Use the sensing point 0 as the dominated
> sensor\n");
> +		d_index = SENSING_POINT0;
> +	}
> +
> +	return d_index;
> +}
> +
> +static void disable_hw_reboot_interrupt(struct lvts_data *lvts_data,
> int tc_id)
> +{
> +	unsigned int temp;
> +	void __iomem *base;
> +
> +	base = GET_BASE_ADDR(tc_id);
> +
> +	/* LVTS thermal controller has two interrupts for thermal HW
> reboot
> +	 * One is for AP SW and the other is for RGU
> +	 * The interrupt of AP SW can turn off by a bit of a register,
> but
> +	 * the other for RGU cannot.
> +	 * To prevent rebooting device accidentally, we are going to
> add
> +	 * a huge offset to LVTS and make LVTS always report extremely
> low
> +	 * temperature.
> +	 */
> +
> +	/* After adding the huge offset 0x3FFF, LVTS alawys adds the
> +	 * offset to MSR_RAW.
> +	 * When MSR_RAW is larger, SW will convert lower temperature/
> +	 */
> +	temp = readl(LVTSPROTCTL_0 + base);
> +	writel(temp | 0x3FFF, LVTSPROTCTL_0 + base);
> +
> +	/* Disable the interrupt of AP SW */
> +	temp = readl(LVTSMONINT_0 + base);
> +	writel(temp & ~(STAGE3_INT_EN), LVTSMONINT_0 + base);
> +}
> +
> +static void enable_hw_reboot_interrupt(struct lvts_data *lvts_data,
> int tc_id)
> +{
> +	unsigned int temp;
> +	void __iomem *base;
> +
> +	base = GET_BASE_ADDR(tc_id);
> +
> +	/* Enable the interrupt of AP SW */
> +	temp = readl(LVTSMONINT_0 + base);
> +	writel(temp | STAGE3_INT_EN, LVTSMONINT_0 + base);
> +	/* Clear the offset */
> +	temp = readl(LVTSPROTCTL_0 + base);
> +	writel(temp & ~PROTOFFSET, LVTSPROTCTL_0 + base);
> +}
> +
> +static void set_tc_hw_reboot_threshold(struct lvts_data *lvts_data,
> +				       int trip_point, int tc_id)
> +{
> +	struct device *dev = lvts_data->dev;
> +	unsigned int msr_raw, temp, config, d_index;
> +	void __iomem *base;
> +
> +	base = GET_BASE_ADDR(tc_id);
> +	d_index = get_dominator_index(lvts_data, tc_id);
> +
> +	dev_info(dev, "%s: LVTS%d, the dominator sensing point= %d\n",
> +		 __func__, tc_id, d_index);
> +
> +	disable_hw_reboot_interrupt(lvts_data, tc_id);
> +
> +	temp = readl(LVTSPROTCTL_0 + base);
> +	if (d_index == ALL_SENSING_POINTS) {
> +		/* Maximum of 4 sensing points */
> +		config = (0x1 << 16);
> +		writel(config | temp, LVTSPROTCTL_0 + base);
> +	} else {
> +		/* Select protection sensor */
> +		config = ((d_index << 2) + 0x2) << 16;
> +		writel(config | temp, LVTSPROTCTL_0 + base);
> +	}
> +
> +	msr_raw = lvts_temp_to_raw(&lvts_data->coeff, trip_point);
> +	writel(msr_raw, LVTSPROTTC_0 + base);
> +
> +	enable_hw_reboot_interrupt(lvts_data, tc_id);
> +}
> +
> +static void set_all_tc_hw_reboot(struct lvts_data *lvts_data)
> +{
> +	struct tc_settings *tc = lvts_data->tc;
> +	int i, trip_point;
> +
> +	for (i = 0; i < lvts_data->num_tc; i++) {
> +		trip_point = tc[i].hw_reboot_trip_point;
> +
> +		if (tc[i].num_sensor == 0)
> +			continue;
> +
> +		if (trip_point == DISABLE_THERMAL_HW_REBOOT)
> +			continue;
> +
> +		set_tc_hw_reboot_threshold(lvts_data, trip_point, i);
> +	}
> +}
> +
> +static int lvts_init(struct lvts_data *lvts_data)
> +{
> +	struct platform_ops *ops = &lvts_data->ops;
> +	struct device *dev = lvts_data->dev;
> +	int ret;
> +
> +	ret = clk_prepare_enable(lvts_data->clk);
> +	if (ret) {
> +		dev_err(dev,
> +			"Error: Failed to enable lvts controller clock:
> %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	lvts_reset(lvts_data);
> +
> +	device_identification(lvts_data);
> +	if (ops->device_enable_and_init)
> +		ops->device_enable_and_init(lvts_data);
> +
> +	if (IS_ENABLE(FEATURE_DEVICE_AUTO_RCK)) {
> +		if (ops->device_enable_auto_rck)
> +			ops->device_enable_auto_rck(lvts_data);
> +	} else {
> +		if (ops->device_read_count_rc_n)
> +			ops->device_read_count_rc_n(lvts_data);
> +	}
> +
> +	if (ops->set_cal_data)
> +		ops->set_cal_data(lvts_data);
> +
> +	disable_all_sensing_points(lvts_data);
> +	wait_all_tc_sensing_point_idle(lvts_data);
> +	if (ops->init_controller)
> +		ops->init_controller(lvts_data);
> +	enable_all_sensing_points(lvts_data);
> +
> +	set_all_tc_hw_reboot(lvts_data);
> +
> +	return 0;
> +}
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
> +					 sizeof(*cal_data->count_r),
> GFP_KERNEL);
> +	if (!cal_data->count_r)
> +		return -ENOMEM;
> +
> +	cal_data->count_rc = devm_kcalloc(dev, lvts_data->num_sensor,
> +					  sizeof(*cal_data->count_rc),
> GFP_KERNEL);
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
> +			"[lvts_cal] This sample is not calibrated, fake
> !!\n");
> +
> +		cal_data->golden_temp = cal_data->default_golden_temp;
> +		for (i = 0; i < lvts_data->num_sensor; i++) {
> +			cal_data->count_r[i] = cal_data-
> >default_count_r;
> +			cal_data->count_rc[i] = cal_data-
> >default_count_rc;
> +		}
> +	}
> +
> +	lvts_data->coeff.golden_temp = cal_data->golden_temp;
> +
> +	dev_info(dev, "[lvts_cal] golden_temp = %d\n", cal_data-
> >golden_temp);
> +
> +	size = sizeof(buffer);
> +	offset = snprintf(buffer, size, "[lvts_cal]
> num:g_count:g_count_rc ");
> +	for (i = 0; i < lvts_data->num_sensor; i++)
> +		offset += snprintf(buffer + offset, size - offset,
> "%d:%d:%d ",
> +				   i, cal_data->count_r[i], cal_data-
> >count_rc[i]);
> +
> +	buffer[offset] = '\0';
> +	dev_info(dev, "%s\n", buffer);
> +
> +	return 0;
> +}
> +
> +static int get_calibration_data(struct lvts_data *lvts_data)
> +{
> +	struct device *dev = lvts_data->dev;
> +	char cell_name[8];
> +	struct nvmem_cell *cell;
> +	u32 *buf;
> +	size_t len;
> +	int i, j, index = 0, ret;
> +
> +	lvts_data->efuse = devm_kcalloc(dev, lvts_data->num_efuse_addr,
> +					sizeof(*lvts_data->efuse),
> GFP_KERNEL);
> +	if (!lvts_data->efuse)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < lvts_data->num_efuse_block; i++) {
> +		snprintf(cell_name, sizeof(cell_name), "e_data%d", i +
> 1);
> +		cell = nvmem_cell_get(dev, cell_name);
> +		if (IS_ERR(cell)) {
> +			dev_err(dev, "Error: Failed to get nvmem cell
> %s\n", cell_name);
> +			return PTR_ERR(cell);
> +		}
> +
> +		buf = (u32 *)nvmem_cell_read(cell, &len);
> +		nvmem_cell_put(cell);
> +
> +		if (IS_ERR(buf))
> +			return PTR_ERR(buf);
> +
> +		for (j = 0; j < (len / sizeof(u32)); j++) {
> +			if (index >= lvts_data->num_efuse_addr) {
> +				dev_err(dev, "Array efuse is going to
> overflow");
> +				kfree(buf);
> +				return -EINVAL;
> +			}
> +
> +			lvts_data->efuse[index] = buf[j];
> +			index++;
> +		}
> +
> +		kfree(buf);
> +	}
> +
> +	ret = prepare_calibration_data(lvts_data);
> +
> +	return ret;
> +}
> +
> +static int lvts_init_tc_regs(struct device *dev, struct lvts_data
> *lvts_data)
> +{
> +	struct tc_settings *tc = lvts_data->tc;
> +	unsigned int i, j, s_index;
> +	void __iomem *base;
> +
> +	lvts_data->reg = devm_kcalloc(dev, lvts_data->num_sensor,
> +					   sizeof(*lvts_data->reg),
> GFP_KERNEL);
> +	if (!lvts_data->reg)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < lvts_data->num_tc; i++) {
> +		base = GET_BASE_ADDR(i);
> +		for (j = 0; j < tc[i].num_sensor; j++) {
> +			s_index = tc[i].sensor_map[j];
> +			lvts_data->reg[s_index] = LVTSMSR0_0 + base +
> 0x4 * j;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int of_update_lvts_data(struct lvts_data *lvts_data,
> +			       struct platform_device *pdev)
> +{
> +	struct device *dev = lvts_data->dev;
> +	struct power_domain *domain;
> +	struct resource *res;
> +	unsigned int i;
> +	int ret;
> +
> +	lvts_data->clk = devm_clk_get(dev, "lvts_clk");
> +	if (IS_ERR(lvts_data->clk))
> +		return PTR_ERR(lvts_data->clk);
> +
> +	domain = devm_kcalloc(dev, lvts_data->num_domain,
> sizeof(*domain), GFP_KERNEL);
> +	if (!domain)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < lvts_data->num_domain; i++) {
> +		/* Get base address */
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
> +		if (!res) {
> +			dev_err(dev, "No IO resource, index %d\n", i);
> +			return -ENXIO;
> +		}
> +
> +		domain[i].base = devm_ioremap_resource(dev, res);
> +		if (IS_ERR(domain[i].base)) {
> +			dev_err(dev, "Failed to remap io, index %d\n",
> i);
> +			return PTR_ERR(domain[i].base);
> +		}
> +
> +		/* Get interrupt number */
> +		res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
> +		if (!res) {
> +			dev_err(dev, "No irq resource, index %d\n", i);
> +			return -EINVAL;
> +		}
> +		domain[i].irq_num = res->start;
> +
> +		/* Get reset control */
> +		domain[i].reset = devm_reset_control_get_by_index(dev,
> i);

For this, we don;t use ti reset, so we can not get the reset by this
function.

I implement another series for mtk reset[1].
Please refer to the modification for MT8186 to get the reset
controller[2].

[1]:
https://patchwork.kernel.org/project/linux-mediatek/list/?series=637849
[2]:
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/3593597

> +		if (IS_ERR(domain[i].reset)) {
> +			dev_err(dev, "Failed to get, index %d\n", i);
> +			return PTR_ERR(domain[i].reset);
> +		}
> +	}
> +
> +	lvts_data->domain = domain;
> +
> +	ret = lvts_init_tc_regs(dev, lvts_data);
> +	if (ret)
> +		return ret;
> +
> +	ret = get_calibration_data(lvts_data);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static void lvts_device_close(struct lvts_data *lvts_data)
> +{
> +	unsigned int i;
> +	void __iomem *base;
> +
> +	for (i = 0; i < lvts_data->num_tc; i++) {
> +		base = GET_BASE_ADDR(i);
> +		lvts_write_device(lvts_data, RESET_ALL_DEVICES, i);
> +		writel(DISABLE_LVTS_CTRL_CLK, LVTSCLKEN_0 + base);
> +	}
> +}
> +
> +static void lvts_close(struct lvts_data *lvts_data)
> +{
> +	disable_all_sensing_points(lvts_data);
> +	wait_all_tc_sensing_point_idle(lvts_data);
> +	lvts_device_close(lvts_data);
> +	clk_disable_unprepare(lvts_data->clk);
> +}
> +
> +static void tc_irq_handler(struct lvts_data *lvts_data, int tc_id)
> +{
> +	struct device *dev = lvts_data->dev;
> +	unsigned int ret = 0;
> +	void __iomem *base;
> +
> +	base = GET_BASE_ADDR(tc_id);
> +
> +	ret = readl(LVTSMONINTSTS_0 + base);
> +	/* Write back to clear interrupt status */
> +	writel(ret, LVTSMONINTSTS_0 + base);
> +
> +	dev_info(dev, "[Thermal IRQ] LVTS thermal controller %d,
> LVTSMONINTSTS=0x%08x\n",
> +		 tc_id, ret);
> +
> +	if (ret & THERMAL_PROTECTION_STAGE_3)
> +		dev_info(dev,
> +			 "[Thermal IRQ]: Thermal protection stage 3
> interrupt triggered\n");
> +}
> +
> +static irqreturn_t irq_handler(int irq, void *dev_id)
> +{
> +	struct lvts_data *lvts_data = (struct lvts_data *)dev_id;
> +	struct device *dev = lvts_data->dev;
> +	struct tc_settings *tc = lvts_data->tc;
> +	unsigned int i, *irq_bitmap;
> +	void __iomem *base;
> +
> +	irq_bitmap = kcalloc(lvts_data->num_domain,
> sizeof(*irq_bitmap), GFP_ATOMIC);
> +
> +	if (!irq_bitmap)
> +		return IRQ_NONE;
> +
> +	for (i = 0; i < lvts_data->num_domain; i++) {
> +		base = lvts_data->domain[i].base;
> +		irq_bitmap[i] = readl(THERMINTST + base);
> +		dev_info(dev, "%s : THERMINTST = 0x%x\n", __func__,
> irq_bitmap[i]);
> +	}
> +
> +	for (i = 0; i < lvts_data->num_tc; i++) {
> +		if ((irq_bitmap[tc[i].domain_index] & tc[i].irq_bit) ==
> 0)
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
> +		ret = devm_request_irq(dev, lvts_data-
> >domain[i].irq_num, irq_handler,
> +				       IRQF_TRIGGER_HIGH, "mtk_lvts",
> lvts_data);
> +
> +		if (ret) {
> +			dev_err(dev, "Failed to register LVTS IRQ, ret
> %d, domain %d irq_num %d\n",
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
> +		lvts_tz = devm_kzalloc(dev, sizeof(*lvts_tz),
> GFP_KERNEL);
> +		if (!lvts_tz) {
> +			lvts_close(lvts_data);
> +			return -ENOMEM;
> +		}
> +
> +		lvts_tz->id = i;
> +		lvts_tz->lvts_data = lvts_data;
> +
> +		tzdev = devm_thermal_zone_of_sensor_register(dev,
> lvts_tz->id,
> +							     lvts_tz,
> &soc_temp_lvts_ops);
> +
> +		if (IS_ERR(tzdev)) {
> +			if (lvts_tz->id != 0)
> +				return 0;
> +
> +			ret = PTR_ERR(tzdev);
> +			dev_err(dev, "Error: Failed to register lvts tz
> %d, ret = %d\n",
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
> +		dev_err(dev, "Error: Failed to get lvts platform
> data\n");
> +		return -ENODATA;

can we return use dev_probe_err(...)?

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
> +static int lvts_suspend(struct platform_device *pdev, pm_message_t
> state)
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
> +/*==================================================
> + * LVTS v4 common code
> + *==================================================
> + */

I don't see other version for this patch.
I think we can just use them directly?

> +static void device_enable_and_init_v4(struct lvts_data *lvts_data)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < lvts_data->num_tc; i++) {
> +		lvts_write_device(lvts_data, STOP_COUNTING_V4, i);
> +		lvts_write_device(lvts_data, SET_RG_TSFM_LPDLY_V4, i);
> +		lvts_write_device(lvts_data,
> SET_COUNTING_WINDOW_20US1_V4, i);
> +		lvts_write_device(lvts_data,
> SET_COUNTING_WINDOW_20US2_V4, i);
> +		lvts_write_device(lvts_data,
> TSV2F_CHOP_CKSEL_AND_TSV2F_EN_V4, i);
> +		lvts_write_device(lvts_data,
> TSBG_DEM_CKSEL_X_TSBG_CHOP_EN_V4, i);
> +		lvts_write_device(lvts_data, SET_TS_RSV_V4, i);
> +		lvts_write_device(lvts_data, SET_TS_EN_V4, i);
> +		lvts_write_device(lvts_data,
> TOGGLE_RG_TSV2F_VCO_RST1_V4, i);
> +		lvts_write_device(lvts_data,
> TOGGLE_RG_TSV2F_VCO_RST2_V4, i);
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
> +	struct tc_settings *tc = lvts_data->tc;
> +	struct sensor_cal_data *cal_data = &lvts_data->cal_data;
> +	unsigned int offset, size, s_index, data;
> +	void __iomem *base;
> +	int ret, i, j;
> +	char buffer[512];
> +
> +	cal_data->count_rc_now = devm_kcalloc(dev, lvts_data-
> >num_sensor,
> +					      sizeof(*cal_data-
> >count_rc_now), GFP_KERNEL);
> +	if (!cal_data->count_rc_now)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < lvts_data->num_tc; i++) {
> +		base = GET_BASE_ADDR(i);
> +		for (j = 0; j < tc[i].num_sensor; j++) {
> +			s_index = tc[i].sensor_map[j];
> +
> +			lvts_write_device(lvts_data,
> SELECT_SENSOR_RCK_V4(j), i);
> +			lvts_write_device(lvts_data,
> SET_DEVICE_SINGLE_MODE_V4, i);
> +			usleep_range(10, 20);
> +
> +			lvts_write_device(lvts_data,
> KICK_OFF_RCK_COUNTING_V4, i);
> +			usleep_range(30, 40);
> +
> +			ret = readl_poll_timeout(LVTS_CONFIG_0 + base,
> data,
> +						 !(data &
> DEVICE_SENSING_STATUS), 2, 200);
> +			if (ret)
> +				dev_err(dev,
> +					"Error: LVTS %d
> DEVICE_SENSING_STATUS didn't ready\n", i);
> +
> +			data = lvts_read_device(lvts_data, 0x00, i);
> +
> +			cal_data->count_rc_now[s_index] = (data &
> GENMASK(23, 0));
> +		}
> +
> +		/* Recover Setting for Normal Access on
> +		 * temperature fetch
> +		 */
> +		lvts_write_device(lvts_data, SET_SENSOR_NO_RCK_V4, i);
> +		lvts_write_device(lvts_data,
> SET_DEVICE_LOW_POWER_SINGLE_MODE_V4, i);
> +	}
> +
> +	size = sizeof(buffer);
> +	offset = snprintf(buffer, size, "[COUNT_RC_NOW] ");
> +	for (i = 0; i < lvts_data->num_sensor; i++)
> +		offset += snprintf(buffer + offset, size - offset,
> "%d:%d ",
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
> +	struct tc_settings *tc = lvts_data->tc;
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
> +					cal_data-
> >count_rc_now[s_index]) *
> +					cal_data->count_r[s_index]) >>
> 14;
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
> +		lvts_write_device(lvts_data,
> SET_DEVICE_LOW_POWER_SINGLE_MODE_V4, i);
> +
> +		writel(SET_SENSOR_INDEX, LVTSTSSEL_0 + base);
> +		writel(SET_CALC_SCALE_RULES, LVTSCALSCALE_0 + base);
> +
> +		set_polling_speed(lvts_data, i);
> +		set_hw_filter(lvts_data, i);
> +
> +		dev_info(dev, "lvts%d: read all %d sensors in %d us,
> one in %d us\n",
> +			 i, GET_TC_SENSOR_NUM(i), GROUP_LATENCY_US(i),
> SENSOR_LATENCY_US(i));
> +	}
> +}
> +
> +/*==================================================
> + * LVTS MT6873
> + *==================================================
> + */
> +

I think we should rename MT6873 to MT8192. MT8192 is a formal name for
upstreaming our soc even though they are the same socs.
Please rename all MT6873 to MT8192.

Thanks.

> +#define MT6873_NUM_LVTS (ARRAY_SIZE(mt6873_tc_settings))
> +
> +enum mt6873_lvts_domain {
> +	MT6873_AP_DOMAIN,
> +	MT6873_MCU_DOMAIN,
> +	MT6873_NUM_DOMAIN
> +};
> +
> +enum mt6873_lvts_sensor_enum {
> +	MT6873_TS1_0,
> +	MT6873_TS1_1,
> +	MT6873_TS2_0,
> +	MT6873_TS2_1,
> +	MT6873_TS3_0,
> +	MT6873_TS3_1,
> +	MT6873_TS3_2,
> +	MT6873_TS3_3,
> +	MT6873_TS4_0,
> +	MT6873_TS4_1,
> +	MT6873_TS5_0,
> +	MT6873_TS5_1,
> +	MT6873_TS6_0,
> +	MT6873_TS6_1,
> +	MT6873_TS7_0,
> +	MT6873_TS7_1,
> +	MT6873_TS7_2,
> +	MT6873_NUM_TS
> +};
> +
> +static void mt6873_efuse_to_cal_data(struct lvts_data *lvts_data)
> +{
> +	struct sensor_cal_data *cal_data = &lvts_data->cal_data;
> +
> +	cal_data->golden_temp = GET_CAL_DATA_BITMASK(0, 31, 24);
> +	cal_data->count_r[MT6873_TS1_0] = GET_CAL_DATA_BITMASK(1, 23,
> 0);
> +	cal_data->count_r[MT6873_TS1_1] = GET_CAL_DATA_BITMASK(2, 23,
> 0);
> +	cal_data->count_r[MT6873_TS2_0] = GET_CAL_DATA_BITMASK(3, 23,
> 0);
> +	cal_data->count_r[MT6873_TS2_1] = GET_CAL_DATA_BITMASK(4, 23,
> 0);
> +	cal_data->count_r[MT6873_TS3_0] = GET_CAL_DATA_BITMASK(5, 23,
> 0);
> +	cal_data->count_r[MT6873_TS3_1] = GET_CAL_DATA_BITMASK(6, 23,
> 0);
> +	cal_data->count_r[MT6873_TS3_2] = GET_CAL_DATA_BITMASK(7, 23,
> 0);
> +	cal_data->count_r[MT6873_TS3_3] = GET_CAL_DATA_BITMASK(8, 23,
> 0);
> +	cal_data->count_r[MT6873_TS4_0] = GET_CAL_DATA_BITMASK(9, 23,
> 0);
> +	cal_data->count_r[MT6873_TS4_1] = GET_CAL_DATA_BITMASK(10, 23,
> 0);
> +	cal_data->count_r[MT6873_TS5_0] = GET_CAL_DATA_BITMASK(11, 23,
> 0);
> +	cal_data->count_r[MT6873_TS5_1] = GET_CAL_DATA_BITMASK(12, 23,
> 0);
> +	cal_data->count_r[MT6873_TS6_0] = GET_CAL_DATA_BITMASK(13, 23,
> 0);
> +	cal_data->count_r[MT6873_TS6_1] = GET_CAL_DATA_BITMASK(14, 23,
> 0);
> +	cal_data->count_r[MT6873_TS7_0] = GET_CAL_DATA_BITMASK(15, 23,
> 0);
> +	cal_data->count_r[MT6873_TS7_1] = GET_CAL_DATA_BITMASK(16, 23,
> 0);
> +	cal_data->count_r[MT6873_TS7_2] = GET_CAL_DATA_BITMASK(17, 23,
> 0);
> +
> +	cal_data->count_rc[MT6873_TS1_0] = GET_CAL_DATA_BITMASK(21, 23,
> 0);
> +
> +	cal_data->count_rc[MT6873_TS2_0] = (GET_CAL_DATA_BITMASK(1, 31,
> 24) << 16) +
> +					   (GET_CAL_DATA_BITMASK(2, 31,
> 24) << 8) +
> +					    GET_CAL_DATA_BITMASK(3, 31,
> 24);
> +
> +	cal_data->count_rc[MT6873_TS3_0] = (GET_CAL_DATA_BITMASK(4, 31,
> 24) << 16) +
> +					   (GET_CAL_DATA_BITMASK(5, 31,
> 24) << 8) +
> +					    GET_CAL_DATA_BITMASK(6, 31,
> 24);
> +
> +	cal_data->count_rc[MT6873_TS4_0] = (GET_CAL_DATA_BITMASK(7, 31,
> 24) << 16) +
> +					   (GET_CAL_DATA_BITMASK(8, 31,
> 24) << 8) +
> +					    GET_CAL_DATA_BITMASK(9, 31,
> 24);
> +
> +	cal_data->count_rc[MT6873_TS5_0] = (GET_CAL_DATA_BITMASK(10,
> 31, 24) << 16) +
> +					   (GET_CAL_DATA_BITMASK(11,
> 31, 24) << 8) +
> +					    GET_CAL_DATA_BITMASK(12,
> 31, 24);
> +
> +	cal_data->count_rc[MT6873_TS6_0] = (GET_CAL_DATA_BITMASK(13,
> 31, 24) << 16) +
> +					   (GET_CAL_DATA_BITMASK(14,
> 31, 24) << 8) +
> +					    GET_CAL_DATA_BITMASK(15,
> 31, 24);
> +
> +	cal_data->count_rc[MT6873_TS7_0] = (GET_CAL_DATA_BITMASK(16,
> 31, 24) << 16) +
> +					   (GET_CAL_DATA_BITMASK(17,
> 31, 24) << 8) +
> +					    GET_CAL_DATA_BITMASK(18,
> 31, 24);
> +}
> +
> +static struct tc_settings mt6873_tc_settings[] = {
> +	[0] = {
> +		.domain_index = MT6873_MCU_DOMAIN,
> +		.addr_offset = 0x0,
> +		.num_sensor = 2,
> +		.sensor_map = {MT6873_TS1_0, MT6873_TS1_1},
> +		.tc_speed = SET_TC_SPEED_IN_US(118, 118, 118, 118),
> +		.hw_filter = LVTS_FILTER_2_OF_4,
> +		.dominator_sensing_point = SENSING_POINT1,
> +		.hw_reboot_trip_point = 117000,
> +		.irq_bit = BIT(3),
> +	},
> +	[1] = {
> +		.domain_index = MT6873_MCU_DOMAIN,
> +		.addr_offset = 0x100,
> +		.num_sensor = 2,
> +		.sensor_map = {MT6873_TS2_0, MT6873_TS2_1},
> +		.tc_speed = SET_TC_SPEED_IN_US(118, 118, 118, 118),
> +		.hw_filter = LVTS_FILTER_2_OF_4,
> +		.dominator_sensing_point = SENSING_POINT0,
> +		.hw_reboot_trip_point = 117000,
> +		.irq_bit = BIT(4),
> +	},
> +	[2] = {
> +		.domain_index = MT6873_MCU_DOMAIN,
> +		.addr_offset = 0x200,
> +		.num_sensor = 4,
> +		.sensor_map = {MT6873_TS3_0, MT6873_TS3_1,
> MT6873_TS3_2, MT6873_TS3_3},
> +		.tc_speed = SET_TC_SPEED_IN_US(118, 118, 118, 118),
> +		.hw_filter = LVTS_FILTER_2_OF_4,
> +		.dominator_sensing_point = SENSING_POINT0,
> +		.hw_reboot_trip_point = 117000,
> +		.irq_bit = BIT(5),
> +	},
> +	[3] = {
> +		.domain_index = MT6873_AP_DOMAIN,
> +		.addr_offset = 0x0,
> +		.num_sensor = 2,
> +		.sensor_map = {MT6873_TS4_0, MT6873_TS4_1},
> +		.tc_speed = SET_TC_SPEED_IN_US(118, 118, 118, 118),
> +		.hw_filter = LVTS_FILTER_2_OF_4,
> +		.dominator_sensing_point = SENSING_POINT0,
> +		.hw_reboot_trip_point = 117000,
> +		.irq_bit = BIT(3),
> +	},
> +	[4] = {
> +		.domain_index = MT6873_AP_DOMAIN,
> +		.addr_offset = 0x100,
> +		.num_sensor = 2,
> +		.sensor_map = {MT6873_TS5_0, MT6873_TS5_1},
> +		.tc_speed = SET_TC_SPEED_IN_US(118, 118, 118, 118),
> +		.hw_filter = LVTS_FILTER_2_OF_4,
> +		.dominator_sensing_point = SENSING_POINT1,
> +		.hw_reboot_trip_point = 117000,
> +		.irq_bit = BIT(4),
> +	},
> +	[5] = {
> +		.domain_index = MT6873_AP_DOMAIN,
> +		.addr_offset = 0x200,
> +		.num_sensor = 2,
> +		.sensor_map = {MT6873_TS6_0, MT6873_TS6_1},
> +		.tc_speed = SET_TC_SPEED_IN_US(118, 118, 118, 118),
> +		.hw_filter = LVTS_FILTER_2_OF_4,
> +		.dominator_sensing_point = SENSING_POINT1,
> +		.hw_reboot_trip_point = 117000,
> +		.irq_bit = BIT(5),
> +	},
> +	[6] = {
> +		.domain_index = MT6873_AP_DOMAIN,
> +		.addr_offset = 0x300,
> +		.num_sensor = 3,
> +		.sensor_map = {MT6873_TS7_0, MT6873_TS7_1,
> MT6873_TS7_2},
> +		.tc_speed = SET_TC_SPEED_IN_US(118, 118, 118, 118),
> +		.hw_filter = LVTS_FILTER_2_OF_4,
> +		.dominator_sensing_point = SENSING_POINT2,
> +		.hw_reboot_trip_point = 117000,
> +		.irq_bit = BIT(6),
> +	}
> +};
> +
> +static struct lvts_data mt6873_lvts_data = {
> +	.num_domain = MT6873_NUM_DOMAIN,
> +	.num_tc = MT6873_NUM_LVTS,
> +	.tc = mt6873_tc_settings,
> +	.num_sensor = MT6873_NUM_TS,
> +	.ops = {
> +		.efuse_to_cal_data = mt6873_efuse_to_cal_data,
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
> +/*==================================================
> + *==================================================
> + * Support chips
> + *==================================================
> + */
> +static const struct of_device_id lvts_of_match[] = {
> +	{
> +		.compatible = "mediatek,mt6873-lvts",
> +		.data = (void *)&mt6873_lvts_data,
> +	},
> +	{
> +	},
> +};
> +MODULE_DEVICE_TABLE(of, lvts_of_match);
> +/*==================================================*/
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
> +MODULE_DESCRIPTION("Mediatek soc temperature driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/thermal/mediatek/soc_temp_lvts.h
> b/drivers/thermal/mediatek/soc_temp_lvts.h
> new file mode 100644
> index 000000000000..77c64145aa17
> --- /dev/null
> +++ b/drivers/thermal/mediatek/soc_temp_lvts.h
> @@ -0,0 +1,312 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2020 MediaTek Inc.
> + */
> +
> +#ifndef __MTK_SOC_TEMP_LVTS_H__
> +#define __MTK_SOC_TEMP_LVTS_H__
> +
> +/* LVTS HW filter settings
> + * 000: Get one sample
> + * 001: Get 2 samples and average them
> + * 010: Get 4 samples, drop max and min, then average the rest of 2
> samples
> + * 011: Get 6 samples, drop max and min, then average the rest of 4
> samples
> + * 100: Get 10 samples, drop max and min, then average the rest of 8
> samples
> + * 101: Get 18 samples, drop max and min, then average the rest of
> 16 samples
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
> +/*==================================================
> + * Data structure
> + *==================================================
> + */
> +struct lvts_data;
> +
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
> +	/* HW filter setting
> +	 * 000: Get one sample
> +	 * 001: Get 2 samples and average them
> +	 * 010: Get 4 samples, drop max and min, then average the rest
> of 2 samples
> +	 * 011: Get 6 samples, drop max and min, then average the rest
> of 4 samples
> +	 * 100: Get 10 samples, drop max and min, then average the rest
> of 8 samples
> +	 * 101: Get 18 samples, drop max and min, then average the rest
> of 16 samples
> +	 */
> +	unsigned int hw_filter;
> +	/* Dominator_sensing point is used to select a sensing point
> +	 * and reference its temperature to trigger Thermal HW Reboot
> +	 * When it is ALL_SENSING_POINTS, it will select all sensing
> points
> +	 */
> +	int dominator_sensing_point;
> +	int hw_reboot_trip_point; /* -274000: Disable HW reboot */
> +	unsigned int irq_bit;
> +};
> +
> +struct formula_coeff {
> +	int a;
> +	int b;
> +	unsigned int golden_temp;
> +};
> +
> +struct sensor_cal_data {
> +	int use_fake_efuse;	/* 1: Use fake efuse, 0: Use real
> efuse */
> +	unsigned int golden_temp;
> +	unsigned int *count_r;
> +	unsigned int *count_rc;
> +	unsigned int *count_rc_now;
> +
> +	unsigned int default_golden_temp;
> +	unsigned int default_count_r;
> +	unsigned int default_count_rc;
> +};
> +
> +struct platform_ops {
> +	void (*efuse_to_cal_data)(struct lvts_data *lvts_data);
> +	void (*device_enable_and_init)(struct lvts_data *lvts_data);
> +	void (*device_enable_auto_rck)(struct lvts_data *lvts_data);
> +	int (*device_read_count_rc_n)(struct lvts_data *lvts_data);
> +	void (*set_cal_data)(struct lvts_data *lvts_data);
> +	void (*init_controller)(struct lvts_data *lvts_data);
> +};
> +
> +struct power_domain {
> +	void __iomem *base;	/* LVTS base addresses */
> +	unsigned int irq_num;	/* LVTS interrupt numbers */
> +	struct reset_control *reset;
> +};
> +
> +struct sensor_data {
> +	void __iomem *base;	/* Sensor base address */
> +	int offset;		/* Sensor offset */
> +};
> +
> +struct lvts_data {
> +	struct device *dev;
> +	struct clk *clk;
> +	unsigned int num_domain;
> +	struct power_domain *domain;
> +
> +	int num_tc;			/* Number of LVTS thermal
> controllers */
> +	struct tc_settings *tc;
> +	int counting_window_us;		/* LVTS device counting
> window */
> +
> +	int num_sensor;			/* Number of sensors in this
> platform */
> +	void __iomem **reg;
> +
> +	struct platform_ops ops;
> +	int feature_bitmap;		/* Show what features are
> enabled */
> +
> +	unsigned int num_efuse_addr;
> +	unsigned int *efuse;
> +	unsigned int num_efuse_block;	/* Number of contiguous efuse
> indexes */
> +	struct sensor_cal_data cal_data;
> +	struct formula_coeff coeff;
> +};
> +
> +struct soc_temp_tz {
> +	unsigned int id; /* if id is 0, get max temperature of all
> sensors */
> +	struct lvts_data *lvts_data;
> +};
> +
> +struct match_entry {
> +	char	chip[32];
> +	struct lvts_data *lvts_data;
> +};
> +
> +struct lvts_match_data {
> +	unsigned int hw_version;
> +	struct match_entry *table;
> +	void (*set_up_common_callbacks)(struct lvts_data *lvts_data);
> +	struct list_head node;
> +};
> +
> +struct lvts_id {
> +	unsigned int hw_version;
> +	char	chip[32];
> +};
> +
> +/*==================================================
> + * LVTS device register
> + *==================================================
> + */
> +#define RG_TSFM_DATA_0	0x00
> +#define RG_TSFM_DATA_1	0x01
> +#define RG_TSFM_DATA_2	0x02
> +#define RG_TSFM_CTRL_0	0x03
> +#define RG_TSFM_CTRL_1	0x04
> +#define RG_TSFM_CTRL_2	0x05
> +#define RG_TSFM_CTRL_3	0x06
> +#define RG_TSFM_CTRL_4	0x07
> +#define RG_TSV2F_CTRL_0	0x08
> +#define RG_TSV2F_CTRL_1	0x09
> +#define RG_TSV2F_CTRL_2	0x0A
> +#define RG_TSV2F_CTRL_3	0x0B
> +#define RG_TSV2F_CTRL_4	0x0C
> +#define RG_TSV2F_CTRL_5	0x0D
> +#define RG_TSV2F_CTRL_6	0x0E
> +#define RG_TEMP_DATA_0	0x10
> +#define RG_TEMP_DATA_1	0x11
> +#define RG_TEMP_DATA_2	0x12
> +#define RG_TEMP_DATA_3	0x13
> +#define RG_RC_DATA_0	0x14
> +#define RG_RC_DATA_1	0x15
> +#define RG_RC_DATA_2	0x16
> +#define RG_RC_DATA_3	0x17
> +#define RG_DIV_DATA_0	0x18
> +#define RG_DIV_DATA_1	0x19
> +#define RG_DIV_DATA_2	0x1A
> +#define RG_DIV_DATA_3	0x1B
> +#define RG_TST_DATA_0	0x70
> +#define RG_TST_DATA_1	0x71
> +#define RG_TST_DATA_2	0x72
> +#define RG_TST_CTRL	0x73
> +#define RG_DBG_FQMTR	0xF0
> +#define RG_DBG_LPSEQ	0xF1
> +#define RG_DBG_STATE	0xF2
> +#define RG_DBG_CHKSUM	0xF3
> +#define RG_DID_LVTS	0xFC
> +#define RG_DID_REV	0xFD
> +#define RG_TSFM_RST	0xFF
> +/*==================================================
> + * LVTS controller register
> + *==================================================
> + */
> +#define LVTSMONCTL0_0	0x000
> +#define LVTS_SINGLE_SENSE	BIT(9)
> +#define ENABLE_SENSING_POINT(num)	(LVTS_SINGLE_SENSE |
> GENMASK(((num) - 1), 0))
> +#define DISABLE_SENSING_POINT	(LVTS_SINGLE_SENSE | 0x0)
> +#define LVTSMONCTL1_0	0x004
> +#define LVTSMONCTL2_0	0x008
> +#define LVTSMONINT_0	0x00C
> +#define STAGE3_INT_EN	BIT(31)
> +#define LVTSMONINTSTS_0	0x010
> +#define LVTSMONIDET0_0	0x014
> +#define LVTSMONIDET1_0	0x018
> +#define LVTSMONIDET2_0	0x01C
> +#define LVTSMONIDET3_0	0x020
> +#define LVTSH2NTHRE_0	0x024
> +#define LVTSHTHRE_0	0x028
> +#define LVTSCTHRE_0	0x02C
> +#define LVTSOFFSETH_0	0x030
> +#define LVTSOFFSETL_0	0x034
> +#define LVTSMSRCTL0_0	0x038
> +#define LVTSMSRCTL1_0	0x03C
> +#define LVTSTSSEL_0	0x040
> +#define SET_SENSOR_INDEX	0x13121110
> +#define LVTSDEVICETO_0	0x044
> +#define LVTSCALSCALE_0	0x048
> +#define SET_CALC_SCALE_RULES	0x00000300
> +#define LVTS_ID_0	0x04C
> +#define LVTS_CONFIG_0	0x050
> +
> +#define BROADCAST_ID_UPDATE	BIT(26)
> +#define DEVICE_SENSING_STATUS	BIT(25)
> +#define DEVICE_ACCESS_STARTUS	BIT(24)
> +#define WRITE_ACCESS		BIT(16)
> +#define DEVICE_WRITE		(BIT(31) | CK26M_ACTIVE |
> DEVICE_ACCESS_STARTUS \
> +				| BIT(17) | WRITE_ACCESS)
> +#define DEVICE_READ		(BIT(31) | CK26M_ACTIVE |
> DEVICE_ACCESS_STARTUS \
> +				| 1 << 17)
> +#define RESET_ALL_DEVICES	(DEVICE_WRITE | RG_TSFM_RST << 8 |
> 0xFF)
> +#define READ_BACK_DEVICE_ID	(BIT(31) | CK26M_ACTIVE |
> BROADCAST_ID_UPDATE	\
> +				| DEVICE_ACCESS_STARTUS | BIT(17)	\
> +				| RG_DID_LVTS << 8)
> +#define READ_DEVICE_REG(reg_idx)	(DEVICE_READ | (reg_idx) << 8 |
> 0x00)
> +#define LVTSEDATA00_0	0x054
> +#define LVTSEDATA01_0	0x058
> +#define LVTSEDATA02_0	0x05C
> +#define LVTSEDATA03_0	0x060
> +#define LVTSMSR0_0	0x090
> +#define MRS_RAW_MASK		GENMASK(15, 0)
> +#define MRS_RAW_VALID_BIT	BIT(16)
> +#define LVTSMSR1_0	0x094
> +#define LVTSMSR2_0	0x098
> +#define LVTSMSR3_0	0x09C
> +#define LVTSIMMD0_0	0x0A0
> +#define LVTSIMMD1_0	0x0A4
> +#define LVTSIMMD2_0	0x0A8
> +#define LVTSIMMD3_0	0x0AC
> +#define LVTSRDATA0_0	0x0B0
> +#define LVTSRDATA1_0	0x0B4
> +#define LVTSRDATA2_0	0x0B8
> +#define LVTSRDATA3_0	0x0BC
> +#define LVTSPROTCTL_0	0x0C0
> +#define PROTOFFSET	GENMASK(15, 0)
> +#define LVTSPROTTA_0	0x0C4
> +#define LVTSPROTTB_0	0x0C8
> +#define LVTSPROTTC_0	0x0CC
> +#define LVTSCLKEN_0	0x0E4
> +#define ENABLE_LVTS_CTRL_CLK	(1)
> +#define DISABLE_LVTS_CTRL_CLK	(0)
> +#define LVTSDBGSEL_0	0x0E8
> +#define LVTSDBGSIG_0	0x0EC
> +#define LVTSSPARE0_0	0x0F0
> +#define LVTSSPARE1_0	0x0F4
> +#define LVTSSPARE2_0	0x0F8
> +#define LVTSSPARE3_0	0x0FC
> +
> +#define THERMINTST	0xF04
> +/*==================================================
> + * LVTS register mask
> + *==================================================
> + */
> +#define THERMAL_COLD_INTERRUPT_0		0x00000001
> +#define THERMAL_HOT_INTERRUPT_0			0x00000002
> +#define THERMAL_LOW_OFFSET_INTERRUPT_0		0x00000004
> +#define THERMAL_HIGH_OFFSET_INTERRUPT_0		0x00000008
> +#define THERMAL_HOT2NORMAL_INTERRUPT_0		0x00000010
> +#define THERMAL_COLD_INTERRUPT_1		0x00000020
> +#define THERMAL_HOT_INTERRUPT_1			0x00000040
> +#define THERMAL_LOW_OFFSET_INTERRUPT_1		0x00000080
> +#define THERMAL_HIGH_OFFSET_INTERRUPT_1		0x00000100
> +#define THERMAL_HOT2NORMAL_INTERRUPT_1		0x00000200
> +#define THERMAL_COLD_INTERRUPT_2		0x00000400
> +#define THERMAL_HOT_INTERRUPT_2			0x00000800
> +#define THERMAL_LOW_OFFSET_INTERRUPT_2		0x00001000
> +#define THERMAL_HIGH_OFFSET_INTERRUPT_2		0x00002000
> +#define THERMAL_HOT2NORMAL_INTERRUPT_2		0x00004000
> +#define THERMAL_AHB_TIMEOUT_INTERRUPT		0x00008000
> +#define THERMAL_DEVICE_TIMEOUT_INTERRUPT	0x00008000
> +#define THERMAL_IMMEDIATE_INTERRUPT_0		0x00010000
> +#define THERMAL_IMMEDIATE_INTERRUPT_1		0x00020000
> +#define THERMAL_IMMEDIATE_INTERRUPT_2		0x00040000
> +#define THERMAL_FILTER_INTERRUPT_0		0x00080000
> +#define THERMAL_FILTER_INTERRUPT_1		0x00100000
> +#define THERMAL_FILTER_INTERRUPT_2		0x00200000
> +#define THERMAL_COLD_INTERRUPT_3		0x00400000
> +#define THERMAL_HOT_INTERRUPT_3			0x00800000
> +#define THERMAL_LOW_OFFSET_INTERRUPT_3		0x01000000
> +#define THERMAL_HIGH_OFFSET_INTERRUPT_3		0x02000000
> +#define THERMAL_HOT2NORMAL_INTERRUPT_3		0x04000000
> +#define THERMAL_IMMEDIATE_INTERRUPT_3		0x08000000
> +#define THERMAL_FILTER_INTERRUPT_3		0x10000000
> +#define THERMAL_PROTECTION_STAGE_1		0x20000000
> +#define THERMAL_PROTECTION_STAGE_2		0x40000000
> +#define THERMAL_PROTECTION_STAGE_3		0x80000000
> +#endif /* __MTK_SOC_TEMP_LVTS_H__ */

