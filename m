Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E30C506C1D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350010AbiDSMUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346541AbiDSMUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:20:11 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C66925E90
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:17:28 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x17so29033305lfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=c4jLu+nEjW6ZyZXVzGI5SDD7yHtnUvhBe/fmRqUVNIQ=;
        b=XHTyOUDABQ14gZmVv1k6ZT33I2aAbve42wB0HyHQxv7GIG6L7ZAKcuW2rGSxXu/ygr
         JnWzRmFHo9x1ZE21q1MdOXNxgM0G6U0dzM3232itmYKA3MVrjrU/MLuccHMgIGDrN3hH
         D3+yMStuFAvLXza9j2W/bcrz9OIx2WmpcXkiVEVsqxbasDR23Ydv/wFqPV9IL4cz2XuP
         +09gFQTuxn7+b56CTrbPi8/Pq6zYk0zHk6sQvCLKjT9J2p/G9SV4KjVtjs3cOMisAS2O
         mivwFNQc84cRhVQafMN71BdlBSk1jKUOclNnS4aoAd2n+l9UOg0Iyj5GA7Yfjtxo1el9
         KIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=c4jLu+nEjW6ZyZXVzGI5SDD7yHtnUvhBe/fmRqUVNIQ=;
        b=QxPfNAzNmRCAYugtqKdjd7c4Snza5l59BOviDKVKDvES1+EfJHGCGy3aMw6H9kAKkZ
         07Sirv0TGcRahV/6evrotQLsFDHj43RGCWCcoS4LuLIglvXMEr8904tYiDIP2WaZz5Rn
         0rgMZ6lWIFkyFPlZW45LgG3Z8hizeVCFGN+6sdwAKUEYxxsuWr6pczO575U1l2LkiI61
         Elwt5NFAqrc7g/P6rzfZWI5e6NDdl01aJhsml4/UyKHY6D5OENXLpyWJ6Jdjmr7EWz8w
         XuDl+AW8qcOEKmi6NXdstO1jSnf//Eg/Xh5fnXYPQ2+cZXkthJQp6W/oHOeFUHv9FTVU
         xong==
X-Gm-Message-State: AOAM531XOdE/k97Gn+9irNxeSUTZQiQX25icXZvuDti3YWR95zfdQ+la
        WvxqkBREb+sIx/h0yw7R69o=
X-Google-Smtp-Source: ABdhPJwkKAkPv72l8VLD2wXgvdqXMSxh5RJKyI64dvC+KXpqtAP43wJmw6LIPT1nv21iuUsXGSy77w==
X-Received: by 2002:a05:6512:c28:b0:471:9a7d:de9e with SMTP id z40-20020a0565120c2800b004719a7dde9emr5320943lfu.440.1650370646660;
        Tue, 19 Apr 2022 05:17:26 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id e15-20020a19500f000000b0046bb76678bcsm1497380lfb.131.2022.04.19.05.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 05:17:26 -0700 (PDT)
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
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <6a04cc34-fbb3-44d8-c1a4-03bda5b3deb1@gmail.com>
Date:   Tue, 19 Apr 2022 15:17:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2204181202080.915916@ubuntu-linux-20-04-desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 18.04.22 22:11, Stefano Stabellini wrote:
> On Mon, 18 Apr 2022, Oleksandr wrote:
>> On 16.04.22 09:07, Christoph Hellwig wrote:
>>
>> Hello Christoph
>>
>>> On Fri, Apr 15, 2022 at 03:02:45PM -0700, Stefano Stabellini wrote:
>>>> This makes sense overall. Considering that the swiotlb-xen case and the
>>>> virtio case are mutually exclusive, I would write it like this:
>>> Curious question:  Why can't the same grant scheme also be used for
>>> non-virtio devices?  I really hate having virtio hooks in the arch
>>> dma code.  Why can't Xen just say in DT/ACPI that grants can be used
>>> for a given device?
> [...]
>
>> This patch series tries to make things work with "virtio" devices in Xen
>> system without introducing any modifications to code under drivers/virtio.
>
> Actually, I think Christoph has a point.
>
> There is nothing inherently virtio specific in this patch series or in
> the "xen,dev-domid" device tree binding.


Although the main intention of this series was to enable using virtio 
devices in Xen guests, I agree that nothing in new DMA ops layer 
(xen-virtio.c) is virtio specific (at least at the moment). Regarding 
the whole patch series I am not quite sure, as it uses 
arch_has_restricted_virtio_memory_access().


>   Assuming a given device is
> emulated by a Xen backend, it could be used with grants as well.
>
> For instance, we could provide an emulated e1000 NIC with a
> "xen,dev-domid" property in device tree. Linux could use grants with it
> and the backend could map the grants. It would work the same way as
> virtio-net/block/etc. Passthrough devices wouldn't have the
> "xen,dev-domid" property, so no problems.
>
> So I think we could easily generalize this work and expand it to any
> device. We just need to hook on the "xen,dev-domid" device tree
> property.
>
> I think it is just a matter of:
> - remove the "virtio,mmio" check from xen_is_virtio_device
> - rename xen_is_virtio_device to something more generic, like
>    xen_is_grants_device
> - rename xen_virtio_setup_dma_ops to something more generic, like
>    xen_grants_setup_dma_ops
>
> And that's pretty much it.

+ likely renaming everything in that patch series not to mention virtio 
(mostly related to xen-virtio.c internals).


Stefano, thank you for clarifying Christoph's point.

Well, I am not against going this direction. Could we please make a 
decision on this? @Juergen, what is your opinion?



-- 
Regards,

Oleksandr Tyshchenko

