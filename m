Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC15A4C35DE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbiBXT0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbiBXT0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:26:23 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0397B24FB88;
        Thu, 24 Feb 2022 11:25:53 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id y7so4422125oih.5;
        Thu, 24 Feb 2022 11:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wYVJphdnC3WyxYFo08m/0+nXWlP/kcAa+yXhJqXCzb4=;
        b=BP9jkfkKdOF3lr6ne3AVGr49UF2GaGQO+3XzS46vmSPi6v5DO0RFwkfCTc6/haxsnn
         +YqgyC0nEmy6e7yZSBs8TUimhrxVz2wtiPz+/uAxBuhlbR3+UAR5k0YjGNZfRYzQnpE4
         f9/asWaiZMPW6BD345v9ecbBH8WTspjaBrf3oC6n4x08+71at7QkksKbYU+0cdb1gFfA
         K9zD+355irL13roJIFaIxp783J0jrDPUe+XjhceZ8FyCNU0SHkWNTUZWdVFgsHexxF7V
         C1wuCDfuqZdsD/7iOjDxAyNG86XOoUw9sJouwzwWMnXEKvGehOxmA9MRIF9Mxf1hV2r4
         byPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=wYVJphdnC3WyxYFo08m/0+nXWlP/kcAa+yXhJqXCzb4=;
        b=HB/Ek3URc+t/QCUVYOE001MfldaZIbN9Nx4NqlZa+icBaMPSNqJz/SJaDD0e8sbAfH
         edah3i7+LrMHzLAYyDkdMoKx7HrnjWYPkT5OFnqX0gt6amqxVzA3uXSCp/IGd2diQYTp
         jINzT6KnSEjfxBtqXWo4bDKsW8aKeCdDiTjq3ct2vSd7R47pacbLoOBZnz3WPXK2Ph2l
         1aysIFRMTOETJcYBmxg0Nhm3liq7xI6REcRySE6BLzuuyAzE5AGXbDDiSzQy1EhCvTGA
         wpomZxBmLxQgyXRxLGpvoymvCeaBWAdubmI5t/Mxsm17lXwkpsTgSWJdAnOclY3BKGUY
         04MQ==
X-Gm-Message-State: AOAM533Bpti7Yc+dMVOgMpjcFkrSuatW9dfIGbttUJIFyrFrNs3Mk2NK
        GXLsIfuDzaRwXhEQmtmzBpQ=
X-Google-Smtp-Source: ABdhPJz+flPuDWdghwWL1Ij5Pn+XFVJi2pJlnTaHEeCDtFobFRgxUZFwyTPcp3mFwI8OjS1p6cK3UA==
X-Received: by 2002:a05:6870:6017:b0:d3:d393:9680 with SMTP id t23-20020a056870601700b000d3d3939680mr6730560oaa.343.1645730752410;
        Thu, 24 Feb 2022 11:25:52 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id dy16-20020a056870c79000b000d273fb9e95sm263733oab.7.2022.02.24.11.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 11:25:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 24 Feb 2022 11:25:50 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Marcello Sylvester Bauer <sylv@sylv.io>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v4 4/4] pmbus (pli1209bc): Add regulator support
Message-ID: <20220224192550.GA1942763@roeck-us.net>
References: <cover.1645435888.git.sylv@sylv.io>
 <21b0cdb6dd72654effa451d3b1636ecd07b160e9.1645435888.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21b0cdb6dd72654effa451d3b1636ecd07b160e9.1645435888.git.sylv@sylv.io>
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

On Mon, Feb 21, 2022 at 10:42:07AM +0100, Marcello Sylvester Bauer wrote:
> Add regulator support for PLI1209BC Digital Supervisor.
> 
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/Kconfig     |  7 +++++++
>  drivers/hwmon/pmbus/pli1209bc.c | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index f18f67a94697..6552467c588d 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -326,6 +326,13 @@ config SENSORS_PLI1209BC
>  	  This driver can also be built as a module. If so, the module will
>  	  be called pli1209bc.
>  
> +config SENSORS_PLI1209BC_REGULATOR
> +	bool "Regulator support for PLI1209BC"
> +	depends on SENSORS_PLI1209BC && REGULATOR
> +	help
> +	  If you say yes here you get regulator support for Vicor PLI1209BC
> +	  Digital Supervisor.
> +
>  config SENSORS_PM6764TR
>  	tristate "ST PM6764TR"
>  	help
> diff --git a/drivers/hwmon/pmbus/pli1209bc.c b/drivers/hwmon/pmbus/pli1209bc.c
> index 5f8847307e55..05b4ee35ba27 100644
> --- a/drivers/hwmon/pmbus/pli1209bc.c
> +++ b/drivers/hwmon/pmbus/pli1209bc.c
> @@ -8,6 +8,7 @@
>  #include <linux/i2c.h>
>  #include <linux/module.h>
>  #include <linux/pmbus.h>
> +#include <linux/regulator/driver.h>
>  #include "pmbus.h"
>  
>  /*
> @@ -33,11 +34,37 @@ static int pli1209bc_read_word_data(struct i2c_client *client, int page,
>  			return data;
>  		data = sign_extend32(data, 15) * 10;
>  		return clamp_val(data, -32768, 32767) & 0xffff;
> +	/*
> +	 * PMBUS_READ_VOUT and PMBUS_READ_TEMPERATURE_1 return invalid data
> +	 * when the BCM is turned off. Since it is not possible to return
> +	 * ENODATA error, return zero instead.
> +	 */
> +	case PMBUS_READ_VOUT:
> +	case PMBUS_READ_TEMPERATURE_1:
> +		data = pmbus_read_word_data(client, page, phase,
> +					    PMBUS_STATUS_WORD);
> +		if (data < 0)
> +			return data;
> +		if (data & PB_STATUS_POWER_GOOD_N)
> +			return 0;
> +		return pmbus_read_word_data(client, page, phase, reg);
>  	default:
>  		return -ENODATA;
>  	}
>  }
>  
> +#if IS_ENABLED(CONFIG_SENSORS_PLI1209BC_REGULATOR)
> +static const struct regulator_desc pli1209bc_reg_desc = {
> +	.name = "vout2",
> +	.id = 1,
> +	.of_match = of_match_ptr("vout2"),
> +	.regulators_node = of_match_ptr("regulators"),
> +	.ops = &pmbus_regulator_ops,
> +	.type = REGULATOR_VOLTAGE,
> +	.owner = THIS_MODULE,
> +};
> +#endif
> +
>  static struct pmbus_driver_info pli1209bc_info = {
>  	.pages = 2,
>  	.format[PSC_VOLTAGE_IN] = direct,
> @@ -75,6 +102,10 @@ static struct pmbus_driver_info pli1209bc_info = {
>  	    | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP
>  	    | PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_INPUT,
>  	.read_word_data = pli1209bc_read_word_data,
> +#if IS_ENABLED(CONFIG_SENSORS_PLI1209BC_REGULATOR)
> +	.num_regulators = 1,
> +	.reg_desc = &pli1209bc_reg_desc,
> +#endif
>  };
>  
>  static int pli1209bc_probe(struct i2c_client *client)
