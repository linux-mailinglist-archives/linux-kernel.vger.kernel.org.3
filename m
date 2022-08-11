Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D768158FDC1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 15:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbiHKNxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 09:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbiHKNxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 09:53:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9017361DA7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 06:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660226003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SWuRKiT75z9a16q2MPD/aE6+mx39JiXpC1mrBGsKMEc=;
        b=LAaWfKhOFEMUGRR6a1TeW6JqYnMgoP7oLrVRaJNTBQAY2cSkL7N6k9LHRBk0b52677e5SK
        kqpg9izRE5no9mPdcERcwDzudu6oIwVpHcyswTAwQDBDG452x6iSjsdSDm1HnfQYiYNyaP
        lG15ansSOdwCBpXYVJHg4i0SQ34USfo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-622-kIhbANAwO42cPsP31RoxKg-1; Thu, 11 Aug 2022 09:53:21 -0400
X-MC-Unique: kIhbANAwO42cPsP31RoxKg-1
Received: by mail-ed1-f69.google.com with SMTP id z3-20020a056402274300b0043d4da3b4b5so10896638edd.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 06:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=SWuRKiT75z9a16q2MPD/aE6+mx39JiXpC1mrBGsKMEc=;
        b=gl5QMEpAmTYBwy5eIWMm6MoMi9GMAZr7jwr8Rsrkaiy6oIgSXkCIjhOfsswDoni7K5
         gZXosRTUbN2um8zs2u4NM5sN1Akne5f7q82OFIjoNt4Rmqu0XLD/GOdn/Gik7rQF8tkW
         eopJWoW/OuVmcy0TwO2eFf9CM07+qMvoZ2S/DheNcLY7M0OTps4F9P8H4bsCDFTcI3Ro
         BKVbeZBkqbAj618/oHfnQtqLkJxrktaYKCWxAHpd1eQAblgMqtz6z+nBQ7u1dyr+SI9j
         WXKYWeZAYMrAthnCq3Az9gjwnWi6HwtDLKzPj5xsQOXFoBcaC0frggsADcycYV4w61Jt
         t/VA==
X-Gm-Message-State: ACgBeo24OLPYf1KIdEPPHzX8ilSHTlqZjJAe1VLkb9KRAIryH2j25tzY
        YCvDmTUZnu7qa7ytavstYFjRoZCU6NfIPebp5lbXNkRI/YO8zBEu8VtjBqQucWyobVsQYfg890u
        VvlYEhR+Q7UqNceGPjUc+pEQR
X-Received: by 2002:aa7:d795:0:b0:43c:eb00:fc77 with SMTP id s21-20020aa7d795000000b0043ceb00fc77mr30641907edq.284.1660226000540;
        Thu, 11 Aug 2022 06:53:20 -0700 (PDT)
X-Google-Smtp-Source: AA6agR540u5ikNl8UGmWgyWIFhXPkhu0rJJ2YoL/XzzsPBpJPOELwxayiGQvp9cQrdS7rFWaTcE/pA==
X-Received: by 2002:aa7:d795:0:b0:43c:eb00:fc77 with SMTP id s21-20020aa7d795000000b0043ceb00fc77mr30641898edq.284.1660226000365;
        Thu, 11 Aug 2022 06:53:20 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id y2-20020a170906070200b007306df330e5sm3630873ejb.12.2022.08.11.06.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 06:53:19 -0700 (PDT)
Message-ID: <7365d41a-1475-118c-96a8-6ab927bda5b7@redhat.com>
Date:   Thu, 11 Aug 2022 15:53:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 6/6] asus-wmi: Support the hardware GPU MUX on some
 laptops
Content-Language: en-US
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     andy.shevchenko@gmail.com, pobrn@protonmail.com, pavel@ucw.cz,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220809025054.1626339-1-luke@ljones.dev>
 <20220809025054.1626339-7-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220809025054.1626339-7-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/9/22 04:50, Luke D. Jones wrote:
> Support the hardware GPU MUX switch available on some models. This
> switch can toggle the MUX between:
> 
> - 0, Dedicated mode
> - 1, Optimus mode
> 
> Optimus mode is the regular iGPU + dGPU available, while dedicated
> mode switches the system to have only the dGPU available.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

I see that you have replied to this that it needs more work.

Besides it needing more work, ideally this should hook into
the existing vga-switcheroo mechanism for this. Can you take
a look at that please?

I think this might be the first non GPU driver doing vga-
switcheroo stuff. So this may be something to discuss
on the dri-devel list.

And if things don't work out we can always go back to
just using an asus-wmi specific sysfs file for this as
is done in this patch.

Regards,

Hans



> ---
>  .../ABI/testing/sysfs-platform-asus-wmi       |  9 ++
>  drivers/platform/x86/asus-wmi.c               | 91 +++++++++++++++++++
>  include/linux/platform_data/x86/asus-wmi.h    |  3 +
>  3 files changed, 103 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> index 541dbfbbbb26..d483bc3cb2e6 100644
> --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> @@ -67,6 +67,15 @@ Description:
>  			* 0 - Disable,
>  			* 1 - Enable,
>  
> +What:		/sys/devices/platform/<platform>/gpu_mux_mode
> +Date:		Aug 2022
> +KernelVersion:	6.0
> +Contact:	"Luke Jones" <luke@ljones.dev>
> +Description:
> +		Switch the GPU used by the hardware MUX:
> +			* 0 - Dedicated GPU,
> +			* 1 - Optimus mode,
> +
>  What:		/sys/devices/platform/<platform>/panel_od
>  Date:		Aug 2022
>  KernelVersion:	5.17
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 78f1f3af1b12..c5fa21370481 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -246,6 +246,9 @@ struct asus_wmi {
>  	bool dgpu_disable_available;
>  	bool dgpu_disable;
>  
> +	bool gpu_mux_mode_available;
> +	bool gpu_mux_mode;
> +
>  	bool keyboard_rgb_state_available;
>  	bool keyboard_rgb_mode_available;
>  	struct keyboard_rgb_led keyboard_rgb_led;
> @@ -750,6 +753,86 @@ static ssize_t egpu_enable_store(struct device *dev,
>  
>  static DEVICE_ATTR_RW(egpu_enable);
>  
> +/* gpu mux switch *************************************************************/
> +static int gpu_mux_mode_check_present(struct asus_wmi *asus)
> +{
> +	u32 result;
> +	int err;
> +
> +	asus->gpu_mux_mode_available = false;
> +
> +	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_GPU_MUX, &result);
> +	if (err) {
> +		if (err == -ENODEV)
> +			return 0;
> +		return err;
> +	}
> +
> +	if (result & ASUS_WMI_DSTS_PRESENCE_BIT) {
> +		asus->gpu_mux_mode_available = true;
> +		asus->gpu_mux_mode = result & ASUS_WMI_DSTS_STATUS_BIT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int gpu_mux_mode_write(struct asus_wmi *asus)
> +{
> +	u32 retval;
> +	u8 value;
> +	int err;
> +
> +	/* Don't rely on type conversion */
> +	value = asus->gpu_mux_mode ? 1 : 0;
> +
> +	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_GPU_MUX, value, &retval);
> +	if (err) {
> +		pr_warn("Failed to set dGPU-only mode: %d\n", err);
> +		return err;
> +	}
> +
> +	if (retval > 1) {
> +		pr_warn("Failed to set dGPU-only mode (retval): 0x%x\n", retval);
> +		return -EIO;
> +	}
> +
> +	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "gpu_mux_mode");
> +
> +	return 0;
> +}
> +
> +static ssize_t gpu_mux_mode_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct asus_wmi *asus = dev_get_drvdata(dev);
> +	u8 mode = asus->gpu_mux_mode;
> +
> +	return sysfs_emit(buf, "%d\n", mode);
> +}
> +
> +static ssize_t gpu_mux_mode_store(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t count)
> +{
> +	bool optimus;
> +	int result;
> +
> +	struct asus_wmi *asus = dev_get_drvdata(dev);
> +
> +	result = kstrtobool(buf, &optimus);
> +	if (result)
> +		return result;
> +
> +	asus->gpu_mux_mode = optimus;
> +
> +	result = gpu_mux_mode_write(asus);
> +	if (result)
> +		return result;
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(gpu_mux_mode);
> +
>  /* TUF Laptop Keyboard RGB Modes **********************************************/
>  static int keyboard_rgb_check_present(struct asus_wmi *asus)
>  {
> @@ -3496,6 +3579,7 @@ static struct attribute *platform_attributes[] = {
>  	&dev_attr_touchpad.attr,
>  	&dev_attr_egpu_enable.attr,
>  	&dev_attr_dgpu_disable.attr,
> +	&dev_attr_gpu_mux_mode.attr,
>  	&dev_attr_keyboard_rgb_save.attr,
>  	&dev_attr_keyboard_rgb_mode.attr,
>  	&dev_attr_keyboard_rgb_speed.attr,
> @@ -3531,6 +3615,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
>  		ok = asus->egpu_enable_available;
>  	else if (attr == &dev_attr_dgpu_disable.attr)
>  		ok = asus->dgpu_disable_available;
> +	else if (attr == &dev_attr_gpu_mux_mode.attr)
> +		ok = asus->gpu_mux_mode_available;
>  	else if (attr == &dev_attr_keyboard_rgb_save.attr)
>  		ok = asus->keyboard_rgb_mode_available;
>  	else if (attr == &dev_attr_keyboard_rgb_mode.attr)
> @@ -3810,6 +3896,10 @@ static int asus_wmi_add(struct platform_device *pdev)
>  	if (err)
>  		goto fail_dgpu_disable;
>  
> +	err = gpu_mux_mode_check_present(asus);
> +	if (err)
> +		goto fail_gpu_mux_mode;
> +
>  	err = keyboard_rgb_check_present(asus);
>  	if (err)
>  		goto fail_keyboard_rgb_mode;
> @@ -3932,6 +4022,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>  fail_fan_boost_mode:
>  fail_egpu_enable:
>  fail_dgpu_disable:
> +fail_gpu_mux_mode:
>  fail_keyboard_rgb_mode:
>  fail_keyboard_rgb_state:
>  fail_platform:
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index b5c966798ef8..3faeb98f6ea9 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -98,6 +98,9 @@
>  /* dgpu on/off */
>  #define ASUS_WMI_DEVID_DGPU		0x00090020
>  
> +/* gpu mux switch, 0 = dGPU, 1 = Optimus */
> +#define ASUS_WMI_DEVID_GPU_MUX	0x00090016
> +
>  /* TUF laptop RGB control */
>  #define ASUS_WMI_DEVID_TUF_RGB_MODE	0x00100056
>  /* TUF laptop RGB state control */

