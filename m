Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125874665DD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358819AbhLBO4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358809AbhLBO4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:56:08 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08297C06174A;
        Thu,  2 Dec 2021 06:52:46 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id r26so55874983oiw.5;
        Thu, 02 Dec 2021 06:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O1yOuGsFTXbs1faEo1A9T2XUWoAE+oO2kFcVDzHK3yU=;
        b=GRhiFuRF1CKCPJ4oGEKGzpAQlm/KA5ljdLE4e3ToIMJhNu4Z/A31ZiSyCXyIEYNkG8
         /P1IcW4VzxR4a4Dhpo18qRjiyozhsFg+wjdvZbqNP6G5/J3q8ZJCPSuciYG/iJTrovDY
         x9SmbdHxkHfCLgUsQsBC1dmlFY6uQ0QnPQhDBijNhWO2dvVP0vIEvzQrYa5QVVGgnVn2
         MJ9cd8hFPzU0Nd6YxooEU6dorl0vgpuOXRQocOfG+Kzl8jCgYdmwDDqKFLYUm4zmQWeG
         Ka4/oBrV1Jj5pbkwq6hDuNJ5PGscK57YqMGG0AXHKAtcq+UNomPU7uNc+6yWk9a6//RV
         NDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O1yOuGsFTXbs1faEo1A9T2XUWoAE+oO2kFcVDzHK3yU=;
        b=Yqmzt7WY+MuATSpTku5ndhiYSeMOg+ux9VB75yJO7CpNArqPpdNY+IlywWTuFOwtr2
         gLUxO1kOAb+G+RfWVtNGVhTJEalUfI1DCtFIPwzE4DmZN2Vbogoh8WPfcyOMTltIfLS1
         z/L3PInVOMF5t6v8tIUiwff4kmHKILduyvVEiQGSHLTxdiNS+C8+KiCh3W8nKYfqXIKE
         JP8QaTw0tINU8WIoh1cgKIkhWUEBXK8+X7cAN5AfaJYvI4xG+9FauknfhYTFvAkXzcNM
         EYYC16kgw/1ilrHVrKE68qlDhc/6Xi9o97T+lluCgkqVXSd/OqBsK58Hcq5VIiOe1frQ
         HEZg==
X-Gm-Message-State: AOAM53288MVDjOqtF+BrYB8zwfaEvJeK9fnmtq5sZBbqvdz0SfGxUjut
        XCOGtnWNmtKLSYelet95bzI=
X-Google-Smtp-Source: ABdhPJztPrtQr7qfRVW1pbskjk/9C3viDOlhMHWy4xRPwJHvMK6mR5RQyleiMvu3LfYx6rY9jZgt6w==
X-Received: by 2002:a05:6808:cf:: with SMTP id t15mr4541716oic.43.1638456765419;
        Thu, 02 Dec 2021 06:52:45 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n6sm16513otj.78.2021.12.02.06.52.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 06:52:44 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Alistair Francis <alistair@alistair23.me>, kernel@pengutronix.de,
        robh+dt@kernel.org, lee.jones@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, alistair23@gmail.com,
        linux-hwmon@vger.kernel.org, andreas@kemnade.info,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, amitk@kernel.org, shawnguo@kernel.org
References: <20211202120758.41478-1-alistair@alistair23.me>
 <20211202120758.41478-6-alistair@alistair23.me>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v16 5/8] hwmon: sy7636a: Add temperature driver for
 sy7636a
Message-ID: <0c4f0237-1718-0d1c-41f5-f0db9876e13d@roeck-us.net>
Date:   Thu, 2 Dec 2021 06:52:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211202120758.41478-6-alistair@alistair23.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/21 4:07 AM, Alistair Francis wrote:
> This is a multi-function device to interface with the sy7636a
> EPD PMIC chip from Silergy.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>

There are still some checkpatch warnings.

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
#49: FILE: Documentation/hwmon/sy7636a-hwmon.rst:1:
+Kernel driver sy7636a-hwmon

WARNING: braces {} are not necessary for single statement blocks
#187: FILE: drivers/hwmon/sy7636a-hwmon.c:77:
+	if (IS_ERR(regulator)) {
+		return PTR_ERR(regulator);
+	}

WARNING: braces {} are not necessary for single statement blocks
#192: FILE: drivers/hwmon/sy7636a-hwmon.c:82:
+	if (err) {
+		return err;
+	}

Please fix those as well as the trivial CHECK messages reported by
checkpatch --strict. A MAINTAINERS update isn't needed, though,
unless you want to.

Thanks,
Guenter

