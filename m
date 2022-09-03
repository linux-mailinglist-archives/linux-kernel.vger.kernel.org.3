Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C631E5ABEAB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 13:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiICLMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 07:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiICLMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 07:12:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF366BD4D
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 04:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662203557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5IrOfp9puY1TEMIMWVabBtxJr8/+Tn4f9nR5sBX7gVk=;
        b=RI97WCNvmOp2rhnby94j6ma04X/Hvy+015in2ddpjWB3oJqiYQDMxEuA75EjtdY2moKy4/
        6fRiic0uUazPfT28PKtjTGIi0Hub7lRPig89bNwzlvkoI3qE8iKyjI8jaht0vGGogn/OCW
        NXG/kqMvjIb884ukN7z0hEIDxe+SH2Q=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-90-6ujjT9VtPCiihd4QQXGl3w-1; Sat, 03 Sep 2022 07:12:33 -0400
X-MC-Unique: 6ujjT9VtPCiihd4QQXGl3w-1
Received: by mail-ed1-f71.google.com with SMTP id c14-20020a05640227ce00b0043e5df12e2cso2953179ede.15
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 04:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=5IrOfp9puY1TEMIMWVabBtxJr8/+Tn4f9nR5sBX7gVk=;
        b=Qm8Dg9tCK3Z5eKoBs5vVS8/UIGWGWumKzt58P+ZY202gB5bp1uw6gWBj8drw6gYvyj
         aEMObyCHSN1yNgfprbQJu9IHa2OilWjYj+4IJHQbv4NpXQK1Ejfc+H2r082htT1AQQo1
         Y+YjWHlKvW0GY9z25ZxVRqEuTtWCNg49lz2UHHDbAVOkQ+FAt9lMIWE3+C8Uaur7C546
         OkRwpD9Yu2766sPvIM4lOtkFtY8di9D44H54wDmI8gB42Vu8HMIlg0KBnups1WxeRNsb
         9TryRZYtluEqo0mD+3ohMfAYo8QbCCZbavx1UeznqeSfQdsnEqOzpFfREuVlp1DOr3bp
         TlxQ==
X-Gm-Message-State: ACgBeo3dfVEZdRCbklaqa5MaIyQN6feEfHaLRBO+s2fZQTp1rYK7NIrv
        tJHQkB9uZk1x2xzig0HQ3APkzW9m3xYmsn1wfdPeiOGp2c8a5HLcCjyJm+EE0Lp9fw1Akxf0FiX
        ESMoFbcN5cevnP2UuK1ufkJdo
X-Received: by 2002:a17:907:74e:b0:74f:83d4:cf58 with SMTP id xc14-20020a170907074e00b0074f83d4cf58mr5338319ejb.178.1662203552843;
        Sat, 03 Sep 2022 04:12:32 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6zDs4lYW9Hm1WbO9PCWqUvNoagEH3Orok7R1GTo5J0ZffsXhhHyi2wrtS4MHcdhAMjyftl/w==
X-Received: by 2002:a17:907:74e:b0:74f:83d4:cf58 with SMTP id xc14-20020a170907074e00b0074f83d4cf58mr5338312ejb.178.1662203552662;
        Sat, 03 Sep 2022 04:12:32 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id b13-20020aa7d48d000000b00445d760fc69sm3121347edr.50.2022.09.03.04.12.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Sep 2022 04:12:32 -0700 (PDT)
Message-ID: <0033b40f-f583-c3a4-ce87-73cbb362537b@redhat.com>
Date:   Sat, 3 Sep 2022 13:12:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] platform/x86: wmi: Allow duplicate GUIDs for drivers
 that use struct wmi_driver
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20220829201500.6341-1-mario.limonciello@amd.com>
 <CAHp75Vc3v4a6=ZJnOYYFGHEomExxopuUy8axDL=M2tbxHqtXqQ@mail.gmail.com>
 <MN0PR12MB6101441AA29CE815DCAD26AEE27B9@MN0PR12MB6101.namprd12.prod.outlook.com>
 <3df6405a-924a-b0e6-c879-05b9151011e3@redhat.com>
 <168cb996-513e-77a8-b895-ef0fdd0c1793@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <168cb996-513e-77a8-b895-ef0fdd0c1793@amd.com>
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

