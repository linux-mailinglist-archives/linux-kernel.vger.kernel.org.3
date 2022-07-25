Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CB157FE76
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 13:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbiGYLhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 07:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiGYLhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 07:37:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23E479FCE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 04:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658749019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t3DEzKG6tvVsHWaP5dFq4DXrdAEnDuBtMJb3V6pCFU0=;
        b=OyXFB3MqSimMqrNbaQ2ZNuj2RgUDMe5yz6NswOPeUOg/nwThe1/8vbicj2qTOHVT8J4Jiy
        X2DhQ9Qk5UwLGlIWKhUPnYhVN5SbDk2UgS780VBqHyQH555PA5FAFi1qSuQ8+nyJRrfvHb
        NzlGOCdnRl3A7IXEa3fbgcTqiq/Ovic=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169-8vqUuMFpNUCKFNcioQqc1w-1; Mon, 25 Jul 2022 07:36:58 -0400
X-MC-Unique: 8vqUuMFpNUCKFNcioQqc1w-1
Received: by mail-wm1-f71.google.com with SMTP id r82-20020a1c4455000000b003a300020352so6046767wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 04:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=t3DEzKG6tvVsHWaP5dFq4DXrdAEnDuBtMJb3V6pCFU0=;
        b=km9wMDoYG6KHN+x4D6fXbskh741pq3KXjAQGrvwGcQjWYTOrA1VmruG1hAnO81OBjS
         xmuQC7BQPKpJdCAjfPIP4Ce4OG5z0VuabdW0nHd3gwnxUZy172j3wcigEVgaf/CZ+mh3
         DItu6H5/n4EI58vmIx9dctZUVdF2xzJ5XonfXqYGHsd2C6726PG2XucVpTE4vv8+hOA3
         PlnOQ9iVwXQ4XEQ8qqov3GZSk909/giRrYIXhAu/aWx4lz/i9wbS3Vq5WrtvDZSMGw0i
         bUvLK/mzdG9MbLeG8CVtgqNBAmOOr75NTm55t/bG0ClXYRMLdgocS68UQjUhUOB0AIPl
         zxrQ==
X-Gm-Message-State: AJIora9AV4J42S2gL9vaxmWMeHhJMYKEmR3/Shea37qhb9mlx7aR+fx2
        1OEdcFhetKP9VCM9etFx3nLctOX8TbBbzKL1Jm3yoJAwxtZyhcZjEucr0hEki3ok6IwETJs6F0s
        Bs2eb1j9PwgkMVi4wdGBAnMyu
X-Received: by 2002:a05:600c:1993:b0:3a3:3eb0:9102 with SMTP id t19-20020a05600c199300b003a33eb09102mr11540523wmq.72.1658749016788;
        Mon, 25 Jul 2022 04:36:56 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vL9EjkwMZINzUqlk5EeL4tBf44YYFF4pa31k6djksa8I6JbHuBxCEjg70v7EZ4h3lsCoHonQ==
X-Received: by 2002:a05:600c:1993:b0:3a3:3eb0:9102 with SMTP id t19-20020a05600c199300b003a33eb09102mr11540508wmq.72.1658749016489;
        Mon, 25 Jul 2022 04:36:56 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:8c00:eee4:63f0:cef2:5ac0? (p200300cbc7048c00eee463f0cef25ac0.dip0.t-ipconnect.de. [2003:cb:c704:8c00:eee4:63f0:cef2:5ac0])
        by smtp.gmail.com with ESMTPSA id i24-20020a1c5418000000b003a3187a2d4csm17892774wmb.22.2022.07.25.04.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 04:36:56 -0700 (PDT)
Message-ID: <55016ed9-7b3c-c4eb-f5f4-02cfce2191e4@redhat.com>
Date:   Mon, 25 Jul 2022 13:36:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 1/1] Create debugfs file with virtio balloon usage
 information
Content-Language: en-US
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     kernel@openvz.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <7fd5e645-3892-6e0d-de80-08728e29b150@redhat.com>
 <20220714132053.56323-1-alexander.atanasov@virtuozzo.com>
 <0b660226-28dc-1f1d-e22e-34805dc5b25d@redhat.com>
 <865e4da3-94fe-95dc-cbe3-161fa8c2146d@virtuozzo.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <865e4da3-94fe-95dc-cbe3-161fa8c2146d@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.07.22 13:27, Alexander Atanasov wrote:
