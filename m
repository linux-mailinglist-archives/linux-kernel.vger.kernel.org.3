Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692085A3C95
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 10:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbiH1IGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 04:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiH1IGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 04:06:17 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17D750710;
        Sun, 28 Aug 2022 01:06:14 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id E7120320082A;
        Sun, 28 Aug 2022 04:06:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 28 Aug 2022 04:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1661673973; x=1661760373; bh=G9M5bX7Dir
        NpAXpOCeQ5IzlgfZIhu38O4P83iKHtPZw=; b=Rn5VfDwx94AEH+3qghzX7KiVgv
        M+srtBnSaXz7gkCUdohfRZ1/tZJVV4b//K9DT3+O5DwETnd2/9URCET0Zv2gqGsf
        pujZkjHYUhac1Y0GJgq8WOhjDZIWtNuMjJwo0nQpNAfwUB0vtvjodgE5lxdwpeYU
        6WlDepI5YRWR0zhw4NemJy7mSNtPSA6QsPAXXx7S9Xn9tDqVtyaKCBEshhre6O1d
        aX5jRJ25aYpAxyYaiEfIDgBmmj+6h/bbeurpghn9yeIKyiqNSYmqCKg0tXKKpFAa
        C1BwiMNWv5PE8Y+vQ3qy+Ad0mhLw9CJH4hlJAHbywqXGlLC7AtpxgMHkKMCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1661673973; x=1661760373; bh=G9M5bX7DirNpAXpOCeQ5IzlgfZIh
        u38O4P83iKHtPZw=; b=pBkon81nhKkxgZTklylQ3435gHysRhUF+ronsigr/NQz
        5gOdSquhH2F+PQBgrZVmiYwVJSJHM9JtNqRB0wga3qU1FM0wkZBMqHNO9/G+JQqH
        WY1JX76O4Q0ARmnhJCXRIbhcY1YeNIKVN3flPUZk4kMqRKkggQ4XAfUkdB3wa4Sy
        y9rDmsplZMzwMxerxSQUICX0L7u/qB2J4jjYc4fz8S8NP3UO0OrtrdiR5AD2K6g9
        ysKeGF47oBI9IOxtRJ0MdSnP3klOAJxpKcFraETG+Xum1awh6ywOtfgo+EA7yGns
        xplNpYe4hju3Mus1J/yiQfZALgVat/8133iasZaVbg==
X-ME-Sender: <xms:9SELY3BDIffbsGi68qpbt2UR4WQwGS2RIYMvMRjLvXekqwT62zjxlA>
    <xme:9SELY9hy9q4Zv-ZH_lsp2Drhc_ZK1CrenHWfsF-6Ou3xk13iOrj8mE4N6ZEjtlkiA
    2V19pvw7gNG0gU01Ek>
X-ME-Received: <xmr:9SELYylOnRA73PrQLPcNeKdZ-V5BAKhkfSFrFqhCzL3Whc9zZ-7gZDuk56CZk5UkoAOGHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejlecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffuvfevkfgjfhfogggtsehttdertdertddvnecuhfhrohhmpefnuhhkvgculfho
    nhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpeevie
    dvfedtheefgeeuteduvdduueejjeeujeetleehlefgtdevfeeliedvteeiheenucffohhm
    rghinhepohhuthhlohhokhdrtghomhdpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdr
    uggvvh
X-ME-Proxy: <xmx:9SELY5yJ4kclgiEAUTWI8qGbERWwwXzv76tBIpOCNQ9hX0CNAX1hFQ>
    <xmx:9SELY8SDKoPq9VdKZ2MOOnTQklrFC1HWPbRtPlo-MxMq0bd5ETBCmQ>
    <xmx:9SELY8bOEv3us33IHvCTW2zcAL3I5gmwpPOXaJebYq_oKiYCDi5m3A>
    <xmx:9SELY3fFcNTBSL52rh8CaK9NcaqUnrGtXcVv2htnnhn0_GmXgy4m6A>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Aug 2022 04:06:09 -0400 (EDT)
