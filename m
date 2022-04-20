Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AE8508456
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 11:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377029AbiDTJEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 05:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377033AbiDTJDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 05:03:55 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E16B1E3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 02:00:52 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id h11so1162739ljb.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 02:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Mm9IQcuw8CPxlnkWpkD0I9Qiw/wRrYXHRKvtGwqprgE=;
        b=ivPeTHCboPn/S32Q9aXG/tBBtObvdQeSvr/DgdMUDIhrTTfib7CWEy2WYHsLEr9EOf
         0xK2WiO4YGqhyqhKwtPwAX/1kdQO55qX6J7g2fITpr1iYrtJ2JW3ou1h1hXtYdK2tU4B
         +riA1kwnCAkNnb33yi92DSl4nbbNYGrJqztnB6M1royRBYqktgrJhvjnBXTdDeS07PPF
         755BProbUFW+sTKxKArSRHQ+E6IrJxe7KcpYXlaMkdiIQOxUIbLCyVmaZNPRHUT6KiVJ
         AsOc/Lh/YfcsaMeY1PS6r3TqGFJU/GQH7Oz9Q5Kdcn+fH1Z+OtKIVyEYmya04O5+3KDc
         JLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Mm9IQcuw8CPxlnkWpkD0I9Qiw/wRrYXHRKvtGwqprgE=;
        b=zG3VOURfcyrg0flVCtK1ZtbaqgAzytbmbenByPac4nqZhO6woo65uRjg10zZ/HHjxh
         jfUCyZofdo4Yhs+ZHOM4erd6pHjuIjmQVU6EWuMg+Vl+B7tBVkAnMJP9vONOC9GtedDj
         6Pb43ieYXeFv4n5gjlB4btaHPfBSsiCgi5rzver92Pon3sylnmp4fbfUinkG+qlRzsWy
         9tV9aw+zCGxcpi9dhK3wE7jWwFkwq5SIURfPOigqgxtHJ9RWyxYmMsdiOZlaG8bgjcFW
         mz2TTkiEIv8FphzHAe8wi1o40WTy8IpsYWxnXU3ZJicegQNy5CAN/FpED9zhllaH7f3w
         IUUg==
X-Gm-Message-State: AOAM530x/g2+bidFIpbaH1u3bYuZasOL/DkFStTMTZgYQ2QaXkiWMZ7R
        sagl1flt3kxRw2gLHwpTG3A=
X-Google-Smtp-Source: ABdhPJyQhZBI3AqCt87T7H2gP7s5E2mi3TolDMY1V1To6m/Pl28eDjChTAvh/qulD3kbDt9e/fVCoA==
X-Received: by 2002:a2e:a552:0:b0:24d:c784:4b43 with SMTP id e18-20020a2ea552000000b0024dc7844b43mr4314706ljn.4.1650445248959;
        Wed, 20 Apr 2022 02:00:48 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id u26-20020ac25bda000000b0046d148d5297sm1758092lfn.184.2022.04.20.02.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 02:00:48 -0700 (PDT)
Subject: Re: [RFC PATCH 6/6] arm/xen: Assign xen-virtio DMA ops for virtio
 devices in Xen guests
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Julien Grall <julien@xen.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <1649963973-22879-1-git-send-email-olekstysh@gmail.com>
 <1649963973-22879-7-git-send-email-olekstysh@gmail.com>
 <alpine.DEB.2.22.394.2204151305050.915916@ubuntu-linux-20-04-desktop>
 <YlpdBHKT1bYzZe2e@infradead.org>
 <f879622e-5656-deb1-1930-f0cd180a4ab1@gmail.com>
 <alpine.DEB.2.22.394.2204181202080.915916@ubuntu-linux-20-04-desktop>
 <6a04cc34-fbb3-44d8-c1a4-03bda5b3deb1@gmail.com>
 <b68163be-ad43-7773-22ff-e83191886626@suse.com>
 <5afb9e61-4164-9cc9-278a-911fc21f4f6c@gmail.com>
 <alpine.DEB.2.22.394.2204191717020.915916@ubuntu-linux-20-04-desktop>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <7047c7a7-47a0-d446-3b99-94bd552ec90f@gmail.com>
Date:   Wed, 20 Apr 2022 12:00:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2204191717020.915916@ubuntu-linux-20-04-desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Stefano, Juergen


