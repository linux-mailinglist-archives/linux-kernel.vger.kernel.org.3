Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02DF4D082F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 21:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240010AbiCGUPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 15:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiCGUPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 15:15:19 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB17B65413
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 12:14:24 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id g1so15330937pfv.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 12:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dycwIoHQQBpDUhGIcot+r2addV8RXGwwuqgAYCsn264=;
        b=LbQTPEr4GnSNUitRf6YHBcjjyEcTfY5oVmBVldrI+eP4dK39SoiuHRz4wJDw0T2GDF
         dGvQflpnc18+LT44cLUY50mKKHjpvitNupfE2lICFsw3eNAZFCsuQVUPV8cOfb1wi8oX
         mOvUl7MUE5i1PMOUNbLsRBlMnM6VFcyOOplUIxu6ed7U//e41WkhCLuQvT1fvxEsXJFQ
         FA1yd8NnLRCl075oI40PwVQ/xYdTdfcMeBZGFl21GxAsbFIjppyEBEOTgxcHQpWpk25c
         eQ1ybcJpAMRMCVDksE3Q+cuG6woxdyT5uT2LAfqAYGbzUG1Vr4p9HpRWfEToTnWRyFNn
         mdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dycwIoHQQBpDUhGIcot+r2addV8RXGwwuqgAYCsn264=;
        b=wrT0O93Rppm+p/eDSslf/KiVsyOGNAgRInJ87kITztM7deI+GNOciSKs6m5uQ2ykfG
         C1jHl4kpKoXeNV+GYgEEeuRh/y0bCXst5ljwHOA+z1wEeU2jseNXp1ITaNOOEK21hHic
         5CIy9RoAsVfxdjOYneGIvnjQRamEAvt1qcIQMrIX/fIQVriFvmxjBqqoEu0sZSpmgbwB
         vU1s+NSQL131aE96o/dy/FvbC6jWdPsjPus6cJ+OqCVVAIJYX22q9WD1zJBOQSOTG+k9
         hqoZNm4Zdu8jm9RPdfDT3JRng7l0gI4XvzpzZJ9R4OsvtDoFpiJsceSLR5F+0ukO4Znb
         oKuw==
X-Gm-Message-State: AOAM5325UI1PD1Icpf0eyllITWzGL8B+SJAysk6hyR1NCT8wkW4Txtvo
        5lZOGOy/V/7K2jYkcrZIT91T77Bi4Bxii9BQCSA=
X-Google-Smtp-Source: ABdhPJy8ieSKKcRoMUisC467i7PrAyALIIcy4JgaaFqJp6Y7+F4/Mjg9B/Qh64xxPxRu9hYkHBAxK0/kLKMeEwKHOpo=
X-Received: by 2002:a63:571e:0:b0:378:9f08:129b with SMTP id
 l30-20020a63571e000000b003789f08129bmr11159688pgb.75.1646684064515; Mon, 07
 Mar 2022 12:14:24 -0800 (PST)
MIME-Version: 1.0
References: <20220228140245.24552-1-linmiaohe@huawei.com> <20220228140245.24552-3-linmiaohe@huawei.com>
 <20220304082714.GB3778609@hori.linux.bs1.fc.nec.co.jp> <227af111-9264-02fd-9e46-744d39ecfed0@huawei.com>
In-Reply-To: <227af111-9264-02fd-9e46-744d39ecfed0@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 7 Mar 2022 12:14:12 -0800
Message-ID: <CAHbLzkom__59_RCpJCZDA+ray-t5qAWatujXWha8BX2-x8GiMA@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm/memory-failure.c: fix wrong user reference report
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 7, 2022 at 3:26 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> On 2022/3/4 16:27, HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3 =E7=9B=B4=E4=B9=9F)=
 wrote:
> > On Mon, Feb 28, 2022 at 10:02:43PM +0800, Miaohe Lin wrote:
> >> The dirty swapcache page is still residing in the swap cache after it'=
s
> >> hwpoisoned. So there is always one extra refcount for swap cache.
> >
> > The diff seems fine at a glance, but let me have a few question to
> > understand the issue more.
> >
> > - Is the behavior described above the effect of recent change on shmem =
where
> >   dirty pagecache is pinned on hwpoison (commit a76054266661 ("mm: shme=
m:
> >   don't truncate page if memory failure happens"). Or the older kernels
> >   behave as the same?
> >
> > - Is the behavior true for normal anonymous pages (not shmem pages)?
> >
>
> The behavior described above is aimed at swapcache not pagecache. So it s=
hould be
> irrelevant with the recent change on shmem.
>
> What I try to fix here is that me_swapcache_dirty holds one extra pin via=
 SwapCache
> regardless of the return value of delete_from_lru_cache. We should try to=
 report more
> accurate extra refcount for debugging purpose.

I think you misunderstood the code. The delete_from_lru_cache()
returning 0 means the page was on LRU and isolated from LRU
successfully now. Returning -EIO means the page was not on LRU, so it
should have at least an extra pin on it.

So MF_DELAYED means there is no other pin other than hwpoison and
swapcache which is expected, MF_FAILED means there might be extra
pins.

The has_extra_refcount() raised error then there is *unexpected* refcount.

>
> > I'm trying to test hwpoison hitting the dirty swapcache, but it seems t=
hat
> > in my testing memory_faliure() fails with "hwpoison: unhandlable page"
>
> Maybe memory_faliure is racing with page reclaim where page is isolated?
>
> > warning at get_any_page().  So I'm still not sure that me_pagecache_dir=
ty()
> > fixes any visible problem.
>
> IIUC, me_pagecache_dirty can't do much except for the corresponding addre=
ss_space supporting
> error_remove_page which can truncate the dirty pagecache page. But this m=
ay cause silent data
> loss. It's better to keep the page stay in the pagecache until the file i=
s truncated, hole
> punched or removed as commit a76054266661 pointed out.
>
> Thanks.
>
> > > Thanks,
> > Naoya Horiguchi
> >
> >>
> >> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >> ---
> >>  mm/memory-failure.c | 6 +-----
> >>  1 file changed, 1 insertion(+), 5 deletions(-)
> >>
> >> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> >> index 0d7c58340a98..5f9503573263 100644
> >> --- a/mm/memory-failure.c
> >> +++ b/mm/memory-failure.c
> >> @@ -984,7 +984,6 @@ static int me_pagecache_dirty(struct page_state *p=
s, struct page *p)
> >>  static int me_swapcache_dirty(struct page_state *ps, struct page *p)
> >>  {
> >>      int ret;
> >> -    bool extra_pins =3D false;
> >>
> >>      ClearPageDirty(p);
> >>      /* Trigger EIO in shmem: */
> >> @@ -993,10 +992,7 @@ static int me_swapcache_dirty(struct page_state *=
ps, struct page *p)
> >>      ret =3D delete_from_lru_cache(p) ? MF_FAILED : MF_DELAYED;
> >>      unlock_page(p);
> >>
> >> -    if (ret =3D=3D MF_DELAYED)
> >> -            extra_pins =3D true;
> >> -
> >> -    if (has_extra_refcount(ps, p, extra_pins))
> >> +    if (has_extra_refcount(ps, p, true))
> >>              ret =3D MF_FAILED;
> >>
> >>      return ret;
> >> --
> >> 2.23.0
>
>
