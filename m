Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667364B9465
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 00:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237743AbiBPXRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 18:17:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiBPXRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 18:17:42 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8031FFF71;
        Wed, 16 Feb 2022 15:17:29 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id u25-20020a4ad0d9000000b002e8d4370689so4397533oor.12;
        Wed, 16 Feb 2022 15:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=793XOJWyfkqhx93nW4Pi5xj2jcIm27dgvSlGDaWmZOE=;
        b=XF76RW97wRBysaGUL5ieC7SPJ86Jc2FN74NDgnL+a0CCEw2uhimoG5O22SkSeMjNgW
         JGkJHCNcxt0uEkKR+XsPN7ptOq41BeEFh1lnKZj2t+KjzO8OGARt0u4TA4lQMM4OEb8s
         5HQy7BpTRNY9V5E+OCTCzBcH7PASkANqjAfl7BAZLzkwQ7MYOFu1P6nr1uyg0aVCU+HD
         OS9Q9EYnYFX4p7hs0lhygGjRKESRgD8UneBKZ+ApA4cdg+DJDbaySqc4gV3OgRAIzwPh
         LLtawCt861TRLLpaIdg5tthIqaVHEaOXUDOkK2CVuWyBDtVHXq5nwWHhpPPFMmqAO+yA
         I0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=793XOJWyfkqhx93nW4Pi5xj2jcIm27dgvSlGDaWmZOE=;
        b=b8VlGyFePFuXWzB57QhvtTbLpUmCSOBqLhP9Ac6v2sitatfk7VmP/rb4SAgB72TXEw
         UmDQoa0MT7R+zKh9C4AvJwz9ugj+V/mdbKusvWbiO32DPTJngwU4QYikg5ZT6t4Za2hS
         UDL/7vSYvv0F2A3U4jfA4c/dLxltvnYO4ZGe7gI9OqHqWTJ5vWdesm3zdCiuFNMVvsi1
         h+QRRqbtHBkbN5BcrTjlmHN1ggU5SwY2vGhb1pLlfkY2QPMobFFF3unQANhtYFdJ2Plw
         1d3Ax2zRa+1cOlgavu6OcCjHTPRNS44rlNy0wgPPOxlWrTWjMIQNIKUjoCyr70ACvGIi
         X0Iw==
X-Gm-Message-State: AOAM5325nk8pP+0CZgXaACz5j3tC0BQlq/AfjH7p/7tEf/jqdTYvzcTr
        mCNAJfC41psKPc8ypZPMt80=
X-Google-Smtp-Source: ABdhPJxwftOeyM2rxRz+JYIN9RIYcjRTwi3lMH7kk/w5jI/whyZ53Q7FbOmoD1p88ITsE5Rm1XcQbw==
X-Received: by 2002:a05:6870:172c:b0:ce:c0c9:67f with SMTP id h44-20020a056870172c00b000cec0c9067fmr1401591oae.209.1645053448576;
        Wed, 16 Feb 2022 15:17:28 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o14sm6762221oaq.37.2022.02.16.15.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 15:17:27 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <82add6a8-cd4f-f331-5b54-e0a6bf633cd1@roeck-us.net>
Date:   Wed, 16 Feb 2022 15:17:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Erik Rosen <erik.rosen@metormote.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chu Lin <linchuyuan@google.com>,
        Jason Ling <jasonling@google.com>
References: <20220216115537.44205-1-erik.rosen@metormote.com>
 <20220216115537.44205-2-erik.rosen@metormote.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/1] hwmon: (pmbus) Try to match MFR_MODEL to pmbus device
 id
In-Reply-To: <20220216115537.44205-2-erik.rosen@metormote.com>
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

On 2/16/22 03:55, Erik Rosen wrote:
> Add a new device id to  read the MFR_MODEL command
> to try and match the model name to the device id name and
> predefine the functions supported by this specific converter.
> In this way one can avoid the auto-detection process
> altogether for the problematic models.
> If there is no match, the driver reverts to auto-detection.
> 
> Signed-off-by: Erik Rosen <erik.rosen@metormote.com>

That looks really messy, and it does more than it claims to do.
Really, if the bcm chips need special treatment they should not
use the generic driver but use their own front-end driver like
other chips. The required flags can then be provided in that driver.
Also "pmbus_match_model" is _really_ not acceptable. Those names
are expected to match chips, not some arbitrary string.

If we have a separate driver, and assuming the customer using
different modules uses various BMR chips, a separate driver could
check PMBUS_MFR_MODEL and use it to match the exact chip (if that is
even needed since all the BMR chips seem to have the same
configuration data). Maybe PMBUS_READ_STATUS_AFTER_FAILED_CHECK
could then be dropped entirely.

Guenter

