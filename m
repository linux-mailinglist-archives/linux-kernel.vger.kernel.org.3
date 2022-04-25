Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE28150E847
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244424AbiDYScs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244280AbiDYScq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:32:46 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830E5126340;
        Mon, 25 Apr 2022 11:29:41 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-e67799d278so13172646fac.11;
        Mon, 25 Apr 2022 11:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3nXayCuus+0Y6qgslSzmhxQ64gNyfx3yJnoJIyHNR1s=;
        b=FIINtMByAR9bcyXh9qSk8x7cRJ/2lmzbYJGFnLzVKMGf1bzFO5TdXuN34WyMCslbwC
         Yo+2532aBO9Y70fsT9wu5qqKWdrrv2SWrrdb0BqJ+C1y/YuZOQUf6MVqDFyFMuC4OmyJ
         HkKNE9tOI/dpZseL55FW6+oLfklH8+sKXdhFagUkf500X03eijt/ohLrz1bbHXox/XGw
         7GlAm19x+Lb2/9SlnUPBZlpkP+MA/iAniXjf7zMk044bTx4VQr8Bc6dAGEtK7afMCDkG
         yCzyedEEihmiPh16l8SwZVJxnAfEQQIakRsFpgfQ8MMnRPbHri6Uwwnni7GOEVt8SfV0
         A/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=3nXayCuus+0Y6qgslSzmhxQ64gNyfx3yJnoJIyHNR1s=;
        b=rAwIXbi5n/aQI6wkPmjDdwVFSWDAP4WfsXpcaEtxMnLI84rSVlJNs8NKa3zBFrSIC9
         dObQpjDRLf1rCgUoJCdGWcltJUrebB6QaMfsPRVV8l+M6DDAnpqHGpMGqN7wkhFG29VP
         2rcEWEZOAAfo3mabc3n+lnfZJrt4l3TrWn4tv2dPpiAfC1Ziw9e/3WOqnoMvEJnbsecw
         LxmYiMzY1GxZ2/H0WTdDfwGcdIcYuFrK4Z7LWGjZnuzRXMbNRC3jVUCIfFk6EYJVELZ8
         IZdSxQSgEuOu/aVrwdop5fmCZBsQb9D5Wp1FfFtJJfoozrDIUvOCZG/z4GSAVfWwftwE
         ai/w==
X-Gm-Message-State: AOAM531WQmhGGFqRfMw1VQ6ZMUit2E08cd5rdm6TXWq9AQrJ/6cXmR03
        dbov8ilf1UUf7pVRvLAattVBuu8g7fE=
X-Google-Smtp-Source: ABdhPJz0XMNoSwdLCNXkq7XgZ5bmm+FFHPuBtSBnKyin5S+OUlxW5flluKYmtNQrG9yfIRLAa9bCHg==
X-Received: by 2002:a05:6870:2053:b0:e9:3c2f:23d9 with SMTP id l19-20020a056870205300b000e93c2f23d9mr2889907oad.158.1650911380851;
        Mon, 25 Apr 2022 11:29:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id cr15-20020a056870ebcf00b000e912a7b843sm2710470oab.6.2022.04.25.11.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 11:29:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 25 Apr 2022 11:29:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (lm75) Add Atmel AT30TS74 support
Message-ID: <20220425182938.GA4176298@roeck-us.net>
References: <e4c15f1c-b2a3-4371-d2de-8205d3dfe972@axentia.se>
 <7160dc31-1429-1206-ec4b-1d8cc0652b27@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7160dc31-1429-1206-ec4b-1d8cc0652b27@axentia.se>
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

Peter,

On Mon, Apr 25, 2022 at 07:59:18AM +0200, Peter Rosin wrote:
> Atmel (now Microchip) AT30TS74 is an LM75 compatible sensor. Add it.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

This and the previous patch of the series fail to apply with

error: patch failed: drivers/hwmon/Kconfig:1248
error: drivers/hwmon/Kconfig: patch does not apply
error: patch failed: drivers/hwmon/lm75.c:26
error: drivers/hwmon/lm75.c: patch does not apply
error: Did you hand edit your patch?
It does not apply to blobs recorded in its index.

when I try to apply with "git am -s -3".

This is probably because MS Exchange tries to be intelligent.
In the first patch, it added a space at the beginning of each
unchanged line. It looks like it did the same or something
similar here. I tried but failed to fix it up.

Please resend as clean patch.

Thanks,
Guenter

> ---
>   drivers/hwmon/Kconfig |  1 +
>   drivers/hwmon/lm75.c  | 14 ++++++++++++++
>   2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 68a8a27ab3b7..d8dc58b2c55a 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1248,6 +1248,7 @@ config SENSORS_LM75
>   	  temperature sensor chip, with models including:
>   
>   		- Analog Devices ADT75
> +		- Atmel (now Microchip) AT30TS74
>   		- Dallas Semiconductor DS75, DS1775 and DS7505
>   		- Global Mixed-mode Technology (GMT) G751
>   		- Maxim MAX6625 and MAX6626
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index afdbb63237b9..66dc826f7962 100644
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -26,6 +26,7 @@
>   
>   enum lm75_type {		/* keep sorted in alphabetical order */
>   	adt75,
> +	at30ts74,
>   	ds1775,
>   	ds75,
>   	ds7505,
> @@ -128,6 +129,14 @@ static const struct lm75_params device_params[] = {
>   		.default_resolution = 12,
>   		.default_sample_time = MSEC_PER_SEC / 10,
>   	},
> +	[at30ts74] = {
> +		.set_mask = 3 << 5,	/* 12-bit mode*/
> +		.default_resolution = 12,
> +		.default_sample_time = 200,
> +		.num_sample_times = 4,
> +		.sample_times = (unsigned int []){ 25, 50, 100, 200 },
> +		.resolutions = (u8 []) {9, 10, 11, 12 },
> +	},
>   	[ds1775] = {
>   		.clr_mask = 3 << 5,
>   		.set_mask = 2 << 5,	/* 11-bit mode */
> @@ -645,6 +654,7 @@ static int lm75_probe(struct i2c_client *client)
>   
>   static const struct i2c_device_id lm75_ids[] = {
>   	{ "adt75", adt75, },
> +	{ "at30ts74", at30ts74, },
>   	{ "ds1775", ds1775, },
>   	{ "ds75", ds75, },
>   	{ "ds7505", ds7505, },
> @@ -680,6 +690,10 @@ static const struct of_device_id __maybe_unused lm75_of_match[] = {
>   		.compatible = "adi,adt75",
>   		.data = (void *)adt75
>   	},
> +	{
> +		.compatible = "atmel,at30ts74",
> +		.data = (void *)at30ts74
> +	},
>   	{
>   		.compatible = "dallas,ds1775",
>   		.data = (void *)ds1775
