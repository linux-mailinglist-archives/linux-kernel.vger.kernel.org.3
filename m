Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A35547774
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 22:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbiFKUMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 16:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiFKUM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 16:12:27 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F99A2674
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 13:12:22 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id e20so2384671vso.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 13:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hrersHGvOicUnlt7OJEv+EsQiBVx9OyQPU1C0m5zTpc=;
        b=C2bvL2clKJHcY49ynfJDwWAymr9REz5ZTkgaV+oBKeJaC5gGvNhgtA3h1lPHsNOLtP
         Sm1BwftfVETHcDfqy8qwA+/gXJiy6BsaJWaDM4U0Dk2etI6NxQ18TzsJVgtxGuhBx7bO
         pibSXszpqvlc5AmroDInCrJrWaRE6cORgKAOuQ13F6dGKfL1smVr7nvLu0Cy/ppaF5ng
         K6Vdbyc0SImMLOZkF4JYba8W9vYwN5rT0TldmARJFa7yw931lO/EHBv8LCrbJ68/nYZc
         Sgoc1MU6NTlDK6nMWXe+T/b0TmglJT82cb85NA/fnW/2n8sUfvr003CsocR998iSnsAy
         pA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hrersHGvOicUnlt7OJEv+EsQiBVx9OyQPU1C0m5zTpc=;
        b=zpsGhT73VOXIGoSTYiY9wTi19itrdNjO4HOXxk5B7zmzwVFwfuws3e3/EhME4QVTFA
         aDwqlPaSlSQCVQsu5PFL4Y2hPY42WOaERF5dNanom3o31qfwPipFiITRJnVVslHn+tLt
         4sexeW9Q5L3asQtSQNW00jEC8UV1qTJWQhnN7hq0aJiwkO/8W3qG2UAAYgsmtojtutYg
         0SqeVJBkqt4cLCOWIiW+XCYT6ODOr0G+9tfWiqvK25InMWRGCkBDbhvEPUNaLdNxvXHi
         FQC0/EgGplqWcauWqIQNv3nbZVVk8dUIcti+fKzNOAoBWAefmNC8txJiU3cwfpewGvWW
         GXIA==
X-Gm-Message-State: AOAM533JmM6xPOTIOTwGSI9Z1U5xlvf5cRmtMhVgkpoM3uZWiGe++Oz2
        JXPkc/n0cIH71vXYGChp3XoA6rzj5+Lpax0rr0NKsw==
X-Google-Smtp-Source: ABdhPJyCoHzk5AG6VcTGyAIQ4af/v1Jm7auvhoa9RGQJQ8p0wTxCRQfDh+0ZDN9UVQb+zvt86ykc8VXovNKg3+8Ehlc=
X-Received: by 2002:a05:6102:214c:b0:34b:b31d:1a50 with SMTP id
 h12-20020a056102214c00b0034bb31d1a50mr15175372vsg.41.1654978341334; Sat, 11
 Jun 2022 13:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com> <20220504011345.662299-13-Liam.Howlett@oracle.com>
 <Yp3udPy0vuDK8khc@qian> <20220606161940.fh5edq5nyz4jru2u@revolver> <Yp4uD8uWB3rit/Ee@qian>
In-Reply-To: <Yp4uD8uWB3rit/Ee@qian>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sat, 11 Jun 2022 14:11:45 -0600
Message-ID: <CAOUHufZk+3xCqK38CuVdWg_ZiWaLyke+Y+=CYJpraET6nKQ=yQ@mail.gmail.com>
Subject: Re: [PATCH v9 28/69] mm/mmap: reorganize munmap to use maple states
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Qian Cai <quic_qiancai@quicinc.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
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

On Mon, Jun 6, 2022 at 10:40 AM Qian Cai <quic_qiancai@quicinc.com> wrote:
>
> On Mon, Jun 06, 2022 at 04:19:52PM +0000, Liam Howlett wrote:
> > Does your syscall fuzzer create a reproducer?  This looks like arm64
> > and says 5.18.0-next-20220603 again.  Was this bisected to the patch
> > above?
>
> This was triggered by running the fuzzer over the weekend.
>
> $ trinity -C 160
>
> No bisection was done. It was only brought up here because the trace
> pointed to do_mas_munmap() which was introduced here.

