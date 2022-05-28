Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B209A536E10
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 20:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbiE1SYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 14:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiE1SYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 14:24:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940251706C;
        Sat, 28 May 2022 11:24:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08B3860A28;
        Sat, 28 May 2022 18:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC09C34100;
        Sat, 28 May 2022 18:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653762283;
        bh=lTcgprgf7E7dvycw+n4r2DLwvsJlX0WP7bbHfg06Rks=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JQAHGUrunVYcL6nV36GcQb9jotE6PuKQEKbfew+p+kBvTpJ7cDS4VxMVVfHUupMJl
         uTSrPFWaHQLp7SKXn/3URxwFqpsY9Q/0wxwKrm2VLOy8hqtQEN8mEm52QFD6uudy/U
         ULx5GZyHtzQzScqzO92B4guBG+DtqnzkCeokjuMlASVaH5seEE5vSPp9i5oWLZg5da
         cuuXflcNjU3b9id5WU+MXhxX1QYYNKZfD/jeMTvMd3fLcqR3iGX075NS+6OFC95QXw
         NdfEmAJirNnwpe8LwpWt/QS+EL+DuM/pqsbUhQnxtzqEnr2tKJjrXsdngivSx4gl0C
         YQZMHZ9Pw/shw==
Date:   Sat, 28 May 2022 19:33:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Message-ID: <20220528193335.646dd092@jic23-huawei>
In-Reply-To: <20220525181532.6805-3-ddrokosov@sberdevices.ru>
References: <20220525181532.6805-1-ddrokosov@sberdevices.ru>
        <20220525181532.6805-3-ddrokosov@sberdevices.ru>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 May 2022 18:15:32 +0000
Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:

> MSA311 is a tri-axial, low-g accelerometer with I2C digital output for
> sensitivity consumer applications. It has dynamical user selectable full
> scales range of +-2g/+-4g/+-8g/+-16g and allows acceleration measurements
> with output data rates from 1Hz to 1000Hz.
> 
> Datasheet can be found at following URL:
> https://cdn-shop.adafruit.com/product-files/5309/MSA311-V1.1-ENG.pdf
> 
> This driver supports following MSA311 features:
>     - IIO interface
>     - Different power modes: NORMAL and SUSPEND (using pm_runtime)
>     - ODR (Output Data Rate) selection
>     - Scale and samp_freq selection
>     - IIO triggered buffer, IIO reg access
>     - NEW_DATA interrupt + trigger
> 
> Below features to be done:
>     - Motion Events: ACTIVE, TAP, ORIENT, FREEFALL
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>

Hi Dmitry,

Various comments inline. One thing to think about is which of the comments
/ function documentation is useful and which is just stating the obvious.
If things are obvious it is usually better to not add documentation that
doesn't provide additional insight because it provides a maintenance
burden going forwards.

In a similar fashion, consider if a failure path that isn't already resulting
in a print is remotely likely.  Error messages are something else that cause
maintenance burden, so there has to be some advantage in having them to
pay that cost.

Thanks,

Jonathan

