Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFB04B27EC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350887AbiBKOci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:32:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244152AbiBKOch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:32:37 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A46B6E;
        Fri, 11 Feb 2022 06:32:34 -0800 (PST)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JwGDy5nHCz682w5;
        Fri, 11 Feb 2022 22:28:18 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Feb 2022 15:32:32 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 11 Feb
 2022 14:32:31 +0000
Date:   Fri, 11 Feb 2022 14:32:29 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Cosmin Tanislav <demonsingur@gmail.com>
CC:     <cosmin.tanislav@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 5/5] iio: accel: add ADXL367 driver
Message-ID: <20220211143229.00000aad@Huawei.com>
In-Reply-To: <20220206211307.1564647-6-cosmin.tanislav@analog.com>
References: <20220206211307.1564647-1-cosmin.tanislav@analog.com>
        <20220206211307.1564647-6-cosmin.tanislav@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  6 Feb 2022 23:13:07 +0200
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> The ADXL367 is an ultralow power, 3-axis MEMS accelerometer.
> 
> The ADXL367 does not alias input signals to achieve ultralow power
> consumption, it samples the full bandwidth of the sensor at all
> data rates. Measurement ranges of +-2g, +-4g, and +-8g are available,
> with a resolution of 0.25mg/LSB on the +-2 g range.
> 
> In addition to its ultralow power consumption, the ADXL367
> has many features to enable true system level power reduction.
> It includes a deep multimode output FIFO, a built-in micropower
> temperature sensor, and an internal ADC for synchronous conversion
> of an additional analog input.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>

I missed the issue below with the use of available_scan_masks
in v3. Other than that and a few trivial things below, the series
looks good to me.

Thanks,

Jonathan


> ---
>  MAINTAINERS                     |    8 +
>  drivers/iio/accel/Kconfig       |   27 +
>  drivers/iio/accel/Makefile      |    3 +
>  drivers/iio/accel/adxl367.c     | 1585 +++++++++++++++++++++++++++++++
>  drivers/iio/accel/adxl367.h     |   23 +
>  drivers/iio/accel/adxl367_i2c.c |   90 ++
>  drivers/iio/accel/adxl367_spi.c |  164 ++++
>  7 files changed, 1900 insertions(+)
>  create mode 100644 drivers/iio/accel/adxl367.c
>  create mode 100644 drivers/iio/accel/adxl367.h
>  create mode 100644 drivers/iio/accel/adxl367_i2c.c
>  create mode 100644 drivers/iio/accel/adxl367_spi.c
> 


> new file mode 100644
> index 000000000000..cac47db7d89c
> --- /dev/null
> +++ b/drivers/iio/accel/adxl367.c
> @@ -0,0 +1,1585 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2021 Analog Devices, Inc.
> + * Author: Cosmin Tanislav <cosmin.tanislav@analog.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/module.h>

#include <linux/mod_devicetable.h>
for the id tables.

> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <asm/unaligned.h>
> +
> +#include "adxl367.h"
> +




> +static const unsigned long adxl367_channel_masks[] = {
> +	[ADXL367_FIFO_FORMAT_XYZ]  = ADXL367_X_CHANNEL_MASK
> +				     | ADXL367_Y_CHANNEL_MASK
> +				     | ADXL367_Z_CHANNEL_MASK,
> +	[ADXL367_FIFO_FORMAT_X]    = ADXL367_X_CHANNEL_MASK,
> +	[ADXL367_FIFO_FORMAT_Y]    = ADXL367_Y_CHANNEL_MASK,
> +	[ADXL367_FIFO_FORMAT_Z]    = ADXL367_Z_CHANNEL_MASK,
> +	[ADXL367_FIFO_FORMAT_XYZT] = ADXL367_X_CHANNEL_MASK
> +				     | ADXL367_Y_CHANNEL_MASK
> +				     | ADXL367_Z_CHANNEL_MASK
> +				     | ADXL367_TEMP_CHANNEL_MASK,
> +	[ADXL367_FIFO_FORMAT_XT]   = ADXL367_X_CHANNEL_MASK
> +				     | ADXL367_TEMP_CHANNEL_MASK,
> +	[ADXL367_FIFO_FORMAT_YT]   = ADXL367_Y_CHANNEL_MASK
> +				     | ADXL367_TEMP_CHANNEL_MASK,
> +	[ADXL367_FIFO_FORMAT_ZT]   = ADXL367_Z_CHANNEL_MASK
> +				     | ADXL367_TEMP_CHANNEL_MASK,
> +	[ADXL367_FIFO_FORMAT_XYZA] = ADXL367_X_CHANNEL_MASK
> +				     | ADXL367_Y_CHANNEL_MASK
> +				     | ADXL367_Z_CHANNEL_MASK
> +				     | ADXL367_EX_ADC_CHANNEL_MASK,
> +	[ADXL367_FIFO_FORMAT_XA]   = ADXL367_X_CHANNEL_MASK
> +				     | ADXL367_EX_ADC_CHANNEL_MASK,
> +	[ADXL367_FIFO_FORMAT_YA]   = ADXL367_Y_CHANNEL_MASK
> +				     | ADXL367_EX_ADC_CHANNEL_MASK,
> +	[ADXL367_FIFO_FORMAT_ZA]   = ADXL367_Z_CHANNEL_MASK
> +				     | ADXL367_EX_ADC_CHANNEL_MASK,
> +	0,
> +};

The way available scan_masks works is to search for an entry
for which the desired mask is a subset.

That means to get the minimal mode IIRC you need to order them from
smallest to largest. e.g.
https://elixir.bootlin.com/linux/latest/source/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c#L1122

> +

> +EXPORT_SYMBOL_NS_GPL(adxl367_probe, ADXL367);

Trivial but we decided to prefix IIO namespaces with IIO_ so this should
be IIO_ADXL367.

> +
> +MODULE_AUTHOR("Cosmin Tanislav <cosmin.tanislav@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices ADXL367 3-axis accelerometer driver");
> +MODULE_LICENSE("GPL");
