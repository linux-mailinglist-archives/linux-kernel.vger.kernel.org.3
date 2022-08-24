Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D5359FA22
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 14:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbiHXMk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 08:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236653AbiHXMkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:40:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A262572FC1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661344851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=snxgbYIvB7W9xGqWBSsL2b/y//Xe8NQxVY3RsWqXnoE=;
        b=ddmtI2hd8MjC+G59ebpmQoWLVI20hWX/coZ8xpkq6uOZHuDV7kr/dRruCIqbJMG3xmbtnw
        DddLBIHdOWDtkM3QZWbSTDOPvltL/hif+1IXDqQOJMfrBpAaObEcnbkq2TcYIk7s6c7QsH
        Ra3auUdly6kwZ9IvwriUI+oroeYWEis=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-139-_ta5-P3HO7Co0KhhDA2zDA-1; Wed, 24 Aug 2022 08:40:50 -0400
X-MC-Unique: _ta5-P3HO7Co0KhhDA2zDA-1
Received: by mail-ed1-f70.google.com with SMTP id h17-20020a05640250d100b00446d1825c9fso5260327edb.14
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:40:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=snxgbYIvB7W9xGqWBSsL2b/y//Xe8NQxVY3RsWqXnoE=;
        b=GWwD2eryrE+akulwePMjF6H9pJNkKB0hJJiUhxioQpWeRHWDgEQmxWy1O5ASAAdBzO
         0s1Lck9aq1N4a1LBHlnCzJALjnPf6IDxiOgvYi4ZOWSX49pzdG+t2GbYGd9BTVbWyCX9
         UG1BBxACzdWXRT2Y+6wSRHfyEd03XSxNG1xY2PWA/A/uuFxVL2l/eXiAfPyuwfrULan8
         Go1kSUdG08kNK6akd+HDC96kARMqIWgCU9KszVFVpMEoqxt++sZ6C43S6LkkXbVVEIKU
         uh2iw2f66ZS8fFmhnKtbzn4zui80ukl5CzEVtRFvkOIvW4VufbDG5fCYrBRg5KjAV/56
         l/pg==
X-Gm-Message-State: ACgBeo0k9QfZSJgnzkcnWg7XdzODXLZtWH+gMqZE4TuphrvZV+3E+C6m
        mAXqKS/CFlryyyaRt2W7PVuXUHbwvOuIABi4dPtZz+yGuPhB7fKs2gu8KgD0X7Ctpj1CHY/7jmP
        aE6F88FRjJAumG0QJ/zTQZzX0
X-Received: by 2002:a17:907:5ce:b0:730:bae0:deb with SMTP id wg14-20020a17090705ce00b00730bae00debmr2878590ejb.181.1661344849516;
        Wed, 24 Aug 2022 05:40:49 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4aFz5dDXm1oUSowvBPmFllgXFDMjcX3zuJcg+pLy3X3Ai70p0u+oYPR9XCFa6ZlzLdHutiLw==
X-Received: by 2002:a17:907:5ce:b0:730:bae0:deb with SMTP id wg14-20020a17090705ce00b00730bae00debmr2878582ejb.181.1661344849285;
        Wed, 24 Aug 2022 05:40:49 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id e3-20020a170906314300b00730860b6c43sm1120169eje.173.2022.08.24.05.40.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 05:40:48 -0700 (PDT)
Message-ID: <4e4c5234-3327-0e49-989c-1117ffb2f13d@redhat.com>
Date:   Wed, 24 Aug 2022 14:40:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] asus-wmi: Support the hardware GPU MUX on some laptops
Content-Language: en-US
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        Luke Jones <luke@ljones.dev>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220813092624.6228-1-luke@ljones.dev>
 <e186622e-f3e6-5715-9f6d-bc41fb41560d@amd.com>
 <UVMZGR.6LXKPONA9OS33@ljones.dev>
 <6f7df43d-292d-3a6b-76bc-09d669733939@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <6f7df43d-292d-3a6b-76bc-09d669733939@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 8/22/22 17:43, Limonciello, Mario wrote:
