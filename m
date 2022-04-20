Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03785508658
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 12:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377809AbiDTKxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 06:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347783AbiDTKxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:53:17 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822FE2316E;
        Wed, 20 Apr 2022 03:50:28 -0700 (PDT)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Kjy7M4Wnlz6GD5Z;
        Wed, 20 Apr 2022 18:47:59 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 20 Apr 2022 12:50:25 +0200
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 20 Apr
 2022 11:50:24 +0100
Date:   Wed, 20 Apr 2022 11:50:23 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Rokosov Dmitry Dmitrievich <DDRokosov@sberdevices.ru>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Message-ID: <20220420115023.00006a25@Huawei.com>
In-Reply-To: <20220419154555.24191-3-ddrokosov@sberdevices.ru>
References: <20220419154555.24191-1-ddrokosov@sberdevices.ru>
        <20220419154555.24191-3-ddrokosov@sberdevices.ru>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2022 15:45:55 +0000
Rokosov Dmitry Dmitrievich <DDRokosov@sberdevices.ru> wrote:

> MSA311 is a tri-axial, low-g accelerometer with I2C digital output for
> sensitivity consumer applications. It has dynamical user selectable full
> scales range of +-2g/+-4g/+-8g/+-16g and allows acceleration measurements
> with output data rates from 1Hz to 1000Hz.
> 
> This driver supports following MSA311 features:
>     - IIO interface
>     - Different power modes: NORMAL, SUSPEND and LOW (using pm_runtime)
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

An initial review below.  Mostly style related stuff as driver looks pretty good
for a first posting.

Thanks,

Jonathan

> ---
>  MAINTAINERS                |    6 +
>  drivers/iio/accel/Kconfig  |   13 +
>  drivers/iio/accel/Makefile |    2 +
>  drivers/iio/accel/msa311.c | 2068 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 2089 insertions(+)
>  create mode 100644 drivers/iio/accel/msa311.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cd0f68d..c75be17 100644
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
> index 49587c9..88a265b 100644
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
> index d03e2f6..b1ddcaa 100644
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
> index 00000000..9f81b60
> --- /dev/null
> +++ b/drivers/iio/accel/msa311.c
> @@ -0,0 +1,2068 @@
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
> + *     - Different power modes: NORMAL, SUSPEND and LOW

There is partial support for LOW but how do you get into that mode?

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
> +#include <linux/module.h>

#include <linux/mod_devicetable.h>

