Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2F651E8A4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 18:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357593AbiEGQyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 12:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbiEGQyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 12:54:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0737648;
        Sat,  7 May 2022 09:50:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB47D61315;
        Sat,  7 May 2022 16:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12890C385A9;
        Sat,  7 May 2022 16:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651942245;
        bh=N6wSTTrbp4oNmVGkBlT6oxcqKxrzckms1p42H5ozv7Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vJNKfpwJc4JYlt1XBcOW2DCXcmeRRODOCFhDODagsiKww9hsobIJPzop0mK7LQZMy
         RH0Zpsj+kqF7tHTPgBEzYMnrNgCxTC119B5VaAtdf9v76bZHA3MlNwc36BmWp8qDFm
         C7XdUGsshW5WJANr5gLOTIOsJu34yxiBslG/K5gQbFJm2dPgwqe7Y0yEzPqbR5ZGf9
         zRY7fWjRR2fmwAjSbHBZl6irtjwhm+sTvHFhXt9WVawExFFvjFKQKZOUsxz7GoD7yf
         rMfm4KG4WwnQtjWwKy6PqAST1d1B6XqYEh+RdRVImqGoYxxzeS8TVaynDswfub2vNn
         Gl7YV6bXycAhQ==
Date:   Sat, 7 May 2022 17:59:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     lars@metafoo.de, robh+dt@kernel.org, Zhigang.Shi@liteon.com,
        krzk@kernel.org, krisman@collabora.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, alvaro.soliverez@collabora.com
Subject: Re: [PATCH v3 3/3] iio: light: Add support for ltrf216a sensor
Message-ID: <20220507175912.10264563@jic23-huawei>
In-Reply-To: <20220503144354.75438-4-shreeya.patel@collabora.com>
References: <20220503144354.75438-1-shreeya.patel@collabora.com>
        <20220503144354.75438-4-shreeya.patel@collabora.com>
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

On Tue,  3 May 2022 20:13:54 +0530
Shreeya Patel <shreeya.patel@collabora.com> wrote:

> From: Zhigang Shi <Zhigang.Shi@liteon.com>
> 
> Add initial support for ltrf216a ambient light sensor.
> 
> Datasheet: gitlab.steamos.cloud/shreeya/iio/-/blob/main/LTRF216A.pdf
> Co-developed-by: Shreeya Patel <shreeya.patel@collabora.com>
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> Signed-off-by: Zhigang Shi <Zhigang.Shi@liteon.com>

One locking bug, otherwise just the lock documentation to resolve.

Thanks,

Jonathan



> +
> +struct ltrf216a_data {
> +	struct i2c_client *client;
> +	u32 int_time;
> +	u16 int_time_fac;
> +	u8 als_gain_fac;
> +	struct mutex mutex; /* Protect read and write operations */

See other branch of thread for feedback on that comment

Thanks for highlighting that btw. I'd forgotten about it so might have
missed it on a fresh read through.

> +};
> +
> +/* open air. need to update based on TP transmission rate. */
> +#define WIN_FAC	1
> +

> +
> +static int ltrf216a_read_data(struct ltrf216a_data *data, u8 addr)
> +{
> +	int i, ret = -1, tries = 25;
> +	u8 buf[3];
> +
> +	while (tries--) {
> +		ret = i2c_smbus_read_byte_data(data->client, LTRF216A_MAIN_STATUS);
> +		if (ret < 0)
> +			return ret;
> +		if (ret & LTRF216A_ALS_DATA_STATUS)
> +			break;
> +		msleep(20);
> +	}
> +
> +	for (i = 0; i < 3; i++) {
> +		ret = i2c_smbus_read_byte_data(data->client, addr);

Might be worth seeing if the device copes with
i2c_smbus_read_i2c_block_data()
The datasheet doesn't mention it though so it might well not work.


> +		if (ret < 0)
> +			return ret;
> +		buf[i] = ret;
> +		addr++;
> +	}
> +
> +	return get_unaligned_le24(&buf[0]);
> +}

> +
> +static int ltrf216a_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int *val,
> +			     int *val2, long mask)
> +{
> +	int ret;
> +	struct ltrf216a_data *data = iio_priv(indio_dev);
> +
> +	mutex_lock(&data->mutex);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		ret = ltrf216a_get_lux(data);
> +		if (ret < 0)
> +			return ret;

Check your locking.  This path doesn't unlock the mutex.

> +		*val = ret;
> +		ret = IIO_VAL_INT;
> +		break;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		ret = ltrf216a_get_int_time(data, val, val2);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +

> +
