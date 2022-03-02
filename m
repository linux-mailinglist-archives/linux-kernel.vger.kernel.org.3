Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266884CA05B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 10:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240367AbiCBJKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 04:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240358AbiCBJKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:10:22 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E49B82F8
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 01:09:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1ED8E21991;
        Wed,  2 Mar 2022 09:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646212178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v+CJOTOD4n7/OSSm073QF8ULoWYfiH4GzE5utXJnhxA=;
        b=oD83E4vsqXcSYoJNs6mRPFvLd5ik2FsCH6wAEbZDKRYSB3S8Tg0EsvFkVSwbfvOb+It4sn
        KxdAN2XxMcBG5bDaLQJ2+jbBh6r4/VamLm5/F6taZn2sGdiCI6rJaCkuvlk6Rn1s1xrqPJ
        71ksSdOrEk2GotWCREp7ZdZqpPEigWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646212178;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v+CJOTOD4n7/OSSm073QF8ULoWYfiH4GzE5utXJnhxA=;
        b=tbETP8MJoXoBANx3DZ02m94JinwzFvQyiFW421CBLBOFkk9Clo4I7VJubxuwEMyZGfTimy
        HNCUOupVS4B8EfDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE49813345;
        Wed,  2 Mar 2022 09:09:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id u5OBMVE0H2LhVgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 02 Mar 2022 09:09:37 +0000
Message-ID: <024aacf5-ac49-7d04-7293-1e1451ff9029@suse.cz>
Date:   Wed, 2 Mar 2022 10:09:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 0/5] SLUB debugfs improvements based on stackdepot
Content-Language: en-US
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     David Rientjes <rientjes@google.com>,
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
 <Yh0+Jld+sDy1Hkdb@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <Yh8szz+UxqddwK7j@linux.ibm.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Yh8szz+UxqddwK7j@linux.ibm.com>
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

On 3/2/22 09:37, Mike Rapoport wrote:
> On Mon, Feb 28, 2022 at 09:27:02PM +0000, Hyeonggon Yoo wrote:
>> On Mon, Feb 28, 2022 at 08:10:18PM +0100, Vlastimil Babka wrote:
>> > On 2/26/22 08:19, Hyeonggon Yoo wrote:
>> > > On Fri, Feb 25, 2022 at 07:03:13PM +0100, Vlastimil Babka wrote:
>> > >> Hi,
>> > >> 
>> > >> this series combines and revives patches from Oliver's last year
>> > >> bachelor thesis (where I was the advisor) that make SLUB's debugfs
>> > >> files alloc_traces and free_traces more useful.
>> > >> The resubmission was blocked on stackdepot changes that are now merged,
>> > >> as explained in patch 2.
>> > >> 
>> > > 
>> > > Hello. I just started review/testing this series.
>> > > 
>> > > it crashed on my system (arm64)
>> > 
>> > Hmm, interesting. On x86_64 this works for me and stackdepot is allocated
>> > from memblock. arm64 must have memblock freeing happen earlier or something.
>> > (CCing memblock experts)
>> > 
>> > > I ran with boot parameter slub_debug=U, and without KASAN.
>> > > So CONFIG_STACKDEPOT_ALWAYS_INIT=n.
>> > > 
>> > > void * __init memblock_alloc_try_nid(
>> > >                         phys_addr_t size, phys_addr_t align,
>> > >                         phys_addr_t min_addr, phys_addr_t max_addr,
>> > >                         int nid)
>> > > {
>> > >         void *ptr;
>> > > 
>> > >         memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa %pS\n",
>> > >                      __func__, (u64)size, (u64)align, nid, &min_addr,
>> > >                      &max_addr, (void *)_RET_IP_);
>> > >         ptr = memblock_alloc_internal(size, align,
>> > >                                            min_addr, max_addr, nid, false);
>> > >         if (ptr)
>> > >                 memset(ptr, 0, size); <--- Crash Here
>> > > 
>> > >         return ptr;
>> > > }
>> > > 
>> > > It crashed during create_boot_cache() -> stack_depot_init() ->
>> > > memblock_alloc().
>> > > 
>> > > I think That's because, in kmem_cache_init(), both slab and memblock is not
>> > > available. (AFAIU memblock is not available after mem_init() because of
>> > > memblock_free_all(), right?)
>> > 
>> > Hm yes I see, even in x86_64 version mem_init() calls memblock_free_all().
>> > But then, I would expect stack_depot_init() to detect that memblock_alloc()
>> > returns NULL, we print ""Stack Depot hash table allocation failed,
>> > disabling" and disable it. Instead it seems memblock_alloc() returns
>> > something that's already potentially used by somebody else? Sounds like a bug?
>> 
>> 
>> By the way, I fixed this by allowing stack_depot_init() to be called in
>> kmem_cache_init() too [1] and Marco suggested that calling
>> stack_depot_init() depending on slub_debug parameter for simplicity. [2]
>> 
>> I would prefer [2], Would you take a look?
>> 
>> [1] https://lkml.org/lkml/2022/2/27/31
>> 
>> [2] https://lkml.org/lkml/2022/2/28/717
> 
> I have the third version :)

While simple, it changes the timing of stack_depot_early_init() that was
supposed to be at a single callsite - now it's less predictable and depends
on e.g. kernel parameter ordering. Some arch/config combo could break,
dunno. Setting a variable that stack_depot_early_init() checks should be
more robust.

> 
> diff --git a/mm/slub.c b/mm/slub.c
> index a74afe59a403..0c3ab2335b46 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1548,6 +1548,10 @@ static int __init setup_slub_debug(char *str)
>  	}
>  out:
>  	slub_debug = global_flags;
> +
> +	if (slub_flags & SLAB_STORE_USER && IS_ENABLED(CONFIG_STACKDEPOT))
> +		stack_depot_early_init();
> +
>  	if (slub_debug != 0 || slub_debug_string)
>  		static_branch_enable(&slub_debug_enabled);
>  	else
> @@ -4221,9 +4225,6 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
>  	s->remote_node_defrag_ratio = 1000;
>  #endif
>  
> -	if (s->flags & SLAB_STORE_USER && IS_ENABLED(CONFIG_STACKDEPOT))
> -		stack_depot_init();
> -
>  	/* Initialize the pre-computed randomized freelist if slab is up */
>  	if (slab_state >= UP) {
>  		if (init_cache_random_seq(s))
>  
>> -- 
>> Thank you, You are awesome!
>> Hyeonggon :-)
> 

