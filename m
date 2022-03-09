Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28544D37AE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbiCIRTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237115AbiCIRSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:18:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2887574AD
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 09:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646846217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hYsp5CTOqE7MYUtz4GC4+jPlQ+BmzzCld+8j376Yzmw=;
        b=C2hqX9aT7Gm6/wdCHtDviPvOe72KXx0aiAWBMHaBX2WtmI1TJvbBCoGdbaWxCcyOqVAiT4
        NqsmZ/qlgUKiGrdiKwrHnLATQ83EBqFx9PhHQ7spmZy6ouhGvr9AQ1WisPyiDcE5SnffKV
        oYGzz+DoXMiyY1hzSLtEdWAEYewipMw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216-6bcW1k3KPUK26xtCNtsuMQ-1; Wed, 09 Mar 2022 12:16:55 -0500
X-MC-Unique: 6bcW1k3KPUK26xtCNtsuMQ-1
Received: by mail-ej1-f71.google.com with SMTP id k21-20020a1709063e1500b006d0777c06d6so1668028eji.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 09:16:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hYsp5CTOqE7MYUtz4GC4+jPlQ+BmzzCld+8j376Yzmw=;
        b=oGl8jpWVnN577zJ1a5aNkH/YL6+ET4fA7J+vsymqjE23+Cr/aQ7ALLsujCYpGGgQ+u
         yJaZAVg5KMEnLLbrCMBlVQmSilhRtwFr+5Kg8hGhJb3bZpfQAAosVg1nA7s1ovImcJNY
         Va8SdcD+rRrzRjphLc209BfO+WgMDS0GQIFKJsxdGiOHA45kZVdeS8RZz18WbIZfCTwB
         50VUrzcVtwP4G5JOmbtAaNt5MyYAzSbR79/0Moq1xM8PCczUb4PPpZlL3oW6pIjofqIz
         M6Oz5mI/jf3iYsJ5pJsAz3CozxArupSbEZyldJvKM8mIPFEpzsDnbYNAboI6mLnuNmaA
         xFxw==
X-Gm-Message-State: AOAM530dTIUPIv0ASA/C3+wCR1x+HfgZ/kCrZ9jBY0UFYuzqAjlsjacM
        3eiENn4v/Qa5nPTmwOCIJ0FH5jrv45o+SsNvJMMoCmtYWvw3u9t4fSRhWns/Ria+pWXh6B0UymI
        LZ6SKsZxS7A6r1sCfA5fwCS9f
X-Received: by 2002:a17:907:6e90:b0:6da:886b:ab with SMTP id sh16-20020a1709076e9000b006da886b00abmr709112ejc.285.1646846206031;
        Wed, 09 Mar 2022 09:16:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyjwRtWcwSQ0oQ0ms1LQAAjsV+XW7qqavYnuPjL0jFbbzvuSNOraDbdtQElQdAdyv8yf/6VNw==
X-Received: by 2002:a17:907:6e90:b0:6da:886b:ab with SMTP id sh16-20020a1709076e9000b006da886b00abmr709096ejc.285.1646846205737;
        Wed, 09 Mar 2022 09:16:45 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:cdb2:2781:c55:5db0? (2001-1c00-0c1e-bf00-cdb2-2781-0c55-5db0.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:cdb2:2781:c55:5db0])
        by smtp.gmail.com with ESMTPSA id w15-20020a1709062f8f00b006cd545d4af6sm972978eji.45.2022.03.09.09.16.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 09:16:45 -0800 (PST)
Message-ID: <e84d98e6-541d-8cc7-626e-f92d76230528@redhat.com>
Date:   Wed, 9 Mar 2022 18:16:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 1/3] Input/i8042: Merge quirk tables
Content-Language: en-US
To:     Werner Sembach <wse@tuxedocomputers.com>,
        dmitry.torokhov@gmail.com, tiwai@suse.de, mpdesouza@suse.com,
        arnd@arndb.de, samuel@cavoj.net, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220308170523.783284-1-wse@tuxedocomputers.com>
 <20220308170523.783284-2-wse@tuxedocomputers.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220308170523.783284-2-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/8/22 18:05, Werner Sembach wrote:
