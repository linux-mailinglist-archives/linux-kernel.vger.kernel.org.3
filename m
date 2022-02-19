Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50D14BC8ED
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 15:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242445AbiBSOle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 09:41:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiBSOlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 09:41:32 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DCE8596F;
        Sat, 19 Feb 2022 06:41:13 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id d3so20688949qvb.5;
        Sat, 19 Feb 2022 06:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5bz0LEo19SZXRNa76wKrJGBhLunyT/UmOk31bN05egs=;
        b=VeylZOciVKjW9YMIn2HwYTghcEMmXNuQg6S3laV7RjTtMa6ssZ0A5r+L5Sx1qGKPFz
         KrM4oMjpWho34Z6QKk54xuc0Yki4zrRA/+XBQ3op3PPDdflguGZCxbWulz13MMO99qET
         e2IjE2qSlMv9dHhtBDWyU2cgo01Qe2Gmuo/KETtB9flw+h3GjMDX9IxSQWE0bLJ3Ik5Y
         HrP+w5AcTm6Yo7YT28udh2ExWjp8tf+UZYrLVaEL0Oj7F6uE+5UbqnireJKlq7LQI/C/
         JrAXbDcyxgNc/zO1CVlacKK46ALZg9G4aCAA7seuSap+j45gP6otwCXE6/i+aNoT8QR4
         a2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=5bz0LEo19SZXRNa76wKrJGBhLunyT/UmOk31bN05egs=;
        b=CB4oKFh+Ob1cJoLxBWnj4xVu8BWXAyaRWXq5EuiYrYRzdpC1BbThOmfdB9KiiXUCJ1
         XTvRm82ng4xquDIyDuuraUi4eJF2vn73AcbUpiD908M7OETJtQhMQegxsNVyP0aLxlmX
         Pzfi9cAuMat48jrFiscF4O43JEWZExVKkaX7Dn2K86CXyt8cXJ9aTJjwfpEUqT2yYbol
         3xHepw5isZGqs7aRfuLtepdlvBo8fwvRe5bMUrm9XCbq0JlflMaBy/5h88ut6QWnuoCE
         mERFd0gRHOlCF9+u2pLnjgXxR23lzuZvNp7UpzbxdvKH5e7skra5KtNZald63zk32B5q
         1X0g==
X-Gm-Message-State: AOAM533U0l8JyaRimIShBkyLjnEBrN0cXEGLcVqV2FQ1zbT9dY3Rg114
        8rW9NKPEqgZXRhk/ceeM1WA=
X-Google-Smtp-Source: ABdhPJwBHHVpn5fbrV8gyxn6Hgckf+Jc7snlM6izgEpKKlrEqwJv3mrqsFDj5aCPa+LApvYel56HlA==
X-Received: by 2002:ac8:5b8f:0:b0:2dd:53e9:9e36 with SMTP id a15-20020ac85b8f000000b002dd53e99e36mr10307381qta.561.1645281672267;
        Sat, 19 Feb 2022 06:41:12 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j11sm27587350qtj.74.2022.02.19.06.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 06:41:11 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 19 Feb 2022 06:41:10 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Marcello Sylvester Bauer <sylv@sylv.io>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 3/4] pmbus: Add support for pli1209bc
Message-ID: <20220219144110.GA1032070@roeck-us.net>
References: <cover.1644874828.git.sylv@sylv.io>
 <8d44098e7b8ca5d4c13733267836d5a147539277.1644874828.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d44098e7b8ca5d4c13733267836d5a147539277.1644874828.git.sylv@sylv.io>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 10:44:55PM +0100, Marcello Sylvester Bauer wrote:
> PLI1209BC is a Digital Supervisor from Vicor Corporation.
> 
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>

checkpatch says:

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
#82: FILE: Documentation/hwmon/pli1209bc.rst:1:
+Kernel driver pli1209bc

I can not accept the patch without license identifier.

> ---
>  Documentation/hwmon/pli1209bc.rst |  73 +++++++++++++++++++

This needs to be added to Documentation/hwmon/index.rst.

