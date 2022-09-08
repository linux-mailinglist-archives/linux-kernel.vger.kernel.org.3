Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B4E5B2585
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbiIHSUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiIHSUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:20:30 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D7EA2633;
        Thu,  8 Sep 2022 11:20:26 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o4so18595448pjp.4;
        Thu, 08 Sep 2022 11:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=jFr962b3Vh092XG5kMgf/jyI9HdgFMZcVYWjVRDIAFA=;
        b=Yycnx16+R/JT+3ksrXPh5iKV6ddwNQDUB5dMGNXVUIEYFlxNQL4ihImqW696AOjbh1
         WlciYtczqdrwafHjtBUfqMw+pUfGLuiBRoGUuI6BCDMdjWh75nf/XMGCnO+OQ/vehoMA
         YYJX9atjYQs8Brz7xImLuFZJTrXQ3jvRaFmeBAseotQejrTSopt1D+OKir6gkviUHZof
         3csmRXeKDKpInRSY8iI8x+e3yKzqW8fPCzPn884/kaDLrXdk4G4BcqSJ9ej9tQfDvFz8
         zIhciy8AdmNr5tgbk+6md1aAbqWVSaL/0jgWAYiSssftw+kqpRk/YtRzlXfUS4cO9+aE
         7tyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=jFr962b3Vh092XG5kMgf/jyI9HdgFMZcVYWjVRDIAFA=;
        b=Msngvn2QwVnjmQzBOfIQnUmq3ag/5HYN57QeEry5n02u65cFHNpB+v7ESIF8RKDMRe
         Wx96RI2mnSuvuXGJreCqztVnLUWhaGSXJUh57tiG3WakTj1KqsHSTc5WbPiLQEZmkMDc
         4+tl8aB9guWQPMkVRs4JZaNo5Kw6GoEqrbf8TxJQheoGRarSUDOPFokdMx5s+vX0hjvB
         +zodZNlKRXg1dsLynkLBC83Y3iTdWSLTL2Vw0VR1tzNNxcHAedrH99HfcHlkrGhOJn52
         kr/u4qQrC5/OWGWLFrMvg3HRPIi+0A4qk6SsJ9lh5JxtRVa/TCxIXAtHTxDS4URWqOWs
         0FKQ==
X-Gm-Message-State: ACgBeo32HrMsj4jqXRSMMbGMzCm4HdhLX75iSha6gUZtt3pUHK1B6PsN
        sYOrLciaJ20vHcRo1Z5jT8Z0rEzm0NCZfQ==
X-Google-Smtp-Source: AA6agR4b6grczwtnHbzSxyd/upMJi/YT932fDwvPVLXPok1jVjj0XQ/xF7i343jUAw9piwbANagOJg==
X-Received: by 2002:a17:90b:4a82:b0:200:a89e:6f1f with SMTP id lp2-20020a17090b4a8200b00200a89e6f1fmr5331337pjb.13.1662661225552;
        Thu, 08 Sep 2022 11:20:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l10-20020a170903120a00b0016ef87334aesm15050594plh.162.2022.09.08.11.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 11:20:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <41c67246-114d-f458-4ff1-164995639ca0@roeck-us.net>
Date:   Thu, 8 Sep 2022 11:20:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4] hwmon: Add driver for the TEXAS TPS546D24 Buck
 Converter.
Content-Language: en-US
To:     Duke Du <dukedu83@gmail.com>, jdelvare@suse.com, corbet@lwn.net,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     fran.hsu@quantatw.com, george.hung@quantatw.com,
        charles.hsu@quantatw.com, duke.du@quantatw.com
References: <1662617599-15270-1-git-send-email-Duke.Du@quantatw.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <1662617599-15270-1-git-send-email-Duke.Du@quantatw.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/22 23:13, Duke Du wrote:
> From: Duke Du <dukedu83@gmail.com>
> 
> Add the pmbus driver for TEXAS tps546d24 Buck Converter.
> The vout mode of tps546d24 supported relative data format,
> which is not meet for the original driver (pmbus.c).

"which is not supported by the PMBus core"

