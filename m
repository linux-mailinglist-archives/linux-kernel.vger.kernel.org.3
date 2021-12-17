Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA9347905C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238198AbhLQPwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbhLQPwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:52:09 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B3BC061574;
        Fri, 17 Dec 2021 07:52:09 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id bj13so4210379oib.4;
        Fri, 17 Dec 2021 07:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z4JrwF2xU22Uzz66iy0H6PetLBdZQCl51fyniEPGDTU=;
        b=FOQwQ4Cb/Y+mtiOCvxyKm+1FkUwJO211cXeTU9EvOeoo1qFsIfvGasdBXIMzlsQlS8
         DY0MHNfvQ+ohN/QFT27pfOzXCItGqU0HdSbZMftVHXMDiRfXAGj8V6JvEBnTnZctKR+c
         I9Jtsbmr96SzqkB+L8Ud6uARmrN/1sx4N8fx+m4f+lPQPoZz/Oe/psBQz4CLodu00Mn9
         JO1cfV61k9J7PGDkCXrYFyFgTvKprX+r1IVY48GLw8s/e9cgqc5bOoc6F19GVVcTvIwW
         RgOdRp3dX+/nnM/Tr/vFkZnU2Wh/gueQClVT3mbSIpUnPyf4eDurS70AgE82wOz0P189
         +atQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Z4JrwF2xU22Uzz66iy0H6PetLBdZQCl51fyniEPGDTU=;
        b=XxKxeU5ck/dzuX1arihMb4xM34wZpX5ii0QAhuKdKTPVPAxFeGnXGmeUlPH57ZdOkD
         1ugR/14jX2yb+PCX01+J36l9rImXegfE8pIE0C+sC2mKlkpkSxpj+UbheIBtQ9tTQYlE
         TcD56P/c/gsK44+Hlvf0Fa9ytJt51SnZrlog01yI7QPYeACOJ0i/+virR23iDtKz6h97
         teSVEFIxt0qn53wfs9nnvVnSfVfCMBpA0ircBKqpFNEpMHw3OVzsBXmoRopqsfVjxJPy
         XNTwMc9p5TPmxEtKjBu23i58JiOizJfkNKEgkdC2Pbj8EiS0z+4054oBRxqQLuk2QA+R
         UZUQ==
X-Gm-Message-State: AOAM533oV/GBgKMeM7asmHPw7+D363eVsTdsn7OkJt7nih2/lMvgt5qf
        CCyzKKF67OCZI7+K2gzZLKo=
X-Google-Smtp-Source: ABdhPJz5Tja12w0YuAoSZ8h2ThpAxNu/4RHvrGoSoKYN4mnEX5ME52DOUkguj/40/oV4IHHwWdHt9w==
X-Received: by 2002:aca:2207:: with SMTP id b7mr8632481oic.24.1639756328485;
        Fri, 17 Dec 2021 07:52:08 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id be12sm1828265oib.50.2021.12.17.07.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 07:52:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 17 Dec 2021 07:52:06 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Howard.Chiu@quantatw.com
Cc:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Potin.Lai@quantatw.com
Subject: Re: [PATCH v3] hwmon: (pmbus) Add support for MPS Multi-phase mp5023
Message-ID: <20211217155206.GA3015782@roeck-us.net>
References: <HKAPR04MB400349AA406694FB976D78D096709@HKAPR04MB4003.apcprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HKAPR04MB400349AA406694FB976D78D096709@HKAPR04MB4003.apcprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 04:48:54AM +0000, Howard.Chiu@quantatw.com wrote:
> Add support for mp5023 device from Monolithic Power Systems, Inc. (MPS)
> vendor. This is a Hot-Swap Controller.
> 
> Signed-off-by: Howard Chiu <howard.chiu@quantatw.com>

Applied.

Thanks,
Guenter

