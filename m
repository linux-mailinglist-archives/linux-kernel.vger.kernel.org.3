Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0728956C234
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238758AbiGHTj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 15:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238693AbiGHTj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:39:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E96EB10FC2
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 12:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657309164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KxGqFxRQR4oJiNCtgb+KA18OJIiQLKlXQ2U1quSzXO4=;
        b=TK1R7WYrGA9z85NZAGrZAyMkK94B8O9Ji/V1NMd0WDzABqc8N0ioQSq+blazwWaI9Gvuto
        LbLRJkGYHXsgGN/RmZo3jnik3BXThkewdxjHPgVTqSs2pgUb2e+LStehOy2VKUUWWj/T4C
        jg4PuShbudbuarzfDmc5tZG0m9rmuNk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-kGJ51_H3PRmJ6mvaMpc8Qg-1; Fri, 08 Jul 2022 15:39:22 -0400
X-MC-Unique: kGJ51_H3PRmJ6mvaMpc8Qg-1
Received: by mail-ed1-f70.google.com with SMTP id h17-20020a056402281100b0043aa5c0493dso2426251ede.16
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 12:39:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KxGqFxRQR4oJiNCtgb+KA18OJIiQLKlXQ2U1quSzXO4=;
        b=rv1PRKexTdrqzhMksavzUa4Z/JHjnpX/z9wi0Q0onF9kWVWLExiRubdGgDxNL83vQD
         eyG274JwQLz6vrNPIo0I8w0EsgyBYGB+ulOYvehKNgfQsAXAk0ymvpVI9WQrFu0teBdZ
         4WFUikKytBscc6r5vkiIE8uT08URJPmHw4wGLLYZAhCBF8rPyHQb56pBUNoybwRtSX87
         02S8LTDrfAW99utwKsajtqgXFRGToP9FJ0KIZqtTQCHcd8oH3lMS0KglOrAWt2uxpPsc
         IHM2V2+INpC5goMPv9u/Uew4PJPb3TMIvx/Lgq8rVQHxEoHTs04/3cOZU6IY9c7C8ubQ
         Dy4w==
X-Gm-Message-State: AJIora91PXFsQDC/ieDN+PhFAlNkK7ebDDn+xqmXFk64Gpiirmmn36pD
        Svz3s2mghN+Oppf6yrm9yWmjBdOfnfQYXVm7pDCt4qTktbMjEv4WZ36nrb8SG6kjU+Q4RRNBO5S
        aqBzrFjLg+XBBiNUsgStkveMM
X-Received: by 2002:a17:907:7355:b0:72a:efdc:8245 with SMTP id dq21-20020a170907735500b0072aefdc8245mr5098662ejc.168.1657309161411;
        Fri, 08 Jul 2022 12:39:21 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u2APmFNnX7GyBA8SbRKKbY+1grb6KBUOEXEEeA0NI4es/IDfGe5CyIynaHCgtfXODqFTkjbQ==
X-Received: by 2002:a17:907:7355:b0:72a:efdc:8245 with SMTP id dq21-20020a170907735500b0072aefdc8245mr5098655ejc.168.1657309161263;
        Fri, 08 Jul 2022 12:39:21 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id z10-20020aa7c64a000000b0043a21e3b4a5sm13255832edr.40.2022.07.08.12.39.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 12:39:20 -0700 (PDT)
Message-ID: <37a7e536-252a-c8a9-1412-37d3f2052a6d@redhat.com>
Date:   Fri, 8 Jul 2022 21:39:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] Input: i8042 - add TUXEDO devices to i8042 quirk
 tables for partial fix
Content-Language: en-US
To:     Werner Sembach <wse@tuxedocomputers.com>,
        dmitry.torokhov@gmail.com, tiwai@suse.de, samuel@cavoj.net,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220708161005.1251929-1-wse@tuxedocomputers.com>
 <20220708161005.1251929-3-wse@tuxedocomputers.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220708161005.1251929-3-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
> Setting SERIO_QUIRK_NOMUX or SERIO_QUIRK_RESET_ALWAYS on the Clevo N150CU
> and the Clevo NHxxRZQ makes the keyboard very laggy for ~5 seconds after
> boot and sometimes also after resume. However both are required for the
> keyboard to not fail completely sometimes after boot or resume.

Hmm, the very laggy bit does not sound good. Have you looked into other
solutions, e.g. what happens if you use just nomux without any of the
other 3 options ?

Regards,

Hans


> 
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/input/serio/i8042-x86ia64io.h | 28 +++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
> index 5204a7dd61d4..9dc0266e5168 100644
> --- a/drivers/input/serio/i8042-x86ia64io.h
> +++ b/drivers/input/serio/i8042-x86ia64io.h
> @@ -1107,6 +1107,20 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
>  		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
>  					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
>  	},
> +	{
> +		/*
> +		 * Setting SERIO_QUIRK_NOMUX or SERIO_QUIRK_RESET_ALWAYS makes
> +		 * the keyboard very laggy for ~5 seconds after boot and
> +		 * sometimes also after resume.
> +		 * However both are required for the keyboard to not fail
> +		 * completely sometimes after boot or resume.
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "N150CU"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
> +	},
>  	{
>  		.matches = {
>  			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> @@ -1114,6 +1128,20 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
>  		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
>  					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
>  	},
> +	{
> +		/*
> +		 * Setting SERIO_QUIRK_NOMUX or SERIO_QUIRK_RESET_ALWAYS makes
> +		 * the keyboard very laggy for ~5 seconds after boot and
> +		 * sometimes also after resume.
> +		 * However both are required for the keyboard to not fail
> +		 * completely sometimes after boot or resume.
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "NHxxRZQ"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
> +	},
>  	{
>  		.matches = {
>  			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),