> ---
>  MAINTAINERS                |    6 +
>  drivers/iio/accel/Kconfig  |   13 +
>  drivers/iio/accel/Makefile |    2 +
>  drivers/iio/accel/msa311.c | 1525 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 1546 insertions(+)
>  create mode 100644 drivers/iio/accel/msa311.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d9b2f1731ee0..55aeb25c004c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12478,6 +12478,12 @@ F:	drivers/mtd/
>  F:	include/linux/mtd/
>  F:	include/uapi/mtd/
>  
> +MEMSENSING MICROSYSTEMS MSA311 ACCELEROMETER DRIVER
> +M:	Dmitry Rokosov <ddrokosov@sberdevices.ru>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	drivers/iio/accel/msa311.c
> +
>  MEN A21 WATCHDOG DRIVER
>  M:	Johannes Thumshirn <morbidrsa@gmail.com>
>  L:	linux-watchdog@vger.kernel.org
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 49587c992a6d..88a265b75eed 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -508,6 +508,19 @@ config MMA9553
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called mma9553.
>  
> +config MSA311
> +	tristate "MEMSensing Digital 3-Axis Accelerometer Driver"
> +	depends on I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	select REGMAP_I2C
> +	help
> +	  Say yes here to build support for the MEMSensing MSA311
> +	  accelerometer driver.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called msa311.
> +
>  config MXC4005
>  	tristate "Memsic MXC4005XC 3-Axis Accelerometer Driver"
>  	depends on I2C
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index d03e2f6bba08..b1ddcaa811b6 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -55,6 +55,8 @@ obj-$(CONFIG_MMA9551_CORE)	+= mma9551_core.o
>  obj-$(CONFIG_MMA9551)		+= mma9551.o
>  obj-$(CONFIG_MMA9553)		+= mma9553.o
>  
> +obj-$(CONFIG_MSA311)		+= msa311.o
> +
>  obj-$(CONFIG_MXC4005)		+= mxc4005.o
>  obj-$(CONFIG_MXC6255)		+= mxc6255.o
>  
> diff --git a/drivers/iio/accel/msa311.c b/drivers/iio/accel/msa311.c
> new file mode 100644
> index 000000000000..fe2cff1ed5ef
> --- /dev/null
> +++ b/drivers/iio/accel/msa311.c
> @@ -0,0 +1,1525 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * msa311.c - MEMSensing digital 3-Axis accelerometer
> + *
> + * MSA311 is a tri-axial, low-g accelerometer with I2C digital output for
> + * sensitivity consumer applications. It has dynamical user selectable full
> + * scales range of +-2g/+-4g/+-8g/+-16g and allows acceleration measurements
> + * with output data rates from 1Hz to 1000Hz.
> + *
> + * MSA311 is available in an ultra small (2mm x 2mm, height 0.95mm) LGA package
> + * and is guaranteed to operate over -40C to +85C.
> + *
> + * This driver supports following MSA311 features:
> + *     - IIO interface
> + *     - Different power modes: NORMAL, SUSPEND
> + *     - ODR (Output Data Rate) selection
> + *     - Scale selection
> + *     - IIO triggered buffer
> + *     - NEW_DATA interrupt + trigger
> + *
> + * Below features to be done:
> + *     - Motion Events: ACTIVE, TAP, ORIENT, FREEFALL
> + *
> + * Copyright (c) 2022, SberDevices. All Rights Reserved.
> + *
> + * Author: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/pm.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +
> +/* Register map */
> +
> +#define MSA311_SOFT_RESET_REG     0x00
> +#define MSA311_PARTID_REG         0x01
> +#define MSA311_ACC_X_REG          0x02
> +#define MSA311_ACC_Y_REG          0x04
> +#define MSA311_ACC_Z_REG          0x06
> +#define MSA311_MOTION_INT_REG     0x09
> +#define MSA311_DATA_INT_REG       0x0A
> +#define MSA311_TAP_ACTIVE_STS_REG 0x0B
> +#define MSA311_ORIENT_STS_REG     0x0C
> +#define MSA311_RANGE_REG          0x0F
> +#define MSA311_ODR_REG            0x10
> +#define MSA311_PWR_MODE_REG       0x11
> +#define MSA311_SWAP_POLARITY_REG  0x12
> +#define MSA311_INT_SET_0_REG      0x16
> +#define MSA311_INT_SET_1_REG      0x17
> +#define MSA311_INT_MAP_0_REG      0x19
> +#define MSA311_INT_MAP_1_REG      0x1A
> +#define MSA311_INT_CONFIG_REG     0x20
> +#define MSA311_INT_LATCH_REG      0x21
> +#define MSA311_FREEFALL_DUR_REG   0x22
> +#define MSA311_FREEFALL_TH_REG    0x23
> +#define MSA311_FREEFALL_HY_REG    0x24
> +#define MSA311_ACTIVE_DUR_REG     0x27
> +#define MSA311_ACTIVE_TH_REG      0x28
> +#define MSA311_TAP_DUR_REG        0x2A
> +#define MSA311_TAP_TH_REG         0x2B
> +#define MSA311_ORIENT_HY_REG      0x2C
> +#define MSA311_Z_BLOCK_REG        0x2D
> +#define MSA311_OFFSET_X_REG       0x38
> +#define MSA311_OFFSET_Y_REG       0x39
> +#define MSA311_OFFSET_Z_REG       0x3A
> +
> +enum msa311_fields {
> +	F_SOFT_RESET_I2C, F_SOFT_RESET_SPI,
> +
> +	F_ORIENT_INT, F_S_TAP_INT, F_D_TAP_INT, F_ACTIVE_INT, F_FREEFALL_INT,
> +
> +	F_NEW_DATA_INT,
> +
> +	F_TAP_SIGN, F_TAP_FIRST_X, F_TAP_FIRST_Y, F_TAP_FIRST_Z, F_ACTV_SIGN,
> +	F_ACTV_FIRST_X, F_ACTV_FIRST_Y, F_ACTV_FIRST_Z,
> +
> +	F_ORIENT_Z, F_ORIENT_X_Y,
> +
> +	F_FS,
> +
> +	F_X_AXIS_DIS, F_Y_AXIS_DIS, F_Z_AXIS_DIS, F_ODR,
> +
> +	F_PWR_MODE, F_LOW_POWER_BW,
> +
> +	F_X_POLARITY, F_Y_POLARITY, F_Z_POLARITY, F_X_Y_SWAP,
> +
> +	F_ORIENT_INT_EN, F_S_TAP_INT_EN, F_D_TAP_INT_EN, F_ACTIVE_INT_EN_Z,
> +	F_ACTIVE_INT_EN_Y, F_ACTIVE_INT_EN_X,
> +
> +	F_NEW_DATA_INT_EN, F_FREEFALL_INT_EN,
> +
> +	F_INT1_ORIENT, F_INT1_S_TAP, F_INT1_D_TAP, F_INT1_ACTIVE,
> +	F_INT1_FREEFALL,
> +
> +	F_INT1_NEW_DATA,
> +
> +	F_INT1_OD, F_INT1_LVL,
> +
> +	F_RESET_INT, F_LATCH_INT,
> +
> +	F_FREEFALL_MODE, F_FREEFALL_HY,
> +
> +	F_ACTIVE_DUR,
> +
> +	F_TAP_QUIET, F_TAP_SHOCK, F_TAP_DUR,
> +
> +	F_TAP_TH,
> +
> +	F_ORIENT_HYST, F_ORIENT_BLOCKING, F_ORIENT_MODE,
> +
> +	F_Z_BLOCKING,
> +
> +	F_MAX_FIELDS,
> +};
> +
> +static const struct reg_field msa311_reg_fields[] = {
> +	[F_SOFT_RESET_I2C] = REG_FIELD(MSA311_SOFT_RESET_REG, 2, 2),
> +	[F_SOFT_RESET_SPI] = REG_FIELD(MSA311_SOFT_RESET_REG, 5, 5),
> +
> +	[F_ORIENT_INT] = REG_FIELD(MSA311_MOTION_INT_REG, 6, 6),
> +	[F_S_TAP_INT] = REG_FIELD(MSA311_MOTION_INT_REG, 5, 5),
> +	[F_D_TAP_INT] = REG_FIELD(MSA311_MOTION_INT_REG, 4, 4),
> +	[F_ACTIVE_INT] = REG_FIELD(MSA311_MOTION_INT_REG, 2, 2),
> +	[F_FREEFALL_INT] = REG_FIELD(MSA311_MOTION_INT_REG, 0, 0),
> +
> +	[F_NEW_DATA_INT] = REG_FIELD(MSA311_DATA_INT_REG, 0, 0),
> +
> +	[F_TAP_SIGN] = REG_FIELD(MSA311_TAP_ACTIVE_STS_REG, 7, 7),
> +	[F_TAP_FIRST_X] = REG_FIELD(MSA311_TAP_ACTIVE_STS_REG, 6, 6),
> +	[F_TAP_FIRST_Y] = REG_FIELD(MSA311_TAP_ACTIVE_STS_REG, 5, 5),
> +	[F_TAP_FIRST_Z] = REG_FIELD(MSA311_TAP_ACTIVE_STS_REG, 4, 4),
> +	[F_ACTV_SIGN] = REG_FIELD(MSA311_TAP_ACTIVE_STS_REG, 3, 3),
> +	[F_ACTV_FIRST_X] = REG_FIELD(MSA311_TAP_ACTIVE_STS_REG, 2, 2),
> +	[F_ACTV_FIRST_Y] = REG_FIELD(MSA311_TAP_ACTIVE_STS_REG, 1, 1),
> +	[F_ACTV_FIRST_Z] = REG_FIELD(MSA311_TAP_ACTIVE_STS_REG, 0, 0),
> +
> +	[F_ORIENT_Z] = REG_FIELD(MSA311_ORIENT_STS_REG, 6, 6),
> +	[F_ORIENT_X_Y] = REG_FIELD(MSA311_ORIENT_STS_REG, 4, 5),
> +
> +	[F_FS] = REG_FIELD(MSA311_RANGE_REG, 0, 1),
> +
> +	[F_X_AXIS_DIS] = REG_FIELD(MSA311_ODR_REG, 7, 7),
> +	[F_Y_AXIS_DIS] = REG_FIELD(MSA311_ODR_REG, 6, 6),
> +	[F_Z_AXIS_DIS] = REG_FIELD(MSA311_ODR_REG, 5, 5),
> +	[F_ODR] = REG_FIELD(MSA311_ODR_REG, 0, 3),
> +
> +	[F_PWR_MODE] = REG_FIELD(MSA311_PWR_MODE_REG, 6, 7),
> +	[F_LOW_POWER_BW] = REG_FIELD(MSA311_PWR_MODE_REG, 1, 4),
> +
> +	[F_X_POLARITY] = REG_FIELD(MSA311_SWAP_POLARITY_REG, 3, 3),
> +	[F_Y_POLARITY] = REG_FIELD(MSA311_SWAP_POLARITY_REG, 2, 2),
> +	[F_Z_POLARITY] = REG_FIELD(MSA311_SWAP_POLARITY_REG, 1, 1),
> +	[F_X_Y_SWAP] = REG_FIELD(MSA311_SWAP_POLARITY_REG, 0, 0),
> +
> +	[F_ORIENT_INT_EN] = REG_FIELD(MSA311_INT_SET_0_REG, 6, 6),
> +	[F_S_TAP_INT_EN] = REG_FIELD(MSA311_INT_SET_0_REG, 5, 5),
> +	[F_D_TAP_INT_EN] = REG_FIELD(MSA311_INT_SET_0_REG, 4, 4),
> +	[F_ACTIVE_INT_EN_Z] = REG_FIELD(MSA311_INT_SET_0_REG, 2, 2),
> +	[F_ACTIVE_INT_EN_Y] = REG_FIELD(MSA311_INT_SET_0_REG, 1, 1),
> +	[F_ACTIVE_INT_EN_X] = REG_FIELD(MSA311_INT_SET_0_REG, 0, 0),
> +
> +	[F_NEW_DATA_INT_EN] = REG_FIELD(MSA311_INT_SET_1_REG, 4, 4),
> +	[F_FREEFALL_INT_EN] = REG_FIELD(MSA311_INT_SET_1_REG, 3, 3),
> +
> +	[F_INT1_ORIENT] = REG_FIELD(MSA311_INT_MAP_0_REG, 6, 6),
> +	[F_INT1_S_TAP] = REG_FIELD(MSA311_INT_MAP_0_REG, 5, 5),
> +	[F_INT1_D_TAP] = REG_FIELD(MSA311_INT_MAP_0_REG, 4, 4),
> +	[F_INT1_ACTIVE] = REG_FIELD(MSA311_INT_MAP_0_REG, 2, 2),
> +	[F_INT1_FREEFALL] = REG_FIELD(MSA311_INT_MAP_0_REG, 0, 0),
> +
> +	[F_INT1_NEW_DATA] = REG_FIELD(MSA311_INT_MAP_1_REG, 0, 0),
> +
> +	[F_INT1_OD] = REG_FIELD(MSA311_INT_CONFIG_REG, 1, 1),
> +	[F_INT1_LVL] = REG_FIELD(MSA311_INT_CONFIG_REG, 0, 0),
> +
> +	[F_RESET_INT] = REG_FIELD(MSA311_INT_LATCH_REG, 7, 7),
> +	[F_LATCH_INT] = REG_FIELD(MSA311_INT_LATCH_REG, 0, 3),
> +
> +	[F_FREEFALL_MODE] = REG_FIELD(MSA311_FREEFALL_HY_REG, 2, 2),
> +	[F_FREEFALL_HY] = REG_FIELD(MSA311_FREEFALL_HY_REG, 0, 1),
> +
> +	[F_ACTIVE_DUR] = REG_FIELD(MSA311_ACTIVE_DUR_REG, 0, 1),
> +
> +	[F_TAP_QUIET] = REG_FIELD(MSA311_TAP_DUR_REG, 7, 7),
> +	[F_TAP_SHOCK] = REG_FIELD(MSA311_TAP_DUR_REG, 6, 6),
> +	[F_TAP_DUR] = REG_FIELD(MSA311_TAP_DUR_REG, 0, 2),
> +
> +	[F_TAP_TH] = REG_FIELD(MSA311_TAP_TH_REG, 0, 4),
> +
> +	[F_ORIENT_HYST] = REG_FIELD(MSA311_ORIENT_HY_REG, 4, 6),
> +	[F_ORIENT_BLOCKING] = REG_FIELD(MSA311_ORIENT_HY_REG, 2, 3),
> +	[F_ORIENT_MODE] = REG_FIELD(MSA311_ORIENT_HY_REG, 0, 1),
> +
> +	[F_Z_BLOCKING] = REG_FIELD(MSA311_Z_BLOCK_REG, 0, 3),
> +};
> +
> +#define MSA311_WHO_AM_I 0x13
> +
> +/*
> + * Possible Full Scale ranges
> + *
> + * Axis data is 12-bit signed value, so
> + *
> + * fs0 = (2 + 2) * 9.81 / (2<<11) = 0.009580
> + * fs1 = (4 + 4) * 9.81 / (2<<11) = 0.019160
> + * fs2 = (8 + 8) * 9.81 / (2<<11) = 0.038320
> + * fs3 = (16 + 16) * 9.81 / (2<<11) = 0.076641
> + */
> +enum {
> +	MSA311_FS_2G,
> +	MSA311_FS_4G,
> +	MSA311_FS_8G,
> +	MSA311_FS_16G,
> +};
> +
> +static const struct {
> +	int val;
> +	int val2;
> +} msa311_fs_table[] = {
> +	{0, 9580}, {0, 19160}, {0, 38320}, {0, 76641}
> +};
> +
> +/* Possible Output Data Rate values */
> +enum {
> +	MSA311_ODR_1_HZ,
> +	MSA311_ODR_1_95_HZ,
> +	MSA311_ODR_3_9_HZ,
> +	MSA311_ODR_7_81_HZ,
> +	MSA311_ODR_15_63_HZ,
> +	MSA311_ODR_31_25_HZ,
> +	MSA311_ODR_62_5_HZ,
> +	MSA311_ODR_125_HZ,
> +	MSA311_ODR_250_HZ,
> +	MSA311_ODR_500_HZ,
> +	MSA311_ODR_1000_HZ,
> +};
> +
> +static const struct {
> +	int val;
> +	int val2;
> +} msa311_odr_table[] = {
> +	{1, 0}, {1, 950000}, {3, 900000}, {7, 810000}, {15, 630000},
> +	{31, 250000}, {62, 500000}, {125, 0}, {250, 0}, {500, 0}, {1000, 0}
> +};
> +
> +/* All Power Modes */
> +#define MSA311_PWR_MODE_NORMAL  0b00
> +#define MSA311_PWR_MODE_SUSPEND 0b11
> +
> +/* Autosuspend delay */
> +#define MSA311_PWR_SLEEP_DELAY_MS 2000
> +
> +/* Possible INT1 types and levels */
> +enum {
> +	MSA311_INT1_OD_PUSH_PULL,
> +	MSA311_INT1_OD_OPEN_DRAIN,
> +};
> +
> +enum {
> +	MSA311_INT1_LVL_LOW,
> +	MSA311_INT1_LVL_HIGH,
> +};
> +
> +/* Latch INT modes */
> +#define MSA311_LATCH_INT_NOT_LATCHED 0b0000
> +#define MSA311_LATCH_INT_250MS       0b0001
> +#define MSA311_LATCH_INT_500MS       0b0010
> +#define MSA311_LATCH_INT_1S          0b0011
> +#define MSA311_LATCH_INT_2S          0b0100
> +#define MSA311_LATCH_INT_4S          0b0101
> +#define MSA311_LATCH_INT_8S          0b0110
> +#define MSA311_LATCH_INT_1MS         0b1010
> +#define MSA311_LATCH_INT_2MS         0b1011
> +#define MSA311_LATCH_INT_25MS        0b1100
> +#define MSA311_LATCH_INT_50MS        0b1101
> +#define MSA311_LATCH_INT_100MS       0b1110
> +#define MSA311_LATCH_INT_LATCHED     0b0111
> +
> +static const struct regmap_range msa311_readonly_registers[] = {
> +	regmap_reg_range(MSA311_PARTID_REG, MSA311_ORIENT_STS_REG),
> +};
> +
> +static const struct regmap_access_table msa311_writeable_table = {
> +	.no_ranges = msa311_readonly_registers,
> +	.n_no_ranges = ARRAY_SIZE(msa311_readonly_registers),
> +};
> +
> +static const struct regmap_range msa311_writeonly_registers[] = {
> +	regmap_reg_range(MSA311_SOFT_RESET_REG, MSA311_SOFT_RESET_REG),
> +};
> +
> +static const struct regmap_access_table msa311_readable_table = {
> +	.no_ranges = msa311_writeonly_registers,
> +	.n_no_ranges = ARRAY_SIZE(msa311_writeonly_registers),
> +};
> +
> +static const struct regmap_range msa311_volatile_registers[] = {
> +	regmap_reg_range(MSA311_ACC_X_REG, MSA311_ORIENT_STS_REG),
> +};
> +
> +static const struct regmap_access_table msa311_volatile_table = {
> +	.yes_ranges = msa311_volatile_registers,
> +	.n_yes_ranges = ARRAY_SIZE(msa311_volatile_registers),
> +};
> +
> +static const struct regmap_config msa311_regmap_config = {
> +	.name = "msa311",
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = MSA311_OFFSET_Z_REG,
> +	.wr_table = &msa311_writeable_table,
> +	.rd_table = &msa311_readable_table,
> +	.volatile_table = &msa311_volatile_table,
> +	.cache_type = REGCACHE_RBTREE,
> +};
> +
> +/**
> + * MSA311_GENMASK() - MSA311 reg_field mask generator
> + * @field: requested regfield from msa311_reg_fields table
> + *
> + * Return: This helper returns reg_field mask to be applied.
> + */
> +#define MSA311_GENMASK(field) ({                \
> +	typeof(field) _field = (field);       \
> +	GENMASK(msa311_reg_fields[_field].msb,  \
> +		msa311_reg_fields[_field].lsb); \
> +})
> +
> +/**
> + * struct msa311_priv - MSA311 internal private state
> + * @i2c: I2C client object
> + * @lock: Protects msa311 device state between setup and data access routines
> + *        (power transitions, samp_freq/scale tune, retrieving axes data, etc)
> + * @new_data_trig: Optional NEW_DATA interrupt driven trigger used
> + *                 to notify external consumers a new sample is ready
> + * @regs: Underlying I2C bus adapter used to abstract slave
> + *        register accesses
> + * @fields: Abstract objects for each registers fields access
> + */
> +struct msa311_priv {
> +	struct i2c_client *i2c;
> +	struct mutex lock; /* state guard */
> +
> +	struct iio_trigger *new_data_trig;
> +
> +	struct regmap *regs;
> +	struct regmap_field *fields[F_MAX_FIELDS];
> +};
> +
> +/* Channels */
> +
> +enum msa311_si {
> +	MSA311_SI_X,
> +	MSA311_SI_Y,
> +	MSA311_SI_Z,
> +	MSA311_SI_TIMESTAMP,
> +};
> +
> +/**
> + * MSA311_ACCEL_CHANNEL() - Construct MSA311 accelerometer channel descriptor
> + * @axis: axis name in uppercase
> + */
> +#define MSA311_ACCEL_CHANNEL(axis) {                                       \
> +	.type = IIO_ACCEL,                                                 \
> +	.modified = 1,                                                     \
> +	.channel2 = IIO_MOD_##axis,                                        \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),                      \
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE) |              \
> +				   BIT(IIO_CHAN_INFO_SAMP_FREQ),           \
> +	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SCALE) |    \
> +					     BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +	.scan_index = MSA311_SI_##axis,                                    \
> +	.scan_type = {                                                     \
> +		.sign = 's',                                               \
> +		.realbits = 12,                                            \
> +		.storagebits = 16,                                         \
> +		.shift = 4,                                                \
> +		.endianness = IIO_LE,                                      \
> +	},                                                                 \
> +	.datasheet_name = "ACC_"#axis                                      \
> +}
> +
> +/**
> + * MSA311_TIMESTAMP_CHANNEL() - Construct MSA311 timestamp channel descriptor
> + */
Documentation doesn't add anything that isn't clear from the code.
Whilst this may seem harmless, having unnecessary documentation adds
to the potential for it to become actively misleading if it is not
updated in future.  As such, we tend to use comments only where there
is something non obvious to convey.

