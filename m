Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED0448656C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 14:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239648AbiAFNm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 08:42:29 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4354 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiAFNmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 08:42:24 -0500
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JV6sf4pLnz67Vhh;
        Thu,  6 Jan 2022 21:39:50 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 14:42:22 +0100
Received: from localhost (10.47.27.61) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 6 Jan
 2022 13:42:21 +0000
Date:   Thu, 6 Jan 2022 13:42:23 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Arnd Bergmann" <arnd@arndb.de>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>, <list@opendingux.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 6/6] iio: pressure: bmp280: Use new PM macros
Message-ID: <20220106134223.00006a9f@Huawei.com>
In-Reply-To: <20220105182939.106885-7-paul@crapouillou.net>
References: <20220105182939.106885-1-paul@crapouillou.net>
        <20220105182939.106885-7-paul@crapouillou.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.27.61]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jan 2022 18:29:39 +0000
Paul Cercueil <paul@crapouillou.net> wrote:

> Use the new EXPORT_RUNTIME_DEV_PM_OPS() macro. It allows the underlying
> dev_pm_ops struct as well as the suspend/resume callbacks to be detected
> as dead code in the case where CONFIG_PM is disabled, without having to
> wrap everything inside #ifdef CONFIG_PM guards.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks

> ---
> 
> Notes:
>     v2: New patch
> 
>  drivers/iio/pressure/bmp280-core.c | 11 ++---------
>  drivers/iio/pressure/bmp280-i2c.c  |  2 +-
>  drivers/iio/pressure/bmp280-spi.c  |  2 +-
>  3 files changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 6b7da40f99c8..bf8167f43c56 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -1138,7 +1138,6 @@ int bmp280_common_probe(struct device *dev,
>  }
>  EXPORT_SYMBOL(bmp280_common_probe);
>  
> -#ifdef CONFIG_PM
>  static int bmp280_runtime_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> @@ -1159,15 +1158,9 @@ static int bmp280_runtime_resume(struct device *dev)
>  	usleep_range(data->start_up_time, data->start_up_time + 100);
>  	return data->chip_info->chip_config(data);
>  }
> -#endif /* CONFIG_PM */
>  
> -const struct dev_pm_ops bmp280_dev_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> -				pm_runtime_force_resume)
> -	SET_RUNTIME_PM_OPS(bmp280_runtime_suspend,
> -			   bmp280_runtime_resume, NULL)
> -};
> -EXPORT_SYMBOL(bmp280_dev_pm_ops);
> +EXPORT_RUNTIME_DEV_PM_OPS(bmp280_dev_pm_ops, bmp280_runtime_suspend,
> +			  bmp280_runtime_resume, NULL);
>  
>  MODULE_AUTHOR("Vlad Dogaru <vlad.dogaru@intel.com>");
>  MODULE_DESCRIPTION("Driver for Bosch Sensortec BMP180/BMP280 pressure and temperature sensor");
> diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
> index 8b03ea15c0d0..35045bd92846 100644
> --- a/drivers/iio/pressure/bmp280-i2c.c
> +++ b/drivers/iio/pressure/bmp280-i2c.c
> @@ -58,7 +58,7 @@ static struct i2c_driver bmp280_i2c_driver = {
>  	.driver = {
>  		.name	= "bmp280",
>  		.of_match_table = bmp280_of_i2c_match,
> -		.pm = &bmp280_dev_pm_ops,
> +		.pm = pm_ptr(&bmp280_dev_pm_ops),
>  	},
>  	.probe		= bmp280_i2c_probe,
>  	.id_table	= bmp280_i2c_id,
> diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
> index 625b86878ad8..41f6cc56d229 100644
> --- a/drivers/iio/pressure/bmp280-spi.c
> +++ b/drivers/iio/pressure/bmp280-spi.c
> @@ -109,7 +109,7 @@ static struct spi_driver bmp280_spi_driver = {
>  	.driver = {
>  		.name = "bmp280",
>  		.of_match_table = bmp280_of_spi_match,
> -		.pm = &bmp280_dev_pm_ops,
> +		.pm = pm_ptr(&bmp280_dev_pm_ops),
>  	},
>  	.id_table = bmp280_spi_id,
>  	.probe = bmp280_spi_probe,