> Hi,
> 
> On 18/07/2022 14:35, David Hildenbrand wrote:
>> On 14.07.22 15:20, Alexander Atanasov wrote:
>>> Allow the guest to know how much it is ballooned by the host.
>>> It is useful when debugging out of memory conditions.
>>>
>>> When host gets back memory from the guest it is accounted
>>> as used memory in the guest but the guest have no way to know
>>> how much it is actually ballooned.
>>>
>>> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
>>> ---
>>>   drivers/virtio/virtio_balloon.c     | 79 +++++++++++++++++++++++++++++
>>>   include/uapi/linux/virtio_balloon.h |  1 +
>>>   2 files changed, 80 insertions(+)
>>>
>>> V2:
>>>   - fixed coding style
>>>   - removed pretty print
>>> V3:
>>>   - removed dublicate of features
>>>   - comment about balooned_pages more clear
>>>   - convert host pages to balloon pages
>>> V4:
>>>   - added a define for BALLOON_PAGE_SIZE to make things clear
>>> V5:
>>>   - Made the calculatons work properly for both ways of memory accounting
>>>     with or without deflate_on_oom
>>>   - dropped comment
>>>
> [....]
>>> +	u32 num_pages, total_pages, current_pages;
>>> +	struct sysinfo i;
>>> +
>>> +	si_meminfo(&i);
>>> +
>>> +	seq_printf(f, "%-22s: %d\n", "page_size", VIRTIO_BALLOON_PAGE_SIZE);
>> Why? Either export all in ordinary page size or in kB. No need to
>> over-complicate the interface with a different page size that users
>> don't actually care about.
>>
>> I'd just stick to /proc/meminfo and use kB.
> 
> The point is to expose some internal balloon data. Balloon works with 
> pages not with kB  and users can easily calculate kB.

Pages translate to KB. kB are easy to consume by humans instead of pages
with variable apge sizes

> 
>>> +
>>> +	seq_printf(f, "%-22s: %u\n", "ballooned_pages", num_pages);
>>> +
>>> +	if (virtio_has_feature(b->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM)) {
>>> +		total_pages = guest_to_balloon_pages(i.totalram);
>>> +		current_pages = guest_to_balloon_pages(i.totalram) - num_pages;
>>> +	} else {
>>> +		total_pages = guest_to_balloon_pages(i.totalram) +  num_pages;
>>> +		current_pages = guest_to_balloon_pages(i.totalram);
>>> +	}
>>> +
>>> +	/* Total Memory for the guest from host */
>>> +	seq_printf(f, "%-22s: %u\n", "total_pages", total_pages);
>>> +
>>> +	/* Current memory for the guest */
>>> +	seq_printf(f, "%-22s: %u\n", "current_pages", current_pages);
>> The think I detest about that interface (total/current) is that it's
>> simply not correct -- because i.totalram for example doesn't include
>> things like (similar to MemTotal in /proc/meminfo)
>>
>> a) crashkernel
>> b) early boot allocations (e.g., memmap)
>> c) any kind of possible memory (un)hotplug in the future
>>
>> I'd really suggest to just KIS and not mess with i.totalram.
>>
>> Exposing how much memory is inflated and some way to identify how that
>> memory is accounted in /proc/meminfo should be good enough.
>>
>> E.g., the output here could simply be
>>
>> "Inflated: 1024 kB"
>> "MemTotalReduced: 1024 kB"
>>
>> That would even allow in the future for flexibility when it comes to how
>> much/what was actually subtracted from MemTotal.
> 
> 
> The point of the debug interface is to expose some of the balloon driver 
> internals to the guest.
> 
> The users of this are user space processes that try to work according to 
> the memory pressure and nested virtualization.
> 
> I haven't seen one userspace software that expects total ram to change, 
> it should be constant with one exception hotplug. But if you do  hotplug 
> RAM you know that and you can restart what you need to restart.
> 
> So instead of messing with totalram with adding or removing pages /it 
> would even be optimization since now it is done page by page/ i suggest 
> to just account the inflated memory as used as in the deflate_on_oom 
> case now. It is confusing and inconsistent as it is now. How to  explain 
> to a vps user why his RAM is constantly changing?
> 
> And the file can go just to
> 
> inflated: <pages>
> 
> ballon_page_size:  4096
> 
> or
> 
> inflated: kB
> 
> I prefer pages because on theory guest and host can different size and 
> if at some point guest starts to make requests to the host for pages it 
> must somehow know what the host/balloon page is. Since you have all the 
> information at one place it is easy to calculate kB. But you can not 
> calculate pages from only kB.

The host can only inflate in guest-page base sizes. How that translates
to host-page base sizes is absolutely irrelevant.

Who should care about pages? Absolutely irrelevant.

Guest pages: kB / getpagesize()
Logical balloon pages: kB / 4k
Host pages: ???

> 
> Later on when hotplug comes it can add it's own data to the file so it 
> can be used to see the amount that is added to the total ram.
> 
> It can add
> 
> hotplugged: <pages>
> 
> 
> What do you think?

Let's keep this interface simple, please.

-- 
Thanks,

David / dhildenb

