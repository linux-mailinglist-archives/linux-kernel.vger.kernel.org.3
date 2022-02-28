Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8878A4C77C1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 19:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240775AbiB1S3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 13:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240876AbiB1S3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 13:29:25 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2549EE61F0;
        Mon, 28 Feb 2022 10:12:43 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id 189-20020a4a03c6000000b003179d7b30d8so19745767ooi.2;
        Mon, 28 Feb 2022 10:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=d1AmaAaEMdz2x5BUvuXaCe1mKX/9fT+CrQaw2mHcoFY=;
        b=W/zV0DlBABRfKVI0YNf8QA1qRNlRfMuu2wPwwoPVjjgfZw1aFcV0K0J7KBighDG7mL
         jxnY/NZajJCuKB18+ubTx2H7eS/Ug0kUF9L/eYmqUjXMHzch3EaP2sXyGtf1FMdCASH0
         P351C/3mVw4EYJizPlxIu1kgAh8Q+jUUWsGO/jvzSKL5J5x/yALc1kPYEOlubG+rhZO7
         8IbN2GbHfob4dHmiBcv+O+8dnVmMalfo3bPoJwT7SdsoTPSoH7jw+cggk4PbwiuhquVR
         pATVs5/S0lO/ONWFC9FaeYd1XvLNOskQvRRE0JFd+U9LHfdRITq5993j7cLE2RrBQ5Qf
         MFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=d1AmaAaEMdz2x5BUvuXaCe1mKX/9fT+CrQaw2mHcoFY=;
        b=aPw1tXdJ+6lxRKOUHQmN2uVah9d4PdGazae0FHvdPOgTXLrcoinORBc1gPbVdnbC/3
         hkzrnKCBZYu23ylXgzquHVX6N0pVo0E7BXQ0qGu7NlVj6ym1WfiiVAhknmRTam0KZGhm
         54byVRwcP4shfuRsaNnI8xLmROt1ZxQgT5u+JJrbpi9IrF2CdLKWY6zGcFX3CQn00WMo
         9iS+vY8JxpXC4NwftDPQYr+YoVhH7nCcY8iMVQLjcPfEc588224Q9lcfdUnG1ALmVnfM
         0fg5NsIffvJoGVWig7zfTEtGsKdYjCokYE/FCJkOL9VAKJjD161yera/iZttx2XmN+HS
         yfNw==
X-Gm-Message-State: AOAM53263LZ+P4htGst9DcGNTz1GPfeWOlrs1fpp14vOsU/kCbw88nLG
        AtA0dykzb7SEXAvScCzU5qg=
X-Google-Smtp-Source: ABdhPJwmoUnIffAb5nrphZJusLTJz2elU/3FWrlM/T4jVYqkvoAU1hB08H8w+irkNjs4vWj6V9TmIg==
X-Received: by 2002:a4a:95d1:0:b0:317:9a32:fd21 with SMTP id p17-20020a4a95d1000000b003179a32fd21mr9502562ooi.89.1646071962172;
        Mon, 28 Feb 2022 10:12:42 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a4-20020a9d6e84000000b005afe328af91sm3900287otr.54.2022.02.28.10.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 10:12:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ad5fe94a-bfa2-8cda-058d-92545cead239@roeck-us.net>
Date:   Mon, 28 Feb 2022 10:12:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/2] hwmon: (adm1275) Allow setting sample averaging
Content-Language: en-US
To:     Potin Lai <potin.lai@quantatw.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Patrick Williams <patrick@stwcx.xyz>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220228103716.10774-1-potin.lai@quantatw.com>
 <20220228103716.10774-2-potin.lai@quantatw.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220228103716.10774-2-potin.lai@quantatw.com>
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

On 2/28/22 02:37, Potin Lai wrote:
> Current driver assume PWR_AVG and VI_AVG as 1 by default, and user needs
> to set sample averaging via sysfs manually.
> 
> This patch parses the properties below from device tree, and setting
> sample averaging during probe. Allowed input value from 1 to 128. If the
> inputed value is not power of 2, the sample averaging number will be
> configured with the smaller and cloest power of 2.
> 
> - adi,power-sample-average
> - adi,volt-curr-sample-average
> 
> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
> ---
>   drivers/hwmon/pmbus/adm1275.c | 36 +++++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
> index d311e0557401..212c7f3c59b0 100644
> --- a/drivers/hwmon/pmbus/adm1275.c
> +++ b/drivers/hwmon/pmbus/adm1275.c
> @@ -475,6 +475,7 @@ static int adm1275_probe(struct i2c_client *client)
>   	int vindex = -1, voindex = -1, cindex = -1, pindex = -1;
>   	int tindex = -1;
>   	u32 shunt;
> +	u32 avg;
>   
>   	if (!i2c_check_functionality(client->adapter,
>   				     I2C_FUNC_SMBUS_READ_BYTE_DATA
> @@ -756,6 +757,41 @@ static int adm1275_probe(struct i2c_client *client)
>   		return -ENODEV;
>   	}
>   
> +	if (data->have_power_sampling &&
> +	    of_property_read_u32(client->dev.of_node,
> +				"adi,power-sample-average", &avg) == 0) {
> +		if (avg > ADM1275_SAMPLES_AVG_MAX || avg < 1)
> +			return -EINVAL;
> +		dev_info(&client->dev,
> +			"Setting power sample averaging number to %u",
> +			BIT(ilog2(avg)));
> +		ret = adm1275_write_pmon_config(data, client, true,
> +						ilog2(avg));
> +		if (ret < 0) {
> +			dev_err(&client->dev,
> +				"Setting power sample averaging failed with error %d",
> +				ret);
> +			return ret;
> +		}
> +	}
> +
> +	if (of_property_read_u32(client->dev.of_node,
> +				"adi,volt-curr-sample-average", &avg) == 0) {
> +		if (avg > ADM1275_SAMPLES_AVG_MAX || avg < 1)
> +			return -EINVAL;
> +		dev_info(&client->dev,
> +			"Setting voltage and current sample averaging number to %u",
> +			BIT(ilog2(avg)));

Please no such logging noise. Imagine if everyone would do that -
the log would be full with similar messages.

Thanks,
Guenter

> +		ret = adm1275_write_pmon_config(data, client, false,
> +						ilog2(avg));
> +		if (ret < 0) {
> +			dev_err(&client->dev,
> +				"Setting voltage and current sample averaging failed with error %d",
> +				ret);
> +			return ret;
> +		}
> +	}
> +
>   	if (voindex < 0)
>   		voindex = vindex;
>   	if (vindex >= 0) {

