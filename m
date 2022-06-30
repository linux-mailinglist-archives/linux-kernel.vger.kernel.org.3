Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958BC561EE5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbiF3PNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbiF3PNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:13:30 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954992F3B0;
        Thu, 30 Jun 2022 08:13:27 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d5so17261127plo.12;
        Thu, 30 Jun 2022 08:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dmz/xtqA6kv99Sis4Vb+0Au3JkFRXvr5w34minJZGPM=;
        b=V+wq2t7woQcGUgHIh1n6Mjk6uy5bu66MPaB649Iz1piak8N5V6ogLrKORKUetSpmO7
         lGG6P4+zVNjNg0IONP/yFPpWo56XkbrXaH8IxL/YHDRjC1oFOD9LcNy1fI2KyZdEGTP3
         3uujOTjH4g982BAhRB7fuBzDRxiOU+gh2HyoeFNAWCJ8QVH9ULAP0YZOGXKxn3q0vc3G
         F1CG7NK1MovkOrz1uXZpkVbFQm0zMBo6LY0Mg4pP1xaOBe1PNryQI0bquSwlDz2hlkfa
         JTK0BTvtEriNWWrOBV9MeIqOvF7LocnvZqSd4qYTJR9+rFgz5RDnr0qWWGGyP0KrF0hG
         +9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dmz/xtqA6kv99Sis4Vb+0Au3JkFRXvr5w34minJZGPM=;
        b=AkT/PyEIPn78v/12I7DQ5qyM2lW0l3A+2Fv2oJnv5VerJdoP6Zj3jV6cfR/mE0B9bF
         +Ux1GwqCGmA2BVVJO7uxqnPvRWa+aChpH+0Xr6UpF4xjwSuvtM3CWOb4bNn3L4KMeWS1
         vMZ7QNzjEsSjIFbo5+utkxS2rIWPE0xWZhhJRVE2c9FdQd/7GRJLgumoYo5Z2WHBsYD2
         vdgMM0z1PDToxT9DlUtrLDrPfVdKN9KfMlBmEYq43S8SYK/S6zHJFyMco1bZEwvdfKiR
         URor3b/O/bnNWuoBBaVfr0JO/2X8h302OJsBLG2X/AILLDyK0+rUFBrsumyyItgZV0hJ
         2ZzQ==
X-Gm-Message-State: AJIora8JrnkofzpKeLmPu9NUIyJokAaWKRiLzg+06SiYLPKknbzG5zCM
        47PHJBBh+S2DTdQVbvtyOe8RGTFVsTo=
X-Google-Smtp-Source: AGRyM1tdHcNUNm4/1Y1sIiSf19LHq3s8+/0HWxGeqfcHiOgB5/l/GPNRBgtAxfYiaLxdMpmVommGHA==
X-Received: by 2002:a17:90b:1c8f:b0:1b8:c6dc:ca61 with SMTP id oo15-20020a17090b1c8f00b001b8c6dcca61mr10457653pjb.13.1656602007043;
        Thu, 30 Jun 2022 08:13:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b8-20020a170903228800b0016b8746132esm11325plh.105.2022.06.30.08.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 08:13:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2e617891-af80-b2c0-4ff7-e74bba57f32e@roeck-us.net>
Date:   Thu, 30 Jun 2022 08:13:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 2/2] hwmon: acpi_power_meter: convert to
 hwmon_device_register_with_info
Content-Language: en-US
To:     LABBE Corentin <clabbe@baylibre.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>
References: <20220509063010.3878134-1-clabbe@baylibre.com>
 <20220509063010.3878134-3-clabbe@baylibre.com>
 <e5f6c712-efed-2126-de2b-9a0d09150e7b@roeck-us.net> <YoFWNAhiDrzpeBU8@Red>
 <9f7d7281-0434-df59-40fa-1f5d8f53356d@roeck-us.net> <YoHtg30ZrhxjVedA@Red>
 <1747d709-6640-193d-8290-893b1541fae8@roeck-us.net>
 <b038aa19-9cba-d16a-15c5-e02fc749ab96@roeck-us.net> <Yr234pcBeCQZ250b@Red>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <Yr234pcBeCQZ250b@Red>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/22 07:49, LABBE Corentin wrote:
> Le Sat, May 21, 2022 at 06:52:15AM -0700, Guenter Roeck a écrit :
>> On 5/16/22 05:21, Guenter Roeck wrote:
>>> On 5/15/22 23:21, LABBE Corentin wrote:
>>>> Le Sun, May 15, 2022 at 05:29:54PM -0700, Guenter Roeck a écrit :
>>>>> On 5/15/22 12:36, LABBE Corentin wrote:
>>>>>> Le Wed, May 11, 2022 at 07:10:29PM -0700, Guenter Roeck a écrit :
>>>>>>> Corentin,
>>>>>>>
>>>>>>> On 5/8/22 23:30, Corentin Labbe wrote:
>>>>>>>> Booting lead to a hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
>>>>>>>> So let's convert the driver to use hwmon_device_register_with_info().
>>>>>>>>
>>>>>>>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>>>>>>>> ---
>>>>>>> [ ... ]
>>>>>>>
>>>>>>>> @@ -836,20 +740,20 @@ static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
>>>>>>>>              if (res)
>>>>>>>>                  break;
>>>>>>>> -        remove_attrs(resource);
>>>>>>>> +        remove_domain_devices(resource);
>>>>>>>>              setup_attrs(resource);
>>>>>>>
>>>>>>> Zhang Rui found an interesting problem with this code:
>>>>>>> It needs a call to sysfs_update_groups(hwmon_dev->groups)
>>>>>>> to update sysfs attribute visibility, probably between
>>>>>>> remove_domain_devices() and setup_attrs().
>>>>>>>
>>>>>>>>              break;
>>>>>>>>          case METER_NOTIFY_TRIP:
>>>>>>>> -        sysfs_notify(&device->dev.kobj, NULL, POWER_AVERAGE_NAME);
>>>>>>>> +        hwmon_notify_event(&device->dev, hwmon_power, hwmon_power_average, 0);
>>>>>>>
>>>>>>> ... which makes realize: The notification device should be the hwmon device.
>>>>>>> That would be resource->hwmon_dev, not the acpi device.
>>>>>>>
>>>>>>
>>>>>> Hello
>>>>>>
>>>>>> Since my hardware lacks capabilities testing this, I have emulated it on qemu:
>>>>>> https://github.com/montjoie/qemu/commit/320f2ddacb954ab308ef699f66fca6313f75bc2b
>>>>>>
>>>>>> I have added a custom ACPI _DBX method for triggering some ACPI state change. (like config change, like enabling CAP).
>>>>>>
>>>>>> For testing config change I have tried lot of way:
>>>>>>                    res = read_capabilities(resource);
>>>>>> @@ -742,18 +758,22 @@ static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
>>>>>>                    remove_domain_devices(resource);
>>>>>>                    setup_attrs(resource);
>>>>>> +               res = sysfs_update_groups(&resource->hwmon_dev->kobj, acpi_power_groups);
>>>>>> +               res = sysfs_update_groups(&resource->acpi_dev->dev.kobj, acpi_power_groups);
>>>>>> +               res = hwmon_notify_event(resource->hwmon_dev, hwmon_power, hwmon_power_cap, 0);
>>>>>> +               res = hwmon_notify_event(resource->hwmon_dev, hwmon_power, hwmon_power_average, 0);
>>>>>
>>>>> Did you add a debug log here ?
>>>>
>>>> Yes I added debug log to check what is called.
>>>>
>>>>>
>>>>> acpi_power_groups would be the wrong parameter for sysfs_update_groups().
>>>>> It would have to be resource->hwmon_dev->groups.
>>>>>
>>>>
>>>> Even with that, no call to is_visible:
>>>> @@ -742,18 +758,22 @@ static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
>>>>                   remove_domain_devices(resource);
>>>>                   setup_attrs(resource);
>>>> +               res = sysfs_update_groups(&resource->hwmon_dev->kobj, resource->hwmon_dev->groups);
>>>> +               res = sysfs_update_groups(&resource->acpi_dev->dev.kobj, resource->hwmon_dev->groups);
>>>> +               res = hwmon_notify_event(resource->hwmon_dev, hwmon_power, hwmon_power_cap, 0);
>>>> +               res = hwmon_notify_event(resource->hwmon_dev, hwmon_power, hwmon_power_average, 0);
>>>>                   break;
>>>>
>>>> I checked drivers/hwmon/hwmon.c is seems that is_visible is only called by gen_attr/gen_attrs which is only called by __hwmon_create_attrs and then by registers functions.
>>>> So perhaps it explain why it is never called.
>>>
>>> Ah yes, you are correct. Sorry, it has been too long ago that I wrote that code.
>>> Effectively that means we'll have to rework the hwmon core to generate attributes
>>> anyway and leave it up to the driver core to call the is_visible function.
>>>
>>
>> Attached is an outline of what would be needed in the hwmon core.
>> Completely untested. I wonder if it may be easier to always
>> create all attributes and have them return -ENODATA if not
>> supported.
>>
>> Guenter
> 
> 
> Hello
> 
> Do you plan to send your change as patch ?
> My patch serie is stuck since now it depend on it.
> 
> Or can I send a new iteration of my serie with partial support for notify.
> 

Unfortunately I won't have time to work on this anytime soon.

Guenter
