Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5372C4D0800
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 20:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245184AbiCGTyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 14:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240239AbiCGTyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 14:54:35 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574535622A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 11:53:40 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id s8so11169551pfk.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 11:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a+6WP3aPzDaqBmbKZ4fXBa2B0+nTVXiDP/kgbc6+cAU=;
        b=c07xOk5XQewmk9EO+50F4gDDVmOcSinZLtBfmd5Dn/BF+gx1ISNcGrmxhhJwhIspPI
         xOC8waHbNNRoj01bqTNZrRTMZplQWQcz7QxiAIBAFci/hM4vkHS+E4/aM8UcKtB9wuvt
         Vq+0cTfZ1SYlnp/sGQ5feHCVnM5HqoVZFTXiy6xJQgu0BK5irZHOcsGG1wzj5+SpGt1A
         Deir9vh86pkwN0VQ110J+7r9o2Y3/cDO4FWJncrVMY3jcBBs5RNPUP057L8f0Tp0QZNS
         seUcTbso+sHK0xO2EnOA3XMP7gCEQGHpGRCbuJbqdvLYqLTuVcCqIauf3dNMal6o9Xps
         2vPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a+6WP3aPzDaqBmbKZ4fXBa2B0+nTVXiDP/kgbc6+cAU=;
        b=KOhfzLbKpltLrpO0G5mwR4R3l8iyP9ErSwva8IBw5eApauX7faBLrZSvUUVku8kJxz
         Pn92j0ebz3/XuSEZXJ/Tm9ynMEWsyMFacVp6Fiq6PmmExzOvOhK6b8SBqVqAWxYZtCoe
         W9bi1EnQtFtKmDq/AeC8V5MYjbvMVpy2LoosA/M+IZBntW7AjXEFKlE+4q8slvd2Bi4j
         UDe5D6ZUlgMhsy7ZjHZaz+htVArc2nPHZx6slXta20qNkO428bfOSkrPQAIE9jKwnR35
         lDXd1p+tuLBqurb1yxDvX7zWgCsl9oKpKeio0vs4UAbePS6RgNE18uYg9bW8UKTMKh4M
         BQGQ==
X-Gm-Message-State: AOAM531T368QKsqriNANFiI6wdU2MpW/+J8hagUoYa3GQDRpNuGqTzCf
        JTR9ehemE48EAnO3ma3XyIz8iRZ94aJxKJNljcoz8XFrH9Y=
X-Google-Smtp-Source: ABdhPJwIi3O+lj4ZnbrUOMpLZNmg76CVFxrlIIMuG2TKxIO8RISTeg/AD15YgkOTsZbHR9X931ls8R6khqpXR1wXsK4=
X-Received: by 2002:a63:920f:0:b0:378:9ef8:7978 with SMTP id
 o15-20020a63920f000000b003789ef87978mr10875734pgd.587.1646682819673; Mon, 07
 Mar 2022 11:53:39 -0800 (PST)
MIME-Version: 1.0
References: <20220228140245.24552-1-linmiaohe@huawei.com> <20220228140245.24552-5-linmiaohe@huawei.com>
 <20220304082804.GC3778609@hori.linux.bs1.fc.nec.co.jp> <2311bee4-cc11-93fc-6992-6c327a150e3d@huawei.com>
In-Reply-To: <2311bee4-cc11-93fc-6992-6c327a150e3d@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 7 Mar 2022 11:53:27 -0800
Message-ID: <CAHbLzkrOfcJvv8Vy8jcKWc7QX=1Y9e=EW9+p78sp1xhac645-w@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm/memory-failure.c: fix potential VM_BUG_ON_PAGE in split_huge_page_to_list
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

On Sun, Mar 6, 2022 at 11:07 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> On 2022/3/4 16:28, HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3 =E7=9B=B4=E4=B9=9F)=
 wrote:
