Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEFF5272A7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 17:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbiENPeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 11:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiENPeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 11:34:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5F15F95;
        Sat, 14 May 2022 08:34:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59338B8075F;
        Sat, 14 May 2022 15:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5D2C340EE;
        Sat, 14 May 2022 15:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652542448;
        bh=FO1SgJTHDtGOgx9WRDS0THMMt69HzvcDsxd+TsjXcJc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Az7rc1BD/sE4eMGzX157/k/ps7JuvWMMIEgJLWJtbTnwSIwJc2Pid2sf+q71yVDGf
         KCMysgNxZCAYs9TF4ctpfNnpCPAvkthxgsLbzgSCL8YwdMnBJVdjV7TDezN1FIpwub
         fWx4pVKi439c7dsgh9Xmkow9b2yg5FNM03xtl+/pX1tLoaSfUm45i1pIYewWXeNLRy
         LHLj/JxVMu8vclinyfwtELH3ePv6ZB1I5Bc4aAGLwBoM1fFn5YnTqhqewewMXtdaJe
         KSXBGZQ7XlpwpTaPFB2XJk2o3nAwHYw7k2wOIJT49H3qG9RSbjsreTKWRR/yRn8z9L
         YsoYzug9Ch1oA==
Date:   Sat, 14 May 2022 16:42:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     lars@metafoo.de, mchehab+huawei@kernel.org, ardeleanalex@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 4/6] iio: accel: bmi088: Add support for bmi085 accel
Message-ID: <20220514164244.09637098@jic23-huawei>
In-Reply-To: <20220510141753.3878390-5-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220510141753.3878390-1-Qing-wu.Li@leica-geosystems.com.cn>
        <20220510141753.3878390-5-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
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

On Tue, 10 May 2022 14:17:51 +0000
LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn> wrote:

> Add supports for BMI085, an Inertial Measurement Unit,
> with an accelerometer and gyroscope.
> The commit adds the accelerometer driver for the SPI interface.
> The gyroscope part is already supported by the BMG160 driver.
> Different from BMI088, the BMI085 accelerometer has the range of
> +/-2, 4, 6, and 8g.
> 
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>

Hi,

A request to change the ordering of id table entries below.

> ---
>  drivers/iio/accel/bmi088-accel-core.c | 7 +++++++
>  drivers/iio/accel/bmi088-accel-spi.c  | 1 +
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
> index de2385e4dad5..13bb3d96a3a6 100644
> --- a/drivers/iio/accel/bmi088-accel-core.c
> +++ b/drivers/iio/accel/bmi088-accel-core.c
> @@ -465,6 +465,13 @@ static const struct bmi088_accel_chip_info bmi088_accel_chip_info_tbl[] = {
>  		.num_channels = ARRAY_SIZE(bmi088_accel_channels),
>  		.scale_table = {{0, 897}, {0, 1795}, {0, 3590}, {0, 7179}},
>  	},
> +	[1] = {
> +		.name = "bmi085-accel",
> +		.chip_id = 0x1F,

Probably makes sense to keep these entries in order of chip_id - so leave the
order as you have it for this array.

> +		.channels = bmi088_accel_channels,
> +		.num_channels = ARRAY_SIZE(bmi088_accel_channels),
> +		.scale_table = {{0, 598}, {0, 1196}, {0, 2393}, {0, 4785}},
> +	},
>  };
>  
>  static const struct iio_info bmi088_accel_info = {
> diff --git a/drivers/iio/accel/bmi088-accel-spi.c b/drivers/iio/accel/bmi088-accel-spi.c
> index 0fed0081e1fd..e7a1daab8f3c 100644
> --- a/drivers/iio/accel/bmi088-accel-spi.c
> +++ b/drivers/iio/accel/bmi088-accel-spi.c
> @@ -61,6 +61,7 @@ static int bmi088_accel_remove(struct spi_device *spi)
>  
>  static const struct spi_device_id bmi088_accel_id[] = {
>  	{"bmi088-accel", },
> +	{"bmi085-accel", },

Alphabetical / numeric order preferred.

>  	{}
>  };
>  MODULE_DEVICE_TABLE(spi, bmi088_accel_id);

