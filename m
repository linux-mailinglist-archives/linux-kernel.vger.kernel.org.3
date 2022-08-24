Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4BD59FC4D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238773AbiHXNzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238724AbiHXNyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:54:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143809A9BF
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 06:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661349116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CXkViq0AL4M4jKlvREvWic60usHrsSFfTWZqwClV86Y=;
        b=fg9vQdvFG/45uYoEHs6BZ1PYktTxuRn5KVXkDL1ibEAnjfD5ZKiHVs1Es61rs+fHWJ4aSz
        9dZPCaBcqd5Ty7MxshCg+l8neYpom9tqhhcMX+7zPbdAktM8dAkCvg1lZTk6XnDugtqSW/
        4cTVa4HrI1ISQn3HOBWcRQ61okQA4iE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-193-YU2NB1A9OCmhM4KVxvkRdw-1; Wed, 24 Aug 2022 09:51:54 -0400
X-MC-Unique: YU2NB1A9OCmhM4KVxvkRdw-1
Received: by mail-ed1-f72.google.com with SMTP id q32-20020a05640224a000b004462f105fa9so9770107eda.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 06:51:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=CXkViq0AL4M4jKlvREvWic60usHrsSFfTWZqwClV86Y=;
        b=MPNqlaoTTpZqRmeD6uQYQGWnY5Pv1ot1WLsxgf7OUMw1AKyGJAvgXAum/j+d5ckBjD
         CNJRlj62HNY3/T4p7tL+pf/UvpgQfkI06ZOWRX3BivZlTFpIb5zP31nmVyir+g5h59Nu
         WYwgYmOSetpTygGKOCtA0Vjpgr/VprMGc4nHoqn3E7aTb+yrPPjngGdnFU1MgIQ1D0LB
         phgYSa/2F16825eL/H0ZZfQd4n8rqSaH3zi7kdP245gR1Eo3AudumXgO5wgF+f/dBN8k
         Vmgyr7gemCzEBWLnvVdx9eS7+SAGbS91bsHQr+s7Kz/PyhZWhB13VOHFSbuzeXxh0JHW
         nDJA==
X-Gm-Message-State: ACgBeo0/vSNumNHEHTxb6TIq8WnY+XNzqd9BoxdegRg4h47RuN/6R2g6
        8YSgKOSIuxnmsCu+2l37JqrDyvkY0/uoVXHmQzgL1j4ZnXbLwUsIv5g9sYAJ5Ft6m5BYTmeHUIF
        tzkkrNbs8kz7PD5yiLtfmqeu/
X-Received: by 2002:a17:906:5a4c:b0:73d:60b8:618c with SMTP id my12-20020a1709065a4c00b0073d60b8618cmr3019850ejc.740.1661349112209;
        Wed, 24 Aug 2022 06:51:52 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7jVVal+ZBOJliVJemZcZdjoAJ/YIbvtSmhX0ToQoagmAazizDmmBCKCHbfnCBU0inxmW0xDQ==
X-Received: by 2002:a17:906:5a4c:b0:73d:60b8:618c with SMTP id my12-20020a1709065a4c00b0073d60b8618cmr3019841ejc.740.1661349111953;
        Wed, 24 Aug 2022 06:51:51 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id c9-20020a17090618a900b007311eb42e40sm1228393ejf.54.2022.08.24.06.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 06:51:51 -0700 (PDT)
Message-ID: <44b937bf-dff7-c301-1c5e-51fb1aed87e8@redhat.com>
Date:   Wed, 24 Aug 2022 15:51:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] asus-wmi: Support the hardware GPU MUX on some laptops
Content-Language: en-US
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220813092624.6228-1-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220813092624.6228-1-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/13/22 11:26, Luke D. Jones wrote:
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

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note there were several whitespace/indentation issues with this
patch. The documentation patch was using spaces instead of tabs
and the .c changes where using 3 space indents instead of tabs
in some places. I've fixed this up while merging this time around,
but for future submissions please ensure that you get the indentation
right and that you only use tabs and not spaces.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

