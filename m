Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0404A3692
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 15:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354941AbiA3OE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 09:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237553AbiA3OE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 09:04:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0ABC061714;
        Sun, 30 Jan 2022 06:04:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE9B1611CB;
        Sun, 30 Jan 2022 14:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AADEC340E4;
        Sun, 30 Jan 2022 14:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643551466;
        bh=V6j1bLnRiyoxNixikiAnOSimbdOAtXOBFRAv0m7JhRA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=asbqWx3OuGhPdWupvzhf0t1T+FBWU+bKyWOYD4kSu6Ue0mv7u0qxU1zniSNPnjleF
         Gdc8lb6v0ztR4WDZLrf45fpDz5s8J0O32mT7JxgzmY2gN7EyWmV5hnUdABVrzXhZhP
         XiMBhXabeeMcVhe1XZSkSjV8HZImS9K5s8kMIL9uBsrXS1Ejh0HFrQs6tCn0O2Yuov
         ysbSCoJCkZNvVHedoD/VTjcwWLmGQ3vrdmL6IkjVuVoBGGvTyvd5s7tSimw6YSf+he
         zRDsNeJ5y72yLA0XUIioOqxMcLYwRIhnnFulW9cjTQ/2az5Kv29cMLGNhe6kDGw8uO
         0YfrZW57FniNg==
Date:   Sun, 30 Jan 2022 14:10:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Denis Ciocca <denis.ciocca@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: accel: st_accel: Add support for Silan SC7A20
Message-ID: <20220130141048.31be2554@jic23-huawei>
In-Reply-To: <20220130034441.15474-4-samuel@sholland.org>
References: <20220130034441.15474-1-samuel@sholland.org>
        <20220130034441.15474-4-samuel@sholland.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jan 2022 21:44:41 -0600
Samuel Holland <samuel@sholland.org> wrote:

> This chip appears to be a clone of the LIS2DH. The new description is a
> copy of the LIS2DH's description with a different WAI value.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
Hi Samuel,

This is nasty as 0x11 is a valid who am I for an LIS3DHH which is a very
different device.

One request inline for a bit more info in the code about what this device
is etc.  I've found a Chinese data sheet on one of the datasheet aggregator
sites.

If you know of a stable location to add a
Datasheet:
tag to this patch that would also be helpful.

Thanks,

Jonathan

