Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5B34986FB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244675AbiAXRfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:35:04 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4481 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244699AbiAXRfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:35:03 -0500
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JjH7r0Mdjz6FGjl;
        Tue, 25 Jan 2022 01:30:48 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 18:35:01 +0100
Received: from localhost (10.47.74.148) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 24 Jan
 2022 17:35:00 +0000
Date:   Mon, 24 Jan 2022 17:34:57 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jeff LaBundy <jeff@labundy.com>
CC:     <lee.jones@linaro.org>, <jic23@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: temperature: iqs620at-temp: Add support for V3
 silicon
Message-ID: <20220124173457.00006728@Huawei.com>
In-Reply-To: <20220123190106.80591-3-jeff@labundy.com>
References: <20220123190106.80591-1-jeff@labundy.com>
        <20220123190106.80591-3-jeff@labundy.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.74.148]
X-ClientProxiedBy: lhreml739-chm.china.huawei.com (10.201.108.189) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jan 2022 13:01:06 -0600
Jeff LaBundy <jeff@labundy.com> wrote:

> The vendor introduced an updated revision of IQS620A(T) silicon
> which is backwards-compatible with previous revisions, the only
> exception being the offset used to derive temperature.
> 
> Enable this new revision by returning the appropriate offset as
> a function of the hardware number provided by the parent MFD.
> 
> Signed-off-by: Jeff LaBundy <jeff@labundy.com>
Trivial comment inline but I'm fine with this either way.
Assuming it will go through mfd.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/iio/temperature/iqs620at-temp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/temperature/iqs620at-temp.c b/drivers/iio/temperature/iqs620at-temp.c
> index fe126e1fb783..e2f878d57af7 100644
> --- a/drivers/iio/temperature/iqs620at-temp.c
> +++ b/drivers/iio/temperature/iqs620at-temp.c
> @@ -17,6 +17,7 @@
>  
>  #define IQS620_TEMP_SCALE			1000
>  #define IQS620_TEMP_OFFSET			(-100)
> +#define IQS620_TEMP_OFFSET_V3			(-40)
>  
>  static int iqs620_temp_read_raw(struct iio_dev *indio_dev,
>  				struct iio_chan_spec const *chan,
> @@ -41,7 +42,8 @@ static int iqs620_temp_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT;
>  
>  	case IIO_CHAN_INFO_OFFSET:
> -		*val = IQS620_TEMP_OFFSET;
> +		*val = iqs62x->hw_num < IQS620_HW_NUM_V3 ? IQS620_TEMP_OFFSET
> +							 : IQS620_TEMP_OFFSET_V3;

Line is a bit long, so maybe it would be better to just use an if / else

		if (iqs6x->hw_num < IQS620_HW_NUM_V3)
			*val = IQS620_TEMP_OFFSET;
		else
			*val = IQS620_TEMP_OFFSET_V3;


>  		return IIO_VAL_INT;
>  
>  	default:

