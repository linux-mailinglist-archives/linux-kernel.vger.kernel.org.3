Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7603C50D3B0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 18:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbiDXQ5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 12:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbiDXQ5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 12:57:09 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8597F30572;
        Sun, 24 Apr 2022 09:54:08 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id z2so14712543oic.6;
        Sun, 24 Apr 2022 09:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hRAH0k2Yx6YMl62m1v8EooRBhKPXrROU9TyI3nKQ9h4=;
        b=pqFKMba01+YQBzDT+GkO1di7psZEsTPAWB+KXe11Zaiu3U4fE5VSs+f4mg4s3uzVLB
         JVRXErrhf6YKDpVBDcF1ENOEZ+8ZQiVAQjaKH8ymMfzdJjIVUY8AQ80D2gl4g5ItXANv
         1LruuPRNB//bZxP+luU2NpvFX8naDllvd4vo3C4VJ0ID+UjQqaBcWXerXco+UMo5hAVf
         VfUBXtwcI7hB45lr3gKHkSeyndcI+N3NXeB/9sZne8O/6bb10zn204w/LUTq2OhmGXk4
         a8bvMtf6esSOLo378VXVQrFL7HGJQJr5MSmAD/QXhp7Ofq6LJcm12MO/xdqQDEbpmF8y
         XF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=hRAH0k2Yx6YMl62m1v8EooRBhKPXrROU9TyI3nKQ9h4=;
        b=a4wV79eTly3J5JO2iyB/Lu4729fx8E2dXGlTgKl1nJTqDN+cHRAYg8HFkpIPx70DuC
         DBm5x1A7JknM96XW6uzTm9kYpQw6W8BgDw1Ih4Mn1ySozLnqZg/rffzaLNwmxwAROeOw
         zEcTPK7yFwa3G0QGOhXjjJHAcLP7LfoOmAzxEE8bJczfqpLky0gRGvQKk79AdEoDQCHP
         30KV0AGPvxjXYlgtUJdY6suFT5UUfX4AuKl/d1gc0at2jQClKH7h4RCzWKAedyiQZiYj
         evEeTvvslh/iRjfnEzPBuxW4NH6Euw3GjuDFt/l7DiagWRQZMrrcRVZF5RLn4TnZ0abJ
         Imtw==
X-Gm-Message-State: AOAM532QvcK0ybZsCmztWUkAK+uf8gn2AlLStRGWxXaL22u7Mkd9ZJ6G
        bsTak9yAUOau6w+rPVYwmZCwjCmRXJ8=
X-Google-Smtp-Source: ABdhPJz+3UIw6L48V+U8cJJeoYzeRquJY0e6WI2ozWbeataP3bgDZ4fQUU96L8oEYqQWWE/6M3IMhg==
X-Received: by 2002:a54:460b:0:b0:322:7964:1b60 with SMTP id p11-20020a54460b000000b0032279641b60mr6424342oip.16.1650819247782;
        Sun, 24 Apr 2022 09:54:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r17-20020a056808211100b00322fbb8bb28sm2796779oiw.57.2022.04.24.09.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 09:54:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 24 Apr 2022 09:54:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] hwmon: (adt7475) Use enum chips when loading
 attenuator settings
Message-ID: <20220424165405.GA748437@roeck-us.net>
References: <20220323034056.260455-1-chris.packham@alliedtelesis.co.nz>
 <20220323034056.260455-4-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323034056.260455-4-chris.packham@alliedtelesis.co.nz>
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

On Wed, Mar 23, 2022 at 04:40:56PM +1300, Chris Packham wrote:
> Make use of enum chips and use a switch statement in load_attenuators()
> so that the compiler can tell us if we've failed to cater for a
> supported chip.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

For my reference:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
> 
> Notes:
>     Changes in v3:
>     - Reword commit message
>     - Use switch instead of if/else
>     Changes in v2:
>     - New
> 
>  drivers/hwmon/adt7475.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
> index 6de501de41b2..ac480e6e4818 100644
> --- a/drivers/hwmon/adt7475.c
> +++ b/drivers/hwmon/adt7475.c
> @@ -1569,12 +1569,12 @@ static int set_property_bit(const struct i2c_client *client, char *property,
>  	return ret;
>  }
>  
> -static int load_attenuators(const struct i2c_client *client, int chip,
> +static int load_attenuators(const struct i2c_client *client, enum chips chip,
>  			    struct adt7475_data *data)
>  {
> -	int ret;
> -
> -	if (chip == adt7476 || chip == adt7490) {
> +	switch (chip) {
> +	case adt7476:
> +	case adt7490:
>  		set_property_bit(client, "adi,bypass-attenuator-in0",
>  				 &data->config4, 4);
>  		set_property_bit(client, "adi,bypass-attenuator-in1",
> @@ -1584,18 +1584,15 @@ static int load_attenuators(const struct i2c_client *client, int chip,
>  		set_property_bit(client, "adi,bypass-attenuator-in4",
>  				 &data->config4, 7);
>  
> -		ret = i2c_smbus_write_byte_data(client, REG_CONFIG4,
> -						data->config4);
> -		if (ret < 0)
> -			return ret;
> -	} else if (chip == adt7473 || chip == adt7475) {
> +		return i2c_smbus_write_byte_data(client, REG_CONFIG4,
> +						 data->config4);
> +	case adt7473:
> +	case adt7475:
>  		set_property_bit(client, "adi,bypass-attenuator-in1",
>  				 &data->config2, 5);
>  
> -		ret = i2c_smbus_write_byte_data(client, REG_CONFIG2,
> -						data->config2);
> -		if (ret < 0)
> -			return ret;
> +		return i2c_smbus_write_byte_data(client, REG_CONFIG2,
> +						 data->config2);
>  	}
>  
>  	return 0;
