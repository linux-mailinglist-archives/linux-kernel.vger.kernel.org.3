Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBF25037F2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 21:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbiDPTdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 15:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbiDPTdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 15:33:11 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44586E342
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 12:30:38 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id i34so8587048vsv.6
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 12:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8QFtLU2ByPJKT644LrsIvu21BExtTz3PUu+pDyzM+k8=;
        b=QRUSDsUJMz4kfN2qvFWFn9lYT5qOp2iiFwvGmzYY2/vtQ+DOq8bK+C32UFXYan5YWQ
         ieiwo3SQt0Uf6WksgX/jCoTK7urIZBY3KSY0Jd1pIgagPaapRemgglTKi23RZBUOdFhO
         Ge1Jws0wnsW3lWyGvb5tYBATnoBd4ouuQRAwj7cDFKrnAmy5crpVdG0CnPM1M/fqTJJ+
         YF9F47d7cXxRykoKJDlrto7u1z1Pupyn0wBYHLy7Mw4NxgUmSY95pgbTaUOHQ6eLytTB
         mS6sOfU4XKKfRwIpc9zkWwtKdqEaReYyH4Jos3S8NHJ1cmINA0pXf5CvrobEhjtZ6euV
         LWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8QFtLU2ByPJKT644LrsIvu21BExtTz3PUu+pDyzM+k8=;
        b=VAYFZsLj8Wt8YJfoPrIgSJJWIqHPbDyFaxhI0jqSBeX8PJBJ/v9HqyKaz7uUV5gmmS
         w7jRdsfeoubAyRRITNOflcHcqvI4WN2JPu1Up55/aePfBCJdIHvEZ00tO3wI55MNlTd+
         iJ7636pw1X/Pgc+69G0NiU86VHe8elazcR2+z8FRqNPcRsRyYgICAxhYmRqujOOE76AP
         C3852mAK50oSHF1mJ0AHi28rpcMJoWIufJKfcW3kOGmB2sV74T37VQmEK6CVCJtwKUi6
         CYjq6LYazVy1qeb+fENKB3Gvvuf8PcJt8iv92lGzkHSyrOlBU6ALueBBksESPz7kVaIc
         hcdA==
X-Gm-Message-State: AOAM531VWTIGjYwU7nsvIzgUJO23HRJW8FhfH2WIkcsTkT4o9UPCE/oM
        6lYDAiK4bSmd64R3JsvhlPSBLraRlAwwrjxn4yBjgg==
X-Google-Smtp-Source: ABdhPJxOmo1KBxfMb61qRXT2tFhtNwO8TeRjuNgzgtTNiDCiTp6TmCRNRp6nj4XESdxCnGzM4552l2uEsIecWx9C8t4=
X-Received: by 2002:a05:6102:2922:b0:325:7818:8669 with SMTP id
 cz34-20020a056102292200b0032578188669mr1227883vsb.41.1650137437605; Sat, 16
 Apr 2022 12:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
 <20220413235051.3a4eb7c86d31656c7aea250c@linux-foundation.org>
 <20220414135706.rcn7zr36s2hcd5re@revolver> <CAOUHufaw8tZrxuc6Sfxe+ES_MFHBqU_=O+X3b4rbYYrWYJRjkg@mail.gmail.com>
 <20220414171521.bgdvrirumd4atjhs@revolver> <20220414121911.8bb89fc3681b13af1566d79c@linux-foundation.org>
 <YlkaiUopM5HKWEdX@google.com> <20220416010259.4gbz5hgvm2lgr3sj@revolver>
 <CAOUHufZ8zPnpamkkpKK6KcSLTF91Eiba+S9VTX-ivhFrPQ_Cpw@mail.gmail.com> <20220416151923.ig5zavuptjsufm3d@revolver>
In-Reply-To: <20220416151923.ig5zavuptjsufm3d@revolver>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sat, 16 Apr 2022 13:30:01 -0600
Message-ID: <CAOUHufZewjQyMy1pHKxRkY82J5STPbUSJor7Q2aJgrkpZvU6bw@mail.gmail.com>
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

On Sat, Apr 16, 2022 at 9:19 AM Liam Howlett <liam.howlett@oracle.com> wrote:
>

<snipped>

> How did you hit this issue?  Just on boot?

I was hoping this is known to you or you have something I can verify for you.

Anyway, this was triggered by the Chrome browser. CompositorTileWorker
is the rendering process of Chrome [1]. With some luck, you might be
able to reproduce the problem by using Chrome. Chrome unit tests [2]
would be a better option, but it'd take some time to set up.

[1] https://source.chromium.org/chromium/chromium/src/+/main:content/renderer/categorized_worker_pool.cc;drc=0ac63f839b806e5e8823c5eebd6ca2db3b8f178e;l=201
[2] https://chromium.googlesource.com/chromium/src/+/HEAD/docs/testing/testing_in_chromium.md

