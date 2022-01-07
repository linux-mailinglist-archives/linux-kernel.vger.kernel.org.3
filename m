Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC4C48790F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347851AbiAGOeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347880AbiAGOeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:34:07 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0635C06173E;
        Fri,  7 Jan 2022 06:34:06 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E37361F45FD4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641566045;
        bh=X9ST1U3jQknSUjIu6aMdDzRiKeTrHNPc1c8i2C8L4B4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=h1Iz/82bo/LY7H2+i6dHhsELE94Wt8alNEPGB3XSJJDBJM3GNwmteXEbi12Jl2cte
         RPd44n00nNQhfKxlGFJj3v1fgI8dbjG1FfCN3LN1pAKG64P8BV78OkXVRZemaCfjdz
         xrsMzgfS48tM9cOKe1BlRMF3YwpB0R5J3rOj7npg8LauSCzupISzKSJxZf9BxOaeWs
         iPddS6ICi6z9ozjDTZRkmVA49noJ+XBJ3w8JQRNl0/gwd4WPy6EDrs/93s46Z+hlVv
         uVPDGA4TuhKrtRCob3QIHGNRuXSjj7NIFT3s+acb2X7OtHi8GI0KtgIVLuvi4/o7qr
         vrdulJvqyrDBA==
Subject: Re: [PATCH v21 4/8] soc: mediatek: SVS: add monitor mode
To:     Roger Lu <roger.lu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Guenter Roeck <linux@roeck-us.net>
References: <20220107095200.4389-1-roger.lu@mediatek.com>
 <20220107095200.4389-5-roger.lu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <e118df40-da6b-88f6-fbff-15befb3405d5@collabora.com>
