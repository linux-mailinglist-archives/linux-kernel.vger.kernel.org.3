Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC415075EA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355717AbiDSRGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355684AbiDSRGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:06:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9BC0488B4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 09:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650387440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ZJkSy0snYmZQYcdUUa6S5DK0dg8RNx6ZqzPz1gftNw=;
        b=a1BYWQR7rPTV+i2Fkhv/ipyn7Ov8tz2r/rShm6/Fz6qEp1VTdpRXPOlqI71nKeeRogG5eR
        z09qyF4/d7JgjdBM3vXBKINLjV2IC18WSPeoPw8XDAE2nBRA9t4PmnaL33NYrbYjNYxqHU
        nLrT4LY33lvyw8SosyW16dOtsn4nA2U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-501-VRis_aIaNWiEbee7UH60Ew-1; Tue, 19 Apr 2022 12:57:19 -0400
X-MC-Unique: VRis_aIaNWiEbee7UH60Ew-1
Received: by mail-wm1-f72.google.com with SMTP id r9-20020a1c4409000000b0038ff033b654so113125wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 09:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=5ZJkSy0snYmZQYcdUUa6S5DK0dg8RNx6ZqzPz1gftNw=;
        b=ykFxD12OBxIIgLQu/qgkJiq7BrmH3ImIta7e56nTrjsNbmDPX9+2Q+Bb06FIR6TeVC
         oKN1evMsvsqFOpS9KgJ+YjqsCsQK0jyqDWRYbSO8i+8oLhNppDdWKwoIYQUfK5ppYk0L
         9VdeSNBjOVd36KXOVbfkKf/FhXcqpuZrdlYT3LxzziAfvISmx68xxhnLo6xz/9dqnNmG
         zgC1XGXCDo+skmQ4KrhyiBBcF726lM/CJpXjGU7Su2DOsIAksGFuf2NbKkpLCJLURd75
         hQIkabk9ApTQOHFrubYUmD2XvTYwGAefoOQVR1vLF4AT+IpDmJjFMPm6xlXpFxg5eS2E
         6p7Q==
X-Gm-Message-State: AOAM531IwLaY8WUM6GuA/yafLDcaa3b71CRM+eWThwCzxiuty2ShOMkP
        +7EfaujKMdvgEW1A8dKu4Rj99Gwl80mFyWo5PNx4D9WaPslTeI55qO3qyKXG9VApklw0TdsByRS
        n9KHLTV9TN9Cr8uyxKw1Im5+W
X-Received: by 2002:a5d:64e7:0:b0:20a:a5e7:7bb9 with SMTP id g7-20020a5d64e7000000b0020aa5e77bb9mr3628634wri.602.1650387438354;
        Tue, 19 Apr 2022 09:57:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAV9fdedIcGeuV2Sqhw1e79/2vn/6x1RS1YayTk1NHOIQXEZD6gNhkoNR/6wpyP8giNy9qtA==
X-Received: by 2002:a5d:64e7:0:b0:20a:a5e7:7bb9 with SMTP id g7-20020a5d64e7000000b0020aa5e77bb9mr3628621wri.602.1650387438105;
        Tue, 19 Apr 2022 09:57:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:5d00:d8c2:fbf6:a608:957a? (p200300cbc7045d00d8c2fbf6a608957a.dip0.t-ipconnect.de. [2003:cb:c704:5d00:d8c2:fbf6:a608:957a])
        by smtp.gmail.com with ESMTPSA id a9-20020a7bc1c9000000b0038eb67e966esm15963513wmj.29.2022.04.19.09.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 09:57:17 -0700 (PDT)
Message-ID: <fc8161c7-61a5-d4c2-ae78-15deddfd9916@redhat.com>
Date:   Tue, 19 Apr 2022 18:57:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] mm: do not call add_nr_deferred() with zero deferred
Content-Language: en-US
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>
References: <20220416004104.4089743-1-roman.gushchin@linux.dev>
 <59404249-de0c-c569-d04a-9da38ed14b0a@redhat.com> <Yl7mdguNR3CabMAN@carbon>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Yl7mdguNR3CabMAN@carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.04.22 18:42, Roman Gushchin wrote:
> On Tue, Apr 19, 2022 at 02:56:06PM +0200, David Hildenbrand wrote:
>> On 16.04.22 02:41, Roman Gushchin wrote:
>>> add_nr_deferred() is often called with next_deferred equal to 0.
>>> For instance, it's happening under low memory pressure for any
>>> shrinkers with a low number of cached objects. A corresponding trace
>>> looks like:
>>>   <...>-619914 [005] .... 467456.345160: mm_shrink_slab_end: \
>>>   super_cache_scan+0x0/0x1a0 0000000087027f06: nid: 1	     \
>>>   unused scan count 0 new scan count 0 total_scan 0	     \
>>>   last shrinker return val 0
>>>
>>>   <...>-619914 [005] .... 467456.345371: mm_shrink_slab_end: \
>>>   super_cache_scan+0x0/0x1a0 0000000087027f06: nid: 1	     \
>>>   unused scan count 0 new scan count 0 total_scan 0	     \
>>>   last shrinker return val 0
>>>
>>>   <...>-619914 [005] .... 467456.345380: mm_shrink_slab_end: \
>>>   super_cache_scan+0x0/0x1a0 0000000087027f06: nid: 1 unused \
>>>   scan count 0 new scan count 0 total_scan 0	             \
>>>   last shrinker return val 0
>>>
>>> This lead to unnecessary checks and atomic operations, which can be
>>> avoided by checking next_deferred for not being zero before calling
>>> add_nr_deferred(). In this case the mm_shrink_slab_end trace point
>>> will get a potentially slightly outdated "new scan count" value, but
>>> it's totally fine.
>>
>> Sufficient improvement to justify added complexity for anybody reading
>> that code?
> 
> I don't have any numbers and really doubt the difference is significant,
> however the added complexity is also small: one "if" statement.
> Anyway, if you feel strongly against this change, I'm fine with dropping it.
> 

No strong opinion, naturally, more conditions make the code harder to
read -- that's why I'm asking.

>>
>>>
>>> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
>>> ---
>>>  mm/vmscan.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> index d4a7d2bd276d..19d3d4fa1aad 100644
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -808,7 +808,10 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>>>  	 * move the unused scan count back into the shrinker in a
>>>  	 * manner that handles concurrent updates.
>>>  	 */
>>> -	new_nr = add_nr_deferred(next_deferred, shrinker, shrinkctl);
>>> +	if (next_deferred)
>>> +		new_nr = add_nr_deferred(next_deferred, shrinker, shrinkctl);
>>> +	else
>>> +		new_nr = nr;
>>>  
>>>  	trace_mm_shrink_slab_end(shrinker, shrinkctl->nid, freed, nr, new_nr, total_scan);
>>>  	return freed;
>>
>> And if we still want to do this optimization, why not put it into
>> add_nr_deferred()?
> 
> Because of the semantics of add_nr_deferred(), which returns the deferred value.
> It's not used for anything except tracing, so maybe it's a place for another
> change.

Skimming over the code I somehow missed that add_nr_deferred() doesn't
have "nr" naturally available.

LGTM

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

