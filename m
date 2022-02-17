Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C294BA58D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243060AbiBQQRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:17:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243055AbiBQQRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:17:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7DC662308BC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645114626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TdAgT3n4yEQkfTC3jSBmOZ+dNy1FI07UJ9BkHZpJoIM=;
        b=SExlBhDeCJTzE2XHqaYQXoRgQsbFYMP+sQ/4o5tt4o+RUznYYpunE/Gwe/fiCYxybaHZ32
        cRInhImEFqwTqHpSg8X1z5B3hQdlkEtPEHh6G/MILxH2uYLCfGqGQvJbT0vNhbebXcwvE9
        oXJdjn+AYd5z1LpS4ISb1ts1SvhVpWA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-530-bMcsvJM_MvqBpF89e_orqA-1; Thu, 17 Feb 2022 11:17:05 -0500
X-MC-Unique: bMcsvJM_MvqBpF89e_orqA-1
Received: by mail-ed1-f71.google.com with SMTP id l3-20020a50cbc3000000b0041083c11173so3833701edi.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:17:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TdAgT3n4yEQkfTC3jSBmOZ+dNy1FI07UJ9BkHZpJoIM=;
        b=pssEMWxlWZMc6c0lZTM2gK94/TUbs8EGByNadIQmt84LINCRPCrSI4bBvE8jXQ9s0x
         f7uU2Ter9LHCtSLoDMUlnD9aqome2jnN2RxHQQLIR3bnlgIMlsFzyegoKOT4VNgP89VP
         tZK0s7NraoDdDZ+610ls8eacl6Ii2Nre9ViRRaI5CCeVFP1mJgXooFW1eHDLVH6fui2D
         +QZXNYSNvbJRHcFsiqtJ5NdRGHV0573XT1P+N8qtBG1viAwfBjh1gDCZxdqJKoYlmZUo
         1aDVgLIkRM9XWQEnGuVlxIQNTdrmhBTSrMRfcV1bTR0zQvm4I8ICU+U0UXdzKdQqtxfK
         o5cg==
X-Gm-Message-State: AOAM5306K4PVkrERrOeTjkqUMQZPcJ6DIuhGcaj/lURGZUg07/kTBlO4
        aAiDhtrkqNEa2226Qflwd4YnV3ytvMFxhBPYNErOfIjJLAu+nPIgpgbbTwNN+TCko2cphDCxCcc
        5nBDi9H7yDez/bsikjKzvCvn7
X-Received: by 2002:a05:6402:270a:b0:410:a3a4:ba06 with SMTP id y10-20020a056402270a00b00410a3a4ba06mr3349257edd.293.1645114623384;
        Thu, 17 Feb 2022 08:17:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy25JQ6VGe5t6ONYFTpEVFyoKUADp5oZTKNQAtYYWVnB3OdDaDzgJbZKDpRVKANVmCvD2h0Rg==
X-Received: by 2002:a05:6402:270a:b0:410:a3a4:ba06 with SMTP id y10-20020a056402270a00b00410a3a4ba06mr3349233edd.293.1645114623137;
        Thu, 17 Feb 2022 08:17:03 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id o10sm1339664ejj.6.2022.02.17.08.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 08:17:02 -0800 (PST)
Message-ID: <ecb6cb02-70a1-9227-5240-7d39bb9b226b@redhat.com>
Date:   Thu, 17 Feb 2022 17:17:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 2/2] asus-wmi: Add support for keyboard rgb backlights
Content-Language: en-US
To:     Abhijeet V <abhijeetviswa@gmail.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Mark Gross <markgross@kernel.org>
Cc:     acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220211200122.9821-1-abhijeetviswa@gmail.com>
 <20220211200122.9821-3-abhijeetviswa@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220211200122.9821-3-abhijeetviswa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhijeet,

On 2/11/22 21:01, Abhijeet V wrote:
> Uses the led multicolor classdev to change the rgb values.
> The WMI function expects other settings in addition to the rgb values.
> This patch assumes some defaults to get the base rgb functionality
> working.
> 
> Signed-off-by: Abhijeet V <abhijeetviswa@gmail.com>

Thank you for your patches. Other then the buildbot issue patch 1/2
looks good to me. I do have some questions / remarks about this one:

> ---
>  drivers/platform/x86/asus-wmi.c            | 137 +++++++++++++++++++++
>  include/linux/platform_data/x86/asus-wmi.h |   2 +
>  2 files changed, 139 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 117fbcb303d3..f8e92021399c 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -193,6 +193,12 @@ struct fan_curve_data {
>  	u8 percents[FAN_CURVE_POINTS];
>  };
>  
> +struct asus_kbd_rgb {
> +	u8 red;
> +	u8 green;
> +	u8 blue;
> +};
> +
>  struct asus_wmi {
>  	int dsts_id;
>  	int spec;
> @@ -217,6 +223,8 @@ struct asus_wmi {
>  	struct led_classdev_mc kbd_led_mc;
>  	int kbd_led_wk;
>  	struct mc_subled subled_info[ASUS_KBD_SUBLED_COUNT];
> +	struct asus_kbd_rgb kbd_rgb;
> +	bool kbd_rgb_available;
>  
>  	struct asus_rfkill wlan;
>  	struct asus_rfkill bluetooth;
> @@ -914,6 +922,114 @@ static void kbd_led_brightness_wmi_write(struct asus_wmi *asus, int value)
>  	asus_wmi_set_devstate(ASUS_WMI_DEVID_KBD_BACKLIGHT, ctrl_param, NULL);
>  }
>  
> +static int kbd_led_rgb_wmi_write(struct asus_wmi *asus)
> +{
> +	int err;
> +	u32 retval;
> +	u8 red;
> +	u8 green;
> +	u8 blue;
> +	u8 speed_byte;
> +	u8 mode_byte;
> +	u8 speed;
> +	u8 mode;
> +	u8 flags;
> +	u8 persistent;
> +
> +	speed = 0; // Sane default
> +	switch (speed) {
> +	case 0:
> +	default:
> +		speed_byte = 0xe1; // slow
> +		speed = 0;
> +		break;
> +	case 1:
> +		speed_byte = 0xeb; // medium
> +		break;
> +	case 2:
> +		speed_byte = 0xf5; // fast
> +		break;
> +	}
> +
> +	mode = 0; // Sane default
> +	switch (mode) {
> +	case 0:
> +	default:
> +		mode_byte = 0x00; // static color
> +		mode = 0;
> +		break;
> +	case 1:
> +		mode_byte = 0x01; // breathing
> +		break;
> +	case 2:
> +		mode_byte = 0x02; // color cycle
> +		break;
> +	case 3:
> +		mode_byte = 0x0a; // strobing
> +		break;
> +	}
> +
> +	red = clamp_val(asus->kbd_led_mc.subled_info[0].intensity, 0, 255);
> +	green = clamp_val(asus->kbd_led_mc.subled_info[1].intensity, 0, 255);
> +	blue = clamp_val(asus->kbd_led_mc.subled_info[2].intensity, 0, 255);
> +
> +	/*
> +	 * 00 - Reset on boot
> +	 * 01 - Persist across boot
> +	 */
> +	persistent = 1; // Sane defaults
> +
> +	err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS,
> +		ASUS_WMI_DEVID_KBD_RGB,
> +		(persistent ? 0xb4 : 0xb3) |
> +		(mode_byte << 8) |
> +		(red << 16) |
> +		(green << 24),
> +		(blue) |
> +		(speed_byte << 8), &retval);
> +	if (err) {
> +		pr_warn("RGB keyboard device 1, write error: %d\n", err);
> +		return err;
> +	}
> +
> +	if (retval != 1) {
> +		pr_warn("RGB keyboard device 1, write error (retval): %x\n",
> +				retval);
> +		return -EIO;
> +	}
> +
> +	/*
> +	 * Enable: 02 - on boot (until module load) | 08 - awake | 20 - sleep
> +	 * (2a or ff to enable everything)
> +	 *
> +	 * Logically 80 would be shutdown, but no visible effects of this option
> +	 * were observed so far
> +	 */
> +	flags = 0xff;
> +
> +	err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS,
> +		ASUS_WMI_DEVID_KBD_RGB2,
> +		(0xbd) |
> +		(flags << 16) |
> +		(persistent ? 0x0100 : 0x0000), 0, &retval);
> +	if (err) {
> +		pr_warn("RGB keyboard device 2, write error: %d\n", err);
> +		return err;
> +	}
> +
> +	if (retval != 1) {
> +		pr_warn("RGB keyboard device 2, write error (retval): %x\n",
> +				retval);
> +		return -EIO;
> +	}
> +
> +	asus->kbd_rgb.red = red;
> +	asus->kbd_rgb.green = green;
> +	asus->kbd_rgb.blue = blue;
> +
> +	return 0;
> +}
> +
>  static void kbd_led_brightness_set(struct led_classdev *led_cdev,
>  		enum led_brightness value)
>  {
> @@ -928,6 +1044,18 @@ static void kbd_led_brightness_set(struct led_classdev *led_cdev,
>  	asus = container_of(led_cdev_mc, struct asus_wmi, kbd_led_mc);
>  
>  	kbd_led_brightness_wmi_write(asus, value);
> +
> +	/* Check and set if rgb available */
> +	if (!asus->kbd_rgb_available)
> +		return;
> +
> +	if (asus->kbd_rgb.red == asus->subled_info[LED_COLOR_ID_RED].intensity &&
> +			asus->kbd_rgb.green == asus->subled_info[LED_COLOR_ID_GREEN].intensity &&
> +			asus->kbd_rgb.blue == asus->subled_info[LED_COLOR_ID_BLUE].intensity) {
> +		return;
> +	}
> +
> +	kbd_led_rgb_wmi_write(asus);
>  }

I notice you are still doing kbd_led_brightness_wmi_write(asus, value); in the 
rgb case is that necessary ? I would expect the rgb settings from kbd_led_rgb_wmi_write()
to also encode/overwrite the brightness setting ?

>  
>  static void kbd_led_set_brightness_by_hw(struct asus_wmi *asus,
> @@ -959,6 +1087,7 @@ int kbd_led_classdev_init(struct asus_wmi *asus, int brightness)
>  {
>  	int rv;
>  
> +	asus->kbd_rgb_available = true;

Sorry but this is not acceptable, you need to detect that this is actually
supported and not change the behavior of the code on laptops without rgb
backlights.

Perhaps Corentin can help with figuring out how to detect this?

>  	asus->kbd_led_wk = brightness;
>  	asus->kbd_led_mc.led_cdev.name = "asus::kbd_backlight";
>  	asus->kbd_led_mc.led_cdev.flags = LED_BRIGHT_HW_CHANGED;
> @@ -966,6 +1095,14 @@ int kbd_led_classdev_init(struct asus_wmi *asus, int brightness)
>  	asus->kbd_led_mc.led_cdev.brightness_get = kbd_led_brightness_get;
>  	asus->kbd_led_mc.led_cdev.max_brightness = 3;
>  
> +	asus->subled_info[0].color_index = LED_COLOR_ID_RED;
> +	asus->subled_info[0].channel = 0;
> +	asus->subled_info[1].color_index = LED_COLOR_ID_GREEN;
> +	asus->subled_info[1].channel = 1;
> +	asus->subled_info[2].color_index = LED_COLOR_ID_BLUE;
> +	asus->subled_info[2].channel = 2;
> +	asus->kbd_led_mc.subled_info = asus->subled_info;
> +

So with just patch 1/2 kbd_led_mc.subled_info is left as NULL, is this allowed?

>  	asus->kbd_led_mc.num_colors = ASUS_KBD_SUBLED_COUNT;
>  
>  	rv = led_classdev_multicolor_register(&asus->platform_device->dev,

Maybe change this to:

	if (asus->kbd_rgb_available)
		rv = led_classdev_multicolor_register(&asus->platform_device->dev,
						      &asus->kbd_led_mc);
	else
		rv led_classdev_register(&asus->platform_device->dev,
					 &asus->kbd_led_mc.led_cdev);

?

(and the same for unregister).

Regards,

Hans


	
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index a571b47ff362..a20ca3787e9f 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -59,6 +59,8 @@
>  #define ASUS_WMI_DEVID_LIGHTBAR		0x00050025
>  #define ASUS_WMI_DEVID_FAN_BOOST_MODE	0x00110018
>  #define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY 0x00120075
> +#define ASUS_WMI_DEVID_KBD_RGB		0x00100056
> +#define ASUS_WMI_DEVID_KBD_RGB2		0x00100057
>  
>  /* Misc */
>  #define ASUS_WMI_DEVID_PANEL_OD		0x00050019
> 

