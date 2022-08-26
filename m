Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640FD5A24E4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343527AbiHZJsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245304AbiHZJro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:47:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA583BD4DD
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661507261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zEx+cHq0Q3xXwYYtwX6N2HHbeabrs5zcbxQz8y1Zit8=;
        b=ar3Yjc9GwO7iyRmon0tgSyslmnSljzXZaGK1rLvwy4oOv4vfPtLivBCD4SgPlwlOxOYRgF
        oG4DDf8ReEnUplEkx/TRuRet3n/x8ca/+vwQ+u5CqKopc1qyPHtSU1xbxl8Pz4B1hdEE8C
        5YeZs6joYwoHIDvuhPnexn6jiZ02sI8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-426-rPqVLAfJMTajCCh4Nz3W3A-1; Fri, 26 Aug 2022 05:47:39 -0400
X-MC-Unique: rPqVLAfJMTajCCh4Nz3W3A-1
Received: by mail-ed1-f69.google.com with SMTP id x9-20020a05640226c900b00447e004ea4cso826302edd.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:47:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=zEx+cHq0Q3xXwYYtwX6N2HHbeabrs5zcbxQz8y1Zit8=;
        b=TJPuLO82QgBIHEQUtZ09Wq91ip3D6jJvh7UYU2C3c8mBQxB49aVzK3uqIc8SR+GcQv
         V29TIE4HC3VFjfy6f+VYq8sBkYthA2s7rtk1aRVSnSqvfpvXE8L4b/JWRa6UNqWDOYp8
         jT1l9DNHl4nDmfJPv9UQcREPdo9ZZa7zvfA1ukxwlfZszFboa3Wd+XfFWLj3sQP7r3AN
         bnWfKiXbduC+M4DLUUUl6vjmCPA1rYWc/Ev1bXWeE8B0kNhrEc1y0j6rzY6mQGR9gcnk
         K8gkvRpAQ+iM2/bQuHQwCa+1VI3M4H3xincsjRnXPb18fRJ5/jMux8ACnPvO1Bu/00Yp
         rEnQ==
X-Gm-Message-State: ACgBeo1Vw6w0QHTjlJtDp5B/U/xKqNynBMFjYfgUAigAjQdXqwo1fZLn
        +2sErKyGWO6aEfko2J/uxbnD3mvL/jo37VoZ0R+IjluUmOHyRvtdmDVxNDp+6Fa86TsG/O/Lf/m
        ldH+dCnr1cFaVWrgGq2VQ/PKK
X-Received: by 2002:a05:6402:496:b0:443:a5f5:d3b with SMTP id k22-20020a056402049600b00443a5f50d3bmr6415338edv.331.1661507258585;
        Fri, 26 Aug 2022 02:47:38 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7ccetz0X+vRgf8dXBLUjgmbvkC66ddIfcP6peNdyvI0OTbvhRY84WEm7/mHPinLCfXrQmF8g==
X-Received: by 2002:a05:6402:496:b0:443:a5f5:d3b with SMTP id k22-20020a056402049600b00443a5f50d3bmr6415321edv.331.1661507258361;
        Fri, 26 Aug 2022 02:47:38 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id wh10-20020a170906fd0a00b0073cdeedf56fsm700655ejb.57.2022.08.26.02.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 02:47:37 -0700 (PDT)
Message-ID: <0a45a991-4123-a76c-174f-435523f6d348@redhat.com>
Date:   Fri, 26 Aug 2022 11:47:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 1/2] asus-wmi: Implement TUF laptop keyboard LED modes
Content-Language: en-US
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        pobrn@protonmail.com, pavel@ucw.cz
References: <20220825232251.345893-1-luke@ljones.dev>
 <20220825232251.345893-2-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220825232251.345893-2-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luke,

