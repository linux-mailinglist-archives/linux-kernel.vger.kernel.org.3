Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13F846A54C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 20:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348166AbhLFTFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 14:05:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59090 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348199AbhLFTFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 14:05:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638817298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7IWUJMUWQMHUT4vP/gLfw34vbVD3xfR2eTEDAHfsLnA=;
        b=CxkIGJCwVTYJToN9e+jnqEkvEstOmvS9E7/6OOMT5L87IHaLTcDKun3t+w3hsygsErPj5V
        lywI1vYq03nnCpGDm/ebj+S1pRlmJjTjaz2k9fXGaMS2AueX/437U5+DNgG1VhqolxMe1i
        ufdHBwd2vliet4RUEDEamk+0rrBZ5No=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-GgAccjx9N--Z0lj-zrTAZg-1; Mon, 06 Dec 2021 14:01:37 -0500
X-MC-Unique: GgAccjx9N--Z0lj-zrTAZg-1
Received: by mail-wm1-f71.google.com with SMTP id j25-20020a05600c1c1900b00332372c252dso316282wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 11:01:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=7IWUJMUWQMHUT4vP/gLfw34vbVD3xfR2eTEDAHfsLnA=;
        b=GpcV4UdR4Lailfypf62LMz2YE/4U1Bu0VJguJmtOrCAf1hLov9Rwz3mwdNtfxkkusm
         6EwzY4o3ERs3pO6cxiVg9b+owVgBpLvuu2H6Dnoj4x52eEBgNWwd2zje/ezvUaDru3Ai
         OGpIFi8TmOJEiO8ZG6EoI7nBhccVqyXQHIOF0sz2W6EmrZ/YKQBlTGzRbRXg0DG7rYpM
         WyDsBansqF8mQSxVHEk/Y6PS/X2BqKU7b93xwMYTTzxv/LplN/SQhvAnaKQCiWBPxE4R
         RGisr2QO5H630TFmzHqp7S1kdrm20KxSEf5VTYK9pk4//ggLrx0Ar2uS+56Yn2eOUrOW
         BVxA==
X-Gm-Message-State: AOAM531pG5bo+7qkHCdNKUb8X25FEhou/PsJNZzzTiZdcC4QpqfTriv/
        6rJHzFflo8gL5H5s8P+zE2lQeSJTaRpggeUs+aZoJwLXonyWzPH/YaIrIcTH8QcK0zZ2qYABJVw
        Jq7ko1wI7lxqyKXmyUjqA5+Z0
X-Received: by 2002:a05:600c:4e45:: with SMTP id e5mr478589wmq.43.1638817295836;
        Mon, 06 Dec 2021 11:01:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJylaw/aehMSK9MAUfw8JuRc4KextNeRWB5cyQ7lL73zqtRhto8ItUBZ3FB0hhdVunM/j0K3nw==
X-Received: by 2002:a05:600c:4e45:: with SMTP id e5mr478527wmq.43.1638817295484;
        Mon, 06 Dec 2021 11:01:35 -0800 (PST)
Received: from [192.168.3.132] (p5b0c62c6.dip0.t-ipconnect.de. [91.12.98.198])
        by smtp.gmail.com with ESMTPSA id n15sm197711wmq.38.2021.12.06.11.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 11:01:35 -0800 (PST)
Message-ID: <a48c16d6-07df-ff44-67e6-f0942672ec28@redhat.com>
Date:   Mon, 6 Dec 2021 20:01:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>, Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Michal Hocko <mhocko@suse.com>, Nico Pache <npache@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, raquini@redhat.com
References: <20211206033338.743270-1-npache@redhat.com>
 <20211206033338.743270-3-npache@redhat.com> <Ya3WcYKcej8XEI0W@dhcp22.suse.cz>
 <d9d14beb-ee20-7ebb-e007-fbf58fb28535@redhat.com>
 <24b4455c-aff9-ca9f-e29f-350833e7a0d1@virtuozzo.com>
 <CAHbLzko0UeNadswXEnwr6EtuKAZT4T-fnC5F7xnFcH4RbjhAiA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 2/2] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
In-Reply-To: <CAHbLzko0UeNadswXEnwr6EtuKAZT4T-fnC5F7xnFcH4RbjhAiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.12.21 19:42, Yang Shi wrote:
> On Mon, Dec 6, 2021 at 5:19 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>
>> On 06.12.2021 13:45, David Hildenbrand wrote:
>>>> This doesn't seen complete. Slab shrinkers are used in the reclaim
>>>> context. Previously offline nodes could be onlined later and this would
>>>> lead to NULL ptr because there is no hook to allocate new shrinker
>>>> infos. This would be also really impractical because this would have to
>>>> update all existing memcgs...
>>>
>>> Instead of going through the trouble of updating...
>>>
>>> ...  maybe just keep for_each_node() and check if the target node is
>>> offline. If it's offline, just allocate from the first online node.
>>> After all, we're not using __GFP_THISNODE, so there are no guarantees
>>> either way ...
>>
>> Hm, can't we add shrinker maps allocation to __try_online_node() in addition
>> to this patch?
> 
> I think the below fix (an example, doesn't cover all affected
> callsites) should be good enough for now? It doesn't touch the hot
> path of the page allocator.
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index fb9584641ac7..1252a33f7c28 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -222,13 +222,15 @@ static int expand_one_shrinker_info(struct
> mem_cgroup *memcg,
>         int size = map_size + defer_size;
> 
>         for_each_node(nid) {
> +               int tmp = nid;
>                 pn = memcg->nodeinfo[nid];
>                 old = shrinker_info_protected(memcg, nid);
>                 /* Not yet online memcg */
>                 if (!old)
>                         return 0;
> -
> -               new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, nid);
> +               if (!node_online(nid))
> +                       tmp = -1;
> +               new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, tmp);
>                 if (!new)
>                         return -ENOMEM;
> 
> It used to use kvmalloc instead of kvmalloc_node(). The commit
> 86daf94efb11d7319fbef5e480018c4807add6ef ("mm/memcontrol.c: allocate
> shrinker_map on appropriate NUMA node") changed to use *_node()
> version. The justification was that "kswapd is always bound to
> specific node. So allocate shrinker_map from the related NUMA node to
> respect its NUMA locality." There is no kswapd for offlined node, so
> just allocate shrinker info on node 0. This is also what
> alloc_mem_cgroup_per_node_info() does.

Yes, that's what I refer to as fixing it in the caller -- similar to
[1]. Michals point is to not require such node_online() checks at all,
neither in the caller nor in the buddy.

I see 2 options short-term

1) What we have in [1].
2) What I proposed in [2], fixing it for all such instances until we
have something better.

Long term I tend to agree that what Michal proposes is better.

Short term I tend to like [2], because it avoids having to mess with all
such instances to eventually get it right and the temporary overhead
until we have the code reworked should be really negligible ...



[1] https://lkml.kernel.org/r/20211108202325.20304-1-amakhalov@vmware.com
[2]
https://lkml.kernel.org/r/51c65635-1dae-6ba4-daf9-db9df0ec35d8@redhat.com

-- 
Thanks,

David / dhildenb

