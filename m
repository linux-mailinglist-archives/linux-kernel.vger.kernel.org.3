Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D063C4E4571
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 18:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239672AbiCVRts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 13:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbiCVRtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:49:46 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BAD240A0;
        Tue, 22 Mar 2022 10:48:16 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id pv16so37940533ejb.0;
        Tue, 22 Mar 2022 10:48:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uhQ60+s/3h+jWyIIuuE2dKB2Qu2RlBZBG+mrPMGhNO0=;
        b=IQJx0BhZypEqUlCv6wZJYzRLLpP6+9tn6vqxIj4FI+ddHS5JvR2Si36JHXNOjwjMCd
         jfSgpKro9BM2TUo3rkN4jvSePw6IBOAbnQphNd7ji4igywOnEtGP2vMqDJ3w6BfOFAM5
         2PFmKb3G0hqcrxOAm8/RiwxQbVk7ePqqGix5E8gfPW62RDIUyc2o3ojMEYCWUGICr1XB
         HCjJGcLjwFsaTWJU/5SSm8PBYOOO/bd+z/X+Piu9bNn05b2qfT3TIVZEtqJNC76KE3W5
         tFEpP7wvrgXO951vPzz6/n4kfamfsa1j6AaXttFU+AHP3HpCnVEbs5HQ1Nxh7UJpSk6i
         EvYg==
X-Gm-Message-State: AOAM532R7xRoT6hxn7fvw6Mpsf2cko3/QtfZlUvtqLYh7OdN3qLUMkF/
        PFGYt6U5BrTFrXgW/JWiL8I=
X-Google-Smtp-Source: ABdhPJycUOk9rRb2GuofivM9xoyn+LbIOOZZs3dpx0RScfAcbmeWMozoq+USKgXgG5Iq7J8cXRyXfQ==
X-Received: by 2002:a17:907:9703:b0:6da:6412:508a with SMTP id jg3-20020a170907970300b006da6412508amr27385513ejc.77.1647971294747;
        Tue, 22 Mar 2022 10:48:14 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id l20-20020a1709062a9400b006ce71a88bf5sm8494260eje.183.2022.03.22.10.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 10:48:13 -0700 (PDT)
Message-ID: <4ca669ea-fdf0-f4bb-7c68-47a26e72a4ce@kernel.org>
Date:   Tue, 22 Mar 2022 18:48:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] thermal: exynos: Add support for ARTPEC-8
Content-Language: en-US
To:     hypmean.kim@samsung.com, "bzolnier@gmail.com" <bzolnier@gmail.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220322075638.110056-1-hypmean.kim@samsung.com>
 <CGME20220322075618epcas1p3c63582c62099312db6d40d71cfbee15b@epcms2p5>
 <20220322082242epcms2p5b5e9e24a947e1d6c4b77fb9c95baf992@epcms2p5>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220322082242epcms2p5b5e9e24a947e1d6c4b77fb9c95baf992@epcms2p5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2022 09:22, Sang Min Kim wrote:
> Add support thermal management for Axis ARTPEC-8 SoC.
> ARTPEC-8 is the SoC platform of Axis Communications.
> In the existing thermal management function of exynos, functions that support
> remote sensors have been added.
>  
> Signed-off-by: sangmin kim <hypmean.kim@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 666 ++++++++++++++++++++++++++++++++---
>  1 file changed, 616 insertions(+), 50 deletions(-)
>  
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index f4ab4c5..9837f42 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -14,6 +14,7 @@
>  #include <linux/clk.h>
>  #include <linux/io.h>
>  #include <linux/interrupt.h>
> +#include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/of_address.h>
> @@ -124,6 +125,77 @@
>  
>  #define MCELSIUS        1000
>  
> +/* Artpec8 specific registers */
Pu all defines just after Exynos specific bits, so before MCELSIUS.

> +#define ARTPEC8_TMU_REG_TRIMINFO        0x0
> +#define ARTPEC8_TMU_REG_TRIMINFO1        0x4
> +#define ARTPEC8_TMU_REG_TRIMINFO2        0x8
> +#define ARTPEC8_TMU_REG_TRIMINFO3        0xC
> +#define ARTPEC8_TMU_REG_TRIMINFO4        0x10
> +#define ARTPEC8_TMU_REG_TRIMINFO5        0x14
> +#define ARTPEC8_TMU_REG_CONTROL                0x20
> +#define ARTPEC8_TMU_REG_CONTROL1        0x24
> +#define ARTPEC8_TMU_REG_STATUS                0x28
> +
> +#define ARTPEC8_TMU_REG_AVG_CONTROL        0x38
> +#define ARTPEC8_TMU_REG_TMU_TRIM0        0x3C
> +
> +#define ARTPEC8_TMU_REG_EMUL_CON        0x160
> +#define NUM_PROBE_OFFSET                16

