Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C881530289
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 13:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244587AbiEVLDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 07:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiEVLDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 07:03:42 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0AC39826;
        Sun, 22 May 2022 04:03:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1B0E4CE0AF7;
        Sun, 22 May 2022 11:03:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D511C385AA;
        Sun, 22 May 2022 11:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653217417;
        bh=g/rNTBYJ5MYl4gdTdbr4QQaYSLYVvb95mGjKiY//WqU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eQUf1wy7rl59gMuCzBlB9LwMrpQb9Hy6yripZO+7Xff/S6cRd0XZNMfDbwscaZLEz
         fzBGJGElkkDhCgoXcJIyxKGHzjHanzYcoj0ZN+ZTq32RWbWRTWPpkWBECi4O5GF5b0
         2BEG16Cxmo9wLXsCWnFUqwg5EbLjJHIgDXzq1tl/RlscD4PZ840fMO+XlhPTfRUlbN
         SA1WINX7bIUpB/KFuCPmqc+V19Sve2VVSbi14NW5ypGCNe7r/OywnKlTzE7PCLHWAj
         HbKxFf4iWo45z7IibLPJA8eLUehAT3WKKBWJUjKmupL21gV8lnkamplML9RClZbBvh
         y5fPm6H6MUevA==
Date:   Sun, 22 May 2022 12:12:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     lars@metafoo.de, robh+dt@kernel.org, tomas.melin@vaisala.com,
        andy.shevchenko@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH V7 4/5] iio: accel: sca3300: Add support for SCL3300
Message-ID: <20220522121222.4243f67c@jic23-huawei>
In-Reply-To: <20220522070419.409556-5-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220522070419.409556-1-Qing-wu.Li@leica-geosystems.com.cn>
        <20220522070419.409556-5-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 May 2022 07:04:18 +0000
LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn> wrote:

> Add support for Murata SCL3300, a 3-axis MEMS accelerometer.
> Same as SCA3300, it has the accelerometer and temperature output.
> 
> Datasheet: www.murata.com/en-us/products/sensor/inclinometer/overview/lineup/scl3300
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>

Hi,

Given you'll be respinning to address Christophe's comment, one trivial
thing inline (if this had been all that came up I'd have just tweaked
it whilst applying).

First 4 patches look good to me otherwise. I'll take a look at 5 shortly.

Thanks,

Jonathan


> ---
>  drivers/iio/accel/sca3300.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
> index e57aba79c32b..10bedb14d4f0 100644
> --- a/drivers/iio/accel/sca3300.c
> +++ b/drivers/iio/accel/sca3300.c
> @@ -38,6 +38,7 @@
>  /* Device ID */
>  #define SCA3300_REG_WHOAMI	0x10
>  #define SCA3300_WHOAMI_ID	0x51
> +#define SCL3300_WHOAMI_ID	0xC1
>  
>  /* Device return status and mask */
>  #define SCA3300_VALUE_RS_ERROR	0x3
> @@ -96,10 +97,18 @@ static const struct iio_chan_spec sca3300_channels[] = {
>  static const int sca3300_lp_freq[] = {70, 10};
>  static const int sca3300_lp_freq_map[] = {0, 0, 0, 1};
>  
> +static const int scl3300_lp_freq[] = {40, 70, 10};
> +static const int scl3300_lp_freq_map[] = {0, 1, 2};
> +
>  static const int sca3300_accel_scale[][2] = {{0, 370}, {0, 741}, {0, 185}};
>  static const int sca3300_accel_scale_map[] = {0, 1, 2, 2};
>  
> +static const int scl3300_accel_scale[][2] = {{0, 167}, {0, 333}, {0, 83}};
> +static const int scl3300_accel_scale_map[] = {0, 1, 2};
> +
>  static const int sca3300_avail_modes_map[] = {0, 1, 2, 3};
> +static const int scl3300_avail_modes_map[] = {0, 1, 3};
> +
>  static const unsigned long sca3300_scan_masks[] = {
>  	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
>  	BIT(SCA3300_TEMP),
> @@ -159,6 +168,20 @@ static const struct sca3300_chip_info sca3300_chip_tbl[] = {
>  		.num_avail_modes = 4,
>  		.chip_id = SCA3300_WHOAMI_ID,
>  	},
> +	{	.scan_masks = sca3300_scan_masks,

	{
		.scan_masks = ...

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
>  };
>  
>  DECLARE_CRC8_TABLE(sca3300_crc_table);
> @@ -444,9 +467,9 @@ static int sca3300_init(struct sca3300_data *sca_data,
>  
>  	/*
>  	 * Wait 1ms after SW-reset command.
> -	 * Wait 15ms for settling of signal paths.
> +	 * Wait 25ms for settling of signal paths.
>  	 */
> -	usleep_range(16e3, 50e3);
> +	usleep_range(26e3, 50e3);
>  
>  	ret = sca3300_read_reg(sca_data, SCA3300_REG_WHOAMI, &value);
>  	if (ret)
> @@ -573,6 +596,7 @@ static int sca3300_probe(struct spi_device *spi)
>  
>  static const struct of_device_id sca3300_dt_ids[] = {
>  	{ .compatible = "murata,sca3300"},
> +	{ .compatible = "murata,scl3300"},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, sca3300_dt_ids);

