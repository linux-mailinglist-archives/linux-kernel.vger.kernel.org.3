Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F1D4C35DC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbiBXT0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbiBXT0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:26:08 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3D924FA25;
        Thu, 24 Feb 2022 11:25:37 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id q5so4406974oij.6;
        Thu, 24 Feb 2022 11:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N7NxQu/FeepDrPM2jefJP5YDe7z5Qlzk0IqBnPNZPGg=;
        b=BPIwg/PTk7HFghjbgNm9t0p30I5saTIzrxxezTjvuZNUc/YQ3d2IOQYnhCsYa73GAQ
         M542WZnRC1lM0s/BTcL0O57pPluD+oLElOuug0ch3zWh/fm6iy2zYvRc1UFtBQuGcf0w
         jIdpoSdtUca8mFSzx8JsgINt/zEMxTH9LyIkNqFZHtGhVPv1dh1R8u6UexV7t7qsHo24
         6BnvlObI3UwwtReN9+hQzOsVjSJsRNmnrasIRo/BxmLhMOjtQ95Gd65QxhOIau/D2iZb
         y9yGmqbz+8t4IPLGTpU2+/BKvQbuP+/ASGhI4c3wGBQxZV9BL1rmkJeo7r+Asd0i3izU
         LrTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=N7NxQu/FeepDrPM2jefJP5YDe7z5Qlzk0IqBnPNZPGg=;
        b=4xO0v9V+ct3rW0anSsoU9+NrBUtRdFAp1CWguLxceMNxwj5NA5pOsdt+S6keDMJxmh
         uiIFvkNWIsgCWhF9EpvJkUDErDpgfFaPSM6rJaj4tAFRFjpAx6CpqP17f97m3g0b5ccw
         0Xf23R7EDrRGG4k7PiyeK2EZzwLKnKEtzCdP8COpRzMO/6wL5OUebLiwHqKGId0TUddv
         745aceAfpn1PP6wT8if+G+QtzPM5XE0qfVpAzH/A7vrkxV5Nay2Xory9PibdT7j/wr/w
         gTu5AhewBNWemVBqhEr1eTJDt2aT8qKAsoqzl9IZkT6JgzDJJmoE7ElbcHv+wWbRkAuo
         SaMQ==
X-Gm-Message-State: AOAM532WQCveum4NqPMrou+ZT55r5zmFqnXhCtc+b31r/noHRng0efUV
        cjh+v8EkVko/VSR0VVga998=
X-Google-Smtp-Source: ABdhPJw4E4m3s1zHg8F4T8LyVRetMw754xWVPq29nOh78qC7YGxHS1UTTwbPFsiK+tJQbZ8JHinbWA==
X-Received: by 2002:a05:6870:910b:b0:ce:c0c9:641 with SMTP id o11-20020a056870910b00b000cec0c90641mr6786438oae.147.1645730736742;
        Thu, 24 Feb 2022 11:25:36 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i11-20020a056830402b00b005af1411565bsm80803ots.78.2022.02.24.11.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 11:25:36 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 24 Feb 2022 11:25:34 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Marcello Sylvester Bauer <sylv@sylv.io>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 3/4] pmbus: Add support for pli1209bc
Message-ID: <20220224192534.GA1942731@roeck-us.net>
References: <cover.1645435888.git.sylv@sylv.io>
 <4e016e66275bc46c90974aec18b150c874e64787.1645435888.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e016e66275bc46c90974aec18b150c874e64787.1645435888.git.sylv@sylv.io>
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

On Mon, Feb 21, 2022 at 10:42:06AM +0100, Marcello Sylvester Bauer wrote:
> PLI1209BC is a Digital Supervisor from Vicor Corporation.
> 
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  Documentation/hwmon/index.rst     |   1 +
>  Documentation/hwmon/pli1209bc.rst |  75 +++++++++++++++++++
>  drivers/hwmon/pmbus/Kconfig       |   9 +++
>  drivers/hwmon/pmbus/Makefile      |   1 +
>  drivers/hwmon/pmbus/pli1209bc.c   | 115 ++++++++++++++++++++++++++++++
>  5 files changed, 201 insertions(+)
>  create mode 100644 Documentation/hwmon/pli1209bc.rst
>  create mode 100644 drivers/hwmon/pmbus/pli1209bc.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index b69fdaf1af82..075d1defcd20 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -161,6 +161,7 @@ Hardware Monitoring Kernel Drivers
>     pc87427
>     pcf8591
>     pim4328
> +   pli1209bc
>     pm6764tr
>     pmbus
>     powr1220
> diff --git a/Documentation/hwmon/pli1209bc.rst b/Documentation/hwmon/pli1209bc.rst
> new file mode 100644
> index 000000000000..ea5b3f68a515
> --- /dev/null
> +++ b/Documentation/hwmon/pli1209bc.rst
> @@ -0,0 +1,75 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
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
> +The Vicor PLI1209BC is an isolated digital power system supervisor that provides
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
> index c73aa50c7615..f18f67a94697 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -317,6 +317,15 @@ config SENSORS_PIM4328
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
> index e5935f70c9e0..a4a96ac71de7 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -33,6 +33,7 @@ obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
>  obj-$(CONFIG_SENSORS_MP2888)	+= mp2888.o
>  obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
>  obj-$(CONFIG_SENSORS_MP5023)	+= mp5023.o
> +obj-$(CONFIG_SENSORS_PLI1209BC)	+= pli1209bc.o
>  obj-$(CONFIG_SENSORS_PM6764TR)	+= pm6764tr.o
>  obj-$(CONFIG_SENSORS_PXE1610)	+= pxe1610.o
>  obj-$(CONFIG_SENSORS_Q54SJ108A2)	+= q54sj108a2.o
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
