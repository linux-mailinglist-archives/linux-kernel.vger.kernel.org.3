Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D62046C8BA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 01:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242827AbhLHAhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 19:37:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25455 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229503AbhLHAhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 19:37:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638923624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4wPqjo5XnKnLRGHjp53e4CWVRbk9N6dPooNDByxfzhI=;
        b=iOd71W4pYC6aPL2CPdvVK8mzUuhEPT6P+Btk7rdLaRtjXS19EGzS9x0oM/bXdFAee2NR10
        djkvOkrx67rClJ1KjawFbrQkCwPh2J6GH16NPc9Q0Fhl+ttwXtLBbpMP7X+6p6OG+U1xz4
        6JXiq54R3Md8QIGKLkXcS5KHwUyP8mg=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-292-bdZBvYF_N1auSxeyaGmBMw-1; Tue, 07 Dec 2021 19:33:43 -0500
X-MC-Unique: bdZBvYF_N1auSxeyaGmBMw-1
Received: by mail-il1-f198.google.com with SMTP id g11-20020a056e021a2b00b0029fdc4107d9so986035ile.16
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 16:33:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4wPqjo5XnKnLRGHjp53e4CWVRbk9N6dPooNDByxfzhI=;
        b=qEvKagxR3xXVrR4QJ487pZBTx843SFADWLig0Ui/0oqCLGr7dwoCiBNdxWrvf1Dj3b
         VFTGrYmLAJ9cfP73A4SUbvs///saz66EBwV2LcWxJ3DzRXZyc5vwv/kDh4A9Pt4F8fHb
         PvVmhtq5JbvriaJSiZKXNTn1jFoACwuKIpnxFtT+8FK+pwRrHIZhJtAIZ7robi6ryCo9
         cHKtSwykLEh+TbhHbzWLNKi9uY5zRE4A1fwuRs9iiZDHMhjd3Qn42IaAQdC1xSSFgGtM
         iJHWoX8Hx3GMptSlljVLyvxzA8LnCkNL9SEnNDstLNNZJgj0Q90EZrq1jxD7F0yIi/Fq
         jjKw==
X-Gm-Message-State: AOAM5316KuAVPmDxKTXltgyAZ/W645yXFlAJvaql7r/Lxf3+i9u1fYSI
        AgEhRkriGOvqJ30pwBcFJ700sAntf/SGpr/FNHp5xKjtirWzotWAjB1gjkY7ruQGDQ3t02Mn6iP
        0bisirGiT7zE/6Q3Og5q4xT0o
X-Received: by 2002:a05:6e02:484:: with SMTP id b4mr2939552ils.173.1638923622374;
        Tue, 07 Dec 2021 16:33:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzcpNBLoUE/608YuXdOGh8G2GYTZmVBtYT2FsOK4t+yc2CNgx6W/E8uV39KrC43r4IQoU1Wsg==
X-Received: by 2002:a05:6e02:484:: with SMTP id b4mr2939530ils.173.1638923622148;
        Tue, 07 Dec 2021 16:33:42 -0800 (PST)
Received: from ?IPV6:2601:280:4400:a2e0:7336:512c:930d:4f0e? ([2601:280:4400:a2e0:7336:512c:930d:4f0e])
        by smtp.gmail.com with ESMTPSA id k13sm1191994iow.45.2021.12.07.16.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 16:33:41 -0800 (PST)
Message-ID: <17a7d9e4-5ebc-1160-1e5e-97707b6e5286@redhat.com>
Date:   Tue, 7 Dec 2021 19:33:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/1] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, raquini@redhat.com,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>
References: <20211207224013.880775-1-npache@redhat.com>
 <20211207224013.880775-2-npache@redhat.com>
 <20211207154438.c1e49a3f0b5ebc9245aac61b@linux-foundation.org>
 <CAHbLzkoCds-WOoN5CKas4DThk8hU65pgtMcga10QEqEmKU2f5A@mail.gmail.com>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <CAHbLzkoCds-WOoN5CKas4DThk8hU65pgtMcga10QEqEmKU2f5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/7/21 19:26, Yang Shi wrote:
> On Tue, Dec 7, 2021 at 3:44 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> On Tue,  7 Dec 2021 17:40:13 -0500 Nico Pache <npache@redhat.com> wrote:
>>
>>> We have run into a panic caused by a shrinker allocation being attempted
>>> on an offlined node.
>>>
>>> Our crash analysis has determined that the issue originates from trying
>>> to allocate pages on an offlined node in expand_one_shrinker_info. This
>>> function makes the incorrect assumption that we can allocate on any node.
>>> To correct this we make sure the node is online before tempting an
>>> allocation. If it is not online choose the closest node.
>>
>> This isn't fully accurate, is it?  We could allocate on a node which is
>> presently offline but which was previously onlined, by testing
>> NODE_DATA(nid).
>>
>> It isn't entirely clear to me from the v1 discussion why this approach
>> isn't being taken?
>>
>> AFAICT the proposed patch is *already* taking this approach, by having
>> no protection against a concurrent or subsequent node offlining?
> 
> AFAICT, we have not reached agreement on how to fix it yet. I saw 3
> proposals at least:
> 
> 1. From Michal, allocate node data for all possible nodes.
> https://lore.kernel.org/all/Ya89aqij6nMwJrIZ@dhcp22.suse.cz/T/#u
> 
> 2. What this patch does. Proposed originally from
> https://lore.kernel.org/all/20211108202325.20304-1-amakhalov@vmware.com/T/#u

Correct me if im wrong, but isn't that a different caller? This patch fixes the
issue in expand_one_shrinker_info.

> 3. From David, fix in node_zonelist().
> https://lore.kernel.org/all/51c65635-1dae-6ba4-daf9-db9df0ec35d8@redhat.com/T/#u
> 
>>
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -222,13 +222,16 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>>>       int size = map_size + defer_size;
>>>
>>>       for_each_node(nid) {
>>> +             int tmp = nid;
>>
>> Not `tmp', please.  Better to use an identifier which explains the
>> variable's use.  target_nid?
>>
>> And a newline after defining locals, please.
>>
>>>               pn = memcg->nodeinfo[nid];
>>>               old = shrinker_info_protected(memcg, nid);
>>>               /* Not yet online memcg */
>>>               if (!old)
>>>                       return 0;
>>>
>>> -             new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, nid);
>>> +             if(!node_online(nid))
>>
>> s/if(/if (/
>>
>>> +                     tmp = numa_mem_id();
>>> +             new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, tmp);
>>>               if (!new)
>>>                       return -ENOMEM;
>>>
>>
>> And a code comment fully explaining what's going on here?
> 

