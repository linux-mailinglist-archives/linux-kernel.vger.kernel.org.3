Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064B75AA975
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235641AbiIBIHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbiIBIHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:07:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4031CB5E5F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 01:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662106065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jkCqqIO8foYTlUIWanTYmb1eD9F9iDyE1IcUyDBWeec=;
        b=O6vdiwk95cjdtthpSa3Ukwam/jKluX8X2RaJaBxJujB5n9SjEK8973/2HhfVZ9Sih0R06Q
        GmNi5qaaaVbhNLVQRaI5voBgDTNZvYBYzTTJRhiqBGl2HGS8JsYqTu/xhr/VD+gTJPshw6
        jiqDzSUDMxeaW1MV+NKh042hX8XWDvw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-370-40ccyVOXNmWkKRLMF7Qq5g-1; Fri, 02 Sep 2022 04:07:44 -0400
X-MC-Unique: 40ccyVOXNmWkKRLMF7Qq5g-1
Received: by mail-ed1-f69.google.com with SMTP id p4-20020a056402500400b00447e8b6f62bso890302eda.17
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 01:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=jkCqqIO8foYTlUIWanTYmb1eD9F9iDyE1IcUyDBWeec=;
        b=M+LwImHr0rY4+vvb2z/jO29xCppJxUpwmHB7XFOkf/9w5GOB9xeHu1gD3UZtKSzjU+
         0EK+MtQUZs5xTNoNPSIm0RcaubG8fWFDsC4ShjBNJoma183HOmjnqjXr39/ZfmNLOtUw
         dIwef2EVN7rHs1Vtx7MQphqCJXvVPVqMdjhsGKL4jff3hZgY17PsH4ahFvAsK22wQIh+
         TM7TOQUQZimOHCGrB5w8+r6ox5LVsOP+jI2YFJuP0szaqAdfpdJA9uEEdhiopt0PWViY
         7jt50iP2fsRS+U4W0/1g3ykTMTM9Q2vbhh27YNNq3AzlJPkfiR2zNcK4UswQoFrMXZ+w
         zW9Q==
X-Gm-Message-State: ACgBeo2giQcaf64n+JHC9whxyH+DDD/w43uxaL4KABPTV9jqjKk4XGYU
        +DHard7HREAusRL/lzKJVFdqGprhlWd7E1UamRo14JWONRQcDBDcHwNfJx8hgr5SkQyxMb/j/5m
        1Eo+oXU4iSnmGHEvDuGe5z99N
X-Received: by 2002:a17:907:c0f:b0:741:9525:23d6 with SMTP id ga15-20020a1709070c0f00b00741952523d6mr16448790ejc.277.1662106062840;
        Fri, 02 Sep 2022 01:07:42 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4yiYTHzK+gzUo9zoqd/CH/evovZNWSJQnB5hGXo9T+dVDAD70xJ3OfQlaE7vw9o+Y8pgJXBQ==
X-Received: by 2002:a17:907:c0f:b0:741:9525:23d6 with SMTP id ga15-20020a1709070c0f00b00741952523d6mr16448773ejc.277.1662106062622;
        Fri, 02 Sep 2022 01:07:42 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id gz28-20020a170907a05c00b0072b92daef1csm848895ejc.146.2022.09.02.01.07.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 01:07:41 -0700 (PDT)
Message-ID: <3df6405a-924a-b0e6-c879-05b9151011e3@redhat.com>
Date:   Fri, 2 Sep 2022 10:07:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] platform/x86: wmi: Allow duplicate GUIDs for drivers
 that use struct wmi_driver
Content-Language: en-US
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20220829201500.6341-1-mario.limonciello@amd.com>
 <CAHp75Vc3v4a6=ZJnOYYFGHEomExxopuUy8axDL=M2tbxHqtXqQ@mail.gmail.com>
 <MN0PR12MB6101441AA29CE815DCAD26AEE27B9@MN0PR12MB6101.namprd12.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <MN0PR12MB6101441AA29CE815DCAD26AEE27B9@MN0PR12MB6101.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 9/1/22 23:39, Limonciello, Mario wrote:
> [Public]
> 
> 
> 
>> -----Original Message-----
>> From: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Sent: Thursday, September 1, 2022 12:17
>> To: Limonciello, Mario <Mario.Limonciello@amd.com>
>> Cc: Hans de Goede <hdegoede@redhat.com>; Mark Gross
>> <markgross@kernel.org>; Platform Driver <platform-driver-
>> x86@vger.kernel.org>; Linux Kernel Mailing List <linux-
>> kernel@vger.kernel.org>
>> Subject: Re: [PATCH v2] platform/x86: wmi: Allow duplicate GUIDs for drivers
>> that use struct wmi_driver
>>
>> On Mon, Aug 29, 2022 at 11:20 PM Mario Limonciello
>> <mario.limonciello@amd.com> wrote:
>>>
>>> The WMI subsystem in the kernel currently tracks WMI devices by
>>> a GUID string not by ACPI device.  The GUID used by the `wmi-bmof`
>>> module however is available from many devices on nearly every machine.
>>>
>>> This originally was though to be a bug, but as it happens on most
>>
>> thought
>>
>>> machines it is a design mistake.  It has been fixed by tying an ACPI
>>> device to the driver with struct wmi_driver. So drivers that have
>>> moved over to struct wmi_driver can actually support multiple
>>> instantiations of a GUID without any problem.
>>>
>>> Add an allow list into wmi.c for GUIDs that the drivers that are known
>>> to use struct wmi_driver.  The list is populated with `wmi-bmof` right
>>> now. The additional instances of that in sysfs with be suffixed with -%d
>>
>> ...
>>
>>> +/* allow duplicate GUIDs as these device drivers use struct wmi_driver */
>>> +static const char * const allow_duplicates[] = {
>>> +       "05901221-D566-11D1-B2F0-00A0C9062910", /* wmi-bmof */
>>> +       NULL,
>>
>> No comma for the terminator.
>>
>>> +};
>>
>> ...
>>
>>> +static int guid_count(const guid_t *guid)
>>> +{
>>> +       struct wmi_block *wblock;
>>> +       int count = 0;
>>> +
>>> +       list_for_each_entry(wblock, &wmi_block_list, list) {
>>> +               if (guid_equal(&wblock->gblock.guid, guid))
>>> +                       count++;
>>> +       }
>>> +
>>> +       return count;
>>> +}
>>
>> I haven't deeply checked the code, but this kind of approach is
>> fragile and proven to be error prone as shown in practice. The
>> scenario is (again, not sure if it's possible, need a comment in the
>> code if it's not possible) removing an entry from the list in the
>> middle and trying to add it again. you will see the duplicate count
>> values. That's why in the general case we use IDA or similar
>> approaches.
> 
> It shouldn't be possible to add/remove from the list, they're fixed
> lists that were parsed from _WDG.
> 
> Hans - since you already took this into your review queue, can you
> land fixes for the 3 things Andy pointed out before it goes to -next
> or do you want me to do a manual follow up for them?

I can do a local fix and squash it into the original commit.

> 1) Spelling error in commit message
> 2) Remove comma on terminator

Ack, will fix.

> 3) Add a comment why guid_count is safe (if you agree with me it is)

I agree it is safe.

Can you suggest some wording for the comment please ?

Regards,

Hans

