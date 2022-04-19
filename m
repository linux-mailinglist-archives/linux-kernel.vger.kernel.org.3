Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA58507628
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244442AbiDSROw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238334AbiDSROi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:14:38 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8FA3B3FB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:11:17 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id c15so21346075ljr.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=rxPYmQa0Egn1mqp1mSydb9Om/nZ3dlYXqwZ9ZJ/h6io=;
        b=dyWdHQ6Lc1rlJ6pELKH/xYiaKPOXoQ/YcCodyE8U8e8bJBI77zlMVC+Ki6HcNSpIeZ
         hJhP6IRzUA4XCB0CBu49/DWNC2kDBRY6Pb2V4fXowbHziawlTEuj1pobxjq4/74XRzHZ
         P04N+J4pxJESMwwUZ/O2VvJMUiPQiB31BKyfGR5KU7rbwgKt2kpcI8QRn/jUpuEzNlQZ
         BF26p8IN65HWr/A4mTBhF0ZoyuOAyjgP2gt0p0gmutZfrzGiFS/zwsWUARmd/Tsv9Yab
         gn1QKQyQzIc/sGsGr4aW/kVp0yTL+K/d22SwqK1Urv8YmJlhqe2Ogkij7yMTxIpxpxDV
         wp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rxPYmQa0Egn1mqp1mSydb9Om/nZ3dlYXqwZ9ZJ/h6io=;
        b=IqbBuLphMTNYh6gteRQXC6GgRQUeRjFdce0W4ezLODm2X3105mrPIkdlzAU+CYMsoC
         lO4LasWD59pIjV8hxSw2Yh9VGztHPXg4+V6qc6Ubn2euTOS9cfSLzgu5S6863bmLL4KH
         U3jS42G6Pmo+mBL9kR28Tl7pgXLHC33gpb5hWb9D63YuywefpiWt383VlJfzZPRWFssG
         KAogifZ9aPmC49LjaFsdjk2qVCmmWYNErSCy8xtKmSNOTyfPvYibcHz9qlYUWCZaZVBt
         Cwc87QTthYJ072vJDd7yXD6zem6Q+opfdnfZ7FNFbKon0J93V9hojQnHnORxZJo7jw4M
         orWw==
X-Gm-Message-State: AOAM530y5OMFy4QMIqSPIB5MvAMIas+/Ac47sAR2+K5v0AdNFW706SAY
        UHt/kNEojNWiyZ2npBod9BA=
X-Google-Smtp-Source: ABdhPJwgqbLh/VuZRiEY2WTuxX7nyZVaNDxdTGSqSrhHfcljZTAensAc3R99HsPQkc5LdCgC/gCgEw==
X-Received: by 2002:a2e:9c43:0:b0:24b:469:2bb6 with SMTP id t3-20020a2e9c43000000b0024b04692bb6mr11327140ljj.248.1650388274392;
        Tue, 19 Apr 2022 10:11:14 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id s10-20020a19ad4a000000b0044826a25a2esm1559012lfd.292.2022.04.19.10.11.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 10:11:14 -0700 (PDT)
Subject: Re: [RFC PATCH 6/6] arm/xen: Assign xen-virtio DMA ops for virtio
 devices in Xen guests
To:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
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
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <5afb9e61-4164-9cc9-278a-911fc21f4f6c@gmail.com>
Date:   Tue, 19 Apr 2022 20:11:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b68163be-ad43-7773-22ff-e83191886626@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Stefano, Juergen


On 19.04.22 17:48, Juergen Gross wrote:
> On 19.04.22 14:17, Oleksandr wrote:
>>
>> Hello Stefano, Juergen
>>
>>
>> On 18.04.22 22:11, Stefano Stabellini wrote:
>>> On Mon, 18 Apr 2022, Oleksandr wrote:
>>>> On 16.04.22 09:07, Christoph Hellwig wrote:
>>>>
>>>> Hello Christoph
>>>>
>>>>> On Fri, Apr 15, 2022 at 03:02:45PM -0700, Stefano Stabellini wrote:
>>>>>> This makes sense overall. Considering that the swiotlb-xen case 
>>>>>> and the
>>>>>> virtio case are mutually exclusive, I would write it like this:
>>>>> Curious question:  Why can't the same grant scheme also be used for
>>>>> non-virtio devices?  I really hate having virtio hooks in the arch
>>>>> dma code.  Why can't Xen just say in DT/ACPI that grants can be used
>>>>> for a given device?
>>> [...]
>>>
>>>> This patch series tries to make things work with "virtio" devices 
>>>> in Xen
>>>> system without introducing any modifications to code under 
>>>> drivers/virtio.
>>>
>>> Actually, I think Christoph has a point.
>>>
>>> There is nothing inherently virtio specific in this patch series or in
>>> the "xen,dev-domid" device tree binding.
>>
>>
>> Although the main intention of this series was to enable using virtio 
>> devices in Xen guests, I agree that nothing in new DMA ops layer 
>> (xen-virtio.c) is virtio specific (at least at the moment). Regarding 
>> the whole patch series I am not quite sure, as it uses 
>> arch_has_restricted_virtio_memory_access(). >
>>>   Assuming a given device is
>>> emulated by a Xen backend, it could be used with grants as well.
>>>
>>> For instance, we could provide an emulated e1000 NIC with a
>>> "xen,dev-domid" property in device tree. Linux could use grants with it
>>> and the backend could map the grants. It would work the same way as
>>> virtio-net/block/etc. Passthrough devices wouldn't have the
>>> "xen,dev-domid" property, so no problems.
>>>
>>> So I think we could easily generalize this work and expand it to any
>>> device. We just need to hook on the "xen,dev-domid" device tree
>>> property.
>>>
>>> I think it is just a matter of:
>>> - remove the "virtio,mmio" check from xen_is_virtio_device
>>> - rename xen_is_virtio_device to something more generic, like
>>>    xen_is_grants_device
>
> xen_is_grants_dma_device, please. Normal Xen PV devices are covered by
> grants, too, and I'd like to avoid the confusion arising from this.


yes, this definitely makes sense as we need to distinguish


>
>
>>> - rename xen_virtio_setup_dma_ops to something more generic, like
>>>    xen_grants_setup_dma_ops
>>>
>>> And that's pretty much it.
>>
>> + likely renaming everything in that patch series not to mention 
>> virtio (mostly related to xen-virtio.c internals).
>>
>>
>> Stefano, thank you for clarifying Christoph's point.
>>
>> Well, I am not against going this direction. Could we please make a 
>> decision on this? @Juergen, what is your opinion?
>
> Yes, why not.


ok, thank you for confirming.


>
>
> Maybe rename xen-virtio.c to grant-dma.c?


Personally I don't mind.


>
> I'd keep the XEN_VIRTIO related config option, as this will be the 
> normal use
> case. grant-dma.c should be covered by a new hidden config option 
> XEN_GRANT_DMA
> selected by XEN_VIRTIO.


I got it, ok


>
>
> CONFIG_XEN_VIRTIO should still guard 
> xen_has_restricted_virtio_memory_access().


ok


So a few questions to clarify:

1. What is the best place to keep "xen,dev-domid" binding's description 
now? I think that proposed in current series place 
(Documentation/devicetree/bindings/virtio/) is not good fit now.

2. I assume the logic in the current patch will remain the same, I mean 
we will still assign Xen grant DMA ops from xen_setup_dma_ops() here?


>
>
>
> Juergen

-- 
Regards,

Oleksandr Tyshchenko

