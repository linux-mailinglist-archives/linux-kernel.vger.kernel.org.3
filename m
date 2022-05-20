Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A6952F15D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 19:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352075AbiETRNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 13:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238817AbiETRN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 13:13:28 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A809AAFAFD;
        Fri, 20 May 2022 10:13:27 -0700 (PDT)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L4YFx32Hbz6H6mq;
        Sat, 21 May 2022 01:13:09 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 20 May 2022 19:13:25 +0200
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 20 May
 2022 18:13:24 +0100
Date:   Fri, 20 May 2022 18:13:23 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Yongzhi Liu <lyz_cs@pku.edu.cn>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <jic23@kernel.org>, <lars@metafoo.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <fuyq@stu.pku.edu.cn>
Subject: Re: [PATCH v2] iio: vadc: Fix potential dereference of NULL pointer
Message-ID: <20220520181323.00002892@huawei.com>
In-Reply-To: <1652939455-123139-1-git-send-email-lyz_cs@pku.edu.cn>
References: <YoUtezVzsPB8MAEO@google.com>
        <1652939455-123139-1-git-send-email-lyz_cs@pku.edu.cn>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml737-chm.china.huawei.com (10.201.108.187) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2022 22:50:55 -0700
Yongzhi Liu <lyz_cs@pku.edu.cn> wrote:

> The return value of vadc_get_channel() needs to be checked
> to avoid use of NULL pointer. Fix this by adding the null
> pointer check on prop.
> 
> Fixes: 0917de94c ("iio: vadc: Qualcomm SPMI PMIC voltage ADC driver")
> 
> Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>
This function has a lot of goto err; where err just results in
a print.

My suggestion is to just drop that print and use
error specific prints as you have done here, then use direct returns.

> ---
>  drivers/iio/adc/qcom-spmi-vadc.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
> index 34202ba..9fa61fb 100644
> --- a/drivers/iio/adc/qcom-spmi-vadc.c
> +++ b/drivers/iio/adc/qcom-spmi-vadc.c
> @@ -358,14 +358,25 @@ static int vadc_measure_ref_points(struct vadc_priv *vadc)
>  	vadc->graph[VADC_CALIB_ABSOLUTE].dx = VADC_ABSOLUTE_RANGE_UV;
>  
>  	prop = vadc_get_channel(vadc, VADC_REF_1250MV);
> +	if (!prop) {
> +		dev_err(vadc->dev, "Please define 1.25V channel\n");
> +		ret = -ENODEV;
> +		goto err;
> +	}
>  	ret = vadc_do_conversion(vadc, prop, &read_1);
>  	if (ret)
>  		goto err;
>  
>  	/* Try with buffered 625mV channel first */
>  	prop = vadc_get_channel(vadc, VADC_SPARE1);
> -	if (!prop)
> +	if (!prop) {
>  		prop = vadc_get_channel(vadc, VADC_REF_625MV);
> +		if (!prop) {
> +			dev_err(vadc->dev, "Please define 0.625V channel\n");
> +			ret = -ENODEV;
> +			goto err;
> +		}
> +	}
>  
>  	ret = vadc_do_conversion(vadc, prop, &read_2);
>  	if (ret)
> @@ -381,11 +392,21 @@ static int vadc_measure_ref_points(struct vadc_priv *vadc)
>  
>  	/* Ratiometric calibration */
>  	prop = vadc_get_channel(vadc, VADC_VDD_VADC);
> +	if (!prop) {
> +		dev_err(vadc->dev, "Please define VDD channel\n");
> +		ret = -ENODEV;
> +		goto err;
> +	}
>  	ret = vadc_do_conversion(vadc, prop, &read_1);
>  	if (ret)
>  		goto err;
>  
>  	prop = vadc_get_channel(vadc, VADC_GND_REF);
> +	if (!prop) {
> +		dev_err(vadc->dev, "Please define GND channel\n");
> +		ret = -ENODEV;
> +		goto err;
> +	}
>  	ret = vadc_do_conversion(vadc, prop, &read_2);
>  	if (ret)
>  		goto err;

