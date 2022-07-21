Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61E757C5FB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbiGUIQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiGUIQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:16:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6547D1DE;
        Thu, 21 Jul 2022 01:16:03 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 37F8566019C1;
        Thu, 21 Jul 2022 09:16:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658391361;
        bh=+uro6du1jM5M4noaSgYgRc27Gam/1Je5qgKJlaUGw3E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KQVQhT6Yc7na1ehojhPFmDL6LAvIqD293jaoYW48/jtLurvY4/CuT2s4HYBbxeC0u
         BSfzVXeX+qjChVMmr7GBDNvKMpE5tG7GUQOHWYWGaeJ+H1iCpMMckiIYwWlwev2KK9
         kFuAPGPpYxedUOShBPOaGIYB/hdHOrp/Nmj5QGLNWDAvkNoqB0BvDoXU/upUysfb/0
         2rAScxkwo22utlywvGDmmg8HHUYe4cofuvRASIDflpLQrsbn3aG0ALUhqcaUBtekbb
         7q3Vm3ruvO2JzY1QPxEbLOjKd55sWa+7yAfiTkZRISPeTWlRnrRGpJ7YJDey7cxsO+
         JTeISkn/Jf8LQ==
Message-ID: <c780f640-7112-1968-04d5-17e30c8e1cc2@collabora.com>
Date:   Thu, 21 Jul 2022 10:15:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/4] thermal: mediatek: add support for MT8365 SoC
Content-Language: en-US
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        matthias.bgg@gmail.com
Cc:     rafael@kernel.org, fparent@baylibre.com, amitk@kernel.org,
        daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        robh+dt@kernel.org, rui.zhang@intel.com
References: <20220720181854.547881-1-aouledameur@baylibre.com>
 <20220720181854.547881-3-aouledameur@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220720181854.547881-3-aouledameur@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/07/22 20:18, Amjad Ouled-Ameur ha scritto:
> From: Fabien Parent <fparent@baylibre.com>
> 
> MT8365 is similar to the other SoCs supported by the driver. It has only
> one bank and 3 actual sensors that can be multiplexed. There is another
> one sensor that does not have usable data.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Reviewed-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Tested-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> ---
>   drivers/thermal/mtk_thermal.c | 68 +++++++++++++++++++++++++++++++++++
>   1 file changed, 68 insertions(+)
> 
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index ede94eadddda..216eb0d61c5b 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -31,6 +31,7 @@
>   #define AUXADC_CON2_V		0x010
>   #define AUXADC_DATA(channel)	(0x14 + (channel) * 4)
>   
> +#define APMIXED_SYS_TS_CON0	0x600
>   #define APMIXED_SYS_TS_CON1	0x604
>   
>   /* Thermal Controller Registers */
> @@ -245,6 +246,17 @@ enum mtk_thermal_version {
>   /* The calibration coefficient of sensor  */
>   #define MT8183_CALIBRATION	153
>   
> +/* MT8365 */
> +#define MT8365_TEMP_AUXADC_CHANNEL 11
> +#define MT8365_CALIBRATION 164
> +#define MT8365_NUM_CONTROLLER 1
> +#define MT8365_NUM_BANKS 1
> +#define MT8365_NUM_SENSORS 3
> +#define MT8365_NUM_SENSORS_PER_ZONE 3
> +#define MT8365_TS1 0
> +#define MT8365_TS2 1
> +#define MT8365_TS3 2
> +
>   struct mtk_thermal;
>   
>   struct thermal_bank_cfg {
> @@ -386,6 +398,24 @@ static const int mt7622_mux_values[MT7622_NUM_SENSORS] = { 0, };
>   static const int mt7622_vts_index[MT7622_NUM_SENSORS] = { VTS1 };
>   static const int mt7622_tc_offset[MT7622_NUM_CONTROLLER] = { 0x0, };
>   
> +/* MT8365 thermal sensor data */
> +static const int mt8365_bank_data[MT8365_NUM_SENSORS] = {
> +	MT8365_TS1, MT8365_TS2, MT8365_TS3
> +};
> +
> +static const int mt8365_msr[MT8365_NUM_SENSORS_PER_ZONE] = {
> +	TEMP_MSR0, TEMP_MSR1, TEMP_MSR2
> +};
> +
> +static const int mt8365_adcpnp[MT8365_NUM_SENSORS_PER_ZONE] = {
> +	TEMP_ADCPNP0, TEMP_ADCPNP1, TEMP_ADCPNP2
> +};
> +
> +static const int mt8365_mux_values[MT8365_NUM_SENSORS] = { 0, 1, 2 };
> +static const int mt8365_tc_offset[MT8365_NUM_CONTROLLER] = { 0 };
> +
> +static const int mt8365_vts_index[MT8365_NUM_SENSORS] = { VTS1, VTS2, VTS3 };
> +
>   /*
>    * The MT8173 thermal controller has four banks. Each bank can read up to
>    * four temperature sensors simultaneously. The MT8173 has a total of 5
> @@ -460,6 +490,40 @@ static const struct mtk_thermal_data mt2701_thermal_data = {
>   	.version = MTK_THERMAL_V1,
>   };
>   
> +/*
> + * The MT8365 thermal controller has one bank, which can read up to
> + * four temperature sensors simultaneously. The MT8365 has a total of 3
> + * temperature sensors.
> + *
> + * The thermal core only gets the maximum temperature of this one bank,
> + * so the bank concept wouldn't be necessary here. However, the SVS (Smart
> + * Voltage Scaling) unit makes its decisions based on the same bank
> + * data.
> + */
> +static const struct mtk_thermal_data mt8365_thermal_data = {
> +	.auxadc_channel = MT8365_TEMP_AUXADC_CHANNEL,
> +	.num_banks = MT8365_NUM_BANKS,
> +	.num_sensors = MT8365_NUM_SENSORS,
> +	.vts_index = mt8365_vts_index,
> +	.cali_val = MT8365_CALIBRATION,
> +	.num_controller = MT8365_NUM_CONTROLLER,
> +	.controller_offset = mt8365_tc_offset,
> +	.need_switch_bank = false,
> +	.bank_data = {
> +		{
> +			.num_sensors = MT8365_NUM_SENSORS,
> +			.sensors = mt8365_bank_data
> +		},
> +	},
> +	.msr = mt8365_msr,
> +	.adcpnp = mt8365_adcpnp,
> +	.sensor_mux_values = mt8365_mux_values,
> +	.version = MTK_THERMAL_V1,
> +	.apmixed_buffer_ctl_reg = APMIXED_SYS_TS_CON0,
> +	.apmixed_buffer_ctl_mask = (u32) ~GENMASK(29, 28),
> +	.apmixed_buffer_ctl_set = 0,

Every commit has to build on its own.

This won't compile unless moved after 'thermal: mediatek: control buffer enablement
tweaks': please move it.

Regards,
Angelo

