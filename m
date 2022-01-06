Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882374862AA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 11:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237763AbiAFKFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 05:05:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24858 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231360AbiAFKFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 05:05:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641463530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZquyDjMWtH6Elw5UE/jt48UgaPm40THs0oEdj0Vwssc=;
        b=RL5sNythHhq3toZ9JDh+Pu+ShA32MQWWGkyCQZ2FN9HIVoVsnggEUIqKdBWanFmydSgOzV
        /TL9Uwpt4//H9jM9SAzZ0neYFLZc//j8tkzKABR76P7P54zXIr8fn8tOuaQq+aTP3gPJtM
        eRSIXFuENpLpGTBQcmR/f7GAAqlE5Sg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-450-_HMeLBWKOWe6bSb-oJd2-w-1; Thu, 06 Jan 2022 05:05:29 -0500
X-MC-Unique: _HMeLBWKOWe6bSb-oJd2-w-1
Received: by mail-wr1-f70.google.com with SMTP id w2-20020adfbac2000000b001a540eeb812so346871wrg.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 02:05:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=ZquyDjMWtH6Elw5UE/jt48UgaPm40THs0oEdj0Vwssc=;
        b=L4/Srv7dwCr6AY6sHhi/UR2bpWN35e4t0XfnfUDk8ZWy4LHUlAtFBgKLJkqX9rbXyj
         EZOHdaZEFxHy3BqVNrzhT2+Ece3s9ijKMffavtoJX0AAb0SUI/PSYIUA44WlCZG4jIgM
         FoujGV4MTJ5F18fD2pEIBAonOsoHeumrcvSjqsQTkbICRIptx+3zIzAFDi1EZgVS/KJ2
         t0ZcynZzWchU3VnoHs45ymWQOojFoluTFm1QTqtiRZe7+eC+vrkJWQKfpIcMNOFqlC1y
         kIllDxIMcoYmMYLEF1sGCZkSnIb/MS46POmUm1OcGDfEXtOGEriZwYe3kTdc/3z2ynoC
         aD4g==
X-Gm-Message-State: AOAM531AbGgRni43NYWVTRufHchxE0EZdMAkff6CjZ8v57s1KoNaJSVE
        lwgbCtubBRC0Y3VyDj4RenPhXtMK6h+0WCYUtXhkoLOCUohclRJ3gEZfAMikUz/gG+JVxCn02j6
        e8jG62YAfz5XZvIs0RuAJkC7c
X-Received: by 2002:a05:6000:1807:: with SMTP id m7mr49931376wrh.191.1641463527919;
        Thu, 06 Jan 2022 02:05:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzv6lEQSqv1I2s2ToQnZUt16x8ql29+wEorqhqfkyZm/saq6lidksuzyFufB1UL+A+Fcqbwuw==
X-Received: by 2002:a05:6000:1807:: with SMTP id m7mr49931355wrh.191.1641463527588;
        Thu, 06 Jan 2022 02:05:27 -0800 (PST)
Received: from [192.168.3.132] (p5b0c699a.dip0.t-ipconnect.de. [91.12.105.154])
        by smtp.gmail.com with ESMTPSA id j3sm1619719wrt.14.2022.01.06.02.05.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 02:05:27 -0800 (PST)
Message-ID: <277b1085-d9a7-78d5-4997-3c0595f54460@redhat.com>
Date:   Thu, 6 Jan 2022 11:05:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wei Liu <wei.liu@kernel.org>
Cc:     linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
References: <20220105165028.1343706-1-vkuznets@redhat.com>
 <20220105202203.evk7uckmephnu3ev@liuwe-devbox-debian-v2>
 <87leztp7zk.fsf@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC] Drivers: hv: balloon: Temporary disable the driver on
 ARM64 when PAGE_SIZE != 4k