> +#include <linux/pm.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +
> +#define MSA311_DRV_NAME "msa311"
> +
> +/* Register map */
> +
> +enum msa311_regs {
> +	MSA311_SOFT_RESET = 0x00,

I'd like to see the naming of these conveying that
they are registers addreses.  

MSA311_SOFT_RESET_REG for example would do that nicely.

> +	MSA311_PARTID,
> +	MSA311_ACC_X_LSB,
> +	MSA311_ACC_X_MSB,
> +	MSA311_ACC_Y_LSB,
> +	MSA311_ACC_Y_MSB,
> +	MSA311_ACC_Z_LSB,
> +	MSA311_ACC_Z_MSB,
> +
> +	MSA311_MOTION_INT = 0x09,

As you have lots of gaps in here and the enum type is never
used, this would be better as a set of #define MSA311_DATA_INT_REG etc
so we can very quickly check the addresses are correct.

> +	MSA311_DATA_INT,
> +	MSA311_TAP_ACTIVE_STS,
> +	MSA311_ORIENT_STS,
> +
> +	MSA311_RANGE = 0x0F,
> +	MSA311_ODR,
> +	MSA311_PWR_MODE,
> +	MSA311_SWAP_POLARITY,
> +
> +	MSA311_INT_SET_0 = 0x16,
> +	MSA311_INT_SET_1,
> +
> +	MSA311_INT_MAP_0 = 0x19,
> +	MSA311_INT_MAP_1,
> +
> +	MSA311_INT_CONFIG = 0x20,
> +	MSA311_INT_LATCH,
> +	MSA311_FREEFALL_DUR,
> +	MSA311_FREEFALL_TH,
> +	MSA311_FREEFALL_HY,
> +
> +	MSA311_ACTIVE_DUR = 0x27,
> +	MSA311_ACTIVE_TH,
> +
> +	MSA311_TAP_DUR = 0x2A,
> +	MSA311_TAP_TH,
> +	MSA311_ORIENT_HY,
> +	MSA311_Z_BLOCK,
> +
> +	MSA311_OFFSET_X = 0x38,
> +	MSA311_OFFSET_Y,
> +	MSA311_OFFSET_Z,
> +
> +	MSA311_MAX_REGS,
> +};
> +
> +enum msa311_fields {
> +	F_SOFT_RESET_I2C, F_SOFT_RESET_SPI,
> +
> +	F_PARTID,
> +
> +	F_ACC_X_LSB, F_ACC_X_MSB,
> +
> +	F_ACC_Y_LSB, F_ACC_Y_MSB,
> +
> +	F_ACC_Z_LSB, F_ACC_Z_MSB,
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
> +	F_FREEFALL_DUR,
> +
> +	F_FREEFALL_TH,
> +
> +	F_FREEFALL_MODE, F_FREEFALL_HY,
> +
> +	F_ACTIVE_DUR,
> +
> +	F_ACTIVE_TH,
> +
> +	F_TAP_QUIET, F_TAP_SHOCK, F_TAP_DUR,
> +
> +	F_TAP_TH,
> +
> +	F_ORIENT_HYST, F_ORIENT_BLOCKING, F_ORIENT_MODE,
> +
> +	F_Z_BLOCKING,
> +
> +	F_OFFSET_X, F_OFFSET_Y, F_OFFSET_Z,
> +
> +	F_MAX_FIELDS,
> +};
> +
> +static const struct reg_field msa311_reg_fields[] = {
> +	/*
> +	 * Soft Reset

Name of field is clear from the code, so don't repeat.

> +	 *
> +	 * 0:soft reset disable, 1:soft reset enable

I would try to keep the documentation minimal as some of this is
obvious from the naming.  For instance, if a field is called
SOFT_RESET then assuption is write 1 causes a reset.

Documentation is good, but too much documentation just adds
noise when people are reviewing and has a habit of becoming
wrong over time.

> +	 */
> +	[F_SOFT_RESET_I2C] = REG_FIELD(MSA311_SOFT_RESET, 2, 2),
> +	[F_SOFT_RESET_SPI] = REG_FIELD(MSA311_SOFT_RESET, 5, 5),
> +
> +	/*
> +	 * Part ID
> +	 *
> +	 * Default: 0x13
> +	 */
> +	[F_PARTID] = REG_FIELD(MSA311_PARTID, 0, 7),

That's the whole register. What benefit is there in treating it
like a field?

> +
> +	/*
> +	 * X_axis Data LSB/MSB
> +	 *
> +	 * ACC_X = (ACC_X_MSB[7:0] << 4) | ACC_X_LSB[7:4]
> +	 */
> +	[F_ACC_X_LSB] = REG_FIELD(MSA311_ACC_X_LSB, 4, 7),
> +	[F_ACC_X_MSB] = REG_FIELD(MSA311_ACC_X_MSB, 0, 7),

Using fields for these two registers make it harder to see
what is going on in the code. I would access them as whole
registers and you should be able to do a bulk read to get
them both followed by endian conversion.

> +
> +	/*
> +	 * Y_axis Data LSB/MSB
> +	 * ACC_Y = (ACC_Y_MSB[7:0] << 4) | ACC_Y_LSB[7:4]
> +	 */
> +	[F_ACC_Y_LSB] = REG_FIELD(MSA311_ACC_Y_LSB, 4, 7),
> +	[F_ACC_Y_MSB] = REG_FIELD(MSA311_ACC_Y_MSB, 0, 7),
> +
> +	/*
> +	 * Z_axis Data LSB/MSB
> +	 *
> +	 * ACC_Z = (ACC_Z_MSB[7:0] << 4) | ACC_Z_LSB[7:4]
> +	 */
> +	[F_ACC_Z_LSB] = REG_FIELD(MSA311_ACC_Z_LSB, 4, 7),
> +	[F_ACC_Z_MSB] = REG_FIELD(MSA311_ACC_Z_MSB, 0, 7),
> +
> +	/*
> +	 * Motion Interrupt
> +	 *
> +	 * ORIENT_INT: orientation interrupt status, 0: inactive, 1: active

As it's a status field it would be very odd if 0 meant inactive, so I think
you can drop that element.  Naming of field should also provide enough
information that the comemnts aren't adding much.

> +	 * S_TAP_INT: single tap interrupt status, 0: inactive, 1: active
> +	 * D_TAP_INT: double tap interrupt status, 0: inactive, 1: active
> +	 * ACTIVE_INT: active interrupt status, 0: inactive, 1: active
> +	 * FREEFALL_INT: freefall interrupt status, 0: inactive, 1: active
> +	 */
> +	[F_ORIENT_INT] = REG_FIELD(MSA311_MOTION_INT, 6, 6),
> +	[F_S_TAP_INT] = REG_FIELD(MSA311_MOTION_INT, 5, 5),
> +	[F_D_TAP_INT] = REG_FIELD(MSA311_MOTION_INT, 4, 4),
> +	[F_ACTIVE_INT] = REG_FIELD(MSA311_MOTION_INT, 2, 2),
> +	[F_FREEFALL_INT] = REG_FIELD(MSA311_MOTION_INT, 0, 0),
> +
> +	/*
> +	 * Data Interrupt
> +	 *
> +	 * NEW_DATA_INT: new data interrupt status, 0: inactive,1: active
> +	 */
> +	[F_NEW_DATA_INT] = REG_FIELD(MSA311_DATA_INT, 0, 0),
> +
> +	/*
> +	 * Tap Active Status
> +	 *
> +	 * TAP_SIGN: sign of tap triggering signal, 0 : positive, 1: negative

These are less obvious to me, so good to document.

> +	 * TAP_FIRST_X: tap interrupt triggered by x axis,
> +	 *              1:positive, 0:negative

However, I'm not sure we need to call out 1:positive etc for each of them as
that bit is fairly obvious.

> +	 * TAP_FIRST_Y: tap interrupt triggered by y axis,
> +	 *              1:positive, 0:negative
> +	 * TAP_FIRST_Z: tap interrupt triggered by z axis,
> +	 *              1:positive, 0:negative
> +	 * ACTIVE_SIGN: sign of active interrupt, 0: positive, 1: negative
> +	 * ACTIVE_FIRST_X: active interrupt triggered by x axis,
> +	 *                 1:positive, 0:negative
> +	 * ACTIVE_FIRST_Y: active interrupt triggered by y axis,
> +	 *                 1:positive, 0:negative
> +	 * ACTIVE_FIRST_Z: active interrupt triggered by z axis,
> +	 *                 1:positive, 0:negative
> +	 */
> +	[F_TAP_SIGN] = REG_FIELD(MSA311_TAP_ACTIVE_STS, 7, 7),
> +	[F_TAP_FIRST_X] = REG_FIELD(MSA311_TAP_ACTIVE_STS, 6, 6),
> +	[F_TAP_FIRST_Y] = REG_FIELD(MSA311_TAP_ACTIVE_STS, 5, 5),
> +	[F_TAP_FIRST_Z] = REG_FIELD(MSA311_TAP_ACTIVE_STS, 4, 4),
> +	[F_ACTV_SIGN] = REG_FIELD(MSA311_TAP_ACTIVE_STS, 3, 3),
> +	[F_ACTV_FIRST_X] = REG_FIELD(MSA311_TAP_ACTIVE_STS, 2, 2),
> +	[F_ACTV_FIRST_Y] = REG_FIELD(MSA311_TAP_ACTIVE_STS, 1, 1),
> +	[F_ACTV_FIRST_Z] = REG_FIELD(MSA311_TAP_ACTIVE_STS, 0, 0),
> +
> +	/*
> +	 * Orientation Status
> +	 *
> +	 * ORIENT[2]: orientation value of z axis,
> +	 *            0:upward looking, 1:downward looking
> +	 * ORIENT[1:0]: orientation value of x/y axes
> +	 *              00: portrait upright
> +	 *              01: portrait upside down
> +	 *              10: landscape left,
> +	 *              11: landscape right
> +	 */
> +	[F_ORIENT_Z] = REG_FIELD(MSA311_ORIENT_STS, 6, 6),
> +	[F_ORIENT_X_Y] = REG_FIELD(MSA311_ORIENT_STS, 4, 5),
> +
> +	/*
> +	 * Acceleration Range
> +	 *
> +	 * FS[1:0]: acceleration range of x/y/z axes,
> +	 *          00:+/-2g, 01:+/-4g, 10:+/-8g, 11:+/-16g
> +	 *
> +	 * Axis data is 12-bit signed value, so
> +	 *
> +	 * fs0 = (2 + 2) * 9.81 / (2<<11) = 0.009580
> +	 * fs1 = (4 + 4) * 9.81 / (2<<11) = 0.019160
> +	 * fs2 = (8 + 8) * 9.81 / (2<<11) = 0.038320
> +	 * fs3 = (16 + 16) * 9.81 / (2<<11) = 0.076641

I would move this information to alongside the scale control
code rather than here.

> +	 */
> +	[F_FS] = REG_FIELD(MSA311_RANGE, 0, 1),
> +
> +	/*
> +	 * Output Data Rate
> +	 *
> +	 * X_AXIS_DIS: 0: enable, 1: disable
> +	 * Y_AXIS_DIS: 0: enable, 1: disable
> +	 * Z_AXIS_DIS: 0: enable, 1: disable
> +	 * ODR[3:0]: 0000: 1Hz (not available in normal mode)
> +	 *           0001: 1.95Hz (not available in normal mode)
> +	 *           0010: 3.9Hz
> +	 *           0011: 7.81Hz
> +	 *           0100: 15.63Hz
> +	 *           0101: 31.25Hz
> +	 *           0110: 62.5Hz
> +	 *           0111: 125Hz
> +	 *           1000: 250Hz
> +	 *           1001: 500Hz (not available in low power mode)
> +	 *           1010-1111:1000hz (not available in low power mode)
This documentation is repeated below. No need to have it here as well.

> +	 */
> +	[F_X_AXIS_DIS] = REG_FIELD(MSA311_ODR, 7, 7),
> +	[F_Y_AXIS_DIS] = REG_FIELD(MSA311_ODR, 6, 6),
> +	[F_Z_AXIS_DIS] = REG_FIELD(MSA311_ODR, 5, 5),
> +	[F_ODR] = REG_FIELD(MSA311_ODR, 0, 3),
> +
> +	/*
> +	 * Power Mode/Bandwidth
> +	 *
> +	 * PWR_MODE: 00: normal mode, 01: low power mode, 11: suspend mode
> +	 * LOW_POWER_BW[3:0]: 0000-0010: 1.95Hz
> +	 *                    0011: 3.9Hz
> +	 *                    0100: 7.81Hz
> +	 *                    0101: 15.63Hz
> +	 *                    0110: 31.25Hz
> +	 *                    0111: 62.5Hz
> +	 *                    1000: 125Hz
> +	 *                    1001: 250Hz
> +	 *                    1010-1111: 500Hz
> +	 */
> +	[F_PWR_MODE] = REG_FIELD(MSA311_PWR_MODE, 6, 7),
> +	[F_LOW_POWER_BW] = REG_FIELD(MSA311_PWR_MODE, 1, 4),
> +
> +	/*
> +	 * Swap Polarity
> +	 *
> +	 * X_POLARITY: the polarity of X axis, 0: not reverse, 1: reverse
> +	 * Y_POLARITY: the polarity of Y axis, 0: not reverse, 1: reverse
> +	 * Z_POLARITY: the polarity of Z axis, 0: not reverse, 1: reverse
> +	 * X_Y_SWAP: output of X/Y axis, 0: not swap, 1: swap
> +	 */
> +	[F_X_POLARITY] = REG_FIELD(MSA311_SWAP_POLARITY, 3, 3),
> +	[F_Y_POLARITY] = REG_FIELD(MSA311_SWAP_POLARITY, 2, 2),
> +	[F_Z_POLARITY] = REG_FIELD(MSA311_SWAP_POLARITY, 1, 1),
> +	[F_X_Y_SWAP] = REG_FIELD(MSA311_SWAP_POLARITY, 0, 0),
> +
> +	/*
> +	 * Interrupt Set 0
> +	 *
> +	 * ORIENT_INT_EN: orient interrupt, 0: disable, 1: enable
> +	 * S_TAP_INT_EN: single tap interrupt, 0: disable, 1: enable
> +	 * D_TAP_INT_EN: double tap interrupt, 0: disable, 1: enable
> +	 * ACTIVE_INT_EN_Z: active interrupt for the z axis,
> +	 *                  0: disable, 1: enable
> +	 * ACTIVE_INT_EN_Y: active interrupt for the y axis,
> +	 *                  0: disable, 1: enable
> +	 * ACTIVE_INT_EN_X: active interrupt for the x axis,
> +	 *                  0: disable, 1: enable
> +	 */
> +	[F_ORIENT_INT_EN] = REG_FIELD(MSA311_INT_SET_0, 6, 6),
> +	[F_S_TAP_INT_EN] = REG_FIELD(MSA311_INT_SET_0, 5, 5),
> +	[F_D_TAP_INT_EN] = REG_FIELD(MSA311_INT_SET_0, 4, 4),
> +	[F_ACTIVE_INT_EN_Z] = REG_FIELD(MSA311_INT_SET_0, 2, 2),
> +	[F_ACTIVE_INT_EN_Y] = REG_FIELD(MSA311_INT_SET_0, 1, 1),
> +	[F_ACTIVE_INT_EN_X] = REG_FIELD(MSA311_INT_SET_0, 0, 0),
> +
> +	/*
> +	 * Interrupt Set 1
> +	 *
> +	 * NEW_DATA_INT_EN: new data interrupt, 0: disable, 1: enable
> +	 * FREEFALL_INT_EN: freefall interrupt, 0: disable, 1: enable
> +	 */
> +	[F_NEW_DATA_INT_EN] = REG_FIELD(MSA311_INT_SET_1, 4, 4),
> +	[F_FREEFALL_INT_EN] = REG_FIELD(MSA311_INT_SET_1, 3, 3),
> +
> +	/*
> +	 * Interrupt Map 0
> +	 *
> +	 * INT1_ORIENT: map orientation interrupt to INT1, 0: disable, 1: enable
> +	 * INT1_S_TAP: map single tap interrupt to INT1, 0: disable, 1: enable
> +	 * INT1_D_TAP: map double tap interrupt to INT1, 0: disable, 1: enable
> +	 * INT1_ACTIVE: map active interrupt to INT1, 0: disable, 1: enable
> +	 * INT1_FREEFALL: map freefall interrupt to INT1, 0: disable, 1: enable
> +	 */
> +	[F_INT1_ORIENT] = REG_FIELD(MSA311_INT_MAP_0, 6, 6),
> +	[F_INT1_S_TAP] = REG_FIELD(MSA311_INT_MAP_0, 5, 5),
> +	[F_INT1_D_TAP] = REG_FIELD(MSA311_INT_MAP_0, 4, 4),
> +	[F_INT1_ACTIVE] = REG_FIELD(MSA311_INT_MAP_0, 2, 2),
> +	[F_INT1_FREEFALL] = REG_FIELD(MSA311_INT_MAP_0, 0, 0),
> +
> +	/*
> +	 * Interrupt Map 1
> +	 *
> +	 * INT1_NEW_DATA: map new data interrupt to INT1, 0: disable, 1: enable
> +	 */
> +	[F_INT1_NEW_DATA] = REG_FIELD(MSA311_INT_MAP_1, 0, 0),
> +
> +	/*
> +	 * Interrupt Config
> +	 *
> +	 * INT1_OD: select output for INT1, 0: push-pull, 1: open-drain
> +	 * INT1_LVL: select active level for INT1, 0: low, 1: high
> +	 */
> +	[F_INT1_OD] = REG_FIELD(MSA311_INT_CONFIG, 1, 1),
> +	[F_INT1_LVL] = REG_FIELD(MSA311_INT_CONFIG, 0, 0),
> +
> +	/*
> +	 * Interrupt Latch
> +	 *
> +	 * RESET_INT: reset or not,
> +	 *            1: reset all latched interrupt,
> +	 *            0: not reset all latched interrupt
> +	 * LATCH_INT[3:0]: 0000: non-latched
> +	 *                 0001: temporary latched 250ms

I'd prefer to see this as a set of suitably named defines
rather than as comments.

> +	 *                 0010: temporary latched 500ms
> +	 *                 0011: temporary latched 1s
> +	 *                 0100: temporary latched 2s
> +	 *                 0101: temporary latched 4s
> +	 *                 0110: temporary latched 8s
> +	 *                 0111: latched
> +	 *                 1000: non-latched
> +	 *                 1001: temporary latched 1ms
> +	 *                 1010: temporary latched 1ms
> +	 *                 1011: temporary latched 2ms
> +	 *                 1100: temporary latched 25ms
> +	 *                 1101: temporary latched 50ms
> +	 *                 1110: temporary latched 100ms
> +	 *                 1111: latched
> +	 */
> +	[F_RESET_INT] = REG_FIELD(MSA311_INT_LATCH, 7, 7),
> +	[F_LATCH_INT] = REG_FIELD(MSA311_INT_LATCH, 0, 3),
> +
> +	/*
> +	 * Freefall Duration
> +	 *
> +	 * FREEFALL_DUR[7:0]: delay_time is (FREEFALL_DUR[7:0] + 1) * 2ms,
> +	 *                    range from 2ms to 512ms,
> +	 *                    the default delay time is 20ms

Again, I don't see benefit in fields when they cover the whole registers.

> +	 */
> +	[F_FREEFALL_DUR] = REG_FIELD(MSA311_FREEFALL_DUR, 0, 7),
> +
> +	/*
> +	 * Freefall Threshold
> +	 *
> +	 * FREEFALL_TH[7:0]: threshold value is freefall_th[7:0] * 7.81mg,
> +	 *                   default value is 375mg
> +	 */
> +	[F_FREEFALL_TH] = REG_FIELD(MSA311_FREEFALL_TH, 0, 7),
> +
> +	/*
> +	 * Freefall Hysteresis
> +	 *
> +	 * FREEFALL_MODE: 0: single mode, 1: sum_mode
> +	 * FREEFALL_HY[1:0]: freefall hysteresis time is
> +	 *                   FREEFALL_HY[1:0] * 125mg
> +	 */
> +	[F_FREEFALL_MODE] = REG_FIELD(MSA311_FREEFALL_HY, 2, 2),
> +	[F_FREEFALL_HY] = REG_FIELD(MSA311_FREEFALL_HY, 0, 1),
> +
> +	/*
> +	 * Active Duration Time
> +	 *
> +	 * ACTIVE_DUR[1:0]: active duration time is (ACTIVE_DUR[1:0] + 1)ms
> +	 */
> +	[F_ACTIVE_DUR] = REG_FIELD(MSA311_ACTIVE_DUR, 0, 1),
> +
> +	/*
> +	 * Active Interrupt Threshold
> +	 *
> +	 * ACTIVE_TH[7:0]: threshold of active interrupt
> +	 *                 3.91mg/LSB (2g range)
> +	 *                 7.81mg/LSB (4g range)
> +	 *                 15.625mg/LSB (8g range)
> +	 *                 31.25mg/LSB (16g range)
> +	 */
> +	[F_ACTIVE_TH] = REG_FIELD(MSA311_ACTIVE_TH, 0, 7),
> +
> +	/*
> +	 * Tap Duration
> +	 *
> +	 * TAP_QUIET: 0: tap quiet duration 30ms, 1: tap quiet duration 20ms
> +	 * TAP_SHOCK: 0: tap shock duration 50ms, 1: tap shock duration 70ms
> +	 * TAP_DUR[2:0]: selects the length of the time window for the
> +	 *               second shock
> +	 *               000: 50ms
> +	 *               001:100ms
> +	 *               010:150ms
> +	 *               011:200ms
> +	 *               100:250ms
> +	 *               101:375ms
> +	 *               110:500ms
> +	 *               111:700ms
> +	 */
> +	[F_TAP_QUIET] = REG_FIELD(MSA311_TAP_DUR, 7, 7),
> +	[F_TAP_SHOCK] = REG_FIELD(MSA311_TAP_DUR, 6, 6),
> +	[F_TAP_DUR] = REG_FIELD(MSA311_TAP_DUR, 0, 2),
> +
> +	/*
> +	 * Tap Interrupt Threshold
> +	 *
> +	 * TAP_TH[4:0]: threshold of tap interrupt.
> +	 *              62.5mg/LSB(2g range)
> +	 *              125mg/LSB(4g range)
> +	 *              250mg/LSB(8g range)
> +	 *              500mg/LSB(16g range)
> +	 */
> +	[F_TAP_TH] = REG_FIELD(MSA311_TAP_TH, 0, 4),
> +
> +	/*
> +	 * Orientation Hysteresis
> +	 *
> +	 * ORIENT_HYST[2:0]: set the hysteresis of the orientation interrupt,
> +	 *                   1LSB is 62.5mg.
> +	 * ORIENT_BLOCKING[1:0]: select the block mode
> +	 *                       00: no blocking
> +	 *                       01: z_axis blocking
> +	 *                       10: z_axis blocking or slope in any axis > 0.2g
> +	 *                       11: no blocking
> +	 * ORIENT_MODE[1:0]: set the thresholds
> +	 *                   00: symmetrical
> +	 *                   01: high-asymmetrical
> +	 *                   10: low-asymmetrical
> +	 *                   11: symmetrical
> +	 */
> +	[F_ORIENT_HYST] = REG_FIELD(MSA311_ORIENT_HY, 4, 6),
> +	[F_ORIENT_BLOCKING] = REG_FIELD(MSA311_ORIENT_HY, 2, 3),
> +	[F_ORIENT_MODE] = REG_FIELD(MSA311_ORIENT_HY, 0, 1),
> +
> +	/*
> +	 * ACC_Z block
> +	 *
> +	 * Z_BLOCKING[3:0]: defines the block acc_z between 0g to 0.9375g
> +	 */
> +	[F_Z_BLOCKING] = REG_FIELD(MSA311_Z_BLOCK, 0, 3),
> +
> +	/*
> +	 * Offset Compensation
> +	 *
> +	 * OFFSET_X[7:0]: the offset compensation value for X axis,
> +	 *                1LSB is 3.9mg
> +	 * OFFSET_Y[7:0]: the offset compensation value for Y axis,
> +	 *                1LSB is 3.9mg
> +	 * OFFSET_Z[7:0]: the offset compensation value for Z axis,
> +	 *                1LSB is 3.9mg
> +	 */
> +	[F_OFFSET_X] = REG_FIELD(MSA311_OFFSET_X, 0, 7),
> +	[F_OFFSET_Y] = REG_FIELD(MSA311_OFFSET_Y, 0, 7),
> +	[F_OFFSET_Z] = REG_FIELD(MSA311_OFFSET_Z, 0, 7),

Note I've only commented on some of these, but many of the comments apply
in multiple places.

> +};
> +
> +#define MSA311_WHO_AM_I 0x13
> +
> +/* Possible Full Scale ranges */
> +enum {
> +	MSA311_FS_2G,
> +	MSA311_FS_4G,
> +	MSA311_FS_8G,
> +	MSA311_FS_16G,
> +};
> +
> +#define msa311_fs_available "0.009580 0.019160 0.038320 0.076641"
> +static const int msa311_fs_table[] = { 9580, 19160, 38320, 76641 };
> +
> +/* Possible Output Data Rate values */

