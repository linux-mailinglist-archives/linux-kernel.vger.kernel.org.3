Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495905301B3
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 09:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbiEVHs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 03:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbiEVHs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 03:48:27 -0400
Received: from smtp.smtpout.orange.fr (smtp07.smtpout.orange.fr [80.12.242.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3B740E50
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 00:48:25 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.180.246])
        by smtp.orange.fr with ESMTPA
        id sgK6nMsvlvNzHsgK6nK1rI; Sun, 22 May 2022 09:48:23 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 22 May 2022 09:48:23 +0200
X-ME-IP: 86.243.180.246
Message-ID: <88ec0bd3-234c-a5ae-8a1a-a7a90e66e87c@wanadoo.fr>
Date:   Sun, 22 May 2022 09:48:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH V7 4/5] iio: accel: sca3300: Add support for SCL3300
Content-Language: en-US
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     linux-iio <linux-iio@vger.kernel.org>
References: <20220522070419.409556-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20220522070419.409556-5-Qing-wu.Li@leica-geosystems.com.cn>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220522070419.409556-5-Qing-wu.Li@leica-geosystems.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 22/05/2022 à 09:04, LI Qingwu a écrit :
> Add support for Murata SCL3300, a 3-axis MEMS accelerometer.
> Same as SCA3300, it has the accelerometer and temperature output.
> 
> Datasheet: www.murata.com/en-us/products/sensor/inclinometer/overview/lineup/scl3300
> Signed-off-by: LI Qingwu <Qing-wu.Li-t1cy0uBObHa2smIkw38IFAiE/XJ0vlP8@public.gmane.org>
> ---
>   drivers/iio/accel/sca3300.c | 28 ++++++++++++++++++++++++++--
>   1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
> index e57aba79c32b..10bedb14d4f0 100644
> --- a/drivers/iio/accel/sca3300.c
> +++ b/drivers/iio/accel/sca3300.c
> @@ -38,6 +38,7 @@
>   /* Device ID */
>   #define SCA3300_REG_WHOAMI	0x10
>   #define SCA3300_WHOAMI_ID	0x51
> +#define SCL3300_WHOAMI_ID	0xC1
>   
>   /* Device return status and mask */
>   #define SCA3300_VALUE_RS_ERROR	0x3
> @@ -96,10 +97,18 @@ static const struct iio_chan_spec sca3300_channels[] = {
>   static const int sca3300_lp_freq[] = {70, 10};
>   static const int sca3300_lp_freq_map[] = {0, 0, 0, 1};
>   
> +static const int scl3300_lp_freq[] = {40, 70, 10};
> +static const int scl3300_lp_freq_map[] = {0, 1, 2};
> +
>   static const int sca3300_accel_scale[][2] = {{0, 370}, {0, 741}, {0, 185}};
>   static const int sca3300_accel_scale_map[] = {0, 1, 2, 2};
>   
> +static const int scl3300_accel_scale[][2] = {{0, 167}, {0, 333}, {0, 83}};
> +static const int scl3300_accel_scale_map[] = {0, 1, 2};
> +
>   static const int sca3300_avail_modes_map[] = {0, 1, 2, 3};
> +static const int scl3300_avail_modes_map[] = {0, 1, 3};
> +
>   static const unsigned long sca3300_scan_masks[] = {
>   	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
>   	BIT(SCA3300_TEMP),
> @@ -159,6 +168,20 @@ static const struct sca3300_chip_info sca3300_chip_tbl[] = {
>   		.num_avail_modes = 4,
>   		.chip_id = SCA3300_WHOAMI_ID,
>   	},
> +	{	.scan_masks = sca3300_scan_masks,
> +		.channels = sca3300_channels,
> +		.num_channels = ARRAY_SIZE(sca3300_channels),
> +		.num_accel_scales = ARRAY_SIZE(scl3300_accel_scale)*2,
> +		.accel_scale = scl3300_accel_scale,
> +		.accel_scale_map = scl3300_accel_scale_map,
> +		.num_freqs = ARRAY_SIZE(scl3300_lp_freq),
> +		.freq_table = scl3300_lp_freq,
> +		.freq_map = scl3300_lp_freq_map,
> +		.name = "scl3300",
> +		.avail_modes_table = scl3300_avail_modes_map,
> +		.num_avail_modes = 3,
> +		.chip_id = SCL3300_WHOAMI_ID,
> +	},
>   };
>   
>   DECLARE_CRC8_TABLE(sca3300_crc_table);
> @@ -444,9 +467,9 @@ static int sca3300_init(struct sca3300_data *sca_data,
>   
>   	/*
>   	 * Wait 1ms after SW-reset command.
> -	 * Wait 15ms for settling of signal paths.
> +	 * Wait 25ms for settling of signal paths.

Hi,
maybe the comment (IIUC) should say that the timing depends of sca3300 
(15 ms) or scl3300 (25 ms) and that the max of the 2 values is taken.
Or have this delay depends of the chip in the code below.

CJ



>   	 */
> -	usleep_range(16e3, 50e3);
> +	usleep_range(26e3, 50e3);
>   
>   	ret = sca3300_read_reg(sca_data, SCA3300_REG_WHOAMI, &value);
>   	if (ret)
> @@ -573,6 +596,7 @@ static int sca3300_probe(struct spi_device *spi)
>   
>   static const struct of_device_id sca3300_dt_ids[] = {
>   	{ .compatible = "murata,sca3300"},
> +	{ .compatible = "murata,scl3300"},
>   	{}
>   };
>   MODULE_DEVICE_TABLE(of, sca3300_dt_ids);

