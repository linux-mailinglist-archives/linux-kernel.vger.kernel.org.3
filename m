Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D70C47C6B7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbhLUSio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:38:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54846 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241405AbhLUSin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:38:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640111922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ay+hHPn3ZbkucnHux9lLB/ZyzbzyXlY5HPlEik2yfME=;
        b=UHQnh62RYd6uWd86aSweqviGgPJBqnQmAbXgRWg5Zd+esTAUYpoXhIy0q1sY/8B0VfjkgO
        0yhmy4vLMmCMyF4G4sMTXdZeAdEBeR9BFogT0DB3BglIN3FONwEwVDTBy5cjVtN2QOCtVw
        6kdu0V8ZObNSiDmJ4hxPPietxqOy7bc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-_9etlqA8MU2QLp8Z7As2Uw-1; Tue, 21 Dec 2021 13:38:41 -0500
X-MC-Unique: _9etlqA8MU2QLp8Z7As2Uw-1
Received: by mail-ed1-f70.google.com with SMTP id h22-20020a056402281600b003f839627a38so7275305ede.23
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 10:38:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ay+hHPn3ZbkucnHux9lLB/ZyzbzyXlY5HPlEik2yfME=;
        b=tb/aZT56XWHpEy/mg69j3mwVdHWBPXwOYnvE4Kzyx19Tv/kS3milGQ2mY8XokK5kXl
         4Q6t8ecrAMQLG3kU5r0eMC6aZYnHpGD+H+06kfmVj/UfplYoEHS7WC382R+x476l8ypI
         qM8pamB1aYwYFfUwRrKP27LqjGRdMPTlEC831QBGEp28ikzCI7KB55UTpQ1gk73xEdba
         AlEvh3oAq4aWMXwF8E8zr7IcS+itDUJtDEAMdMhjoIypcobUjNpiB51GNJp88QcTRyOr
         vlsxgK51ReHvPvFKEa/hHGL1WJ2z+q0V6nbzQ7T1ARPwVN4rERpGfb25D9HSyPe6XAl3
         yT7w==
X-Gm-Message-State: AOAM5300l25c44lRpRHnnOPR2zbhfjj9kKegOaefgYvEhiXXJGHuFF6M
        a6R/NZda5PJpZrEdNu27OiMCCFd3Q1K+GTGO6lLGibNO5AjHyOgHyt1WadJeF1wQPD67IAlMt+K
        LwBNBHS/2cA5xHa+4nTlaQQxo
X-Received: by 2002:a17:906:c110:: with SMTP id do16mr2763158ejc.625.1640111920034;
        Tue, 21 Dec 2021 10:38:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxmK2zX/ZNwqmdTy7V2hyclXI/2mnVzG9TwQNXBlrGUsBDzKS/mDQx2Gts3xnsNqEOBwO1Tlg==
X-Received: by 2002:a17:906:c110:: with SMTP id do16mr2763139ejc.625.1640111919801;
        Tue, 21 Dec 2021 10:38:39 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id zh8sm5055872ejb.21.2021.12.21.10.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 10:38:39 -0800 (PST)
Message-ID: <8c9d0a86-cbbb-be1b-41b1-61f27890b77d@redhat.com>
Date:   Tue, 21 Dec 2021 19:38:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH RESEND V2 3/6] platform/x86/intel: Move intel_pmt from MFD
 to Auxiliary Bus
Content-Language: en-US
To:     david.e.box@linux.intel.com, Greg KH <gregkh@linuxfoundation.org>
Cc:     lee.jones@linaro.org, bhelgaas@google.com,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
References: <20211208015015.891275-1-david.e.box@linux.intel.com>
 <20211208015015.891275-4-david.e.box@linux.intel.com>
 <YbDbql39x7Kw6iAC@kroah.com>
 <7e78e6311cb0d261892f7361a1ef10130436f358.camel@linux.intel.com>
 <YbD1NsYHbU8FvtTN@kroah.com>
 <a70956e1c4da10603e29087e893cbae62ce82631.camel@linux.intel.com>
 <YbEFuN7fwdiNI8vW@kroah.com>
 <622887d53eaf6e6ae36354bfa0ed483df1cd9214.camel@linux.intel.com>
 <YcGEaH0oAAocziU2@kroah.com>
 <e9648546c3fb751954e411dfa392f0e0f90f0c85.camel@linux.intel.com>
 <YcIGwZqm2sfIixkH@kroah.com>
 <3913dfd7-3872-7d69-24af-eba747a7a92d@redhat.com>
 <be2a1cce5691e5dc7fb875f46d5f2085b6a55542.camel@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <be2a1cce5691e5dc7fb875f46d5f2085b6a55542.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/21/21 19:16, David E. Box wrote:
> On Tue, 2021-12-21 at 18:04 +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 12/21/21 17:54, Greg KH wrote:
>>> On Tue, Dec 21, 2021 at 08:44:57AM -0800, David E. Box wrote:
>>>> On Tue, 2021-12-21 at 08:38 +0100, Greg KH wrote:
>>>>> On Wed, Dec 08, 2021 at 01:30:06PM -0800, David E. Box wrote:
>>>>>> On Wed, 2021-12-08 at 20:21 +0100, Greg KH wrote:
>>>>>>> On Wed, Dec 08, 2021 at 11:09:48AM -0800, David E. Box wrote:
>>>>>>>> On Wed, 2021-12-08 at 19:11 +0100, Greg KH wrote:
>>>>>>>>> On Wed, Dec 08, 2021 at 09:47:26AM -0800, David E. Box wrote:
>>>>>>>>>> On Wed, 2021-12-08 at 17:22 +0100, Greg KH wrote:
>>>>>>>>>>> On Tue, Dec 07, 2021 at 05:50:12PM -0800, David E. Box
>>>>>>>>>>> wrote:
>>>>>>>>>>>> +static struct pci_driver intel_vsec_pci_driver = {
>>>>>>>>>>>> +       .name = "intel_vsec",
>>>>>>>>>>>> +       .id_table = intel_vsec_pci_ids,
>>>>>>>>>>>> +       .probe = intel_vsec_pci_probe,
>>>>>>>>>>>> +};
>>>>>>>>>>>
>>>>>>>>>>> So when the PCI device is removed from the system you leak
>>>>>>>>>>> resources and
>>>>>>>>>>> have dangling devices?
>>>>>>>>>>
>>>>>>>>>> No.
>>>>>>>>>>
>>>>>>>>>>> Why no PCI remove driver callback?
>>>>>>>>>>
>>>>>>>>>> After probe all resources are device managed. There's nothing
>>>>>>>>>> to
>>>>>>>>>> explicitly clean up. When
>>>>>>>>>> the
>>>>>>>>>> PCI
>>>>>>>>>> device is removed, all aux devices are automatically removed.
>>>>>>>>>> This
>>>>>>>>>> is the case for the SDSi
>>>>>>>>>> driver
>>>>>>>>>> as well.
>>>>>>>>>
>>>>>>>>> Where is the "automatic cleanup" happening?  As this pci driver
>>>>>>>>> is
>>>>>>>>> bound
>>>>>>>>> to the PCI device, when the device is removed, what is called in
>>>>>>>>> this
>>>>>>>>> driver to remove the resources allocated in the probe callback?
>>>>>>>>>
>>>>>>>>> confused,
>>>>>>>>
>>>>>>>> devm_add_action_or_reset(&pdev->dev, intel_vsec_remove_aux,
>>>>>>>> auxdev)
>>>>>>>
>>>>>>> Wow that is opaque.  Why not do it on remove instead?
>>>>>>
>>>>>> This code is common for auxdev cleanup. AFAICT most auxiliary bus code
>>>>>> is
>>>>>> done by drivers that have
>>>>>> some other primary function. They clean up their primary function
>>>>>> resources
>>>>>> in remove, but they
>>>>>> clean up the auxdev using the method above. In this case the sole
>>>>>> purpose of
>>>>>> this driver is to
>>>>>> create the auxdev. There are no other resources beyond what the auxdev
>>>>>> is
>>>>>> using.
>>>>>>
>>>>>> Adding runtime pm to the pci driver will change this. Remove will be
>>>>>> needed
>>>>>> then.
>>>>>
>>>>> And who will notice that being required when that happens?
>>>>>
>>>>> Why is there no runtime PM for this driver?  Do you not care about power
>>>>> consumption?  :)
>>>>
>>>> Of course. :)
>>>>
>>>> There's a backlog of patches waiting for this series. One adds support for
>>>> the
>>>> telemetry device (an auxdev) on the DG2 GPU. This device requires runtime
>>>> pm in
>>>> order for the slot to go D3. But this also requires changes to the
>>>> telemetry
>>>> driver in order for runtime pm to be handled correctly. These and other
>>>> patches,
>>>> including a series to have all current aux drivers use the new drvdata
>>>> helpers,
>>>> are waiting for this.
>>>
>>> I can take the aux driver drvdata patch now, through my tree, if you
>>> want, no need to make it wait for this tiny driver.
>>>
>>> Feel free to send it independant of the existing patchset, and with the
>>> cleanup patches at the same time, should be quite easy to get merged.
>>
>> If you're going to take that one, can you perhaps take patches
>> 1-3 for 5.17 through your tree as well (patch 3 depends on 2/it) ?
>>
>> Note there is a v4 of this series, see please use that :)
>>
>> I assume the follow up patches are also going to need patch 3
>> (the actual conversion of the driver to aux-bus).
> 
> Yes.
> 
>>
>> Here is my Ack for the pdx86 bits in patch 3:
>>
>> Acked-by: Hans de Goede <hdegoede@redhat.com>
>>
>> And patch 1 and 3 also have acks from the PCI resp. MFD subsys maintainers,
>> so I guess taking this all upstream through your tree is fine.
> 
> Should I send 1-3 plus the drvdata cleanup patches I have to Grep? V5?

No there is no need for that v4 is fine, since no changes have been
requested there is no need to send out a new version.

Regards,

Hans

