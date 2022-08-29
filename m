Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDA25A4DF4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiH2N03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiH2N0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:26:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FA6E0BA
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661779440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NuVlFDDdZ7yC0FFHn+Ct3CaNxoa9Omb+EPvuDDgUNDA=;
        b=aMw79ppTVFsPz8rl2rXu9wdnR9lHNn9ouAUVkM1FWlWf1IAXnPyS1hMGLETH79zrK484f1
        u0qwOCEojW7YubhwJh2szY6v8TD2E+/11Nc7T6ch51po+2HRsylU52iHuqy6WrRh56ZjdC
        vg2JZ+8djPrcRQ6g+55PQnWyWUDvmqY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-300-TLZtWmavMDCrl_XVXpm0xQ-1; Mon, 29 Aug 2022 09:20:22 -0400
X-MC-Unique: TLZtWmavMDCrl_XVXpm0xQ-1
Received: by mail-ej1-f71.google.com with SMTP id qw34-20020a1709066a2200b00730ca5a94bfso2289780ejc.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=NuVlFDDdZ7yC0FFHn+Ct3CaNxoa9Omb+EPvuDDgUNDA=;
        b=A82VtiSC58WXZitdtX5Dxwwqxh4jkO4zkgw1cee7oqbnThcKhBBTMmRRS8Thpje8gq
         BTjL8VFEBW2WS2QnQm0PHnQTKYEA/lXofsFwgfnS5ro100hp57mkRpI35CrTfY2pfyUl
         C0TtIyEWv9GPSsNz1rsn1ZjER69808qdyTQNVYyPvVuop/8Sx35td/nb6sQqVSL9XWWW
         LAtpUW03qu+uimMQlX+2H5cns1YMTj4Z8PYTC2jpi/nZUcZbhdsdi9/akQKeolVgSLEs
         b+aMt5Fy748AFszye8VyckZ6Klaykr0EkOINgOGKMufNCJakLQweciRTdFPzvsBxo2uC
         2eBQ==
X-Gm-Message-State: ACgBeo0YVraKLQ7nNo7xSSG97HZ+KoM7D5yOYtGZ9Sye89xRR9wIHtlk
        ECsyMXowsZNUGIWCA4RS2cyETbl/XRd7tlCF7azWzLmPHsK6HWNeB8MXGzit1nXBuAQXdfrAJKj
        XzWQzuDa685QycUwaCh3vphiY
X-Received: by 2002:a05:6402:337:b0:447:c616:2aed with SMTP id q23-20020a056402033700b00447c6162aedmr14621809edw.127.1661779221093;
        Mon, 29 Aug 2022 06:20:21 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4/T7HO9twugSkVIrGWz8sbPW6joUbY1lFxeSEy5YM6caADRgCVkQAVEgJPyLGwzJlGZq8VyQ==
X-Received: by 2002:a05:6402:337:b0:447:c616:2aed with SMTP id q23-20020a056402033700b00447c6162aedmr14621788edw.127.1661779220824;
        Mon, 29 Aug 2022 06:20:20 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090676cc00b007413dde3151sm3645527ejn.130.2022.08.29.06.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 06:20:20 -0700 (PDT)
Message-ID: <dd71f560-6d57-8147-8010-f14abd4f63cf@redhat.com>
Date:   Mon, 29 Aug 2022 15:20:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] platform/x86: wmi: Lower verbosity of some duplicate GUID
 messages
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220826170053.2124-1-mario.limonciello@amd.com>
 <a547f88a-7ab2-e665-aa6d-d80ef74f4fd4@redhat.com>
 <12b98ed4-6bc3-455c-3b90-a159d811147d@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <12b98ed4-6bc3-455c-3b90-a159d811147d@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/29/22 14:17, Mario Limonciello wrote:
> On 8/29/22 06:45, Hans de Goede wrote:
>> Hi Mario,
>>
>> On 8/26/22 19:00, Mario Limonciello wrote:
>>> The WMI subsystem in the kernel currently tracks WMI devices by
>>> a GUID string not by ACPI device.  The GUID used by the `wmi-bmof`
>>> module however is available from many devices on nearly every machine.
>>>
>>> This originally was though to be a bug, but as it happens on most
>>> machines it is a design mistake.  As there isn't an active need to
>>> get the binary from each of the `wmi-bmof` device, special case it
>>> and lower the message to debugging.  This will help to identify if
>>> there are other duplicate GUIDs in the wild.
>>>
>>> If there are and the information contained in them is desirable it
>>> may be worth considering a design change to the WMI subsystem to
>>> access those.
>>>
>>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2017%2F12%2F8%2F913&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7Ce38feb41da464767725808da89b3efcc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637973703162395560%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=sGh1bVTcO7vXOF6%2BwibhS7nbSiH3aEEdVNGfanKkGF8%3D&amp;reserved=0
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>
>> I am a bit surprised by this patch. I though that there was
>> consensus that the right thing to do here is actually create
>> wmi-bus devices for the duplicate WMI-ids adding a numbered
>> postfix to the extra devices (lets not add the postfix
>> to the first device for each WMI GUID as some userspace
>> code / scripts may depend on the sysfs paths not changing).
>>
>> IMHO registering wmi-bus devices for all the WMI devices
>> in the ACPI table would be the right thing to do ?
> 
> I don't disagree it's the correct eventual direction, but I looked at it and it seems to be a much larger overhaul because that means drivers would also need to be able to specify which ACPI device they're intending on interacting with from wmi.c rather than just a GUID string.
> 
> So before going down that path I think it's best to understand if it really is just wmi-bmof causing these cases or more cases (low priority IMO) or if there really is a strong need for the overhaul.