> On 8/21/2022 18:07, Luke Jones wrote:
>> Hi Mario,
>>
>> On Mon, Aug 15 2022 at 23:16:12 -0500, Mario Limonciello <mario.limonciello@amd.com> wrote:
>>> On 8/13/22 04:26, Luke D. Jones wrote:
>>>> Support the hardware GPU MUX switch available on some models. This
>>>> switch can toggle the MUX between:
>>>>
>>>> - 0, Dedicated mode
>>>> - 1, Optimus mode
>>>>
>>>> Optimus mode is the regular iGPU + dGPU available, while dedicated
>>>> mode switches the system to have only the dGPU available.
>>>>
>>>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>>> ---
>>>>   .../ABI/testing/sysfs-platform-asus-wmi       | 11 ++++
>>>>   drivers/platform/x86/asus-wmi.c               | 62 +++++++++++++++++++
>>>>   include/linux/platform_data/x86/asus-wmi.h    |  3 +
>>>>   3 files changed, 76 insertions(+)
>>>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>>> index 574b5170a37d..03124eab7f01 100644
>>>> --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>>> +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>>> @@ -58,6 +58,17 @@ Description:
>>>>               * 1 - overboost,
>>>>               * 2 - silent
>>>>   +What:          /sys/devices/platform/<platform>/gpu_mux_mode
>>>> +Date:          Aug 2022
>>>> +KernelVersion: 6.1
>>>> +Contact:       "Luke Jones" <luke@ljones.dev>
>>>> +Description:
>>>> +               Switch the GPU hardware MUX mode. Laptops with this feature can
>>>> +               can be toggled to boot with only the dGPU (discrete mode) or in
>>>> +               standard Optimus/Hybrid mode. On switch a reboot is required:
>>>> +                       * 0 - Discrete GPU,
>>>> +                       * 1 - Optimus/Hybrid,
>>>
>>> This feel like it should probably export using /sys/class/firmware-attributes.  That's exactly how those types of attributes work.
>>>
>>> As a bonus, software like fwupd 1.8.4 knows how to manipulate it and you don't need special documentation.
>>>
>>>> +
>>>>   What:          /sys/devices/platform/<platform>/dgpu_disable
>>>>   Date:          Aug 2022
>>>>   KernelVersion: 5.17
>>>> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
>>>> index e2b51b5550e8..0421ffb81927 100644
>>>> --- a/drivers/platform/x86/asus-wmi.c
>>>> +++ b/drivers/platform/x86/asus-wmi.c
>>>> @@ -230,6 +230,7 @@ struct asus_wmi {
>>>>         bool egpu_enable_available;
>>>>       bool dgpu_disable_available;
>>>> +    bool gpu_mux_mode_available;
>>>>         bool throttle_thermal_policy_available;
>>>>       u8 throttle_thermal_policy_mode;
>>>> @@ -668,6 +669,59 @@ static ssize_t egpu_enable_store(struct device *dev,
>>>>   }
>>>>   static DEVICE_ATTR_RW(egpu_enable);
>>>>   +/* gpu mux switch *************************************************************/
>>>> +static int gpu_mux_mode_check_present(struct asus_wmi *asus)
>>>> +{
>>>> +    asus->gpu_mux_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX);
>>>> +
>>>> +   return 0;
>>>> +}
>>>> +
>>>> +static ssize_t gpu_mux_mode_show(struct device *dev,
>>>> +                  struct device_attribute *attr, char *buf)
>>>> +{
>>>> +   struct asus_wmi *asus = dev_get_drvdata(dev);
>>>> +   int result;
>>>> +
>>>> +   result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GPU_MUX);
>>>> +   if (result < 0)
>>>> +       return result;
>>>> +
>>>> +   return sysfs_emit(buf, "%d\n", result);
>>>> +}
>>>> +
>>>> +static ssize_t gpu_mux_mode_store(struct device *dev,
>>>> +                   struct device_attribute *attr,
>>>> +                   const char *buf, size_t count)
>>>> +{
>>>> +   struct asus_wmi *asus = dev_get_drvdata(dev);
>>>> +   int result, err;
>>>> +   u32 optimus;
>>>> +
>>>> +   err = kstrtou32(buf, 10, &optimus);
>>>> +   if (err)
>>>> +       return err;
>>>> +
>>>> +   if (optimus > 1)
>>>> +       return -EINVAL;
>>>> +
>>>> +   err = asus_wmi_set_devstate(ASUS_WMI_DEVID_GPU_MUX, optimus, &result);
>>>> +   if (err) {
>>>> +       dev_err(dev, "Failed to set GPU MUX mode: %d\n", err);
>>>> +       return err;
>>>> +   }
>>>> +    /* !1 is considered a fail by ASUS */
>>>> +    if (result != 1) {
>>>> +        dev_warn(dev, "Failed to set GPU MUX mode (result): 0x%x\n", result);
>>>> +       return -EIO;
>>>> +   }
>>>> +
>>>> +   sysfs_notify(&asus->platform_device->dev.kobj, NULL, "gpu_mux_mode");
>>>> +
>>>> +   return count;
>>>> +}
>>>> +static DEVICE_ATTR_RW(gpu_mux_mode);
>>>> +
>>>>   /* Battery ********************************************************************/
>>>>     /* The battery maximum charging percentage */
>>>> @@ -3165,6 +3219,7 @@ static struct attribute *platform_attributes[] = {
>>>>       &dev_attr_touchpad.attr,
>>>>       &dev_attr_egpu_enable.attr,
>>>>       &dev_attr_dgpu_disable.attr,
>>>> +    &dev_attr_gpu_mux_mode.attr,
>>>>       &dev_attr_lid_resume.attr,
>>>>       &dev_attr_als_enable.attr,
>>>>       &dev_attr_fan_boost_mode.attr,
>>>> @@ -3195,6 +3250,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
>>>>           ok = asus->egpu_enable_available;
>>>>       else if (attr == &dev_attr_dgpu_disable.attr)
>>>>           ok = asus->dgpu_disable_available;
>>>> +    else if (attr == &dev_attr_gpu_mux_mode.attr)
>>>> +        ok = asus->gpu_mux_mode_available;
>>>>       else if (attr == &dev_attr_fan_boost_mode.attr)
>>>>           ok = asus->fan_boost_mode_available;
>>>>       else if (attr == &dev_attr_throttle_thermal_policy.attr)
>>>> @@ -3464,6 +3521,10 @@ static int asus_wmi_add(struct platform_device *pdev)
>>>>       if (err)
>>>>           goto fail_dgpu_disable;
>>>>   +    err = gpu_mux_mode_check_present(asus);
>>>> +   if (err)
>>>> +       goto fail_gpu_mux_mode;
>>>> +
>>>>       err = fan_boost_mode_check_present(asus);
>>>>       if (err)
>>>>           goto fail_fan_boost_mode;
>>>> @@ -3578,6 +3639,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>>>>   fail_fan_boost_mode:
>>>>   fail_egpu_enable:
>>>>   fail_dgpu_disable:
>>>> +fail_gpu_mux_mode:
>>>>   fail_platform:
>>>>   fail_panel_od:
>>>>       kfree(asus);
>>>> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
>>>> index a571b47ff362..c023332842a2 100644
>>>> --- a/include/linux/platform_data/x86/asus-wmi.h
>>>> +++ b/include/linux/platform_data/x86/asus-wmi.h
>>>> @@ -98,6 +98,9 @@
>>>>   /* dgpu on/off */
>>>>   #define ASUS_WMI_DEVID_DGPU        0x00090020
>>>>   +/* gpu mux switch, 0 = dGPU, 1 = Optimus */
>>>> +#define ASUS_WMI_DEVID_GPU_MUX 0x00090016
>>>> +
>>>>   /* DSTS masks */
>>>>   #define ASUS_WMI_DSTS_STATUS_BIT    0x00000001
>>>>   #define ASUS_WMI_DSTS_UNKNOWN_BIT    0x00000002
>>>
>>
>> You can see previous discussion here https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fplatform-driver-x86%2Fc3bb0989-78d9-c513-1669-75407b2acbac%40redhat.com%2F&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7C3df656b0acd34b793bb908da83c9e8f4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637967200474348826%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=MsHEOH2aUUYGBhOBhVukN6DxWeBE16qz0nw%2BJryfM7M%3D&amp;reserved=0
>>
>> Below is Hans response verbatim:
>>
>>  > Yes it sounds like a BIOS setting is being toggled from within
>>  > Linux, which would normally be done through the
>>  > "firmware-attributes" class, but all existing "firmware-attributes"
>>  > class drivers allow changing all BIOS setting not just a single
>>  > setting, so using the  "firmware-attributes" class here is not really
>>  > appropriate.
>>
> 
> Although the two consumers thus far (Lenovo and Dell) use WMI interfaces to build and discover varieties of settings there is no requirement for how the backend for firwmare-attributes works.  You can just as well poulate a single attribute statically from your driver.
> 
> So I guess Hans and I disagree here.  I have a feeling that we shouldn't be introducing custom ABI to userspace just because only "one" setting is offered.  I anticipate that some day the DE's will offer a GUI setting built on top of fwupd which is built on top of firmware-attributes.
> 
> If you *don't* populate a setting with firmware-attributes the only way that users will discover such a setting is by installing other custom userspace software that has the knowledge of it.
> 
> At the end of the day it's up to Hans and Mark though, this is just my 2c.

Mario, thank you for your input here, it is much appreciated.

As Luke mentioned in my quote using the firmware-attributes class for this really seems like overkill. As for discoverability, the firmware-attributes class only standardizes how to enum / change BIOS settings. The consumer of the API still must now the name of the setting which can/will be different per vendor.

AFAIK fwupd only uses the firmware-attributes class to check for / disable some BIOS flashing protection. So having the GPU mux setting in the firmware-attributes class is not really relevant for fwupd.

If in the future some generic tool which uses the firmware-attributes class to toggle GPU muxes is created (presumably with a lookup table for the exact setting's name under the firmare-attributes API) then we can always add firmware-attributes support for the GPU mux to asus-wmi at that point in time.

I just don't think it is likely such a generic tool will happen (any time soon), so for now I still believe that using the firmware-attributes class for this is not necessary.

Regards,

Hans