> +#define MSA311_TIMESTAMP_CHANNEL() IIO_CHAN_SOFT_TIMESTAMP(MSA311_SI_TIMESTAMP)

Just put this inline where used, there is no benefit in having a macro
for it. 

> +
> +static const struct iio_chan_spec msa311_channels[] = {
> +	MSA311_ACCEL_CHANNEL(X),
> +	MSA311_ACCEL_CHANNEL(Y),
> +	MSA311_ACCEL_CHANNEL(Z),
> +	MSA311_TIMESTAMP_CHANNEL(),
> +};
> +
> +/**
> + * msa311_get_odr() - Read Output Data Rate (ODR) value from MSA311 accel
> + * @msa311: MSA311 internal private state
> + * @odr: output ODR value
> + *
> + * This function should be called under msa311->lock.
> + *
> + * Return: 0 on success, -ERRNO in other failures
> + */
> +static inline int msa311_get_odr(struct msa311_priv *msa311, unsigned int *odr)
> +{
> +	int err;
> +
> +	err = regmap_field_read(msa311->fields[F_ODR], odr);
> +	if (err) {
> +		dev_err(&msa311->i2c->dev, "failed to read odr value (%d)\n",
> +			err);
> +		return err;
> +	}
> +
> +	/**
> +	 * Filter the same 1000Hz ODR register values based on datasheet info.
> +	 * ODR can be equal to 1010-1111 for 1000Hz, but function returns 1010
> +	 * all the time.
> +	 */
> +	if (*odr > MSA311_ODR_1000_HZ)
> +		*odr = MSA311_ODR_1000_HZ;
> +
> +	return err;
> +}
> +
> +/**
> + * msa311_set_odr() - Setup Output Data Rate (ODR) value for MSA311 accel
> + * @msa311: MSA311 internal private state
> + * @odr: requested ODR value
> + *
> + * This function should be called under msa311->lock. Possible ODR values:
> + *     - 1Hz (not available in normal mode)
> + *     - 1.95Hz (not available in normal mode)
> + *     - 3.9Hz
> + *     - 7.81Hz
> + *     - 15.63Hz
> + *     - 31.25Hz
> + *     - 62.5Hz
> + *     - 125Hz
> + *     - 250Hz
> + *     - 500Hz
> + *     - 1000Hz
> + *
> + * Return: 0 on success, -EINVAL for bad ODR value in the certain power mode,
> + *         -ERRNO in other failures
> + */
> +static inline int msa311_set_odr(struct msa311_priv *msa311, unsigned int odr)
> +{
> +	const char *mode = NULL;
> +	unsigned int pwr_mode;
> +	bool good_odr = false;
> +	int err;
> +
> +	err = regmap_field_read(msa311->fields[F_PWR_MODE], &pwr_mode);
> +	if (err) {
> +		dev_err(&msa311->i2c->dev, "failed to read pwr_mode (%d)\n",
> +			err);
> +		return err;
> +	}
> +
> +	/* Filter bad ODR values */
> +	switch (pwr_mode) {
> +	case MSA311_PWR_MODE_NORMAL:
> +		mode = "normal";
> +		good_odr = (odr > MSA311_ODR_1_95_HZ);
> +		break;
> +	case MSA311_PWR_MODE_SUSPEND:
> +		mode = "suspend";
> +		break;
> +	default:
> +		mode = "unknown";
> +		break;
> +	}
> +
> +	if (!good_odr) {
> +		return dev_err_probe(&msa311->i2c->dev, -EINVAL,

You should only use dev_err_probe() in functions exclusively called
from the probe path.  It's there to provide special handling for deferred
probing so doesn't make a lot of sense eslewhere.

> +			"failed to set odr %u.%uHz, not available in %s mode\n",
> +			msa311_odr_table[odr].val,
> +			msa311_odr_table[odr].val2 / 1000, mode);
> +	}
> +
> +	err = regmap_field_write(msa311->fields[F_ODR], odr);
> +	if (err)
> +		return dev_err_probe(&msa311->i2c->dev, err,
> +				     "failed to set odr value (%d)\n", err);
> +
> +	return 0;
> +}
> +