These don't seem to be all supported currently.  So remove the ones that
aren't until you have the mode handling in place (or maybe I'm missing something...)

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
> +#define msa311_odr_available "1 1.95 3.9 7.81 15.63 31.25 62.5 125 250 500 1000"
> +static const struct {
> +	int val;
> +	int val2;
> +} msa311_odr_table[] = {
> +	{1, 0}, {1, 950000}, {3, 900000}, {7, 810000}, {15, 630000},
> +	{31, 250000}, {62, 500000}, {125, 0}, {250, 0}, {500, 0}, {1000, 0}
> +};
> +
> +/* All Power Modes */
> +enum {
> +	MSA311_PWR_MODE_NORMAL,
> +	MSA311_PWR_MODE_LOW,
> +	MSA311_PWR_MODE_SUSPEND = 0x3,

Given the gap, I would suggest setting all values explicitly.

> +};
> +
> +#define MSA311_PWR_SLEEP_DELAY_MS 2000 /* Autosuspend delay */
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
> +enum {
> +	MSA311_LATCH_INT_NOT_LATCHED,
> +	MSA311_LATCH_INT_250MS,
> +	MSA311_LATCH_INT_500MS,
> +	MSA311_LATCH_INT_1S,
> +	MSA311_LATCH_INT_2S,
> +	MSA311_LATCH_INT_4S,
> +	MSA311_LATCH_INT_8S,
> +	MSA311_LATCH_INT_1MS = 0xA,
> +	MSA311_LATCH_INT_2MS,
> +	MSA311_LATCH_INT_25MS,
> +	MSA311_LATCH_INT_50MS,
> +	MSA311_LATCH_INT_100MS,
> +	MSA311_LATCH_INT_LATCHED,
> +};
> +
> +/* Readonly MSA311 registers */
> +static const struct regmap_range msa311_readonly_registers[] = {
> +	regmap_reg_range(MSA311_PARTID, MSA311_ORIENT_STS),
> +};
> +
> +static const struct regmap_access_table msa311_writeable_table = {
> +	.no_ranges = msa311_readonly_registers,
> +	.n_no_ranges = ARRAY_SIZE(msa311_readonly_registers),
> +};
> +
> +/* Writeonly MSA311 registers */
> +static const struct regmap_range msa311_writeonly_registers[] = {
> +	regmap_reg_range(MSA311_SOFT_RESET, MSA311_SOFT_RESET),
> +};
> +
> +static const struct regmap_access_table msa311_readable_table = {
> +	.no_ranges = msa311_writeonly_registers,
> +	.n_no_ranges = ARRAY_SIZE(msa311_writeonly_registers),
> +};
> +
> +/* Volatile MSA311 registers, they will not be cached in the regmap rbtree */
> +static const struct regmap_range msa311_volatile_registers[] = {
> +	regmap_reg_range(MSA311_ACC_X_LSB, MSA311_ORIENT_STS),
> +};
> +
> +static const struct regmap_access_table msa311_volatile_table = {
> +	.yes_ranges = msa311_volatile_registers,
> +	.n_yes_ranges = ARRAY_SIZE(msa311_volatile_registers),
> +};
> +
> +/*
> + * MSA311 regmap definition, supports readonly, writeonly registers,
> + * rbtree cache with certain volatile registers

What does this comment add given the structure elements make most of this
immediately clear? I would drop the comment.

> + */
> +static const struct regmap_config msa311_regmap_config = {
> +	.name = MSA311_DRV_NAME,
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = MSA311_OFFSET_Z,
> +	.wr_table = &msa311_writeable_table,
> +	.rd_table = &msa311_readable_table,
> +	.volatile_table = &msa311_volatile_table,
> +	.cache_type = REGCACHE_RBTREE,
> +};
> +
> +/**
> + * MSA311_GENMASK() - MSA311 reg_field mask generator
> + *
> + * @field: requested regfield from msa311_reg_fields table
> + *
> + * @return: This helper returns reg_field mask to be applied.
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
> + * @lock: State guard

What state?  Need to be very clear what this covers.  There doesn't seem
to be a lot of state to guard.  Possibly it's about read modify write
cycles, but that's not what this implies.

> + * @new_data_trig: Optional NEW_DATA interrupt driven trigger used
> + *                 to notify external consumers a new sample is ready
> + * @new_data_trig_enabled: NEW_DATA interrupt driver trigger state,
> + *                         can be changed by trigger->ops->set_trigger_state()
> + * @regs: Underlying I2C bus adapter used to abstract slave
> + *        register accesses
> + * @fields: Abstract objects for each registers fields access
> + */
> +struct msa311_priv {
> +	struct i2c_client *i2c;
> +	struct mutex lock; /* state guard */
> +
> +	struct iio_trigger *new_data_trig;
> +	bool new_data_trig_enabled;
> +
> +	struct regmap *regs;
> +	struct regmap_field *fields[F_MAX_FIELDS];
> +};
> +
> +/**
> + * struct msa311_axis - MSA311 axis decriptor
> + * @lsb: LSB regmap_field object
> + * @msb: MSB regmap_field object
> + */
> +struct msa311_axis {
> +	struct regmap_field *lsb;
> +	struct regmap_field *msb;
> +};
> +
> +/* Channels */
> +
> +enum msa311_si {
> +	MSA311_SI_X,
> +	MSA311_SI_Y,
> +	MSA311_SI_Z,
> +	MSA311_SI_TIMESTAMP,
> +	MSA311_SI_NONE = -1,

SI_NONE isn't used so drop it.

> +};
> +
> +/**
> + * MSA311_ACCEL_CHANNEL() - Construct MSA311 accelerometer channel descriptor
> + *
> + * @axis: axis name in uppercase
> + */
> +#define MSA311_ACCEL_CHANNEL(axis) {                           \
> +	.type = IIO_ACCEL,                                     \
> +	.modified = 1,                                         \
> +	.channel2 = IIO_MOD_##axis,                            \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),          \
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | \
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),  \
> +	.scan_index = MSA311_SI_##axis,                        \
> +	.scan_type = {                                         \
> +		.sign = 's',                                   \
> +		.realbits = 12,                                \
> +		.storagebits = 16,                             \
> +		.shift = 4,                                    \
> +		.endianness = IIO_LE,                          \

Looks like you are unwinding the endianness of the data in the driver. You
should not be doing that.

> +	},                                                     \
> +	.datasheet_name = "ACC_"#axis                          \
> +}
> +
> +/**
> + * MSA311_TIMESTAMP_CHANNEL() - Construct MSA311 timestamp channel descriptor
> + */
> +#define MSA311_TIMESTAMP_CHANNEL() IIO_CHAN_SOFT_TIMESTAMP(MSA311_SI_TIMESTAMP)
> +
> +static const struct iio_chan_spec msa311_channels[] = {
> +	MSA311_ACCEL_CHANNEL(X),
> +	MSA311_ACCEL_CHANNEL(Y),
> +	MSA311_ACCEL_CHANNEL(Z),
> +	MSA311_TIMESTAMP_CHANNEL(),
> +};
> +
> +/* Attributes */
> +
> +/* Full Scale Range */
> +static IIO_CONST_ATTR(in_accel_scale_available, msa311_fs_available);
> +
> +/* Output Data Rate */
> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(msa311_odr_available);
> +
> +static struct attribute *msa311_attrs[] = {
> +	&iio_const_attr_in_accel_scale_available.dev_attr.attr,
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,

Please change over to using the read_avail() callback and
info_mask_*_avail bitmaps.

Where possible we avoid doing these by hand as then they can't be
used by consumer drivers in kernel (or not in a standard way at least!)

You have appropriate tables already so it shouldn't add much code and
avoids duplication of the list of values.

> +	NULL,
> +};
> +
> +static const struct attribute_group msa311_attr_group = {
> +	.attrs = msa311_attrs,
> +};
> +
> +/**
> + * msa311_get_odr() - Read Output Data Rate (ODR) value from MSA311 accel
> + *
> + * @msa311: MSA311 internal private state
> + * @odr: output ODR value
> + *
> + * This function should be called under msa311->lock.
> + * It filters the same 1000Hz ODR register values based on datasheet info.
> + * ODR can be equal to 1010-1111 for 1000Hz, but function returns 1010
> + * all the time.

I would move this comment down to where you do the clamping in the code.

> + *
> + * @return: 0 on success, -ERRNO in other failures
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
> +	/* Filter same ODR values */
> +	if (*odr > MSA311_ODR_1000_HZ)
> +		*odr = MSA311_ODR_1000_HZ;
> +
> +	return err;
> +}
> +
> +/**
> + * msa311_set_odr() - Setup Output Data Rate (ODR) value for MSA311 accel
> + *
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
> + *     - 500Hz (not available in low power mode)
> + *     - 1000Hz (not available in low power mode)
> + *
> + * @return: 0 on success, -EINVAL for bad ODR value in the certain power mode,
> + *          -ERRNO in other failures
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
> +	case MSA311_PWR_MODE_LOW:

I can't see where the mode is set to LOW. As such, perhaps this is support
to add later?

> +		mode = "low";
> +		good_odr = (odr < MSA311_ODR_500_HZ);
> +		break;
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
> +		dev_err(&msa311->i2c->dev,
> +			"failed to set odr %u.%uHz, not available in %s mode\n",
> +			msa311_odr_table[odr].val,
> +			msa311_odr_table[odr].val2 / 1000, mode);
> +		return -EINVAL;
> +	}
> +
> +	err = regmap_field_write(msa311->fields[F_ODR], odr);
> +	if (err)
> +		dev_err(&msa311->i2c->dev, "failed to set odr value (%d)\n",
> +			err);
> +
> +	return err;
> +}
> +
> +/**
> + * msa311_wait_for_next_data() - Wait next accel data available after resume
> + *
> + * @msa311: MSA311 internal private state
> + *
> + * @return: 0 on success, -EINTR if msleep() was interrupted,
> + *          -ERRNO in other failures
> + */
> +static int msa311_wait_for_next_data(struct msa311_priv *msa311)
> +{
> +	static const int unintr_thresh_ms = 20;
> +	unsigned int odr;
> +	unsigned long wait_ms;
> +	unsigned long freq_uhz;
> +	int err;
> +
> +	err = msa311_get_odr(msa311, &odr);
> +	if (err) {
> +		dev_warn(&msa311->i2c->dev,
> +			 "cannot get actual freq (%d)\n", err);
> +		/* Use lowest Output Data Rate, this is not fatal error */

Say why this error can happen.  To me it looks like a comms failure so
it might as well be fatal.

> +		odr = MSA311_ODR_1_HZ;
> +		err = 0;
> +	}
> +
> +	freq_uhz = msa311_odr_table[odr].val * USEC_PER_SEC +
> +		   msa311_odr_table[odr].val2;
> +	wait_ms = (USEC_PER_SEC * MSEC_PER_SEC) / freq_uhz;
> +
> +	if (wait_ms < unintr_thresh_ms)

Comments needed on why this dance is needed.

> +		usleep_range(wait_ms * USEC_PER_MSEC,
> +			     unintr_thresh_ms * USEC_PER_MSEC);
> +	else
> +		err = msleep_interruptible(wait_ms) ? -EINTR : 0;
> +
> +	return err;
> +}
> +
> +/**
> + * msa311_set_pwr_mode() - Install certain MSA311 power mode
> + *
> + * @msa311: MSA311 internal private state
> + * @mode: Power mode can be equal to NORMAL, SUSPEND and LOW
> + *
> + * This function should be called under msa311->lock.
> + *
> + * @return: 0 on success, -ERRNO on failure
> + */
> +static int msa311_set_pwr_mode(struct msa311_priv *msa311, unsigned int mode)
> +{
> +	unsigned int prev_mode;
> +	int err;
> +
> +	dev_dbg(&msa311->i2c->dev, "transition to %s mode\n",
> +		(mode == MSA311_PWR_MODE_LOW) ? "low" :
> +		(mode == MSA311_PWR_MODE_NORMAL) ? "normal" :
> +		"suspend");
> +
> +	err = regmap_field_read(msa311->fields[F_PWR_MODE], &prev_mode);
> +	if (err) {
> +		dev_err(&msa311->i2c->dev,
> +			"cannot read previous pwr mode (%d)\n", err);
> +		return err;
> +	}
> +
> +	err = regmap_field_write(msa311->fields[F_PWR_MODE], mode);
> +	if (err) {
> +		dev_err(&msa311->i2c->dev, "bad pwr mode transition (%d)\n",
> +			err);
> +		return err;
> +	}
> +
> +	/* Wait actual data if we wakeup */
> +	if (prev_mode == MSA311_PWR_MODE_SUSPEND &&
> +	    mode == MSA311_PWR_MODE_NORMAL)
> +		err = msa311_wait_for_next_data(msa311);
> +
> +	return err;
> +}
> +
> +/**
> + * msa311_normal_mode() - Transit MSA311 power state to NORMAL mode
> + *
> + * @msa311: MSA311 internal private state
> + *
> + * This function should be called under msa311->lock.
> + *
> + * @return: 0 on success, -ERRNO on failure
> + */
> +static inline int msa311_normal_mode(struct msa311_priv *msa311)
> +{
> +	return msa311_set_pwr_mode(msa311, MSA311_PWR_MODE_NORMAL);

This wrapper doesn't seem to add any value over just replacing all calls
with the direct call to msa311_set_pwr_mode()

> +}
> +
> +/**
> + * msa311_suspend_mode() - Transit MSA311 power state to SUSPEND mode
> + *
> + * @msa311: MSA311 internal private state
> + *
> + * This function should be called under msa311->lock.
> + *
> + * @return: 0 on success, -ERRNO on failure
> + */
> +static inline int msa311_suspend_mode(struct msa311_priv *msa311)
> +{
> +	return msa311_set_pwr_mode(msa311, MSA311_PWR_MODE_SUSPEND);

As above, wrapper doesn't seem to add anything so drop it.

> +}
> +
> +/**
> + * msa311_powerup() - MSA311 resume power state using pm_runtime system
> + *
> + * @msa311: MSA311 internal private state
> + *
> + * @return: 0 on success, -ERRNO if cannot resume and get pm counter
> + */
> +static inline int msa311_powerup(struct msa311_priv *msa311)
> +{
> +	return pm_runtime_resume_and_get(&msa311->i2c->dev);

Another wrapper that doesn't add anything. Please drop.

> +}
> +
> +/**
> + * msa311_powerdown() - MSA311 suspend power state using pm_runtime system
> + *
> + * @msa311: MSA311 internal private state
> + */
> +static inline void msa311_powerdown(struct msa311_priv *msa311)
> +{
> +	pm_runtime_mark_last_busy(&msa311->i2c->dev);
> +	pm_runtime_put_autosuspend(&msa311->i2c->dev);

Drop this wrapper as well. It is better to be able to immediately see what is
going on where this is called.
 
> +}
> +
> +/**
> + * msa311_chan_to_axis() - Translate IIO channel spec to MSA311 axis descriptor
> + *
> + * @msa311: MSA311 internal private state
> + * @chan: IIO channel specification
> + *
> + * @return: appropriate msa311_axis object or NULL msa311_axis for unknown
> + *          IIO channel spec
> + */
> +static inline
> +struct msa311_axis msa311_chan_to_axis(struct msa311_priv *msa311,
> +				       const struct iio_chan_spec * const chan)
> +{
> +	struct msa311_axis axis = { NULL, NULL };
> +
> +	switch (chan->scan_index) {
> +	case MSA311_SI_X:
> +		axis.lsb = msa311->fields[F_ACC_X_LSB];
> +		axis.msb = msa311->fields[F_ACC_X_MSB];
> +		break;
> +
> +	case MSA311_SI_Y:
> +		axis.lsb = msa311->fields[F_ACC_Y_LSB];
> +		axis.msb = msa311->fields[F_ACC_Y_MSB];
> +		break;
> +
> +	case MSA311_SI_Z:
> +		axis.lsb = msa311->fields[F_ACC_Z_LSB];
> +		axis.msb = msa311->fields[F_ACC_Z_MSB];
> +		break;
> +	}
> +
> +	return axis;
> +}
> +
> +/**
> + * msa311_get_axis() - Read MSA311 accel data for certain IIO channel spec
> + *
> + * @msa311: MSA311 internal private state
> + * @chan: IIO channel specification
> + * @data: Output accel data for requested IIO channel spec
> + *
> + * This function should be called under msa311->lock.
> + *
> + * @return: 0 on success, -EINVAL for unknown IIO channel specification,
> + *          -ERRNO in other failures
> + */
> +static int msa311_get_axis(struct msa311_priv *msa311,
> +			   const struct iio_chan_spec * const chan,
> +			   unsigned int *data)
> +{
> +	struct msa311_axis axis;
> +	unsigned int lsb, msb;
> +	int err;
> +
> +	axis = msa311_chan_to_axis(msa311, chan);
> +	if (!axis.lsb)
> +		return -EINVAL;
> +
> +	err = regmap_field_read(axis.lsb, &lsb);
> +	if (err) {
> +		dev_err(&msa311->i2c->dev,
> +			"failed to read lsb value of axis %s (%d)\n",
> +			chan->datasheet_name, err);
> +		return err;
> +	}
> +
> +	err = regmap_field_read(axis.msb, &msb);
> +	if (err) {
> +		dev_err(&msa311->i2c->dev,
> +			"failed to read msb value of axis %s (%d)\n",
> +			chan->datasheet_name, err);
> +		return err;
> +	}
> +
> +	*data = (msb << chan->scan_type.shift) | lsb;

This is unusual. Needs a comment on why only the msb is being
shifted. I suspect this a side effect of using fields here which
I think is a bad idea as this should be a bulk read across
the register pairs.


> +
> +	return err;
> +}
> +
> +static int msa311_read_raw_data(struct msa311_priv *msa311,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2)
> +{
> +	unsigned int axis;
> +	int err;
> +
> +	err = msa311_powerup(msa311);
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

Usual trick for this pattern is to check the error after unlock.

	mutex_lock(&msa311->lock);
	err = msa311_get_axis(msa311, chan, &axis);
	mutex_unlock(&msa311->lock);
	if (err) {
		dev_err()..
		return err;
	}

> +
> +	msa311_powerdown(msa311);
> +
> +	*val = sign_extend32(axis, chan->scan_type.realbits - 1);
> +	*val2 = 0;
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
> +
> +	*val = 0;
> +	*val2 = msa311_fs_table[fs];
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
> +
> +	*val = msa311_odr_table[odr].val;
> +	*val2 = msa311_odr_table[odr].val2;
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +/**
> + * msa311_read_raw() - IIO interface function to request attr/accel data
> + *
> + * @indio_dev: The IIO device associated with MSA311
> + * @chan: IIO channel specification
> + * @val: Output data value, first part
> + * @val2: Output data value, second part
> + * @mask: Value type selector
> + *
> + * @return: IIO_VAL_* type on success,
> + *          -EINVAL for unknown value type (bad mask),
> + *          -EBUSY if IIO buffer enabled,
> + *          -ERRNO in other failures
> + */
> +static int msa311_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct msa311_priv *msa311 = iio_priv(indio_dev);
> +	int err = -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (iio_buffer_enabled(indio_dev))
> +			return -EBUSY;
> +
> +		err = msa311_read_raw_data(msa311, chan, val, val2);

		return msa311_read_raw_data()

Same in other cases...

> +		break;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		err = msa311_read_scale(msa311, val, val2);
> +		break;
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		err = msa311_read_samp_freq(msa311, val, val2);
> +		break;

	default:
		return -EINVAL;

> +	}
> +
> +	return err;
> +}
> +
> +static int msa311_write_scale(struct msa311_priv *msa311, int val, int val2)
> +{
> +	unsigned int fs;
> +	int err = -EINVAL;
> +
> +	/* Skip such values */
> +	if (val != 0)
> +		return 0;
> +
> +	err = msa311_powerup(msa311);
> +	if (err) {
> +		dev_err(&msa311->i2c->dev, "failed powerup (%d)\n", err);
> +		return err;
> +	}
> +
> +	mutex_lock(&msa311->lock);
> +	for (fs = 0; fs < ARRAY_SIZE(msa311_fs_table); ++fs)
> +		if (val2 == msa311_fs_table[fs]) {

Handle failure to match..

> +			err = regmap_field_write(msa311->fields[F_FS], fs);
> +			if (err) {
> +				dev_err(&msa311->i2c->dev,
> +					"cannot update scale (%d)\n", err);
> +				goto failed;
> +			}
> +
> +			break;
> +		}
> +
> +failed:
> +	mutex_unlock(&msa311->lock);
> +
> +	msa311_powerdown(msa311);
> +
> +	return err;
> +}
> +
> +static int msa311_write_samp_freq(struct msa311_priv *msa311, int val, int val2)
> +{
> +	unsigned int odr;
> +	int err = -EINVAL;

err doesn't need initializing.

> +
> +	err = msa311_powerup(msa311);
> +	if (err) {
> +		dev_err(&msa311->i2c->dev, "failed powerup (%d)\n", err);
> +		return err;
> +	}
> +
> +	mutex_lock(&msa311->lock);
> +	for (odr = 0; odr < ARRAY_SIZE(msa311_odr_table); ++odr)
> +		if (val == msa311_odr_table[odr].val &&
> +		    val2 == msa311_odr_table[odr].val2) {

If it doesn't match, we want to return an error.

> +			err = msa311_set_odr(msa311, odr);
> +			if (err) {
> +				dev_err(&msa311->i2c->dev,
> +					"cannot update freq (%d)\n", err);
> +				goto failed;
> +			}
> +
> +			break;
> +		}
> +
> +failed:
> +	mutex_unlock(&msa311->lock);
> +
> +	msa311_powerdown(msa311);
> +
> +	return err;
> +}
> +
> +/**
> + * msa311_write_raw() - IIO interface function to write attr/accel data
> + *
> + * @indio_dev: The IIO device associated with MSA311
> + * @chan: IIO channel specification
> + * @val: Input data value, first part
> + * @val2: Input data value, second part
> + * @mask: Value type selector
> + *
> + * @return: 0 on success,
> + *          -EINVAL for unknown value type (bad mask),
> + *          -ERRNO in other failures
> + */
> +static int msa311_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	struct msa311_priv *msa311 = iio_priv(indio_dev);
> +	int err = -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		if (iio_buffer_enabled(indio_dev))
> +			return -EBUSY;
> +
> +		err = msa311_write_scale(msa311, val, val2);

		return msa311_write_scale()