Liam,

I'm getting a similar crash on arm64 -- the allocator is madvise(),
not mprotect(). Please take a look.

Thanks.

==================================================================
BUG: KASAN: double-free or invalid-free in kmem_cache_free_bulk+0x230/0x3b0
Pointer tag: [0c], memory tag: [fe]

CPU: 2 PID: 8320 Comm: stress-ng Tainted: G    B   W
5.19.0-rc1-lockdep+ #3
Call trace:
 dump_backtrace+0x1a0/0x200
 show_stack+0x24/0x30
 dump_stack_lvl+0x7c/0xa0
 print_report+0x15c/0x524
 kasan_report_invalid_free+0x64/0x84
 ____kasan_slab_free+0x150/0x184
 __kasan_slab_free+0x14/0x24
 slab_free_freelist_hook+0x100/0x1ac
 kmem_cache_free_bulk+0x230/0x3b0
 mas_destroy+0x10d8/0x1270
 mas_store_prealloc+0xb8/0xec
 do_mas_align_munmap+0x398/0x694
 do_mas_munmap+0xf8/0x118
 __vm_munmap+0x154/0x1e0
 __arm64_sys_munmap+0x44/0x54
 el0_svc_common+0xfc/0x1cc
 do_el0_svc_compat+0x38/0x5c
 el0_svc_compat+0x68/0xf4
 el0t_32_sync_handler+0xc0/0xf0
 el0t_32_sync+0x190/0x194

Allocated by task 8437:
 kasan_set_track+0x4c/0x7c
 __kasan_slab_alloc+0x84/0xa8
 kmem_cache_alloc_bulk+0x300/0x408
 mas_alloc_nodes+0x198/0x294
 mas_preallocate+0x8c/0x110
 __vma_adjust+0x174/0xc88
 vma_merge+0x2e4/0x300
 do_madvise+0x504/0xd20
 __arm64_sys_madvise+0x54/0x64
 el0_svc_common+0xfc/0x1cc
 do_el0_svc_compat+0x38/0x5c
 el0_svc_compat+0x68/0xf4
 el0t_32_sync_handler+0xc0/0xf0
 el0t_32_sync+0x190/0x194

Freed by task 8320:
 kasan_set_track+0x4c/0x7c
 kasan_set_free_info+0x2c/0x38
 ____kasan_slab_free+0x13c/0x184
 __kasan_slab_free+0x14/0x24
 slab_free_freelist_hook+0x100/0x1ac
 kmem_cache_free+0x11c/0x264
 mt_destroy_walk+0x6d8/0x714
 mas_wmb_replace+0x9d4/0xa68
 mas_spanning_rebalance+0x1af0/0x1d2c
 mas_wr_spanning_store+0x908/0x964
 mas_wr_store_entry+0x53c/0x5c0
 mas_store_prealloc+0x88/0xec
 do_mas_align_munmap+0x398/0x694
 do_mas_munmap+0xf8/0x118
 __vm_munmap+0x154/0x1e0
 __arm64_sys_munmap+0x44/0x54
 el0_svc_common+0xfc/0x1cc
 do_el0_svc_compat+0x38/0x5c
 el0_svc_compat+0x68/0xf4
 el0t_32_sync_handler+0xc0/0xf0
 el0t_32_sync+0x190/0x194

The buggy address belongs to the object at ffffff808b5f0a00
 which belongs to the cache maple_node of size 256
The buggy address is located 0 bytes inside of
 256-byte region [ffffff808b5f0a00, ffffff808b5f0b00)

The buggy address belongs to the physical page:
page:fffffffe022d7c00 refcount:1 mapcount:0 mapping:0000000000000000
index:0xcffff808b5f0a00 pfn:0x10b5f0
head:fffffffe022d7c00 order:2 compound_mapcount:0 compound_pincount:0
flags: 0x8000000000010200(slab|head|zone=2|kasantag=0x0)
raw: 8000000000010200 fffffffe031a8608 fffffffe021a3608 caffff808002c800
raw: 0cffff808b5f0a00 0000000000150013 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffffff808b5f0800: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
 ffffff808b5f0900: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>ffffff808b5f0a00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
                   ^
 ffffff808b5f0b00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
 ffffff808b5f0c00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
==================================================================
