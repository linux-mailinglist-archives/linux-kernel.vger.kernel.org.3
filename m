Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E11587D68
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 15:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbiHBNsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 09:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbiHBNsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 09:48:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B920E1DA79
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 06:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659448110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OrwE3Ag22dL3OQ2ksEp1YwraLinA6Mssgv+fkDSYVVA=;
        b=e1U0xpB1dZv8LxjSHyZzuw3oBphow7sG6otpOWgyF31GqwnLbpQ1T3UzI//FIb9VRMCI01
        1MhIfrXVZLxfTfy6BxvgBe31F4MuOjiFjfEaAAfyb6f0Cnxy6nrBa8JztGQVzcdQVgQAfD
        LiNhqVhbpnL8lsFQ9P5KpzOVVV0wCzk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-381-XO8-lj8WNx6rNrxQqP0Rqw-1; Tue, 02 Aug 2022 09:48:29 -0400
X-MC-Unique: XO8-lj8WNx6rNrxQqP0Rqw-1
Received: by mail-wr1-f71.google.com with SMTP id x5-20020adfbb45000000b0021ee56506dfso3578311wrg.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 06:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=OrwE3Ag22dL3OQ2ksEp1YwraLinA6Mssgv+fkDSYVVA=;
        b=6zqoba24UZiaAvwfJRcVAIJ7lPeUkBEqR1cenFPrBm+h+c41B4PhYix9tS/4eVaM8p
         xEDkPJc95vQ6+uXZ4pNXGzyQzuZ8ZacTtY6iUFKVLfGzF30SonD5xtpi05dmG+/mb835
         wQpypuLknerqbyGC3pxSyTVDO0CDSAshkmJs9IJanWJpqU+p0T8TIVr36fEhs7XDJWje
         m7+7JAAEkLmir7ofmoAXceA/Gs/ssDTMUXeGT45HazFo8ebRjXLU2mBmPHmcj3bKmEqK
         p01eDFXUZOOkEWAa4tKnA5vjD1RKtZWDsGkMvgbCdPtoT/SZcS3ZljvaTowoCYLUSXhc
         EU4g==
X-Gm-Message-State: AJIora8zcOZQaungdlCtZgZoyM0J1a/Ri1qgx81UpZy0taU/uFHu0kpm
        Thcneo3JgYBnsZfB0HN3r2aMJqtkQ689+Ht2wdV9Q4igT7uTre5YPTFhY6OLa8JZtBqtnJkKP3b
        ZMr+AY78j85Db5XKqVv5eqrdk
X-Received: by 2002:a1c:f710:0:b0:394:1960:e8a1 with SMTP id v16-20020a1cf710000000b003941960e8a1mr14360940wmh.154.1659448108425;
        Tue, 02 Aug 2022 06:48:28 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v9Dgd3H45ZrMwAMcmmB5W4HzBAT4j3DZORAVdakwAplU9KXQO2uIkeIGZbm3F6/tcCZdIByg==
X-Received: by 2002:a1c:f710:0:b0:394:1960:e8a1 with SMTP id v16-20020a1cf710000000b003941960e8a1mr14360915wmh.154.1659448108091;
        Tue, 02 Aug 2022 06:48:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:3800:8435:659e:f80:9b3d? (p200300cbc70738008435659e0f809b3d.dip0.t-ipconnect.de. [2003:cb:c707:3800:8435:659e:f80:9b3d])
        by smtp.gmail.com with ESMTPSA id h3-20020a5d4fc3000000b0021eba590ad1sm17427218wrw.90.2022.08.02.06.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 06:48:27 -0700 (PDT)
Message-ID: <f0f12c84-a62e-5f8b-46ab-a651fe8f8589@redhat.com>
Date:   Tue, 2 Aug 2022 15:48:26 +0200
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC] how the ballooned memory should be accounted by the drivers
 inside the guests? (was:[PATCH v6 1/2] Create debugfs file with virtio
 balloon usage information)
In-Reply-To: <2dfad5c8-59d2-69a1-cc4c-d530c12ceea9@virtuozzo.com>
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