> +		break;
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (iio_buffer_enabled(indio_dev))
> +			return -EBUSY;
> +
> +		err = msa311_write_samp_freq(msa311, val, val2);

		return msa311_write_samp_req();

> +		break;

	default:
		return -EINVAL;

> +	}
> +
> +	return err;
> +}
> +
> +/**
> + * msa311_debugfs_reg_access() - IIO interface function to read/write registers
> + *
> + * @indio_dev: The IIO device associated with MSA311
> + * @reg: Register offset
> + * @writeval: Input value to be written (applicable if readval == NULL)
> + * @readval: Output value to be read, should be not NULL, if it's read operation
> + *
> + * @return: 0 on success,
> + *          -EINVAL for wrong register offset
> + *          -ERRNO in other failures
> + */
> +static int msa311_debugfs_reg_access(struct iio_dev *indio_dev,
> +				     unsigned int reg, unsigned int writeval,
> +				     unsigned int *readval)
> +{
> +	struct msa311_priv *msa311 = iio_priv(indio_dev);
> +	int err;
> +
> +	if (reg > regmap_get_max_register(msa311->regs))
> +		return -EINVAL;
> +
> +	err = msa311_powerup(msa311);

I'd much rather see the runtime_pm calls here as that will make it clear
you aren't actually powering up and down if it's already running but rather
messing around with reference counts.

> +	if (err) {
> +		dev_err(&msa311->i2c->dev, "failed powerup (%d)\n", err);
> +		return err;
> +	}
> +
> +	mutex_lock(&msa311->lock);

Why is lock needed here?  The internal regmap lock should be enough
I think.

> +
> +	if (!readval)
> +		err = regmap_write(msa311->regs, reg, writeval);
> +	else
> +		err = regmap_read(msa311->regs, reg, readval);
> +
> +	mutex_unlock(&msa311->lock);
> +
> +	msa311_powerdown(msa311);
> +
> +	if (err)
> +		dev_err(&msa311->i2c->dev,
> +			"cannot %s register %u from debugfs (%d)\n",
> +			(!readval) ? "write" : "read", reg, err);
> +
> +	return err;
> +}
> +
> +/**
> + * msa311_buffer_preenable() - IIO buffer interface preenable actions
> + *
> + * @indio_dev: The IIO device associated with MSA311
> + *
> + * @return: 0 on success,
> + *          -ERRNO in other failures
> + */
> +static int msa311_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct msa311_priv *msa311 = iio_priv(indio_dev);
> +	int err;
> +
> +	err = msa311_powerup(msa311);
> +	if (err)
> +		dev_err(&msa311->i2c->dev, "failed powerup (%d)\n", err);
> +
> +	return err;
> +}
> +
> +/**
> + * msa311_buffer_postdisable() - IIO buffer interface postdisable actions
> + *
> + * @indio_dev: The IIO device associated with MSA311
> + *
> + * @return: 0 on success,
> + *          -ERRNO in other failures
> + */
> +static int msa311_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct msa311_priv *msa311 = iio_priv(indio_dev);
> +
> +	msa311_powerdown(msa311);

