Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA2F50D3AE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 18:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236004AbiDXQ4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 12:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235903AbiDXQ4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 12:56:16 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEBF2FFF1;
        Sun, 24 Apr 2022 09:53:15 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-d39f741ba0so13806407fac.13;
        Sun, 24 Apr 2022 09:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TJIgBSDmAXW4QL5uLcDUK6BDrhPYWOpK0Qh4mgX0XVc=;
        b=V/yFvwAFY+86HR6bvmBn9XBfNeoSfntg4lZoJcbo+GJQ+XJrAajeNG//Spirc1szOk
         PDaF3d2cfGNjmBH9T7+eYbKsgkPfKM6uUgiduIyv9s9sK+lED4bVMP5UwD2CZv6M0jJN
         v3/aQ76ErLQkJy0CCfl+1ogMCEpx3H8FjDcy0ZVRd4JhUq6VonpT8HaRtDwgdfzsPzAI
         NX+nd3hH5zW4TvhOLZKpDQWDehgf9DPfYD+ceiQvT8WRlLFmtGaXEft+yKRlMxXtXuaV
         QnbLAEcgXqVLnSA69A13Awnurk4Agwo7PVYRnWTtoYE20lzz5Bhc8pFc908h2QDn19R5
         AaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=TJIgBSDmAXW4QL5uLcDUK6BDrhPYWOpK0Qh4mgX0XVc=;
        b=OzAcbJFkXGMNV4xwVtVQkPkjDTtDpRIqzb+47kMhTY+N4DZEYcD2+vR3BqWLSP6L4k
         QEgKJOSFoPxAvHbA0N198Z3etqBV2fih94u+PaIO1soTXIbuHC8UnrXxSB+T+IQHYIYu
         ClSoYKrurSL/Hg33a1p91hgP4MEGZELaBHnjgsYE7F+84e0Fmydj+K8RMJ4y45uPOjdo
         O0VUeI4t5xjmOhk9P32yegM0ygAb12aX/oi9xpEWBZhxYBpnE5xA4WD93Xai+4d7Ev65
         0h8bHVnFp2gSu1k00ajZ2aL9S3GlsLoU4bkrr/acCU7lxiiisTeGhogeH63SwxlQvdYi
         uOKw==
X-Gm-Message-State: AOAM5300Ek5VEKYviUcJC87lVUSqF+/EjbEPy/8y3rD7H8V9bxuwian9
        famwBLihwgRug5SL3nA1Ise78+WX5Bc=
X-Google-Smtp-Source: ABdhPJwzjpLgb5XuI8IUkx5+/c43SLQEvSe3uChTQ428Nk9S+7fYIfJIfQxdqRFjEP/W5ghrrG+2Eg==
X-Received: by 2002:a05:6870:c59a:b0:e9:3d37:1bbd with SMTP id ba26-20020a056870c59a00b000e93d371bbdmr754959oab.91.1650819194791;
        Sun, 24 Apr 2022 09:53:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z2-20020a05683020c200b00604cd00f91esm2962228otq.44.2022.04.24.09.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 09:53:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 24 Apr 2022 09:53:12 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] hwmon: (adt7475) Add support for pin configuration
Message-ID: <20220424165312.GA748365@roeck-us.net>
References: <20220323034056.260455-1-chris.packham@alliedtelesis.co.nz>
 <20220323034056.260455-3-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323034056.260455-3-chris.packham@alliedtelesis.co.nz>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 04:40:55PM +1300, Chris Packham wrote:
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

For my reference:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Notes:
>     Changes in v3:
>     - None
>     Changes in v2:
>     - Use load_config{3,4} instead of load_pin{10,14}_config
>     - Handle errors from adt7475_read()
>     - Remove obsolete check on chip type
>     - Use enum chips instead of int
>     - Update error messages
> 
>  drivers/hwmon/adt7475.c | 96 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
> 
> diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
> index 9d5b019651f2..6de501de41b2 100644
> --- a/drivers/hwmon/adt7475.c
> +++ b/drivers/hwmon/adt7475.c
> @@ -112,6 +112,8 @@
>  #define CONFIG3_THERM		0x02
>  
>  #define CONFIG4_PINFUNC		0x03
> +#define CONFIG4_THERM		0x01
> +#define CONFIG4_SMBALERT	0x02
>  #define CONFIG4_MAXDUTY		0x08
>  #define CONFIG4_ATTN_IN10	0x30
>  #define CONFIG4_ATTN_IN43	0xC0
> @@ -1460,6 +1462,96 @@ static int adt7475_update_limits(struct i2c_client *client)
>  	return 0;
>  }
>  
> +static int load_config3(const struct i2c_client *client, const char *propname)
> +{
> +	const char *function;
> +	u8 config3;
> +	int ret;
> +
> +	ret = of_property_read_string(client->dev.of_node, propname, &function);
> +	if (!ret) {
> +		ret = adt7475_read(REG_CONFIG3);
> +		if (ret < 0)
> +			return ret;
> +
> +		config3 = ret & ~CONFIG3_SMBALERT;
> +		if (!strcmp("pwm2", function))
> +			;
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
> +static int load_config4(const struct i2c_client *client, const char *propname)
> +{
> +	const char *function;
> +	u8 config4;
> +	int ret;
> +
> +	ret = of_property_read_string(client->dev.of_node, propname, &function);
> +	if (!ret) {
> +		ret = adt7475_read(REG_CONFIG4);
> +		if (ret < 0)
> +			return ret;
> +
> +		config4 = ret & ~CONFIG4_PINFUNC;
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
> +static int load_config(const struct i2c_client *client, enum chips chip)
> +{
> +	int err;
> +	const char *prop1, *prop2;
> +
> +	switch (chip) {
> +	case adt7473:
> +	case adt7475:
> +		prop1 = "adi,pin5-function";
> +		prop2 = "adi,pin9-function";
> +		break;
> +	case adt7476:
> +	case adt7490:
> +		prop1 = "adi,pin10-function";
> +		prop2 = "adi,pin14-function";
> +		break;
> +	}
> +
> +	err = load_config3(client, prop1);
> +	if (err) {
> +		dev_err(&client->dev, "failed to configure %s\n", prop1);
> +		return err;
> +	}
> +
> +	err = load_config4(client, prop2);
> +	if (err) {
> +		dev_err(&client->dev, "failed to configure %s\n", prop2);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
>  static int set_property_bit(const struct i2c_client *client, char *property,
>  			    u8 *config, u8 bit_index)
>  {
> @@ -1585,6 +1677,10 @@ static int adt7475_probe(struct i2c_client *client)
>  		revision = adt7475_read(REG_DEVID2) & 0x07;
>  	}
>  
> +	ret = load_config(client, chip);
> +	if (ret)
> +		return ret;
> +
>  	config3 = adt7475_read(REG_CONFIG3);
>  	/* Pin PWM2 may alternatively be used for ALERT output */
>  	if (!(config3 & CONFIG3_SMBALERT))