> Merge i8042 quirk tables to reduce code duplication for devices that need
> more than one quirk.
> 
> Also align quirkable options with command line parameters and make vendor
> wide quirks per device overwriteable on a per device basis.
> 
> Some duplication on the ASUS devices is required to mirror the exact
> behaviour of the previous code.

Can you explain this a bit more ?



> 
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/input/serio/i8042-x86ia64io.h | 1125 ++++++++++++++-----------
>  1 file changed, 640 insertions(+), 485 deletions(-)
> 
> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
> index 148a7c5fd0e2..689b9ee3e742 100644
> --- a/drivers/input/serio/i8042-x86ia64io.h
> +++ b/drivers/input/serio/i8042-x86ia64io.h
> @@ -67,675 +67,821 @@ static inline void i8042_write_command(int val)
>  
>  #include <linux/dmi.h>
>  
> -static const struct dmi_system_id __initconst i8042_dmi_noloop_table[] = {
> +#define SERIO_QUIRK_NOKBD		BIT(0)
> +#define SERIO_QUIRK_NOAUX		BIT(1)
> +#define SERIO_QUIRK_NOMUX		BIT(2)
> +#define SERIO_QUIRK_FORCEMUX		BIT(3)
> +#define SERIO_QUIRK_UNLOCK		BIT(4)
> +#define SERIO_QUIRK_PROBE_DEFER		BIT(5)
> +#define SERIO_QUIRK_RESET_ALWAYS	BIT(6)
> +#define SERIO_QUIRK_RESET_NEVER		BIT(7)
> +#define SERIO_QUIRK_DIECT		BIT(8)
> +#define SERIO_QUIRK_DUMBKBD		BIT(9)
> +#define SERIO_QUIRK_NOLOOP		BIT(10)
> +#define SERIO_QUIRK_NOTIMEOUT		BIT(11)
> +#define SERIO_QUIRK_KBDRESET		BIT(12)
> +#define SERIO_QUIRK_DRITEK		BIT(13)
> +#define SERIO_QUIRK_NOPNP		BIT(14)
> +
> +/* Quirk table for different mainboards. Options similar or identical to i8042
> + * module parameters.
> + * ORDERING IS IMPORTANT! The first match will be apllied and the rest ignored.
> + * This allows entries to overwrite vendor wide quirks on a per device basis.
> + * Where this is irrelevant, entries are sorted case sensitive by DMI_SYS_VENDOR
> + * and/or DMI_BOARD_VENDOR to make it easier to avoid dublicate entries.
> + */
> +static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {

<snip>

> @@ -1167,11 +1307,6 @@ static int __init i8042_pnp_init(void)
>  	bool pnp_data_busted = false;
>  	int err;
>  
> -#ifdef CONFIG_X86
> -	if (dmi_check_system(i8042_dmi_nopnp_table))
> -		i8042_nopnp = true;
> -#endif
> -
>  	if (i8042_nopnp) {
>  		pr_info("PNP detection disabled\n");
>  		return 0;

have you checked that i8042_platform_init() *always*
gets called before i8042_pnp_init()?

Maybe just add something like this:

#ifdef CONFIG_X86
static void __init i8042_check_quirks(void)
{
	const struct dmi_system_id *device_quirk_info;
	uintptr_t quirks;

	device_quirk_info = dmi_first_match(i8042_dmi_quirk_table);
	if (!device_quirk_info)
		return;

	quirks = (uintptr_t)device_quirk_info->driver_data;

	if (i8042_reset == I8042_RESET_DEFAULT) {
		if (quirks & SERIO_QUIRK_RESET)
			i8042_reset = I8042_RESET_ALWAYS;
		if (quirks & SERIO_QUIRK_NOSELFTEST)
			i8042_reset = I8042_RESET_NEVER;
	}

	/* Do more quirk checks */
}
#else
static inline void i8042_check_quirks(void) {}
#endif

(above the declaration of i8042_pnp_init())

And call i8042_check_quirks() in both
i8042_platform_init() and i8042_platform_init() ?

This also abstracts some of the CONFIG_X86
ifdef-ery out of the other functions.


> @@ -1277,6 +1412,9 @@ static inline void i8042_pnp_exit(void) { }
>  
>  static int __init i8042_platform_init(void)
>  {
> +	bool i8042_reset_always_quirk = false;
> +	bool i8042_reset_never_quirk = false;

I'm not a fan of these 2 helper variables, you can do this directly,
see above.

> +	const struct dmi_system_id *device_quirk_info;

All 3 these variables will trigger unused variable
settings when compiling without CONFIG_X86 set. Note
introducing the i8042_check_quirks() helper as I suggest
above avoids this without needing more #ifdef-ery.

>  	int retval;
>  
>  #ifdef CONFIG_X86
> @@ -1297,6 +1435,44 @@ static int __init i8042_platform_init(void)
>  	i8042_kbd_irq = I8042_MAP_IRQ(1);
>  	i8042_aux_irq = I8042_MAP_IRQ(12);
>  
> +#ifdef CONFIG_X86
> +	device_quirk_info = dmi_first_match(i8042_dmi_quirk_table);
> +	if (device_quirk_info) {
> +		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_NOKBD)
> +			i8042_nokbd = true;
> +		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_NOAUX)
> +			i8042_noaux = true;
> +		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_NOMUX)
> +			i8042_nomux = true;
> +		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_FORCEMUX)
> +			i8042_nomux = false;
> +		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_UNLOCK)
> +			i8042_unlock = true;
> +		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_PROBE_DEFER)
> +			i8042_probe_defer = true;
> +		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_RESET_ALWAYS)
> +			i8042_reset_always_quirk = true;
> +		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_RESET_NEVER)
> +			i8042_reset_never_quirk = true;
> +		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_DIECT)
> +			i8042_direct = true;
> +		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_DUMBKBD)
> +			i8042_dumbkbd = true;
> +		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_NOLOOP)
> +			i8042_noloop = true;
> +		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_NOTIMEOUT)
> +			i8042_notimeout = true;
> +		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_KBDRESET)
> +			i8042_kbdreset = true;
> +		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_DRITEK)
> +			i8042_dritek = true;
> +#ifdef CONFIG_PNP
> +		if ((uintptr_t)device_quirk_info->driver_data & SERIO_QUIRK_NOPNP)
> +			i8042_nopnp = true;
> +#endif
> +	}
> +#endif
> +
>  	retval = i8042_pnp_init();
>  	if (retval)
>  		return retval;
> @@ -1308,34 +1484,13 @@ static int __init i8042_platform_init(void)
>  #ifdef CONFIG_X86
>  	/* Honor module parameter when value is not default */
>  	if (i8042_reset == I8042_RESET_DEFAULT) {
> -		if (dmi_check_system(i8042_dmi_reset_table))
> +		if (i8042_reset_always_quirk)
>  			i8042_reset = I8042_RESET_ALWAYS;
>  
> -		if (dmi_check_system(i8042_dmi_noselftest_table))
> +		if (i8042_reset_never_quirk)
>  			i8042_reset = I8042_RESET_NEVER;
>  	}
>  
> -	if (dmi_check_system(i8042_dmi_noloop_table))
> -		i8042_noloop = true;
> -
> -	if (dmi_check_system(i8042_dmi_nomux_table))
> -		i8042_nomux = true;
> -
> -	if (dmi_check_system(i8042_dmi_forcemux_table))
> -		i8042_nomux = false;
> -
> -	if (dmi_check_system(i8042_dmi_notimeout_table))
> -		i8042_notimeout = true;
> -
> -	if (dmi_check_system(i8042_dmi_dritek_table))
> -		i8042_dritek = true;
> -
> -	if (dmi_check_system(i8042_dmi_kbdreset_table))
> -		i8042_kbdreset = true;
> -
> -	if (dmi_check_system(i8042_dmi_probe_defer_table))
> -		i8042_probe_defer = true;
> -
>  	/*
>  	 * A20 was already enabled during early kernel init. But some buggy
>  	 * BIOSes (in MSI Laptops) require A20 to be enabled using 8042 to

Regards,

Hans