Ah.. See comment below on trigger. Why do it for buffer and trigger?
runtime_pm is ref counted so it won't matter, but seems a bit unusual.

> +
> +	return 0;
> +}
> +
> +/**
> + * msa311_set_new_data_trig_state() - IIO trigger interface to change trig state
> + *
> + * @trig: The IIO device trigger for new data event
> + * @state: New state (enabled or disabled)
> + *
> + * This function changes NEW_DATA interrupt driver trigger state to enabled or
> + * disabled.
> + *
> + * @return: 0 on success,
> + *          -ERRNO in other failures
> + */
> +static int msa311_set_new_data_trig_state(struct iio_trigger *trig, bool state)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct msa311_priv *msa311 = iio_priv(indio_dev);
> +	int err = 0;
> +
> +	if (state)
> +		err = msa311_powerup(msa311);

Superficially it feels like power control should be in the buffer enable
rather than trigger enable. See below for discussion of whether other triggers
can be used with this device if the interrupt isn't wired for example.

> +	else
> +		msa311_powerdown(msa311);
> +
> +	if (err) {
> +		dev_err(&msa311->i2c->dev,
> +			"failed %s (%d)\n",
> +			state ? "powerup" : "powerdown", err);

Given you don't set Err on powerdown you won't hit that path.

> +		return err;
> +	}
> +
> +	mutex_lock(&msa311->lock);
> +
> +	WRITE_ONCE(msa311->new_data_trig_enabled, state);

