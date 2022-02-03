Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119094A806F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 09:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349026AbiBCI1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 03:27:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45512 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233434AbiBCI1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 03:27:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643876840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mcKEYXqPIU6EmxmVYKokVd8YQg0IyQZTYFGDXp+PzRQ=;
        b=HNnuHQoDTCQMkz+s8IyuBAwVYsPRV1YGqMqoEVmAqVPUpApDNHpiCZvC2mAvYCAU/+isiK
        GJxqBlzaoQRcbZWbZ8P8iLwL27U6jk/j19hCvAiGTu2GqgvxYyaP1xoew+WEeNnpBKSc5O
        Roqi8Qgn+6OCuf1j1JIcye4z0Pq5J0c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-NyT724quNhyZ48__NoJ9xA-1; Thu, 03 Feb 2022 03:27:19 -0500
X-MC-Unique: NyT724quNhyZ48__NoJ9xA-1
Received: by mail-wr1-f70.google.com with SMTP id j21-20020adfa555000000b001db55dd5a1dso394117wrb.15
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 00:27:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=mcKEYXqPIU6EmxmVYKokVd8YQg0IyQZTYFGDXp+PzRQ=;
        b=CYHkbsu170ebpJ4xoF4YRIHeCklFSCMZV+RmCYfyudkt1ddFgr91i7Nk0y2sc6lEnQ
         t2Y+39LuZNdqm7mSI4KB534P1lJhYgPyoOD1uiiLyjFAPng7EGyIiDo/vMp6anWWDFmp
         e5G9J2Md3wANosoH7kpa8556+iMzfcyZzcUvLkTyN6R6CbVHf/dRmZpNdPAz2MMDS+eb
         EgBUz0iPMc5WMs0tq5gW8OVvtiGcyKC5C0+K80dAZrvDlBCH/lmMfC0sQTmGwUxclf5M
         T9H3bHiVcMpxMaTJdjqGQFsDI5blgODckyhT4STO4kk3+ZYDctYmuQ3IpUf8kVSHvPvg
         yrUw==
X-Gm-Message-State: AOAM533dRkPZRR+28XUV9di+XPLUg7t0MOzgGK23DNvnyeAhTlQIqaHo
        r5JHkqB5EVp4NfP/ZF5rSbvpONws66dDAQ3BfJP68Vyhe0b4tM4uVtFEv+6eDU4TwW+poKYGYii
        UxgbjtLQTEpNLUfhSqh3hsvBQ
X-Received: by 2002:adf:e4c4:: with SMTP id v4mr27933911wrm.332.1643876838441;
        Thu, 03 Feb 2022 00:27:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWBN8FmjCQATCY1dHn479U4lb3by48KSEH1vwLr1w8qX2V41BfYO7Sf/m5ssgb3DEEE7rXzA==
X-Received: by 2002:adf:e4c4:: with SMTP id v4mr27933900wrm.332.1643876838184;
        Thu, 03 Feb 2022 00:27:18 -0800 (PST)
Received: from ?IPV6:2003:d8:2f11:9700:838c:3860:6500:5284? (p200300d82f119700838c386065005284.dip0.t-ipconnect.de. [2003:d8:2f11:9700:838c:3860:6500:5284])
        by smtp.gmail.com with ESMTPSA id 5sm22514099wrb.113.2022.02.03.00.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 00:27:17 -0800 (PST)
Message-ID: <c67e5fc0-95dd-1659-3a81-f23cf0be9c08@redhat.com>
Date:   Thu, 3 Feb 2022 09:27:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Nico Pache <npache@redhat.com>,
        Rafael Aquini <raquini@redhat.com>
References: <20220127085305.20890-1-mhocko@kernel.org>
 <20220127085305.20890-3-mhocko@kernel.org> <YfKgE5hTgbaBeaMa@kernel.org>
 <YfKwjAlPW2kJUv5w@dhcp22.suse.cz> <20220201024119.2ailcw4rp5thambz@master>
 <YfkDXYhGjAvAKKeU@dhcp22.suse.cz> <20220203002116.akpk5um5nkpeflve@master>
 <YfuC6IaasxcnAdGl@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 2/6] mm: handle uninitialized numa nodes gracefully
In-Reply-To: <YfuC6IaasxcnAdGl@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.02.22 08:23, Mike Rapoport wrote:
> On Thu, Feb 03, 2022 at 12:21:16AM +0000, Wei Yang wrote:
>> On Tue, Feb 01, 2022 at 10:54:37AM +0100, Michal Hocko wrote:
>>> On Tue 01-02-22 02:41:19, Wei Yang wrote:
>>>> On Thu, Jan 27, 2022 at 03:47:40PM +0100, Michal Hocko wrote:
>>>> [...]
>>>>>>> +			/*
>>>>>>> +			 * not marking this node online because we do not want to
>>>>>>> +			 * confuse userspace by sysfs files/directories for node
>>>>>>> +			 * without any memory attached to it (see topology_init)
>>>>>>> +			 * The pgdat will get fully initialized when a memory is
>>>>>>> +			 * hotpluged into it by hotadd_init_pgdat
>>>>>>> +			 */
>>>>
>>>> Hmm... which following step would mark the node online? On x86, the node is
>>>> onlined in alloc_node_date(). This is not onlined here.
>>>
>>> The comment tries to explain that this happens during the memory
>>> hotplug. Or maybe I have missed your question?
>>>
>>
>> I am not sure for others, while the comment confused me a little.
>>
>> Currently in kernel, there are two situations for node online:
>>
>>   * during memory hotplug
>>   * during sys-init
>>
>> For memory hotplug, we allocate pgdat and online node. And current hot-add
>> process has already put them in two steps:
>>
>>   1. __try_online_node()
>>   2. node_set_online()
>>
>> So emphasize "not online" node here, confuse me a little. It is a natural
>> thing to not online node until it has memory.
>>
>> But from another point of view, the comment here is reasonable. During
>> sys-init, we online node at the same time when creating pgdat. And even for
>> memory-less node on x86, we online them too.
>>
>> Well, this is all about the comment. I have tried to grab may head but not
>> come up with a better idea.
>>
>> Or maybe this is just my personal feeling, don't bother if no-one else feel
>> like this.
> 
> I shuffled the words a bit, maybe this sounds better not only to me :)
> 
> /*
>  * We do not want to confuse userspace by sysfs files/directories for node
>  * without any memory attached to it, so this node is not marked as
>  * N_MEMORY and not marked online so that topology_init() won't create
>  * sysfs hierarchy for this node.  The pgdat will get fully initialized by
>  * hotadd_init_pgdat() when memory is hotpluged into this node
>  */
> 

Note that the topology_init() part might change soon [1] so maybe we
want to rephrase that to "so that no sysfs hierarchy will be created via
register_one_node() for this node." right away.

or (because there is also /sys/devices/system/node/online  )

"so that the node won't be indicated as online to user space, for
example, via register_one_node()."

[1] https://lkml.kernel.org/r/20220128151540.164759-1-david@redhat.com

-- 
Thanks,

David / dhildenb