This is not prefixed with artpec and is very cryptic. Please document
this and other defines which are not obvious, comparing to current code.

> +
> +#define ARTPEC8_FIRST_POINT_TRIM        25
> +#define ARTPEC8_SECOND_POINT_TRIM        105
> +
> +#define ARTPEC8_EMUL_EN                        1
> +#define ARTPEC8_TIME_OFFSET                16

Don't duplicate defines with existing ones. Define only differences.
This applies to all other defines as well.

> +#define ARTPEC8_EMUL_NEXT_TIME                (0x4e20 << ARTPEC8_TIME_OFFSET)
> +
> +#define ARTPEC8_TMU_TEMP_MASK                0x1ff
> +#define ARTPEC8_CALIB_SEL_SHIFT                23
> +
> +#define ARTPEC8_EMUL_DATA_SHIFT                7
> +
> +#define ARTPEC8_T_BUF_VREF_SEL_SHIFT        18
> +#define ARTPEC8_T_BUF_SLOPE_SEL_SHIFT        18
> +#define ARTPEC8_INTEN_TRIPPING_SHIFT        7
> +#define ARTPEC8_INTEN_CLOCKDOWN_SHIFT        8
> +#define ARTPEC8_TRIMINFO_105_SHIFT        9
> +#define ARTPEC8_INTEN_FALL0_SHIFT        16
> +#define ARTPEC8_TMU_REF_VOLTAGE_SHIFT        24
> +#define ARTPEC8_TMU_REF_VOLTAGE_MASK        0x1f
> +#define ARTPEC8_TMU_BUF_SLOPE_SEL_SHIFT        8
> +#define ARTPEC8_TMU_BUF_SLOPE_SEL_MASK        0xf
> +
> +#define ARTPEC8_TMU_CONTROL_CORE_EN        1
> +#define ARTPEC8_TMU_CONTROL_AUTO_MODE        2
> +#define ARTPEC8_TMU_CONTROL_TRIP_EN        (1 << 12)
> +#define ARTPEC8_LPI_MODE_EN                (1 << 10)
> +
> +#define ARTPEC8_TRIM0_BGR_I_SHIFT        20
> +#define ARTPEC8_TRIM0_VREF_SHIFT        12
> +#define ARTPEC8_TRIM0_VBE_I_SHIFT        8
> +
> +#define INTPEND_RISE_MASK                0xff
> +#define INTPEND_FALL_MASK                0xff0000

prefix

> +#define ARTPEC8_TRIM0_MASK                0xf
> +#define ARTPEC8_TRIM2_MASK                0x7
> +
> +#define ARTPEC8_TRIMINFO_TRIM0_SHIFT        18
> +
> +#define LOW_TEMP_WEIGHT                        9203
> +#define HIGH_TEMP_WEIGHT                9745
> +#define TEMP_WEIGHT                        10000

All these need explanation why/what/how did you get these values.