You are doing this under a lock. Why is WRITE_ONCE needed?
Personally I'd be tempted to use the flag in the register once you've
stopped using new_data_trig_enabled as suggested below.

> +
> +	err = regmap_field_write(msa311->fields[F_NEW_DATA_INT_EN], state);
> +	if (err) {
> +		dev_err(&msa311->i2c->dev,
> +			"cannot %s buffer due to new_data_int failure (%d)\n",
> +			state ? "enable" : "disable", err);
> +		if (state) {
> +			mutex_unlock(&msa311->lock);
> +			msa311_powerdown(msa311);
> +			return err;
> +		}
> +	}
> +
> +	mutex_unlock(&msa311->lock);
> +
> +	return err;
> +}
> +
> +/**
> + * msa311_reenable() - IIO trigger interface to reenable trigger interrupt
> + *
> + * @trig: The IIO device trigger wanted to reenable
> + */
> +static void msa311_reenable(struct iio_trigger *trig)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct msa311_priv *msa311 = iio_priv(indio_dev);
> +	int err;
> +
> +	mutex_lock(&msa311->lock);
> +
> +	/* Reset all latched interrupts */

Should only be resetting interrupts related to the trigger.  Otherwise you have
a race against handling of other interrupts (once added).

> +	err = regmap_field_write(msa311->fields[F_RESET_INT], 1);
> +
> +	mutex_unlock(&msa311->lock);
> +
> +	if (err)
> +		dev_err(&msa311->i2c->dev,
> +			"cannot reset all latched interrupts (%d)\n", err);
> +}
> +
> +/**
> + * msa311_validate_device() - IIO trigger interface to validate requested device
> + *
> + * @trig: Appropriate IIO trigger
> + * @indio_dev: Requested IIO device
> + *
> + * @return: 0 on success,
> + *         -EINVAL when indio_dev isn't linked with appropriate trigger
> + */
> +static int msa311_validate_device(struct iio_trigger *trig,
> +				  struct iio_dev *indio_dev)
> +{
> +	struct iio_dev *indio = iio_trigger_get_drvdata(trig);
> +
> +	if (indio != indio_dev)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +/**
> + * msa311_buffer_thread() - IIO buffer thread to push channels actual data
> + *
> + * @irq:  The software interrupt assigned to @p
> + * @p: The IIO poll function dispatched by external trigger our device is
> + *     attached to.
> + *
> + * @return: IRQ_HANDLED all the time
> + */
> +static irqreturn_t msa311_buffer_thread(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct msa311_priv *msa311 = iio_priv(indio_dev);
> +	const struct iio_chan_spec *chan;
> +	unsigned int axis;
> +	int bit = 0, err, i = 0;
> +
> +	/* Ensure correct alignment of time stamp when present */
> +	struct {
> +		s16 channels[MSA311_SI_Z + 1];

Why +1?  Just to ensure no holes to get zeroing to work?

> +		s64 ts;
> +	} __aligned(8) buf = {0};

This doesn't guarantee the expected alignment.  The problem is x86_32 which
aligns s64 to 4 bytes where IIO guarantees natural alignment on all architectures.
You need

	struct {
		s16 channels[MSA311_SI_Z];
		s64 ts __aligned(8);
	} buf;

Can't use {0} as that is not guaranteed to zero holes (IIRC). So need
an explicit memset(&buf);


> +
> +	mutex_lock(&msa311->lock);
> +
> +	for_each_set_bit(bit, indio_dev->active_scan_mask,
> +			 indio_dev->masklength) {
> +		chan = &msa311_channels[bit];
> +		err = msa311_get_axis(msa311, chan, &axis);
> +		if (err) {
> +			dev_err(&msa311->i2c->dev,
> +				"cannot get axis %s (%d)\n",
> +				chan->datasheet_name, err);
> +			mutex_unlock(&msa311->lock);
> +			goto err;
> +		}
> +		buf.channels[i++] = sign_extend32(axis,
> +						  chan->scan_type.realbits - 1);

That should be up to userspace, not done in kernel which should present the raw data
without sign extension.


> +	}
> +
> +	mutex_unlock(&msa311->lock);
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &buf, pf->timestamp);
> +
> +err:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + * msa311_irq_handler() - Process MSA311 hardware interrupts (INT1 line)
> + *
> + * @irq:  Interrupt line the hardware uses to notify new data has arrived.
> + * @p: The IIO device associated with the sampling hardware.
> + *
> + * @return: IRQ_WAKE_THREAD all the time
> + */
> +static irqreturn_t msa311_irq_handler(int irq, void *p)
> +{
> +	struct iio_dev *indio_dev = p;
> +	struct msa311_priv *msa311 = iio_priv(indio_dev);
> +
> +	/* TODO: notify motion triggers */

You probably can't do that in the top half, so this comment seems
misleading.

> +
> +	if (READ_ONCE(msa311->new_data_trig_enabled))
> +		iio_trigger_poll(msa311->new_data_trig);
As below. I would not rely on the assumption that the interrupt was caused
by this being set.

> +
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +/**
> + * msa311_irq_thread() - Interrupt bottom-half handler.
> + *
> + * @irq:  Interrupt line the hardware uses to notify new data has arrived.
> + * @p: The IIO device associated with the sampling hardware.
> + *
> + * @return: IRQ_HANDLED all the time
> + */
> +static irqreturn_t msa311_irq_thread(int irq, void *p)
> +{
> +	struct iio_dev *indio_dev = p;

As indio_dev isn't used here, you can just pass p into iio_priv()
without loss of readability.

> +	struct msa311_priv *msa311 = iio_priv(indio_dev);
> +	unsigned int new_data_int_status;
> +	int err;
> +
> +	mutex_lock(&msa311->lock);
> +
> +	/* TODO: push motion events */
> +
> +	/* Ack NEW_DATA interrupt */
> +	err = regmap_field_read(msa311->fields[F_NEW_DATA_INT],
> +				&new_data_int_status);
> +
> +	mutex_unlock(&msa311->lock);

I'd expect to see iio_trigger_poll_chained() (one day I'll give
that function a better name) in here after we
have verified that the interrupt in question was the right one.
Note that will break use of top half measurement of timestamp
for the buffer so you would need to handle that.


> +
> +	if (err)
> +		dev_err(&msa311->i2c->dev,
> +			"cannot retrieve new_data interrupt status (%d)\n",
> +			err);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + * msa311_check_partid() - Check MSA311 WHO_AM_I identifier.
> + *
> + * @msa311: MSA311 internal private state
> + *
> + * @return: 0 on success (MSA311 device was found on the I2C bus)
> + *          -ENODEV when MSA311 device is not presented on the I2C bus
> + *          -ERRNO in other failures
> + */
> +static int msa311_check_partid(struct msa311_priv *msa311)
> +{
> +	unsigned int partid;
> +	int err;
> +
> +	err = regmap_field_read(msa311->fields[F_PARTID], &partid);
> +	if (err) {
> +		dev_err(&msa311->i2c->dev, "failed to read partid (%d)\n", err);
> +		return err;
> +	}
> +
> +	if (partid != MSA311_WHO_AM_I) {
> +		dev_err(&msa311->i2c->dev, "invalid partid (%#x)\n", partid);

So... We've had a lot of discussion of this in various drivers recently and
as a general rule the preferred option is to just warn on the wrong WHOAMI
and carry on.  The reason is that enables future parts that happen to be
compatible to use fallback compatibles and work on older kernels.

> +		return -ENODEV;
> +	}
> +
> +	dev_info(&msa311->i2c->dev, "Found MSA311 chip[%#x]\n", partid);
> +
> +	return err;
> +}
> +
> +/**
> + * msa311_soft_reset() - Make soft reset operation for MSA311 device.
> + *
> + * @msa311: MSA311 internal private state
> + *
> + * @return: 0 on success, -ERRNO in other failures
> + */
> +static int msa311_soft_reset(struct msa311_priv *msa311)
> +{
> +	int err;
> +
> +	err = regmap_write(msa311->regs, MSA311_SOFT_RESET,
> +			   MSA311_GENMASK(F_SOFT_RESET_I2C) |
> +			   MSA311_GENMASK(F_SOFT_RESET_SPI));
> +	if (err)
> +		return err;
> +
> +	usleep_range(5000, 10000);
> +
> +	return err;
err definitely 0 here so
	return 0; to make that explicit.

> +}
> +
> +/**
> + * msa311_chip_init() - MSA311 chip initialization sequence
> + *
> + * @msa311: MSA311 internal private state
> + *
> + * We do not need to hold msa311->lock here, because this function is used
> + * during I2C driver probing process only.
> + *
> + * @return: 0 on success, -ERRNO in other failures
> + */
> +static int msa311_chip_init(struct msa311_priv *msa311)
> +{
> +	int err;
> +
> +	err = msa311_check_partid(msa311);
> +	if (err)
> +		return err;
> +
> +	err = msa311_soft_reset(msa311);
> +	if (err) {
> +		dev_err(&msa311->i2c->dev,
> +			"cannot soft reset all logic (%d)\n", err);
> +		return err;

dev_err_probe() for all these.

> +	}
> +
> +	err = msa311_normal_mode(msa311);
> +	if (err) {
> +		dev_err(&msa311->i2c->dev,
> +			"bad normal pwr mode transition (%d)\n", err);
> +		return err;
> +	}
> +
> +	err = regmap_write(msa311->regs, MSA311_RANGE, MSA311_FS_16G);
> +	if (err) {
> +		dev_err(&msa311->i2c->dev,
> +			"failed to setup accel range (%d)\n", err);
> +		return err;
> +	}
> +
> +	/* Disable all interrupts by default */
> +	err = regmap_write(msa311->regs, MSA311_INT_SET_0, 0);
> +	if (err) {
> +		dev_err(&msa311->i2c->dev,
> +			"cannot disable set0 interrupts (%d)\n", err);
> +		return err;
> +	}
> +	err = regmap_write(msa311->regs, MSA311_INT_SET_1, 0);
> +	if (err) {
> +		dev_err(&msa311->i2c->dev,
> +			"cannot disable set1 interrupts (%d)\n", err);
> +		return err;
> +	}
> +
> +	/* Unmap all INT1 interrupts by default */
> +	err = regmap_write(msa311->regs, MSA311_INT_MAP_0, 0);
> +	if (err) {
> +		dev_err(&msa311->i2c->dev,
> +			"failed to unmap map0 interrupts (%d)\n", err);
> +		return err;
> +	}
> +	err = regmap_write(msa311->regs, MSA311_INT_MAP_1, 0);
> +	if (err) {
> +		dev_err(&msa311->i2c->dev,
> +			"failed to unmap map1 interrupts (%d)\n", err);
> +		return err;
> +	}
> +
> +	/* Disable all axis by default */
> +	err = regmap_update_bits(msa311->regs, MSA311_ODR,
> +				 MSA311_GENMASK(F_X_AXIS_DIS) |
> +				 MSA311_GENMASK(F_Y_AXIS_DIS) |
> +				 MSA311_GENMASK(F_Z_AXIS_DIS), 0);
> +	if (err) {
> +		dev_err(&msa311->i2c->dev,
> +			"cannot enable all axes (%d)\n", err);
> +		return err;
> +	}
> +
> +	err = msa311_set_odr(msa311, MSA311_ODR_125_HZ);
> +	if (err) {
> +		dev_err(&msa311->i2c->dev,
> +			"failed to set accel frequency (%d)\n", err);
> +		return err;
> +	}
> +
> +	usleep_range(10000, 15000);

Comment needed to justify this sleep. Probably a spec reference.

> +
> +	return err;
> +}
> +
> +/**
> + * msa311_setup_interrupts() - MSA311 interrupts initialization sequence
> + *
> + * @msa311: MSA311 internal private state
> + *
> + * We do not need to hold msa311->lock here, because this function is used
> + * during I2C driver probing process only.
> + *
> + * @return: 0 on success, -ERRNO in other failures
> + */
> +static int msa311_setup_interrupts(struct msa311_priv *msa311)
> +{
> +	int err;
> +
> +	err = regmap_field_write(msa311->fields[F_INT1_OD],
> +				 MSA311_INT1_OD_PUSH_PULL);
> +	if (err)
> +		return err;
> +
> +	err = regmap_field_write(msa311->fields[F_INT1_LVL],
> +				 MSA311_INT1_LVL_HIGH);
> +	if (err)
> +		return err;
> +
> +	err = regmap_field_write(msa311->fields[F_LATCH_INT],
> +				 MSA311_LATCH_INT_LATCHED);
> +	if (err)
> +		return err;
> +
> +	err = regmap_field_write(msa311->fields[F_INT1_NEW_DATA], 1);

return regmap_field_write()...

> +
> +	return err;
> +}
> +
> +/**
> + * msa311_regmap_init() - MSA311 registers mapping initialization
> + *
> + * @msa311: MSA311 internal private state
> + *
> + * We do not need to hold msa311->lock here, because this function is used
> + * during I2C driver probing process only.
> + *
> + * @return: 0 on success, -ERRNO in other failures
> + */
> +static int msa311_regmap_init(struct msa311_priv *msa311)
> +{
> +	struct regmap *regmap;
> +	struct regmap_field **fields = msa311->fields;
> +	int i;
> +
> +	regmap = devm_regmap_init_i2c(msa311->i2c, &msa311_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&msa311->i2c->dev, "failed to register i2c regmap\n");

dev_err_probe() preferred for things called from probe() same elsewhere.

> +		return PTR_ERR(regmap);
> +	}
> +	msa311->regs = regmap;
> +
> +	for (i = 0; i < F_MAX_FIELDS; ++i) {
> +		fields[i] = devm_regmap_field_alloc(&msa311->i2c->dev,
> +						    msa311->regs,
> +						    msa311_reg_fields[i]);
> +		if (IS_ERR(msa311->fields[i])) {
> +			dev_err(&msa311->i2c->dev,
> +				"failed to allocate reg field[%d]\n", i);
> +			return PTR_ERR(msa311->fields[i]);

dev_err_probe()

> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct iio_info msa311_info = {
> +	.attrs = &msa311_attr_group,
> +	.read_raw = msa311_read_raw,
> +	.write_raw = msa311_write_raw,
> +	.debugfs_reg_access = msa311_debugfs_reg_access,
> +};
> +
> +static const struct iio_buffer_setup_ops msa311_buffer_setup_ops = {
> +	.preenable = msa311_buffer_preenable,
> +	.postdisable = msa311_buffer_postdisable,
> +};
> +
> +static const struct iio_trigger_ops msa311_new_data_trig_ops = {
> +	.set_trigger_state = msa311_set_new_data_trig_state,
> +	.reenable = msa311_reenable,
> +	.validate_device = msa311_validate_device,
> +};
> +
> +/**
> + * msa311_probe() - MSA311 main I2C driver probe function
> + *
> + * @i2c: I2C client associated with MSA311 device
> + * @id: Matching device id
> + *
> + * @return: 0 on success
> + *          -ENOMEM due to memory allocation failures
> + *          -ERRNO in other failures
> + */
> +static int msa311_probe(struct i2c_client *i2c,
> +			const struct i2c_device_id *id)

Use probe_new() callback rather than probe() for new I2C drivers.

> +{
> +	struct msa311_priv *msa311;
> +	struct iio_dev *indio_dev;
> +	int err;
> +
> +	indio_dev = devm_iio_device_alloc(&i2c->dev, sizeof(*msa311));
> +	if (!indio_dev) {
> +		dev_err(&i2c->dev, "iio device allocation failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	msa311 = iio_priv(indio_dev);
> +	msa311->i2c = i2c;
> +	i2c_set_clientdata(i2c, indio_dev);
> +
> +	indio_dev->dev.parent = &i2c->dev;

This should already be set by internals of devm_iio_device_alloc()

> +
> +	err = msa311_regmap_init(msa311);
> +	if (err) {
> +		dev_err(&i2c->dev, "cannot initialize regmap (%d)\n", err);

For error handling in probe() please use
	dev_err_probe() throughout.

> +		return err;
> +	}
> +
> +	err = msa311_chip_init(msa311);
> +	if (err)
> +		return err;
> +
> +	mutex_init(&msa311->lock);
> +
> +	indio_dev->modes = INDIO_DIRECT_MODE; /* setup buffered mode later */
> +	indio_dev->channels = msa311_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(msa311_channels);
> +	indio_dev->name = i2c->name;
> +	indio_dev->info = &msa311_info;
> +
> +	if (i2c->irq > 0) {
> +		err = devm_request_threaded_irq(&i2c->dev, i2c->irq,
> +						msa311_irq_handler,
> +						msa311_irq_thread,
> +						IRQF_TRIGGER_RISING,
> +						i2c->name,
> +						indio_dev);
> +		if (err) {
> +			dev_err(&i2c->dev, "failed to request irq (%d)\n", err);
> +			goto err_lock_destroy;

One advantage of dropping mutex_destroy() below is you can return directly
from all of these paths.

> +		}
> +
> +		msa311->new_data_trig = devm_iio_trigger_alloc(&i2c->dev,

I would use a local variable for trig to shorten some of these lines.
		trig = devm_iio_trigger_alloc();
		if (!trig)
			return -ENOMEM;

		msa311->new_data_trig = trig;

> +							       "%s-new-data",
> +							       indio_dev->name);
> +		if (!msa311->new_data_trig) {
> +			dev_err(&i2c->dev, "cannot allocate new data trig\n");
> +			err = -ENOMEM;
> +			goto err_lock_destroy;
> +		}
> +
> +		msa311->new_data_trig->dev.parent = &i2c->dev;
> +		msa311->new_data_trig->ops = &msa311_new_data_trig_ops;
> +		iio_trigger_set_drvdata(msa311->new_data_trig, indio_dev);
> +		indio_dev->trig = msa311->new_data_trig;

This will create a double free if you were to change the trigger.
		indio_dev->trig = iio_trigger_get(trig);

> +		err = devm_iio_trigger_register(&i2c->dev,
> +						msa311->new_data_trig);
> +		if (err) {
> +			dev_err(&i2c->dev,
> +				"failed to register new data trig (%d)\n", err);
> +			goto err_lock_destroy;
> +		}
> +
> +		err = devm_iio_triggered_buffer_setup(&i2c->dev,

Can the device operate using other triggers?  So far you haven't prevented
that (you need to provide the validate_trigger() callback if you want to
restrict it).  If it works, then the buffer setup should not be gated
on irq being available as you should be able to use a hrtimer trigger
etc.

> +						      indio_dev,
> +						      iio_pollfunc_store_time,
> +						      msa311_buffer_thread,
> +						      &msa311_buffer_setup_ops);
> +		if (err) {
> +			dev_err(&i2c->dev,
> +				"failed to setup iio triggered buffer (%d)\n",
> +				err);
> +			goto err_lock_destroy;
> +		}
> +
> +		err = msa311_setup_interrupts(msa311);

This is related to the trigger rather than the buffer, so move it up above
the buffer setup.

> +		if (err) {
> +			dev_err(&i2c->dev, "failed to setup interrupts (%d)\n",
> +				err);
> +			goto err_lock_destroy;
> +		}
> +	}
> +
> +	err = msa311_suspend_mode(msa311);
> +	if (err) {
> +		dev_err(&msa311->i2c->dev,
> +			"bad suspend pwr mode transition (%d)\n", err);
> +		goto err_lock_destroy;
> +	}
> +
> +	err = pm_runtime_set_active(&i2c->dev);

I'm confused. You seem to have suspended the chip then specified that it is not
suspended to runtime_pm.

> +	if (err) {
> +		dev_err(&i2c->dev,
> +			"failed to active runtime pm (%d)\n", err);
> +		goto err_lock_destroy;
> +	}
> +
> +	pm_runtime_enable(&i2c->dev);
> +	pm_runtime_set_autosuspend_delay(&i2c->dev, MSA311_PWR_SLEEP_DELAY_MS);
> +	pm_runtime_use_autosuspend(&i2c->dev);
> +
> +	err = devm_iio_device_register(&i2c->dev, indio_dev);
> +	if (err) {
> +		dev_err(&i2c->dev, "iio device register failed (%d)\n", err);
> +		goto err_poweroff_msa311;
> +	}
> +
> +	return err;
> +
> +err_poweroff_msa311:
> +	pm_runtime_get_sync(&i2c->dev);
> +	pm_runtime_disable(&i2c->dev);
> +	pm_runtime_set_suspended(&i2c->dev);
> +	pm_runtime_put_noidle(&i2c->dev);
> +
> +err_lock_destroy:
> +	mutex_destroy(&msa311->lock);

Don't bother destroying the mutex.  That is only useful when trying
to debug use after free and we aren't going to get any of those in probe.

> +
> +	return err;
> +}
> +
> +/**
> + * msa311_remove() - MSA311 main I2C driver remove function
> + *
> + * @i2c: I2C client associated with MSA311 device
> + *
> + * @return: 0 all the time
> + */
> +static int msa311_remove(struct i2c_client *i2c)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(i2c);
> +	struct msa311_priv *msa311 = iio_priv(indio_dev);
> +
> +	pm_runtime_get_sync(&i2c->dev);
> +	pm_runtime_disable(&i2c->dev);
> +	pm_runtime_set_suspended(&i2c->dev);
> +	pm_runtime_put_noidle(&i2c->dev);

It probably makes sense to use 
devm_add_action_or_reset() with appropriate callback to handle this
power management.

> +
> +	mutex_lock(&msa311->lock);
> +	msa311_suspend_mode(msa311);
> +	mutex_unlock(&msa311->lock);

Why do we have suspend in the remove() function but not in error handling
of probe()?

> +
> +	mutex_destroy(&msa311->lock);

mutex destroy is only relevant if you are destroying a mutex that might
still be used.  It's debug only and we almost never bother doing it 
in remove() functions.

> +
> +	return 0;
> +}
> +
> +/**
> + * msa311_runtime_suspend() - MSA311 pm runtime suspend callback
> + *
> + * @dev: Device object associated with MSA311
> + *
> + * @return: 0 on success, -EAGAIN due to MSA311 pm errors, please try later
> + */
> +static int __maybe_unused msa311_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));

As below use dev_get_drvdata() same in other cases.
 
> +	struct msa311_priv *msa311 = iio_priv(indio_dev);
> +	int err;
> +
> +	dev_info(&msa311->i2c->dev, "suspending %s\n", dev->driver->name);
Too noisy. dev_dbg() or drop.

> +
> +	mutex_lock(&msa311->lock);
> +	err = msa311_suspend_mode(msa311);
> +	mutex_unlock(&msa311->lock);
> +
> +	if (err) {
> +		dev_err(&msa311->i2c->dev,
> +			"failed to power off device (%d)\n", err);
> +		err = -EAGAIN;

As far as I can see this is a device comms failure.  Normally
we just give up in such cases and return err;
		return err;

> +	}
> +
> +	return err;

return 0;

> +}
> +
> +/**
> + * msa311_runtime_resume() - MSA311 pm runtime resume callback
> + *

No blank line here.  Same in similar cases throughout the driver.

> + * @dev: Device object associated with MSA311
> + *
> + * @return: 0 on success, -EAGAIN due to MSA311 pm errors, please try later

This is new syntax to me. It 'might' be fine but please run the kernel-doc
build script on the whole file and fix any warnings.

> + */
> +static int __maybe_unused msa311_runtime_resume(struct device *dev)

With changes suggested below you won't need the __maybe_unused on these.

> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));