> ---
>  .../ABI/testing/sysfs-platform-asus-wmi       | 11 ++++
>  drivers/platform/x86/asus-wmi.c               | 62 +++++++++++++++++++
>  include/linux/platform_data/x86/asus-wmi.h    |  3 +
>  3 files changed, 76 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> index 574b5170a37d..03124eab7f01 100644
> --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> @@ -58,6 +58,17 @@ Description:
>  			* 1 - overboost,
>  			* 2 - silent
>  
> +What:          /sys/devices/platform/<platform>/gpu_mux_mode
> +Date:          Aug 2022
> +KernelVersion: 6.1
> +Contact:       "Luke Jones" <luke@ljones.dev>
> +Description:
> +               Switch the GPU hardware MUX mode. Laptops with this feature can
> +			   can be toggled to boot with only the dGPU (discrete mode) or in
> +			   standard Optimus/Hybrid mode. On switch a reboot is required:
> +                       * 0 - Discrete GPU,
> +                       * 1 - Optimus/Hybrid,
> +
>  What:          /sys/devices/platform/<platform>/dgpu_disable
>  Date:          Aug 2022
>  KernelVersion: 5.17
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index e2b51b5550e8..0421ffb81927 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -230,6 +230,7 @@ struct asus_wmi {
>  
>  	bool egpu_enable_available;
>  	bool dgpu_disable_available;
> +	bool gpu_mux_mode_available;
>  
>  	bool throttle_thermal_policy_available;
>  	u8 throttle_thermal_policy_mode;
> @@ -668,6 +669,59 @@ static ssize_t egpu_enable_store(struct device *dev,
>  }
>  static DEVICE_ATTR_RW(egpu_enable);
>  
> +/* gpu mux switch *************************************************************/
> +static int gpu_mux_mode_check_present(struct asus_wmi *asus)
> +{
> +	asus->gpu_mux_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX);
> +
> +   return 0;
> +}
> +
> +static ssize_t gpu_mux_mode_show(struct device *dev,
> +                  struct device_attribute *attr, char *buf)
> +{
> +   struct asus_wmi *asus = dev_get_drvdata(dev);
> +   int result;
> +
> +   result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GPU_MUX);
> +   if (result < 0)
> +       return result;
> +
> +   return sysfs_emit(buf, "%d\n", result);
> +}
> +
> +static ssize_t gpu_mux_mode_store(struct device *dev,
> +                   struct device_attribute *attr,
> +                   const char *buf, size_t count)
> +{
> +   struct asus_wmi *asus = dev_get_drvdata(dev);
> +   int result, err;
> +   u32 optimus;
> +
> +   err = kstrtou32(buf, 10, &optimus);
> +   if (err)
> +       return err;
> +
> +   if (optimus > 1)
> +       return -EINVAL;
> +
> +   err = asus_wmi_set_devstate(ASUS_WMI_DEVID_GPU_MUX, optimus, &result);
> +   if (err) {
> +       dev_err(dev, "Failed to set GPU MUX mode: %d\n", err);
> +       return err;
> +   }
> +	/* !1 is considered a fail by ASUS */
> +	if (result != 1) {
> +		dev_warn(dev, "Failed to set GPU MUX mode (result): 0x%x\n", result);
> +       return -EIO;
> +   }
> +
> +   sysfs_notify(&asus->platform_device->dev.kobj, NULL, "gpu_mux_mode");
> +
> +   return count;
> +}
> +static DEVICE_ATTR_RW(gpu_mux_mode);
> +
>  /* Battery ********************************************************************/
>  
>  /* The battery maximum charging percentage */
> @@ -3165,6 +3219,7 @@ static struct attribute *platform_attributes[] = {
>  	&dev_attr_touchpad.attr,
>  	&dev_attr_egpu_enable.attr,
>  	&dev_attr_dgpu_disable.attr,
> +	&dev_attr_gpu_mux_mode.attr,
>  	&dev_attr_lid_resume.attr,
>  	&dev_attr_als_enable.attr,
>  	&dev_attr_fan_boost_mode.attr,
> @@ -3195,6 +3250,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
>  		ok = asus->egpu_enable_available;
>  	else if (attr == &dev_attr_dgpu_disable.attr)
>  		ok = asus->dgpu_disable_available;
> +	else if (attr == &dev_attr_gpu_mux_mode.attr)
> +		ok = asus->gpu_mux_mode_available;
>  	else if (attr == &dev_attr_fan_boost_mode.attr)
>  		ok = asus->fan_boost_mode_available;
>  	else if (attr == &dev_attr_throttle_thermal_policy.attr)
> @@ -3464,6 +3521,10 @@ static int asus_wmi_add(struct platform_device *pdev)
>  	if (err)
>  		goto fail_dgpu_disable;
>  
> +	err = gpu_mux_mode_check_present(asus);
> +   if (err)
> +       goto fail_gpu_mux_mode;
> +
>  	err = fan_boost_mode_check_present(asus);
>  	if (err)
>  		goto fail_fan_boost_mode;
> @@ -3578,6 +3639,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>  fail_fan_boost_mode:
>  fail_egpu_enable:
>  fail_dgpu_disable:
> +fail_gpu_mux_mode:
>  fail_platform:
>  fail_panel_od:
>  	kfree(asus);
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index a571b47ff362..c023332842a2 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -98,6 +98,9 @@
>  /* dgpu on/off */
>  #define ASUS_WMI_DEVID_DGPU		0x00090020
>  
> +/* gpu mux switch, 0 = dGPU, 1 = Optimus */
> +#define ASUS_WMI_DEVID_GPU_MUX 0x00090016
> +
>  /* DSTS masks */
>  #define ASUS_WMI_DSTS_STATUS_BIT	0x00000001
>  #define ASUS_WMI_DSTS_UNKNOWN_BIT	0x00000002