> ---
>   drivers/hwmon/pmbus/pmbus.c | 57 +++++++++++++++++++++++++++++++------
>   1 file changed, 49 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
> index d0d386990af5..278b2a927ce0 100644
> --- a/drivers/hwmon/pmbus/pmbus.c
> +++ b/drivers/hwmon/pmbus/pmbus.c
> @@ -18,9 +18,11 @@
>   struct pmbus_device_info {
>   	int pages;
>   	u32 flags;
> +	u32 func[PMBUS_PAGES];
>   };
>   
>   static const struct i2c_device_id pmbus_id[];
> +static const struct pmbus_device_info pmbus_info_zero;
>   
>   /*
>    * Find sensor groups and status registers on each page.
> @@ -156,13 +158,18 @@ static int pmbus_identify(struct i2c_client *client,
>   	}
>   
>   	/* Try to find sensor groups  */
> -	pmbus_find_sensor_groups(client, info);
> +	if (info->func[0] == 0)
> +		pmbus_find_sensor_groups(client, info);
> +
>   abort:
>   	return ret;
>   }
>   
>   static int pmbus_probe(struct i2c_client *client)
>   {
> +	int ret, i;
> +	u8 mfr_model[I2C_SMBUS_BLOCK_MAX + 1];
> +	const struct i2c_device_id *device_id = NULL;
>   	struct pmbus_driver_info *info;
>   	struct pmbus_platform_data *pdata = NULL;
>   	struct device *dev = &client->dev;
> @@ -173,6 +180,30 @@ static int pmbus_probe(struct i2c_client *client)
>   		return -ENOMEM;
>   
>   	device_info = (struct pmbus_device_info *)i2c_match_id(pmbus_id, client)->driver_data;
> +	if (!device_info) {
> +		if (!i2c_check_functionality(client->adapter,
> +					     I2C_FUNC_SMBUS_BLOCK_DATA))
> +			return -ENODEV;
> +
> +		ret = i2c_smbus_read_block_data(client, PMBUS_MFR_MODEL, mfr_model);
> +		if (ret < 0)
> +			return ret;
> +
> +		for (device_id = pmbus_id; device_id->name[0]; device_id++) {
> +			if (device_id->driver_data &&
> +			    !strncasecmp(device_id->name, mfr_model, strlen(device_id->name)))
> +				break;
> +		}
> +
> +		if (device_id->name[0])
> +			device_info = (struct pmbus_device_info *)device_id->driver_data;
> +		else
> +			device_info = (struct pmbus_device_info *)&pmbus_info_zero;
> +
> +		dev_info(dev, "Use pmbus device id: %s\n",
> +			 device_id->name[0] ? device_id->name : "pmbus");
> +	}
> +
>   	if (device_info->flags) {
>   		pdata = devm_kzalloc(dev, sizeof(struct pmbus_platform_data),
>   				     GFP_KERNEL);
> @@ -183,6 +214,8 @@ static int pmbus_probe(struct i2c_client *client)
>   	}
>   
>   	info->pages = device_info->pages;
> +	for (i = 0; i < info->pages; i++)
> +		info->func[i] = device_info->func[i];
>   	info->identify = pmbus_identify;
>   	dev->platform_data = pdata;
>   
> @@ -204,9 +237,16 @@ static const struct pmbus_device_info pmbus_info_one_skip = {
>   	.flags = PMBUS_SKIP_STATUS_CHECK
>   };
>   
> -static const struct pmbus_device_info pmbus_info_one_status = {
> +static const struct pmbus_device_info pmbus_info_bmr458 = {
>   	.pages = 1,
> -	.flags = PMBUS_READ_STATUS_AFTER_FAILED_CHECK
> +	.flags = PMBUS_READ_STATUS_AFTER_FAILED_CHECK,
> +	.func = {
> +			PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT
> +		      | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
> +		      | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT
> +		      | PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2
> +		      | PMBUS_HAVE_STATUS_TEMP
> +		}
>   };
>   
>   /*
> @@ -214,15 +254,15 @@ static const struct pmbus_device_info pmbus_info_one_status = {
>    */
>   static const struct i2c_device_id pmbus_id[] = {
>   	{"adp4000", (kernel_ulong_t)&pmbus_info_one},
> -	{"bmr310", (kernel_ulong_t)&pmbus_info_one_status},
> +	{"bmr310", (kernel_ulong_t)&pmbus_info_bmr458},
>   	{"bmr453", (kernel_ulong_t)&pmbus_info_one},
>   	{"bmr454", (kernel_ulong_t)&pmbus_info_one},
>   	{"bmr456", (kernel_ulong_t)&pmbus_info_one},
>   	{"bmr457", (kernel_ulong_t)&pmbus_info_one},
> -	{"bmr458", (kernel_ulong_t)&pmbus_info_one_status},
> -	{"bmr480", (kernel_ulong_t)&pmbus_info_one_status},
> -	{"bmr490", (kernel_ulong_t)&pmbus_info_one_status},
> -	{"bmr491", (kernel_ulong_t)&pmbus_info_one_status},
> +	{"bmr458", (kernel_ulong_t)&pmbus_info_bmr458},
> +	{"bmr480", (kernel_ulong_t)&pmbus_info_bmr458},
> +	{"bmr490", (kernel_ulong_t)&pmbus_info_bmr458},
> +	{"bmr491", (kernel_ulong_t)&pmbus_info_bmr458},
>   	{"bmr492", (kernel_ulong_t)&pmbus_info_one},
>   	{"dps460", (kernel_ulong_t)&pmbus_info_one_skip},
>   	{"dps650ab", (kernel_ulong_t)&pmbus_info_one_skip},
> @@ -235,6 +275,7 @@ static const struct i2c_device_id pmbus_id[] = {
>   	{"pdt006", (kernel_ulong_t)&pmbus_info_one},
>   	{"pdt012", (kernel_ulong_t)&pmbus_info_one},
>   	{"pmbus", (kernel_ulong_t)&pmbus_info_zero},
> +	{"pmbus_match_model", (kernel_ulong_t)0},
>   	{"sgd009", (kernel_ulong_t)&pmbus_info_one_skip},
>   	{"tps40400", (kernel_ulong_t)&pmbus_info_one},
>   	{"tps544b20", (kernel_ulong_t)&pmbus_info_one},