Date:   Sun, 28 Aug 2022 20:05:54 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH] asus-wmi: Support the hardware GPU MUX on some laptops
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <UTFBHR.7QAVRH751VBB@ljones.dev>
In-Reply-To: <80a42677-81a1-dc97-5ee3-86c80c79500b@amd.com>
References: <20220813092624.6228-1-luke@ljones.dev>
        <e186622e-f3e6-5715-9f6d-bc41fb41560d@amd.com>
        <UVMZGR.6LXKPONA9OS33@ljones.dev>
        <6f7df43d-292d-3a6b-76bc-09d669733939@amd.com>
        <4e4c5234-3327-0e49-989c-1117ffb2f13d@redhat.com>
        <34bf5d3a-adb6-ce12-8c9c-ee9144f5262d@amd.com>
        <fda6b7fc-b307-f4f3-1176-6b15c639b3d0@redhat.com>
        <80a42677-81a1-dc97-5ee3-86c80c79500b@amd.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Aug 24 2022 at 08:09:08 -0500, Mario Limonciello 
<mario.limonciello@amd.com> wrote:
> On 8/24/22 08:03, Hans de Goede wrote:
>> Hi,
>> 
>> On 8/24/22 14:53, Mario Limonciello wrote:
>>> On 8/24/22 07:40, Hans de Goede wrote:
>>>> Hi All,
>>>> 
>>>> On 8/22/22 17:43, Limonciello, Mario wrote:
>>>>> On 8/21/2022 18:07, Luke Jones wrote:
>>>>>> Hi Mario,
>>>>>> 
>>>>>> On Mon, Aug 15 2022 at 23:16:12 -0500, Mario Limonciello 
>>>>>> <mario.limonciello@amd.com> wrote:
>>>>>>> On 8/13/22 04:26, Luke D. Jones wrote:
>>>>>>>> Support the hardware GPU MUX switch available on some models. 
>>>>>>>> This
>>>>>>>> switch can toggle the MUX between:
>>>>>>>> 
>>>>>>>> - 0, Dedicated mode
>>>>>>>> - 1, Optimus mode
>>>>>>>> 
>>>>>>>> Optimus mode is the regular iGPU + dGPU available, while 
>>>>>>>> dedicated
>>>>>>>> mode switches the system to have only the dGPU available.
>>>>>>>> 
>>>>>>>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>>>>>>> ---
>>>>>>>>     .../ABI/testing/sysfs-platform-asus-wmi       | 11 ++++
>>>>>>>>     drivers/platform/x86/asus-wmi.c               | 62 
>>>>>>>> +++++++++++++++++++
>>>>>>>>     include/linux/platform_data/x86/asus-wmi.h    |  3 +
>>>>>>>>     3 files changed, 76 insertions(+)
>>>>>>>> 
>>>>>>>> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi 
>>>>>>>> b/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>>>>>>> index 574b5170a37d..03124eab7f01 100644
>>>>>>>> --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>>>>>>> +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>>>>>>> @@ -58,6 +58,17 @@ Description:
>>>>>>>>                 * 1 - overboost,
>>>>>>>>                 * 2 - silent
>>>>>>>>     +What:          
>>>>>>>> /sys/devices/platform/<platform>/gpu_mux_mode
>>>>>>>> +Date:          Aug 2022
>>>>>>>> +KernelVersion: 6.1
>>>>>>>> +Contact:       "Luke Jones" <luke@ljones.dev>
>>>>>>>> +Description:
>>>>>>>> +               Switch the GPU hardware MUX mode. Laptops with 
>>>>>>>> this feature can
>>>>>>>> +               can be toggled to boot with only the dGPU 
>>>>>>>> (discrete mode) or in
>>>>>>>> +               standard Optimus/Hybrid mode. On switch a 
>>>>>>>> reboot is required:
>>>>>>>> +                       * 0 - Discrete GPU,
>>>>>>>> +                       * 1 - Optimus/Hybrid,
>>>>>>> 
>>>>>>> This feel like it should probably export using 
>>>>>>> /sys/class/firmware-attributes.  That's exactly how those types 
>>>>>>> of attributes work.
>>>>>>> 
>>>>>>> As a bonus, software like fwupd 1.8.4 knows how to manipulate 
>>>>>>> it and you don't need special documentation.
>>>>>>> 
>>>>>>>> +
>>>>>>>>     What:          
>>>>>>>> /sys/devices/platform/<platform>/dgpu_disable
>>>>>>>>     Date:          Aug 2022
>>>>>>>>     KernelVersion: 5.17
>>>>>>>> diff --git a/drivers/platform/x86/asus-wmi.c 
>>>>>>>> b/drivers/platform/x86/asus-wmi.c
>>>>>>>> index e2b51b5550e8..0421ffb81927 100644
>>>>>>>> --- a/drivers/platform/x86/asus-wmi.c
>>>>>>>> +++ b/drivers/platform/x86/asus-wmi.c
>>>>>>>> @@ -230,6 +230,7 @@ struct asus_wmi {
>>>>>>>>           bool egpu_enable_available;
>>>>>>>>         bool dgpu_disable_available;
>>>>>>>> +    bool gpu_mux_mode_available;
>>>>>>>>           bool throttle_thermal_policy_available;
>>>>>>>>         u8 throttle_thermal_policy_mode;
>>>>>>>> @@ -668,6 +669,59 @@ static ssize_t egpu_enable_store(struct 
>>>>>>>> device *dev,
>>>>>>>>     }
>>>>>>>>     static DEVICE_ATTR_RW(egpu_enable);
>>>>>>>>     +/* gpu mux switch 
>>>>>>>> *************************************************************/
>>>>>>>> +static int gpu_mux_mode_check_present(struct asus_wmi *asus)
>>>>>>>> +{
>>>>>>>> +    asus->gpu_mux_mode_available = 
>>>>>>>> asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX);
>>>>>>>> +
>>>>>>>> +   return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static ssize_t gpu_mux_mode_show(struct device *dev,
>>>>>>>> +                  struct device_attribute *attr, char *buf)
>>>>>>>> +{
>>>>>>>> +   struct asus_wmi *asus = dev_get_drvdata(dev);
>>>>>>>> +   int result;
>>>>>>>> +
>>>>>>>> +   result = asus_wmi_get_devstate_simple(asus, 
>>>>>>>> ASUS_WMI_DEVID_GPU_MUX);
>>>>>>>> +   if (result < 0)
>>>>>>>> +       return result;
>>>>>>>> +
>>>>>>>> +   return sysfs_emit(buf, "%d\n", result);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static ssize_t gpu_mux_mode_store(struct device *dev,
>>>>>>>> +                   struct device_attribute *attr,
>>>>>>>> +                   const char *buf, size_t count)
>>>>>>>> +{
>>>>>>>> +   struct asus_wmi *asus = dev_get_drvdata(dev);
>>>>>>>> +   int result, err;
>>>>>>>> +   u32 optimus;
>>>>>>>> +
>>>>>>>> +   err = kstrtou32(buf, 10, &optimus);
>>>>>>>> +   if (err)
>>>>>>>> +       return err;
>>>>>>>> +
>>>>>>>> +   if (optimus > 1)
>>>>>>>> +       return -EINVAL;
>>>>>>>> +
>>>>>>>> +   err = asus_wmi_set_devstate(ASUS_WMI_DEVID_GPU_MUX, 
>>>>>>>> optimus, &result);
>>>>>>>> +   if (err) {
>>>>>>>> +       dev_err(dev, "Failed to set GPU MUX mode: %d\n", err);
>>>>>>>> +       return err;
>>>>>>>> +   }
>>>>>>>> +    /* !1 is considered a fail by ASUS */
>>>>>>>> +    if (result != 1) {
>>>>>>>> +        dev_warn(dev, "Failed to set GPU MUX mode (result): 
>>>>>>>> 0x%x\n", result);
>>>>>>>> +       return -EIO;
>>>>>>>> +   }
>>>>>>>> +
>>>>>>>> +   sysfs_notify(&asus->platform_device->dev.kobj, NULL, 
>>>>>>>> "gpu_mux_mode");
>>>>>>>> +
>>>>>>>> +   return count;
>>>>>>>> +}
>>>>>>>> +static DEVICE_ATTR_RW(gpu_mux_mode);
>>>>>>>> +
>>>>>>>>     /* Battery 
>>>>>>>> ********************************************************************/
>>>>>>>>       /* The battery maximum charging percentage */
>>>>>>>> @@ -3165,6 +3219,7 @@ static struct attribute 
>>>>>>>> *platform_attributes[] = {
>>>>>>>>         &dev_attr_touchpad.attr,
>>>>>>>>         &dev_attr_egpu_enable.attr,
>>>>>>>>         &dev_attr_dgpu_disable.attr,
>>>>>>>> +    &dev_attr_gpu_mux_mode.attr,
>>>>>>>>         &dev_attr_lid_resume.attr,
>>>>>>>>         &dev_attr_als_enable.attr,
>>>>>>>>         &dev_attr_fan_boost_mode.attr,
>>>>>>>> @@ -3195,6 +3250,8 @@ static umode_t 
>>>>>>>> asus_sysfs_is_visible(struct kobject *kobj,
>>>>>>>>             ok = asus->egpu_enable_available;
>>>>>>>>         else if (attr == &dev_attr_dgpu_disable.attr)
>>>>>>>>             ok = asus->dgpu_disable_available;
>>>>>>>> +    else if (attr == &dev_attr_gpu_mux_mode.attr)
>>>>>>>> +        ok = asus->gpu_mux_mode_available;
>>>>>>>>         else if (attr == &dev_attr_fan_boost_mode.attr)
>>>>>>>>             ok = asus->fan_boost_mode_available;
>>>>>>>>         else if (attr == 
>>>>>>>> &dev_attr_throttle_thermal_policy.attr)
>>>>>>>> @@ -3464,6 +3521,10 @@ static int asus_wmi_add(struct 
>>>>>>>> platform_device *pdev)
>>>>>>>>         if (err)
>>>>>>>>             goto fail_dgpu_disable;
>>>>>>>>     +    err = gpu_mux_mode_check_present(asus);
>>>>>>>> +   if (err)
>>>>>>>> +       goto fail_gpu_mux_mode;
>>>>>>>> +
>>>>>>>>         err = fan_boost_mode_check_present(asus);
>>>>>>>>         if (err)
>>>>>>>>             goto fail_fan_boost_mode;
>>>>>>>> @@ -3578,6 +3639,7 @@ static int asus_wmi_add(struct 
>>>>>>>> platform_device *pdev)
>>>>>>>>     fail_fan_boost_mode:
>>>>>>>>     fail_egpu_enable:
>>>>>>>>     fail_dgpu_disable:
>>>>>>>> +fail_gpu_mux_mode:
>>>>>>>>     fail_platform:
>>>>>>>>     fail_panel_od:
>>>>>>>>         kfree(asus);
>>>>>>>> diff --git a/include/linux/platform_data/x86/asus-wmi.h 
>>>>>>>> b/include/linux/platform_data/x86/asus-wmi.h
>>>>>>>> index a571b47ff362..c023332842a2 100644
>>>>>>>> --- a/include/linux/platform_data/x86/asus-wmi.h
>>>>>>>> +++ b/include/linux/platform_data/x86/asus-wmi.h
>>>>>>>> @@ -98,6 +98,9 @@
>>>>>>>>     /* dgpu on/off */
>>>>>>>>     #define ASUS_WMI_DEVID_DGPU        0x00090020
>>>>>>>>     +/* gpu mux switch, 0 = dGPU, 1 = Optimus */
>>>>>>>> +#define ASUS_WMI_DEVID_GPU_MUX 0x00090016
>>>>>>>> +
>>>>>>>>     /* DSTS masks */
>>>>>>>>     #define ASUS_WMI_DSTS_STATUS_BIT    0x00000001
>>>>>>>>     #define ASUS_WMI_DSTS_UNKNOWN_BIT    0x00000002
>>>>>>> 
>>>>>> 
>>>>>> You can see previous discussion here 
>>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fplatform-driver-x86%2Fc3bb0989-78d9-c513-1669-75407b2acbac%40redhat.com%2F&data=05%7C01%7Cmario.limonciello%40amd.com%7Ceebec0ca0ab74f8babf908da85d10582%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637969430056811815%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=kFb75Jhr77XZScoegTh5FyJAnnEXm6cInIoxKdu7rhM%3D&reserved=0
>>>>>> 
>>>>>> Below is Hans response verbatim:
>>>>>> 
>>>>>>    > Yes it sounds like a BIOS setting is being toggled from 
>>>>>> within
>>>>>>    > Linux, which would normally be done through the
>>>>>>    > "firmware-attributes" class, but all existing 
>>>>>> "firmware-attributes"
>>>>>>    > class drivers allow changing all BIOS setting not just a 
>>>>>> single
>>>>>>    > setting, so using the  "firmware-attributes" class here is 
>>>>>> not really
>>>>>>    > appropriate.
>>>>>> 
>>>>> 
>>>>> Although the two consumers thus far (Lenovo and Dell) use WMI 
>>>>> interfaces to build and discover varieties of settings there is 
>>>>> no requirement for how the backend for firwmare-attributes works. 
>>>>>  You can just as well poulate a single attribute statically from 
>>>>> your driver.
>>>>> 
>>>>> So I guess Hans and I disagree here.  I have a feeling that we 
>>>>> shouldn't be introducing custom ABI to userspace just because 
>>>>> only "one" setting is offered.  I anticipate that some day the 
>>>>> DE's will offer a GUI setting built on top of fwupd which is 
>>>>> built on top of firmware-attributes.
>>>>> 
>>>>> If you *don't* populate a setting with firmware-attributes the 
>>>>> only way that users will discover such a setting is by installing 
>>>>> other custom userspace software that has the knowledge of it.
>>>>> 
>>>>> At the end of the day it's up to Hans and Mark though, this is 
>>>>> just my 2c.
>>>> 
>>>> Mario, thank you for your input here, it is much appreciated.
>>>> 
>>>> As Luke mentioned in my quote using the firmware-attributes class 
>>>> for this really seems like overkill. As for discoverability, the 
>>>> firmware-attributes class only standardizes how to enum / change 
>>>> BIOS settings. The consumer of the API still must now the name of 
>>>> the setting which can/will be different per vendor.
>>>> 
>>>> AFAIK fwupd only uses the firmware-attributes class to check for / 
>>>> disable some BIOS flashing protection. So having the GPU mux 
>>>> setting in the firmware-attributes class is not really relevant 
>>>> for fwupd.
>>>> 
>>>> If in the future some generic tool which uses the 
>>>> firmware-attributes class to toggle GPU muxes is created 
>>>> (presumably with a lookup table for the exact setting's name under 
>>>> the firmare-attributes API) then we can always add 
>>>> firmware-attributes support for the GPU mux to asus-wmi at that 
>>>> point in time.
>>>> 
>>>> I just don't think it is likely such a generic tool will happen 
>>>> (any time soon), so for now I still believe that using the 
>>>> firmware-attributes class for this is not necessary.
>>>> 
>>> 
>>> Actually I've been actively working on that.  Take a look at fwupd 
>>> main (what will go into the next tagged 1.8.4 release).
>>> 
>>> It's got support for "fwupdmgr get-bios-settings" and "fwupdmgr 
>>> set-bios-settings" which will follow the rules the kernel API uses.
>>> 
>>> So I expect that if this attribute was implemented as I suggested 
>>> you could do:
>>> 
>>> # fwupdmgr get-bios-settings
>>> 
>>> and find the mux (including the possible values if it's declared a 
>>> kernel enumeration attribute and possible_values is populated).  If 
>>> you populate the optional description attribute in the kernel fwupd 
>>> will show you what your enumerated settings mean.
>>> 
>>> followed by:
>>> 
>>> # fwupdmgr set-bios-setting dGPUMux iGPU
>>> or
>>> # fwupdmgr set-bios-setting dGPUMux dGPU
>>> 
>>> To set it.
>>> 
>>> fwupd will prompt you to reboot the system after it's done changing 
>>> it as well.
>>> 
>>> It's implemented such that GUI clients can use libfwupd just the 
>>> same, and I really think this increases discoverability of such a 
>>> setting.
>> 
>> Interesting, I must admit that that makes your argument for using 
>> the firmware-attributes class stronger.
>> 
>> But in the end it IMHO still feels wrong to add firmware-attribute 
>> support for just a single setting, rather then for something which 
>> actually exports all or most BIOS settings.
> 
> OK thanks for your thoughts.
> 
>> 
>> So for now I'm going to with this patch as is. If eventually it 
>> turns out that having this inside the firmware-attributes class 
>> would be really useful we can add it later, while keeping the sysfs 
>> attr for backward compat. My thinking being here that the code for 
>> the single sysfs attr is quite small, where as adding 
>> firmware-attributes class support will be more involved
> At least looking at the context of that diff I see a whole bunch of 
> settings listed and this is "just one more". I noticed:  "eGPU", "lid 
> resume", "ALS enable", "fan boost mode".
> 
> Maybe a later follow up should implement ALL of these as 
> firmware-attributes but keep compatibility for sysfs.
> 
>> 
>> Regards,
>> 
>> Hans
>> 
> 

Hi Mario, Hans.

Quite a bit for me to follow here. But going from the gist of it all 
I'm not opposed at all to implementing support for fwupd. I realise we 
already have a series of attributes under the wmi sysfs, and there will 
be more added - but in the first instances of this I (personally) 
wasn't aware of fwupd and who it was aiming to enable this, and 
secondly it was a very fast way to bring up support along with being 
easily discoverable with udev libs.

Unfortunately it looks like it is going to be a large body of work to 
start doing fwupd support, and I'm not likely to have much time for it 
although I'd love to do it. I may well have a go with a single simple 
attribute and see how it works out, but man I wish I was getting paid 
for all this so I could justify the time cost.

Mario, as I seem to be the single person adding support for various 
things with ASUS gaming laptops, please feel free to CC or email me (in 
addition to others) whenever required for the ASUS stuff. I tend to 
stick to the gaming laptops for now however (as I have two kinds I can 
test with).

Kind regards,
Luke.


