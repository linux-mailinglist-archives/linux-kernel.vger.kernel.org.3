Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90D44B2DF4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 20:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352974AbiBKTow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 14:44:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbiBKTou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 14:44:50 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFB113A;
        Fri, 11 Feb 2022 11:44:49 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id t199so10708815oie.10;
        Fri, 11 Feb 2022 11:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Wy/W1bAG274Y0qe9iL4b7M6BndZjgerzoZT6E+uph/M=;
        b=A7nYVOpK2xN1B9VYu/YbG3la21K3kXSa4qiPL5wOeiCqnGFT4WljMAI6hBBKUskHa3
         NMZL+vZPbVodHlvsLWoXThsPvGWhCyk7t5pehPN/ZwMTIrbta1BsA8p4Zax2VU2XyGac
         CU25pp4rBqen4HjjrECiZUzqGh3b8bKvbEG4stQYLS11+zcSlbXisC0yMYUZhaT4dYZq
         woyEuvQyKrbmxOS4Mu7zZHnB2IQfBFx9gIYCeDjWBiglMeGKEWvIboAJFNdyCM9L51/F
         XiVJosYZCNI5Cx/PmtTg2LDjWUb0Y54gXd4aQT3TruJk6EZDyFNdETctEV6++QE8qA8c
         OOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Wy/W1bAG274Y0qe9iL4b7M6BndZjgerzoZT6E+uph/M=;
        b=bh6N8dFdDgpd2pMP5YWEbIiQPMpR4dWR4LIUTgHw6lRqAplkRoxUPpAgW+LDORwfyw
         n8IviA/e5BY3ZhWV/QeZ2XWHg7rvgPs8yZk7fFxvat+F9/BfWE/YYW2c/26QACQUqdMM
         cMmKTo7tDMNyYpd0FdpQX9Hb0IO3n5ouMrA1mMGOJnLTeaZAr0UEfZ5+7Mugg1nhgFBc
         JE70ke/yqPj6elihOuQba6tguxsdQWPOcEi/zApa25QIBGwAs72kaDZU5lfPFX/amV6E
         AjzdTdzldd4G/5Ypk9oK7HbeNz+VWYuMG/nmpYH/Fu/LYk8no7GbM546ylKO1Kv2zPjg
         fyzA==
X-Gm-Message-State: AOAM5335KVBA8m9JSCRv0NIm1e+ipK11/MmSiSc2Jf2ugFhmRRu+25f2
        yZA1FyP+s3gOTncSGFnfhoqFGN1sig+FEA==
X-Google-Smtp-Source: ABdhPJxcaiv57INQPFV6yhhLYlWDUzOsMx2xN7e24O9ZuXWv/MD3HT0zhMSOWBGFASiimaa+QBzvrQ==
X-Received: by 2002:a05:6808:2011:: with SMTP id q17mr994371oiw.199.1644608688413;
        Fri, 11 Feb 2022 11:44:48 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id eq37sm11649972oab.19.2022.02.11.11.44.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 11:44:47 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <07a08a9f-5600-f5d2-0955-4bc6e1f9a893@roeck-us.net>
Date:   Fri, 11 Feb 2022 11:44:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 4/4] pmbus (pli1209bc): Add regulator support
Content-Language: en-US
To:     Marcello Sylvester Bauer <sylv@sylv.io>,
        linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
References: <cover.1644597670.git.sylv@sylv.io>
 <0a657d200809dedc5fdd2095fae8c0f2fceecf1f.1644597670.git.sylv@sylv.io>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <0a657d200809dedc5fdd2095fae8c0f2fceecf1f.1644597670.git.sylv@sylv.io>
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

On 2/11/22 09:17, Marcello Sylvester Bauer wrote:
> Add regulator support for PLI1209BC Digital Supervisor.
> 
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> ---
>   drivers/hwmon/pmbus/Kconfig     |  8 ++++++++
>   drivers/hwmon/pmbus/pli1209bc.c | 33 +++++++++++++++++++++++++++++++++
>   2 files changed, 41 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 831db423bea0..e64e0f2d93c9 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -319,6 +319,14 @@ config SENSORS_PLI1209BC
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
> +

Single empty line please

>   config SENSORS_PM6764TR
>   	tristate "ST PM6764TR"
>   	help
> diff --git a/drivers/hwmon/pmbus/pli1209bc.c b/drivers/hwmon/pmbus/pli1209bc.c
> index da345eb105fd..ec479b22aa10 100644
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
> @@ -32,11 +33,39 @@ static int pli1209bc_read_word_data(struct i2c_client *client, int page,
>   		if (data < 0)
>   			return data;
>   		return div_s64(data + 5LL, 10L);
> +#if IS_ENABLED(CONFIG_SENSORS_PLI1209BC_REGULATOR)

I don't think this needs to be conditional.

> +	/*
> +	 * PMBUS_READ_VOUT and PMBUS_READ_TEMPERATURE_1 returns invalid data,

s/returns/return/ and no ','

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
> +		return pmbus_read_word_data(client, page, phase, reg);
> +#endif
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
> @@ -64,6 +93,10 @@ static struct pmbus_driver_info pli1209bc_info = {
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