> +static int msa311_read_raw_data(struct msa311_priv *msa311,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2)
> +{
> +	__le16 axis;
> +	int err;
> +
> +	err = pm_runtime_resume_and_get(&msa311->i2c->dev);
> +	if (err) {
> +		dev_err(&msa311->i2c->dev, "failed powerup (%d)\n", err);
> +		return err;
> +	}
> +
> +	mutex_lock(&msa311->lock);
> +	err = msa311_get_axis(msa311, chan, &axis);
> +	if (err) {
> +		dev_err(&msa311->i2c->dev,
> +			"cannot get axis %s (%d)\n",
> +			chan->datasheet_name, err);
> +		mutex_unlock(&msa311->lock);
> +		return err;
> +	}
> +	mutex_unlock(&msa311->lock);
move lock above if (err) to simplify error handling.

> +
> +	pm_runtime_mark_last_busy(&msa311->i2c->dev);
> +	pm_runtime_put_autosuspend(&msa311->i2c->dev);
> +
> +	/*
> +	 * Axis data format is:
> +	 * ACC_X = (ACC_X_MSB[7:0] << 4) | ACC_X_LSB[7:4]
> +	 */
> +	*val = sign_extend32(le16_to_cpu(axis) >> chan->scan_type.shift,
> +			     chan->scan_type.realbits - 1);
> +	*val2 = 0;

val2 is never used by the IIO core, so shouldn't be necessary to clear it.

> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int msa311_read_scale(struct msa311_priv *msa311, int *val, int *val2)
> +{
> +	unsigned int fs;
> +	int err;
> +
> +	mutex_lock(&msa311->lock);
> +	err = regmap_field_read(msa311->fields[F_FS], &fs);
> +	if (err) {
> +		dev_err(&msa311->i2c->dev,
> +			"cannot get actual scale (%d)\n", err);
> +		mutex_unlock(&msa311->lock);
> +		return err;
> +	}
> +	mutex_unlock(&msa311->lock);

move lock above the if (err)

> +
> +	*val = msa311_fs_table[fs].val;
> +	*val2 = msa311_fs_table[fs].val2;
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +static int msa311_read_samp_freq(struct msa311_priv *msa311,
> +				 int *val, int *val2)
> +{
> +	unsigned int odr;
> +	int err;
> +
> +	mutex_lock(&msa311->lock);
> +	err = msa311_get_odr(msa311, &odr);
> +	if (err) {
> +		dev_err(&msa311->i2c->dev,
> +			"cannot get actual freq (%d)\n", err);
> +		mutex_unlock(&msa311->lock);
> +		return err;
> +	}
> +	mutex_unlock(&msa311->lock);

Move lock above the if (err)

> +
> +	*val = msa311_odr_table[odr].val;
> +	*val2 = msa311_odr_table[odr].val2;
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +

> +/**
> + * msa311_read_avail() - IIO interface to request available device attr values
> + * @indio_dev: The IIO device associated with MSA311
> + * @chan: IIO channel specification
> + * @vals: Available device attr values
> + * @type: The type of the vals
> + * @length: Attr values array size
> + * @mask: Attr value type selector
> + *
> + * Return: IIO_AVAIL_LIST specificator on success,
> + *         -EINVAL for unknown attr value type (bad mask),

I'd not bother with this level of documentation. It's not adding anything
that can't be seen by glancing at the code below.

Worth thinking about many of the other cases as well. Any documentation
is something that has to be maintained and reviewed.  If it's not there
then that becomes a lot easier :)

Obviously there is a trade off though as good documentation will
call out the non obvious for the reader.
> + */
> +static int msa311_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type,
> +			     int *length, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*vals = (int *)msa311_odr_table;
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		/* ODR value has 2 ints (integer and fractional parts) */
> +		*length = ARRAY_SIZE(msa311_odr_table) * 2;
> +		return IIO_AVAIL_LIST;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*vals = (int *)msa311_fs_table;
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		/* FS value has 2 ints (integer and fractional parts) */
> +		*length = ARRAY_SIZE(msa311_fs_table) * 2;
> +		return IIO_AVAIL_LIST;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +


> +/**
> + * msa311_write_raw() - IIO interface function to write attr/accel data
> + * @indio_dev: The IIO device associated with MSA311
> + * @chan: IIO channel specification
> + * @val: Input data value, first part
> + * @val2: Input data value, second part
> + * @mask: Value type selector
> + *
> + * Return: 0 on success,
> + *         -EINVAL for unknown value type (bad mask),
> + *         -ERRNO in other failures
> + */
> +static int msa311_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	struct msa311_priv *msa311 = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		if (iio_buffer_enabled(indio_dev))

This races.  We have
iio_device_claim_direct_mode() and the matching
release to avoid such races.  They will ensure we are in
a mode where the buffer isn't enabled for the duration of
any action like this. 


Mind you, why can't we write the scale while the buffer is turned on?
It might be unwise given no way of knowing when it applies, but
that is a problem for userspace dumb enough to do it ;)

If there is a reason to not do so, good to add a comment here
to say why not.  Same obviously applies to sampling frequency below.


> +			return -EBUSY;
> +
> +		return msa311_write_scale(msa311, val, val2);
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (iio_buffer_enabled(indio_dev))
> +			return -EBUSY;
> +
> +		return msa311_write_samp_freq(msa311, val, val2);
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}


> +/**
> + * msa311_buffer_postdisable() - IIO buffer interface postdisable actions
> + * @indio_dev: The IIO device associated with MSA311
> + *
> + * Return: 0 on success,
> + *         -ERRNO in other failures

I wouldn't document return values for these - particularly as it's
wrong in this case.

In general, I would advise not provide any documentation for short and obvious
functions.  The code and naming should provide enough in many cases.

> + */
> +static int msa311_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct msa311_priv *msa311 = iio_priv(indio_dev);
> +
> +	pm_runtime_mark_last_busy(&msa311->i2c->dev);
> +	pm_runtime_put_autosuspend(&msa311->i2c->dev);
> +
> +	return 0;
> +}
> +

