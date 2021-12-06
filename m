Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89E2469769
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244729AbhLFNus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:50:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39029 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244021AbhLFNuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:50:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638798437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pbTuaguneU20yLH8XmZHu4ZuqUZW2es0ggVeJe1mqRM=;
        b=IugOQX2RXhIlG1+ZhiY7ovuzsu5QzLfdsusP8SUPfxrPBppZ/iO2hDZUMEqFEZFO61V6KI
        MxXpc69dO86IdTq1rWXvCcgWtlPbbngDZmp9glGxPkFW+diwzPlwaTe3x7JfOxA+kM5tuQ
        oU4Irw0XHIGUQyapft/RFsrLzqXCbn4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-gYf3tjnBNiuuSGA7R8iN2g-1; Mon, 06 Dec 2021 08:47:16 -0500
X-MC-Unique: gYf3tjnBNiuuSGA7R8iN2g-1
Received: by mail-wm1-f69.google.com with SMTP id 187-20020a1c02c4000000b003335872db8dso6151267wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 05:47:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=pbTuaguneU20yLH8XmZHu4ZuqUZW2es0ggVeJe1mqRM=;
        b=5E0GajYeDIDYsxGZTnVu9naeHoJnOMSOfDbrzJ5G+oRNxqyBcM+99aOTE8v710kGzA
         nFD9B/Moj2Z4roU2l8SDlUtOLu7ufZ+/YCDeTrPrRnSdhVnUNg3duX7kzF3wPNqgifgd
         L5agkCequxsDk3RVhQ5bbewEmgwA9FlLFUQ8CJ2oLXkrOR0L+hgmk+Q3CEwEhLTjU0Y6
         s2c4j7oTLQZXBIqi+DniZxFGVJJ7eZMjwchYIA1Di0+zRZ0F2UAMWlrbLO69Nhw8EVyE
         9fS2GA/kdNYZqshEU74pH/55D2FiVxyfO9aZ+xy9GukQY/LQhZXEeR0HS1fAPzHnJ6F7
         9t9w==
X-Gm-Message-State: AOAM530NTtlqc1ZgeKjE1hYIYB+Mkh48Oumybd8EQLchXsKp+gb/Y5/n
        uUIx2oE5XupZDZkF9dnEOhhpD03RX1FzP4Ad5IhC5h4O2u8jovgaSrIif9tT3wlazvbCqKDzzpK
        JXjosPOBJFFdxn619P53jjiHW
X-Received: by 2002:a05:600c:1f19:: with SMTP id bd25mr38678949wmb.75.1638798435522;
        Mon, 06 Dec 2021 05:47:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwrrhBg2VovE2Fdc+MaVMjQ76RtjNVj1lzeojZ6Qzu6XZoqdrUUzEpGsS2brfJERMTInmg5sw==
X-Received: by 2002:a05:600c:1f19:: with SMTP id bd25mr38678913wmb.75.1638798435231;
        Mon, 06 Dec 2021 05:47:15 -0800 (PST)
Received: from [192.168.3.132] (p5b0c62c6.dip0.t-ipconnect.de. [91.12.98.198])
        by smtp.gmail.com with ESMTPSA id c4sm11216205wrr.37.2021.12.06.05.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 05:47:14 -0800 (PST)
Message-ID: <05157de4-e5df-11fc-fc46-8a9f79d0ddb4@redhat.com>
Date:   Mon, 6 Dec 2021 14:47:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, shakeelb@google.com,
        ktkhai@virtuozzo.com, shy828301@gmail.com, guro@fb.com,
        vbabka@suse.cz, vdavydov.dev@gmail.com, raquini@redhat.com
References: <20211206033338.743270-1-npache@redhat.com>
 <20211206033338.743270-3-npache@redhat.com> <Ya3WcYKcej8XEI0W@dhcp22.suse.cz>
 <d9d14beb-ee20-7ebb-e007-fbf58fb28535@redhat.com>
 <Ya3r3C/OpnK7OBPt@dhcp22.suse.cz>
 <840cb3d0-61fe-b6cb-9918-69146ba06cf7@redhat.com>
 <Ya3yZWkj2wGRWDMz@dhcp22.suse.cz>
 <51c65635-1dae-6ba4-daf9-db9df0ec35d8@redhat.com>
 <Ya4K0+XCmv3NBmwQ@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 2/2] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
In-Reply-To: <Ya4K0+XCmv3NBmwQ@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.12.21 14:06, Michal Hocko wrote:
> On Mon 06-12-21 13:43:27, David Hildenbrand wrote:
> [...]
>>> Now practically speaking !node_online should not apear node_online (note
>>> I am attentionally avoiding to say offline and online as that has a
>>> completely different semantic) shouldn't really happen for some
>>> architectures. x86 should allocate pgdat for each possible node. I do
>>> not know what was the architecture in this case but we already have
>>> another report for x86 that remains unexplained.
>>
>> So we'd allocate the pgdat although all we want is just a zonelist. The
>> obvious alternative is to implement the fallback where reasonable -- for
>> example, in the page allocator. It knows the fallback order:
>> build_zonelists(). That's pretty much all we need the preferred_nid for.
>>
>> So just making prepare_alloc_pages()/node_zonelist() deal with a missing
>> pgdat could make sense as well. Something like:
>>
>>
>> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
>> index b976c4177299..2d2649e78766 100644
>> --- a/include/linux/gfp.h
>> +++ b/include/linux/gfp.h
>> @@ -508,9 +508,14 @@ static inline int gfp_zonelist(gfp_t flags)
>>   *
>>   * For the case of non-NUMA systems the NODE_DATA() gets optimized to
>>   * &contig_page_data at compile-time.
>> + *
>> + * If the node does not have a pgdat yet, returns the zonelist of the
>> + * first online node.
>>   */
>>  static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
>>  {
>> +       if (unlikely(!NODE_DATA(nid)))
>> +               nid = first_online_node;
>>         return NODE_DATA(nid)->node_zonelists + gfp_zonelist(flags);
>>  }
> 
> This is certainly possible. But it a) adds a branch to the hotpath and
> b) it doesn't solve any other potential dereference of garbage node.

I don't think a) is  a problem but it's easy to measure. Agreed to b),
however, the page allocator has been the most prominent source of error
reports for this.

>  
>> But of course, there might be value in a proper node-aware fallback list
>> as we have in build_zonelists() -- but it remains questionable if the
>> difference for these corner cases would be relevant in practice.
> 
> Only the platform knows the proper node topology and that includes
> memory less nodes. So they should be setting up a node properly and we
> shouldn't be dealing with this at the allocator nor any other code.

I *think* there are cases where the topology of a new node is only know
once it actually gets used. For example, I remember talking to CXL and
there are ideas to have a pool of possible nodes, which can get used
dynamically for CXL memory. Of course, some kind of reconfiguration
could be imaginable.

> 
>> Further, if we could have thousands of nodes, we'd have to update each
>> and every one when building zone lists ...
> 
> Why would that be a practical problem?

We'll need at least

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c5952749ad40..e5d958abc7cc 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6382,7 +6382,7 @@ static void __build_all_zonelists(void *data)
        if (self && !node_online(self->node_id)) {
                build_zonelists(self);
        } else {
-               for_each_online_node(nid) {
+               for_each_node(nid) {
                        pg_data_t *pgdat = NODE_DATA(nid);

                        build_zonelists(pgdat);


But there might be more missing. Onlining a new zone will get more
expensive in setups with a lot of possible nodes (x86-64 shouldn't
really be an issue in that regard).

If we want stable backports, we'll want something simple upfront.


-- 
Thanks,

David / dhildenb

