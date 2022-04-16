Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1565032CD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiDPEN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 00:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiDPENZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 00:13:25 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4094AF2109
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 21:10:55 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id i34so7434407vsv.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 21:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TrdQDo/FCawgnyLuqOioiW8a9vW4wSQD/OLrLW554Fo=;
        b=qYEZP8fP3sPaifEBGLPVzwgDAs35vAK5AUgLzhPFcvfrWwvLCABIvqjL1oCo2/2THR
         2BPZQm/Ewsw3yGGsMr06RyWfS1JATLixP6NePbakKUijNlsfDoR24+gNNbv//PwC/W6I
         5O6eygLAtZKsZm1sL9NYeAqwYUDuXexnZJwIWUjUqjAU5IgdLo+09ptszWEMVssNATbt
         GLImjJR+5tJZRTOmv9KAvIOxtzCSO8WYdKnjzR/UV3XZe5r1AHQuR/rMWOHURDEioxBK
         6BxyWcCdMCJ1vJduWOHtMUKjRySuTj1pemJDczR8yLDWY9oE6xP7h+ES5qBTfWgPvixf
         RcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TrdQDo/FCawgnyLuqOioiW8a9vW4wSQD/OLrLW554Fo=;
        b=Hj45ndnn6U8c9tmBSHgoNhJvcfsoHeAN7LB/IfAc/sxm9fI766DQlnCNMDA5Bg5eYs
         IIq04O9F+7PN2B+cQGlIDcDHo/8gYIm7LbvVj9RvBmKxW/MimH2kmgdVJP8ZL3wWBqQE
         uUOyJkadgNalklnqf2aPkZoYxEuOQK+EPeBXuDi24k9GszI+ILL0j2qNdNsBlEudIe4D
         0fiNfMV5mus1krE3gRnWyUiEnKatPyu3zTSyAP9lA12MecmsGaTy+qAuuTVYNomuw0dQ
         e0/9Ruu4wCpr06YqGSlRAqO+ksU5qLMDWNgvZQa9BVtdVklN2QNZXJKmHPDF9LbxqYQ2
         0Qsg==
X-Gm-Message-State: AOAM531XMzv3p8u9JBFYZBQcR6Z/4QTQf/uraHNFTpopwnuxhzag46VM
        j2qrtRlJIIstS2ByFZd+j882qBuIudzXwBQBpH1Ywg==
X-Google-Smtp-Source: ABdhPJz6jNob+vgQawQ/3bdTFVwUBWe96kyjwXZYS2m8piV6gPURVEnLjNHxs1GNCSEBsp8hgHNY4egRzD31ZFErnjU=
X-Received: by 2002:a05:6102:5cc:b0:320:9bd2:3823 with SMTP id
 v12-20020a05610205cc00b003209bd23823mr544023vsf.81.1650082254199; Fri, 15 Apr
 2022 21:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
 <20220413235051.3a4eb7c86d31656c7aea250c@linux-foundation.org>
 <20220414135706.rcn7zr36s2hcd5re@revolver> <CAOUHufaw8tZrxuc6Sfxe+ES_MFHBqU_=O+X3b4rbYYrWYJRjkg@mail.gmail.com>
 <20220414171521.bgdvrirumd4atjhs@revolver> <20220414121911.8bb89fc3681b13af1566d79c@linux-foundation.org>
 <YlkaiUopM5HKWEdX@google.com> <20220416010259.4gbz5hgvm2lgr3sj@revolver>
In-Reply-To: <20220416010259.4gbz5hgvm2lgr3sj@revolver>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 15 Apr 2022 22:10:18 -0600
Message-ID: <CAOUHufZ8zPnpamkkpKK6KcSLTF91Eiba+S9VTX-ivhFrPQ_Cpw@mail.gmail.com>
Subject: Re: [PATCH v7 00/70] Introducing the Maple Tree
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 7:03 PM Liam Howlett <liam.howlett@oracle.com> wrote:
>
> * Yu Zhao <yuzhao@google.com> [220415 03:11]:
> > On Thu, Apr 14, 2022 at 12:19:11PM -0700, Andrew Morton wrote:
> > > On Thu, 14 Apr 2022 17:15:26 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:
> > >
> > > > > Also I noticed, for the end address to walk_page_range(), Matthew used
> > > > > -1 and you used ULONG_MAX in the maple branch; Andrew used TASK_SIZE
> > > > > below. Having a single value throughout would be great.
> > > >
> > > > I think ULONG_MAX would be best, we should probably change the below to
> > > > ULONG_MAX.
> > >
> > > I switched it to ULONG_MAX/
> > >
> > > > I don't see the code below in mglru-mapletree (62dd11ea8d).  Am I on the
> > > > right branch/commit?
> > >
> > > oop, sorry, sleepy guy failed to include all the mglru patches!  It
> > > should be fixed now (4e03b8e70232).
> >
> > Hi Liam,
> >
> > Mind taking a look? Thanks.
> >
> > I used
> >   1fe4e0d45c05 (HEAD) mm/vmscan: remove obsolete comment in get_scan_count
> >
> > On aarch64:
> >   arch/arm64/kernel/elfcore.c:120:2: error: no member named 'mmap' in 'struct mm_struct'
> >   arch/arm64/kernel/elfcore.c:120:2: error: no member named 'vm_next' in 'struct vm_area_struct'
> >   arch/arm64/kernel/elfcore.c:130:2: error: no member named 'mmap' in 'struct mm_struct'
> >   arch/arm64/kernel/elfcore.c:130:2: error: no member named 'vm_next' in 'struct vm_area_struct'
> >   arch/arm64/kernel/elfcore.c:13:23: note: expanded from macro 'for_each_mte_vma'
> >   arch/arm64/kernel/elfcore.c:13:45: note: expanded from macro 'for_each_mte_vma'
> >   arch/arm64/kernel/elfcore.c:85:2: error: no member named 'mmap' in 'struct mm_struct'
> >   arch/arm64/kernel/elfcore.c:85:2: error: no member named 'vm_next' in 'struct vm_area_struct'
> >   arch/arm64/kernel/elfcore.c:95:2: error: no member named 'mmap' in 'struct mm_struct'
> >   arch/arm64/kernel/elfcore.c:95:2: error: no member named 'vm_next' in 'struct vm_area_struct'
>
> This was fixed in linux-next by commit 3a4f7ef4bed5 [1].  Using the same
> patch fixes this issue, although I will clean up the define prior to
> inclusion in the patches.

