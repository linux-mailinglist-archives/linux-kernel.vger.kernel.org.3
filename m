Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA00516A17
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 06:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357685AbiEBEki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 00:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356680AbiEBEka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 00:40:30 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58693ED39;
        Sun,  1 May 2022 21:37:02 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id z8so14271776oix.3;
        Sun, 01 May 2022 21:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3Br+n0K7k+C3+/ovSPrijxX1Bg3JwPDAx3LhT1Kpj2g=;
        b=TCiS84NLvK+JrFbA6TX6NtQYy+yW7yMaYBWXWPLx+H73p5Lt7kUcF508gkiQ7Nj4nu
         eerRo7WxHXpyUkbOnAmBXgGigsOv/NI7HnOEngWp+nMkcY0zgdrqA5riuePMymvxyrBw
         zZJQkVfAxdJqOeKdEONcTVCa5X8O1YDDpqIcvB9o7qiCq6mscQ/JstbL7WszcxpIvILE
         aSh0CnpLHyCgHOQEUknd2SzfIab3UfJb5Df56Yy1U6W81sVhNK3WmjLDQQsjo8y+Iwen
         Ac8YnkPXoyUVs9eSHCySjK2gxWhjO3z7vxA9DmhA48dsc70z6PyjfQFRbg3rs311lYww
         6kHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=3Br+n0K7k+C3+/ovSPrijxX1Bg3JwPDAx3LhT1Kpj2g=;
        b=E29jJvWXVDfEOivey1iwaVHXxtKKkVNDBbP4rwQImvhJ/I9YZZZcLhnE7mOUd1OKQD
         D85xBFFaHg2B4+kRcT94cCpT52H+fQ13QHdwaLxkl2b+2H7Ret6mhhq4lCVfI1dg3FIv
         yvOrdaRP2PSY1aJxF3kzcBCeWkQSVU5f9NlUyZVnIwCw1XpXuaVmgZIJq7Tw9MpT9Suz
         FyJeh/tM+84337VrVtFY38cy63a+5VIWy6fWiAP7etgqfCFdoX/XDlhy5acTbpm6pIcT
         wZI2EX+hWco/63Fj1mGPwSwpI+uUgTM+OCX73fop6ObnLEqAboIanbddV7+ti1xxyQj7
         ETow==
X-Gm-Message-State: AOAM531MEgDsRL36Fzn4huNJUVENhuWJ5NooKIiU3EOLaq+BNXrbPfJQ
        kUqgrT6lPM4sbxoEY2U3chw=
X-Google-Smtp-Source: ABdhPJzgsc7TDcfYAfnEzfTGoGl31PnF5rdBOgRRwX9+taIY+hY8x6NG2jlkaznhgK25o+E710qFEQ==
X-Received: by 2002:aca:5d85:0:b0:325:bf2b:253c with SMTP id r127-20020aca5d85000000b00325bf2b253cmr4856622oib.85.1651466222076;
        Sun, 01 May 2022 21:37:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b3-20020a056870918300b000eb639a5652sm3067377oaf.37.2022.05.01.21.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 21:37:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 1 May 2022 21:37:00 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] hwmon: (adt7475) Use enum chips when loading
 attenuator settings
Message-ID: <20220502043700.GA1719447@roeck-us.net>
References: <20220323034056.260455-1-chris.packham@alliedtelesis.co.nz>
 <20220323034056.260455-4-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323034056.260455-4-chris.packham@alliedtelesis.co.nz>
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

On Wed, Mar 23, 2022 at 04:40:56PM +1300, Chris Packham wrote:
> Make use of enum chips and use a switch statement in load_attenuators()
> so that the compiler can tell us if we've failed to cater for a
> supported chip.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Applied to hwmon-next.

Thanks,
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
