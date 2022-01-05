Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A024850C3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239261AbiAEKLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:11:06 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4340 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbiAEKLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:11:03 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JTQDJ5nnqz67Q0K;
        Wed,  5 Jan 2022 18:08:32 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 11:11:01 +0100
Received: from localhost (10.47.83.118) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Wed, 5 Jan
 2022 10:11:00 +0000
Date:   Wed, 5 Jan 2022 10:11:06 +0000
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
Subject: Re: [PATCH 8/8] iio: gyro: mpu3050: Use new PM macros
Message-ID: <20220105101106.00005ae0@Huawei.com>
In-Reply-To: <20220104214214.198843-9-paul@crapouillou.net>
References: <20220104214214.198843-1-paul@crapouillou.net>
        <20220104214214.198843-9-paul@crapouillou.net>
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

On Tue, 4 Jan 2022 21:42:14 +0000
Paul Cercueil <paul@crapouillou.net> wrote:

> Use the new EXPORT_RUNTIME_DEV_PM_OPS() macro. It allows the underlying
> dev_pm_ops struct as well as the suspend/resume callbacks to be detected
> as dead code in the case where CONFIG_PM is disabled, without having to
> wrap everything inside #ifdef CONFIG_PM guards.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Hohum - bad choice of example. These shouldn't be exported as only used within
the same module ;)  No one ever wrote the other bus interface (and the part is
ancient so I can't see it happening now) hence whilst there are two files, they
are built into a single module.  There is a comment about this in the Makefile.

Jonathan


> ---
>  drivers/iio/gyro/mpu3050-core.c | 13 ++++---------
>  drivers/iio/gyro/mpu3050-i2c.c  |  2 +-
>  2 files changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> index ea387efab62d..7d6721e268fe 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c
> @@ -1281,7 +1281,6 @@ int mpu3050_common_remove(struct device *dev)
>  }
>  EXPORT_SYMBOL(mpu3050_common_remove);
>  
> -#ifdef CONFIG_PM
>  static int mpu3050_runtime_suspend(struct device *dev)
>  {
>  	return mpu3050_power_down(iio_priv(dev_get_drvdata(dev)));
> @@ -1291,15 +1290,11 @@ static int mpu3050_runtime_resume(struct device *dev)
>  {
>  	return mpu3050_power_up(iio_priv(dev_get_drvdata(dev)));
>  }
> -#endif /* CONFIG_PM */
>  
> -const struct dev_pm_ops mpu3050_dev_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> -				pm_runtime_force_resume)
> -	SET_RUNTIME_PM_OPS(mpu3050_runtime_suspend,
> -			   mpu3050_runtime_resume, NULL)
> -};
> -EXPORT_SYMBOL(mpu3050_dev_pm_ops);
> +EXPORT_RUNTIME_DEV_PM_OPS(mpu3050_dev_pm_ops,
> +			  mpu3050_runtime_suspend,
> +			  mpu3050_runtime_resume,
> +			  NULL);
>  
>  MODULE_AUTHOR("Linus Walleij");
>  MODULE_DESCRIPTION("MPU3050 gyroscope driver");
> diff --git a/drivers/iio/gyro/mpu3050-i2c.c b/drivers/iio/gyro/mpu3050-i2c.c
> index ef5bcbc4b45b..820133cad601 100644
> --- a/drivers/iio/gyro/mpu3050-i2c.c
> +++ b/drivers/iio/gyro/mpu3050-i2c.c
> @@ -114,7 +114,7 @@ static struct i2c_driver mpu3050_i2c_driver = {
>  	.driver = {
>  		.of_match_table = mpu3050_i2c_of_match,
>  		.name = "mpu3050-i2c",
> -		.pm = &mpu3050_dev_pm_ops,
> +		.pm = pm_ptr(&mpu3050_dev_pm_ops),
>  	},
>  };
>  module_i2c_driver(mpu3050_i2c_driver);

