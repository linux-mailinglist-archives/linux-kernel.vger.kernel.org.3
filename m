Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4126C589C85
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239389AbiHDNWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbiHDNWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:22:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D1F926544
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 06:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659619326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hoIC5xUT6MvWbO14CCVaOuP3N4Wc5kwT1fweHc77iw4=;
        b=FRprgmdOfOZ1cDMoyumxcnsnm5jVWUQ8zE/OGgZdqetVc/i04YMgMMxBJsdx78CZXlsSmC
        QWduc9all9PveZAI+Xl25TDckO17cU1xgKOlYyhpyq81y6Z5w3qVGIIFADUkZkjJItFW8v
        G1pzdmIwNopq+I/v3MVQ8TNXUFgH6O4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-yI_fCZhmMJWvE6iRezWRAg-1; Thu, 04 Aug 2022 09:22:04 -0400
X-MC-Unique: yI_fCZhmMJWvE6iRezWRAg-1
Received: by mail-ed1-f72.google.com with SMTP id h6-20020a05640250c600b0043d9964d2ceso7823766edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 06:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hoIC5xUT6MvWbO14CCVaOuP3N4Wc5kwT1fweHc77iw4=;
        b=Es7mX2yvpGllvQd7HiikTkMxUGdGcV9RiLum//x8R4E0DKwnH3WmZvym6/X8i14g5L
         tchLw43YjN9LGW9J2PCsLeSFuKNSDA2WaU/gU4Mtf2ihyLB465RFP6EAaIpsuIIgJtHt
         JLgz5Sju2OVm0/Y2Pjd7n0Jn61yEedrfEoX2KSCRTHvp/ngEe0bZoCGiv//9kK4kQ6Mc
         9khyrIFD3dCqsxS5aZGRh/Pe2O+gPfkwF7UAT8RiXG6eEUn/hUGnub1zDCOlvG51gl2q
         ja2cCCXXDk0gax+3MdGTzF+idonLNZSbrvYNXyKzL+3KZPGaDi3DKTWb5lxoX7RNtJE3
         OAig==
X-Gm-Message-State: ACgBeo1oGdlg93XufgU854msu+Vns24aDza/4mvL68us9c0+kMOX80Zp
        0nmYIhj59ZQVykjETr3WCUzSVn9VVjwB9I8STlY6AwAnQne754wMMGFoj414+ye5fbicV2UTTRX
        3w/e4r4KpOSf8mOrkuOyKF63F
X-Received: by 2002:a17:907:3f8f:b0:730:9367:f9c2 with SMTP id hr15-20020a1709073f8f00b007309367f9c2mr1432220ejc.438.1659619323665;
        Thu, 04 Aug 2022 06:22:03 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7RUYYcV6wHHP6v2qRCFWlXi7XiVvcYgYaZGo552EeEIRjYO8FpqnxIG/wA5ucr6J0QRnoVjw==
X-Received: by 2002:a17:907:3f8f:b0:730:9367:f9c2 with SMTP id hr15-20020a1709073f8f00b007309367f9c2mr1432203ejc.438.1659619323417;
        Thu, 04 Aug 2022 06:22:03 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id 12-20020a508e4c000000b0043cbdb16fbbsm675712edx.24.2022.08.04.06.22.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 06:22:01 -0700 (PDT)
Message-ID: <db7f33c8-404d-6e41-73af-370e148a4eed@redhat.com>
Date:   Thu, 4 Aug 2022 15:22:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/1] asus-wmi: Add support for TUF laptop keyboard
 states
Content-Language: en-US
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220803231331.48788-1-luke@ljones.dev>
 <20220803231331.48788-2-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220803231331.48788-2-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luke,

On 8/4/22 01:13, Luke D. Jones wrote:
> Adds support for the TUF series laptop power states. This means
> control of if the LED's are on while awake, or an animation is
> shown while booting or suspended.
> 
> /sys/devices/platform/asus-nb-wmi/tuf_krgb_state_index provides
> labels for the index fields as "save boot awake sleep keyboard"
> 
> /sys/devices/platform/asus-nb-wmi/tuf_krgb_state has the following
> as input options via boolean "b b b b b":
> - Save or set, if set, then settings revert on cold boot
> - Boot, if true, the keyboard displays animation on boot
> - Awake, if true, the keyboard LED's are on while device is awake
> - Sleep, if true, the keyboard shows animation while device is suspended
> - Keybaord, appears to have no effect

Keybaord typo / spelling issue.

Please make this an extra attribute for the led_class_device,
you can do this by adding this attribute to a separate
attribute_group, lets say e.g. "tuf_rgb_attributes" and then
in the "[PATCH] asus-wmi: Add support for TUF laptop keyboard RGB"
code add:

	mc_cdev->led_cdev.groups = tuf_rgb_attributes;

and then the "tuf_krgb_state" file should show up as:
/sys/class/leds/asus::multicolour/tuf_krgb_state

Also I'm not sure what to think of the tuf_krgb_state_index file,
having a sysfs file just to show some help text feels weird / wrong.

Please instead document the expected format in the existing:
Documentation/ABI/testing/sysfs-platform-asus-wmi

file; and talking about that file, it seems that this file
could use some love to document other recently addes asus-wmi
features too.

Related to the tuf_krgb_state_index file, please use the
new sysfs_emit helper for all new show functions. And bonus
points for a patch (series?) converting old show functions
over to it.

Regards,

Hans





> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-wmi.c            | 95 ++++++++++++++++++++++
>  include/linux/platform_data/x86/asus-wmi.h |  3 +
>  2 files changed, 98 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 0e7fbed8a50d..bbfb054ff3b2 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -234,6 +234,8 @@ struct asus_wmi {
>  	bool dgpu_disable_available;
>  	bool dgpu_disable;
>  
> +	bool tuf_krgb_state_available;
> +
>  	bool throttle_thermal_policy_available;
>  	u8 throttle_thermal_policy_mode;
>  
> @@ -734,6 +736,86 @@ static ssize_t egpu_enable_store(struct device *dev,
>  
>  static DEVICE_ATTR_RW(egpu_enable);
>  
> +/* TUF Laptop Keyboard RGB States *********************************************/
> +static int tuf_krgb_state_check_present(struct asus_wmi *asus)
> +{
> +	u32 result;
> +	int err;
> +
> +	asus->tuf_krgb_state_available = false;
> +
> +	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_TUF_RGB_STATE, &result);
> +	if (err) {
> +		if (err == -ENODEV)
> +			return 0;
> +		return err;
> +	}
> +
> +	if (result & ASUS_WMI_DSTS_PRESENCE_BIT)
> +		asus->tuf_krgb_state_available = true;
> +
> +	return 0;
> +}
> +
> +static ssize_t tuf_krgb_state_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t count)
> +{
> +	int err;
> +	u32 ret;
> +	bool tmp;
> +	char *data, *part, *end;
> +	u8 save, flags, res, arg_num;
> +
> +	save = flags = arg_num = 0;
> +	data = end = kstrdup(buf, GFP_KERNEL);
> +
> +	while ((part = strsep(&end, " ")) != NULL) {
> +		if (part == NULL)
> +			return -1;
> +
> +		res = kstrtobool(part, &tmp);
> +		if (res)
> +			return -1;
> +
> +		if (tmp) {
> +			if (arg_num == 0) // save  :  set
> +				save = tmp == 0 ? 0x0100 : 0x0000;
> +			else if (arg_num == 1)
> +				flags |= 0x02; // boot
> +			else if (arg_num == 2)
> +				flags |= 0x08; // awake
> +			else if (arg_num == 3)
> +				flags |= 0x20; // sleep
> +			else if (arg_num == 4)
> +				flags |= 0x80; // keyboard
> +		}
> +
> +		arg_num += 1;
> +	}
> +
> +	err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS,
> +			ASUS_WMI_DEVID_TUF_RGB_STATE, 0xBD | save | (flags << 16), 0, &ret);
> +	if (err) {
> +			return err;
> +	}
> +
> +	kfree(data);
> +	return count;
> +}
> +
> +static DEVICE_ATTR_WO(tuf_krgb_state);
> +
> +static ssize_t tuf_krgb_state_index_show(struct device *device,
> +						 struct device_attribute *attr,
> +						 char *buf)
> +{
> +	int len = sprintf(buf, "%s", "save boot awake sleep keyboard\n");
> +	return len;
> +}
> +
> +static DEVICE_ATTR_RO(tuf_krgb_state_index);
> +
>  /* Battery ********************************************************************/
>  
>  /* The battery maximum charging percentage */
> @@ -3258,6 +3340,8 @@ static struct attribute *platform_attributes[] = {
>  	&dev_attr_touchpad.attr,
>  	&dev_attr_egpu_enable.attr,
>  	&dev_attr_dgpu_disable.attr,
> +	&dev_attr_tuf_krgb_state.attr,
> +	&dev_attr_tuf_krgb_state_index.attr,
>  	&dev_attr_lid_resume.attr,
>  	&dev_attr_als_enable.attr,
>  	&dev_attr_fan_boost_mode.attr,
> @@ -3286,6 +3370,12 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
>  		devid = ASUS_WMI_DEVID_ALS_ENABLE;
>  	else if (attr == &dev_attr_egpu_enable.attr)
>  		ok = asus->egpu_enable_available;
> +	else if (attr == &dev_attr_tuf_krgb_state.attr)
> +		ok = asus->tuf_krgb_state_available;
> +	else if (attr == &dev_attr_tuf_krgb_state_index.attr)
> +		ok = asus->tuf_krgb_state_available;
> +	else if (attr == &dev_attr_dgpu_disable.attr)
> +		ok = asus->dgpu_disable_available;
>  	else if (attr == &dev_attr_dgpu_disable.attr)
>  		ok = asus->dgpu_disable_available;
>  	else if (attr == &dev_attr_fan_boost_mode.attr)
> @@ -3557,6 +3647,10 @@ static int asus_wmi_add(struct platform_device *pdev)
>  	if (err)
>  		goto fail_dgpu_disable;
>  
> +	err = tuf_krgb_state_check_present(asus);
> +	if (err)
> +		goto fail_tuf_krgb_state;
> +
>  	err = fan_boost_mode_check_present(asus);
>  	if (err)
>  		goto fail_fan_boost_mode;
> @@ -3671,6 +3765,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>  fail_fan_boost_mode:
>  fail_egpu_enable:
>  fail_dgpu_disable:
> +fail_tuf_krgb_state:
>  fail_platform:
>  fail_panel_od:
>  	kfree(asus);
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index a571b47ff362..a95b37385e66 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -98,6 +98,9 @@
>  /* dgpu on/off */
>  #define ASUS_WMI_DEVID_DGPU		0x00090020
>  
> +/* TUF laptop RGB power/state */
> +#define ASUS_WMI_DEVID_TUF_RGB_STATE	0x00100057
> +
>  /* DSTS masks */
>  #define ASUS_WMI_DSTS_STATUS_BIT	0x00000001
>  #define ASUS_WMI_DSTS_UNKNOWN_BIT	0x00000002

