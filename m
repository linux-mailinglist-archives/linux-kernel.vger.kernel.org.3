Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763BC4C7BEF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 22:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiB1V1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 16:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiB1V1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:27:49 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737A6122216
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 13:27:08 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id gl14-20020a17090b120e00b001bc2182c3d5so356908pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 13:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TrpS+67FSlQddGwDdOi9w+ACBG5gdUCC1hh0gQpLGAY=;
        b=FhWodKreUKlKomxPwKATYPgLmZQmVpfJ5p7j2iyU0G2dzYavbYhY9Dsjh93cnWeD/6
         EbyCUbux0xwmuMRD2GAtrzQe824sH9OCGea5TgvuvMjnZPZx6JPMZUIs4VaiDyBKxk8O
         yL0jVjfiLqJWy1VURLkJbtamSkJGpPYqntCLhnKj+aPFzl/Rla/B5FvmVThxgFj0fAeJ
         P5OihMmyKQXBiBiCXgbeRyD5m9cnP7T6TT7oBCA0o3+QUeTcCtweBDEe9WYSQR2Ux3cC
         wxd76R1UTrI32mpz28eVNaig6lKIfRSF17izSNL9OZGHCC9k/bKcado65wlgkoLnOVhc
         ytLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TrpS+67FSlQddGwDdOi9w+ACBG5gdUCC1hh0gQpLGAY=;
        b=Ij85QUvGGN5lf9FeQzbU7HDC7r23VHouCV4ovocTqULP+emS1ZQMcSiT4vWq1Yth1N
         KMNlX3wG8H+Qz1a0plmonq75wksrd7P0ToK7hS/VL4ZwaB/hFzn8BJU3gVhu8Nr8Vqnx
         Vwq+vzNb5ySiBotg5dKj50PrYoUGk1t2nQMnHhGmqKwmG0uh0kwpX355Pc8ZVsDT3EMy
         kPT/AwFEudkHE5DEItRkytMU2fAkUV/vmhP4bpsytxFe0iJLN61cnPSyEHrg3IaTJrjo
         3Wne4UNOwtGrOMMwC9L+2uSDy9wHdXatRRqbCvE8Kbo6xyvTp5zy2SmCtqlepkjDl/Xu
         XlwA==
X-Gm-Message-State: AOAM531tDmHkNU5syEMUs/LlhgV4UXc4MSPslWpF3qZLo1GXJetUWNTB
        mckmr3OGXRIOOvXuXiB5WEk=
X-Google-Smtp-Source: ABdhPJwkbr7Fu+Il5U9r7qVubGsHTewbcYPuorR2WUujTDJyNxE2/EwwkNu9J3flXwuQZFvgwVquQg==
X-Received: by 2002:a17:90a:7147:b0:1bd:24ac:13bd with SMTP id g7-20020a17090a714700b001bd24ac13bdmr11744633pjs.70.1646083627969;
        Mon, 28 Feb 2022 13:27:07 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id q24-20020aa79618000000b004e0e89985eesm13725359pfg.156.2022.02.28.13.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 13:27:07 -0800 (PST)
Date:   Mon, 28 Feb 2022 21:27:02 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
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
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 0/5] SLUB debugfs improvements based on stackdepot
Message-ID: <Yh0+Jld+sDy1Hkdb@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <20220225180318.20594-1-vbabka@suse.cz>
 <YhnUcqyeMgCrWZbd@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <f194f876-1c46-f3ae-573e-d3ddd6dcf4cc@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f194f876-1c46-f3ae-573e-d3ddd6dcf4cc@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 08:10:18PM +0100, Vlastimil Babka wrote:
> On 2/26/22 08:19, Hyeonggon Yoo wrote:
> > On Fri, Feb 25, 2022 at 07:03:13PM +0100, Vlastimil Babka wrote:
> >> Hi,
> >> 
> >> this series combines and revives patches from Oliver's last year
> >> bachelor thesis (where I was the advisor) that make SLUB's debugfs
> >> files alloc_traces and free_traces more useful.
> >> The resubmission was blocked on stackdepot changes that are now merged,
> >> as explained in patch 2.
> >> 
> > 
> > Hello. I just started review/testing this series.
> > 
> > it crashed on my system (arm64)
> 
> Hmm, interesting. On x86_64 this works for me and stackdepot is allocated
> from memblock. arm64 must have memblock freeing happen earlier or something.
> (CCing memblock experts)
> 
> > I ran with boot parameter slub_debug=U, and without KASAN.
> > So CONFIG_STACKDEPOT_ALWAYS_INIT=n.
> > 
> > void * __init memblock_alloc_try_nid(
> >                         phys_addr_t size, phys_addr_t align,
> >                         phys_addr_t min_addr, phys_addr_t max_addr,
> >                         int nid)
> > {
> >         void *ptr;
> > 
> >         memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa %pS\n",
> >                      __func__, (u64)size, (u64)align, nid, &min_addr,
> >                      &max_addr, (void *)_RET_IP_);
> >         ptr = memblock_alloc_internal(size, align,
> >                                            min_addr, max_addr, nid, false);
> >         if (ptr)
> >                 memset(ptr, 0, size); <--- Crash Here
> > 
> >         return ptr;
> > }
> > 
> > It crashed during create_boot_cache() -> stack_depot_init() ->
> > memblock_alloc().
> > 
> > I think That's because, in kmem_cache_init(), both slab and memblock is not
> > available. (AFAIU memblock is not available after mem_init() because of
> > memblock_free_all(), right?)
> 
> Hm yes I see, even in x86_64 version mem_init() calls memblock_free_all().
> But then, I would expect stack_depot_init() to detect that memblock_alloc()
> returns NULL, we print ""Stack Depot hash table allocation failed,
> disabling" and disable it. Instead it seems memblock_alloc() returns
> something that's already potentially used by somebody else? Sounds like a bug?


By the way, I fixed this by allowing stack_depot_init() to be called in
kmem_cache_init() too [1] and Marco suggested that calling
stack_depot_init() depending on slub_debug parameter for simplicity. [2]

I would prefer [2], Would you take a look?

[1] https://lkml.org/lkml/2022/2/27/31

[2] https://lkml.org/lkml/2022/2/28/717

> > Thanks!
> > 
> > /*
> >  * Set up kernel memory allocators
> >  */
> > static void __init mm_init(void)
> > {
> >         /*
> >          * page_ext requires contiguous pages,
> >          * bigger than MAX_ORDER unless SPARSEMEM.
> >          */
> >         page_ext_init_flatmem();
> >         init_mem_debugging_and_hardening();
> >         kfence_alloc_pool();
> >         report_meminit();
> >         stack_depot_early_init();
> >         mem_init();
> >         mem_init_print_info();
> >         kmem_cache_init();
> >         /*
> >          * page_owner must be initialized after buddy is ready, and also after
> >          * slab is ready so that stack_depot_init() works properly
> >          */)
> > 
> >> Patch 1 is a new preparatory cleanup.
> >> 
> >> Patch 2 originally submitted here [1], was merged to mainline but
> >> reverted for stackdepot related issues as explained in the patch.
> >> 
> >> Patches 3-5 originally submitted as RFC here [2]. In this submission I
> >> have omitted the new file 'all_objects' (patch 3/3 in [2]) as it might
> >> be considered too intrusive so I will postpone it for later. The docs
> >> patch is adjusted accordingly.
> >> 
> >> Also available in git, based on v5.17-rc1:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-stackdepot-v1
> >> 
> >> I'd like to ask for some review before I add this to the slab tree.
> >> 
> >> [1] https://lore.kernel.org/all/20210414163434.4376-1-glittao@gmail.com/
> >> [2] https://lore.kernel.org/all/20210521121127.24653-1-glittao@gmail.com/
> >> 
> >> Oliver Glitta (4):
> >>   mm/slub: use stackdepot to save stack trace in objects
> >>   mm/slub: aggregate and print stack traces in debugfs files
> >>   mm/slub: sort debugfs output by frequency of stack traces
> >>   slab, documentation: add description of debugfs files for SLUB caches
> >> 
> >> Vlastimil Babka (1):
> >>   mm/slub: move struct track init out of set_track()
> >> 
> >>  Documentation/vm/slub.rst |  61 +++++++++++++++
> >>  init/Kconfig              |   1 +
> >>  mm/slub.c                 | 152 +++++++++++++++++++++++++-------------
> >>  3 files changed, 162 insertions(+), 52 deletions(-)
> >> 
> >> -- 
> >> 2.35.1
> >> 
> >> 
> > 
> 

-- 
Thank you, You are awesome!
Hyeonggon :-)