> ---
> 
>  drivers/iio/accel/st_accel.h      |  2 +
>  drivers/iio/accel/st_accel_core.c | 79 +++++++++++++++++++++++++++++++
>  drivers/iio/accel/st_accel_i2c.c  |  5 ++
>  3 files changed, 86 insertions(+)
> 
> diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
> index 8750dea56fcb..00e056c21bfc 100644
> --- a/drivers/iio/accel/st_accel.h
> +++ b/drivers/iio/accel/st_accel.h
> @@ -36,6 +36,7 @@ enum st_accel_type {
>  	LIS3DHH,
>  	LIS2DE12,
>  	LIS2HH12,
> +	SC7A20,
>  	ST_ACCEL_MAX,
>  };
>  
> @@ -61,6 +62,7 @@ enum st_accel_type {
>  #define LIS3DE_ACCEL_DEV_NAME		"lis3de"
>  #define LIS2DE12_ACCEL_DEV_NAME		"lis2de12"
>  #define LIS2HH12_ACCEL_DEV_NAME		"lis2hh12"
> +#define SC7A20_ACCEL_DEV_NAME		"sc7a20"
>  
>  #ifdef CONFIG_IIO_BUFFER
>  int st_accel_allocate_ring(struct iio_dev *indio_dev);
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index 31ea19d0ba71..d9aa0ff1922b 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -1087,6 +1087,85 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  		.multi_read_bit = true,
>  		.bootime = 2,
>  	},
> +	{

Please add a comment here about the fact it seems to be a clone of the LIS2DH
despite the wrong WAI.

It's worth noting that a good part of the maintenance of this driver is
done by ST employees who are probably less than happy with seeing
a clone (with bugs) supported.  So support is likely to be somewhat best
effort / not going to deliberately break support for this part but no
means to test it. Hopefully we'll remember to cc you to test anything new added to
the driver.  Clones aren't always perfect!

Jonathan

> +		.wai = 0x11,
> +		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
> +		.sensors_supported = {
> +			[0] = SC7A20_ACCEL_DEV_NAME,
> +		},
> +		.ch = (struct iio_chan_spec *)st_accel_12bit_channels,
> +		.odr = {
> +			.addr = 0x20,
> +			.mask = 0xf0,
> +			.odr_avl = {
> +				{ .hz = 1, .value = 0x01, },
> +				{ .hz = 10, .value = 0x02, },
> +				{ .hz = 25, .value = 0x03, },
> +				{ .hz = 50, .value = 0x04, },
> +				{ .hz = 100, .value = 0x05, },
> +				{ .hz = 200, .value = 0x06, },
> +				{ .hz = 400, .value = 0x07, },
> +				{ .hz = 1600, .value = 0x08, },
> +			},
> +		},
> +		.pw = {
> +			.addr = 0x20,
> +			.mask = 0xf0,
> +			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
> +		},
> +		.enable_axis = {
> +			.addr = ST_SENSORS_DEFAULT_AXIS_ADDR,
> +			.mask = ST_SENSORS_DEFAULT_AXIS_MASK,
> +		},
> +		.fs = {
> +			.addr = 0x23,
> +			.mask = 0x30,
> +			.fs_avl = {
> +				[0] = {
> +					.num = ST_ACCEL_FS_AVL_2G,
> +					.value = 0x00,
> +					.gain = IIO_G_TO_M_S_2(1000),
> +				},
> +				[1] = {
> +					.num = ST_ACCEL_FS_AVL_4G,
> +					.value = 0x01,
> +					.gain = IIO_G_TO_M_S_2(2000),
> +				},
> +				[2] = {
> +					.num = ST_ACCEL_FS_AVL_8G,
> +					.value = 0x02,
> +					.gain = IIO_G_TO_M_S_2(4000),
> +				},
> +				[3] = {
> +					.num = ST_ACCEL_FS_AVL_16G,
> +					.value = 0x03,
> +					.gain = IIO_G_TO_M_S_2(12000),
> +				},
> +			},
> +		},
> +		.bdu = {
> +			.addr = 0x23,
> +			.mask = 0x80,
> +		},
> +		.drdy_irq = {
> +			.int1 = {
> +				.addr = 0x22,
> +				.mask = 0x10,
> +			},
> +			.addr_ihl = 0x25,
> +			.mask_ihl = 0x02,
> +			.stat_drdy = {
> +				.addr = ST_SENSORS_DEFAULT_STAT_ADDR,
> +				.mask = 0x07,
> +			},
> +		},
> +		.sim = {
> +			.addr = 0x23,
> +			.value = BIT(0),
> +		},
> +		.multi_read_bit = true,
> +		.bootime = 2,
> +	},
>  };
>  
>  /* Default accel DRDY is available on INT1 pin */
> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> index c0ce78eebad9..7f5888570e87 100644
> --- a/drivers/iio/accel/st_accel_i2c.c
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -107,6 +107,10 @@ static const struct of_device_id st_accel_of_match[] = {
>  		.compatible = "st,lis2hh12",
>  		.data = LIS2HH12_ACCEL_DEV_NAME,
>  	},
> +	{
> +		.compatible = "silan,sc7a20",
> +		.data = SC7A20_ACCEL_DEV_NAME,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_accel_of_match);
> @@ -142,6 +146,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
>  	{ LIS3DE_ACCEL_DEV_NAME },
>  	{ LIS2DE12_ACCEL_DEV_NAME },
>  	{ LIS2HH12_ACCEL_DEV_NAME },
> +	{ SC7A20_ACCEL_DEV_NAME },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, st_accel_id_table);

