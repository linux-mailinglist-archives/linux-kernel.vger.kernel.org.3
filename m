Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2372458FD58
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 15:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbiHKNZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 09:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbiHKNZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 09:25:23 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C118D45F4D;
        Thu, 11 Aug 2022 06:25:22 -0700 (PDT)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M3S9T0T85z67MDp;
        Thu, 11 Aug 2022 21:20:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 11 Aug 2022 15:25:20 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 11 Aug
 2022 14:25:19 +0100
Date:   Thu, 11 Aug 2022 14:25:18 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Shreeya Patel <shreeya.patel@collabora.com>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <krisman@collabora.com>,
        <kernel@collabora.com>, <alvaro.soliverez@collabora.com>
Subject: Re: [PATCH] iio: light: Add raw attribute
Message-ID: <20220811142518.00000256@huawei.com>
In-Reply-To: <20220811101443.499761-1-shreeya.patel@collabora.com>
References: <20220811101443.499761-1-shreeya.patel@collabora.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Aug 2022 15:44:43 +0530
Shreeya Patel <shreeya.patel@collabora.com> wrote:

> Add IIO_CHAN_INFO_RAW to the mask to be able to read raw values
> from the light sensor.

Why is this useful?  It's rare to support _PROCESSED and _RAW for the same channel.
Normally occurred to avoid breaking ABI.

Jonathan

> 
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> ---
>  drivers/iio/light/ltrf216a.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
> index e6e24e70d2b9..a717bf99bd2a 100644
> --- a/drivers/iio/light/ltrf216a.c
> +++ b/drivers/iio/light/ltrf216a.c
> @@ -93,6 +93,7 @@ static const struct iio_chan_spec ltrf216a_channels[] = {
>  	{
>  		.type = IIO_LIGHT,
>  		.info_mask_separate =
> +			BIT(IIO_CHAN_INFO_RAW) |
>  			BIT(IIO_CHAN_INFO_PROCESSED) |
>  			BIT(IIO_CHAN_INFO_INT_TIME),
>  		.info_mask_separate_available =
> @@ -259,6 +260,18 @@ static int ltrf216a_read_raw(struct iio_dev *indio_dev,
>  	int ret;
>  
>  	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = ltrf216a_set_power_state(data, true);
> +		if (ret)
> +			return ret;
> +		mutex_lock(&data->lock);
> +		ret = ltrf216a_read_data(data, LTRF216A_ALS_DATA_0);
> +		mutex_unlock(&data->lock);
> +		if (ret < 0)
> +			return ret;
> +		*val = ret;
> +		ltrf216a_set_power_state(data, false);
> +		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_PROCESSED:
>  		mutex_lock(&data->lock);
>  		ret = ltrf216a_get_lux(data);