On 20.04.22 03:23, Stefano Stabellini wrote:
> On Tue, 19 Apr 2022, Oleksandr wrote:
>> On 19.04.22 17:48, Juergen Gross wrote:
>>> On 19.04.22 14:17, Oleksandr wrote:
>>>> Hello Stefano, Juergen
>>>>
>>>>
>>>> On 18.04.22 22:11, Stefano Stabellini wrote:
>>>>> On Mon, 18 Apr 2022, Oleksandr wrote:
>>>>>> On 16.04.22 09:07, Christoph Hellwig wrote:
>>>>>>
>>>>>> Hello Christoph
>>>>>>
>>>>>>> On Fri, Apr 15, 2022 at 03:02:45PM -0700, Stefano Stabellini wrote:
>>>>>>>> This makes sense overall. Considering that the swiotlb-xen case
>>>>>>>> and the
>>>>>>>> virtio case are mutually exclusive, I would write it like this:
>>>>>>> Curious question:  Why can't the same grant scheme also be used for
>>>>>>> non-virtio devices?  I really hate having virtio hooks in the arch
>>>>>>> dma code.  Why can't Xen just say in DT/ACPI that grants can be used
>>>>>>> for a given device?
>>>>> [...]
>>>>>
>>>>>> This patch series tries to make things work with "virtio" devices in
>>>>>> Xen
>>>>>> system without introducing any modifications to code under
>>>>>> drivers/virtio.
>>>>> Actually, I think Christoph has a point.
>>>>>
>>>>> There is nothing inherently virtio specific in this patch series or in
>>>>> the "xen,dev-domid" device tree binding.
>>>>
>>>> Although the main intention of this series was to enable using virtio
>>>> devices in Xen guests, I agree that nothing in new DMA ops layer
>>>> (xen-virtio.c) is virtio specific (at least at the moment). Regarding the
>>>> whole patch series I am not quite sure, as it uses
>>>> arch_has_restricted_virtio_memory_access(). >
>>>>>    Assuming a given device is
>>>>> emulated by a Xen backend, it could be used with grants as well.
>>>>>
>>>>> For instance, we could provide an emulated e1000 NIC with a
>>>>> "xen,dev-domid" property in device tree. Linux could use grants with it
>>>>> and the backend could map the grants. It would work the same way as
>>>>> virtio-net/block/etc. Passthrough devices wouldn't have the
>>>>> "xen,dev-domid" property, so no problems.
>>>>>
>>>>> So I think we could easily generalize this work and expand it to any
>>>>> device. We just need to hook on the "xen,dev-domid" device tree
>>>>> property.
>>>>>
>>>>> I think it is just a matter of:
>>>>> - remove the "virtio,mmio" check from xen_is_virtio_device
>>>>> - rename xen_is_virtio_device to something more generic, like
>>>>>     xen_is_grants_device
>>> xen_is_grants_dma_device, please. Normal Xen PV devices are covered by
>>> grants, too, and I'd like to avoid the confusion arising from this.
>>
>> yes, this definitely makes sense as we need to distinguish
>>
>>
>>>
>>>>> - rename xen_virtio_setup_dma_ops to something more generic, like
>>>>>     xen_grants_setup_dma_ops
>>>>>
>>>>> And that's pretty much it.
>>>> + likely renaming everything in that patch series not to mention virtio
>>>> (mostly related to xen-virtio.c internals).
>>>>
>>>>
>>>> Stefano, thank you for clarifying Christoph's point.
>>>>
>>>> Well, I am not against going this direction. Could we please make a
>>>> decision on this? @Juergen, what is your opinion?
>>> Yes, why not.
>>
>> ok, thank you for confirming.
>>
>>
>>>
>>> Maybe rename xen-virtio.c to grant-dma.c?
>>
>> Personally I don't mind.
>>
>>
>>> I'd keep the XEN_VIRTIO related config option, as this will be the normal
>>> use
>>> case. grant-dma.c should be covered by a new hidden config option
>>> XEN_GRANT_DMA
>>> selected by XEN_VIRTIO.
>>
>> I got it, ok
>>
>>
>>>
>>> CONFIG_XEN_VIRTIO should still guard
>>> xen_has_restricted_virtio_memory_access().
>>
>> ok
>>
>>
>> So a few questions to clarify:
>>
>> 1. What is the best place to keep "xen,dev-domid" binding's description now? I
>> think that proposed in current series place
>> (Documentation/devicetree/bindings/virtio/) is not good fit now.
> I would probably add it to the existing
> Documentation/devicetree/bindings/arm/xen.txt.
>
>
>> 2. I assume the logic in the current patch will remain the same, I mean we
>> will still assign Xen grant DMA ops from xen_setup_dma_ops() here?
> Yes I think so


Stefano, thank you for clarifying!


Regarding new naming scheme...

As there is an existing Kconfig option XEN_GRANT_DMA_ALLOC used for 
different purpose, we need to clarify naming scheme here a bit to avoid 
possible confusion.

For example, I am happy with proposed by Juergen ...

... Kconfig option: XEN_GRANT_DMA_OPS

and

... file: grant-dma-ops.c


-- 
Regards,

Oleksandr Tyshchenko

