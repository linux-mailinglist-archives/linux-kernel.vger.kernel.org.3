Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685EA56C34A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239934AbiGHTi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 15:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239863AbiGHTiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:38:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E57BB6D578
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 12:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657309099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I/fg/wntNEY1kq+343fpO5iPvcPnrKxiR+Qi8P8PYVs=;
        b=TvjDPGILK5V/5v7f7s1SmqaTnz9m1GCC9w+1HcHKPaP2W3tZAf6lofOnpSmb4M5hczWWJv
        gC5WI+mMlOh0r6XQc4HP+hlMek59WClaxrbO5Ld10upQBaNRnrtxaH9A0xqaT+/wgpjW89
        6CesbRWN/XO3pJ3aWSQPxpYvOEm3rmM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-287-3ES6rKvMNcOOwiA-rQra4g-1; Fri, 08 Jul 2022 15:38:17 -0400
X-MC-Unique: 3ES6rKvMNcOOwiA-rQra4g-1
Received: by mail-ej1-f69.google.com with SMTP id go10-20020a1709070d8a00b00722e8ee15b4so6055982ejc.22
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 12:38:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=I/fg/wntNEY1kq+343fpO5iPvcPnrKxiR+Qi8P8PYVs=;
        b=WVIcws4CHNlrYudEl5cTrCSNXpLYKzQmCX4kT558x3bs1txWxFCUtQ7dWYKzVU9DCk
         6hQMkE2P3v2YoAH8Hb5gSqcCtV07AyB97A0sd1oTTRxso/lJ/ESihKiuPzu06M/ZEejH
         CXAvoRCLmdLT0tktBF+0zY0SlXARFveynkn8nWyOqdM3dWrxg1S5Ros6QRhjsgRznQWr
         8VTntH70CLktdsK9bRNwbk0QKu6EwVV/SYXfIe/vQhP/A44y9uk6Uw9L5U2ZqRgtYBKs
         5nEzgJtVNdiRfSlpzoMnkduMGswLxifxovva88NjypBrKpkciH85BaAbtw/XBeqQKetQ
         6u0w==
X-Gm-Message-State: AJIora9GOPHZ8T+PQvjHPjn21UME/GKF2QdyZqVZQTBXq/DImNMAlO8F
        r6X1sJ5OxX6+VmxrlTEfwE0K2waNzRirG8eNE0l+sKgBdDe59O5FGGTvl+V8SmYN2yII9Yc9+6k
        I7ughiHfZQqADCc8bNyjOvApn
X-Received: by 2002:a17:907:948a:b0:726:f3d7:c7d6 with SMTP id dm10-20020a170907948a00b00726f3d7c7d6mr5290260ejc.2.1657309096348;
        Fri, 08 Jul 2022 12:38:16 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sCCSDFps99TjKBXzzWRK5i66gIcDvLqD95+yoAlvGeBxu6kR6LIrmz7hRdDgKZ4ZdNnRvlJA==
X-Received: by 2002:a17:907:948a:b0:726:f3d7:c7d6 with SMTP id dm10-20020a170907948a00b00726f3d7c7d6mr5290243ejc.2.1657309096163;
        Fri, 08 Jul 2022 12:38:16 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id t27-20020a17090616db00b0071cbc7487e1sm20530641ejd.69.2022.07.08.12.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 12:38:15 -0700 (PDT)
Message-ID: <69df97d3-81ca-83d2-b9c9-fee2033b6877@redhat.com>
Date:   Fri, 8 Jul 2022 21:38:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/2] Input: i8042 - add additional TUXEDO devices to i8042
 quirk tables
Content-Language: en-US
To:     Werner Sembach <wse@tuxedocomputers.com>,
        dmitry.torokhov@gmail.com, tiwai@suse.de, samuel@cavoj.net,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220708161005.1251929-1-wse@tuxedocomputers.com>
 <20220708161005.1251929-2-wse@tuxedocomputers.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220708161005.1251929-2-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/8/22 18:10, Werner Sembach wrote:
> A lot of modern Clevo barebones have touchpad and/or keyboard issues after
> suspend fixable with nomux + reset + noloop + nopnp. Luckily, none of them
> have an external PS/2 port so this can safely be set for all of them.
> 
> I'm not entirely sure if every device listed really needs all four quirks,
> but after testing and production use. No negative effects could be
> observed when setting all four.
> 
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: stable@vger.kernel.org

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/input/serio/i8042-x86ia64io.h | 76 ++++++++++++++++++++++++---
>  1 file changed, 68 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
> index 50b090e77fca..5204a7dd61d4 100644
> --- a/drivers/input/serio/i8042-x86ia64io.h
> +++ b/drivers/input/serio/i8042-x86ia64io.h
> @@ -900,14 +900,6 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
>  		},
>  		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
>  	},
> -	{
> -		/* Clevo P650RS, 650RP6, Sager NP8152-S, and others */
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "P65xRP"),
> -		},
> -		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
> -	},
>  	{
>  		/* OQO Model 01 */
>  		.matches = {
> @@ -1162,6 +1154,74 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
>  		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
>  					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
>  	},
> +	{
> +		/*
> +		 * This is only a partial board_name and might be followed by
> +		 * another letter or number. DMI_MATCH however does do partial
> +		 * matching.
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "P65xH"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
> +	},
> +	{
> +		/* Clevo P650RS, 650RP6, Sager NP8152-S, and others */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "P65xRP"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
> +	},
> +	{
> +		/*
> +		 * This is only a partial board_name and might be followed by
> +		 * another letter or number. DMI_MATCH however does do partial
> +		 * matching.
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "P65_P67H"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
> +	},
> +	{
> +		/*
> +		 * This is only a partial board_name and might be followed by
> +		 * another letter or number. DMI_MATCH however does do partial
> +		 * matching.
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "P65_67RP"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
> +	},
> +	{
> +		/*
> +		 * This is only a partial board_name and might be followed by
> +		 * another letter or number. DMI_MATCH however does do partial
> +		 * matching.
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "P65_67RS"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
> +	},
> +	{
> +		/*
> +		 * This is only a partial board_name and might be followed by
> +		 * another letter or number. DMI_MATCH however does do partial
> +		 * matching.
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "P67xRP"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
> +	},
>  	{
>  		.matches = {
>  			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),

