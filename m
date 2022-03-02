Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF424CAB11
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237931AbiCBRDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243627AbiCBRDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:03:21 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D0C38BA
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:02:34 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id z4so2135881pgh.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 09:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aFBenmLELYH06vT94XgM8M/suz0iqKEdtwlDD+II77s=;
        b=MIrwJeWFSSc0zi6jRMv6Z5XZytCaUDfDd+KrBC85ZR/zGoBE8vbJaEqfNNw4aaHPlx
         f51itcDv0dlQH9Yx3+soH4uz5oajDcj8OwHgo/wvdrSxwREKDGiVGd0L/9zz3t8cKzS0
         Ck20cqRNzaz2EsrbBsC1rnyKNb+LlLGg0VM63/gFMONgaQx0uDU6umLQLciK3hjgVpNk
         4HdSEBo2MWVoNqk9K8kJ7+N9ez5keRV7d54wUJrodhAinOvcAqCHaM0jxHUKtQA2iUQ/
         WXT3q8suMzSu9E9UgRODeO28r/cRIk7rF1OrwklIuqUWqOWAwfVWHpuwNjE9kQ8eGv0Q
         v2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aFBenmLELYH06vT94XgM8M/suz0iqKEdtwlDD+II77s=;
        b=e9s/Vwzmu7AnwIsz0QYbjfs6MMp+AnGDfM+hFIvDGUaVodol/2hZQK2Q0e/i0vCVhy
         IN9SiS8/bz0sX7kRxmUKC1yt+NBcDAYxIs+LlBBaX/tfma6hJwOdayyDRdl7FsQzLoI8
         FjoxXCxBJCc0AoyKXbO72wxzIPaZX3Nmwx/hcgUyk8gQGECAYFQsCdApJDdoDUgGdBSA
         ykw7W75mr9VBNJhGOyKz2iig+/mplai0C7ZoIURqIysJiE5laBN7A5qdQ6XDVSNT0OkR
         VC/ojz6bugl73zuaBuoowt7UMD3xeXUXt8S77iSR79uwhkpzHm/sPZmSlVGfkFfXQ10M
         +BWA==
X-Gm-Message-State: AOAM530y01G5evS9q+P6FB9CbDym2p2waMMFGUdR+qvYvq+8f9FCG4mw
        ySQmAAN8wIz05MVHe139a/I=
X-Google-Smtp-Source: ABdhPJzczjtlZOIEZK+1kKkYRKRNKIaq5+two8ZxS/0cFE2Jb4IcM/0xXdF1gbtDdRX00XLh9qtGrQ==
X-Received: by 2002:a05:6a00:984:b0:4e1:5e1b:1e9b with SMTP id u4-20020a056a00098400b004e15e1b1e9bmr33793258pfg.71.1646240553958;
        Wed, 02 Mar 2022 09:02:33 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id j6-20020a056a00174600b004f3e5d344b9sm18208007pfc.194.2022.03.02.09.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:02:33 -0800 (PST)
Date:   Wed, 2 Mar 2022 17:02:28 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
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
Subject: Re: [PATCH 0/5] SLUB debugfs improvements based on stackdepot
Message-ID: <Yh+jJC8JofHx28K+@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <20220225180318.20594-1-vbabka@suse.cz>
 <YhnUcqyeMgCrWZbd@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <f194f876-1c46-f3ae-573e-d3ddd6dcf4cc@suse.cz>
 <Yh0+Jld+sDy1Hkdb@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <Yh8szz+UxqddwK7j@linux.ibm.com>
 <024aacf5-ac49-7d04-7293-1e1451ff9029@suse.cz>
 <Yh9jgGOocmU3WsES@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh9jgGOocmU3WsES@linux.ibm.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 02:30:56PM +0200, Mike Rapoport wrote:
> On Wed, Mar 02, 2022 at 10:09:37AM +0100, Vlastimil Babka wrote:
> > On 3/2/22 09:37, Mike Rapoport wrote:
> > > On Mon, Feb 28, 2022 at 09:27:02PM +0000, Hyeonggon Yoo wrote:
> > >> On Mon, Feb 28, 2022 at 08:10:18PM +0100, Vlastimil Babka wrote:
> > >> > On 2/26/22 08:19, Hyeonggon Yoo wrote:
> > >> > > On Fri, Feb 25, 2022 at 07:03:13PM +0100, Vlastimil Babka wrote:
> > >> > >> Hi,
> > >> > >> 
> > >> > >> this series combines and revives patches from Oliver's last year
> > >> > >> bachelor thesis (where I was the advisor) that make SLUB's debugfs
> > >> > >> files alloc_traces and free_traces more useful.
> > >> > >> The resubmission was blocked on stackdepot changes that are now merged,
> > >> > >> as explained in patch 2.
> > >> > >> 
> > >> > > 
> > >> > > Hello. I just started review/testing this series.
> > >> > > 
> > >> > > it crashed on my system (arm64)
> > >> > 
> > >> > Hmm, interesting. On x86_64 this works for me and stackdepot is allocated
> > >> > from memblock. arm64 must have memblock freeing happen earlier or something.
> > >> > (CCing memblock experts)
> > >> > 
> > >> > > I ran with boot parameter slub_debug=U, and without KASAN.
> > >> > > So CONFIG_STACKDEPOT_ALWAYS_INIT=n.
> > >> > > 
> > >> > > void * __init memblock_alloc_try_nid(
> > >> > >                         phys_addr_t size, phys_addr_t align,
> > >> > >                         phys_addr_t min_addr, phys_addr_t max_addr,
> > >> > >                         int nid)
> > >> > > {
> > >> > >         void *ptr;
> > >> > > 
> > >> > >         memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa %pS\n",
> > >> > >                      __func__, (u64)size, (u64)align, nid, &min_addr,
> > >> > >                      &max_addr, (void *)_RET_IP_);
> > >> > >         ptr = memblock_alloc_internal(size, align,
> > >> > >                                            min_addr, max_addr, nid, false);
> > >> > >         if (ptr)
> > >> > >                 memset(ptr, 0, size); <--- Crash Here
> > >> > > 
> > >> > >         return ptr;
> > >> > > }
> > >> > > 
> > >> > > It crashed during create_boot_cache() -> stack_depot_init() ->
> > >> > > memblock_alloc().
> > >> > > 
> > >> > > I think That's because, in kmem_cache_init(), both slab and memblock is not
> > >> > > available. (AFAIU memblock is not available after mem_init() because of
> > >> > > memblock_free_all(), right?)
> > >> > 
> > >> > Hm yes I see, even in x86_64 version mem_init() calls memblock_free_all().
> > >> > But then, I would expect stack_depot_init() to detect that memblock_alloc()
> > >> > returns NULL, we print ""Stack Depot hash table allocation failed,
> > >> > disabling" and disable it. Instead it seems memblock_alloc() returns
> > >> > something that's already potentially used by somebody else? Sounds like a bug?
> > >> 
> > >> 
> > >> By the way, I fixed this by allowing stack_depot_init() to be called in
> > >> kmem_cache_init() too [1] and Marco suggested that calling
> > >> stack_depot_init() depending on slub_debug parameter for simplicity. [2]
> > >> 
> > >> I would prefer [2], Would you take a look?
> > >> 
> > >> [1] https://lkml.org/lkml/2022/2/27/31
> > >> 
> > >> [2] https://lkml.org/lkml/2022/2/28/717
> > > 
> > > I have the third version :)
> > 
> > While simple, it changes the timing of stack_depot_early_init() that was
> > supposed to be at a single callsite - now it's less predictable and depends
> > on e.g. kernel parameter ordering. Some arch/config combo could break,
> > dunno. Setting a variable that stack_depot_early_init() checks should be
> > more robust.
> 
> Not sure I follow.
> stack_depot_early_init() is a wrapper for stack_depot_init() which already
> checks 
> 
> 	if (!stack_depot_disable && !stack_table)
> 
> So largely it can be at multiple call sites just like stack_depot_init...