> 
> Signed-off-by: Duke Du <dukedu83@gmail.com>
> ---
> Change in v1:
>      Initial patchset.
> Change in v2:
>      Correct the tps546d24.rst format.
> Change in v3:
>      1. Modify the patch description.
>      2. Put the change log between the dashes and diffstat.
> Change in v4:
>      1. Modify the patch description.
>      2. Clear the bit 7 of PMBUS_VOUT_MODE to change the mode from relative
>         to absolute.
>      3. Add the vendor prefix.
> ---
> ---
>   Documentation/hwmon/index.rst     |  1 +
>   Documentation/hwmon/tps546d24.rst | 35 ++++++++++++++++++++++
>   MAINTAINERS                       |  7 +++++
>   drivers/hwmon/pmbus/Kconfig       |  9 ++++++
>   drivers/hwmon/pmbus/Makefile      |  1 +
>   drivers/hwmon/pmbus/tps546d24.c   | 63 +++++++++++++++++++++++++++++++++++++++
>   6 files changed, 116 insertions(+)
>   create mode 100644 Documentation/hwmon/tps546d24.rst
>   create mode 100644 drivers/hwmon/pmbus/tps546d24.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index f7113b0..d3eede4 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -205,6 +205,7 @@ Hardware Monitoring Kernel Drivers
>      tps23861
>      tps40422
>      tps53679
> +   tps546d24
>      twl4030-madc-hwmon
>      ucd9000
>      ucd9200
> diff --git a/Documentation/hwmon/tps546d24.rst b/Documentation/hwmon/tps546d24.rst
> new file mode 100644
> index 0000000..3061fd8
> --- /dev/null
> +++ b/Documentation/hwmon/tps546d24.rst
> @@ -0,0 +1,35 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +Kernel driver tps546d24
> +======================
> +
> +Supported chips:
> +
> +  * TI TPS546D24
> +
> +    Prefix: 'tps546d24'
> +
> +    Addresses scanned: -
> +
> +    Datasheet: https://www.ti.com/lit/gpn/tps546d24
> +
> +Author: Duke Du <dukedu83@gmail.com>
> +
> +
> +Description
> +-----------
> +
> +The TPS546D24A is a highly integrated, non-isolated DC/DC converter capable
> +of high frequency operation and 40-A current output from a 7-mm x 5-mm
> +package.
> +
> +Two, three, and four TPS546D24A devices can be interconnected
> +to provide up to 160 A on a single output. The device has an option to
> +overdrive the internal 5-V LDO with an external 5-V supply via the VDD5
> +pin to improve efficiency and reduce power dissipation of the converter.
> +
> +
> +Platform data support
> +---------------------
> +
> +The driver supports standard PMBus driver platform data.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8a5012b..fa2d4fb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20583,6 +20583,13 @@ Q:	https://patchwork.kernel.org/project/linux-integrity/list/
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
>   F:	drivers/char/tpm/
>   
> +TPS546D24 DRIVER
> +M:	Duke Du <dukedu83@gmail.com>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/hwmon/tps546d24.rst
> +F:	drivers/hwmon/pmbus/tps546d24.c
> +
>   TRACING
>   M:	Steven Rostedt <rostedt@goodmis.org>
>   M:	Ingo Molnar <mingo@redhat.com>
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 951e4a9..89668af 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -397,6 +397,15 @@ config SENSORS_TPS53679
>   	  This driver can also be built as a module. If so, the module will
>   	  be called tps53679.
>   
> +config SENSORS_TPS546D24
> +	tristate "TPS546D24"
> +	help
> +	  If you say yes here you get hardware monitoring support for TEXAS
> +	  TPS546D24.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called tps546d24
> +
>   config SENSORS_UCD9000
>   	tristate "TI UCD90120, UCD90124, UCD90160, UCD90320, UCD9090, UCD90910"
>   	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index e2fe86f..0002dbe 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -41,6 +41,7 @@ obj-$(CONFIG_SENSORS_Q54SJ108A2)	+= q54sj108a2.o
>   obj-$(CONFIG_SENSORS_STPDDC60)	+= stpddc60.o
>   obj-$(CONFIG_SENSORS_TPS40422)	+= tps40422.o
>   obj-$(CONFIG_SENSORS_TPS53679)	+= tps53679.o
> +obj-$(CONFIG_SENSORS_TPS546D24)	+= tps546d24.o
>   obj-$(CONFIG_SENSORS_UCD9000)	+= ucd9000.o
>   obj-$(CONFIG_SENSORS_UCD9200)	+= ucd9200.o
>   obj-$(CONFIG_SENSORS_XDPE122)	+= xdpe12284.o
> diff --git a/drivers/hwmon/pmbus/tps546d24.c b/drivers/hwmon/pmbus/tps546d24.c
> new file mode 100644
> index 0000000..84f3dc9
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/tps546d24.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Hardware monitoring driver for TEXAS TPS546D24 buck converter
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pmbus.h>
> +#include "pmbus.h"
> +
> +static struct pmbus_driver_info tps546d24_info = {
> +	.pages = 1,
> +	.format[PSC_VOLTAGE_IN] = linear,
> +	.format[PSC_VOLTAGE_OUT] = linear,
> +	.format[PSC_TEMPERATURE] = linear,
> +	.format[PSC_CURRENT_OUT] = linear,
> +	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN
> +			| PMBUS_HAVE_IOUT | PMBUS_HAVE_VOUT
> +			| PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_VOUT
> +			| PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
> +};
> +
> +static int tps546d24_probe(struct i2c_client *client)
> +{
> +	int reg;
> +
> +	reg = i2c_smbus_read_byte_data(client, PMBUS_VOUT_MODE);
> +	if (reg > 0x80)

This does not cover reg == 0x80, and does not handle errors.

I would suggest something like

	if (reg < 0)
		return reg;

	if (reg & 0x80) {
		int err;

		err = i2c_smbus_write_byte_data(client, PMBUS_VOUT_MODE, reg & 0x7f);
		if (err < 0)
			return err;
	}
	return pmbus_do_probe(client, &tps546d24_info);

Thanks,
Guenter

> +		i2c_smbus_write_byte_data(client, PMBUS_VOUT_MODE, reg & 0x7f);
> +	return pmbus_do_probe(client, &tps546d24_info);
> +}
> +
> +static const struct i2c_device_id tps546d24_id[] = {
> +	{"tps546d24", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, tps546d24_id);
> +
> +static const struct of_device_id tps546d24_of_match[] = {
> +	{.compatible = "ti,tps546d24"},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, tps546d24_of_match);
> +
> +/* This is the driver that will be inserted */
> +static struct i2c_driver tps546d24_driver = {
> +	.driver = {
> +		   .name = "tps546d24",
> +		   .of_match_table = of_match_ptr(tps546d24_of_match),
> +	   },
> +	.probe_new = tps546d24_probe,
> +	.id_table = tps546d24_id,
> +};
> +
> +module_i2c_driver(tps546d24_driver);
> +
> +MODULE_AUTHOR("Duke Du <dukedu83@gmail.com>");
> +MODULE_DESCRIPTION("PMBus driver for TI tps546d24");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(PMBUS);

