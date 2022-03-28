Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E71B4E9643
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 14:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242317AbiC1MM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 08:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbiC1MMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:12:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D49EF4616F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648469444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s303ye8ReaHpOjOwx4Ovn/6MsJxh1EGbGaKLyFHGIYc=;
        b=AEUemNLXrl8Nj+ky8+n+NU8L1v7l0OyCGPOUKT6Z16om2F3IHmoxaJrv09s/a2j9WvI1gV
        ZS0ZJlO93NDpQBvIPqAKwGrUOW4WIhYHCuLB0DSOVYkRiYxOkdxMZmF0VwrdQt88PpkQwe
        I2HTpfZRifFoEozpYUC6NLDDuMRMs98=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-7ubu0SQSO3uXn6GXIYoOJw-1; Mon, 28 Mar 2022 08:10:42 -0400
X-MC-Unique: 7ubu0SQSO3uXn6GXIYoOJw-1
Received: by mail-ej1-f69.google.com with SMTP id hz15-20020a1709072cef00b006dfeceff2d1so6717980ejc.17
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=s303ye8ReaHpOjOwx4Ovn/6MsJxh1EGbGaKLyFHGIYc=;
        b=cPCddrsnQs3PDHcnTKzNijguJnvs3o9qg0tqqSYgmnsWVaJlrnS6cZMQvEtxUstMOI
         4g6fEyFn+3cLxAao4+ec6bx472JY+7h9wbx8/qmEgfcoJtjcL8XPG+X8ZwXUF++vlU/e
         SyLflYmu+jLzWJhs+kXCwuJslMsnVZjSte65EK3MLug3ZHjCwor5FhMgZJSYK7sWemyx
         guev6feoXfkmDKHufPOUhbqet5G6+JMC1UPy7G2pCrmaeM6cYKAoCzv8UPaaceCBCoIE
         rgvQb9YPvH0n5gSVCY0+k/nf6mpycKaMszYNHNviOhiZB5ZW3cTIx83ABvy0xSOFjW+U
         ZeOA==
X-Gm-Message-State: AOAM531hpd+jwrq4Z1fvBMNChu25twuTncp89cZE3oCkQ9I5Ui8tR0g/
        1QRhnZcPBf2Fuw/IKNCvHnFhpM4SW6Tl0gJb5l08ZO3ahBzy/4wWGyYzbogjSbLQ1HDZdC4lB8M
        hMUYzxWkCJTr0WRdLEaSK4H07
X-Received: by 2002:a05:6402:100e:b0:416:596a:2581 with SMTP id c14-20020a056402100e00b00416596a2581mr16031726edu.181.1648469441218;
        Mon, 28 Mar 2022 05:10:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrfXpfh65G/q1+H74AqsjWFo6tjp7o+o0GjPWQPjGlzS/vEbHIzRwXZ5f+MmkREIDWc/eIdg==
X-Received: by 2002:a05:6402:100e:b0:416:596a:2581 with SMTP id c14-20020a056402100e00b00416596a2581mr16031688edu.181.1648469440977;
        Mon, 28 Mar 2022 05:10:40 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id m25-20020a170906161900b006d43be5b95fsm5887532ejd.118.2022.03.28.05.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 05:10:40 -0700 (PDT)
Message-ID: <810c9b35-1f8b-912c-9300-f57fb0b2f60c@redhat.com>
Date:   Mon, 28 Mar 2022 14:10:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 4/4] input/i8042: Add TUXEDO devices to i8042 quirk
 tables
Content-Language: en-US
To:     Werner Sembach <wse@tuxedocomputers.com>,
        dmitry.torokhov@gmail.com, tiwai@suse.de, mpdesouza@suse.com,
        arnd@arndb.de, samuel@cavoj.net, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220322162125.59838-1-wse@tuxedocomputers.com>
 <20220322162125.59838-5-wse@tuxedocomputers.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220322162125.59838-5-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/22/22 17:21, Werner Sembach wrote:
> A lot of modern Clevo barebones have touchpad and/or keyboard issues after
> suspend fixable with nomux + reset + noloop + nopnp. Luckily, none of them
> have an external PS/2 port so this can safely be set for all of them.
> 
> I'm not entirely sure if every device listed really needs all four quirks,
> but after testing and production use. No negative effects could be
> observed when setting all four.
> 
> In this 4th revision the list is reduced by only identifying the devices by
> board_name. This avoids a lot of duplication because of inconsistent and/or
> reseller specific values of board_vendor and/or system_vendor. This change
> is based on Dmitry Torokhovs mention that Clevos default "Notebook" string
> doesn't add much uniqueness anyhow.
> 
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: stable@vger.kernel.org

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/input/serio/i8042-x86ia64io.h | 125 ++++++++++++++++++++++++++
>  1 file changed, 125 insertions(+)
> 
> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
> index 229d4936910f..f79b5eea1295 100644
> --- a/drivers/input/serio/i8042-x86ia64io.h
> +++ b/drivers/input/serio/i8042-x86ia64io.h
> @@ -1095,6 +1095,25 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
>  		},
>  		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
>  	},
> +	/*
> +	 * A lot of modern Clevo barebones have touchpad and/or keyboard issues
> +	 * after suspend fixable with nomux + reset + noloop + nopnp. Luckily,
> +	 * none of them have an external PS/2 port so this can savely be set for
> +	 * all of them. These two are based on a Clevo design, but have the
> +	 * board_name changed.
> +	 */
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "AURA1501"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "EDUBOOK1502"),
> +		},
> +	},
>  	{
>  		/* Mivvy M310 */
>  		.matches = {
> @@ -1124,6 +1143,112 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
>  		},
>  		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
>  	},
> +	/*
> +	 * A lot of modern Clevo barebones have touchpad and/or keyboard issues
> +	 * after suspend fixable with nomux + reset + noloop + nopnp. Luckily,
> +	 * none of them have an external PS/2 port so this can savely be set for
> +	 * all of them.
> +	 * Clevo barebones come with board_vendor and/or system_vendor set to
> +	 * either the very generic string "Notebook" and/or a different value
> +	 * for each individual reseller. The only somewhat universal way to
> +	 * identify them is by board_name.
> +	 */
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
> +	},
> +	/*
> +	 * At least one modern Clevo barebone has the touchpad connected both
> +	 * via PS/2 and i2c interface. This causes a race condition between the
> +	 * psmouse and i2c-hid driver. Since the full capability of the touchpad
> +	 * is available via the i2c interface and the device has no external
> +	 * PS/2 port, it is save to just ignore all ps2 mouses here to avoid
> +	 * this issue. The know affected device is the
> +	 * TUXEDO InfinityBook S17 Gen6 / Clevo NS70MU which comes with one of
> +	 * the two different dmi strings below. NS50MU is not a typo!
> +	 */
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOAUX | SERIO_QUIRK_NOMUX |
> +					SERIO_QUIRK_RESET_ALWAYS | SERIO_QUIRK_NOLOOP |
> +					SERIO_QUIRK_NOPNP)
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOAUX | SERIO_QUIRK_NOMUX |
> +					SERIO_QUIRK_RESET_ALWAYS | SERIO_QUIRK_NOLOOP |
> +					SERIO_QUIRK_NOPNP)
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
> +	},
>  	{ }
>  };
>  

