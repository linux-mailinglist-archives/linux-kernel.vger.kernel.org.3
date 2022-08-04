Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4929D589CC9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239960AbiHDNhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239945AbiHDNhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:37:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8F293B972
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 06:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659620218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uZ6dU7FbIslQ7+mfNCH4MEAKKwV7FaBW+yHtzOKs2ZU=;
        b=aALxNtFAkMPQVYtVWvouL3GODKVLOPhtDlC834XUv/CQkQ+rLYrAUVxxtbS+EskgdSnzJ1
        yiBLa5r94ARzsIJs4fdaRnAEpjIyVIKtZ0fG9wa+c0Pg6SZHQ3oCiEhqdedq73fbwFXxE6
        fPNC5ad5B0FmJJpoZ6enX3qm8rPq11c=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-NwrTl-32MYCSCRqIBUa2og-1; Thu, 04 Aug 2022 09:36:57 -0400
X-MC-Unique: NwrTl-32MYCSCRqIBUa2og-1
Received: by mail-ed1-f72.google.com with SMTP id l19-20020a056402255300b0043df64f9a0fso5286551edb.16
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 06:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uZ6dU7FbIslQ7+mfNCH4MEAKKwV7FaBW+yHtzOKs2ZU=;
        b=7eAKK3CyiBc9/a5bQbxncobS2DBgsvBODkS85vyFcaqoGOJMnGO4ACwEjR5y7UUtK8
         ejd8tfPU0JAmKJRi/OfdGee7ReDLJBSFuU/oAeTREWnx6F1vnPxR/RwR6LAX9SepC2aG
         mWJkY8hfm/iKoAvMGC8Xkoz1IFhf7wRB8mGXyFyHWU/ZGQh44abQZPPUDxQzNTCqG3yI
         H/eBz+G4NUXRFX/w2G2CrZB6miU96we4a62i9Y5zufWZdHeicruroQZrt4uAGwDyAE+Z
         g7C3rsA6Y70doysnVbKHobyuYhVdaPz9E81FfFNPVL3gRK/Uh51YNawDXc00rFOqNP1e
         gUGw==
X-Gm-Message-State: ACgBeo2NU1z9/DYg4SPqgNG9wC5d4mrrlE5hlY+Sj+bA7M+J+8UXqJfV
        SFDu5xCUhlkjUo74+/DWbGXpWHxibwrocWlMTP+lxAgNWpxog2nyl2iC1ja8PjyQBQluxrKydm8
        rtCfWKYqKiivsX7iAkAT2ZOdU
X-Received: by 2002:a05:6402:46:b0:43a:f611:5992 with SMTP id f6-20020a056402004600b0043af6115992mr2133907edu.18.1659620216009;
        Thu, 04 Aug 2022 06:36:56 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5eVcpTVC6789/nkR5GVznLJlJRI291MXpJhmMurppfvaB5Jl2gY3Gw/RF+ck0565LiN8ApOw==
X-Received: by 2002:a05:6402:46:b0:43a:f611:5992 with SMTP id f6-20020a056402004600b0043af6115992mr2133877edu.18.1659620215704;
        Thu, 04 Aug 2022 06:36:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id j19-20020aa7c0d3000000b0043d8d0ba6a3sm671634edp.85.2022.08.04.06.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 06:36:54 -0700 (PDT)
Message-ID: <c07730be-0056-4ccf-2989-dbd2e1a8a826@redhat.com>
Date:   Thu, 4 Aug 2022 15:36:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] asus-wmi: Add support for TUF laptop keyboard RGB
Content-Language: en-US
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220803231631.49924-1-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220803231631.49924-1-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/4/22 01:16, Luke D. Jones wrote:
> Adds support for TUF laptop RGB control. This adds a multicolor LED
> device, and two sysfs paths for extra feature control.
> 
> /sys/devices/platform/asus-nb-wmi/tuf_krgb_mode_index provides
> labels for the index fields as "save mode speed"

As mentioned in my review of "[PATCH v2 1/1] asus-wmi: Add support
for TUF laptop keyboard states" the new tuf_krgb_mode attribute
should be an extra attribute under the led_class_device, you can do
this by adding this attribute to a separate attribute_group,
lets say e.g. "tuf_rgb_attributes" and then in the code of this
patch add:

	mc_cdev->led_cdev.groups = tuf_rgb_attributes;

and then the "tuf_krgb_mode" file should show up as:
/sys/class/leds/asus::multicolour/tuf_krgb_mode

Also again please drop the tuf_krgb_mode_index file and document
things in Documentation/ABI/testing/sysfs-platform-asus-wmi.

I've not done a detailed review of this yet, but overall this looks
good, definitely moving in the right direction.

