Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B868358D710
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 12:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240874AbiHIKDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 06:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240472AbiHIKDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 06:03:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 255C223BD3
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 03:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660039427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z4S7sEwRZF/s5fONnXF+oN53vWEng4sMiupLFnh9W74=;
        b=ZGbmmIjNl+kpAQtl1sKqsM3mIyGpSojCDOSc1A58LEYZY+Q1tMMLrfg3a27XNRdnUw6vcN
        Qh3J8KFFBxs7cH0bYi8k+3EjTkEYbg2MqlH+3pMKfMwBkvSszijvJeGKnTDFO59RX0osxL
        s4uLgx9N3E9LYWwiRIAI6+Kj36odc1U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-407-4OaEIRT_MriHmwTrAjQhcQ-1; Tue, 09 Aug 2022 06:03:46 -0400
X-MC-Unique: 4OaEIRT_MriHmwTrAjQhcQ-1
Received: by mail-wr1-f71.google.com with SMTP id t12-20020adfa2cc000000b0021e564cde06so1765186wra.17
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 03:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=z4S7sEwRZF/s5fONnXF+oN53vWEng4sMiupLFnh9W74=;
        b=OBssZeBABtTe9jgG7/W0+KNe9nF4RabHmca2J8Sq4Tsu5hrpnL0MoXPQEFEh44JRbQ
         +TQ1O5olPfaVK7yFuF8hTC9ptHtFncIPyd9m5rVN+hEL1WaHfDkG2Sb5EDcEbb1z5yVm
         QRmpYUz6V5t4ZF+9nW9rofOBh9ESN/RJcnHS8KTPFTEmRdvjdmEEg4nh6TPJ8fwWsN1i
         tYzpSCW1qHJTJv47WxXxLPhL7lifCKvZuANuKUqkmWRrlDlT1JBFa89/m8U32gHFyhMC
         SDeEleCk6zzuKjtu7iwSVUdZbUOQHzn177w2NpmnyKr8c4AYYpF/BmL/tldJOanh76pR
         UCSQ==
X-Gm-Message-State: ACgBeo2+EgKh4zoVGWXRWDYfd9F7sD4tn26UFBFyjQYh3r84H5s1JA3C
        5jfwmiF8z/pzB7oOdJqOueV0IwAZFPPjbDIyU0btIKMFP2nbXm3guBXxQavYmrM8XY5Pgui77SP
        Lj2Ums2474LewN7GiF7LVoyNI
X-Received: by 2002:adf:eb4c:0:b0:220:6aaf:ef5e with SMTP id u12-20020adfeb4c000000b002206aafef5emr13314861wrn.488.1660039424622;
        Tue, 09 Aug 2022 03:03:44 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7y5+8/fEMwrlzoSfhLcMgqH5R7lIz5Q92iaf/1I0YI3oGEeG6j/+HbyhSs4Xw/986oaQT4yA==
X-Received: by 2002:adf:eb4c:0:b0:220:6aaf:ef5e with SMTP id u12-20020adfeb4c000000b002206aafef5emr13314830wrn.488.1660039424232;
        Tue, 09 Aug 2022 03:03:44 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f15:c300:d2ce:1fb5:2460:179a? (p200300d82f15c300d2ce1fb52460179a.dip0.t-ipconnect.de. [2003:d8:2f15:c300:d2ce:1fb5:2460:179a])
        by smtp.gmail.com with ESMTPSA id o24-20020a05600c511800b003a54f49c1c8sm3730714wms.12.2022.08.09.03.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 03:03:43 -0700 (PDT)
Message-ID: <bb015ee3-06ea-e589-7748-2fd9d589d685@redhat.com>
Date:   Tue, 9 Aug 2022 12:03:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     kernel@openvz.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, stevensd@chromium.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Nadav Amit <namit@vmware.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <55016ed9-7b3c-c4eb-f5f4-02cfce2191e4@redhat.com>
 <20220726140831.72816-1-alexander.atanasov@virtuozzo.com>
 <2d0703da-ae89-7002-f500-300a4b5d206b@redhat.com>
 <3a5e60e8-a0d2-a1f1-28e9-e0b45069029a@virtuozzo.com>
 <71e73194-1683-b65f-7b84-c0c719010aef@redhat.com>
 <2dfad5c8-59d2-69a1-cc4c-d530c12ceea9@virtuozzo.com>
 <f0f12c84-a62e-5f8b-46ab-a651fe8f8589@redhat.com>
 <7bfac48d-2e50-641b-6523-662ea4df0240@virtuozzo.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC] how the ballooned memory should be accounted by the drivers
 inside the guests? (was:[PATCH v6 1/2] Create debugfs file with virtio
 balloon usage information)