> +/**
> + * msa311_validate_device() - IIO trigger interface to validate requested device
> + * @trig: Appropriate IIO trigger
> + * @indio_dev: Requested IIO device
> + *
> + * Return: 0 on success,
> + *         -EINVAL when indio_dev isn't linked with appropriate trigger
> + */
> +static int msa311_validate_device(struct iio_trigger *trig,
> +				  struct iio_dev *indio_dev)
> +{
> +	struct iio_dev *indio = iio_trigger_get_drvdata(trig);
> +
> +	if (indio != indio_dev)

Give these clearer names or avoid the local variable so it
is obvious.

	if (indio != iio_trigger_get_drvdata())

for example.

> +		return -EINVAL;
> +
> +	return 0;
> +}
> +

...

> +/**
> + * msa311_check_partid() - Check MSA311 WHO_AM_I identifier.
> + * @msa311: MSA311 internal private state
> + *
> + * Return: 0 on success (MSA311 device was found on the I2C bus)
> + *         0 with warning notice when MSA311 device was found on the I2C bus,
> + *         but chipid has not expected value
> + *         -ERRNO in other failures
> + */
> +static int msa311_check_partid(struct msa311_priv *msa311)
> +{
> +	struct device *dev = &msa311->i2c->dev;
> +	unsigned int partid;
> +	int err;
> +
> +	err = regmap_read(msa311->regs, MSA311_PARTID_REG, &partid);
> +	if (err)
> +		return dev_err_probe(dev, err,
> +				     "failed to read partid (%d)\n", err);
> +
> +	dev_info(dev, "Found MSA311 compatible chip[%#x]\n", partid);
This is noise that we generally try to avoid in drivers.

The log on systems is long enough as it is without needing to log
success conditions.  dev_dbg is fine if you want to provide a way
of getting to this.

> +
> +	if (partid != MSA311_WHO_AM_I)
> +		dev_warn(dev, "invalid partid (%#x), expected (%#x)\n",
> +			 partid, MSA311_WHO_AM_I);
> +
> +	return 0;
> +}
> +
> +/**
> + * msa311_chip_init() - MSA311 chip initialization sequence
> + * @msa311: MSA311 internal private state
> + *
> + * We do not need to hold msa311->lock here, because this function is used
> + * during I2C driver probing process only.
> + *
> + * Return: 0 on success, -ERRNO in other failures
> + */
> +static int msa311_chip_init(struct msa311_priv *msa311)
> +{
> +	int err;
> +
> +	err = msa311_check_partid(msa311);
> +	if (err)
> +		return err;
> +
> +	/* Soft reset */
> +	err = regmap_write(msa311->regs, MSA311_SOFT_RESET_REG,
> +			   MSA311_GENMASK(F_SOFT_RESET_I2C) |
> +			   MSA311_GENMASK(F_SOFT_RESET_SPI));
> +	if (err)
> +		return dev_err_probe(&msa311->i2c->dev, err,

A local
struct device *dev; variable will make these all a little more readable.

> +				     "cannot soft reset all logic (%d)\n", err);
> +
> +	err = msa311_set_pwr_mode(msa311, MSA311_PWR_MODE_NORMAL);
> +	if (err)
> +		return dev_err_probe(&msa311->i2c->dev, err,
> +				     "bad normal mode transition (%d)\n", err);
> +
> +	err = regmap_write(msa311->regs, MSA311_RANGE_REG, MSA311_FS_16G);
> +	if (err)
> +		return dev_err_probe(&msa311->i2c->dev, err,
> +				     "failed to setup accel range (%d)\n", err);
> +
> +	/* Disable all interrupts by default */
> +	err = regmap_write(msa311->regs, MSA311_INT_SET_0_REG, 0);
> +	if (err)
> +		return dev_err_probe(&msa311->i2c->dev, err,
> +				     "cannot disable set0 intrs (%d)\n", err);
> +
> +	err = regmap_write(msa311->regs, MSA311_INT_SET_1_REG, 0);
> +	if (err)
> +		return dev_err_probe(&msa311->i2c->dev, err,
> +				     "cannot disable set1 intrs (%d)\n", err);
> +
> +	/* Unmap all INT1 interrupts by default */
> +	err = regmap_write(msa311->regs, MSA311_INT_MAP_0_REG, 0);
> +	if (err)
> +		return dev_err_probe(&msa311->i2c->dev, err,
> +				     "failed to unmap map0 intrs (%d)\n", err);
> +
> +	err = regmap_write(msa311->regs, MSA311_INT_MAP_1_REG, 0);
> +	if (err)
> +		return dev_err_probe(&msa311->i2c->dev, err,
> +				     "failed to unmap map1 intrs (%d)\n", err);
> +
> +	/* Disable all axis by default */
> +	err = regmap_update_bits(msa311->regs, MSA311_ODR_REG,
> +				 MSA311_GENMASK(F_X_AXIS_DIS) |
> +				 MSA311_GENMASK(F_Y_AXIS_DIS) |
> +				 MSA311_GENMASK(F_Z_AXIS_DIS), 0);
> +	if (err)
> +		return dev_err_probe(&msa311->i2c->dev, err,
> +				     "cannot enable all axes (%d)\n", err);
> +
> +	err = msa311_set_odr(msa311, MSA311_ODR_125_HZ);
> +	if (err)
> +		return dev_err_probe(&msa311->i2c->dev, err,
> +				     "failed to set accel freq (%d)\n", err);
> +
> +	return 0;
> +}
> +
> +/**
> + * msa311_setup_interrupts() - MSA311 interrupts initialization sequence
> + * @msa311: MSA311 internal private state
> + *
> + * We register new data trigger firstly and then setup MSA311 int registers.
> + * This function does not need to hold msa311->lock, because it is used
> + * during I2C driver probing process only.
> + *
> + * Return: 0 on success, -ERRNO in other failures
> + */
> +static int msa311_setup_interrupts(struct msa311_priv *msa311)
> +{
> +	struct iio_trigger *trig;
> +	struct i2c_client *i2c = msa311->i2c;
> +	struct iio_dev *indio_dev = i2c_get_clientdata(i2c);
> +	struct device *dev = &i2c->dev;
> +	int err;
> +
> +	err = devm_request_threaded_irq(dev, i2c->irq,
> +					NULL, msa311_irq_thread,
> +					IRQF_TRIGGER_RISING | IRQF_ONESHOT,

Should leave the 'rising' part to be specified by the firmware (e.g. DT)
If someone happens to have an inverter in the way (common for cheap
level shifting) then the direction of this will be the opposite.

If you don't specify it here, it should get picked up from DT IIRC.

We have this wrong in a lot of drivers, but can't easily fix it
after the event without possibly breaking boards relying on it.

> +					i2c->name,
> +					indio_dev);
> +	if (err)
> +		return dev_err_probe(dev, err,
> +				     "failed to request irq (%d)\n", err);
> +
> +	trig = devm_iio_trigger_alloc(dev, "%s-new-data", i2c->name);
> +	if (!trig)
> +		return dev_err_probe(dev, -ENOMEM,
> +				     "cannot allocate newdata trig\n");
> +
> +	msa311->new_data_trig = trig;
> +	msa311->new_data_trig->dev.parent = dev;
> +	msa311->new_data_trig->ops = &msa311_new_data_trig_ops;
> +	iio_trigger_set_drvdata(msa311->new_data_trig, indio_dev);
> +
> +	err = devm_iio_trigger_register(dev, msa311->new_data_trig);
> +	if (err)
> +		return dev_err_probe(dev, err,
> +				     "can't register newdata trig (%d)\n", err);
> +
> +	indio_dev->trig = iio_trigger_get(msa311->new_data_trig);

Drop this.  Your driver now supports other triggers so leave
this decision to userspace (thus avoiding the issue with remove discussed in
v1).

> +
> +	err = regmap_field_write(msa311->fields[F_INT1_OD],
> +				 MSA311_INT1_OD_PUSH_PULL);
> +	if (err)
> +		return dev_err_probe(dev, err,
> +				     "cannot enable push-pull int (%d)\n", err);
> +
> +	err = regmap_field_write(msa311->fields[F_INT1_LVL],
> +				 MSA311_INT1_LVL_HIGH);
> +	if (err)
> +		return dev_err_probe(dev, err,
> +				     "cannot set active int level (%d)\n", err);
> +
> +	err = regmap_field_write(msa311->fields[F_LATCH_INT],
> +				 MSA311_LATCH_INT_LATCHED);
> +	if (err)
> +		return dev_err_probe(dev, err, "cannot latch int (%d)\n", err);
> +
> +	err = regmap_field_write(msa311->fields[F_RESET_INT], 1);
> +	if (err)
> +		return dev_err_probe(dev, err, "cannot reset int (%d)\n", err);
> +
> +	err = regmap_field_write(msa311->fields[F_INT1_NEW_DATA], 1);
> +	if (err)
> +		return dev_err_probe(dev, err,
> +				     "cannot map new data int (%d)\n", err);
> +
> +	return 0;
> +}
> +