My only other remark is that the led_class_device name should be
something like: "asus_wmi::kbd_backlight".

For easier reviewing of the next version, please split this
into 3 patches:

1. Add just the multi color led_class_dev
2. Add tuf_krgb_state attribute under the led_class_dev
3. Add tuf_krgb_mode attribute under the led_class_dev

Also see some further comments inline / below.


> /sys/devices/platform/asus-nb-wmi/tuf_krgb_mode has the following
> as input options via U8 "n n n":
> - Save or set, if set, then settings revert on cold boot
> - Mode, 0 = Static, 1 = Breathe, 2 = Colour cycle, 3 = Pulse
> - Speed, 0 = Slow, 1 = Medium, 2 = Fast
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-wmi.c            | 213 +++++++++++++++++++++
>  include/linux/platform_data/x86/asus-wmi.h |   3 +
>  2 files changed, 216 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 0e7fbed8a50d..2959f17047a8 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -25,6 +25,7 @@
>  #include <linux/input/sparse-keymap.h>
>  #include <linux/kernel.h>
>  #include <linux/leds.h>
> +#include <linux/led-class-multicolor.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/pci_hotplug.h>
> @@ -117,6 +118,9 @@ static const char * const ashs_ids[] = { "ATK4001", "ATK4002", NULL };
>  
>  static int throttle_thermal_policy_write(struct asus_wmi *);
>  
> +static int tuf_rgb_brightness_set(struct led_classdev *cdev,
> +							enum led_brightness brightness);
> +
>  static bool ashs_present(void)
>  {
>  	int i = 0;
> @@ -190,6 +194,14 @@ struct fan_curve_data {
>  	u8 percents[FAN_CURVE_POINTS];
>  };
>  
> +struct tuf_rgb_led {
> +	struct led_classdev_mc dev;
> +	struct mc_subled subled_info[3]; /* r g b */
> +	u8 save;
> +	u8 mode;
> +	u8 speed;
> +};
> +
>  struct asus_wmi {
>  	int dsts_id;
>  	int spec;
> @@ -234,6 +246,9 @@ struct asus_wmi {
>  	bool dgpu_disable_available;
>  	bool dgpu_disable;
>  
> +	bool tuf_krgb_mode_available;
> +	struct tuf_rgb_led tuf_krgb_mode;
> +
>  	bool throttle_thermal_policy_available;
>  	u8 throttle_thermal_policy_mode;
>  
> @@ -734,6 +749,116 @@ static ssize_t egpu_enable_store(struct device *dev,
>  
>  static DEVICE_ATTR_RW(egpu_enable);
>  
> +/* TUF Laptop Keyboard RGB Modes **********************************************/
> +static int tuf_krgb_mode_check_present(struct asus_wmi *asus)
> +{
> +	u32 result;
> +	int err;
> +
> +	asus->tuf_krgb_mode_available = false;
> +
> +	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_TUF_RGB_MODE, &result);
> +	if (err) {
> +		if (err == -ENODEV)
> +			return 0;
> +		return err;
> +	}
> +
> +	if (result & ASUS_WMI_DSTS_PRESENCE_BIT) {
> +		asus->tuf_krgb_mode_available = true;
> +		/* set some sane defaults since we can't read this from WMI */
> +		asus->tuf_krgb_mode.save = 1;
> +		asus->tuf_krgb_mode.mode = 0;
> +		asus->tuf_krgb_mode.speed = 1;

Why not just make tuf_krgb_mode write-only like you have done for tuf_krgb_state ?

> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t tuf_krgb_mode_store(struct device *device,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t count)
> +{
> +	char *data, *part, *end;
> +	u8 res, tmp, arg_num;
> +	int err;
> +
> +	struct asus_wmi *asus = dev_get_drvdata(device);
> +	struct led_classdev *cdev = &asus->tuf_krgb_mode.dev.led_cdev;
> +
> +	data = end = kstrdup(buf, GFP_KERNEL);
> +	arg_num = 0;
> +
> +	while ((part = strsep(&end, " ")) != NULL) {
> +		if (part == NULL)
> +			return -1;

return -EINVAL please.

> +
> +		res = kstrtou8(part, 10, &tmp);
> +		if (res)
> +			return -1;

return -EINVAL please.

> +
> +		if (arg_num == 0)
> +			asus->tuf_krgb_mode.save = tmp;
> +		else if (arg_num == 1)
> +			/* These are the known usable modes across all TUF/ROG */
> +			asus->tuf_krgb_mode.mode = tmp < 12 && tmp != 9 ? tmp : 0x0a;
> +		else if (arg_num == 2) {
> +			if (tmp == 0)
> +				asus->tuf_krgb_mode.speed = 0xe1;
> +			else if (tmp == 1)
> +				asus->tuf_krgb_mode.speed = 0xeb;
> +			else if (tmp == 2)
> +				asus->tuf_krgb_mode.speed = 0xf5;
> +			else
> +				asus->tuf_krgb_mode.speed = 0xeb;
> +		}
> +
> +		arg_num += 1;
> +	}

Maybe just replace the kstrdup + the entire while loop with:

	int a, b, c;

	if (sscanf(buf, "%d %d %d", &a, &b, &c) != 3)
		return -EINVAL;

	asus->tuf_krgb_mode.save = a;
	asus->tuf_krgb_mode.mode = b < 12 && b != 9 ? b : 0x0a;

	if (c == 0)
		asus->tuf_krgb_mode.speed = 0xe1;
	else if (c == 1)
		asus->tuf_krgb_mode.speed = 0xeb;
	else if (c == 2)
		asus->tuf_krgb_mode.speed = 0xf5;
	else
		asus->tuf_krgb_mode.speed = 0xeb;
	
That certainly seems a lot cleaner to me ?

And perhaps you can do something similar for
tuf_krgb_state_store  ?



> +
> +	err = tuf_rgb_brightness_set(cdev, cdev->brightness);
> +	if (err)
> +		return err;
> +	return 0;
> +}
> +
> +static ssize_t tuf_krgb_mode_show(struct device *device,
> +						 struct device_attribute *attr,
> +						 char *buf)
> +{
> +	struct asus_wmi *asus = dev_get_drvdata(device);
> +	u8 speed = asus->tuf_krgb_mode.speed;
> +	int len;
> +
> +	if (speed == 0xe1)
> +		speed = 0;
> +	else if (speed == 0xeb)
> +		speed = 1;
> +	else if (speed == 0xf5)
> +		speed = 2;
> +	else
> +		speed = 1;
> +
> +	len = sprintf(buf, "%d %d %d",
> +						asus->tuf_krgb_mode.save,
> +						asus->tuf_krgb_mode.mode,
> +						speed);
> +
> +	return len;
> +}
> +
> +static DEVICE_ATTR_RW(tuf_krgb_mode);

As mentioned above why not just make this write-only
like you have done for tuf_krgb_state ?

> +
> +static ssize_t tuf_krgb_mode_index_show(struct device *device,
> +						 struct device_attribute *attr,
> +						 char *buf)
> +{
> +	int len = sprintf(buf, "%s", "save mode speed\n");
> +	return len;
> +}
> +
> +static DEVICE_ATTR_RO(tuf_krgb_mode_index);
> +
>  /* Battery ********************************************************************/
>  
>  /* The battery maximum charging percentage */
> @@ -1028,6 +1153,38 @@ static enum led_brightness lightbar_led_get(struct led_classdev *led_cdev)
>  	return result & ASUS_WMI_DSTS_LIGHTBAR_MASK;
>  }
>  
> +static int tuf_rgb_brightness_set(struct led_classdev *cdev,
> +	enum led_brightness brightness)
> +{
> +	u8 r, g, b, mode, speed, save;
> +	int err;
> +	u32 ret;
> +	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);
> +	struct asus_wmi *asus = container_of(mc_cdev, struct asus_wmi, tuf_krgb_mode.dev);
> +
> +	led_mc_calc_color_components(mc_cdev, brightness);
> +	r = mc_cdev->subled_info[0].brightness;
> +	g = mc_cdev->subled_info[1].brightness;
> +	b = mc_cdev->subled_info[2].brightness;
> +	/* 0 still sets the mode/rgb, but does not stick on reboot */
> +	save = asus->tuf_krgb_mode.save == 1 ? 0xb5 : 0xb4;
> +	mode = asus->tuf_krgb_mode.mode;
> +	speed = asus->tuf_krgb_mode.speed;
> +
> +	err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS, ASUS_WMI_DEVID_TUF_RGB_MODE,
> +			save | (mode << 8) | (r << 16) | (g << 24), (b) | (speed << 8), &ret);
> +	if (err) {
> +		pr_err("Unable to set TUF RGB data?\n");
> +		return err;
> +	}
> +	return 0;
> +}
> +
> +static enum led_brightness tuf_rgb_brightness_get(struct led_classdev *cdev)
> +{
> +	return cdev->brightness;
> +}
> +
>  static void asus_wmi_led_exit(struct asus_wmi *asus)
>  {
>  	led_classdev_unregister(&asus->kbd_led);
> @@ -1105,6 +1262,51 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
>  					   &asus->lightbar_led);
>  	}
>  
> +	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE)) {
> +		struct led_classdev_mc *mc_cdev;
> +		struct mc_subled *mc_led_info;
> +		u8 brightness = 127;
> +
> +		mc_cdev = &asus->tuf_krgb_mode.dev;
> +
> +		mc_cdev->led_cdev.name = "asus::multicolour";
> +		mc_cdev->led_cdev.flags = LED_CORE_SUSPENDRESUME | LED_RETAIN_AT_SHUTDOWN;
> +		mc_cdev->led_cdev.brightness_set_blocking = tuf_rgb_brightness_set;
> +		mc_cdev->led_cdev.brightness_get = tuf_rgb_brightness_get;
> +
> +		/* Let the multicolour LED own the info */
> +		mc_led_info = devm_kmalloc_array(
> +			&asus->platform_device->dev,
> +			3,
> +			sizeof(*mc_led_info),
> +			GFP_KERNEL | __GFP_ZERO);
> +
> +		if (!mc_led_info)
> +			return -ENOMEM;
> +
> +		mc_led_info[0].color_index = LED_COLOR_ID_RED;
> +		mc_led_info[1].color_index = LED_COLOR_ID_GREEN;
> +		mc_led_info[2].color_index = LED_COLOR_ID_BLUE;
> +
> +		/* It's not possible to get last set data from device so set defaults */
> +		asus->tuf_krgb_mode.save = 1;
> +		asus->tuf_krgb_mode.mode = 0;
> +		asus->tuf_krgb_mode.speed = 1;
> +		mc_cdev->led_cdev.brightness = brightness;
> +		mc_cdev->led_cdev.max_brightness = brightness;
> +		mc_led_info[0].intensity = brightness;
> +		mc_led_info[0].brightness = mc_cdev->led_cdev.brightness;
> +		mc_led_info[1].brightness = mc_cdev->led_cdev.brightness;
> +		mc_led_info[2].brightness = mc_cdev->led_cdev.brightness;
> +		led_mc_calc_color_components(mc_cdev, brightness);
> +
> +		mc_cdev->subled_info = mc_led_info;
> +		mc_cdev->num_colors = 3;
> +
> +		tuf_rgb_brightness_set(&mc_cdev->led_cdev, brightness);
> +		rv = led_classdev_multicolor_register(&asus->platform_device->dev, mc_cdev);
> +	}
> +
>  error:
>  	if (rv)
>  		asus_wmi_led_exit(asus);
> @@ -3258,6 +3460,8 @@ static struct attribute *platform_attributes[] = {
>  	&dev_attr_touchpad.attr,
>  	&dev_attr_egpu_enable.attr,
>  	&dev_attr_dgpu_disable.attr,
> +	&dev_attr_tuf_krgb_mode.attr,
> +	&dev_attr_tuf_krgb_mode_index.attr,
>  	&dev_attr_lid_resume.attr,
>  	&dev_attr_als_enable.attr,
>  	&dev_attr_fan_boost_mode.attr,
> @@ -3288,6 +3492,10 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
>  		ok = asus->egpu_enable_available;
>  	else if (attr == &dev_attr_dgpu_disable.attr)
>  		ok = asus->dgpu_disable_available;
> +	else if (attr == &dev_attr_tuf_krgb_mode.attr)
> +		ok = asus->tuf_krgb_mode_available;
> +	else if (attr == &dev_attr_tuf_krgb_mode_index.attr)
> +		ok = asus->tuf_krgb_mode_available;
>  	else if (attr == &dev_attr_fan_boost_mode.attr)
>  		ok = asus->fan_boost_mode_available;
>  	else if (attr == &dev_attr_throttle_thermal_policy.attr)
> @@ -3557,6 +3765,10 @@ static int asus_wmi_add(struct platform_device *pdev)
>  	if (err)
>  		goto fail_dgpu_disable;
>  
> +	err = tuf_krgb_mode_check_present(asus);
> +	if (err)
> +		goto fail_tuf_krgb_mode;
> +
>  	err = fan_boost_mode_check_present(asus);
>  	if (err)
>  		goto fail_fan_boost_mode;
> @@ -3671,6 +3883,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>  fail_fan_boost_mode:
>  fail_egpu_enable:
>  fail_dgpu_disable:
> +fail_tuf_krgb_mode:
>  fail_platform:
>  fail_panel_od:
>  	kfree(asus);
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index a571b47ff362..5049c153a3fe 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -98,6 +98,9 @@
>  /* dgpu on/off */
>  #define ASUS_WMI_DEVID_DGPU		0x00090020
>  
> +/* TUF laptop RGB modes */
> +#define ASUS_WMI_DEVID_TUF_RGB_MODE	0x00100056
> +
>  /* DSTS masks */
>  #define ASUS_WMI_DSTS_STATUS_BIT	0x00000001
>  #define ASUS_WMI_DSTS_UNKNOWN_BIT	0x00000002



Regards,

Hans

