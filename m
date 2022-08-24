Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C187B59FACD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237873AbiHXND0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237887AbiHXNDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:03:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42B097ED3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 06:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661346201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cHlGdkZ8cjqGXDFrYUZ4f7u44SK7+WzvZn4udWPH5o4=;
        b=QKq0fr9dommAyQxMYTLB3qGPM1I2YmXcY8rRhp81c0/Fc6sBn0x/qCvUsRcI27xtmg0pPY
        i6ZHUeNj9p5/oR8LH+wwmQ+l+vBz6jPtKtNL9qWnJkO6qtUEttUJtc4axq89mWDPMd9vEQ
        JLE2lKzmle0Tsq/3gBqGVeRIN2xEWm4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-218-CnyCEkhZPUOo5kE1qdzNDQ-1; Wed, 24 Aug 2022 09:03:19 -0400
X-MC-Unique: CnyCEkhZPUOo5kE1qdzNDQ-1
Received: by mail-ed1-f72.google.com with SMTP id b13-20020a056402350d00b0043dfc84c533so10754417edd.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 06:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=cHlGdkZ8cjqGXDFrYUZ4f7u44SK7+WzvZn4udWPH5o4=;
        b=rdxPOsB20Jwsn38RHfTGsAvfmS75MPjjXwstouGoHJ2sLRcwpqZs3aniH12dfwy6MF
         VTu0xKtxAFdsfMgvUb0OhKSqq/ksFhNoKSE6ZMHxAbPqGea6pR3AzazN24e89YO6BZOM
         pWpuauL09059dvK64zMceZMutPNpTVFIFP4Fz53HZtSGmJOBjxZThlxdtT5WbaNtRYeH
         To7Dar+AyXcpSd7+bzLsXJkmkHzW4wh5SQNOaEgVFETWvUsHJJIu2bAISN9bJkhMhlfx
         CxIZc2NzDp1UFdUntl9xfUt84oPFpAM4GPbsvAx7m3NpOpjyWUsWUPz3/wT/kZxH7hBK
         X9+g==
X-Gm-Message-State: ACgBeo2ieyT6xkNv6qxkkXwxNSfvnPgM0nkUarVzGOjOlBEhzhDl/yXB
        kVVT5pZP3TKSAnzJ7yz9d4uWVIL8W7jc7seNGVd2WngZCOqDiLHzNyG6QYD3p6+7TsVXWpjdvnY
        yZ0RKUgs0KpOtyExr+dLS7o6e
X-Received: by 2002:aa7:c946:0:b0:43d:3038:1381 with SMTP id h6-20020aa7c946000000b0043d30381381mr7626667edt.354.1661346197578;
        Wed, 24 Aug 2022 06:03:17 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6Z4Ix8mkYRJYuQbNsZ9ADw11tosiW67CVFn9u5BqyDPXPdXDAH3Msicx6FSlXzJgY29dTZzg==
X-Received: by 2002:aa7:c946:0:b0:43d:3038:1381 with SMTP id h6-20020aa7c946000000b0043d30381381mr7626626edt.354.1661346197048;
        Wed, 24 Aug 2022 06:03:17 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id s10-20020a170906c30a00b006fef0c7072esm1128659ejz.144.2022.08.24.06.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 06:03:16 -0700 (PDT)
Message-ID: <fda6b7fc-b307-f4f3-1176-6b15c639b3d0@redhat.com>
Date:   Wed, 24 Aug 2022 15:03:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] asus-wmi: Support the hardware GPU MUX on some laptops
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Luke Jones <luke@ljones.dev>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220813092624.6228-1-luke@ljones.dev>
 <e186622e-f3e6-5715-9f6d-bc41fb41560d@amd.com>
 <UVMZGR.6LXKPONA9OS33@ljones.dev>
 <6f7df43d-292d-3a6b-76bc-09d669733939@amd.com>
 <4e4c5234-3327-0e49-989c-1117ffb2f13d@redhat.com>
 <34bf5d3a-adb6-ce12-8c9c-ee9144f5262d@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <34bf5d3a-adb6-ce12-8c9c-ee9144f5262d@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/24/22 14:53, Mario Limonciello wrote:
> On 8/24/22 07:40, Hans de Goede wrote:
>> Hi All,
>>
>> On 8/22/22 17:43, Limonciello, Mario wrote:
>>> On 8/21/2022 18:07, Luke Jones wrote:
>>>> Hi Mario,
>>>>
>>>> On Mon, Aug 15 2022 at 23:16:12 -0500, Mario Limonciello <mario.limonciello@amd.com> wrote:
>>>>> On 8/13/22 04:26, Luke D. Jones wrote:
>>>>>> Support the hardware GPU MUX switch available on some models. This
>>>>>> switch can toggle the MUX between:
>>>>>>
>>>>>> - 0, Dedicated mode
>>>>>> - 1, Optimus mode
>>>>>>
>>>>>> Optimus mode is the regular iGPU + dGPU available, while dedicated
>>>>>> mode switches the system to have only the dGPU available.
>>>>>>
>>>>>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>>>>> ---
>>>>>>    .../ABI/testing/sysfs-platform-asus-wmi       | 11 ++++
>>>>>>    drivers/platform/x86/asus-wmi.c               | 62 +++++++++++++++++++
>>>>>>    include/linux/platform_data/x86/asus-wmi.h    |  3 +
>>>>>>    3 files changed, 76 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>>>>> index 574b5170a37d..03124eab7f01 100644
>>>>>> --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>>>>> +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>>>>> @@ -58,6 +58,17 @@ Description:
>>>>>>                * 1 - overboost,
>>>>>>                * 2 - silent
>>>>>>    +What:          /sys/devices/platform/<platform>/gpu_mux_mode
>>>>>> +Date:          Aug 2022
>>>>>> +KernelVersion: 6.1
>>>>>> +Contact:       "Luke Jones" <luke@ljones.dev>
>>>>>> +Description:
>>>>>> +               Switch the GPU hardware MUX mode. Laptops with this feature can
>>>>>> +               can be toggled to boot with only the dGPU (discrete mode) or in
>>>>>> +               standard Optimus/Hybrid mode. On switch a reboot is required:
>>>>>> +                       * 0 - Discrete GPU,
>>>>>> +                       * 1 - Optimus/Hybrid,
>>>>>
>>>>> This feel like it should probably export using /sys/class/firmware-attributes.  That's exactly how those types of attributes work.
>>>>>
>>>>> As a bonus, software like fwupd 1.8.4 knows how to manipulate it and you don't need special documentation.
>>>>>
>>>>>> +
>>>>>>    What:          /sys/devices/platform/<platform>/dgpu_disable
>>>>>>    Date:          Aug 2022
>>>>>>    KernelVersion: 5.17
>>>>>> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
>>>>>> index e2b51b5550e8..0421ffb81927 100644
>>>>>> --- a/drivers/platform/x86/asus-wmi.c
>>>>>> +++ b/drivers/platform/x86/asus-wmi.c
>>>>>> @@ -230,6 +230,7 @@ struct asus_wmi {
>>>>>>          bool egpu_enable_available;
>>>>>>        bool dgpu_disable_available;
>>>>>> +    bool gpu_mux_mode_available;
>>>>>>          bool throttle_thermal_policy_available;
>>>>>>        u8 throttle_thermal_policy_mode;
>>>>>> @@ -668,6 +669,59 @@ static ssize_t egpu_enable_store(struct device *dev,
>>>>>>    }
>>>>>>    static DEVICE_ATTR_RW(egpu_enable);
>>>>>>    +/* gpu mux switch *************************************************************/
>>>>>> +static int gpu_mux_mode_check_present(struct asus_wmi *asus)
>>>>>> +{
>>>>>> +    asus->gpu_mux_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX);
>>>>>> +
>>>>>> +   return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static ssize_t gpu_mux_mode_show(struct device *dev,
>>>>>> +                  struct device_attribute *attr, char *buf)
>>>>>> +{
>>>>>> +   struct asus_wmi *asus = dev_get_drvdata(dev);
>>>>>> +   int result;
>>>>>> +
>>>>>> +   result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GPU_MUX);
>>>>>> +   if (result < 0)
>>>>>> +       return result;
>>>>>> +
>>>>>> +   return sysfs_emit(buf, "%d\n", result);
>>>>>> +}
>>>>>> +
>>>>>> +static ssize_t gpu_mux_mode_store(struct device *dev,
>>>>>> +                   struct device_attribute *attr,
>>>>>> +                   const char *buf, size_t count)
>>>>>> +{
>>>>>> +   struct asus_wmi *asus = dev_get_drvdata(dev);
>>>>>> +   int result, err;
>>>>>> +   u32 optimus;
>>>>>> +
>>>>>> +   err = kstrtou32(buf, 10, &optimus);
>>>>>> +   if (err)
>>>>>> +       return err;
>>>>>> +
>>>>>> +   if (optimus > 1)
>>>>>> +       return -EINVAL;
>>>>>> +
>>>>>> +   err = asus_wmi_set_devstate(ASUS_WMI_DEVID_GPU_MUX, optimus, &result);
>>>>>> +   if (err) {
>>>>>> +       dev_err(dev, "Failed to set GPU MUX mode: %d\n", err);
>>>>>> +       return err;
>>>>>> +   }
>>>>>> +    /* !1 is considered a fail by ASUS */
>>>>>> +    if (result != 1) {
>>>>>> +        dev_warn(dev, "Failed to set GPU MUX mode (result): 0x%x\n", result);
>>>>>> +       return -EIO;
>>>>>> +   }
>>>>>> +
>>>>>> +   sysfs_notify(&asus->platform_device->dev.kobj, NULL, "gpu_mux_mode");
>>>>>> +
>>>>>> +   return count;
>>>>>> +}
>>>>>> +static DEVICE_ATTR_RW(gpu_mux_mode);
>>>>>> +
>>>>>>    /* Battery ********************************************************************/
>>>>>>      /* The battery maximum charging percentage */
>>>>>> @@ -3165,6 +3219,7 @@ static struct attribute *platform_attributes[] = {
>>>>>>        &dev_attr_touchpad.attr,
>>>>>>        &dev_attr_egpu_enable.attr,
>>>>>>        &dev_attr_dgpu_disable.attr,
>>>>>> +    &dev_attr_gpu_mux_mode.attr,
>>>>>>        &dev_attr_lid_resume.attr,
>>>>>>        &dev_attr_als_enable.attr,
>>>>>>        &dev_attr_fan_boost_mode.attr,
>>>>>> @@ -3195,6 +3250,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
>>>>>>            ok = asus->egpu_enable_available;
>>>>>>        else if (attr == &dev_attr_dgpu_disable.attr)
>>>>>>            ok = asus->dgpu_disable_available;
>>>>>> +    else if (attr == &dev_attr_gpu_mux_mode.attr)
>>>>>> +        ok = asus->gpu_mux_mode_available;
>>>>>>        else if (attr == &dev_attr_fan_boost_mode.attr)
>>>>>>            ok = asus->fan_boost_mode_available;
>>>>>>        else if (attr == &dev_attr_throttle_thermal_policy.attr)
>>>>>> @@ -3464,6 +3521,10 @@ static int asus_wmi_add(struct platform_device *pdev)
>>>>>>        if (err)
>>>>>>            goto fail_dgpu_disable;
>>>>>>    +    err = gpu_mux_mode_check_present(asus);
>>>>>> +   if (err)
>>>>>> +       goto fail_gpu_mux_mode;
>>>>>> +
>>>>>>        err = fan_boost_mode_check_present(asus);
>>>>>>        if (err)
>>>>>>            goto fail_fan_boost_mode;
>>>>>> @@ -3578,6 +3639,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>>>>>>    fail_fan_boost_mode:
>>>>>>    fail_egpu_enable:
>>>>>>    fail_dgpu_disable:
>>>>>> +fail_gpu_mux_mode:
>>>>>>    fail_platform:
>>>>>>    fail_panel_od:
>>>>>>        kfree(asus);
>>>>>> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
>>>>>> index a571b47ff362..c023332842a2 100644
>>>>>> --- a/include/linux/platform_data/x86/asus-wmi.h
>>>>>> +++ b/include/linux/platform_data/x86/asus-wmi.h
>>>>>> @@ -98,6 +98,9 @@
>>>>>>    /* dgpu on/off */
>>>>>>    #define ASUS_WMI_DEVID_DGPU        0x00090020
>>>>>>    +/* gpu mux switch, 0 = dGPU, 1 = Optimus */
>>>>>> +#define ASUS_WMI_DEVID_GPU_MUX 0x00090016
>>>>>> +
>>>>>>    /* DSTS masks */
>>>>>>    #define ASUS_WMI_DSTS_STATUS_BIT    0x00000001
>>>>>>    #define ASUS_WMI_DSTS_UNKNOWN_BIT    0x00000002
>>>>>
>>>>
>>>> You can see previous discussion here https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fplatform-driver-x86%2Fc3bb0989-78d9-c513-1669-75407b2acbac%40redhat.com%2F&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7C54f5129bf4ad437bd11108da85cde220%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637969416575174610%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=GqFSQY5%2BVJCX1Wytp5mGq54rcx6ks9sKrGdGFf2WtNI%3D&amp;reserved=0
>>>>
>>>> Below is Hans response verbatim:
>>>>
>>>>   > Yes it sounds like a BIOS setting is being toggled from within
>>>>   > Linux, which would normally be done through the
>>>>   > "firmware-attributes" class, but all existing "firmware-attributes"
>>>>   > class drivers allow changing all BIOS setting not just a single
>>>>   > setting, so using the  "firmware-attributes" class here is not really
>>>>   > appropriate.
>>>>
>>>
>>> Although the two consumers thus far (Lenovo and Dell) use WMI interfaces to build and discover varieties of settings there is no requirement for how the backend for firwmare-attributes works.  You can just as well poulate a single attribute statically from your driver.
>>>
>>> So I guess Hans and I disagree here.  I have a feeling that we shouldn't be introducing custom ABI to userspace just because only "one" setting is offered.  I anticipate that some day the DE's will offer a GUI setting built on top of fwupd which is built on top of firmware-attributes.
>>>
>>> If you *don't* populate a setting with firmware-attributes the only way that users will discover such a setting is by installing other custom userspace software that has the knowledge of it.
>>>
>>> At the end of the day it's up to Hans and Mark though, this is just my 2c.
>>
>> Mario, thank you for your input here, it is much appreciated.
>>
>> As Luke mentioned in my quote using the firmware-attributes class for this really seems like overkill. As for discoverability, the firmware-attributes class only standardizes how to enum / change BIOS settings. The consumer of the API still must now the name of the setting which can/will be different per vendor.
>>
>> AFAIK fwupd only uses the firmware-attributes class to check for / disable some BIOS flashing protection. So having the GPU mux setting in the firmware-attributes class is not really relevant for fwupd.
>>
>> If in the future some generic tool which uses the firmware-attributes class to toggle GPU muxes is created (presumably with a lookup table for the exact setting's name under the firmare-attributes API) then we can always add firmware-attributes support for the GPU mux to asus-wmi at that point in time.
>>
>> I just don't think it is likely such a generic tool will happen (any time soon), so for now I still believe that using the firmware-attributes class for this is not necessary.
>>
> 
> Actually I've been actively working on that.  Take a look at fwupd main (what will go into the next tagged 1.8.4 release).
> 
> It's got support for "fwupdmgr get-bios-settings" and "fwupdmgr set-bios-settings" which will follow the rules the kernel API uses.
> 
> So I expect that if this attribute was implemented as I suggested you could do:
> 
> # fwupdmgr get-bios-settings
> 
> and find the mux (including the possible values if it's declared a kernel enumeration attribute and possible_values is populated).  If you populate the optional description attribute in the kernel fwupd will show you what your enumerated settings mean.
> 
> followed by:
> 
> # fwupdmgr set-bios-setting dGPUMux iGPU
> or
> # fwupdmgr set-bios-setting dGPUMux dGPU
> 
> To set it.
> 
> fwupd will prompt you to reboot the system after it's done changing it as well.
> 
> It's implemented such that GUI clients can use libfwupd just the same, and I really think this increases discoverability of such a setting.

Interesting, I must admit that that makes your argument for using the firmware-attributes class stronger.

But in the end it IMHO still feels wrong to add firmware-attribute support for just a single setting, rather then for something which actually exports all or most BIOS settings.

So for now I'm going to with this patch as is. If eventually it turns out that having this inside the firmware-attributes class would be really useful we can add it later, while keeping the sysfs attr for backward compat. My thinking being here that the code for the single sysfs attr is quite small, where as adding firmware-attributes class support will be more involved.

Regards,

Hans