> ---
> Change since v2:
> - Fixed patch content overwritten by mail server
> 
> Change since v1:
> - mp5023.c
>   - Sort headers
> - mp5023.rst
>   - Add datasheet information
>   - Correct sentences
> 
>  Documentation/hwmon/mp5023.rst | 84 ++++++++++++++++++++++++++++++++++
>  drivers/hwmon/pmbus/Kconfig    |  9 ++++
>  drivers/hwmon/pmbus/Makefile   |  1 +
>  drivers/hwmon/pmbus/mp5023.c   | 66 ++++++++++++++++++++++++++
>  4 files changed, 160 insertions(+)
>  create mode 100644 Documentation/hwmon/mp5023.rst
>  create mode 100644 drivers/hwmon/pmbus/mp5023.c
> 
> diff --git a/Documentation/hwmon/mp5023.rst b/Documentation/hwmon/mp5023.rst
> new file mode 100644
> index 000000000000..af5ab1345a91
> --- /dev/null
> +++ b/Documentation/hwmon/mp5023.rst
> @@ -0,0 +1,84 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Kernel driver mp5023
> +====================
> +
> +Supported chips:
> +
> +  * MPS MP5023
> +
> +    Prefix: 'mp5023'
> +
> +  * Datasheet
> +
> +    Publicly available at the MPS website : https://www.monolithicpower.com/en/mp5023.html
> +
> +Author:
> +
> +	Howard Chiu <howard.chiu@quantatw.com>
> +
> +Description
> +-----------
> +
> +This driver implements support for Monolithic Power Systems, Inc. (MPS)
> +MP5023 Hot-Swap Controller.
> +
> +Device complaint with:
> +
> +- PMBus rev 1.3 interface.
> +
> +Device supports direct format for reading input voltage, output voltage,
> +output current, input power and temperature.
> +
> +The driver exports the following attributes via the 'sysfs' files
> +for input voltage:
> +
> +**in1_input**
> +
> +**in1_label**
> +
> +**in1_max**
> +
> +**in1_max_alarm**
> +
> +**in1_min**
> +
> +**in1_min_alarm**
> +
> +The driver provides the following attributes for output voltage:
> +
> +**in2_input**
> +
> +**in2_label**
> +
> +**in2_alarm**
> +
> +The driver provides the following attributes for output current:
> +
> +**curr1_input**
> +
> +**curr1_label**
> +
> +**curr1_alarm**
> +
> +**curr1_max**
> +
> +The driver provides the following attributes for input power:
> +
> +**power1_input**
> +
> +**power1_label**
> +
> +**power1_alarm**
> +
> +The driver provides the following attributes for temperature:
> +
> +**temp1_input**
> +
> +**temp1_max**
> +
> +**temp1_max_alarm**
> +
> +**temp1_crit**
> +
> +**temp1_crit_alarm**
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index ffb609cee3a4..b56bd8542864 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -276,6 +276,15 @@ config SENSORS_MP2975
>  	  This driver can also be built as a module. If so, the module will
>  	  be called mp2975.
>  
> +config SENSORS_MP5023
> +	tristate "MPS MP5023"
> +	help
> +	  If you say yes here you get hardware monitoring support for MPS
> +	  MP5023.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called mp5023.
> +
>  config SENSORS_PIM4328
>  	tristate "Flex PIM4328 and compatibles"
>  	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 0ed4d596a948..61cdc24b1309 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -31,6 +31,7 @@ obj-$(CONFIG_SENSORS_MAX34440)	+= max34440.o
>  obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
>  obj-$(CONFIG_SENSORS_MP2888)	+= mp2888.o
>  obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
> +obj-$(CONFIG_SENSORS_MP5023)	+= mp5023.o
>  obj-$(CONFIG_SENSORS_PM6764TR)	+= pm6764tr.o
>  obj-$(CONFIG_SENSORS_PXE1610)	+= pxe1610.o
>  obj-$(CONFIG_SENSORS_Q54SJ108A2)	+= q54sj108a2.o
> diff --git a/drivers/hwmon/pmbus/mp5023.c b/drivers/hwmon/pmbus/mp5023.c
> new file mode 100644
> index 000000000000..14d3934aa099
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/mp5023.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Driver for MPS MP5023 Hot-Swap Controller
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include "pmbus.h"
> +
> +static struct pmbus_driver_info mp5023_info = {
> +	.pages = 1,
> +
> +	.format[PSC_VOLTAGE_IN] = direct,
> +	.format[PSC_VOLTAGE_OUT] = direct,
> +	.format[PSC_CURRENT_OUT] = direct,
> +	.format[PSC_POWER] = direct,
> +	.format[PSC_TEMPERATURE] = direct,
> +
> +	.m[PSC_VOLTAGE_IN] = 32,
> +	.b[PSC_VOLTAGE_IN] = 0,
> +	.R[PSC_VOLTAGE_IN] = 0,
> +	.m[PSC_VOLTAGE_OUT] = 32,
> +	.b[PSC_VOLTAGE_OUT] = 0,
> +	.R[PSC_VOLTAGE_OUT] = 0,
> +	.m[PSC_CURRENT_OUT] = 16,
> +	.b[PSC_CURRENT_OUT] = 0,
> +	.R[PSC_CURRENT_OUT] = 0,
> +	.m[PSC_POWER] = 1,
> +	.b[PSC_POWER] = 0,
> +	.R[PSC_POWER] = 0,
> +	.m[PSC_TEMPERATURE] = 2,
> +	.b[PSC_TEMPERATURE] = 0,
> +	.R[PSC_TEMPERATURE] = 0,
> +
> +	.func[0] =
> +		PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_PIN |
> +		PMBUS_HAVE_TEMP | PMBUS_HAVE_IOUT |
> +		PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP,
> +};
> +
> +static int mp5023_probe(struct i2c_client *client)
> +{
> +	return pmbus_do_probe(client, &mp5023_info);
> +}
> +
> +static const struct of_device_id __maybe_unused mp5023_of_match[] = {
> +	{ .compatible = "mps,mp5023", },
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(of, mp5023_of_match);
> +
> +static struct i2c_driver mp5023_driver = {
> +	.driver = {
> +		   .name = "mp5023",
> +		   .of_match_table = of_match_ptr(mp5023_of_match),
> +	},
> +	.probe_new = mp5023_probe,
> +};
> +
> +module_i2c_driver(mp5023_driver);
> +
> +MODULE_AUTHOR("Howard Chiu <howard.chiu@quantatw.com>");
> +MODULE_DESCRIPTION("PMBus driver for MPS MP5023 HSC");
> +MODULE_LICENSE("GPL");