> +/**
> + * msa311_powerdown() - MSA311 powerdown callback used by devres
> + *
> + * @msa311: MSA311 internal private state
> + */
> +static void msa311_powerdown(void *msa311)
> +{
> +	struct device *dev = &((struct msa311_priv *)msa311)->i2c->dev;

As you want the dev, pass the devm_add_action_or_reset the dev
in the first place so you can avoid this rather ugly line!

> +
> +	/* Resume device if any */
> +	pm_runtime_get_sync(dev);
> +
> +	/* Don't use autosuspend PM runtime feature anymore */
> +	pm_runtime_dont_use_autosuspend(dev);

this is done for you in the unwind of
devm_pm_runtime_enable() so If you need to repeat it here, explain why.

> +
> +	/* Suspend device right now */
> +	pm_runtime_put_sync_suspend(dev);

At this point is this any different from pm_runtime_put_sync?

> +}
> +
> +/**
> + * msa311_probe() - MSA311 main I2C driver probe function
> + * @i2c: I2C client associated with MSA311 device
> + *
> + * Return: 0 on success
> + *         -ENOMEM due to memory allocation failures
> + *         -ERRNO in other failures
> + */
> +static int msa311_probe(struct i2c_client *i2c)
> +{
> +	struct msa311_priv *msa311;
> +	struct iio_dev *indio_dev;
> +	struct device *dev = &i2c->dev;
> +	int err;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*msa311));
> +	if (!indio_dev)
> +		return dev_err_probe(dev, -ENOMEM,
> +				     "iio device allocation failed\n");
> +
> +	msa311 = iio_priv(indio_dev);
> +	msa311->i2c = i2c;
> +	i2c_set_clientdata(i2c, indio_dev);
> +
> +	err = msa311_regmap_init(msa311);
> +	if (err)
> +		return err;
> +
> +	mutex_init(&msa311->lock);
> +
> +	err = devm_pm_runtime_enable(dev);
> +	if (err)
> +		return dev_err_probe(dev, err,
> +				     "cannot enable runtime PM (%d)\n", err);
> +
> +	/* Resume msa311 logic before any interactions with registers */
> +	err = pm_runtime_resume_and_get(dev);
> +	if (err)
> +		return dev_err_probe(dev, err,
> +				     "failed to resume runtime pm (%d)\n", err);