>  drivers/hwmon/pmbus/Kconfig       |   9 +++
>  drivers/hwmon/pmbus/Makefile      |   1 +
>  drivers/hwmon/pmbus/pli1209bc.c   | 115 ++++++++++++++++++++++++++++++
>  4 files changed, 198 insertions(+)
>  create mode 100644 Documentation/hwmon/pli1209bc.rst
>  create mode 100644 drivers/hwmon/pmbus/pli1209bc.c
> 
> diff --git a/Documentation/hwmon/pli1209bc.rst b/Documentation/hwmon/pli1209bc.rst
> new file mode 100644
> index 000000000000..a3f686d03cf2
> --- /dev/null
> +++ b/Documentation/hwmon/pli1209bc.rst
> @@ -0,0 +1,73 @@
> +Kernel driver pli1209bc
> +=======================
> +
> +Supported chips:
> +
> +  * Digital Supervisor PLI1209BC
> +
> +    Prefix: 'pli1209bc'
> +
> +    Addresses scanned: 0x50 - 0x5F
> +
> +    Datasheet: https://www.vicorpower.com/documents/datasheets/ds-PLI1209BCxyzz-VICOR.pdf
> +
> +Authors:
> +    - Marcello Sylvester Bauer <sylv@sylv.io>
> +
> +Description
> +-----------
> +
> +The Vicor PLI1209BC is an isolated digital power system supervisor thatprovides

that provides

> +a communication interface between a host processor and one Bus Converter Module
> +(BCM). The PLI communicates with a system controller via a PMBus compatible
> +interface over an isolated UART interface. Through the PLI, the host processor
> +can configure, set protection limits, and monitor the BCM.
> +
> +Sysfs entries
> +-------------
> +
> +======================= ========================================================
> +in1_label		"vin2"
> +in1_input		Input voltage.
> +in1_rated_min		Minimum rated input voltage.
> +in1_rated_max		Maximum rated input voltage.
> +in1_max			Maximum input voltage.
> +in1_max_alarm		Input voltage high alarm.
> +in1_crit		Critical input voltage.
> +in1_crit_alarm		Input voltage critical alarm.
> +
> +in2_label		"vout2"
> +in2_input		Output voltage.
> +in2_rated_min		Minimum rated output voltage.
> +in2_rated_max		Maximum rated output voltage.
> +in2_alarm		Output voltage alarm
> +
> +curr1_label		"iin2"
> +curr1_input		Input current.
> +curr1_max		Maximum input current.
> +curr1_max_alarm		Maximum input current high alarm.
> +curr1_crit		Critical input current.
> +curr1_crit_alarm	Input current critical alarm.
> +
> +curr2_label		"iout2"
> +curr2_input		Output current.
> +curr2_crit		Critical output current.
> +curr2_crit_alarm	Output current critical alarm.
> +curr2_max		Maximum output current.
> +curr2_max_alarm		Output current high alarm.
> +
> +power1_label		"pin2"
> +power1_input		Input power.
> +power1_alarm		Input power alarm.
> +
> +power2_label		"pout2"
> +power2_input		Output power.
> +power2_rated_max	Maximum rated output power.
> +
> +temp1_input		Die temperature.
> +temp1_alarm		Die temperature alarm.
> +temp1_max		Maximum die temperature.
> +temp1_max_alarm		Die temperature high alarm.
> +temp1_crit		Critical die temperature.
> +temp1_crit_alarm	Die temperature critical alarm.
> +======================= ========================================================
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index c96f7b7338bd..831db423bea0 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -310,6 +310,15 @@ config SENSORS_PIM4328
>  	  This driver can also be built as a module. If so, the module will
>  	  be called pim4328.
>  
> +config SENSORS_PLI1209BC
> +	tristate "Vicor PLI1209BC"
> +	help
> +	  If you say yes here you get hardware monitoring support for Vicor
> +	  PLI1209BC Digital Supervisor.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called pli1209bc.
> +
>  config SENSORS_PM6764TR
>  	tristate "ST PM6764TR"
>  	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index e5935f70c9e0..7ce74e3b8552 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_SENSORS_MP2888)	+= mp2888.o
>  obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
>  obj-$(CONFIG_SENSORS_MP5023)	+= mp5023.o
>  obj-$(CONFIG_SENSORS_PM6764TR)	+= pm6764tr.o
> +obj-$(CONFIG_SENSORS_PLI1209BC)	+= pli1209bc.o

Alphabetic order please.

