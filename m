Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DC74C883C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbiCAJly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiCAJlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:41:53 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5268AE5D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 01:41:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3A01B219A2;
        Tue,  1 Mar 2022 09:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646127671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IkEzjCntl04WMjzdipCFPXraObjVWH/A28DXmzE6ZwQ=;
        b=NgZdrNmalRgtKeLZ4dhFGoEiahl2O3o5aAiEYWk+ZrlQFzNzXhkghEjV6svSwK6Q+KPENv
        bOBFqddX3LgDyT9KdvEOQQpHls7i0MIsuBrY+DqetQmGtebORmwicVgkMjW6n4Ux2jMnUw
        nPfpg3shY1EbCFuuy5LaylEwUzlFP8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646127671;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IkEzjCntl04WMjzdipCFPXraObjVWH/A28DXmzE6ZwQ=;
        b=bCpBKkRyV38cvGEZI5n1kUjTWXUiEW7LTgYOkUeXwbQC+adoxuu/N8x+ud8bE34BI+w/7p
        3zRzuAz5am/yTyCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EEBC613B08;
        Tue,  1 Mar 2022 09:41:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id A8aCOTbqHWJUYwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 01 Mar 2022 09:41:10 +0000
Message-ID: <827b9a5a-f925-776d-1893-c35211fee7f9@suse.cz>
Date:   Tue, 1 Mar 2022 10:41:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 0/5] SLUB debugfs improvements based on stackdepot
Content-Language: en-US
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marco Elver <elver@google.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>
References: <20220225180318.20594-1-vbabka@suse.cz>
 <YhnUcqyeMgCrWZbd@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <f194f876-1c46-f3ae-573e-d3ddd6dcf4cc@suse.cz>
 <Yh0qGY48JeH7TzdQ@linux.ibm.com>
 <7918434f-9730-3532-9b42-3e67d10d25d3@suse.cz>
 <Yh3lhDuL2DhuREp4@linux.ibm.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Yh3lhDuL2DhuREp4@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/22 10:21, Mike Rapoport wrote:
> On Tue, Mar 01, 2022 at 12:38:11AM +0100, Vlastimil Babka wrote:
>> On 2/28/22 21:01, Mike Rapoport wrote:
>> > On Mon, Feb 28, 2022 at 08:10:18PM +0100, Vlastimil Babka wrote:
>> >> On 2/26/22 08:19, Hyeonggon Yoo wrote:
>> >> > On Fri, Feb 25, 2022 at 07:03:13PM +0100, Vlastimil Babka wrote:
>> >> >> Hi,
>> >> >> 
>> >> >> this series combines and revives patches from Oliver's last year
>> >> >> bachelor thesis (where I was the advisor) that make SLUB's debugfs
>> >> >> files alloc_traces and free_traces more useful.
>> >> >> The resubmission was blocked on stackdepot changes that are now merged,
>> >> >> as explained in patch 2.
>> >> >> 
>> >> > 
>> >> > Hello. I just started review/testing this series.
>> >> > 
>> >> > it crashed on my system (arm64)
>> >> 
>> >> Hmm, interesting. On x86_64 this works for me and stackdepot is allocated
>> >> from memblock. arm64 must have memblock freeing happen earlier or something.
>> >> (CCing memblock experts)
>> >> 
>> >> > I ran with boot parameter slub_debug=U, and without KASAN.
>> >> > So CONFIG_STACKDEPOT_ALWAYS_INIT=n.
>> >> > 
>> >> > void * __init memblock_alloc_try_nid(
>> >> >                         phys_addr_t size, phys_addr_t align,
>> >> >                         phys_addr_t min_addr, phys_addr_t max_addr,
>> >> >                         int nid)
>> >> > {
>> >> >         void *ptr;
>> >> > 
>> >> >         memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa %pS\n",
>> >> >                      __func__, (u64)size, (u64)align, nid, &min_addr,
>> >> >                      &max_addr, (void *)_RET_IP_);
>> >> >         ptr = memblock_alloc_internal(size, align,
>> >> >                                            min_addr, max_addr, nid, false);
>> >> >         if (ptr)
>> >> >                 memset(ptr, 0, size); <--- Crash Here
>> >> > 
>> >> >         return ptr;
>> >> > }
>> >> > 
>> >> > It crashed during create_boot_cache() -> stack_depot_init() ->
>> >> > memblock_alloc().
>> >> > 
>> >> > I think That's because, in kmem_cache_init(), both slab and memblock is not
>> >> > available. (AFAIU memblock is not available after mem_init() because of
>> >> > memblock_free_all(), right?)
>> >> 
>> >> Hm yes I see, even in x86_64 version mem_init() calls memblock_free_all().
>> >> But then, I would expect stack_depot_init() to detect that memblock_alloc()
>> >> returns NULL, we print ""Stack Depot hash table allocation failed,
>> >> disabling" and disable it. Instead it seems memblock_alloc() returns
>> >> something that's already potentially used by somebody else? Sounds like a bug?
>> > 
>> > If stack_depot_init() is called from kmem_cache_init(), there will be a
>> > confusion what allocator should be used because we use slab_is_available()
>> > to stop using memblock and start using kmalloc() instead in both
>> > stack_depot_init() and in memblock.
>> 
>> I did check that stack_depot_init() is called from kmem_cache_init()
>> *before* we make slab_is_available() true, hence assumed that memblock would
>> be still available at that point and expected no confusion. But seems if
>> memblock is already beyond memblock_free_all() then it being still available
>> is just an illusion?
> 
> Yeah, it appears it is an illusion :)
> 
> I think we have to deal with allocations that happen between
> memblock_free_all() and slab_is_available() at the memblock level and then
> figure out the where to put stack_depot_init() and how to allocate memory
> there.
> 
> I believe something like this (untested) patch below addresses the first
> issue. As for stack_depot_init() I'm still trying to figure out the
> possible call paths, but it seems we can use stack_depot_early_init() for
> SLUB debugging case. I'll try to come up with something Really Soon (tm).

