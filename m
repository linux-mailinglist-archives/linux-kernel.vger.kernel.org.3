Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B144FA94C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 17:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242500AbiDIPiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 11:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiDIPiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 11:38:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0732BE0;
        Sat,  9 Apr 2022 08:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649518569;
        bh=AWSiqye97mYi6sUv586l1tMN+wWRer2Pgc3D/ECWV6A=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=Eeh84ME6jM7D95V5ZZUEj835vUcTsY/bM9q/AVBieGrzPleYdntWLNV0vNEHwgq4j
         vMipLJDkH+/o43ENhD4aiakBwFS6a2CuIefP6Q+O7n8vdYcAAXd5g6NsE0PL99N5MC
         n6ZPNDE0R7iN/YjDaWyWbNQ37ocHMDOH5P75QfC0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6KUT-1o13T73QJF-016j0D; Sat, 09
 Apr 2022 17:36:08 +0200
Subject: Re: [PATCH] hwmon: (dell-smm) Add cooling device support
From:   Armin Wolf <W_Armin@gmx.de>
To:     linux-hwmon@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220330163324.572437-1-W_Armin@gmx.de>
Message-ID: <19965146-a004-aae5-4448-ec573b227edc@gmx.de>
Date:   Sat, 9 Apr 2022 17:36:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220330163324.572437-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:eoIM1SRVBeOvvNBAfc8YeoLXKzA/kU9creonpmTXgNHGjcXQXim
 ajVWENly9K27ojxeooRHG+QZqY1N15oyg1/As7bF7eYyqkBRnuZDvepnn7oqn6+hjzp8h8J
 otcaJrIcSDVXnlqazIHd8lVOQSS/BvuGzH72xqyUq2uhzB2bOgrE7xTV0ZRqCCF+8Z8z3gi
 60X/L10EHsJ3IADQtj8LA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S3Ngp4lbYw0=:m0mCMYTJgwLInxaaHQ4AXr
 /zcg5sSIYt+tu3Wr/ruWKr0d7O2koKnp6x9N4FYVzfBhBkQ8q8pt3Rfnlc4Nv5nshYadKi9dx
 d9EmlrBtqvm9vzwcoUIYwdE5ejj2fWggTflznrO8YKV7ntdcZQJRKH96ZltuXiacQZt+oN02H
 a8ZU2XUDXG4iWIaIXfxo3V4/WOGoG8IvlI1e4ioIRyFp7NB8ZfspnGZULGH6lfYCavnIrDe7t
 C8l5+N4Cz3i0z9Yhpq2fbVkhuNyY95O4R+ebWNgkWNJ/RhSn4fWH43YSVw8lzCeb3xY4iEm1L
 dGiG1gxpmBhpP5v6ZPt+yUCIdEztTIBvcGj63a38BZN0nj92GVfejpWhOct884v8c/k3Ko6wr
 7GXmERuGhF8S2xB11Q2Ca+eXo9ZbVc1Z2hFES7WZKwJKi7OZWMkJbaSBcd9+6RCmjdhHMVpjj
 TtXGacxvjtPnPRcUPVmfkiM7Wnpop+s6898NZT/hxuR2c51PgEx+vnpZSgRVTQBaipsMf1w+g
 1yafGoOc9SiHcBIEutH7Ng55avvTsmXl6oq95NFj1ny+LoG/oM+5wz50hNYtG53jtuc95LoqQ
 89bXAqD2uLED/Qc2qHG05HmheJZ5PAU7GyQiqu0zelo2Z2F0uT8nbRdV2VSJWQyhS6cpJ9KDW
 8N1LA3l0zlLELc9Chs9bVHM9yiCeoFzKqjttwqrl4Bpu+lY3m5cQfaDhz1BVS87dKztSF4+1Q
 1INaI5QyXoWdO3poYs+QgRtzHmRyOj33uu3b1TpUO79SmTcY9gLm8GYQyqWrDjV0AhgKG4VYp
 3/RdJ/fiCw/xjJZHhu0PPliokLdjyMQ5WOwoyfm66mA2idXIoYleBJKXx7E+g0k26V8TgwteY
 NjD5NLvKxe3/MAE4GaxNZ05qwknWJ+STBeZmwCQupv5HNpwawyLvxUp+AVuEavwgIyiOyjERI
 liYau8nPqPy/BREXM45AoNBfrv7zg8cFzMp3ue3JvBOmpORWPQs8TG5HxqgzaS4dqbTb3sYYM
 a5TRdRam3iTQtpZFftHr1Glqd49PrkcSBY/iqcRDTmdup1LIrMZUF9zr0tHwc0sZuqoOdOA1o
 +Mdj88AYbsvKiU=
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 30.03.22 um 18:33 schrieb Armin Wolf:

> Until now, only the temperature sensors where exported thru
> the thermal subsystem. Export the fans as "dell-smm-fan[1-3]" too
> to make them available as cooling devices.
> Also update Documentation.
>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>   Documentation/hwmon/dell-smm-hwmon.rst |  7 ++
>   drivers/hwmon/Kconfig                  |  1 +
>   drivers/hwmon/dell-smm-hwmon.c         | 94 +++++++++++++++++++++++++-
>   3 files changed, 99 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation/hwmo=
n/dell-smm-hwmon.rst
> index d3323a96665d..41839b7de2c1 100644
> --- a/Documentation/hwmon/dell-smm-hwmon.rst
> +++ b/Documentation/hwmon/dell-smm-hwmon.rst
> @@ -86,6 +86,13 @@ probe the BIOS on your machine and discover the appro=
priate codes.
>
>   Again, when you find new codes, we'd be happy to have your patches!
>
> +``thermal`` interface
> +---------------------------
> +
> +The driver also exports the fans as thermal cooling devices with
> +``type`` set to ``dell-smm-fan[1-3]``. This allows for easy fan control
> +using one of the thermal governors.
> +
>   Module parameters
>   -----------------
>
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 9ab4e9b3d27b..1175b8e38c45 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -498,6 +498,7 @@ config SENSORS_DS1621
>   config SENSORS_DELL_SMM
>   	tristate "Dell laptop SMM BIOS hwmon driver"
>   	depends on X86
> +	imply THERMAL
>   	help
>   	  This hwmon driver adds support for reporting temperature of differe=
nt
>   	  sensors and controls the fans on Dell laptops via System Management
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwm=
on.c
> index 84cb1ede7bc0..0c29386f4bd3 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -21,6 +21,7 @@
>   #include <linux/errno.h>
>   #include <linux/hwmon.h>
>   #include <linux/init.h>
> +#include <linux/kconfig.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/mutex.h>
> @@ -29,6 +30,7 @@
>   #include <linux/seq_file.h>
>   #include <linux/string.h>
>   #include <linux/smp.h>
> +#include <linux/thermal.h>
>   #include <linux/types.h>
>   #include <linux/uaccess.h>
>
> @@ -80,6 +82,11 @@ struct dell_smm_data {
>   	int *fan_nominal_speed[DELL_SMM_NO_FANS];
>   };
>
> +struct dell_smm_cooling_data {
> +	u8 fan_num;
> +	struct dell_smm_data *data;
> +};
> +
>   MODULE_AUTHOR("Massimo Dal Zotto (dz@debian.org)");
>   MODULE_AUTHOR("Pali Roh=C3=A1r <pali@kernel.org>");
>   MODULE_DESCRIPTION("Dell laptop SMM BIOS hwmon driver");
> @@ -638,9 +645,50 @@ static void __init i8k_init_procfs(struct device *d=
ev)
>
>   #endif
>
> -/*
> - * Hwmon interface
> - */
> +static int dell_smm_get_max_state(struct thermal_cooling_device *dev, u=
nsigned long *state)
> +{
> +	struct dell_smm_cooling_data *cdata =3D dev->devdata;
> +
> +	*state =3D cdata->data->i8k_fan_max;
> +
> +	return 0;
> +}
> +
> +static int dell_smm_get_cur_state(struct thermal_cooling_device *dev, u=
nsigned long *state)
> +{
> +	struct dell_smm_cooling_data *cdata =3D dev->devdata;
> +	int ret;
> +
> +	ret =3D i8k_get_fan_status(cdata->data, cdata->fan_num);
> +	if (ret < 0)
> +		return ret;
> +
> +	*state =3D ret;
> +
> +	return 0;
> +}
> +
> +static int dell_smm_set_cur_state(struct thermal_cooling_device *dev, u=
nsigned long state)
> +{
> +	struct dell_smm_cooling_data *cdata =3D dev->devdata;
> +	struct dell_smm_data *data =3D cdata->data;
> +	int ret;
> +
> +	if (state > data->i8k_fan_max)
> +		return -EINVAL;
> +
> +	mutex_lock(&data->i8k_mutex);
> +	ret =3D i8k_set_fan(data, cdata->fan_num, (int)state);
> +	mutex_unlock(&data->i8k_mutex);
> +
> +	return ret;
> +}
> +
> +static const struct thermal_cooling_device_ops dell_smm_cooling_ops =3D=
 {
> +	.get_max_state =3D dell_smm_get_max_state,
> +	.get_cur_state =3D dell_smm_get_cur_state,
> +	.set_cur_state =3D dell_smm_set_cur_state,
> +};
>
>   static umode_t dell_smm_is_visible(const void *drvdata, enum hwmon_sen=
sor_types type, u32 attr,
>   				   int channel)
> @@ -941,6 +989,37 @@ static const struct hwmon_chip_info dell_smm_chip_i=
nfo =3D {
>   	.info =3D dell_smm_info,
>   };
>
> +static int __init dell_smm_init_cdev(struct device *dev, u8 fan_num)
> +{
> +	struct dell_smm_data *data =3D dev_get_drvdata(dev);
> +	struct thermal_cooling_device *cdev;
> +	struct dell_smm_cooling_data *cdata;
> +	int ret =3D 0;
> +	char *name;
> +
> +	name =3D kasprintf(GFP_KERNEL, "dell-smm-fan%u", fan_num + 1);
> +	if (!name)
> +		return -ENOMEM;
> +
> +	cdata =3D devm_kmalloc(dev, sizeof(*cdata), GFP_KERNEL);
> +	if (cdata) {
> +		cdata->fan_num =3D fan_num;
> +		cdata->data =3D data;
> +		cdev =3D devm_thermal_of_cooling_device_register(dev, NULL, name, cda=
ta,
> +							       &dell_smm_cooling_ops);
> +		if (IS_ERR(cdev)) {
> +			devm_kfree(dev, cdata);
> +			ret =3D PTR_ERR(cdev);
> +		}
> +	} else {
> +		ret =3D -ENOMEM;
> +	}
> +
> +	kfree(name);
> +
> +	return ret;
> +}
> +
>   static int __init dell_smm_init_hwmon(struct device *dev)
>   {
>   	struct dell_smm_data *data =3D dev_get_drvdata(dev);
> @@ -967,6 +1046,15 @@ static int __init dell_smm_init_hwmon(struct devic=
e *dev)
>   			continue;
>
>   		data->fan[i] =3D true;
> +
> +		/* the cooling device it not critical, ignore failures */
> +		if (IS_REACHABLE(CONFIG_THERMAL)) {
> +			err =3D dell_smm_init_cdev(dev, i);
> +			if (err < 0)
> +				dev_err(dev, "Failed to register cooling device for fan %u\n",
> +					i + 1);
> +		}
> +
>   		data->fan_nominal_speed[i] =3D devm_kmalloc_array(dev, data->i8k_fan=
_max + 1,
>   								sizeof(*data->fan_nominal_speed[i]),
>   								GFP_KERNEL);
> --
> 2.30.2
>
Any thoughts on this? I tested it on a Dell Inspiron 3505, so i can prove =
it works.