> +
> +struct sensor_offset {

kerneldoc needed

> +        u32 trim_offset;
> +        u32 temp_offset;
> +        u32 temp_reg_shift;
> +        u32 rise_offset;
> +        u32 fall_offset;
> +        u32 past_offset;
> +        u32 inten;
> +        u32 intpend;
> +};
> +
>  enum soc_type {
>          SOC_ARCH_EXYNOS3250 = 1,
>          SOC_ARCH_EXYNOS4210,
> @@ -134,6 +206,63 @@ enum soc_type {
>          SOC_ARCH_EXYNOS5420_TRIMINFO,
>          SOC_ARCH_EXYNOS5433,
>          SOC_ARCH_EXYNOS7,
> +        SOC_ARCH_ARTPEC8,

Put it alphabetically.

> +};
> +
> +#define SENSOR(_tr, _te, _sh, _ri, _fa, _pa, _en, _pend)        \
> +        {                                        \
> +                .trim_offset        = _tr,                \
> +                .temp_offset        = _te,                \
> +                .temp_reg_shift        = _sh,                \
> +                .rise_offset        = _ri,                \
> +                .fall_offset        = _fa,                \
> +                .past_offset        = _pa,                \
> +                .inten                = _en,                \
> +                .intpend        = _pend,                \
> +        }
> +
> +static const struct sensor_offset artpec8_sensors[] = {
> +        SENSOR(0x0,        0x40,        0,  0x50,        0x60,        0x70,        0x110,        0x118),

0x118 is existing value, right?
All these should be using rather a macro - either dedicated defines or
offset-based macros.

> +        SENSOR(0x4,        0x40,        9,  0x170,        0x180,        0x90,        0x120,        0x128),

Here and further it looks like you have all registers distributed
according to specific pattern. Define macro, probably with an offset
based on first sensor.

> +        SENSOR(0x8,        0x44,        0,  0x190,        0x1a0,        0xb0,        0x130,        0x138),
> +        SENSOR(0xc,        0x44,        9,  0x1b0,        0x1c0,        0xd0,        0x140,        0x148),
> +        SENSOR(0x10,        0x44,        18, 0x1d0,        0x1e0,        0xf0,        0x150,        0x158),
> +        SENSOR(0x14,        0x48,        0,  0x1f0,        0x200,        0x250,        0x310,        0x318),
> +};
> +
> +/**
> + * struct artpec8_sensor: A structure to hold the private data of the sensor
> + * @tmudev: The tmu device which this sensor is connected.
> + * @tzd: Thermal zonde device pointer to register this sensor.
> + * @id: Identifier of the one instance of the thermal sensor.
> + * @ntrip: Number of threshols for this sensor.
> + * @triminfo_25: OTP information to trim temperature sensor error for 25C
> + * @triminfo_105: OTP information to trim temperature sensor error for 105C
> + * @trim_offset: Offset of triminfo register.
> + * @temp_offset: Offset of current temperature. The temperature values of
> + *                2 to 3 remote sensors are stored in this register.
> + * @temp_reg_shift: start location of each tempt in temp_off
> + * @rise_offset: Offset of rising threshold level 6 and 7.
> + * @fall_offset: Offset of falling thershold level 6 and 7.
> + * @past_offset: Offset of Past temperature 0,1.
> + * @inten: Offset of interrupt enable sfr.
> + * @intpend: Offset of interrupt pending sfr.
> + */
> +struct artpec8_sensor {
> +        struct exynos_tmu_data *tmudev;
> +        struct thermal_zone_device *tzd;

Why does the sensor duplicate struct exynos_tmu_data?

> +        int id;
> +        unsigned int ntrip;
> +        u16 triminfo_25;
> +        u16 triminfo_105;
> +        u32 trim_offset;
> +        u32 temp_offset;
> +        u32 temp_reg_shift;
> +        u32 rise_offset;
> +        u32 fall_offset;
> +        u32 past_offset;
> +        u32 inten;
> +        u32 intpend;

You have all these in sensor_offset, don't you? Why do you need them
second time?

>  };
>  
>  /**
> @@ -193,6 +322,7 @@ struct exynos_tmu_data {
>          struct thermal_zone_device *tzd;
>          unsigned int ntrip;
>          bool enabled;
> +        u32 nr_remote;

Missing doc. Did you compile your code with W=1?

>  
>          void (*tmu_set_trip_temp)(struct exynos_tmu_data *data, int trip,
>                                   u8 temp);
> @@ -203,6 +333,8 @@ struct exynos_tmu_data {
>          int (*tmu_read)(struct exynos_tmu_data *data);
>          void (*tmu_set_emulation)(struct exynos_tmu_data *data, int temp);
>          void (*tmu_clear_irqs)(struct exynos_tmu_data *data);
> +
> +        struct artpec8_sensor sensor[0];

No artpec8_sensor, but Exynos sensor. You need to convert existing code
for working with 1 sensors and X sensors. Don't just add X sensors
duplicating parts of driver.

Also - why this is array of [0]?

>  };
>  
>  /*
> @@ -220,6 +352,28 @@ static int temp_to_code(struct exynos_tmu_data *data, u8 temp)
>                  data->temp_error1;
>  }
>  
> +static u16 artpec8_temp_to_code(struct artpec8_sensor *sensor, int temp)

Maintain consistent code with existing implementation. Why types are
different than temp_to_code()? Maybe temp_to_code() is not good?

> +{
> +        int code;
> +        int weight;
> +
> +        if (sensor->tmudev->cal_type == TYPE_ONE_POINT_TRIMMING)
> +                return temp + sensor->triminfo_25 - ARTPEC8_FIRST_POINT_TRIM;
> +
> +        if (temp > ARTPEC8_FIRST_POINT_TRIM)
> +                weight = HIGH_TEMP_WEIGHT;
> +        else
> +                weight = LOW_TEMP_WEIGHT;
> +
> +        code = DIV_ROUND_CLOSEST((temp - ARTPEC8_FIRST_POINT_TRIM) *
> +                (sensor->triminfo_105 - sensor->triminfo_25) * TEMP_WEIGHT,
> +                (ARTPEC8_SECOND_POINT_TRIM - ARTPEC8_FIRST_POINT_TRIM) *
> +                weight);
> +        code += sensor->triminfo_25;
> +
> +        return (u16)code;
> +}
> +
>  /*
>   * Calculate a temperature value from a temperature code.
>   * The unit of the temperature is degree Celsius.
> @@ -235,6 +389,27 @@ static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code)
>                  EXYNOS_FIRST_POINT_TRIM;
>  }
>  
> +static int artpec8_code_to_temp(struct artpec8_sensor *sensor, u16 code)
> +{
> +        int temp;
> +        int weight;
> +
> +        if (sensor->tmudev->cal_type == TYPE_ONE_POINT_TRIMMING)
> +                return code - sensor->triminfo_25 + ARTPEC8_FIRST_POINT_TRIM;
> +
> +        if (code > sensor->triminfo_25)
> +                weight = HIGH_TEMP_WEIGHT;
> +        else
> +                weight = LOW_TEMP_WEIGHT;
> +
> +        temp = DIV_ROUND_CLOSEST((code - sensor->triminfo_25) *
> +                (ARTPEC8_SECOND_POINT_TRIM - ARTPEC8_FIRST_POINT_TRIM) * weight,
> +                (sensor->triminfo_105 - sensor->triminfo_25) * TEMP_WEIGHT);
> +        temp += ARTPEC8_FIRST_POINT_TRIM;
> +
> +        return temp;
> +}
> +
>  static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info)
>  {
>          u16 tmu_temp_mask =
> @@ -338,7 +513,8 @@ static u32 get_con_reg(struct exynos_tmu_data *data, u32 con)
>          con &= ~(EXYNOS_TMU_REF_VOLTAGE_MASK << EXYNOS_TMU_REF_VOLTAGE_SHIFT);
>          con |= data->reference_voltage << EXYNOS_TMU_REF_VOLTAGE_SHIFT;
>  
> -        con &= ~(EXYNOS_TMU_BUF_SLOPE_SEL_MASK << EXYNOS_TMU_BUF_SLOPE_SEL_SHIFT);
> +        con &= ~(EXYNOS_TMU_BUF_SLOPE_SEL_MASK <<
> +                        EXYNOS_TMU_BUF_SLOPE_SEL_SHIFT);

How is this related?

>          con |= (data->gain << EXYNOS_TMU_BUF_SLOPE_SEL_SHIFT);
>  
>          con &= ~(EXYNOS_TMU_TRIP_MODE_MASK << EXYNOS_TMU_TRIP_MODE_SHIFT);
> @@ -558,6 +734,120 @@ static void exynos7_tmu_initialize(struct platform_device *pdev)
>          sanitize_temp_error(data, trim_info);
>  }
>  
> +static void artpec8_tmu_set_trip_temp(struct exynos_tmu_data *data,
> +                int trip, int temp, int remote)
> +{
> +        unsigned int reg_off, bit_off;
> +        u32 th;
> +        struct artpec8_sensor *sensor;
> +        unsigned int temp_rise;
> +
> +        sensor = &data->sensor[remote];
> +        temp_rise = sensor->rise_offset;
> +
> +        reg_off = ((7 - trip) / 2) * 4;
> +        bit_off = ((8 - trip) % 2);
Please explain the offsets in comment.

> +
> +        th = readl(data->base + temp_rise + reg_off);
> +        th &= ~(ARTPEC8_TMU_TEMP_MASK << (16 * bit_off));
> +        th |= artpec8_temp_to_code(sensor, temp) << (16 * bit_off);
> +        writel(th, data->base + temp_rise + reg_off);
> +}
> +
> +static void artpec8_tmu_set_trip_hyst(struct exynos_tmu_data *data,
> +                int trip, int temp, int hyst, int remote)
> +{
> +        unsigned int reg_off, bit_off;
> +        u32 th;
> +        struct artpec8_sensor *sensor;
> +        unsigned int temp_fall;
> +
> +        sensor = &data->sensor[remote];
> +        temp_fall = sensor->fall_offset;
> +
> +        reg_off = ((7 - trip) / 2) * 4;
> +        bit_off = ((8 - trip) % 2);
> +
> +        th = readl(data->base + temp_fall + reg_off);
> +        th &= ~(ARTPEC8_TMU_TEMP_MASK << (16 * bit_off));
> +        th |= artpec8_temp_to_code(sensor, temp - hyst) << (16 * bit_off);
> +        writel(th, data->base + temp_fall + reg_off);
> +}
> +
> +static void artpec8_tmu_clear_irqs(struct exynos_tmu_data *data, int i)
> +{
> +        u32 intp = readl(data->base + data->sensor[i].intpend);
> +
> +        writel(intp, data->base + data->sensor[i].intpend);
> +}
> +

I'll skip reviewing this part. Half of it will be gone once you convert
driver to have uniform approach to sensors.

(...)

> +static int artpec8_register_tzd(struct platform_device *pdev)
> +{
> +        struct exynos_tmu_data *data = platform_get_drvdata(pdev);
> +        struct artpec8_sensor *sensor;
> +        struct device *dev = &pdev->dev;
> +        int sensor_idx, ret = 0;
> +        struct thermal_zone_device *tzd;
> +        const struct thermal_trip *trips;
> +
> +        for (sensor_idx = 0; sensor_idx < data->nr_remote; sensor_idx++) {
> +                sensor = &data->sensor[sensor_idx];
> +
> +                ret = artpec8_map_sensor_data(data, sensor_idx, sensor);
> +                if (ret)
> +                        break;
> +
> +                tzd = devm_thermal_zone_of_sensor_register(dev,
> +                                sensor_idx, sensor, &artpec8_ops);
> +                if (IS_ERR(tzd))
> +                        continue;
> +
> +                sensor->tzd = tzd;
> +                trips = of_thermal_get_trip_points(tzd);
> +                if (!trips) {
> +                        dev_warn(dev,
> +                                "Cannot get trip points from device tree!\n");
> +                        ret = -ENODEV;
> +                        break;
> +                }
> +                sensor->ntrip = of_thermal_get_ntrips(tzd);
> +        }
> +
> +        return ret;
> +}
> +
>  static int exynos_tmu_probe(struct platform_device *pdev)
>  {
>          struct exynos_tmu_data *data;
>          int ret;
> +        int sensor_idx;
> +        int nr_remote = 0;
> +        struct device *dev;
> +        const struct of_device_id *dev_id;
>  
> -        data = devm_kzalloc(&pdev->dev, sizeof(struct exynos_tmu_data),
> -                                        GFP_KERNEL);
> +        if (pdev->dev.of_node)
> +                dev = &pdev->dev;
> +        else
> +                dev = pdev->dev.parent;

Whaaaaat?

> +
> +        dev_id = of_match_node(exynos_tmu_match, dev->of_node);
> +        if (dev_id) {
> +              �� data = (struct exynos_tmu_data *)dev_id->data;

Some unusual characters appeared here.

Did you run checkpatch, smatch and sparse?

> +        } else {
> +                dev_warn(dev, "dev id error\n");

Is it possible?

> +                return -EINVAL;
> +        }
> +
> +        ret = of_property_read_u32(dev->of_node, "remote_sensors", &nr_remote);

Do not add undocumented properties.

> +        if (ret < 0)
> +                data = devm_kzalloc(&pdev->dev, sizeof(struct exynos_tmu_data),
> +                                    GFP_KERNEL);
> +        else
> +                data = devm_kzalloc(dev, sizeof(struct exynos_tmu_data) +
> +                        (sizeof(struct artpec8_sensor) * nr_remote),
> +                        GFP_KERNEL);
>          if (!data)
>                  return -ENOMEM;
>  
>          platform_set_drvdata(pdev, data);
>          mutex_init(&data->lock);
>  
> +        if (data->soc != SOC_ARCH_ARTPEC8) {
>          /*
>           * Try enabling the regulator if found
>           * TODO: Add regulator as an SOC feature, so that regulator enable
>           * is a compulsory call.
>           */

Does not look like proper indentation.

> -        data->regulator = devm_regulator_get_optional(&pdev->dev, "vtmu");
> -        if (!IS_ERR(data->regulator)) {
> -                ret = regulator_enable(data->regulator);
> -                if (ret) {
> -                        dev_err(&pdev->dev, "failed to enable vtmu\n");
> -                        return ret;
> +                data->regulator = devm_regulator_get_optional(&pdev->dev, "vtmu");
> +                if (!IS_ERR(data->regulator)) {
> +                        ret = regulator_enable(data->regulator);
> +                        if (ret) {
> +                                dev_err(&pdev->dev, "failed to enable vtmu\n");
> +                                return ret;
> +                        }
> +                } else {
> +                        if (PTR_ERR(data->regulator) == -EPROBE_DEFER)
> +                                return -EPROBE_DEFER;
> +                        dev_info(&pdev->dev, "Regulator node (vtmu) not found\n");
>                  }
> -        } else {
> -                if (PTR_ERR(data->regulator) == -EPROBE_DEFER)
> -                        return -EPROBE_DEFER;
> -                dev_info(&pdev->dev, "Regulator node (vtmu) not found\n");
>          }
>  
>          ret = exynos_map_dt_data(pdev);
>          if (ret)
>                  goto err_sensor;
>  
> -        INIT_WORK(&data->irq_work, exynos_tmu_work);
> +        if (data->soc == SOC_ARCH_ARTPEC8) {
> +                ret = artpec8_register_tzd(pdev);
> +                if (ret)
> +                        return -EINVAL;
> +
> +                INIT_WORK(&data->irq_work, artpec8_tmu_work);
> +        } else {
> +                INIT_WORK(&data->irq_work, exynos_tmu_work);
> +        }

No, this should be parametrized via ops in exynos_tmu_data (one more op
for "work").

>  
>          data->clk = devm_clk_get(&pdev->dev, "tmu_apbif");
>          if (IS_ERR(data->clk)) {
> @@ -1046,18 +1590,21 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>                  goto err_sensor;
>          }
>  
> -        data->clk_sec = devm_clk_get(&pdev->dev, "tmu_triminfo_apbif");
> -        if (IS_ERR(data->clk_sec)) {
> -                if (data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO) {
> -                        dev_err(&pdev->dev, "Failed to get triminfo clock\n");
> -                        ret = PTR_ERR(data->clk_sec);
> -                        goto err_sensor;
> -                }
> -        } else {
> -                ret = clk_prepare(data->clk_sec);
> -                if (ret) {
> -                        dev_err(&pdev->dev, "Failed to get clock\n");
> -                        goto err_sensor;
> +        if (data->soc != SOC_ARCH_ARTPEC8) {
> +                data->clk_sec = devm_clk_get(&pdev->dev, "tmu_triminfo_apbif");
> +                if (IS_ERR(data->clk_sec)) {
> +                        if (data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO) {
> +                                dev_err(&pdev->dev,
> +                                        "Failed to get triminfo clock\n");
> +                                ret = PTR_ERR(data->clk_sec);
> +                                goto err_sensor;
> +                        }
> +                } else {
> +                        ret = clk_prepare(data->clk_sec);
> +                        if (ret) {
> +                                dev_err(&pdev->dev, "Failed to get clock\n");
> +                                goto err_sensor;
> +                        }
>                  }
>          }
>  
> @@ -1070,6 +1617,7 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>          switch (data->soc) {
>          case SOC_ARCH_EXYNOS5433:
>          case SOC_ARCH_EXYNOS7:
> +        case SOC_ARCH_ARTPEC8:
>                  data->sclk = devm_clk_get(&pdev->dev, "tmu_sclk");
>                  if (IS_ERR(data->sclk)) {
>                          dev_err(&pdev->dev, "Failed to get sclk\n");
> @@ -1087,24 +1635,26 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>                  break;
>          }
>  
> +        if (data->soc != SOC_ARCH_ARTPEC8) {
>          /*
>           * data->tzd must be registered before calling exynos_tmu_initialize(),
>           * requesting irq and calling exynos_tmu_control().
>           */

Again wrong indentation.


Best regards,
Krzysztof
