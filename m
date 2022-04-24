Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8379650D342
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 18:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbiDXQ1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 12:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbiDXQ1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 12:27:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0B57DE1A;
        Sun, 24 Apr 2022 09:24:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7EC1B80E45;
        Sun, 24 Apr 2022 16:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF52C385A7;
        Sun, 24 Apr 2022 16:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650817445;
        bh=SKkt44/pdWWtJDnAFjZyfdHI94wAj09CMu8k9vIQhF0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QXHqVXxuifbmtoq8vQmDLAQa4ePAIET9jxbcqo1EU2YpPJvwYwMdMQrg2BgFW22HT
         ZACr5tMW64j+0WiLqb30/EDOA1mSBAul6pjTVCj0SIlDOlzHrEvi+i3vxAU3CfqBrY
         zHiWOqOHbu/3GSFzXnAbgThfq8j+l1PYpz/1pXcO8PxdhD5vPq551IPF6pTIBGvI6z
         zjSSk7ZhvWcVXEM5CdNmagp0J/2KdPB53n06yuN7dZ7FTDezV9IbWJTTZU71F2/j4e
         ObZ2M6BAoy1oiBl0lK/fePOnVcYISZocdWyZGSHq5t+TBdJxNnBovLmFW+Czd11/2b
         gXk+UPtVEVoSQ==
Date:   Sun, 24 Apr 2022 17:32:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     lars@metafoo.de, robh+dt@kernel.org, Zhigang.Shi@liteon.com,
        krzk@kernel.org, krisman@collabora.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, alvaro.soliverez@collabora.com
Subject: Re: [PATCH v2 3/3] iio: light: Add support for ltrf216a sensor
Message-ID: <20220424173210.554c8247@jic23-huawei>
In-Reply-To: <20220421140133.354498-4-shreeya.patel@collabora.com>
References: <20220421140133.354498-1-shreeya.patel@collabora.com>
        <20220421140133.354498-4-shreeya.patel@collabora.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2022 19:31:33 +0530
Shreeya Patel <shreeya.patel@collabora.com> wrote:

> From: Zhigang Shi <Zhigang.Shi@liteon.com>
> 
> Add initial support for ltrf216a ambient light sensor.
> 
> Datasheet: gitlab.steamos.cloud/shreeya/iio/-/blob/main/LTRF216A.pdf
> Co-developed-by: Shreeya Patel <shreeya.patel@collabora.com>
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> Signed-off-by: Zhigang Shi <Zhigang.Shi@liteon.com>

Hi Shreeya,

Looking pretty good.  Just a few minor things in here - I very nearly
just made the changes whilst applying but the one about reusing the
available array is slightly more complex than I like to do without
bouncing it back to the author.

Thanks,

Jonathan

> ---
> 
> Changes in v2
>   - Add support for 25ms and 50ms integration time.
>   - Rename some of the macros as per names given in datasheet
>   - Add a comment for the mutex lock
>   - Use read_avail callback instead of attributes and set the
>     appropriate _available bit.
>   - Use FIELD_PREP() at appropriate places.
>   - Add a constant lookup table for integration time and reg val
>   - Use BIT() macro for magic numbers.
>   - Improve error handling at few places.
>   - Use get_unaligned_le24() and div_u64()
>   - Use probe_new() callback and devm functions
>   - Return errors in probe using dev_err_probe()
>   - Use DEFINE_SIMPLE_DEV_PM_OPS()
>   - Correct the formula for lux to use 0.45 instead of 0.8
> 
> 
>  drivers/iio/light/Kconfig    |  10 +
>  drivers/iio/light/Makefile   |   1 +
>  drivers/iio/light/ltrf216a.c | 349 +++++++++++++++++++++++++++++++++++
>  3 files changed, 360 insertions(+)
>  create mode 100644 drivers/iio/light/ltrf216a.c
> 

> diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
> new file mode 100644
> index 000000000000..de6d2e2e7f08
> --- /dev/null
> +++ b/drivers/iio/light/ltrf216a.c
> @@ -0,0 +1,349 @@
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
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/i2c.h>
> +#include <linux/mutex.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

I don't think you are using anything from iio/sysfs.h any more so please
drop this header (unless I'm missing something!)

> +#include <linux/mod_devicetable.h>
> +#include <linux/bitfield.h>
> +#include <linux/pm.h>
> +#include <linux/delay.h>
> +#include <asm/unaligned.h>
> +
Where no other reason to have a particular order for headers IIO preference is
3 blocks of headers.  First set are the non IIO related ones in alphabetical order.
Second block typically IIO specific ones.  Final block the asm includes

So here best order is something like

#include <linux/bitfield.h>
#include <linux/delay.h>
#include <linux/init.h>
#include <linux/i2c.h>
#include <linux/module.h>
#include <linux/mod_devicetable.h>
#include <linux/mutex.h>
#include <linux/pm.h>

#include <linux/iio/iio.h>

#include <asm/unaligned.h>


> +#define LTRF216A_ALS_DATA_0		0x0D
> +
> +static const int int_time_mapping[] = { 400000, 200000, 100000, 50000, 25000 };

You should use the array below for the same matching purpose as this one and
avoid duplicating data.

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
> +	u8 int_time_fac;
> +	u8 als_gain_fac;
> +	struct mutex mutex; /* Protect read and write operations */

This could probably have been more descriptive. I think you are also
ensuring that the cached state and the device state are kept in sync.

> +};


> +
> +static int ltrf216a_get_lux(struct ltrf216a_data *data)
> +{
> +	int greendata, cleardata;
> +	u64 lux, div;
> +
> +	greendata = ltrf216a_read_data(data, LTRF216A_ALS_DATA_0);
> +	cleardata = ltrf216a_read_data(data, LTRF216A_CLEAR_DATA_0);
> +
> +	if (greendata < 0 || cleardata < 0) {
> +		return -EINVAL;

As this is an error case and you correctly return directly there is
no need to have else.  That will reduce indentation and
allow last line to simply be

return div_u64(lux, div);

> +
> +	} else {
> +		lux = greendata * 45 * WIN_FAC * 100;
> +		div = data->als_gain_fac * data->int_time_fac * 100;
> +		lux = div_u64(lux, div);
> +	}
> +
> +	return lux;
> +}
> +