On 9/2/22 14:19, Mario Limonciello wrote:
> On 9/2/22 03:07, Hans de Goede wrote:
>> Hi,
>>
>> On 9/1/22 23:39, Limonciello, Mario wrote:
>>> [Public]
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Andy Shevchenko <andy.shevchenko@gmail.com>
>>>> Sent: Thursday, September 1, 2022 12:17
>>>> To: Limonciello, Mario <Mario.Limonciello@amd.com>
>>>> Cc: Hans de Goede <hdegoede@redhat.com>; Mark Gross
>>>> <markgross@kernel.org>; Platform Driver <platform-driver-
>>>> x86@vger.kernel.org>; Linux Kernel Mailing List <linux-
>>>> kernel@vger.kernel.org>
>>>> Subject: Re: [PATCH v2] platform/x86: wmi: Allow duplicate GUIDs for drivers
>>>> that use struct wmi_driver
>>>>
>>>> On Mon, Aug 29, 2022 at 11:20 PM Mario Limonciello
>>>> <mario.limonciello@amd.com> wrote:
>>>>>
>>>>> The WMI subsystem in the kernel currently tracks WMI devices by
>>>>> a GUID string not by ACPI device.  The GUID used by the `wmi-bmof`
>>>>> module however is available from many devices on nearly every machine.
>>>>>
>>>>> This originally was though to be a bug, but as it happens on most
>>>>
>>>> thought
>>>>
>>>>> machines it is a design mistake.  It has been fixed by tying an ACPI
>>>>> device to the driver with struct wmi_driver. So drivers that have
>>>>> moved over to struct wmi_driver can actually support multiple
>>>>> instantiations of a GUID without any problem.
>>>>>
>>>>> Add an allow list into wmi.c for GUIDs that the drivers that are known
>>>>> to use struct wmi_driver.  The list is populated with `wmi-bmof` right
>>>>> now. The additional instances of that in sysfs with be suffixed with -%d
>>>>
>>>> ...
>>>>
>>>>> +/* allow duplicate GUIDs as these device drivers use struct wmi_driver */
>>>>> +static const char * const allow_duplicates[] = {
>>>>> +       "05901221-D566-11D1-B2F0-00A0C9062910", /* wmi-bmof */
>>>>> +       NULL,
>>>>
>>>> No comma for the terminator.
>>>>
>>>>> +};
>>>>
>>>> ...
>>>>
>>>>> +static int guid_count(const guid_t *guid)
>>>>> +{
>>>>> +       struct wmi_block *wblock;
>>>>> +       int count = 0;
>>>>> +
>>>>> +       list_for_each_entry(wblock, &wmi_block_list, list) {
>>>>> +               if (guid_equal(&wblock->gblock.guid, guid))
>>>>> +                       count++;
>>>>> +       }
>>>>> +
>>>>> +       return count;
>>>>> +}
>>>>
>>>> I haven't deeply checked the code, but this kind of approach is
>>>> fragile and proven to be error prone as shown in practice. The
>>>> scenario is (again, not sure if it's possible, need a comment in the
>>>> code if it's not possible) removing an entry from the list in the
>>>> middle and trying to add it again. you will see the duplicate count
>>>> values. That's why in the general case we use IDA or similar
>>>> approaches.
>>>
>>> It shouldn't be possible to add/remove from the list, they're fixed
>>> lists that were parsed from _WDG.
>>>
>>> Hans - since you already took this into your review queue, can you
>>> land fixes for the 3 things Andy pointed out before it goes to -next
>>> or do you want me to do a manual follow up for them?
>>
>> I can do a local fix and squash it into the original commit.
>>
>>> 1) Spelling error in commit message
>>> 2) Remove comma on terminator
>>
>> Ack, will fix.
>>
>>> 3) Add a comment why guid_count is safe (if you agree with me it is)
>>
>> I agree it is safe.
>>
>> Can you suggest some wording for the comment please ?
>>
>> Regards,
>>
>> Hans
>>
> 
> Maybe something like "_WDG is a static list that is only parsed at startup, it's safe to count entries without extra protection".

Ok, that works for me. I've added that as a comment as
well as squashed in the other 2 suggestions by Andy.

Regards,

Hans