> > On Mon, Feb 28, 2022 at 10:02:45PM +0800, Miaohe Lin wrote:
> >> The huge zero page could reach here and if we ever try to split it, th=
e
> >> VM_BUG_ON_PAGE will be triggered in split_huge_page_to_list(). Also th=
e
> >> non-lru compound movable pages could be taken for transhuge pages. Ski=
p
> >> these pages by checking PageLRU because huge zero page isn't lru page =
as
> >> non-lru compound movable pages.
> >
> > It seems that memory_failure() also fails at get_any_page() with "hwpoi=
son:
> > unhandlable page" message.
> >
> >   [16478.203474] page:00000000b6acdbd1 refcount:1 mapcount:0 mapping:00=
00000000000000 index:0x0 pfn:0x1810b4
> >   [16478.206612] flags: 0x57ffffc0801000(reserved|hwpoison|node=3D1|zon=
e=3D2|lastcpupid=3D0x1fffff)
> >   [16478.209411] raw: 0057ffffc0801000 fffff11bc6042d08 fffff11bc6042d0=
8 0000000000000000
> >   [16478.211921] raw: 0000000000000000 0000000000000000 00000001fffffff=
f 0000000000000000
> >   [16478.214473] page dumped because: hwpoison: unhandlable page
> >   [16478.216386] Memory failure: 0x1810b4: recovery action for unknown =
page: Ignored
> >
> > We can't handle errors on huge (or normal) zero page, so the current
>
> Sorry for confusing commit log again. I should have a coffee before I mak=
e this patch.
> Huge or normal zero page will fail at get_any_page because they're neithe=
r HWPoisonHandlable
> nor PageHuge.
>
> > behavior seems to me more suitable than "unsplit thp".
> >
> > Or if you have some producer to reach the following path with huge zero
> > page, could you share it?
> >
>
> What I mean is that non-lru movable compound page can reach here unexpect=
ed because __PageMovable(page)
> is handleable now. So get_any_page could succeed to grab the page refcnt.=
 And since it's compound page,
> it will go through the split_huge_page_to_list because PageTransHuge chec=
ks PageHead(page) which can also
> be true for compound page. But this type of pages is unexpected for split=
_huge_page_to_list.

Can we really handle non-LRU movable pages in memory failure
(uncorrectable errors)? Typically they are balloon, zsmalloc, etc.
Assuming we run into a base (4K) non-LRU movable page, we could reach
as far as identify_page_state(), it should not fall into any category
except me_unknown. So it seems we could just simply make it
unhandlable.

But it should be handlable for soft-offline since it could be migrated.


> Does this make sense for you? Thanks Naoya.
>
> > Thanks,
> > Naoya Horiguchi
> >
> >>
> >> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >> ---
> >>  mm/memory-failure.c | 14 ++++++++++++++
> >>  1 file changed, 14 insertions(+)
> >>
> >> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> >> index 23bfd809dc8c..ac6492e36978 100644
> >> --- a/mm/memory-failure.c
> >> +++ b/mm/memory-failure.c
> >> @@ -1792,6 +1792,20 @@ int memory_failure(unsigned long pfn, int flags=
)
> >>      }
> >>
> >>      if (PageTransHuge(hpage)) {
> >> +            /*
> >> +             * The non-lru compound movable pages could be taken for
> >> +             * transhuge pages. Also huge zero page could reach here
> >> +             * and if we ever try to split it, the VM_BUG_ON_PAGE wil=
l
> >> +             * be triggered in split_huge_page_to_list(). Skip these
> >> +             * pages by checking PageLRU because huge zero page isn't
> >> +             * lru page as non-lru compound movable pages.
> >> +             */
> >> +            if (!PageLRU(hpage)) {
> >> +                    put_page(p);
> >> +                    action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNORED=
);
> >> +                    res =3D -EBUSY;
> >> +                    goto unlock_mutex;
> >> +            }
> >>              /*
> >>               * The flag must be set after the refcount is bumped
> >>               * otherwise it may race with THP split.
> >> --
> >> 2.23.0
>
>
