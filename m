Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698B54FC0CA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348005AbiDKPeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348369AbiDKPeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:34:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8AF369FD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:31:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 208AF21100;
        Mon, 11 Apr 2022 15:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649691112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FYat79/7pG8HYkrEImZXhwDV0UKca1/KnNQ9I3dHX0c=;
        b=wMtEydag0BsohSfymKljISu20kAG0cCFcQ8RNZ7fGabsPpf7X4QO9rkAi1AZuEujM1UyjZ
        1BjzkBTlYs86jXPV4I4wEpUpocPn0yZD6ml9nvt4l6soTlrX2Yr75mqiRayuVrc7U6cUT2
        ckIW/U28aRkd6qX6zg4aKsSfiYz5+E4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649691112;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FYat79/7pG8HYkrEImZXhwDV0UKca1/KnNQ9I3dHX0c=;
        b=tS6tlzFmkCSgDl3NJDtSu+DgOM/EbaQ6ZDEbZJA3jlmjJ960V6rXIQfj32PfyH1IgKe5y5
        jgmzm4eAx1AQ9oBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4B1B13AB5;
        Mon, 11 Apr 2022 15:31:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hEhKM+dJVGJyZAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 11 Apr 2022 15:31:51 +0000
Message-ID: <9b02d27a-b4c0-acfa-dc0b-ac4912c1d3e6@suse.cz>
Date:   Mon, 11 Apr 2022 17:31:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] mm/slab_common: move dma-kmalloc caches creation into
 new_kmalloc_cache()
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Ohhoon Kwon <ohkwon1043@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        JaeSang Yoo <jsyoo5b@gmail.com>,
        Wonhyuk Yang <vvghjk1234@gmail.com>,
        Jiyoup Kim <lakroforce@gmail.com>,
        Donghyeok Kim <dthex5d@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <Catalin.Marinas@arm.com>
References: <20220410162511.656541-1-ohkwon1043@gmail.com>
 <YlQMC9x1hfgonJH/@hyeyoo>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YlQMC9x1hfgonJH/@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/22 13:07, Hyeonggon Yoo wrote:
> On Mon, Apr 11, 2022 at 01:25:11AM +0900, Ohhoon Kwon wrote:
>> There are four types of kmalloc_caches: KMALLOC_NORMAL, KMALLOC_CGROUP,
>> KMALLOC_RECLAIM, and KMALLOC_DMA. While the first three types are
>> created using new_kmalloc_cache(), KMALLOC_DMA caches are created in a
>> separate logic. Let KMALLOC_DMA caches be also created using
>> new_kmalloc_cache(), to enhance readability.
>> 
>> Historically, there were only KMALLOC_NORMAL caches and KMALLOC_DMA
>> caches in the first place, and they were initialized in two separate
>> logics. However, when KMALLOC_RECLAIM was introduced in v4.20 via
>> commit 1291523f2c1d ("mm, slab/slub: introduce kmalloc-reclaimable
>> caches") and KMALLOC_CGROUP was introduced in v5.14 via
>> commit 494c1dfe855e ("mm: memcg/slab: create a new set of kmalloc-cg-<n>
>> caches"), their creations were merged with KMALLOC_NORMAL's only.
>> KMALLOC_DMA creation logic should be merged with them, too.
>> 
>> By merging KMALLOC_DMA initialization with other types, the following
>> two changes might occur:
>> 1. The order dma-kmalloc-<n> caches added in slab_cache list may be
>> sorted by size. i.e. the order they appear in /proc/slabinfo may change
>> as well.
>> 2. slab_state will be set to UP after KMALLOC_DMA is created.
>> In case of slub, freelist randomization is dependent on slab_state>=UP,
>> and therefore KMALLOC_DMA cache's freelist will not be randomized in
>> creation, but will be deferred to init_freelist_randomization().
>> 
>> Co-developed-by: JaeSang Yoo <jsyoo5b@gmail.com>
>> Signed-off-by: JaeSang Yoo <jsyoo5b@gmail.com>
>> Signed-off-by: Ohhoon Kwon <ohkwon1043@gmail.com>
>> ---
>>  mm/slab_common.c | 18 +++---------------
>>  1 file changed, 3 insertions(+), 15 deletions(-)
>> 
>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>> index 6ee64d6208b3..a959d247c27b 100644
>> --- a/mm/slab_common.c
>> +++ b/mm/slab_common.c
>> @@ -849,6 +849,8 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
>>  			return;
>>  		}
>>  		flags |= SLAB_ACCOUNT;
>> +	} else if (IS_ENABLED(CONFIG_ZONE_DMA) && (type == KMALLOC_DMA)) {
>> +		flags |= SLAB_CACHE_DMA;
>>  	}
>>  
>>  	kmalloc_caches[type][idx] = create_kmalloc_cache(
>> @@ -877,7 +879,7 @@ void __init create_kmalloc_caches(slab_flags_t flags)
>>  	/*
>>  	 * Including KMALLOC_CGROUP if CONFIG_MEMCG_KMEM defined
>>  	 */
>> -	for (type = KMALLOC_NORMAL; type <= KMALLOC_RECLAIM; type++) {
>> +	for (type = KMALLOC_NORMAL; type < NR_KMALLOC_TYPES; type++) {
>>  		for (i = KMALLOC_SHIFT_LOW; i <= KMALLOC_SHIFT_HIGH; i++) {
>>  			if (!kmalloc_caches[type][i])
>>  				new_kmalloc_cache(i, type, flags);
>> @@ -898,20 +900,6 @@ void __init create_kmalloc_caches(slab_flags_t flags)
>>  
>>  	/* Kmalloc array is now usable */
>>  	slab_state = UP;
>> -
>> -#ifdef CONFIG_ZONE_DMA
>> -	for (i = 0; i <= KMALLOC_SHIFT_HIGH; i++) {
>> -		struct kmem_cache *s = kmalloc_caches[KMALLOC_NORMAL][i];
>> -
>> -		if (s) {
>> -			kmalloc_caches[KMALLOC_DMA][i] = create_kmalloc_cache(
>> -				kmalloc_info[i].name[KMALLOC_DMA],
>> -				kmalloc_info[i].size,
>> -				SLAB_CACHE_DMA | flags, 0,
>> -				kmalloc_info[i].size);
>> -		}
>> -	}
>> -#endif
>>  }
>>  #endif /* !CONFIG_SLOB */
>>
> 
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks.
Added to:
https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=for-5.19/refactor

> BTW this patch may conflict with [1] (not merged yet)
> 
> [1] https://lore.kernel.org/linux-mm/20220405135758.774016-9-catalin.marinas@arm.com/

FYI Catalin, might want to base v2 on the above once the crypto side is
solved. At cursory look it shouldn't be a significant conflict.

> Thanks!
> 
>> -- 
>> 2.25.1
>> 
> 