Yeah as you already noticed, we are pursuing an approach to decide on
calling stack_depot_early_init(), which should be a good way to solve this
given how special slab is in this case. For memblock I just wanted to point
out that it could be more robust, your patch below seems to be on the right
patch. Maybe it just doesn't have to fallback to buddy, which could be
considered a layering violation, but just return NULL that can be
immediately recognized as an error?

> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 50ad19662a32..4ea89d44d22a 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -90,6 +90,7 @@ struct memblock_type {
>   */
>  struct memblock {
>  	bool bottom_up;  /* is bottom up direction? */
> +	bool mem_freed;
>  	phys_addr_t current_limit;
>  	struct memblock_type memory;
>  	struct memblock_type reserved;
> diff --git a/mm/memblock.c b/mm/memblock.c
> index b12a364f2766..60196dc4980e 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -120,6 +120,7 @@ struct memblock memblock __initdata_memblock = {
>  	.reserved.name		= "reserved",
>  
>  	.bottom_up		= false,
> +	.mem_freed		= false,
>  	.current_limit		= MEMBLOCK_ALLOC_ANYWHERE,
>  };
>  
> @@ -1487,6 +1488,13 @@ static void * __init memblock_alloc_internal(
>  	if (WARN_ON_ONCE(slab_is_available()))
>  		return kzalloc_node(size, GFP_NOWAIT, nid);
>  
> +	if (memblock.mem_freed) {
> +		unsigned int order = get_order(size);
> +
> +		pr_warn("memblock: allocating from buddy\n");
> +		return __alloc_pages_node(nid, order, GFP_KERNEL);
> +	}
> +
>  	if (max_addr > memblock.current_limit)
>  		max_addr = memblock.current_limit;
>  
> @@ -2116,6 +2124,7 @@ void __init memblock_free_all(void)
>  
>  	pages = free_low_memory_core_early();
>  	totalram_pages_add(pages);
> +	memblock.mem_freed = true;
>  }
>  
>  #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_ARCH_KEEP_MEMBLOCK)
>  
>> > Hyeonggon, did you run your tests with panic on warn at any chance?
>> >  
>> >> > Thanks!
>> >> > 
>> >> > /*
>> >> >  * Set up kernel memory allocators
>> >> >  */
>> >> > static void __init mm_init(void)
>> >> > {
>> >> >         /*
>> >> >          * page_ext requires contiguous pages,
>> >> >          * bigger than MAX_ORDER unless SPARSEMEM.
>> >> >          */
>> >> >         page_ext_init_flatmem();
>> >> >         init_mem_debugging_and_hardening();
>> >> >         kfence_alloc_pool();
>> >> >         report_meminit();
>> >> >         stack_depot_early_init();
>> >> >         mem_init();
>> >> >         mem_init_print_info();
>> >> >         kmem_cache_init();
>> >> >         /*
>> >> >          * page_owner must be initialized after buddy is ready, and also after
>> >> >          * slab is ready so that stack_depot_init() works properly
>> >> >          */)
>> >> > 
>> >> >> Patch 1 is a new preparatory cleanup.
>> >> >> 
>> >> >> Patch 2 originally submitted here [1], was merged to mainline but
>> >> >> reverted for stackdepot related issues as explained in the patch.
>> >> >> 
>> >> >> Patches 3-5 originally submitted as RFC here [2]. In this submission I
>> >> >> have omitted the new file 'all_objects' (patch 3/3 in [2]) as it might
>> >> >> be considered too intrusive so I will postpone it for later. The docs
>> >> >> patch is adjusted accordingly.
>> >> >> 
>> >> >> Also available in git, based on v5.17-rc1:
>> >> >> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-stackdepot-v1
>> >> >> 
>> >> >> I'd like to ask for some review before I add this to the slab tree.
>> >> >> 
>> >> >> [1] https://lore.kernel.org/all/20210414163434.4376-1-glittao@gmail.com/
>> >> >> [2] https://lore.kernel.org/all/20210521121127.24653-1-glittao@gmail.com/
>> >> >> 
>> >> >> Oliver Glitta (4):
>> >> >>   mm/slub: use stackdepot to save stack trace in objects
>> >> >>   mm/slub: aggregate and print stack traces in debugfs files
>> >> >>   mm/slub: sort debugfs output by frequency of stack traces
>> >> >>   slab, documentation: add description of debugfs files for SLUB caches
>> >> >> 
>> >> >> Vlastimil Babka (1):
>> >> >>   mm/slub: move struct track init out of set_track()
>> >> >> 
>> >> >>  Documentation/vm/slub.rst |  61 +++++++++++++++
>> >> >>  init/Kconfig              |   1 +
>> >> >>  mm/slub.c                 | 152 +++++++++++++++++++++++++-------------
>> >> >>  3 files changed, 162 insertions(+), 52 deletions(-)
>> >> >> 
>> >> >> -- 
>> >> >> 2.35.1
>> >> >> 
>> >> >> 
>> >> > 
>> >> 
>> > 
>> 
> 