Hmm, some alternative ideas (just brainstorming here):

1. Use an allow-multiple-instances-guids list/array fo guids and create multiple-devices
   for those, starting with the bmof guid. The bmof driver is a new-style wmi-bus driver
   so it can handle multiple instances/devices just fine

2. Always instantiate multiple devices, making sure that we keep an ordered list of
   them, so that when searching for a guid through the old-style APIs we always
   find the first instance; and document that the old-style APIs always operate
   on the first wmi_device probed which matches the requested GUID

IMHO if an old-style driver needs to support multiple instances of the same GUID
it really should be converted to a new-style driver.

I personally think both suggestions are workable but I have a preference for option 1.

Regards,

Hans







> 
>>
>> Regards,
>>
>> Hans
>>
>>
>>
>>
>>> ---
>>>   drivers/platform/x86/wmi-bmof.c |  2 --
>>>   drivers/platform/x86/wmi.c      | 10 ++++++++--
>>>   include/linux/wmi.h             |  2 ++
>>>   3 files changed, 10 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/platform/x86/wmi-bmof.c b/drivers/platform/x86/wmi-bmof.c
>>> index 80137afb9753..af46e9e03376 100644
>>> --- a/drivers/platform/x86/wmi-bmof.c
>>> +++ b/drivers/platform/x86/wmi-bmof.c
>>> @@ -18,8 +18,6 @@
>>>   #include <linux/types.h>
>>>   #include <linux/wmi.h>
>>>   -#define WMI_BMOF_GUID "05901221-D566-11D1-B2F0-00A0C9062910"
>>> -
>>>   struct bmof_priv {
>>>       union acpi_object *bmofdata;
>>>       struct bin_attribute bmof_bin_attr;
>>> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
>>> index aed293b5af81..d7a1f4bf443b 100644
>>> --- a/drivers/platform/x86/wmi.c
>>> +++ b/drivers/platform/x86/wmi.c
>>> @@ -1157,6 +1157,9 @@ static void wmi_free_devices(struct acpi_device *device)
>>>   static bool guid_already_parsed(struct acpi_device *device, const guid_t *guid)
>>>   {
>>>       struct wmi_block *wblock;
>>> +    guid_t guid_wmi_bmof;
>>> +
>>> +    guid_parse(WMI_BMOF_GUID, &guid_wmi_bmof);
>>>         list_for_each_entry(wblock, &wmi_block_list, list) {
>>>           if (guid_equal(&wblock->gblock.guid, guid)) {
>>> @@ -1166,8 +1169,11 @@ static bool guid_already_parsed(struct acpi_device *device, const guid_t *guid)
>>>                * we need to suppress GUIDs that are unique on a
>>>                * given node but duplicated across nodes.
>>>                */
>>> -            dev_warn(&device->dev, "duplicate WMI GUID %pUL (first instance was on %s)\n",
>>> -                 guid, dev_name(&wblock->acpi_device->dev));
>>> +            if (guid_equal(guid, &guid_wmi_bmof))
>>> +                dev_dbg(&device->dev, "duplicate WMI-BMOF GUID found\n");
>>> +            else
>>> +                dev_warn(&device->dev, "duplicate WMI GUID %pUL (first instance was on %s)\n",
>>> +                     guid, dev_name(&wblock->acpi_device->dev));
>>>               return true;
>>>           }
>>>       }
>>> diff --git a/include/linux/wmi.h b/include/linux/wmi.h
>>> index b88d7b58e61e..59acdceb4411 100644
>>> --- a/include/linux/wmi.h
>>> +++ b/include/linux/wmi.h
>>> @@ -13,6 +13,8 @@
>>>   #include <linux/mod_devicetable.h>
>>>   #include <uapi/linux/wmi.h>
>>>   +#define WMI_BMOF_GUID "05901221-D566-11D1-B2F0-00A0C9062910"
>>> +
>>>   struct wmi_device {
>>>       struct device dev;
>>>   
>>
> 