>>
>> In case of Hyper-V I remember a customer BUG report that requested that
>> exact behavior, however, I'm not able to locate the BZ quickly.
>> [1] https://lists.linuxfoundation.org/pipermail/virtualization/2021-November/057767.html
>> (note that I can't easily find the original mail in the archives)
> 
> VMWare does not, Xen do, HV do (but it didn't) - Virtio does both.
> 
> For me the confusion comes from mixing ballooning and hot plug.

For example, QEMU (and even libvirt) doesn't even have built in support
for any kind of automatic balloon resizing on guest memory pressure (and
I'm happy that we don't implement any such heuristics). As a user/admin,
all you can do is manually adjust the logical VM size by requesting to
inflate/deflate the balloon. For virtio-balloon, we cannot derive what
the hypervisor/admin might or might not do -- and whether the admin
intends to use memory ballooning for memory hotunplug or for optimizing
memory overcommit.

As another example, HV dynamic memory actually combines memory hotplug
with memory ballooning: use memory hotplug to add more memory on demand
and use memory ballooning to logically unplug memory again.

The VMWare balloon is a bit special, because it actually usually
implements deflate-on-oom semantics in the hypervisor. IIRC, the
hypervisor will actually adjust the balloon size based on guest memory
stats, and there isn't really an interface to manually set the balloon
size for an admin. But I might be wrong regarding the latter.

> 
> Ballooning is like a heap inside the guest from which the host can 
> allocate/deallocate pages, if there is a mechanism for the guest to ask 
> the host for more/to free/ pages or the host have a heuristic to monitor 
> the guest and inflate/deflate the guest it is a matter of implementation.

Please don't assume that the use case for memory ballooning is only
optimizing memory overcommit in the hypervisor under memory pressure.

> 
> Hot plug is adding  to MemTotal and it is not a random event either in 
> real or virtual environment -  so you can act upon it. MemTotal  goes 
> down on hot unplug and if pages get marked as faulty RAM.

"not a random event either" -- sure, with ppc dlpar, xen balloon, hv
balloon or virtio-mem ... which all are able to hotplug memory fairly
randomly based on hypervisor decisions.

In physical environments, it's not really a random event, I agree.

> 
> Historically MemTotal is a stable value ( i agree with most of David 
> Stevens points) and user space is expecting it to be stable , 
> initialized at startup and it does not expect it to change.

Just like some apps are not prepared for memory hot(un)plug. Some apps
just don't work in environments with variable physical memory sizes:
examples include databases, where memory ballooning might essentially be
completely useless (there is a paper about application-aware memory
ballooning for that exact use case).

> 
> Used is what changes and that is what user space expects to change.
> 
> Delfate on oom might have been a mistake but it is there and if anything 
> depends on changing MemTotal  it will be broken by that option.  How 
> that can be fixed?

I didn't quite get your concern here. Deflate-on-oom in virtio-balloon
won't adjust MemTotal, so under which condition would be something broken?

> 
> I agree that the host can not reclaim what is marked as used  but should 
> it be able to ? May be it will be good to teach oom killer that there 
> can be such ram that can not be reclaimed.
> 
>> Note: I suggested under [1] to expose inflated pages via /proc/meminfo
>> directly. We could do that consistently over all balloon drivers ...
>> doesn't sound too crazy.
> 
> Initally i wanted to do exactly this BUT:
> - some drivers prefer to expose some more internal information in the file.

They always can have an extended debugfs interface in addition.

> - a lot of user space is using meminfo so better keep it as is to avoid breaking something, ballooning is not very frequently used.

We can always extend. Just recently, we exposed Zswap data:

commit f6498b776d280b30a4614d8261840961e993c2c8
Author: Johannes Weiner <hannes@cmpxchg.org>
Date:   Thu May 19 14:08:53 2022 -0700

    mm: zswap: add basic meminfo and vmstat coverage


Exposing information about inflated pages in a generic way doesn't sound
completely wrong to me, but there might be people that object.

> 
> 
> Please, share your view on how the ballooned memory should be accounted by the drivers inside the guests so we can work towards consistent behaviour:
> 
> Should the inflated memory be accounted as Used or MemTotal be adjusted?

I hope I was able to make it clear that it completely depends on how
memory ballooning is actually intended to be used. It's not uncommon to
use it as form of fake memory hotunplug, where that memory is actually
gone for good and won't simply come back when under memory pressure.

> 
> Should the inflated memory be added to /proc/meminfo ?

My gut feeling is yes. The interesting question remains, how to
distinguish the two use cases (inflated memory subtracted from MemTotal
or subtracted from MemFree).

I'm not sure if we even want to unify balloon handling reagrding
adjusting managed pages. IMHO, there are good reasons to do it either way.

-- 
Thanks,

David / dhildenb

