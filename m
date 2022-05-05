Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10E051B8F2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 09:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345341AbiEEHcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 03:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344309AbiEEHbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 03:31:49 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9539048305
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 00:27:44 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id k1so3626235pll.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 00:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sdOJy9rnvDwfzvmnn6j6QC2/k4SprY6poljrhU6ERjM=;
        b=SH+mtnZULvwnaVfPcfukAFArBjFxn8qIN4CcPYpxa1rw8oKK8U+0XIaOdSv2j6hYHC
         ftdxMRAe9gn5EY8pm78hwxj4VnTgtIxV7vF1i/43NACuOxMpTX+Lyw3Ub/9otfAaT6d6
         ayycK2sX8Z3NtK/A2ojQJVDhdvaNxP2Rlqsv989d52Qz+6R4l7odEGo62PDZB/YHAEvu
         dgj+OVHpkhQ5nzfMZ9i5be+A2UYiDxUCvJWT50h8eYLBRxKrUWdqX1rV52s5iMAps9Hm
         JXj0DHN+A4UpL8lASRHH29tzWBnMDUtPpAFVoD3elKHy5pA504Gpv1XcQuhCFMj6th7h
         NKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sdOJy9rnvDwfzvmnn6j6QC2/k4SprY6poljrhU6ERjM=;
        b=0x1+7WE0rgGbv75y1IKtcU9ZH6rX7thYmW77pBNikfNSY1Dr8cDnT1ua4+iTNU26fC
         ePbsGCeuDaIhPuc7s6f4D1sCWa74qVf+d8QQIMkCHBArK2CEOZnrtREUzAspX7MxFPSP
         Xwhi4wezMZanp8AwWNG14QmfXOCO581plvcCLgq+QwBAgZ0+nx1wjOq7vtr7yv8fSdPq
         a8TH6Jcy1B67U9SK7T2JyTGtvRMe2xgbKHb8P09Ysm9o1tv69ZtRpkDr7GxskvEm7m/B
         Wtu8BXH01NT3zdtubez86UmIjAFZBlbmbhZtUs6CfDh+kdM8nnhGeTGR8pqP1vgaX2VO
         pFNA==
X-Gm-Message-State: AOAM531vRODh/Fa0kjRuiFOb0f6wq7pIbT+QPXLc08r4o41RZWeJoEEv
        aQA7+a2pH6sm5HpZxpk1EMpy8DlCy4c=
X-Google-Smtp-Source: ABdhPJx2PdxKwhBCD9gwdowDoR4lY3wzuXoyTmjGt6aTBhywjGErWD0KWXZwLPS4uSwt/24scXuo8w==
X-Received: by 2002:a17:902:7c8c:b0:156:5651:1d51 with SMTP id y12-20020a1709027c8c00b0015656511d51mr25890593pll.107.1651735664051;
        Thu, 05 May 2022 00:27:44 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id w10-20020a170902c78a00b0015e8d4eb223sm737930pla.109.2022.05.05.00.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 00:27:43 -0700 (PDT)
Date:   Thu, 5 May 2022 16:27:38 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/kfence: reset PG_slab and memcg_data before freeing
 __kfence_pool
Message-ID: <YnN8auHRG1+DWeT+@hyeyoo>
References: <20220505070105.1835745-1-42.hyeyoo@gmail.com>
 <CANpmjNN5B5xjcTfcAF78d9Bpxqypt8p=OHTLU+QHbtV6vJJjeg@mail.gmail.com>
 <CANpmjNPEwnW-uXJr_8rt-KPCjuuVY1sTDg0E312c4iCuSRQ2ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPEwnW-uXJr_8rt-KPCjuuVY1sTDg0E312c4iCuSRQ2ug@mail.gmail.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 09:19:31AM +0200, Marco Elver wrote:
> On Thu, 5 May 2022 at 09:12, Marco Elver <elver@google.com> wrote:
> >
> > On Thu, 5 May 2022 at 09:01, Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> > >
> > > When kfence fails to initialize kfence pool, it frees the pool.
> > > But it does not reset PG_slab flag and memcg_data of struct page.
> > >
> > > Below is a BUG because of this. Let's fix it by resetting PG_slab
> > > and memcg_data before free.
> > >
> > > [    0.089149] BUG: Bad page state in process swapper/0  pfn:3d8e06
> > > [    0.089149] page:ffffea46cf638180 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3d8e06
> > > [    0.089150] memcg:ffffffff94a475d1
> > > [    0.089150] flags: 0x17ffffc0000200(slab|node=0|zone=2|lastcpupid=0x1fffff)
> > > [    0.089151] raw: 0017ffffc0000200 ffffea46cf638188 ffffea46cf638188 0000000000000000
> > > [    0.089152] raw: 0000000000000000 0000000000000000 00000000ffffffff ffffffff94a475d1
> > > [    0.089152] page dumped because: page still charged to cgroup
> > > [    0.089153] Modules linked in:
> > > [    0.089153] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G    B   W         5.18.0-rc1+ #965
> > > [    0.089154] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
> > > [    0.089154] Call Trace:
> > > [    0.089155]  <TASK>
> > > [    0.089155]  dump_stack_lvl+0x49/0x5f
> > > [    0.089157]  dump_stack+0x10/0x12
> > > [    0.089158]  bad_page.cold+0x63/0x94
> > > [    0.089159]  check_free_page_bad+0x66/0x70
> > > [    0.089160]  __free_pages_ok+0x423/0x530
> > > [    0.089161]  __free_pages_core+0x8e/0xa0
> > > [    0.089162]  memblock_free_pages+0x10/0x12
> > > [    0.089164]  memblock_free_late+0x8f/0xb9
> > > [    0.089165]  kfence_init+0x68/0x92
> > > [    0.089166]  start_kernel+0x789/0x992
> > > [    0.089167]  x86_64_start_reservations+0x24/0x26
> > > [    0.089168]  x86_64_start_kernel+0xa9/0xaf
> > > [    0.089170]  secondary_startup_64_no_verify+0xd5/0xdb
> > > [    0.089171]  </TASK>
> >
> > This is probably:
> >
> > Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
> 
> Hmm, looking closer at the above BUG, I think it's
> 
> Fixes: 8f0b36497303 ("mm: kfence: fix objcgs vector allocation")
> 
> ?

Marco, Thanks for comments.

I think it fixes both because not clearing PG_slab also invokes a BUG.

> 
> > > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > > ---
> > >  mm/kfence/core.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> > > index a203747ad2c0..2ab3d473321e 100644
> > > --- a/mm/kfence/core.c
> > > +++ b/mm/kfence/core.c
> > > @@ -642,6 +642,13 @@ static bool __init kfence_init_pool_early(void)
> > >          * fails for the first page, and therefore expect addr==__kfence_pool in
> > >          * most failure cases.
> > >          */
> > > +       for (char *p = (char *)addr; p < __kfence_pool + KFENCE_POOL_SIZE; p += PAGE_SIZE) {
> > > +               struct page *page;
> > > +
> > > +               page = virt_to_page(p);
> >
> > #ifdef CONFIG_MEMCG
> >
> > > +               page->memcg_data = 0;
> >
> > #endif
> >
> > > +               __ClearPageSlab(page);
> >

Ah, thanks! Will do in v2.

> > We're now using __folio_set_slab(), so I'm guessing this should be
> > __folio_clear_slab()?

Right. Will do in v2.

> >
> > > +       }
> > >         memblock_free_late(__pa(addr), KFENCE_POOL_SIZE - (addr - (unsigned long)__kfence_pool));
> > >         __kfence_pool = NULL;
> > >         return false;
> > > --
> > > 2.32.0
> > >

-- 
Thanks,
Hyeonggon