Given you already report an error message on the failure path in resume,
having one here as well is probably excessive as any other failure case
is very unlikely.

> +
> +	pm_runtime_set_autosuspend_delay(dev, MSA311_PWR_SLEEP_DELAY_MS);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	err = msa311_chip_init(msa311);
> +	if (err)
> +		return err;
> +
> +	indio_dev->modes = INDIO_DIRECT_MODE; /* setup buffered mode later */
> +	indio_dev->channels = msa311_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(msa311_channels);
> +	indio_dev->name = i2c->name;
> +	indio_dev->info = &msa311_info;
> +
> +	err = devm_iio_triggered_buffer_setup(dev,
> +					      indio_dev,
> +					      iio_pollfunc_store_time,
> +					      msa311_buffer_thread,
> +					      &msa311_buffer_setup_ops);
> +	if (err)
> +		return dev_err_probe(dev, err,
> +				     "cannot setup iio trig buf (%d)\n", err);
> +
> +	if (i2c->irq > 0) {
> +		err = msa311_setup_interrupts(msa311);
> +		if (err)
> +			return err;
> +	}
> +
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	err = devm_add_action_or_reset(dev, msa311_powerdown, msa311);

It's not immediately clear what this devm action corresponds to and hence
why it is at this point in the probe.  Needs a comment.  I think it's
a way of forcing suspend to have definitely occurred?

> +	if (err)
> +		return dev_err_probe(dev, err,
> +				     "cannot add powerdown action (%d)\n", err);
> +
> +	err = devm_iio_device_register(dev, indio_dev);
> +	if (err)
> +		return dev_err_probe(dev, err,
> +				     "iio device register failed (%d)\n", err);
> +
> +	return 0;
> +}