>  obj-$(CONFIG_SENSORS_PXE1610)	+= pxe1610.o
>  obj-$(CONFIG_SENSORS_Q54SJ108A2)	+= q54sj108a2.o
>  obj-$(CONFIG_SENSORS_STPDDC60)	+= stpddc60.o
> diff --git a/drivers/hwmon/pmbus/pli1209bc.c b/drivers/hwmon/pmbus/pli1209bc.c
> new file mode 100644
> index 000000000000..5f8847307e55
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/pli1209bc.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Hardware monitoring driver for Vicor PLI1209BC Digital Supervisor
> + *
> + * Copyright (c) 2022 9elements GmbH
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/pmbus.h>
> +#include "pmbus.h"
> +
> +/*
> + * The capability command is only supported at page 0. Probing the device while
> + * the page register is set to 1 will falsely enable PEC support. Disable
> + * capability probing accordingly, since the PLI1209BC does not have any
> + * additional capabilities.
> + */
> +static struct pmbus_platform_data pli1209bc_plat_data = {
> +	.flags = PMBUS_NO_CAPABILITY,
> +};
> +
> +static int pli1209bc_read_word_data(struct i2c_client *client, int page,
> +				    int phase, int reg)
> +{
> +	int data;
> +
> +	switch (reg) {
> +	/* PMBUS_READ_POUT uses a direct format with R=0 */
> +	case PMBUS_READ_POUT:
> +		data = pmbus_read_word_data(client, page, phase, reg);
> +		if (data < 0)
> +			return data;
> +		data = sign_extend32(data, 15) * 10;
> +		return clamp_val(data, -32768, 32767) & 0xffff;
> +	default:
> +		return -ENODATA;
> +	}
> +}
> +
> +static struct pmbus_driver_info pli1209bc_info = {
> +	.pages = 2,
> +	.format[PSC_VOLTAGE_IN] = direct,
> +	.format[PSC_VOLTAGE_OUT] = direct,
> +	.format[PSC_CURRENT_IN] = direct,
> +	.format[PSC_CURRENT_OUT] = direct,
> +	.format[PSC_POWER] = direct,
> +	.format[PSC_TEMPERATURE] = direct,
> +	.m[PSC_VOLTAGE_IN] = 1,
> +	.b[PSC_VOLTAGE_IN] = 0,
> +	.R[PSC_VOLTAGE_IN] = 1,
> +	.m[PSC_VOLTAGE_OUT] = 1,
> +	.b[PSC_VOLTAGE_OUT] = 0,
> +	.R[PSC_VOLTAGE_OUT] = 1,
> +	.m[PSC_CURRENT_IN] = 1,
> +	.b[PSC_CURRENT_IN] = 0,
> +	.R[PSC_CURRENT_IN] = 3,
> +	.m[PSC_CURRENT_OUT] = 1,
> +	.b[PSC_CURRENT_OUT] = 0,
> +	.R[PSC_CURRENT_OUT] = 2,
> +	.m[PSC_POWER] = 1,
> +	.b[PSC_POWER] = 0,
> +	.R[PSC_POWER] = 1,
> +	.m[PSC_TEMPERATURE] = 1,
> +	.b[PSC_TEMPERATURE] = 0,
> +	.R[PSC_TEMPERATURE] = 0,
> +	/*
> +	 * Page 0 sums up all attributes except voltage readings.
> +	 * The pli1209 digital supervisor only contains a single BCM, making
> +	 * page 0 redundant.
> +	 */
> +	.func[1] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT
> +	    | PMBUS_HAVE_IIN | PMBUS_HAVE_IOUT
> +	    | PMBUS_HAVE_PIN | PMBUS_HAVE_POUT
> +	    | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP
> +	    | PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_INPUT,
> +	.read_word_data = pli1209bc_read_word_data,
> +};
> +
> +static int pli1209bc_probe(struct i2c_client *client)
> +{
> +	client->dev.platform_data = &pli1209bc_plat_data;
> +	return pmbus_do_probe(client, &pli1209bc_info);
> +}
> +
> +static const struct i2c_device_id pli1209bc_id[] = {
> +	{"pli1209bc", 0},
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, pli1209bc_id);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id pli1209bc_of_match[] = {
> +	{ .compatible = "vicor,pli1209bc" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, pli1209bc_of_match);
> +#endif
> +
> +static struct i2c_driver pli1209bc_driver = {
> +	.driver = {
> +		   .name = "pli1209bc",
> +		   .of_match_table = of_match_ptr(pli1209bc_of_match),
> +		   },
> +	.probe_new = pli1209bc_probe,
> +	.id_table = pli1209bc_id,
> +};
> +
> +module_i2c_driver(pli1209bc_driver);
> +
> +MODULE_AUTHOR("Marcello Sylvester Bauer <sylv@sylv.io>");
> +MODULE_DESCRIPTION("PMBus driver for Vicor PLI1209BC");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(PMBUS);
