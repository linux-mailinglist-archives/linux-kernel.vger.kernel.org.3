Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA57C518AB6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 19:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240061AbiECRLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 13:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240047AbiECRLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 13:11:31 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4482FE4E;
        Tue,  3 May 2022 10:07:58 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id 96B2D1F4446C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651597677;
        bh=HwxoMhvHmwAFaURsXErIiih4TEl5JwdIk/Dk6YyTrfw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dp/WRkP2T9O1dJ61ca/WcSG7Iq/NOhwXGBDpxIvCMkurDg7Gyos+LkL53wNa0kXJ6
         0Iv6eBqxIwT86zwqUnFza+rLoBSPUFfDHK57RFWcP6WmVrtLsh62X6AOmFGaxykq0J
         +R8ss0ZUI6z1XYovxZ8P8HfXsGGQZZFV6afnCXgkc1zcJEmBAPfyDtllgaTM5Ye6Tz
         HRkvrQrIYfjDSQBlo9ULkELqJkHnfRuTEkdyBVuHeJUnrPv+FrJ6rxOo7UfzKEaqkd
         zuJHjD5VgqnIVdUhhK3nHYaf8gxUErR/O1Ds/PCSbh3loFOrG7JJhNMIgKCGWcxqp8
         /ziJkwDoUitJg==
Message-ID: <8916313f-0974-0d2d-091b-17e5765c0304@collabora.com>
Date:   Tue, 3 May 2022 22:37:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 3/3] iio: light: Add support for ltrf216a sensor
Content-Language: en-US
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        Zhigang.Shi@liteon.com, krzk@kernel.org, krisman@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com
References: <20220503144354.75438-1-shreeya.patel@collabora.com>
 <20220503144354.75438-4-shreeya.patel@collabora.com>
From:   Shreeya Patel <shreeya.patel@collabora.com>
In-Reply-To: <20220503144354.75438-4-shreeya.patel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,


Just one comment inline related to your previous review.

On 03/05/22 20:13, Shreeya Patel wrote:
> From: Zhigang Shi <Zhigang.Shi@liteon.com>
>
> Add initial support for ltrf216a ambient light sensor.
>
> Datasheet: gitlab.steamos.cloud/shreeya/iio/-/blob/main/LTRF216A.pdf
> Co-developed-by: Shreeya Patel <shreeya.patel@collabora.com>
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> Signed-off-by: Zhigang Shi <Zhigang.Shi@liteon.com>
> ---
>
> Changes in v3
>    - Use u16 instead of u8 for int_time_fac
>    - Reorder headers in ltrf216a.c file
>    - Remove int_time_mapping table and use int_time_available
>
> Changes in v2
>    - Add support for 25ms and 50ms integration time.
>    - Rename some of the macros as per names given in datasheet
>    - Add a comment for the mutex lock
>    - Use read_avail callback instead of attributes and set the
>      appropriate _available bit.
>    - Use FIELD_PREP() at appropriate places.
>    - Add a constant lookup table for integration time and reg val
>    - Use BIT() macro for magic numbers.
>    - Improve error handling at few places.
>    - Use get_unaligned_le24() and div_u64()
>    - Use probe_new() callback and devm functions
>    - Return errors in probe using dev_err_probe()
>    - Use DEFINE_SIMPLE_DEV_PM_OPS()
>    - Correct the formula for lux to use 0.45 instead of 0.8
>
>
>   drivers/iio/light/Kconfig    |  10 +
>   drivers/iio/light/Makefile   |   1 +
>   drivers/iio/light/ltrf216a.c | 343 +++++++++++++++++++++++++++++++++++
>   3 files changed, 354 insertions(+)
>   create mode 100644 drivers/iio/light/ltrf216a.c
>
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index a62c7b4b8678..33d2b24ba1da 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -318,6 +318,16 @@ config SENSORS_LM3533
>   	  changes. The ALS-control output values can be set per zone for the
>   	  three current output channels.
>   
> +config LTRF216A
> +	tristate "Liteon LTRF216A Light Sensor"
> +	depends on I2C
> +	help
> +	  If you say Y or M here, you get support for Liteon LTRF216A
> +	  Ambient Light Sensor.
> +
> +	  If built as a dynamically linked module, it will be called
> +	  ltrf216a.
> +
>   config LTR501
>   	tristate "LTR-501ALS-01 light sensor"
>   	depends on I2C
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index d10912faf964..8fa91b9fe5b6 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -30,6 +30,7 @@ obj-$(CONFIG_SENSORS_ISL29028)	+= isl29028.o
>   obj-$(CONFIG_ISL29125)		+= isl29125.o
>   obj-$(CONFIG_JSA1212)		+= jsa1212.o
>   obj-$(CONFIG_SENSORS_LM3533)	+= lm3533-als.o
> +obj-$(CONFIG_LTRF216A)		+= ltrf216a.o
>   obj-$(CONFIG_LTR501)		+= ltr501.o
>   obj-$(CONFIG_LV0104CS)		+= lv0104cs.o
>   obj-$(CONFIG_MAX44000)		+= max44000.o
> diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
> new file mode 100644
> index 000000000000..1ad1eb4a4c6d
> --- /dev/null
> +++ b/drivers/iio/light/ltrf216a.c
> @@ -0,0 +1,343 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * LTRF216A Ambient Light Sensor
> + *
> + * Copyright (C) 2021 Lite-On Technology Corp (Singapore)
> + * Author: Shi Zhigang <Zhigang.Shi@liteon.com>
> + *
> + * IIO driver for LTRF216A (7-bit I2C slave address 0x53).
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm.h>
> +#include <linux/iio/iio.h>
> +#include <asm/unaligned.h>
> +
> +#define LTRF216A_DRV_NAME "ltrf216a"
> +
> +#define LTRF216A_MAIN_CTRL		0x00
> +
> +#define LTRF216A_ALS_DATA_STATUS	BIT(3)
> +#define LTRF216A_ALS_ENABLE_MASK	BIT(1)
> +
> +#define LTRF216A_ALS_MEAS_RES		0x04
> +#define LTRF216A_MAIN_STATUS		0x07
> +#define LTRF216A_CLEAR_DATA_0		0x0A
> +
> +#define LTRF216A_ALS_DATA_0		0x0D
> +
> +static const int ltrf216a_int_time_available[5][2] = {
> +	{0, 400000},
> +	{0, 200000},
> +	{0, 100000},
> +	{0, 50000},
> +	{0, 25000},
> +};
> +
> +static const int ltrf216a_int_time_reg[5][2] = {
> +	{400, 0x03},
> +	{200, 0x13},
> +	{100, 0x22},
> +	{50, 0x31},
> +	{25, 0x40},
> +};
> +
> +struct ltrf216a_data {
> +	struct i2c_client *client;
> +	u32 int_time;
> +	u16 int_time_fac;
> +	u8 als_gain_fac;
> +	struct mutex mutex; /* Protect read and write operations */

I wasn't really sure about your comment related to the lock description 
here.
I see we are using these locks in read_raw and write_raw functions only and
hence I've added the above comment.



Thanks,
Shreeya Patel
