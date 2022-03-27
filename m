Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2F54E88E4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 18:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236049AbiC0Qj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 12:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236042AbiC0Qjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 12:39:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93515CE7;
        Sun, 27 Mar 2022 09:38:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10A85B80D88;
        Sun, 27 Mar 2022 16:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3C1C340EC;
        Sun, 27 Mar 2022 16:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648399092;
        bh=ohmr/grIdQuAq8gGll+TPucDDR6vVnZqbYEs4VnBTBE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kLFL+JzMsK1Rvt9ZeC/RzS05s5JBkUcDEkaZVxoUlPTVoOvpwdd2Qr8ztrrjFWRyh
         8PQfXbBiYt9H6VnF+JN28w5+u8ThhPnNi7r2iPUXhqyxY0yE27diW+QAY/zhr9OWKj
         O0f1Ka4aGjTjimaOqpm+1G3gQHQv4/PRKVYHxAqlSi+PPyq5RGtdlrWS3yk10PGUGd
         st7mrvXDEop0l7MIMmc5Uc3kp6LHDF1OcMn4CqoGfbcd2uDnp45zGz8Uw16aQIwu3X
         DURhzOWPqVt4pP98mkMWnWXy7dH+EfIFklbMuSLBm5+o09kwTRTNvBUxz7sSRbkNr3
         Jvbe9i02LdJIA==
Date:   Sun, 27 Mar 2022 17:45:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     dan@dlrobertson.com, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] iio: accel: bma400: Add triggered buffer support
Message-ID: <20220327174545.41a15150@jic23-huawei>
In-Reply-To: <20220326194146.15549-4-jagathjog1996@gmail.com>
References: <20220326194146.15549-1-jagathjog1996@gmail.com>
        <20220326194146.15549-4-jagathjog1996@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Mar 2022 01:11:44 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Added trigger buffer support to read continuous acceleration
> data from device with data ready interrupt which is mapped
> to INT1 pin.
> 
> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
Hi Jagath,

Just a few small things noticed on this read through.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/Kconfig       |   2 +
>  drivers/iio/accel/bma400.h      |  10 +-
>  drivers/iio/accel/bma400_core.c | 162 ++++++++++++++++++++++++++++++--
>  drivers/iio/accel/bma400_i2c.c  |   2 +-
>  drivers/iio/accel/bma400_spi.c  |   2 +-
>  5 files changed, 168 insertions(+), 10 deletions(-)
> 

> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> index dc273381a0a2..fa3f4b5f229f 100644
> --- a/drivers/iio/accel/bma400_core.c
> +++ b/drivers/iio/accel/bma400_core.c
> @@ -11,16 +11,22 @@
>   *  - Create channel for sensor time
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/device.h>
> -#include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

Is iio/sysfs.h actually used?  It rarely is these days as it contains
the infrastructure for custom attributes and we try not to use any
of those anymore.

> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
This reorganization of headers is good but shouldn't be in this patch.
Add an earlier patch in the series to move the existing pair down here
before this patch then adds the new ones.


...

>  
>  static int bma400_get_temp_reg(struct bma400_data *data, int *val, int *val2)
> @@ -659,6 +687,10 @@ static int bma400_init(struct bma400_data *data)
>  	if (ret)
>  		return ret;
>  
> +	/* Configure INT1 pin to open drain */
> +	ret = regmap_write(data->regmap, BMA400_INT_IO_CTRL_REG, 0x06);
> +	if (ret)
> +		return ret;
>  	/*
>  	 * Once the interrupt engine is supported we might use the
>  	 * data_src_reg, but for now ensure this is set to the
> @@ -807,6 +839,33 @@ static int bma400_write_raw_get_fmt(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static int bma400_data_rdy_trigger_set_state(struct iio_trigger *trig,
> +					     bool state)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct bma400_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = regmap_update_bits(data->regmap, BMA400_INT_CONFIG0_REG,
> +				 BMA400_INT_DRDY_MSK,
> +				 FIELD_PREP(BMA400_INT_DRDY_MSK, state));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(data->regmap, BMA400_INT1_MAP_REG,
> +				 BMA400_INT_DRDY_MSK,
> +				 FIELD_PREP(BMA400_INT_DRDY_MSK, state));
> +	if (ret)
> +		return ret;
> +
> +	return 0;

	return regmap_update_bits()...

> +}

...


> +static irqreturn_t bma400_interrupt(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct bma400_data *data = iio_priv(indio_dev);
> +	irqreturn_t ret = IRQ_NONE;
> +	__le16 status;
> +
> +	mutex_lock(&data->mutex);
> +	ret = regmap_bulk_read(data->regmap, BMA400_INT_STAT0_REG, &status,
> +			       sizeof(status));
> +	mutex_unlock(&data->mutex);
> +	if (ret)
> +		return IRQ_NONE;
> +
> +	if (FIELD_GET(BMA400_INT_DRDY_MSK, le16_to_cpu(status))) {
> +		iio_trigger_poll_chained(data->trig);
> +		ret = IRQ_HANDLED;
Preference for this style
		return IRQ_HANDLED;
> +	}
> +
return IRQ_NONE;
and don't initialize above.

> +	return ret;
> +}
> +


