Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D339848533C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 14:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbiAENHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 08:07:47 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4350 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236840AbiAENHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 08:07:41 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JTV855VHqz682w5;
        Wed,  5 Jan 2022 21:05:09 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 14:07:38 +0100
Received: from localhost (10.47.83.118) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Wed, 5 Jan
 2022 13:07:37 +0000
Date:   Wed, 5 Jan 2022 13:07:43 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Miaoqian Lin <linmq006@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Adriana Reus <adi.reus@gmail.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: gyro: bmg160: Fix error handling in
 bmg160_core_probe
Message-ID: <20220105130743.00001661@Huawei.com>
In-Reply-To: <20220105125633.21989-1-linmq006@gmail.com>
References: <20220105125633.21989-1-linmq006@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.83.118]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  5 Jan 2022 12:56:30 +0000
Miaoqian Lin <linmq006@gmail.com> wrote:

> The pm_runtime_enable will increase power disable depth.
> If the probe fails, we should use pm_runtime_disable() to balance
> pm_runtime_enable(). In the PM Runtime docs:
>     Drivers in ->remove() callback should undo the runtime PM changes done
>     in ->probe(). Usually this means calling pm_runtime_disable(),
>     pm_runtime_dont_use_autosuspend() etc.
> We should do this in error handling.
> 
> Fixes: 7d0ead5 ("iio: Reconcile operation order between iio_register/unregister and pm functions")

Hi Miaoqian,

Please check this fixes tag against the format it should have.

Thanks,

Jonathan


> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/iio/gyro/bmg160_core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
> index 17b939a367ad..81a6d09788bd 100644
> --- a/drivers/iio/gyro/bmg160_core.c
> +++ b/drivers/iio/gyro/bmg160_core.c
> @@ -1188,11 +1188,14 @@ int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0) {
>  		dev_err(dev, "unable to register iio device\n");
> -		goto err_buffer_cleanup;
> +		goto err_pm_cleanup;
>  	}
>  
>  	return 0;
>  
> +err_pm_cleanup:
> +	pm_runtime_dont_use_autosuspend(dev);
> +	pm_runtime_disable(dev);
>  err_buffer_cleanup:
>  	iio_triggered_buffer_cleanup(indio_dev);
>  err_trigger_unregister:

