Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3044FAD20
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 12:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbiDJKLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 06:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiDJKLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 06:11:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9830056742;
        Sun, 10 Apr 2022 03:08:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 140B860EFD;
        Sun, 10 Apr 2022 10:08:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F52DC385A4;
        Sun, 10 Apr 2022 10:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649585329;
        bh=5hnhj8lRLwppHniJP4Ld6iOLqg92e97n3QjacjSZxyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MspoahMdWZaxNi2eaHZFxKy2ApJ7h4AttsBZqB1XHVDKMMH288fI4IIdYvuG1YWRx
         EXEA1EE47u53HudY30bNRRk3HBMk9WDuqw/MQoRTS02PLIPnho70QjHj3Kyi81rbT0
         L5Str++WG516zHgO19LuCpoQWWtYTHgORmYykPS433U854mdJt0tg7ZBBErLjCOI9A
         ToSosVqfaQMWcVqa/8qUrVpAgIFW5IYKZntiOlLV/tSujMUgpYInc4yVQ9DjSG6/yi
         l+9Xoq3pZuQ9/5MurFgHj6ApRrZy3yfR5lzwJEv7jXHRst3tzatuLQ6Uv13F2eokMA
         OIJWimajKD1WA==
Received: by pali.im (Postfix)
        id E80717EE; Sun, 10 Apr 2022 12:08:45 +0200 (CEST)
Date:   Sun, 10 Apr 2022 12:08:45 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm) Add cooling device support
Message-ID: <20220410100845.2isvctcw643yfp7n@pali>
References: <20220330163324.572437-1-W_Armin@gmx.de>
 <757b30ef-e250-063f-7523-030f56b1d0b8@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <757b30ef-e250-063f-7523-030f56b1d0b8@gmx.de>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 09 April 2022 17:33:48 Armin Wolf wrote:
> Am 30.03.22 um 18:33 schrieb Armin Wolf:
> 
> > Until now, only the temperature sensors where exported thru
> > the thermal subsystem. Export the fans as "dell-smm-fan[1-3]" too
> > to make them available as cooling devices.
> > Also update Documentation.
> > 
> > Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> > ---
> >   Documentation/hwmon/dell-smm-hwmon.rst |  7 ++
> >   drivers/hwmon/Kconfig                  |  1 +
> >   drivers/hwmon/dell-smm-hwmon.c         | 94 +++++++++++++++++++++++++-
> >   3 files changed, 99 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation/hwmon/dell-smm-hwmon.rst
> > index d3323a96665d..41839b7de2c1 100644
> > --- a/Documentation/hwmon/dell-smm-hwmon.rst
> > +++ b/Documentation/hwmon/dell-smm-hwmon.rst
> > @@ -86,6 +86,13 @@ probe the BIOS on your machine and discover the appropriate codes.
> > 
> >   Again, when you find new codes, we'd be happy to have your patches!
> > 
> > +``thermal`` interface
> > +---------------------------
> > +
> > +The driver also exports the fans as thermal cooling devices with
> > +``type`` set to ``dell-smm-fan[1-3]``. This allows for easy fan control
> > +using one of the thermal governors.
> > +
> >   Module parameters
> >   -----------------
> > 
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 9ab4e9b3d27b..1175b8e38c45 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -498,6 +498,7 @@ config SENSORS_DS1621
> >   config SENSORS_DELL_SMM
> >   	tristate "Dell laptop SMM BIOS hwmon driver"
> >   	depends on X86
> > +	imply THERMAL
> >   	help
> >   	  This hwmon driver adds support for reporting temperature of different
> >   	  sensors and controls the fans on Dell laptops via System Management
> > diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> > index 84cb1ede7bc0..0c29386f4bd3 100644
> > --- a/drivers/hwmon/dell-smm-hwmon.c
> > +++ b/drivers/hwmon/dell-smm-hwmon.c
> > @@ -21,6 +21,7 @@
> >   #include <linux/errno.h>
> >   #include <linux/hwmon.h>
> >   #include <linux/init.h>
> > +#include <linux/kconfig.h>
> >   #include <linux/kernel.h>
> >   #include <linux/module.h>
> >   #include <linux/mutex.h>
> > @@ -29,6 +30,7 @@
> >   #include <linux/seq_file.h>
> >   #include <linux/string.h>
> >   #include <linux/smp.h>
> > +#include <linux/thermal.h>
> >   #include <linux/types.h>
> >   #include <linux/uaccess.h>
> > 
> > @@ -80,6 +82,11 @@ struct dell_smm_data {
> >   	int *fan_nominal_speed[DELL_SMM_NO_FANS];
> >   };
> > 
> > +struct dell_smm_cooling_data {
> > +	u8 fan_num;
> > +	struct dell_smm_data *data;
> > +};
> > +
> >   MODULE_AUTHOR("Massimo Dal Zotto (dz@debian.org)");
> >   MODULE_AUTHOR("Pali Rohár <pali@kernel.org>");
> >   MODULE_DESCRIPTION("Dell laptop SMM BIOS hwmon driver");
> > @@ -638,9 +645,50 @@ static void __init i8k_init_procfs(struct device *dev)
> > 
> >   #endif
> > 
> > -/*
> > - * Hwmon interface
> > - */
> > +static int dell_smm_get_max_state(struct thermal_cooling_device *dev, unsigned long *state)
> > +{
> > +	struct dell_smm_cooling_data *cdata = dev->devdata;
> > +
> > +	*state = cdata->data->i8k_fan_max;
> > +
> > +	return 0;
> > +}
> > +
> > +static int dell_smm_get_cur_state(struct thermal_cooling_device *dev, unsigned long *state)
> > +{
> > +	struct dell_smm_cooling_data *cdata = dev->devdata;
> > +	int ret;
> > +
> > +	ret = i8k_get_fan_status(cdata->data, cdata->fan_num);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	*state = ret;
> > +
> > +	return 0;
> > +}
> > +
> > +static int dell_smm_set_cur_state(struct thermal_cooling_device *dev, unsigned long state)
> > +{
> > +	struct dell_smm_cooling_data *cdata = dev->devdata;
> > +	struct dell_smm_data *data = cdata->data;
> > +	int ret;
> > +
> > +	if (state > data->i8k_fan_max)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&data->i8k_mutex);
> > +	ret = i8k_set_fan(data, cdata->fan_num, (int)state);
> > +	mutex_unlock(&data->i8k_mutex);
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct thermal_cooling_device_ops dell_smm_cooling_ops = {
> > +	.get_max_state = dell_smm_get_max_state,
> > +	.get_cur_state = dell_smm_get_cur_state,
> > +	.set_cur_state = dell_smm_set_cur_state,
> > +};
> > 
> >   static umode_t dell_smm_is_visible(const void *drvdata, enum hwmon_sensor_types type, u32 attr,
> >   				   int channel)
> > @@ -941,6 +989,37 @@ static const struct hwmon_chip_info dell_smm_chip_info = {
> >   	.info = dell_smm_info,
> >   };
> > 
> > +static int __init dell_smm_init_cdev(struct device *dev, u8 fan_num)
> > +{
> > +	struct dell_smm_data *data = dev_get_drvdata(dev);
> > +	struct thermal_cooling_device *cdev;
> > +	struct dell_smm_cooling_data *cdata;
> > +	int ret = 0;
> > +	char *name;
> > +
> > +	name = kasprintf(GFP_KERNEL, "dell-smm-fan%u", fan_num + 1);
> > +	if (!name)
> > +		return -ENOMEM;
> > +
> > +	cdata = devm_kmalloc(dev, sizeof(*cdata), GFP_KERNEL);
> > +	if (cdata) {
> > +		cdata->fan_num = fan_num;
> > +		cdata->data = data;
> > +		cdev = devm_thermal_of_cooling_device_register(dev, NULL, name, cdata,
> > +							       &dell_smm_cooling_ops);
> > +		if (IS_ERR(cdev)) {
> > +			devm_kfree(dev, cdata);
> > +			ret = PTR_ERR(cdev);
> > +		}
> > +	} else {
> > +		ret = -ENOMEM;
> > +	}
> > +
> > +	kfree(name);
> > +
> > +	return ret;
> > +}
> > +
> >   static int __init dell_smm_init_hwmon(struct device *dev)
> >   {
> >   	struct dell_smm_data *data = dev_get_drvdata(dev);
> > @@ -967,6 +1046,15 @@ static int __init dell_smm_init_hwmon(struct device *dev)
> >   			continue;
> > 
> >   		data->fan[i] = true;
> > +
> > +		/* the cooling device it not critical, ignore failures */
> > +		if (IS_REACHABLE(CONFIG_THERMAL)) {
> > +			err = dell_smm_init_cdev(dev, i);
> > +			if (err < 0)
> > +				dev_err(dev, "Failed to register cooling device for fan %u\n",
> > +					i + 1);
> > +		}
> > +
> >   		data->fan_nominal_speed[i] = devm_kmalloc_array(dev, data->i8k_fan_max + 1,
> >   								sizeof(*data->fan_nominal_speed[i]),
> >   								GFP_KERNEL);
> > --
> > 2.30.2
> > 
> Any thoughts on this? I tested it on a Dell Inspiron 3505, so i can prove it works.

Hello! If hwmon maintainers are happy with this approach and this new
API then I'm fine with it. Maybe one thing to discuss, should not be
dell_smm_init_cdev() fatal on error?