Date:   Fri, 7 Jan 2022 15:34:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220107095200.4389-5-roger.lu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/01/22 10:51, Roger Lu ha scritto:
> SVS monitor mode is based on different thermal temperature
> to provide suitable SVS bank voltages.
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> ---
>   drivers/soc/mediatek/mtk-svs.c | 253 ++++++++++++++++++++++++++++++++-
>   1 file changed, 247 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index fc7e2ee44a92..042c6e8e9069 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -25,6 +25,7 @@
>   #include <linux/regulator/consumer.h>
>   #include <linux/slab.h>
>   #include <linux/spinlock.h>
> +#include <linux/thermal.h>
>   
>   /* svs bank 1-line sw id */
>   #define SVSB_CPU_LITTLE			BIT(0)
> @@ -36,6 +37,7 @@
>   #define SVSB_MODE_ALL_DISABLE		0
>   #define SVSB_MODE_INIT01		BIT(1)
>   #define SVSB_MODE_INIT02		BIT(2)
> +#define SVSB_MODE_MON			BIT(3)
>   
>   /* svs bank volt flags */
>   #define SVSB_INIT01_PD_REQ		BIT(0)
> @@ -53,11 +55,16 @@
>   #define SVSB_EN_INIT01			0x1
>   #define SVSB_EN_INIT02			0x5
>   #define SVSB_EN_MASK			0x7
> +#define SVSB_EN_MON			0x2
>   #define SVSB_EN_OFF			0x0
>   #define SVSB_INTEN_INIT0x		0x00005f01
> +#define SVSB_INTEN_MONVOPEN		0x00ff0000
>   #define SVSB_INTSTS_CLEAN		0x00ffffff
>   #define SVSB_INTSTS_COMPLETE		0x1
> +#define SVSB_INTSTS_MONVOP		0x00ff0000
>   #define SVSB_RUNCONFIG_DEFAULT		0x80000000
> +#define SVSB_TEMP_LOWER_BOUND		0xb2
> +#define SVSB_TEMP_UPPER_BOUND		0x64
>   
>   static DEFINE_SPINLOCK(svs_lock);
>   
> @@ -66,6 +73,7 @@ static DEFINE_SPINLOCK(svs_lock);
>    * @SVSB_PHASE_ERROR: svs bank encounters unexpected condition
>    * @SVSB_PHASE_INIT01: svs bank basic init for data calibration
>    * @SVSB_PHASE_INIT02: svs bank can provide voltages to opp table
> + * @SVSB_PHASE_MON: svs bank can provide voltages with thermal effect
>    * @SVSB_PHASE_MAX: total number of svs bank phase (debug purpose)
>    *
>    * Each svs bank has its own independent phase and we enable each svs bank by
> @@ -73,12 +81,13 @@ static DEFINE_SPINLOCK(svs_lock);
>    * condition, it will fire an irq (PHASE_ERROR) to inform svs software.
>    *
>    * svs bank general phase-enabled order:
> - * SVSB_PHASE_INIT01 -> SVSB_PHASE_INIT02
> + * SVSB_PHASE_INIT01 -> SVSB_PHASE_INIT02 -> SVSB_PHASE_MON
>    */
>   enum svsb_phase {
>   	SVSB_PHASE_ERROR = 0,
>   	SVSB_PHASE_INIT01,
>   	SVSB_PHASE_INIT02,
> +	SVSB_PHASE_MON,
>   	SVSB_PHASE_MAX,
>   };
>   
> @@ -209,9 +218,11 @@ static const u32 svs_regs_v2[] = {
>    * @probe: svs platform probe function pointer
>    * @irqflags: svs platform irq settings flags
>    * @efuse_max: total number of svs efuse
> + * @tefuse_max: total number of thermal efuse
>    * @regs: svs platform registers map
>    * @bank_max: total number of svs banks
>    * @efuse: svs efuse data received from NVMEM framework
> + * @tefuse: thermal efuse data received from NVMEM framework
>    */
>   struct svs_platform {
>   	char *name;
> @@ -224,9 +235,11 @@ struct svs_platform {
>   	int (*probe)(struct svs_platform *svsp);
>   	unsigned long irqflags;
>   	size_t efuse_max;
> +	size_t tefuse_max;
>   	const u32 *regs;
>   	u32 bank_max;
>   	u32 *efuse;
> +	u32 *tefuse;
>   };
>   
>   /**
> @@ -241,6 +254,7 @@ struct svs_platform {
>    * @get_volts: function pointer to get bank voltages
>    * @name: bank name
>    * @buck_name: regulator name
> + * @tzone_name: thermal zone name
>    * @suspended: suspend flag of this bank
>    * @phase: bank current phase
>    * @volt_od: bank voltage overdrive
> @@ -270,6 +284,13 @@ struct svs_platform {
>    * @sw_id: bank software identification
>    * @cpu_id: cpu core id for SVS CPU bank use only
>    * @ctl0: TS-x selection
> + * @temp: bank temperature
> + * @tzone_htemp: thermal zone high temperature threshold
> + * @tzone_htemp_voffset: thermal zone high temperature voltage offset
> + * @tzone_ltemp: thermal zone low temperature threshold
> + * @tzone_ltemp_voffset: thermal zone low temperature voltage offset
> + * @bts: svs efuse data
> + * @mts: svs efuse data
>    * @bdes: svs efuse data
>    * @mdes: svs efuse data
>    * @mtdes: svs efuse data
> @@ -292,6 +313,7 @@ struct svs_bank {
>   	void (*get_volts)(struct svs_platform *svsp);
>   	char *name;
>   	char *buck_name;
> +	char *tzone_name;
>   	bool suspended;
>   	enum svsb_phase phase;
>   	s32 volt_od;
> @@ -321,6 +343,13 @@ struct svs_bank {
>   	u32 sw_id;
>   	u32 cpu_id;
>   	u32 ctl0;
> +	u32 temp;
> +	u32 tzone_htemp;
> +	u32 tzone_htemp_voffset;
> +	u32 tzone_ltemp;
> +	u32 tzone_ltemp_voffset;
> +	u32 bts;
> +	u32 mts;
>   	u32 bdes;
>   	u32 mdes;
>   	u32 mtdes;
> @@ -361,10 +390,21 @@ static u32 svs_bank_volt_to_opp_volt(u32 svsb_volt, u32 svsb_volt_step,
>   	return (svsb_volt * svsb_volt_step) + svsb_volt_base;
>   }
>   

I'm sorry for the double review, but this went unnoticed in the previous one.

> +static int svs_get_zone_temperature(const char *tzone_name, int *tzone_temp)
> +{
> +	struct thermal_zone_device *tzd;
> +
> +	tzd = thermal_zone_get_zone_by_name(tzone_name);

This call is expensive, as it's iterating through the (possibly) entire
thermal_tz_list (drivers/thermal/thermal_core.c) so, for performance purposes,
noting that you're using this in svs_adjust_pm_opp_volts(), it's not a good idea
to call it at every ISR.

I would instead propose to get a pointer to the thermal_zone at driver probe
time and cache that in struct svs_bank: this function would also be removed
as the only thing that you'd need to do then would be just one call...

[read forward...]

> +	if (IS_ERR(tzd))
> +		return PTR_ERR(tzd);
> +
> +	return thermal_zone_get_temp(tzd, tzone_temp);
> +}
> +
>   static int svs_adjust_pm_opp_volts(struct svs_bank *svsb, bool force_update)
>   {
> -	int ret = -EPERM;
> -	u32 i, svsb_volt, opp_volt;
> +	int ret = -EPERM, tzone_temp = 0;
> +	u32 i, svsb_volt, opp_volt, temp_voffset = 0;
>   
>   	mutex_lock(&svsb->lock);
>   
> @@ -378,6 +418,22 @@ static int svs_adjust_pm_opp_volts(struct svs_bank *svsb, bool force_update)
>   		goto unlock_mutex;
>   	}
>   
> +	/* Get thermal effect */
> +	if (svsb->phase == SVSB_PHASE_MON) {
> +		ret = svs_get_zone_temperature(svsb->tzone_name, &tzone_temp);

... so you can simply call ...


	ret = thermal_zone_get_temp(svsb->tzd, tzone_temp);


...without any need for any helper.

> +		if (ret || (svsb->temp > SVSB_TEMP_UPPER_BOUND &&
> +			    svsb->temp < SVSB_TEMP_LOWER_BOUND)) {
> +			dev_err(svsb->dev, "%s: %d (0x%x), run default volts\n",
> +				svsb->tzone_name, ret, svsb->temp);
> +			svsb->phase = SVSB_PHASE_ERROR;
> +		}
> +
> +		if (tzone_temp >= svsb->tzone_htemp)
> +			temp_voffset += svsb->tzone_htemp_voffset;
> +		else if (tzone_temp <= svsb->tzone_ltemp)
> +			temp_voffset += svsb->tzone_ltemp_voffset;
> +	}
> +
>   	/* vmin <= svsb_volt (opp_volt) <= default opp voltage */
>   	for (i = 0; i < svsb->opp_count; i++) {
>   		switch (svsb->phase) {

Apart from that, the commit looks good. Looking forward to review the new version!

Regards,
- Angelo
