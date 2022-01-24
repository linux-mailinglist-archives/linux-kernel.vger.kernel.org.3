Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4718C497CD1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 11:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236049AbiAXKO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 05:14:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47634 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233901AbiAXKOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:14:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643019264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NFgGOWrMCsiwvX0Gq9eyXG7AAOSCR/S9BqptCmgvn9E=;
        b=Nu8TyN9icjvZlzwe8bIbgzZDITIIWV0Va/02Pb/tIMGEqkaMV5fBSFZTyuNVzXfJCPcb6Z
        7dgk4KNnRwqpJzi44mehJA92KniP0M7WS6E6xR+xvEnJNmuKq3vUUca3rQ2i4I+Wulv4TC
        x4mjrSOp/bOqDrDuUJV9lLukHmqcjos=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-82-9qaFK9B1NuykVZA-SHSnkQ-1; Mon, 24 Jan 2022 05:14:23 -0500
X-MC-Unique: 9qaFK9B1NuykVZA-SHSnkQ-1
Received: by mail-ej1-f70.google.com with SMTP id m21-20020a1709061ed500b006b3003ec50dso1883481ejj.17
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 02:14:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NFgGOWrMCsiwvX0Gq9eyXG7AAOSCR/S9BqptCmgvn9E=;
        b=0P09uPl3e08AtTFX1ZYzd8Vn+lXM/uRKiHmcxuu4gLM1KGIO8PfuL7d29jtHY9SZts
         6R7W15xq2x2pMbPuG0NTKTVCNbPg6OxzUdUC/MExH4rDAhxvs1ItohgKXWa2ITJnhHMT
         0ZnFNWl8XNJaHnH0la+ahuK4Y7P/0ZFdDuM6FhLOG2Md8kRtY6VO1ElbTbqkCTmzAZZo
         JAzq/KZJENC6ULWCpqoz5aruaGnSoaOjR+zw4BX44yRkY541E4Ed3k5hGhjcpkSJmubs
         442y1c8VphnCwiFtg4PcytiiursDoYzSvUbWYiW+IwvEFjyg/Yj90g7peowV+FF5dsOL
         IuXA==
X-Gm-Message-State: AOAM5321HBkVz0PkUIDidIbB+xm3hxssSQPwQii0X8Ricg7UsLBa7lRg
        IZ17/ICt9mHAaU8Ol9ef7AfxA2FckQSjZtdzi45OCNFghR4cH/eZQT3pm2rxe8qup2+ljxu7Uz7
        9OBhTZedsbfZXV2nHTslSC0NN
X-Received: by 2002:a05:6402:27d3:: with SMTP id c19mr9241152ede.397.1643019261734;
        Mon, 24 Jan 2022 02:14:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgEUvrFOdIY8NoH2FzWKpfLTQB2FiLKXn0DJqRGG/E9Pa5GXxMw6SwHK+qao6vxJzf9fp7CQ==
X-Received: by 2002:a05:6402:27d3:: with SMTP id c19mr9241122ede.397.1643019261367;
        Mon, 24 Jan 2022 02:14:21 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id i17sm4691144ejp.60.2022.01.24.02.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 02:14:20 -0800 (PST)
Message-ID: <055616f1-587e-107e-24db-0e30788fca56@redhat.com>
Date:   Mon, 24 Jan 2022 11:14:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 20/31] platform: x86: changing LED_* from enum
 led_brightness to actual value
Content-Language: en-US
To:     Luiz Sampaio <sampaio.ime@gmail.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Mark Gross <markgross@kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        =?UTF-8?Q?Jo=c3=a3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Jonathan Woithe <jwoithe@just42.net>,
        Matan Ziv-Av <matan@svgalib.org>,
        Jeremy Soller <jeremy@system76.com>,
        System76 Product Development <productdev@system76.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Herton Ronaldo Krzesinski <herton@canonical.com>,
        Azael Avalos <coproscefalo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net,
        ibm-acpi-devel@lists.sourceforge.net
References: <20220121165436.30956-1-sampaio.ime@gmail.com>
 <20220121165436.30956-21-sampaio.ime@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220121165436.30956-21-sampaio.ime@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/21/22 17:54, Luiz Sampaio wrote:
> The enum led_brightness, which contains the declaration of LED_OFF,
> LED_ON, LED_HALF and LED_FULL is obsolete, as the led class now supports
> max_brightness.

This change is fine with me. I assume that this depends on earlier
changes in this series (1), so that it is best to merge the entire
series through the LED tree, here is my ack for merging the
drivers/platform/x86 bits through the LED tree:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

1) next time please send the entire series to
the platform-driver-x86@vger.kernel.org list and not just one patch
of a series.


> ---
>  drivers/platform/x86/acer-wmi.c          |  6 ++---
>  drivers/platform/x86/asus-wireless.c     |  6 ++---
>  drivers/platform/x86/dell/dell-laptop.c  |  2 +-
>  drivers/platform/x86/dell/dell-wmi-led.c |  4 ++--
>  drivers/platform/x86/fujitsu-laptop.c    | 28 ++++++++++++------------
>  drivers/platform/x86/lg-laptop.c         | 18 +++++++--------
>  drivers/platform/x86/system76_acpi.c     |  4 ++--
>  drivers/platform/x86/thinkpad_acpi.c     | 14 ++++++------
>  drivers/platform/x86/topstar-laptop.c    |  4 ++--
>  drivers/platform/x86/toshiba_acpi.c      | 24 ++++++++++----------
>  10 files changed, 55 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index 9c6943e401a6..ce960164a397 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -1597,7 +1597,7 @@ static int acer_led_init(struct device *dev)
>  
>  static void acer_led_exit(void)
>  {
> -	set_u32(LED_OFF, ACER_CAP_MAILLED);
> +	set_u32(0, ACER_CAP_MAILLED);
>  	led_classdev_unregister(&mail_led);
>  }
>  
> @@ -2332,7 +2332,7 @@ static int acer_suspend(struct device *dev)
>  
>  	if (has_cap(ACER_CAP_MAILLED)) {
>  		get_u32(&value, ACER_CAP_MAILLED);
> -		set_u32(LED_OFF, ACER_CAP_MAILLED);
> +		set_u32(0, ACER_CAP_MAILLED);
>  		data->mailled = value;
>  	}
>  
> @@ -2377,7 +2377,7 @@ static void acer_platform_shutdown(struct platform_device *device)
>  		return;
>  
>  	if (has_cap(ACER_CAP_MAILLED))
> -		set_u32(LED_OFF, ACER_CAP_MAILLED);
> +		set_u32(0, ACER_CAP_MAILLED);
>  }
>  
>  static struct platform_driver acer_platform_driver = {
> diff --git a/drivers/platform/x86/asus-wireless.c b/drivers/platform/x86/asus-wireless.c
> index d3e7171928e5..139257bf71ea 100644
> --- a/drivers/platform/x86/asus-wireless.c
> +++ b/drivers/platform/x86/asus-wireless.c
> @@ -84,8 +84,8 @@ static enum led_brightness led_state_get(struct led_classdev *led)
>  	s = asus_wireless_method(acpi_device_handle(data->adev), "HSWC",
>  				 data->hswc_params->status, &ret);
>  	if (ACPI_SUCCESS(s) && ret == data->hswc_params->on)
> -		return LED_FULL;
> -	return LED_OFF;
> +		return 255;
> +	return 0;
>  }
>  
>  static void led_state_update(struct work_struct *work)
> @@ -103,7 +103,7 @@ static void led_state_set(struct led_classdev *led, enum led_brightness value)
>  	struct asus_wireless_data *data;
>  
>  	data = container_of(led, struct asus_wireless_data, led);
> -	data->led_state = value == LED_OFF ? data->hswc_params->off :
> +	data->led_state = value == 0 ? data->hswc_params->off :
>  					     data->hswc_params->on;
>  	queue_work(data->wq, &data->led_work);
>  }
> diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
> index 8230e7a68a5e..4dd530e3b47b 100644
> --- a/drivers/platform/x86/dell/dell-laptop.c
> +++ b/drivers/platform/x86/dell/dell-laptop.c
> @@ -2141,7 +2141,7 @@ static int micmute_led_set(struct led_classdev *led_cdev,
>  {
>  	struct calling_interface_buffer buffer;
>  	struct calling_interface_token *token;
> -	int state = brightness != LED_OFF;
> +	int state = brightness != 0;
>  
>  	if (state == 0)
>  		token = dell_smbios_find_token(GLOBAL_MIC_MUTE_DISABLE);
> diff --git a/drivers/platform/x86/dell/dell-wmi-led.c b/drivers/platform/x86/dell/dell-wmi-led.c
> index 5bedaf7f0633..fcfd6dd60583 100644
> --- a/drivers/platform/x86/dell/dell-wmi-led.c
> +++ b/drivers/platform/x86/dell/dell-wmi-led.c
> @@ -122,7 +122,7 @@ static int led_blink(unsigned char on_eighths, unsigned char off_eighths)
>  static void dell_led_set(struct led_classdev *led_cdev,
>  			 enum led_brightness value)
>  {
> -	if (value == LED_OFF)
> +	if (value == 0)
>  		led_off();
>  	else
>  		led_on();
> @@ -154,7 +154,7 @@ static int dell_led_blink(struct led_classdev *led_cdev,
>  
>  static struct led_classdev dell_led = {
>  	.name		= "dell::lid",
> -	.brightness	= LED_OFF,
> +	.brightness	= 0,
>  	.max_brightness = 1,
>  	.brightness_set = dell_led_set,
>  	.blink_set	= dell_led_blink,
> diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
> index 80929380ec7e..6ebfda771209 100644
> --- a/drivers/platform/x86/fujitsu-laptop.c
> +++ b/drivers/platform/x86/fujitsu-laptop.c
> @@ -584,10 +584,10 @@ static int logolamp_set(struct led_classdev *cdev,
>  	int poweron = FUNC_LED_ON, always = FUNC_LED_ON;
>  	int ret;
>  
> -	if (brightness < LED_HALF)
> +	if (brightness < 127)
>  		poweron = FUNC_LED_OFF;
>  
> -	if (brightness < LED_FULL)
> +	if (brightness < 255)
>  		always = FUNC_LED_OFF;
>  
>  	ret = call_fext_func(device, FUNC_LEDS, 0x1, LOGOLAMP_POWERON, poweron);
> @@ -604,13 +604,13 @@ static enum led_brightness logolamp_get(struct led_classdev *cdev)
>  
>  	ret = call_fext_func(device, FUNC_LEDS, 0x2, LOGOLAMP_ALWAYS, 0x0);
>  	if (ret == FUNC_LED_ON)
> -		return LED_FULL;
> +		return 255;
>  
>  	ret = call_fext_func(device, FUNC_LEDS, 0x2, LOGOLAMP_POWERON, 0x0);
>  	if (ret == FUNC_LED_ON)
> -		return LED_HALF;
> +		return 127;
>  
> -	return LED_OFF;
> +	return 0;
>  }
>  
>  static int kblamps_set(struct led_classdev *cdev,
> @@ -618,7 +618,7 @@ static int kblamps_set(struct led_classdev *cdev,
>  {
>  	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
>  
> -	if (brightness >= LED_FULL)
> +	if (brightness >= 255)
>  		return call_fext_func(device, FUNC_LEDS, 0x1, KEYBOARD_LAMPS,
>  				      FUNC_LED_ON);
>  	else
> @@ -629,11 +629,11 @@ static int kblamps_set(struct led_classdev *cdev,
>  static enum led_brightness kblamps_get(struct led_classdev *cdev)
>  {
>  	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
> -	enum led_brightness brightness = LED_OFF;
> +	unsigned int brightness = 0;
>  
>  	if (call_fext_func(device,
>  			   FUNC_LEDS, 0x2, KEYBOARD_LAMPS, 0x0) == FUNC_LED_ON)
> -		brightness = LED_FULL;
> +		brightness = 255;
>  
>  	return brightness;
>  }
> @@ -643,7 +643,7 @@ static int radio_led_set(struct led_classdev *cdev,
>  {
>  	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
>  
> -	if (brightness >= LED_FULL)
> +	if (brightness >= 255)
>  		return call_fext_func(device, FUNC_FLAGS, 0x5, RADIO_LED_ON,
>  				      RADIO_LED_ON);
>  	else
> @@ -654,10 +654,10 @@ static int radio_led_set(struct led_classdev *cdev,
>  static enum led_brightness radio_led_get(struct led_classdev *cdev)
>  {
>  	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
> -	enum led_brightness brightness = LED_OFF;
> +	unsigned int brightness = 0;
>  
>  	if (call_fext_func(device, FUNC_FLAGS, 0x4, 0x0, 0x0) & RADIO_LED_ON)
> -		brightness = LED_FULL;
> +		brightness = 255;
>  
>  	return brightness;
>  }
> @@ -669,7 +669,7 @@ static int eco_led_set(struct led_classdev *cdev,
>  	int curr;
>  
>  	curr = call_fext_func(device, FUNC_LEDS, 0x2, ECO_LED, 0x0);
> -	if (brightness >= LED_FULL)
> +	if (brightness >= 255)
>  		return call_fext_func(device, FUNC_LEDS, 0x1, ECO_LED,
>  				      curr | ECO_LED_ON);
>  	else
> @@ -680,10 +680,10 @@ static int eco_led_set(struct led_classdev *cdev,
>  static enum led_brightness eco_led_get(struct led_classdev *cdev)
>  {
>  	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
> -	enum led_brightness brightness = LED_OFF;
> +	unsigned int brightness = 0;
>  
>  	if (call_fext_func(device, FUNC_LEDS, 0x2, ECO_LED, 0x0) & ECO_LED_ON)
> -		brightness = LED_FULL;
> +		brightness = 255;
>  
>  	return brightness;
>  }
> diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
> index a91847a551a7..cbcc945c2d9d 100644
> --- a/drivers/platform/x86/lg-laptop.c
> +++ b/drivers/platform/x86/lg-laptop.c
> @@ -547,13 +547,13 @@ static void tpad_led_set(struct led_classdev *cdev,
>  {
>  	union acpi_object *r;
>  
> -	r = lg_wmab(WM_TLED, WM_SET, brightness > LED_OFF);
> +	r = lg_wmab(WM_TLED, WM_SET, brightness > 0);
>  	kfree(r);
>  }
>  
>  static enum led_brightness tpad_led_get(struct led_classdev *cdev)
>  {
> -	return ggov(GOV_TLED) > 0 ? LED_ON : LED_OFF;
> +	return ggov(GOV_TLED) > 0 ? 1 : 0;
>  }
>  
>  static LED_DEVICE(tpad_led, 1, 0);
> @@ -565,9 +565,9 @@ static void kbd_backlight_set(struct led_classdev *cdev,
>  	union acpi_object *r;
>  
>  	val = 0x22;
> -	if (brightness <= LED_OFF)
> +	if (brightness <= 0)
>  		val = 0;
> -	if (brightness >= LED_FULL)
> +	if (brightness >= 255)
>  		val = 0x24;
>  	r = lg_wmab(WM_KEY_LIGHT, WM_SET, val);
>  	kfree(r);
> @@ -581,22 +581,22 @@ static enum led_brightness get_kbd_backlight_level(void)
>  	r = lg_wmab(WM_KEY_LIGHT, WM_GET, 0);
>  
>  	if (!r)
> -		return LED_OFF;
> +		return 0;
>  
>  	if (r->type != ACPI_TYPE_BUFFER || r->buffer.pointer[1] != 0x05) {
>  		kfree(r);
> -		return LED_OFF;
> +		return 0;
>  	}
>  
>  	switch (r->buffer.pointer[0] & 0x27) {
>  	case 0x24:
> -		val = LED_FULL;
> +		val = 255;
>  		break;
>  	case 0x22:
> -		val = LED_HALF;
> +		val = 127;
>  		break;
>  	default:
> -		val = LED_OFF;
> +		val = 0;
>  	}
>  
>  	kfree(r);
> diff --git a/drivers/platform/x86/system76_acpi.c b/drivers/platform/x86/system76_acpi.c
> index 7299ad08c838..9f2b11a0e02f 100644
> --- a/drivers/platform/x86/system76_acpi.c
> +++ b/drivers/platform/x86/system76_acpi.c
> @@ -299,7 +299,7 @@ static enum led_brightness ap_led_get(struct led_classdev *led)
>  	if (value > 0)
>  		return (enum led_brightness)value;
>  	else
> -		return LED_OFF;
> +		return 0;
>  }
>  
>  // Set the airplane mode LED brightness
> @@ -308,7 +308,7 @@ static int ap_led_set(struct led_classdev *led, enum led_brightness value)
>  	struct system76_data *data;
>  
>  	data = container_of(led, struct system76_data, ap_led);
> -	return system76_set(data, "SAPL", value == LED_OFF ? 0 : 1);
> +	return system76_set(data, "SAPL", value == 0 ? 0 : 1);
>  }
>  
>  // Get the last set keyboard LED brightness
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 82fa6148216c..01fe0a2995fd 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -5421,13 +5421,13 @@ static int light_set_status(int status)
>  static int light_sysfs_set(struct led_classdev *led_cdev,
>  			enum led_brightness brightness)
>  {
> -	return light_set_status((brightness != LED_OFF) ?
> +	return light_set_status((brightness != 0) ?
>  				TPACPI_LED_ON : TPACPI_LED_OFF);
>  }
>  
>  static enum led_brightness light_sysfs_get(struct led_classdev *led_cdev)
>  {
> -	return (light_get_status() == 1) ? LED_FULL : LED_OFF;
> +	return (light_get_status() == 1) ? 255 : 0;
>  }
>  
>  static struct tpacpi_led_classdev tpacpi_led_thinklight = {
> @@ -5759,7 +5759,7 @@ static int led_sysfs_set(struct led_classdev *led_cdev,
>  			     struct tpacpi_led_classdev, led_classdev);
>  	enum led_status_t new_state;
>  
> -	if (brightness == LED_OFF)
> +	if (brightness == 0)
>  		new_state = TPACPI_LED_OFF;
>  	else if (tpacpi_led_state_cache[data->led] != TPACPI_LED_BLINK)
>  		new_state = TPACPI_LED_ON;
> @@ -5796,9 +5796,9 @@ static enum led_brightness led_sysfs_get(struct led_classdev *led_cdev)
>  	rc = led_get_status(data->led);
>  
>  	if (rc == TPACPI_LED_OFF || rc < 0)
> -		rc = LED_OFF;	/* no error handling in led class :( */
> +		rc = 0;	/* no error handling in led class :( */
>  	else
> -		rc = LED_FULL;
> +		rc = 255;
>  
>  	return rc;
>  }
> @@ -9145,13 +9145,13 @@ static int tpacpi_led_set(int whichled, bool on)
>  static int tpacpi_led_mute_set(struct led_classdev *led_cdev,
>  			       enum led_brightness brightness)
>  {
> -	return tpacpi_led_set(LED_AUDIO_MUTE, brightness != LED_OFF);
> +	return tpacpi_led_set(LED_AUDIO_MUTE, brightness != 0);
>  }
>  
>  static int tpacpi_led_micmute_set(struct led_classdev *led_cdev,
>  				  enum led_brightness brightness)
>  {
> -	return tpacpi_led_set(LED_AUDIO_MICMUTE, brightness != LED_OFF);
> +	return tpacpi_led_set(LED_AUDIO_MICMUTE, brightness != 0);
>  }
>  
>  static struct led_classdev mute_led_cdev[TPACPI_LED_MAX] = {
> diff --git a/drivers/platform/x86/topstar-laptop.c b/drivers/platform/x86/topstar-laptop.c
> index f7761d98c0fd..1382b91c2860 100644
> --- a/drivers/platform/x86/topstar-laptop.c
> +++ b/drivers/platform/x86/topstar-laptop.c
> @@ -71,8 +71,8 @@ static int topstar_led_set(struct led_classdev *led,
>  	 * it seems to be faulty on some models like the Topstar U931
>  	 * Notebook).
>  	 */
> -	if ((ret == 0x30001 && state == LED_OFF)
> -			|| (ret == 0x30000 && state != LED_OFF)) {
> +	if ((ret == 0x30001 && state == 0)
> +			|| (ret == 0x30000 && state != 0)) {
>  		status = acpi_execute_simple_method(topstar->device->handle,
>  				"FNCX", 0x83);
>  		if (ACPI_FAILURE(status))
> diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
> index 352508d30467..641c6766febe 100644
> --- a/drivers/platform/x86/toshiba_acpi.c
> +++ b/drivers/platform/x86/toshiba_acpi.c
> @@ -501,19 +501,19 @@ static enum led_brightness toshiba_illumination_get(struct led_classdev *cdev)
>  
>  	/* First request : initialize communication. */
>  	if (!sci_open(dev))
> -		return LED_OFF;
> +		return 0;
>  
>  	/* Check the illumination */
>  	result = sci_read(dev, SCI_ILLUMINATION, &state);
>  	sci_close(dev);
>  	if (result == TOS_FAILURE) {
>  		pr_err("ACPI call for illumination failed\n");
> -		return LED_OFF;
> +		return 0;
>  	} else if (result != TOS_SUCCESS) {
> -		return LED_OFF;
> +		return 0;
>  	}
>  
> -	return state ? LED_FULL : LED_OFF;
> +	return state ? 255 : 0;
>  }
>  
>  /* KBD Illumination */
> @@ -602,12 +602,12 @@ static enum led_brightness toshiba_kbd_backlight_get(struct led_classdev *cdev)
>  	result = hci_read(dev, HCI_KBD_ILLUMINATION, &state);
>  	if (result == TOS_FAILURE) {
>  		pr_err("ACPI call to get the keyboard backlight failed\n");
> -		return LED_OFF;
> +		return 0;
>  	} else if (result != TOS_SUCCESS) {
> -		return LED_OFF;
> +		return 0;
>  	}
>  
> -	return state ? LED_FULL : LED_OFF;
> +	return state ? 255 : 0;
>  }
>  
>  static void toshiba_kbd_backlight_set(struct led_classdev *cdev,
> @@ -711,13 +711,13 @@ toshiba_eco_mode_get_status(struct led_classdev *cdev)
>  	status = tci_raw(dev, in, out);
>  	if (ACPI_FAILURE(status)) {
>  		pr_err("ACPI call to get ECO led failed\n");
> -		return LED_OFF;
> +		return 0;
>  	}
>  
>  	if (out[0] != TOS_SUCCESS)
> -		return LED_OFF;
> +		return 0;
>  
> -	return out[2] ? LED_FULL : LED_OFF;
> +	return out[2] ? 255 : 0;
>  }
>  
>  static void toshiba_eco_mode_set_status(struct led_classdev *cdev,
> @@ -2402,7 +2402,7 @@ static void toshiba_acpi_kbd_bl_work(struct work_struct *work)
>  	    toshiba_acpi->kbd_mode != SCI_KBD_MODE_AUTO)
>  		led_classdev_notify_brightness_hw_changed(&toshiba_acpi->kbd_led,
>  				(toshiba_acpi->kbd_mode == SCI_KBD_MODE_ON) ?
> -				LED_FULL : LED_OFF);
> +				255 : 0);
>  
>  	/* Emulate the keyboard backlight event */
>  	acpi_bus_generate_netlink_event(toshiba_acpi->acpi_dev->pnp.device_class,
> @@ -3225,7 +3225,7 @@ static void toshiba_acpi_notify(struct acpi_device *acpi_dev, u32 event)
>  		if (dev->kbd_type == 2 && dev->kbd_mode != SCI_KBD_MODE_AUTO)
>  			led_classdev_notify_brightness_hw_changed(&dev->kbd_led,
>  					(dev->kbd_mode == SCI_KBD_MODE_ON) ?
> -					LED_FULL : LED_OFF);
> +					255 : 0);
>  		break;
>  	case 0x85: /* Unknown */
>  	case 0x8d: /* Unknown */
> 