dev_get_drvdata() to avoid bouncing backwards and forwards.
There have been various discussions about this and whether it is balanced
but general conclusion was that it was fairly obvious these were accessing
the same underlying storage and that there is no chance of that changing
in future.


> +	struct msa311_priv *msa311 = iio_priv(indio_dev);
> +	int err;
> +
> +	dev_info(&msa311->i2c->dev, "resuming %s\n", dev->driver->name);

This is excessive noise so reduce to dev_dbg or drop.

> +
> +	mutex_lock(&msa311->lock);
> +	err = msa311_normal_mode(msa311);
> +	mutex_unlock(&msa311->lock);
> +
> +	if (err) {
> +		dev_err(&msa311->i2c->dev,
> +			"failed to power on device (%d)\n", err);
> +		err = -EAGAIN;
> +	}
> +
> +	return err;
> +}
> +
> +static const struct dev_pm_ops msa311_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)
> +	SET_RUNTIME_PM_OPS(msa311_runtime_suspend,
> +			   msa311_runtime_resume, NULL)
> +};

Please use the new DEFINE_RUNTIME_DEV_PM_OPS for this and see below...

> +
> +static const struct i2c_device_id msa311_i2c_id[] = {
> +	{ .name = MSA311_DRV_NAME },

I'd rather see the string here than a define given we are matching
on it so good to see what it is directly.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, msa311_i2c_id);
> +
> +#ifdef CONFIG_OF

As below, drop this protection. It brings more disadvantages than
it is worth.

> +static const struct of_device_id msa311_of_match[] = {
> +	{ .compatible = "memsensing,msa311" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, msa311_of_match);
> +#else
> +#define msa311_of_match NULL
> +#endif
> +
> +static struct i2c_driver msa311_driver = {
> +	.driver = {
> +		.name = MSA311_DRV_NAME,
> +		.owner = THIS_MODULE,
> +		.of_match_table = of_match_ptr(msa311_of_match),

Don't use of_match_ptr(). It prevents use of this table for
ACPI PRP0001 based bindings and it's not worth doing just
to save a few bytes on non DT systems.

> +		.pm = &msa311_pm_ops,

		.pm = pm_ptr(&msa311_pm_ops),

> +	},
> +	.probe		= msa311_probe,
> +	.remove		= msa311_remove,
> +	.id_table	= msa311_i2c_id,
> +};
> +
> +module_i2c_driver(msa311_driver);
> +
> +MODULE_AUTHOR("Dmitry Rokosov <ddrokosov@sberdevices.ru>");
> +MODULE_DESCRIPTION("MEMSensing MSA311 3-axis accelerometer driver");
> +MODULE_LICENSE("GPL v2");