In-Reply-To: <7bfac48d-2e50-641b-6523-662ea4df0240@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.08.22 11:36, Alexander Atanasov wrote:
> Hello,
> 
> On 2.08.22 16:48, David Hildenbrand wrote:
>>>>
>>>> In case of Hyper-V I remember a customer BUG report that requested that
>>>> exact behavior, however, I'm not able to locate the BZ quickly.
>>>> [1] https://lists.linuxfoundation.org/pipermail/virtualization/2021-November/057767.html
>>>> (note that I can't easily find the original mail in the archives)
>>>
>>> VMWare does not, Xen do, HV do (but it didn't) - Virtio does both.
>>>
>>> For me the confusion comes from mixing ballooning and hot plug.
>>
>> For example, QEMU (and even libvirt) doesn't even have built in support
>> for any kind of automatic balloon resizing on guest memory pressure (and
>> I'm happy that we don't implement any such heuristics). As a user/admin,
>> all you can do is manually adjust the logical VM size by requesting to
>> inflate/deflate the balloon. For virtio-balloon, we cannot derive what
>> the hypervisor/admin might or might not do -- and whether the admin
>> intends to use memory ballooning for memory hotunplug or for optimizing > memory overcommit.
> 
> Is the lack of proper hotplug/unplug leading the admins to use it like 
> this?

Yes. Especially unplug is tricky and hard to get working reliably in
practice because of unmovable pages. Ballooning is an easy hack to get
unplug somewhat working.

For reference: under Windows ballooning was (and maybe still mostly is)
the only way to unplug memory again. Unplug of DIMMs is not supported.

> I really don't understand why you don't like automatic resizing - 
> both HyperV and VMWare do it ?

You need heuristics to guess what the guest might be doing next and
deflate fast enough to avoid any kind of OOMs in the guest. I pretty
much dislike that concept, because it just screams to be fragile.

In short: I don't like ballooning, to me it's a technology from ancient
times before we were able to do any better. In comparison, I do like
free page reporting for optimizing memory overcommit, but it still has
some drawbacks (caches consuming too much memory), that people are
working on to improve. So we're stuck with ballooning for now for some
use cases.

Personally, I consider any balloon extensions (inflate/deflate, not
things like free page reporting) a waste of time and effort, but that's
just my humble opinion. So I keep reviewing and maintaining them ;)

> 
>> As another example, HV dynamic memory actually combines memory hotplug
>> with memory ballooning: use memory hotplug to add more memory on demand
>> and use memory ballooning to logically unplug memory again.
> 
> Have both as an options - min/max memory , percentage free to keep as 
> minimum, fixed size and have hot add - kind of hot plug to go above 
> initial max - tries to manage it in dynamic way.
> 
>> The VMWare balloon is a bit special, because it actually usually
>> implements deflate-on-oom semantics in the hypervisor. IIRC, the
>> hypervisor will actually adjust the balloon size based on guest memory
>> stats, and there isn't really an interface to manually set the balloon
>> size for an admin. But I might be wrong regarding the latter.
> 
> For me this is what makes sense - you have a limited amount of
> physical RAM that you want to be used optimally by the guests.
> Waiting for the admin to adjust the balloon would not give very
> optimal results.

Exactly. For the use case of optimizing memory overcommit in the
hypervisor, you want deflate-on-oom semantics if you go with balloon
inflation/deflation.

> 
>>
>>>
>>> Ballooning is like a heap inside the guest from which the host can
>>> allocate/deallocate pages, if there is a mechanism for the guest to ask
>>> the host for more/to free/ pages or the host have a heuristic to monitor
>>> the guest and inflate/deflate the guest it is a matter of implementation.
>>
>> Please don't assume that the use case for memory ballooning is only
>> optimizing memory overcommit in the hypervisor under memory pressure.
> 
> I understood that - currently it is used and as a way to do 
> hotplug/unplug. The question is if that is the right way to use it.

People use it like that, and we have no control over that. I've heard of
people using hotplug of DIMMs to increase VM memory and balloon
inflation to hotunplug memory, to decrease VM memory.

> 
>>>
>>> Hot plug is adding  to MemTotal and it is not a random event either in
>>> real or virtual environment -  so you can act upon it. MemTotal  goes
>>> down on hot unplug and if pages get marked as faulty RAM.
>>
>> "not a random event either" -- sure, with ppc dlpar, xen balloon, hv
>> balloon or virtio-mem ... which all are able to hotplug memory fairly
>> randomly based on hypervisor decisions.
>>
>> In physical environments, it's not really a random event, I agree.
> 
> Even if it is not manual - if they do hotplug it is ok - you can track 
> hotplug events. But you can not track balloon events.

I was already asking myself in the past if there should be notifiers
when we inflate/deflate -- when we adjust MemTotal essentially. But I
think there is a more fundamental problem: some things are just
incompatible to any of that.

> 
>>
>>>
>>> Historically MemTotal is a stable value ( i agree with most of David
>>> Stevens points) and user space is expecting it to be stable ,
>>> initialized at startup and it does not expect it to change.
>>
>> Just like some apps are not prepared for memory hot(un)plug. Some apps
>> just don't work in environments with variable physical memory sizes:
>> examples include databases, where memory ballooning might essentially be
>> completely useless (there is a paper about application-aware memory > ballooning for that exact use case).
> 
> I would say that even the kernel is not prepared to work with changing
> MemTotal - there are caches that are sized according to it -
> While with hotplug there is a notifier and who is interested can use it.
> With balloon inflate/deflate there is no way to do so , implementing
> a clone of hotplug_memory_notifier doesn't sound right for me.

Again, it completely depends on the use case.

As a reference, we used to adjust MemTotal ever since virtio-balloon was
introduce in the kernel (2003 !), which was almost 20 (!) years ago. I
am not aware of many (any) complains. It's just what people actually do
expect. Changing that suddenly is not ok.

> 
> Same for the userspace - on a hotplug/unplug event you can restart your 
> database or any other process sensitive to the value of MemTotal.

IMHO databases and any form of MemTotal changes are incomaptible,
because databases are simply extreme memhogs.

> 
>>>
>>> Used is what changes and that is what user space expects to change.
>>>
>>> Delfate on oom might have been a mistake but it is there and if anything
>>> depends on changing MemTotal  it will be broken by that option.  How
>>> that can be fixed?
>>
>> I didn't quite get your concern here. Deflate-on-oom in virtio-balloon > won't adjust MemTotal, so under which condition would be something 
> broken?
> 
> I mean the two ways of accounting - if a process depends on either
> used or total to change it will break depending on the option .

... and I would argue that such applications are not designed for
physical memory changes in any form. And not even for running
concurrently with other applications.

Yes, they might be compatible with deflate-on-oom.

[...]

>> Exposing information about inflated pages in a generic way doesn't sound
>> completely wrong to me, but there might be people that object.
>>
> 
> Patch for /proc/meminfo coming next.

Good!

> 
>>>
>>>
>>> Please, share your view on how the ballooned memory should be accounted by the drivers inside the guests so we can work towards consistent behaviour:
>>>
>>> Should the inflated memory be accounted as Used or MemTotal be adjusted?
>>
>> I hope I was able to make it clear that it completely depends on how
>> memory ballooning is actually intended to be used. It's not uncommon to
>> use it as form of fake memory hotunplug, where that memory is actually
>> gone for good and won't simply come back when under memory pressure.
>>
>>>
>>> Should the inflated memory be added to /proc/meminfo ?
>>
>> My gut feeling is yes. The interesting question remains, how to
>> distinguish the two use cases (inflated memory subtracted from MemTotal > or subtracted from MemFree).
> 
> There are currently two options:
> =========== RAM ===================|
>          |_Used Marker              |_ Total Marker
> 
> You either move Used marker or move Total to adjust.
> For simplicity sign bit can be used. If an other way appears
> the bit next to the sign bit can be used.
> 
>>
>> I'm not sure if we even want to unify balloon handling reagrding
>> adjusting managed pages. IMHO, there are good reasons to do it either way.
> 
> I think there is a need of clear rules based on what is correct and what 
> not. It seems that currently every hypervisor/driver is going the easy 
> way with hot plug/hot unplug vs inflate/deflate vs hot-add/hot-remove.
> Now if i try to make my app "smart" about memory pressure i need to know 
> way too much about each current and future hypervisor.

Yeah, I raised in the past that, for example for virtio-balloon, we'd
need information (e.g., feature flag) from the hypervisor what it is
actually going to do: whether it implements some form of deflate-on-oom
such that you can allocate huge portions of memory and immediately get
that memory freed up instead of running into OOMs and triggering
application/kernel crashes.

-- 
Thanks,

David / dhildenb

