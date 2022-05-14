Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3585272AC
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 17:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbiENPgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 11:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbiENPgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 11:36:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7293DF2B;
        Sat, 14 May 2022 08:36:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D9F560FB3;
        Sat, 14 May 2022 15:36:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B69C340EE;
        Sat, 14 May 2022 15:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652542562;
        bh=G0imUzha/YrKPnjBc6/BAOfIkMayZSvc2ZMPqH87O9Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jogRBw9ecpTke9g/kNZNaQ+RFryWgR68j/2CPEKxoIBZOEbsNwmvStVoc4plv+r4G
         kEJ/9byML0b5rpGj7v0ACwDaAQZLwzC3/jvWQbS/cxfNF5OGB5RU5rdhMncgFTCQCT
         2wfDzS8iy6lVEUNcgY/FX4//e5q1wmqp/FlFI3n04G9x73ifR+XqzsVsQ6zgmRLtB2
         gob6xpy5B25ig3AzfoHY5d4v1VmHOPXh8aIzsXviFCAoGWzqKOt653hzg9c5QNezmf
         EBAd1rdlGr1mng8njXZyC1HO5jQTBbMOYWfWM0bcJad40f1wjCFBJipK2wOhRZw14c
         9rTNWV44ts+hg==
Date:   Sat, 14 May 2022 16:44:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     lars@metafoo.de, mchehab+huawei@kernel.org, ardeleanalex@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 5/6] iio: accel: bmi088: Add support for bmi090l
 accel
Message-ID: <20220514164437.08c970ed@jic23-huawei>
In-Reply-To: <20220510141753.3878390-6-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220510141753.3878390-1-Qing-wu.Li@leica-geosystems.com.cn>
        <20220510141753.3878390-6-Qing-wu.Li@leica-geosystems.com.cn>
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

On Tue, 10 May 2022 14:17:52 +0000
LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn> wrote:

> Add supports for BMI090L, it's a high-performance Inertial
> Measurement Unit, with an accelerometer and gyroscope.
> The commit adds the accelerometer driver for the SPI interface.
> The gyroscope part is already supported by the BMG160 driver.
> Same as BMI088, BMI090L have the range of +/-3, 6, 12, and 24g.
> 
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> ---
>  drivers/iio/accel/bmi088-accel-core.c | 7 +++++++
>  drivers/iio/accel/bmi088-accel-spi.c  | 1 +
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
> index 13bb3d96a3a6..6d44e97b4906 100644
> --- a/drivers/iio/accel/bmi088-accel-core.c
> +++ b/drivers/iio/accel/bmi088-accel-core.c
> @@ -472,6 +472,13 @@ static const struct bmi088_accel_chip_info bmi088_accel_chip_info_tbl[] = {
>  		.num_channels = ARRAY_SIZE(bmi088_accel_channels),
>  		.scale_table = {{0, 598}, {0, 1196}, {0, 2393}, {0, 4785}},
>  	},
> +	[2] = {
> +		.name = "bmi090l-accel",
> +		.chip_id = 0x1A,

Either order by chip_id or by name. I don't mind which but we do want some
logical ordering in this table so we know where to put future entries.

Thanks,

Jonathan

> +		.channels = bmi088_accel_channels,
> +		.num_channels = ARRAY_SIZE(bmi088_accel_channels),
> +		.scale_table = {{0, 897}, {0, 1795}, {0, 3590}, {0, 7179}},
> +	},
>  };
>  
>  static const struct iio_info bmi088_accel_info = {
> diff --git a/drivers/iio/accel/bmi088-accel-spi.c b/drivers/iio/accel/bmi088-accel-spi.c
> index e7a1daab8f3c..58be73ebd2dd 100644
> --- a/drivers/iio/accel/bmi088-accel-spi.c
> +++ b/drivers/iio/accel/bmi088-accel-spi.c
> @@ -62,6 +62,7 @@ static int bmi088_accel_remove(struct spi_device *spi)
>  static const struct spi_device_id bmi088_accel_id[] = {
>  	{"bmi088-accel", },
>  	{"bmi085-accel", },
> +	{"bmi090l-accel", },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(spi, bmi088_accel_id);

