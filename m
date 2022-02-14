Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57794B58B4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 18:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357197AbiBNRks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 12:40:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357188AbiBNRkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:40:46 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A57865427;
        Mon, 14 Feb 2022 09:40:38 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id r18-20020a05683001d200b005ac516aa180so5003472ota.6;
        Mon, 14 Feb 2022 09:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+YzDzBUolqzlVG9vR2yoBnETAT9BjXB0yQBIcDtwgwo=;
        b=nDd2Vtjwc2soEdPeClmxuA8mw8N68OQuVBqumreC74txk5rAjVAJABimV0izqqTTqj
         P29oUvVxXuo2dxCwkK9HxwigZjz9dTuAVJVdC0j//5EZCjwXRA1/srbFOTLBCcYcuUX+
         N2gC/issLqrfcnqm1EgjX6NkqdjRLu3fwT3/DUWYVlgiQCR0dS86/e9VaJJfFN2spEiT
         uK+E3ZpWtZtqhY7dD77BkNWulQdVGRyQ1silyG4WjnUUOX1BVaXRRA2mIpRckLnwavL/
         ACa6APf2sN0k2ijnw8Oi3fO5dH3xo9oun25vsY1sPZvCX30xP0DxC90z8aHUlb0HvpWz
         FC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+YzDzBUolqzlVG9vR2yoBnETAT9BjXB0yQBIcDtwgwo=;
        b=hbxy4PTfSPWJ2GAprHRvvwVyReFeDa2snFPU6DfSLIHLnJPUkTA8NVz4Bzn+lp4Gku
         FJkcjRAEISxasvx4FaX90qfKEyZ9fOhGGBbV73/vxKZnTwHF9bmo7IEYIntTe9fkzYGg
         Mdf5V3QRHTWKs6dCkTGJnRFGyTk/aupjk+SR16STWTvpkiBd8aP+4PvqduUaiJ+BY4JR
         3Ad05Np8CV2CModEyPnMSL0lN9K0VHBSffOV/rDV4I1h7XG6djMChkhFM8djVFlF0reO
         hZOg/5qJKkDzZthKwY/yCOQw6o1rsLJGMCuzct4MF8XgagWwY5vw7AfeyDqETxcle76O
         LqIg==
X-Gm-Message-State: AOAM5327NBs9KaN79sSkZofp9bbS+SL+rX+H20G7+dEmXQtCAyZn7dKS
        Vk+Q2JKVywvZI54NutgRI793N18HrgBONQ==
X-Google-Smtp-Source: ABdhPJxZnMBeUM06qQmAn0iYC9VjZDi6sbiBPMaC+5y/isHJA21yEfr6TtdTiwfq5jkVuNg+oobBkw==
X-Received: by 2002:a9d:7593:: with SMTP id s19mr5023otk.71.1644860437712;
        Mon, 14 Feb 2022 09:40:37 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d22sm12487408otp.79.2022.02.14.09.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 09:40:37 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <62de6f93-12eb-838f-884d-f1ef96ab6e22@roeck-us.net>
Date:   Mon, 14 Feb 2022 09:40:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 4/4] pmbus (pli1209bc): Add regulator support
Content-Language: en-US
To:     Marcello Sylvester Bauer <sylv@sylv.io>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
References: <cover.1644834803.git.sylv@sylv.io>
 <fc5b0ba1f7d41e88ef066c3ff23aaf882c19c543.1644834803.git.sylv@sylv.io>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <fc5b0ba1f7d41e88ef066c3ff23aaf882c19c543.1644834803.git.sylv@sylv.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/22 04:40, Marcello Sylvester Bauer wrote:
> Add regulator support for PLI1209BC Digital Supervisor.
> 
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> ---
>   drivers/hwmon/pmbus/Kconfig     |  7 +++++++
>   drivers/hwmon/pmbus/pli1209bc.c | 31 +++++++++++++++++++++++++++++++
>   2 files changed, 38 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 831db423bea0..8b8f0d8733b2 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -319,6 +319,13 @@ config SENSORS_PLI1209BC
>   	  This driver can also be built as a module. If so, the module will
>   	  be called pli1209bc.
>   
> +config SENSORS_PLI1209BC_REGULATOR
> +	bool "Regulator support for PLI1209BC"
> +	depends on SENSORS_PLI1209BC && REGULATOR
> +	help
> +	  If you say yes here you get regulator support for Vicor PLI1209BC
> +	  Digital Supervisor.
> +
>   config SENSORS_PM6764TR
>   	tristate "ST PM6764TR"
>   	help
> diff --git a/drivers/hwmon/pmbus/pli1209bc.c b/drivers/hwmon/pmbus/pli1209bc.c
> index 8a9af2ccc46f..7212d73f6e04 100644
> --- a/drivers/hwmon/pmbus/pli1209bc.c
> +++ b/drivers/hwmon/pmbus/pli1209bc.c
> @@ -8,6 +8,7 @@
>   #include <linux/i2c.h>
>   #include <linux/module.h>
>   #include <linux/pmbus.h>
> +#include <linux/regulator/driver.h>
>   #include "pmbus.h"
>   
>   /*
> @@ -32,11 +33,37 @@ static int pli1209bc_read_word_data(struct i2c_client *client, int page,
>   		if (data < 0)
>   			return data;
>   		return data * 10;
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
> +			return 0L;

Why 0L ? The return value of pli1209bc_read_word_data() is int.

> +		return pmbus_read_word_data(client, page, phase, reg);
>   	default:
>   		return -ENODATA;
>   	}
>   }
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
>   static struct pmbus_driver_info pli1209bc_info = {
>   	.pages = 2,
>   	.format[PSC_VOLTAGE_IN] = direct,
> @@ -74,6 +101,10 @@ static struct pmbus_driver_info pli1209bc_info = {
>   	    | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP
>   	    | PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_INPUT,
>   	.read_word_data = pli1209bc_read_word_data,
> +#if IS_ENABLED(CONFIG_SENSORS_PLI1209BC_REGULATOR)
> +	.num_regulators = 1,
> +	.reg_desc = &pli1209bc_reg_desc,
> +#endif
>   };
>   
>   static int pli1209bc_probe(struct i2c_client *client)