> >   ==================================================================
> >   BUG: KASAN: invalid-access in mas_destroy+0x10a4/0x126c
> >   Read of size 8 at addr 7bffff8015c1a110 by task CompositorTileW/9966
> >   Pointer tag: [7b], memory tag: [fe]
> >
> >   CPU: 1 PID: 9966 Comm: CompositorTileW Not tainted 5.18.0-rc2-mm1-lockdep+ #2
> >   Call trace:
> >    dump_backtrace+0x1a0/0x200
> >    show_stack+0x24/0x30
> >    dump_stack_lvl+0x7c/0xa0
> >    print_report+0x15c/0x524
> >    kasan_report+0x84/0xb4
> >    kasan_tag_mismatch+0x28/0x3c
> >    __hwasan_tag_mismatch+0x30/0x60
> >    mas_destroy+0x10a4/0x126c
> >    mas_nomem+0x40/0xf4
> >    mas_store_gfp+0x9c/0xfc
> >    do_mas_align_munmap+0x344/0x688
> >    do_mas_munmap+0xf8/0x118
> >    __vm_munmap+0x154/0x1e0
> >    __arm64_sys_munmap+0x44/0x54
> >    el0_svc_common+0xfc/0x1cc
> >    do_el0_svc_compat+0x38/0x5c
> >    el0_svc_compat+0x68/0x118
> >    el0t_32_sync_handler+0xc0/0xf0
> >    el0t_32_sync+0x190/0x194
> >
> >   Allocated by task 9966:
> >    kasan_set_track+0x4c/0x7c
> >    __kasan_slab_alloc+0x84/0xa8
> >    kmem_cache_alloc_bulk+0x300/0x408
> >    mas_alloc_nodes+0x188/0x268
> >    mas_nomem+0x88/0xf4
> >    mas_store_gfp+0x9c/0xfc
> >    do_mas_align_munmap+0x344/0x688
> >    do_mas_munmap+0xf8/0x118
> >    __vm_munmap+0x154/0x1e0
> >    __arm64_sys_munmap+0x44/0x54
> >    el0_svc_common+0xfc/0x1cc
> >    do_el0_svc_compat+0x38/0x5c
> >    el0_svc_compat+0x68/0x118
> >    el0t_32_sync_handler+0xc0/0xf0
> >    el0t_32_sync+0x190/0x194
> >
> >   Freed by task 9966:
> >    kasan_set_track+0x4c/0x7c
> >    kasan_set_free_info+0x2c/0x38
> >    ____kasan_slab_free+0x13c/0x184
> >    __kasan_slab_free+0x14/0x24
> >    slab_free_freelist_hook+0x100/0x1ac
> >    kmem_cache_free_bulk+0x230/0x3b0
> >    mas_destroy+0x10d4/0x126c
> >    mas_nomem+0x40/0xf4
> >    mas_store_gfp+0x9c/0xfc
> >    do_mas_align_munmap+0x344/0x688
> >    do_mas_munmap+0xf8/0x118
> >    __vm_munmap+0x154/0x1e0
> >    __arm64_sys_munmap+0x44/0x54
> >    el0_svc_common+0xfc/0x1cc
> >    do_el0_svc_compat+0x38/0x5c
> >    el0_svc_compat+0x68/0x118
> >    el0t_32_sync_handler+0xc0/0xf0
> >    el0t_32_sync+0x190/0x194
> >
> >   The buggy address belongs to the object at ffffff8015c1a100
> >    which belongs to the cache maple_node of size 256
> >   The buggy address is located 16 bytes inside of
> >    256-byte region [ffffff8015c1a100, ffffff8015c1a200)
> >
> >   The buggy address belongs to the physical page:
> >   page:fffffffe00570600 refcount:1 mapcount:0 mapping:0000000000000000
> > index:0xa8ffff8015c1ad00 pfn:0x95c18
> >   head:fffffffe00570600 order:3 compound_mapcount:0 compound_pincount:0
> >   flags: 0x10200(slab|head|zone=0|kasantag=0x0)
> >   raw: 0000000000010200 6cffff8080030850 fffffffe003ec608 dbffff8080016280
> >   raw: a8ffff8015c1ad00 000000000020001e 00000001ffffffff 0000000000000000
> >   page dumped because: kasan: bad access detected
> >
> >   Memory state around the buggy address:
> >    ffffff8015c19f00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> >    ffffff8015c1a000: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> >   >ffffff8015c1a100: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> >                         ^
> >    ffffff8015c1a200: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> >    ffffff8015c1a300: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> >   ==================================================================
