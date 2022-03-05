Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7C04CE5BB
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 17:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiCEQFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 11:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiCEQFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 11:05:34 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C62369C1;
        Sat,  5 Mar 2022 08:04:44 -0800 (PST)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K9qJY32ffz67WtW;
        Sun,  6 Mar 2022 00:03:25 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 5 Mar 2022 17:04:42 +0100
Received: from localhost (10.47.66.18) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 5 Mar
 2022 16:04:42 +0000
Date:   Sat, 5 Mar 2022 16:04:39 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <cgel.zte@gmail.com>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        <tangbin@cmss.chinamobile.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] iio:adc:twl6030: Use of_device_get_match_data()
Message-ID: <20220305160439.00000184@Huawei.com>
In-Reply-To: <20220304015932.2061712-1-chi.minghao@zte.com.cn>
References: <20220304015932.2061712-1-chi.minghao@zte.com.cn>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.66.18]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
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

On Fri,  4 Mar 2022 01:59:32 +0000
cgel.zte@gmail.com wrote:

> From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
> 
> Use of_device_get_match_data() to simplify the code.
> 
> v1->v2:
>   iio:adc:->iio:adc:twl6030:
Hi,

For IIO please put the change log below the ---
A few areas of the kernel do this differently but we are consistent
in using link tags (generated when I apply the patch) to give
access to change logs rather than having them stored for ever
in the main git log.

> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>

You haven't addressed my request in reply to previous posting
to use device_get_match_data() and switch to the generic
properties interfaces.  I'd rather see that done in one step
then going via this cleanup.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/twl6030-gpadc.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
> index afdb59e0b526..6a022e583658 100644
> --- a/drivers/iio/adc/twl6030-gpadc.c
> +++ b/drivers/iio/adc/twl6030-gpadc.c
> @@ -867,16 +867,11 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct twl6030_gpadc_data *gpadc;
>  	const struct twl6030_gpadc_platform_data *pdata;
> -	const struct of_device_id *match;
>  	struct iio_dev *indio_dev;
>  	int irq;
>  	int ret;
>  
> -	match = of_match_device(of_twl6030_match_tbl, dev);
> -	if (!match)
> -		return -EINVAL;
> -
> -	pdata = match->data;
> +	pdata = of_device_get_match_data(dev);
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*gpadc));
>  	if (!indio_dev)