Thanks. With that commit, I was able to build and test on aarch64:

  ==================================================================
  BUG: KASAN: invalid-access in mas_destroy+0x10a4/0x126c
  Read of size 8 at addr 7bffff8015c1a110 by task CompositorTileW/9966
  Pointer tag: [7b], memory tag: [fe]

  CPU: 1 PID: 9966 Comm: CompositorTileW Not tainted 5.18.0-rc2-mm1-lockdep+ #2
  Call trace:
   dump_backtrace+0x1a0/0x200
   show_stack+0x24/0x30
   dump_stack_lvl+0x7c/0xa0
   print_report+0x15c/0x524
   kasan_report+0x84/0xb4
   kasan_tag_mismatch+0x28/0x3c
   __hwasan_tag_mismatch+0x30/0x60
   mas_destroy+0x10a4/0x126c
   mas_nomem+0x40/0xf4
   mas_store_gfp+0x9c/0xfc
   do_mas_align_munmap+0x344/0x688
   do_mas_munmap+0xf8/0x118
   __vm_munmap+0x154/0x1e0
   __arm64_sys_munmap+0x44/0x54
   el0_svc_common+0xfc/0x1cc
   do_el0_svc_compat+0x38/0x5c
   el0_svc_compat+0x68/0x118
   el0t_32_sync_handler+0xc0/0xf0
   el0t_32_sync+0x190/0x194

  Allocated by task 9966:
   kasan_set_track+0x4c/0x7c
   __kasan_slab_alloc+0x84/0xa8
   kmem_cache_alloc_bulk+0x300/0x408
   mas_alloc_nodes+0x188/0x268
   mas_nomem+0x88/0xf4
   mas_store_gfp+0x9c/0xfc
   do_mas_align_munmap+0x344/0x688
   do_mas_munmap+0xf8/0x118
   __vm_munmap+0x154/0x1e0
   __arm64_sys_munmap+0x44/0x54
   el0_svc_common+0xfc/0x1cc
   do_el0_svc_compat+0x38/0x5c
   el0_svc_compat+0x68/0x118
   el0t_32_sync_handler+0xc0/0xf0
   el0t_32_sync+0x190/0x194

  Freed by task 9966:
   kasan_set_track+0x4c/0x7c
   kasan_set_free_info+0x2c/0x38
   ____kasan_slab_free+0x13c/0x184
   __kasan_slab_free+0x14/0x24
   slab_free_freelist_hook+0x100/0x1ac
   kmem_cache_free_bulk+0x230/0x3b0
   mas_destroy+0x10d4/0x126c
   mas_nomem+0x40/0xf4
   mas_store_gfp+0x9c/0xfc
   do_mas_align_munmap+0x344/0x688
   do_mas_munmap+0xf8/0x118
   __vm_munmap+0x154/0x1e0
   __arm64_sys_munmap+0x44/0x54
   el0_svc_common+0xfc/0x1cc
   do_el0_svc_compat+0x38/0x5c
   el0_svc_compat+0x68/0x118
   el0t_32_sync_handler+0xc0/0xf0
   el0t_32_sync+0x190/0x194

  The buggy address belongs to the object at ffffff8015c1a100
   which belongs to the cache maple_node of size 256
  The buggy address is located 16 bytes inside of
   256-byte region [ffffff8015c1a100, ffffff8015c1a200)

  The buggy address belongs to the physical page:
  page:fffffffe00570600 refcount:1 mapcount:0 mapping:0000000000000000
index:0xa8ffff8015c1ad00 pfn:0x95c18
  head:fffffffe00570600 order:3 compound_mapcount:0 compound_pincount:0
  flags: 0x10200(slab|head|zone=0|kasantag=0x0)
  raw: 0000000000010200 6cffff8080030850 fffffffe003ec608 dbffff8080016280
  raw: a8ffff8015c1ad00 000000000020001e 00000001ffffffff 0000000000000000
  page dumped because: kasan: bad access detected

  Memory state around the buggy address:
   ffffff8015c19f00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
   ffffff8015c1a000: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
  >ffffff8015c1a100: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
                        ^
   ffffff8015c1a200: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
   ffffff8015c1a300: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
  ==================================================================
