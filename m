Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D8150EB10
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 23:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245700AbiDYVMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 17:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245738AbiDYVMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 17:12:36 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E086FA12;
        Mon, 25 Apr 2022 14:09:31 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id y27-20020a4a9c1b000000b0032129651bb0so3030161ooj.2;
        Mon, 25 Apr 2022 14:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ocq/1AaEPjmsxW3YG0qAS81tpEvxdC0fDFi5CkuG//A=;
        b=h0pi3L6q45NeX3zgY/5PH74u5EEfidYqsoawOueW5t8QmWuLgdnwCvhlqibCTvP7Bi
         8ARFOmTQ+SHPQoXBDq/J9RHOHa3nNraO/5aNr1n0iFZfSSU9uX8hRnZDoM9/uI9LiGrq
         sKLvs1EZNNZiTepZxlnGcuSrKd79zS14As0bBxifSxL9zXWR9pCDD9q2mKF9ppN5HHlV
         PCEsIFJVx2ZB0RTRBODeVACpF53rUn0bwFsiqbu1hzgpE36wso8/jHcXNBxtonnalz/q
         G2kFsrQkOAKSS2orGXUqL+7p4eJdwwppUWiWJUnrhHRWEm5XW/vfBHlVntSs8FBZgXyT
         UIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Ocq/1AaEPjmsxW3YG0qAS81tpEvxdC0fDFi5CkuG//A=;
        b=ri4svaHpNozBcFOgmkMWt+Cg7c/R19FeNWLj85r23V0CCtWvX650r1nLtbqFHd5phx
         7yFA+H0guvsJjcyVi5/iShmiqXezQFjiy6mcu0HItxt/kx9rcd3CdCG/qt5BovZkI9iN
         bhR3C8YOmNWhC0SEkf39cjWOsHgOdM0/AJjRuRFvf0sR8dovjFWgweZo2y/5qjU/xHVR
         Zcl1VvJyDv9HBCSJVbz7odwZ1rfd6R0eABZy5jAZDlWks9WyhLyUyqj1UjYoiLmbuLSo
         eW9MLoxznaLQKZRVgyJiSWub0nL4CizVmclLvg9FQFmS0ljtOWXfi3Qwxwe+rE8kbVNZ
         WpJw==
X-Gm-Message-State: AOAM532f2w3rh9LpgTEMVTyDrtvDi58zUOyTQkU3iqdp1oPxgRLQFWdD
        TiCHqSxNWq58AmJkOe3AlUc=
X-Google-Smtp-Source: ABdhPJypKjn/nHTDqfcBoRBfWeVMhyKZa9XE2BwVZBxp470xIfcDj15/+vmghEJmNRF9ycmkDNMOBw==
X-Received: by 2002:a4a:2a4c:0:b0:35e:7e88:7850 with SMTP id x12-20020a4a2a4c000000b0035e7e887850mr1014254oox.39.1650920971192;
        Mon, 25 Apr 2022 14:09:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id eb25-20020a056870a89900b000e686d13881sm117574oab.27.2022.04.25.14.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 14:09:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 25 Apr 2022 14:09:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] hwmon: (lm75) Add Atmel AT30TS74 support
Message-ID: <20220425210928.GA4184327@roeck-us.net>
References: <ea4cd16b-4a04-8857-d08a-53be58b00d28@axentia.se>
 <9494dfbc-f506-3e94-501d-6760c487c93d@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9494dfbc-f506-3e94-501d-6760c487c93d@axentia.se>
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

On Mon, Apr 25, 2022 at 10:35:50PM +0200, Peter Rosin wrote:
> Atmel (now Microchip) AT30TS74 is an LM75 compatible sensor. Add it.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/Kconfig |  1 +
>  drivers/hwmon/lm75.c  | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 68a8a27ab3b7..d8dc58b2c55a 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1248,6 +1248,7 @@ config SENSORS_LM75
>  	  temperature sensor chip, with models including:
>  
>  		- Analog Devices ADT75
> +		- Atmel (now Microchip) AT30TS74
>  		- Dallas Semiconductor DS75, DS1775 and DS7505
>  		- Global Mixed-mode Technology (GMT) G751
>  		- Maxim MAX6625 and MAX6626
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index afdbb63237b9..66dc826f7962 100644
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -26,6 +26,7 @@
>  
>  enum lm75_type {		/* keep sorted in alphabetical order */
>  	adt75,
> +	at30ts74,
>  	ds1775,
>  	ds75,
>  	ds7505,
> @@ -128,6 +129,14 @@ static const struct lm75_params device_params[] = {
>  		.default_resolution = 12,
>  		.default_sample_time = MSEC_PER_SEC / 10,
>  	},
> +	[at30ts74] = {
> +		.set_mask = 3 << 5,	/* 12-bit mode*/
> +		.default_resolution = 12,
> +		.default_sample_time = 200,
> +		.num_sample_times = 4,
> +		.sample_times = (unsigned int []){ 25, 50, 100, 200 },
> +		.resolutions = (u8 []) {9, 10, 11, 12 },
> +	},
>  	[ds1775] = {
>  		.clr_mask = 3 << 5,
>  		.set_mask = 2 << 5,	/* 11-bit mode */
> @@ -645,6 +654,7 @@ static int lm75_probe(struct i2c_client *client)
>  
>  static const struct i2c_device_id lm75_ids[] = {
>  	{ "adt75", adt75, },
> +	{ "at30ts74", at30ts74, },
>  	{ "ds1775", ds1775, },
>  	{ "ds75", ds75, },
>  	{ "ds7505", ds7505, },
> @@ -680,6 +690,10 @@ static const struct of_device_id __maybe_unused lm75_of_match[] = {
>  		.compatible = "adi,adt75",
>  		.data = (void *)adt75
>  	},
> +	{
> +		.compatible = "atmel,at30ts74",
> +		.data = (void *)at30ts74
> +	},
>  	{
>  		.compatible = "dallas,ds1775",
>  		.data = (void *)ds1775