On 8/26/22 01:22, Luke D. Jones wrote:
> Adds support for changing the laptop keyboard LED mode and colour.
> 
> The modes are visible effects such as static, rainbow, pulsing,
> colour cycles.
> 
> These sysfs attributes are added to asus::kbd_backlight:
> - kbd_rgb_mode
> - kbd_rgb_mode_index
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-wmi.c            | 76 +++++++++++++++++++++-
>  include/linux/platform_data/x86/asus-wmi.h |  3 +
>  2 files changed, 78 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 0f9f79f249c7..92f16bb9b4ef 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -237,6 +237,8 @@ struct asus_wmi {
>  	bool dgpu_disable_available;
>  	bool gpu_mux_mode_available;
>  
> +	bool kbd_rgb_mode_available;
> +
>  	bool throttle_thermal_policy_available;
>  	u8 throttle_thermal_policy_mode;
>  
> @@ -720,6 +722,69 @@ static ssize_t gpu_mux_mode_store(struct device *dev,
>  }
>  static DEVICE_ATTR_RW(gpu_mux_mode);
>  
> +/* TUF Laptop Keyboard RGB Modes **********************************************/
> +static ssize_t kbd_rgb_mode_store(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t count)
> +{
> +	u32 cmd, mode, r, g,  b,  speed;
> +	int err;
> +
> +	if (sscanf(buf, "%d %d %d %d %d %d", &cmd, &mode, &r, &g, &b, &speed) != 6)
> +		return -EINVAL;
> +
> +	cmd = !!cmd;
> +
> +	/* These are the known usable modes across all TUF/ROG */
> +	if (mode >= 12 || mode == 9)
> +		mode = 10;
> +
> +	switch (speed) {
> +	case 0:
> +		speed = 0xe1;
> +		break;
> +	case 1:
> +		speed = 0xeb;
> +		break;
> +	case 2:
> +		speed = 0xf5;
> +		break;
> +	default:
> +		speed = 0xeb;
> +	}
> +
> +	err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS, ASUS_WMI_DEVID_TUF_RGB_MODE,
> +			cmd | (mode << 8) | (r << 16) | (g << 24), b | (speed << 8), NULL);
> +	if (err)
> +		return err;
> +
> +	return count;
> +}
> +static DEVICE_ATTR_WO(kbd_rgb_mode);
> +
> +static ssize_t kbd_rgb_mode_index_show(struct device *device,
> +						 struct device_attribute *attr,
> +						 char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", "cmd mode red green blue speed");
> +}
> +static DEVICE_ATTR_RO(kbd_rgb_mode_index);
> +
> +static struct attribute *kbd_rgb_mode_attrs[] = {
> +	&dev_attr_kbd_rgb_mode.attr,
> +	&dev_attr_kbd_rgb_mode_index.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group kbd_rgb_mode_group = {
> +	.attrs = kbd_rgb_mode_attrs,
> +};
> +
> +const struct attribute_group *kbd_rgb_mode_groups[] = {
> +	NULL,
> +	NULL,
> +};
> +
>  /* Battery ********************************************************************/
>  
>  /* The battery maximum charging percentage */
> @@ -1038,7 +1103,10 @@ static void asus_wmi_led_exit(struct asus_wmi *asus)
>  
>  static int asus_wmi_led_init(struct asus_wmi *asus)
>  {
> -	int rv = 0, led_val;
> +	int rv = 0, num_rgb_groups = 0, led_val;
> +
> +	if (asus->kbd_rgb_mode_available)
> +		kbd_rgb_mode_groups[num_rgb_groups++] = &kbd_rgb_mode_group;
>  
>  	asus->led_workqueue = create_singlethread_workqueue("led_workqueue");
>  	if (!asus->led_workqueue)
> @@ -1066,6 +1134,9 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
>  		asus->kbd_led.brightness_get = kbd_led_get;
>  		asus->kbd_led.max_brightness = 3;
>  
> +		if (num_rgb_groups != 0)
> +			asus->kbd_led.groups = kbd_rgb_mode_groups;
> +
>  		rv = led_classdev_register(&asus->platform_device->dev,
>  					   &asus->kbd_led);
>  		if (rv)
> @@ -3253,6 +3324,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
>  		ok = asus->egpu_enable_available;
>  	else if (attr == &dev_attr_dgpu_disable.attr)
>  		ok = asus->dgpu_disable_available;
> +	else if (attr == &dev_attr_dgpu_disable.attr)
> +		ok = asus->dgpu_disable_available;
>  	else if (attr == &dev_attr_gpu_mux_mode.attr)
>  		ok = asus->gpu_mux_mode_available;
>  	else if (attr == &dev_attr_fan_boost_mode.attr)

This patch-hunk looks like it is a (mangled) leftover from previous versions
of the patch.

Other then that this latest version of the series looks nice and clean,
so I've added the series to my review-hans branch minus this patch-hunk.

One request can you do a follow up patch documenting the new
attributes in Documentation/ABI/testing/sysfs-platform-asus-wmi
I know the attributes sit under the LED class device, but this
still seems the best place for documenting them.

Regards,

Hans




> @@ -3519,6 +3592,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>  	asus->egpu_enable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU);
>  	asus->dgpu_disable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_DGPU);
>  	asus->gpu_mux_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX);
> +	asus->kbd_rgb_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE);
>  	asus->panel_overdrive_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PANEL_OD);
>  
>  	err = fan_boost_mode_check_present(asus);
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index 6e8a95c10d17..3d861477cb20 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -103,6 +103,9 @@
>  /* gpu mux switch, 0 = dGPU, 1 = Optimus */
>  #define ASUS_WMI_DEVID_GPU_MUX		0x00090016
>  
> +/* TUF laptop RGB modes/colours */
> +#define ASUS_WMI_DEVID_TUF_RGB_MODE	0x00100056
> +
>  /* DSTS masks */
>  #define ASUS_WMI_DSTS_STATUS_BIT	0x00000001
>  #define ASUS_WMI_DSTS_UNKNOWN_BIT	0x00000002

