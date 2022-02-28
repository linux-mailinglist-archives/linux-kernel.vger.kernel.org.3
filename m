Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614A54C7BC2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 22:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiB1VVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 16:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiB1VVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:21:13 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222D9EF798
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 13:20:32 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id s1so11791824plg.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 13:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6j4iszzj0cZB59eyvH7KEYjUiOAtYTKI6HW7ZxtRKCc=;
        b=j7cqxe9dxOnSEyontZOrJTyHnCh8VoPiQ1ztMVKNiiwQbNROJv2abR4woQbmuJOnnJ
         CkH68B50DbTfDtfedwYpIipLJFiCnhnhWat3ZbcCgwCU0PLFsLeHiRYiMMGzyAXph5aJ
         oY285bDUElEYgc7S6ZzsXPxjiR7r+7tKeCm/W0T4NhWHRIqnjcNjpTaaI4vH0xika2u6
         vH9VibDy7ZEyiN3yMxqHClKT5ADdNQcwdetTO3rkLHLwMYtPb2nj4WV3s/zHbtXMCNTZ
         Ns2lx12jHz+9QVTq1ccTJ2JiUYKPFlH+fueJ9E3jZUxpph1f9qbr28h9AmWHvxGwfByd
         6X3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6j4iszzj0cZB59eyvH7KEYjUiOAtYTKI6HW7ZxtRKCc=;
        b=fCPXCPzbwTrZxJO2IZoedj3ccYVOmL9mv8l0818lmoy4WsLWgYjUa9H5paaT+MSi96
         DScGVrMN1j7cewvYtYFJEzpXoTik1bSLcQq0RVSAavFeXKd8gFyppy/tY79XLc9VbEtb
         U1M2cfGqoMNV0T39/vPte8z6Et/CpTeGjYOGE82ScDwvEdkY4HWxCNb0yniJ4W4myZvp
         +WYD6Cz1WEAiNOGq+7Eyzl0MHLGLttQD1uzhp0Lgp8UZ/46cW8PGzewCd7FMPfQwtL8h
         4BapBsGRUlJ5SJcfuqB6xTPCHAJbZwqV8+peKXsWMgCvXZrk9Tw83mwJUN8imAYDbRlh
         o78g==
X-Gm-Message-State: AOAM530iZz/4H0rFKm6z9O1oXy5qBnjRe6gZU6eSbI87p3GxZvnVlDIi
        XFSivOPO6AqU2AgUYoLg4B4=
X-Google-Smtp-Source: ABdhPJzlNCgdWKxkzYFD0xDIOBCeBV4wyCFJ101m9eyB0Tp1qAP2XRYbfGZwyqA7E8+cLWJ5uKT/Tw==
X-Received: by 2002:a17:90a:5293:b0:1bc:a544:a638 with SMTP id w19-20020a17090a529300b001bca544a638mr18650367pjh.174.1646083232293;
        Mon, 28 Feb 2022 13:20:32 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id y16-20020a056a00191000b004e155b2623bsm15105219pfi.178.2022.02.28.13.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 13:20:31 -0800 (PST)
Date:   Mon, 28 Feb 2022 21:20:26 +0000
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
Message-ID: <Yh08mp/q7vBUEl3V@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <20220225180318.20594-1-vbabka@suse.cz>
 <YhnUcqyeMgCrWZbd@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <f194f876-1c46-f3ae-573e-d3ddd6dcf4cc@suse.cz>
 <Yh0qGY48JeH7TzdQ@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh0qGY48JeH7TzdQ@linux.ibm.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 10:01:29PM +0200, Mike Rapoport wrote:
> On Mon, Feb 28, 2022 at 08:10:18PM +0100, Vlastimil Babka wrote:
> > On 2/26/22 08:19, Hyeonggon Yoo wrote:
> > > On Fri, Feb 25, 2022 at 07:03:13PM +0100, Vlastimil Babka wrote:
> > >> Hi,
> > >> 
> > >> this series combines and revives patches from Oliver's last year
> > >> bachelor thesis (where I was the advisor) that make SLUB's debugfs
> > >> files alloc_traces and free_traces more useful.
> > >> The resubmission was blocked on stackdepot changes that are now merged,
> > >> as explained in patch 2.
> > >> 
> > > 
> > > Hello. I just started review/testing this series.
> > > 
> > > it crashed on my system (arm64)
> > 
> > Hmm, interesting. On x86_64 this works for me and stackdepot is allocated
> > from memblock. arm64 must have memblock freeing happen earlier or something.
> > (CCing memblock experts)
> > 
> > > I ran with boot parameter slub_debug=U, and without KASAN.
> > > So CONFIG_STACKDEPOT_ALWAYS_INIT=n.
> > > 
> > > void * __init memblock_alloc_try_nid(
> > >                         phys_addr_t size, phys_addr_t align,
> > >                         phys_addr_t min_addr, phys_addr_t max_addr,
> > >                         int nid)
> > > {
> > >         void *ptr;
> > > 
> > >         memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa %pS\n",
> > >                      __func__, (u64)size, (u64)align, nid, &min_addr,
> > >                      &max_addr, (void *)_RET_IP_);
> > >         ptr = memblock_alloc_internal(size, align,
> > >                                            min_addr, max_addr, nid, false);
> > >         if (ptr)
> > >                 memset(ptr, 0, size); <--- Crash Here
> > > 
> > >         return ptr;
> > > }
> > > 
> > > It crashed during create_boot_cache() -> stack_depot_init() ->
> > > memblock_alloc().
> > > 
> > > I think That's because, in kmem_cache_init(), both slab and memblock is not
> > > available. (AFAIU memblock is not available after mem_init() because of
> > > memblock_free_all(), right?)
> > 
> > Hm yes I see, even in x86_64 version mem_init() calls memblock_free_all().
> > But then, I would expect stack_depot_init() to detect that memblock_alloc()
> > returns NULL, we print ""Stack Depot hash table allocation failed,
> > disabling" and disable it. Instead it seems memblock_alloc() returns
> > something that's already potentially used by somebody else? Sounds like a bug?
> 

It's really weird, but memblock_alloc() did not fail after
memblock_free_all(). it just crashed while initializing memory returned
by memblock.

> If stack_depot_init() is called from kmem_cache_init(), there will be a
> confusion what allocator should be used because we use slab_is_available()
> to stop using memblock and start using kmalloc() instead in both
> stack_depot_init() and in memblock.
> 
> Hyeonggon, did you run your tests with panic on warn at any chance?
>

Yeah, I think this stack trace would help:

[    0.000000] Stack Depot allocating hash table with memblock_alloc
[    0.000000] Unable to handle kernel paging request at virtual address ffff000097400000
[    0.000000] Mem abort info:
[    0.000000]   ESR = 0x96000047
[    0.000000]   EC = 0x25: DABT (current EL), IL = 32 bits
[    0.000000]   SET = 0, FnV = 0
[    0.000000]   EA = 0, S1PTW = 0
[    0.000000]   FSC = 0x07: level 3 translation fault
[    0.000000] Data abort info:
[    0.000000]   ISV = 0, ISS = 0x00000047
[    0.000000]   CM = 0, WnR = 1
[    0.000000] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000041719000
[    0.000000] [ffff000097400000] pgd=18000000dcff8003, p4d=18000000dcff8003, pud=18000000dcbfe003, pmd=18000000dcb43003, pte=00680000d7400706
[    0.000000] Internal error: Oops: 96000047 [#1] PREEMPT SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.17.0-rc1-11918-gbf5d03166d75 #51
[    0.000000] Hardware name: linux,dummy-virt (DT)
[    0.000000] pstate: 400000c5 (nZcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.000000] pc : __memset+0x16c/0x188
[    0.000000] lr : memblock_alloc_try_nid+0xcc/0xe4
[    0.000000] sp : ffff800009a33cd0
[    0.000000] x29: ffff800009a33cd0 x28: 0000000041720018 x27: ffff800009362640
[    0.000000] x26: ffff800009362640 x25: 0000000000000000 x24: 0000000000000000
[    0.000000] x23: 0000000000002000 x22: ffff80000932bb50 x21: 00000000ffffffff
[    0.000000] x20: ffff000097400000 x19: 0000000000800000 x18: ffffffffffffffff
[    0.000000] x17: 373578302f383278 x16: 302b657461657263 x15: 0000001000000000
[    0.000000] x14: 0000000000000360 x13: 0000000000009f8c x12: 00000000dcb0c070
[    0.000000] x11: 0000001000000000 x10: 00000000004ea000 x9 : 0000000000000000
[    0.000000] x8 : ffff000097400000 x7 : 0000000000000000 x6 : 000000000000003f
[    0.000000] x5 : 0000000000000040 x4 : 0000000000000000 x3 : 0000000000000004
[    0.000000] x2 : 00000000007fffc0 x1 : 0000000000000000 x0 : ffff000097400000
[    0.000000] Call trace:
[    0.000000]  __memset+0x16c/0x188
[    0.000000]  stack_depot_init+0xc8/0x100
[    0.000000]  __kmem_cache_create+0x454/0x570
[    0.000000]  create_boot_cache+0xa0/0xe0
[    0.000000]  kmem_cache_init+0xf8/0x204
[    0.000000]  start_kernel+0x3ec/0x668
[    0.000000]  __primary_switched+0xc0/0xc8
[    0.000000] Code: 91010108 54ffff4a 8b040108 cb050042 (d50b7428)
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---


Thanks!

> > > Thanks!
> > > 
> > > /*
> > >  * Set up kernel memory allocators
> > >  */
> > > static void __init mm_init(void)
> > > {
> > >         /*
> > >          * page_ext requires contiguous pages,
> > >          * bigger than MAX_ORDER unless SPARSEMEM.
> > >          */
> > >         page_ext_init_flatmem();
> > >         init_mem_debugging_and_hardening();
> > >         kfence_alloc_pool();
> > >         report_meminit();
> > >         stack_depot_early_init();
> > >         mem_init();
> > >         mem_init_print_info();
> > >         kmem_cache_init();
> > >         /*
> > >          * page_owner must be initialized after buddy is ready, and also after
> > >          * slab is ready so that stack_depot_init() works properly
> > >          */)
> > > 
> > >> Patch 1 is a new preparatory cleanup.
> > >> 
> > >> Patch 2 originally submitted here [1], was merged to mainline but
> > >> reverted for stackdepot related issues as explained in the patch.
> > >> 
> > >> Patches 3-5 originally submitted as RFC here [2]. In this submission I
> > >> have omitted the new file 'all_objects' (patch 3/3 in [2]) as it might
> > >> be considered too intrusive so I will postpone it for later. The docs
> > >> patch is adjusted accordingly.
> > >> 
> > >> Also available in git, based on v5.17-rc1:
> > >> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-stackdepot-v1
> > >> 
> > >> I'd like to ask for some review before I add this to the slab tree.
> > >> 
> > >> [1] https://lore.kernel.org/all/20210414163434.4376-1-glittao@gmail.com/
> > >> [2] https://lore.kernel.org/all/20210521121127.24653-1-glittao@gmail.com/
> > >> 
> > >> Oliver Glitta (4):
> > >>   mm/slub: use stackdepot to save stack trace in objects
> > >>   mm/slub: aggregate and print stack traces in debugfs files
> > >>   mm/slub: sort debugfs output by frequency of stack traces
> > >>   slab, documentation: add description of debugfs files for SLUB caches
> > >> 
> > >> Vlastimil Babka (1):
> > >>   mm/slub: move struct track init out of set_track()
> > >> 
> > >>  Documentation/vm/slub.rst |  61 +++++++++++++++
> > >>  init/Kconfig              |   1 +
> > >>  mm/slub.c                 | 152 +++++++++++++++++++++++++-------------
> > >>  3 files changed, 162 insertions(+), 52 deletions(-)
> > >> 
> > >> -- 
> > >> 2.35.1
> > >> 
> > >> 
> > > 
> > 
> 
> -- 
> Sincerely yours,
> Mike.

-- 
Thank you, You are awesome!
Hyeonggon :-)
