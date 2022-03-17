Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835B84DC794
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 14:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbiCQNaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 09:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiCQNaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 09:30:14 -0400
Received: from gateway20.websitewelcome.com (gateway20.websitewelcome.com [192.185.66.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D88811DD31
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 06:28:56 -0700 (PDT)
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id A7ACD400F00CC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 08:28:55 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id UqBTnuieKRnrrUqBTnO8Jg; Thu, 17 Mar 2022 08:28:55 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZWlDpJ1jKpFqrvBTDx/wTo26QSvpgwcabfkWM+NH5jc=; b=R+oy9LMWd0I1peoGYqliO/5hmz
        wQqYKKAVATe4jzNwfnXWcwcUxsK0iayujfDu1DhAGbkcKuxcxG3BcuxhoF2Ldd6DhJAsI1nHogiiR
        ELc5oE2J0AeM4kDEOB9RPoZ2seXSgtglbrfhqJIZJ64KuzGW2ThqK9OJAgeOyXfTMrQWszVUlrT5r
        ID3MpjXQetLxRMQDbS3PXtxw+5ialhhJvcaaWGzYhXJ95GUW47CsxYQGkyv0fZAUHJemZuYLRIl9j
        2f9s731PyYBEL8MXToAMGABS1V+9PXMPixVTFMKDpebGr+TGNe8wUDmA5ZnR2apweiycHaieGTyLQ
        HWsKB0Vg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54312)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nUqBT-003zon-5m; Thu, 17 Mar 2022 13:28:55 +0000
Message-ID: <6aabb517-c46e-bcf8-c93d-b6fa1fe8eb3a@roeck-us.net>
Date:   Thu, 17 Mar 2022 06:28:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        jdelvare@suse.com, robh+dt@kernel.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220316234134.290492-1-chris.packham@alliedtelesis.co.nz>
 <20220316234134.290492-3-chris.packham@alliedtelesis.co.nz>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2] hwmon: (adt7475) Add support for pin configuration
In-Reply-To: <20220316234134.290492-3-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nUqBT-003zon-5m
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54312
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 1
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/22 16:41, Chris Packham wrote:
> The adt7473, adt7475, adt7476 and adt7490 have pins that can be used for
> different functions. On the adt7473 and  adt7475 this is pins 5 and 9.
> On the adt7476 and adt7490 this is pins 10 and 14.
> 
> The first pin can either be PWM2(default) or SMBALERT#. The second pin
> can be TACH4(default), THERM#, SMBALERT# or GPIO.
> 
> The adt7475 driver has always been able to detect the configuration if
> it had been done by an earlier boot stage. Add support for configuring
> the pins based on the hardware description in the device tree.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>   drivers/hwmon/adt7475.c | 95 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 95 insertions(+)
> 
> diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
> index 9d5b019651f2..ad5e5a7a844b 100644
> --- a/drivers/hwmon/adt7475.c
> +++ b/drivers/hwmon/adt7475.c
> @@ -112,6 +112,8 @@
>   #define CONFIG3_THERM		0x02
>   
>   #define CONFIG4_PINFUNC		0x03
> +#define CONFIG4_THERM		0x01
> +#define CONFIG4_SMBALERT	0x02
>   #define CONFIG4_MAXDUTY		0x08
>   #define CONFIG4_ATTN_IN10	0x30
>   #define CONFIG4_ATTN_IN43	0xC0
> @@ -1460,6 +1462,95 @@ static int adt7475_update_limits(struct i2c_client *client)
>   	return 0;
>   }
>   
> +static int load_pin10_config(const struct i2c_client *client, const char *propname)
> +{

A better function name would probably be load_config3() or similar.

> +	const char *function;
> +	u8 config3;
> +	int err;
> +
> +	err = of_property_read_string(client->dev.of_node, propname, &function);
> +	if (!err) {
> +		config3 = adt7475_read(REG_CONFIG3);

error check missing (I see the driver is notorious for that, but that is not
a reason to keep doing it).

> +
> +		if (!strcmp("pwm2", function))
> +			config3 &= ~CONFIG3_SMBALERT;
> +		else if (!strcmp("smbalert#", function))
> +			config3 |= CONFIG3_SMBALERT;
> +		else
> +			return -EINVAL;
> +
> +		return i2c_smbus_write_byte_data(client, REG_CONFIG3, config3);
> +	}
> +
> +	return 0;
> +}
> +
> +static int load_pin14_config(const struct i2c_client *client, const char *propname)
> +{

load_config4() ?

> +	const char *function;
> +	u8 config4;
> +	int err;
> +
> +	err = of_property_read_string(client->dev.of_node, propname, &function);
> +	if (!err) {
> +		config4 = adt7475_read(REG_CONFIG4);

error check

> +		config4 &= ~CONFIG4_PINFUNC;
> +
> +		if (!strcmp("tach4", function))
> +			;
> +		else if (!strcmp("therm#", function))
> +			config4 |= CONFIG4_THERM;
> +		else if (!strcmp("smbalert#", function))
> +			config4 |= CONFIG4_SMBALERT;
> +		else if (!strcmp("gpio", function))
> +			config4 |= CONFIG4_PINFUNC;
> +		else
> +			return -EINVAL;
> +
> +		return i2c_smbus_write_byte_data(client, REG_CONFIG4, config4);
> +	}
> +
> +	return 0;
> +}
> +
> +static int load_config(const struct i2c_client *client, int chip)
> +{
> +	int err;
> +	const char *conf_prop1, *conf_prop2;

conf_ prefix is unnecessary.

> +
> +	switch (chip) {
> +	case adt7473:
> +	case adt7475:
> +		conf_prop1 = "adi,pin5-function";
> +		conf_prop2 = "adi,pin9-function";
> +		break;
> +	case adt7476:
> +	case adt7490:
> +		conf_prop1 = "adi,pin10-function";
> +		conf_prop2 = "adi,pin14-function";
> +		break;
> +	default:
> +		return -EINVAL;

It doesn't seem right to return -EINVAL here.

> +	}
> +
> +	if (chip != adt7476 && chip != adt7490)
> +		return 0;
> +

Why not check this first, and what is the point of assigning values to
conf_prop1 and conf_prop2 for the other chips in the case statement above
only to return 0 here ? It would be much simpler to drop the other chips
from the case statement and have default: return 0.

> +	err = load_pin10_config(client, conf_prop1);
> +	if (err) {
> +		dev_err(&client->dev, "failed to configure PIN10\n");

The messages are misleading. This isn't always pin 10/14.

> +		return err;
> +	}
> +
> +	err = load_pin14_config(client, conf_prop2);
> +	if (err) {
> +		dev_err(&client->dev, "failed to configure PIN14\n");
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
>   static int set_property_bit(const struct i2c_client *client, char *property,
>   			    u8 *config, u8 bit_index)
>   {
> @@ -1585,6 +1676,10 @@ static int adt7475_probe(struct i2c_client *client)
>   		revision = adt7475_read(REG_DEVID2) & 0x07;
>   	}
>   
> +	ret = load_config(client, chip);
> +	if (ret)
> +		return ret;
> +
>   	config3 = adt7475_read(REG_CONFIG3);
>   	/* Pin PWM2 may alternatively be used for ALERT output */
>   	if (!(config3 & CONFIG3_SMBALERT))