In-Reply-To: <87leztp7zk.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.01.22 09:46, Vitaly Kuznetsov wrote:
> Wei Liu <wei.liu@kernel.org> writes:
> 
>> On Wed, Jan 05, 2022 at 05:50:28PM +0100, Vitaly Kuznetsov wrote:
>>> Hyper-V ballooning and memory hotplug protocol always seems to assume
>>> 4k page size so all PFNs in the structures used for communication are
>>> 4k PFNs. In case a different page size is in use on the guest (e.g.
>>> 64k), things go terribly wrong all over:
>>> - When reporting statistics, post_status() reports them in guest pages
>>> and hypervisor sees very low memory usage.
>>> - When ballooning, guest reports back PFNs of the allocated pages but
>>> the hypervisor treats them as 4k PFNs.
>>> - When unballooning or memory hotplugging, PFNs coming from the host
>>> are 4k PFNs and they may not even be 64k aligned making it difficult
>>> to handle.
>>>
>>> While statistics and ballooning requests would be relatively easy to
>>> handle by converting between guest and hypervisor page sizes in the
>>> communication structures, handling unballooning and memory hotplug
>>> requests seem to be harder. In particular, when ballooning up
>>> alloc_balloon_pages() shatters huge pages so unballooning request can
>>> be handled for any part of it. It is not possible to shatter a 64k
>>> page into 4k pages so it's unclear how to handle unballooning for a
>>> sub-range if such request ever comes so we can't just report a 64k
>>> page as 16 separate 4k pages.
>>>
>>
>> How does virtio-balloon handle it? Does its protocol handle different
>> page sizes?
>>
> 
> Let's ask the expert)
> 
> David,
> 
> how does virtio-balloon (and virtio-mem) deal with different page sizes
> between guest and host?

virtio-mem is easy, virtio-balloon is more involved. virtio-balloon has
similarly a 4k granularity as part of the protocol.


1. virtio-mem:

It has a per-device block size determined by the device, usually around
1 MiB or bigger. virtio-mem usually uses the THP size (e.g., 2 MiB on
x86_64) unless larger huge pages are used for backing device memory in
the hypervisor. So the actual base page size doesn't play any role.

Resizing is triggered by a resize request towards the guest, and it's
always up to the guest to select device blocks to (un)plug.

E.g., plugged_size: 200 MiB, requested_size: 300 MiB -> guest is
requested to plug 100 MiB (select unplugged device blocks and request to
plug them)

E.g., plugged_size: 300 MiB, requested_size: 200 MiB -> guest is
requested to unplug 100 MiB (select plugged device blocks and request to
unplug them)


1.1 host granularity < guest granularity

Assume the device supports 2MiB and the guest 4 MiB, which is the case
on current x86_64, The guest will simply (un)plug in 4 MiB granularity,
logically mapping to two 2MiB device blocks. Requests not aligned to
4MiB cannot be fully processed.


1.2 guest granularity < host granularity

Assume the device supports 2 MiB and the guest 1 MiB. The guest will
simply (un)plug in 2 MiB granularity.



2. virtio-balloon

It's based on 4k pages.

Inflation/deflation is triggered by a balloon size change request. It's
always up to the guest to select pages to inflate/deflate

E.g., current_size: 200 MiB, target_size: 300 MiB -> guest is requested
to inflate the balloon by 100 MiB (select deflated pages and request to
inflate them)

E.g., current_size: 300 MiB, target_size: 200 MiB -> guest is requested
to deflate 100 MiB (select inflated pages and request to deflate them)

2.1 guest granularity > 4k:

Assume the guest has a page size of 16K. Inflation/deflation requests
not aligned to 16K cannot be fully processed. Otherwise, the guest
simply inflates/defaltes 16k pages by logically inflating/deflating 4
consecutive 4k pages. It's worth noting that inflation/deflation
requests of 4k pages cannot be rejected by the host.

VIRTIO_BALLOON_PAGES_PER_PAGE expresses exactly that. set_page_pfns()
simply iterates over VIRTIO_BALLOON_PAGES_PER_PAGE "4k sub-pages"

2.2 host granularity > 4k:

Assume the host has a page size of 16K. From a guest POV we don't care
and we don't know and will just operate on 4k pages. In the hypervisor
it's problematic, though: if the guest inflated a 4k page, we cannot
easily free up a 16k page. We'd have to track the state of each and
every individual page, which is undesirable: once the complete 16k page
would be inflated, we could free it. QEMU only tracks this for
consecutive inflation requests, which sometimes works.



Long story short, IIRC all the details about the HV balloon, the real
issue is that while the guest is in charge of selecting pages to
inflate, it's the *hypervisor* that selects pages to deflate, which
makes it impossible to handle 2.1 in a similar way to virtio-balloon.
The hypervisor would have to know about the guest granularity in order
to not request to deflate, say, 4k pages, but 16k pages. Devil might be
in the detail.

-- 
Thanks,

David / dhildenb