> ---
>   Documentation/hwmon/index.rst         |   1 +
>   Documentation/hwmon/sy7636a-hwmon.rst |  24 ++++++
>   drivers/hwmon/Kconfig                 |   9 +++
>   drivers/hwmon/Makefile                |   1 +
>   drivers/hwmon/sy7636a-hwmon.c         | 107 +++++++++++++++++++++++++
>   5 files changed, 142 insertions(+)
>   create mode 100644 Documentation/hwmon/sy7636a-hwmon.rst
>   create mode 100644 drivers/hwmon/sy7636a-hwmon.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 7046bf1870d9..a887308850cd 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -180,6 +180,7 @@ Hardware Monitoring Kernel Drivers
>      smsc47m1
>      sparx5-temp
>      stpddc60
> +   sy7636a-hwmon
>      tc654
>      tc74
>      thmc50
> diff --git a/Documentation/hwmon/sy7636a-hwmon.rst b/Documentation/hwmon/sy7636a-hwmon.rst
> new file mode 100644
> index 000000000000..6b3e36d028dd
> --- /dev/null
> +++ b/Documentation/hwmon/sy7636a-hwmon.rst
> @@ -0,0 +1,24 @@
> +Kernel driver sy7636a-hwmon
> +=========================
> +
> +Supported chips:
> +
> + * Silergy SY7636A PMIC
> +
> +
> +Description
> +-----------
> +
> +This driver adds hardware temperature reading support for
> +the Silergy SY7636A PMIC.
> +
> +The following sensors are supported
> +
> +  * Temperature
> +      - SoC on-die temperature in milli-degree C
> +
> +sysfs-Interface
> +---------------
> +
> +temp0_input
> +	- SoC on-die temperature (milli-degree C)
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 64bd3dfba2c4..3139a286c35a 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1662,6 +1662,15 @@ config SENSORS_SIS5595
>   	  This driver can also be built as a module. If so, the module
>   	  will be called sis5595.
>   
> +config SENSORS_SY7636A
> +	tristate "Silergy SY7636A"
> +	help
> +	  If you say yes here you get support for the thermistor readout of
> +	  the Silergy SY7636A PMIC.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called sy7636a-hwmon.
> +
>   config SENSORS_DME1737
>   	tristate "SMSC DME1737, SCH311x and compatibles"
>   	depends on I2C && !PPC
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index baee6a8d4dd1..8f8da52098d1 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -182,6 +182,7 @@ obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
>   obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc47m192.o
>   obj-$(CONFIG_SENSORS_SPARX5)	+= sparx5-temp.o
>   obj-$(CONFIG_SENSORS_STTS751)	+= stts751.o
> +obj-$(CONFIG_SENSORS_SY7636A)	+= sy7636a-hwmon.o
>   obj-$(CONFIG_SENSORS_AMC6821)	+= amc6821.o
>   obj-$(CONFIG_SENSORS_TC74)	+= tc74.o
>   obj-$(CONFIG_SENSORS_THMC50)	+= thmc50.o
> diff --git a/drivers/hwmon/sy7636a-hwmon.c b/drivers/hwmon/sy7636a-hwmon.c
> new file mode 100644
> index 000000000000..3cc3afcdfb2d
> --- /dev/null
> +++ b/drivers/hwmon/sy7636a-hwmon.c
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Functions to access SY3686A power management chip temperature
> + *
> + * Copyright (C) 2021 reMarkable AS - http://www.remarkable.com/
> + *
> + * Authors: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>
> + *          Alistair Francis <alistair@alistair23.me>
> + */
> +
> +#include <linux/err.h>
> +#include <linux/hwmon.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/machine.h>
> +
> +#include <linux/mfd/sy7636a.h>
> +
> +static int sy7636a_read(struct device *dev, enum hwmon_sensor_types type,
> +			 u32 attr, int channel, long *temp)
> +{
> +	struct regmap *regmap = dev_get_drvdata(dev);
> +	int ret, reg_val;
> +
> +	ret = regmap_read(regmap,
> +			SY7636A_REG_TERMISTOR_READOUT, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	*temp = reg_val * 1000;
> +
> +	return 0;
> +}
> +
> +static umode_t sy7636a_is_visible(const void *data,
> +				   enum hwmon_sensor_types type,
> +				   u32 attr, int channel)
> +{
> +	if (type != hwmon_temp)
> +		return 0;
> +
> +	if (attr != hwmon_temp_input)
> +		return 0;
> +
> +	return 0444;
> +}
> +
> +static const struct hwmon_ops sy7636a_hwmon_ops = {
> +	.is_visible = sy7636a_is_visible,
> +	.read = sy7636a_read,
> +};
> +
> +static const struct hwmon_channel_info *sy7636a_info[] = {
> +	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
> +	NULL
> +};
> +
> +static const struct hwmon_chip_info sy7636a_chip_info = {
> +	.ops = &sy7636a_hwmon_ops,
> +	.info = sy7636a_info,
> +};
> +
> +static int sy7636a_sensor_probe(struct platform_device *pdev)
> +{
> +	struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	struct regulator *regulator;
> +	struct device *hwmon_dev;
> +	int err;
> +
> +	if (!regmap)
> +		return -EPROBE_DEFER;
> +
> +	regulator = devm_regulator_get(&pdev->dev, "vcom");
> +	if (IS_ERR(regulator)) {
> +		return PTR_ERR(regulator);
> +	}
> +
> +	err = regulator_enable(regulator);
> +	if (err) {
> +		return err;
> +	}
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
> +			"sy7636a_temperature", regmap, &sy7636a_chip_info, NULL);
> +
> +	if (IS_ERR(hwmon_dev)) {
> +		err = PTR_ERR(hwmon_dev);
> +		dev_err(&pdev->dev, "Unable to register hwmon device, returned %d\n", err);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct platform_driver sy7636a_sensor_driver = {
> +	.probe = sy7636a_sensor_probe,
> +	.driver = {
> +		.name = "sy7636a-temperature",
> +	},
> +};
> +module_platform_driver(sy7636a_sensor_driver);
> +
> +MODULE_DESCRIPTION("SY7636A sensor driver");
> +MODULE_LICENSE("GPL");
> 

