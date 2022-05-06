Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE1A51D643
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 13:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348136AbiEFLLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 07:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391181AbiEFLLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 07:11:39 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A65916833C
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 04:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651835267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2HuLCNJx05zSHUlmMHT6S4qU45txmydxhGQw118xWYA=;
        b=J/gBGU1JU9cndh2UZNwRXPhdspvt7SEWS0ZmlttkWmbTH6x5yrAasGMNqpz8FwYDXpWzzL
        tOjVB6FfA3n6m3GpvW+ZgFURdIHfsfzSPip1TnEVnmzbrsh3m3z+rDm5/cT4760zIH+Rn5
        SghJlCb+Fmsge507aFGGEqJRA2mTYIU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-DIl5JVsaPuGr1-aZpcB71w-1; Fri, 06 May 2022 07:07:46 -0400
X-MC-Unique: DIl5JVsaPuGr1-aZpcB71w-1
Received: by mail-ed1-f69.google.com with SMTP id dk9-20020a0564021d8900b00425a9c3d40cso3839438edb.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 04:07:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=2HuLCNJx05zSHUlmMHT6S4qU45txmydxhGQw118xWYA=;
        b=xXd5UlI6OsLEunqLk0KTLlhfZsVrS9tM+tFNSatN7VR2opkLnGmsYekFbvNCmRIjHq
         iFhCXa1QIjYaH0Y5vcUa01n8/jVASzhoX44hCi4B6Sy+6UeSXU/xAGIIpvbzLeUwACHc
         ep5aHME64hB2jOHNj2IEIvKEPFKXuC8CJz07s+AZJ7fqZUuvzdBwdiCluS0Av3uWAC+Z
         afScEvvJqbV/LYA7ox4HzHbVofWrMrA0l8ORyBgdl4N6dsmD76qz0Hn1KigXd0WR2j/u
         erjhWK8UQ92clXnKGijmJqzrhaF6Z2niQArU76XNrUHB0YxCC2KZn6Aaj/DyDpNErAKV
         9paQ==
X-Gm-Message-State: AOAM5315rIz6ZT4Ivs8GUndVw5gMHB32x1ZRt3jcJn1VWvHW3nHlCv3B
        oW5+oGBq5VSA2sw9O1pFcgThBJtEvXFCoID3/5T/0DVsxcXB2AlfySpxWGEref55P75VYbqf4ys
        tXrjezNF27h45epY1HQEkYvnS
X-Received: by 2002:a17:906:7304:b0:6da:9243:865 with SMTP id di4-20020a170906730400b006da92430865mr2426216ejc.665.1651835265100;
        Fri, 06 May 2022 04:07:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtt/k2RqUCTLzZmSJ4UcadrnPC2p2no+9LACk99FJ0/KvCTo6d0VDn6NtS0MTVYVpgZY2MQQ==
X-Received: by 2002:a17:906:7304:b0:6da:9243:865 with SMTP id di4-20020a170906730400b006da92430865mr2426195ejc.665.1651835264887;
        Fri, 06 May 2022 04:07:44 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id i24-20020a05640200d800b0042617ba63a8sm2205496edu.50.2022.05.06.04.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 04:07:44 -0700 (PDT)
Message-ID: <565fd863-49b2-5dca-8271-579a94b3b860@redhat.com>
Date:   Fri, 6 May 2022 13:07:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [RFC PATCH pdx86-platform-drivers-x86] platform/x86:
 thinkpad_acpi: quirk_btusb_bug can be static
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        kernel test robot <lkp@intel.com>
Cc:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <202205031944.EP1ElC1B-lkp@intel.com>
 <YnEPbSO2rBJq37Ez@74ccfaeec2ea>
 <BL1PR12MB5157478736D9C5E82B4D9B1DE2C09@BL1PR12MB5157.namprd12.prod.outlook.com>
 <69b622c0-550b-f562-eb1e-7614e97acc25@redhat.com>
In-Reply-To: <69b622c0-550b-f562-eb1e-7614e97acc25@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/6/22 12:09, Hans de Goede wrote:
> Hi,
> 
> On 5/3/22 15:07, Limonciello, Mario wrote:
>> [Public]
>>
>>
>>
>>> -----Original Message-----
>>> From: kernel test robot <lkp@intel.com>
>>> Sent: Tuesday, May 3, 2022 06:18
>>> To: Limonciello, Mario <Mario.Limonciello@amd.com>
>>> Cc: kbuild-all@lists.01.org; Andy Shevchenko
>>> <andriy.shevchenko@linux.intel.com>; Hans de Goede
>>> <hdegoede@redhat.com>; linux-kernel@vger.kernel.org
>>> Subject: [RFC PATCH pdx86-platform-drivers-x86] platform/x86:
>>> thinkpad_acpi: quirk_btusb_bug can be static
>>>
>>> drivers/platform/x86/thinkpad_acpi.c:317:20: warning: symbol
>>> 'quirk_btusb_bug' was not declared. Should it be static?
>>>
>>> Fixes: 25eecc2ff6cc ("platform/x86: thinkpad_acpi: Convert btusb DMI list to
>>> quirks")
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Signed-off-by: kernel test robot <lkp@intel.com>
>>
>> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Thanks, since the original patch was still in my review-hans
> branch (and not yet in for-next) I've squashed this fix into
> the original patch.

I've just realized there is another issue with this
("platform/x86: thinkpad_acpi: Convert btusb DMI list to quirks")

Patch, it only sets tp_features.quirks after bluetooth_init()
has already run, so the:

	if (tp_features.quirks && tp_features.quirks->btusb_bug && ...

check will never be true since tp_features.quirks is being set
too late.

I'll squash in a change moving the:

        dmi_id = dmi_first_match(fwbug_list);
        if (dmi_id)
                tp_features.quirks = dmi_id->driver_data;

to higher inside thinkpad_acpi_module_init() to fix this,
while keeping the:

#ifdef CONFIG_SUSPEND
       if (tp_features.quirks && tp_features.quirks->s2idle_bug_mmio) {
               if (!acpi_register_lps0_dev(&thinkpad_acpi_s2idle_dev_ops))
                       pr_info("Using s2idle quirk to avoid %s platform firmware bug\n",
                               (dmi_id && dmi_id->ident) ? dmi_id->ident : "");
       }
#endif

block at then end of thinkpad_acpi_module_init() so as to not change
the ordering wrt registering the lps0_dev.

Regards,

Hans





> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> 
>>
>>> ---
>>>  drivers/platform/x86/thinkpad_acpi.c |    2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/platform/x86/thinkpad_acpi.c
>>> b/drivers/platform/x86/thinkpad_acpi.c
>>> index aed17d32ed84b..eefa22e86ae10 100644
>>> --- a/drivers/platform/x86/thinkpad_acpi.c
>>> +++ b/drivers/platform/x86/thinkpad_acpi.c
>>> @@ -314,7 +314,7 @@ struct quirk_entry {
>>>  	bool btusb_bug;
>>>  };
>>>
>>> -struct quirk_entry quirk_btusb_bug = {
>>> +static struct quirk_entry quirk_btusb_bug = {
>>>  	.btusb_bug = true,
>>>  };
>>>
>>