In my opinion, allowing to call stack_depot_init() in various context is not a good
idea. For another simple example, slub_debug=U,vmap_area can fool the
current code because it's called in context where slab is available,
but vmalloc is unavailable. and stack_depot_init() will try to allocate
using kvmalloc(). Late initialization adds too much complexity.

So IMO we have two solutions.

First solution is only allowing early init and avoiding late init.
(setting a global variable that is visible to stack depot would do this)

And second solution is to make caller allocate and manage its own hash
table. All of this complexity is because we're trying to make stack_table
global.

First solution looks ok if we have few users of stack depot.
But I think we should use second approach if stack depot is growing
more and more callers?

> Still, I understand your concern of having multiple call sites for
> stack_depot_early_init().
> 
> The most robust way I can think of will be to make stack_depot_early_init()
> a proper function, move memblock_alloc() there and add a variable, say
> stack_depot_needed_early that will be set to 1 if
> CONFIG_STACKDEPOT_ALWAYS_INIT=y or by the callers that need to allocate the
> stack_table before kmalloc is up.
>  
> E.g
>
> __init int stack_depot_early_init(void)
> {
> 
> 	if (stack_depot_needed_early && !stack_table) {
> 		size_t size = (STACK_HASH_SIZE * sizeof(struct stack_record *));
> 		int i;
> 
> 		pr_info("Stack Depot allocating hash table with memblock_alloc\n");
> 		stack_table = memblock_alloc(size, SMP_CACHE_BYTES);
> 	
> 		if (!stack_table) {
> 			pr_err("Stack Depot hash table allocation failed, disabling\n");
> 			stack_depot_disable = true;
> 			return -ENOMEM;
> 		}
> 	}
> 
> 	return 0;
> }
>
> The mutex is not needed here because mm_init() -> stack_depot_early_init()
> happens before SMP and setting stack_table[i] to NULL is redundant with
> memblock_alloc(). (btw, kvmalloc case could use __GFP_ZERO as well).
> 
> I'm not sure if the stack depot should be disabled for good if the early
> allocation failed, but that's another story.
> 
> > > diff --git a/mm/slub.c b/mm/slub.c
> > > index a74afe59a403..0c3ab2335b46 100644
> > > --- a/mm/slub.c
> > > +++ b/mm/slub.c
> > > @@ -1548,6 +1548,10 @@ static int __init setup_slub_debug(char *str)
> > >  	}
> > >  out:
> > >  	slub_debug = global_flags;
> > > +
> > > +	if (slub_flags & SLAB_STORE_USER && IS_ENABLED(CONFIG_STACKDEPOT))
> > > +		stack_depot_early_init();
> > > +
> > >  	if (slub_debug != 0 || slub_debug_string)
> > >  		static_branch_enable(&slub_debug_enabled);
> > >  	else
> > > @@ -4221,9 +4225,6 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
> > >  	s->remote_node_defrag_ratio = 1000;
> > >  #endif
> > >  
> > > -	if (s->flags & SLAB_STORE_USER && IS_ENABLED(CONFIG_STACKDEPOT))
> > > -		stack_depot_init();
> > > -
> > >  	/* Initialize the pre-computed randomized freelist if slab is up */
> > >  	if (slab_state >= UP) {
> > >  		if (init_cache_random_seq(s))
> > >  
> > >> -- 
> > >> Thank you, You are awesome!
> > >> Hyeonggon :-)
> > > 
> > 
> 
> -- 
> Sincerely yours,
> Mike.

-- 
Thank you, You are awesome!
Hyeonggon :-)
