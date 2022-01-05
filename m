Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFCD4850FB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239361AbiAEKRy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 Jan 2022 05:17:54 -0500
Received: from aposti.net ([89.234.176.197]:49148 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239352AbiAEKRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:17:52 -0500
Date:   Wed, 05 Jan 2022 10:17:40 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 8/8] iio: gyro: mpu3050: Use new PM macros
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>, list@opendingux.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pm@vger.kernel.org
Message-Id: <G9F85R.NKLOHGES4L8G@crapouillou.net>
In-Reply-To: <20220105101106.00005ae0@Huawei.com>
References: <20220104214214.198843-1-paul@crapouillou.net>
        <20220104214214.198843-9-paul@crapouillou.net>
        <20220105101106.00005ae0@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le mer., janv. 5 2022 at 10:11:06 +0000, Jonathan Cameron 
<Jonathan.Cameron@Huawei.com> a écrit :
> On Tue, 4 Jan 2022 21:42:14 +0000
> Paul Cercueil <paul@crapouillou.net> wrote:
> 
>>  Use the new EXPORT_RUNTIME_DEV_PM_OPS() macro. It allows the 
>> underlying
>>  dev_pm_ops struct as well as the suspend/resume callbacks to be 
>> detected
>>  as dead code in the case where CONFIG_PM is disabled, without 
>> having to
>>  wrap everything inside #ifdef CONFIG_PM guards.
>> 
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> 
> Hohum - bad choice of example. These shouldn't be exported as only 
> used within
> the same module ;)  No one ever wrote the other bus interface (and 
> the part is
> ancient so I can't see it happening now) hence whilst there are two 
> files, they
> are built into a single module.  There is a comment about this in the 
> Makefile.

Ok - then I'll drop this patch and try to find a better driver to 
showcase this.

Cheers,
-Paul

>>  ---
>>   drivers/iio/gyro/mpu3050-core.c | 13 ++++---------
>>   drivers/iio/gyro/mpu3050-i2c.c  |  2 +-
>>   2 files changed, 5 insertions(+), 10 deletions(-)
>> 
>>  diff --git a/drivers/iio/gyro/mpu3050-core.c 
>> b/drivers/iio/gyro/mpu3050-core.c
>>  index ea387efab62d..7d6721e268fe 100644
>>  --- a/drivers/iio/gyro/mpu3050-core.c
>>  +++ b/drivers/iio/gyro/mpu3050-core.c
>>  @@ -1281,7 +1281,6 @@ int mpu3050_common_remove(struct device *dev)
>>   }
>>   EXPORT_SYMBOL(mpu3050_common_remove);
>> 
>>  -#ifdef CONFIG_PM
>>   static int mpu3050_runtime_suspend(struct device *dev)
>>   {
>>   	return mpu3050_power_down(iio_priv(dev_get_drvdata(dev)));
>>  @@ -1291,15 +1290,11 @@ static int mpu3050_runtime_resume(struct 
>> device *dev)
>>   {
>>   	return mpu3050_power_up(iio_priv(dev_get_drvdata(dev)));
>>   }
>>  -#endif /* CONFIG_PM */
>> 
>>  -const struct dev_pm_ops mpu3050_dev_pm_ops = {
>>  -	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>>  -				pm_runtime_force_resume)
>>  -	SET_RUNTIME_PM_OPS(mpu3050_runtime_suspend,
>>  -			   mpu3050_runtime_resume, NULL)
>>  -};
>>  -EXPORT_SYMBOL(mpu3050_dev_pm_ops);
>>  +EXPORT_RUNTIME_DEV_PM_OPS(mpu3050_dev_pm_ops,
>>  +			  mpu3050_runtime_suspend,
>>  +			  mpu3050_runtime_resume,
>>  +			  NULL);
>> 
>>   MODULE_AUTHOR("Linus Walleij");
>>   MODULE_DESCRIPTION("MPU3050 gyroscope driver");
>>  diff --git a/drivers/iio/gyro/mpu3050-i2c.c 
>> b/drivers/iio/gyro/mpu3050-i2c.c
>>  index ef5bcbc4b45b..820133cad601 100644
>>  --- a/drivers/iio/gyro/mpu3050-i2c.c
>>  +++ b/drivers/iio/gyro/mpu3050-i2c.c
>>  @@ -114,7 +114,7 @@ static struct i2c_driver mpu3050_i2c_driver = {
>>   	.driver = {
>>   		.of_match_table = mpu3050_i2c_of_match,
>>   		.name = "mpu3050-i2c",
>>  -		.pm = &mpu3050_dev_pm_ops,
>>  +		.pm = pm_ptr(&mpu3050_dev_pm_ops),
>>   	},
>>   };
>>   module_i2c_driver(mpu3050_i2c_driver);
> 


