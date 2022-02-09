Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E270B4AEB60
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 08:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbiBIHpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 02:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiBIHp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 02:45:29 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0C1C0613CA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 23:45:32 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id o19so3460173ybc.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 23:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rZt97/8ROY3+UKnKOkybgWpfp57iv+flrkhWaztw2B4=;
        b=hjNPEUw9OlUPIk2B4S7HhB3hqe9U9AT7bF0Q+ofYKz+gn7Tit4EYniAacYbI8Ut2DR
         sImSygPZsw2DdMFe6k/h3puZokb+ORZ/tqEi/CO2VbqgO7ZI4sa9YhKqKgeo5M6HzPCk
         1hBQBzkRbptsJjjpKnecf9nOiDO0mP2eQMZ3VoHmrbfD+b47MiHA246ZqOnFS2Uk4Coc
         l4amT4j7IO2ciSvjaSLS6qzWp2xzxvsf0qFFWuHepJGrt0wiq0F8fdTuGhKeNx2YcxBU
         2DfUuPmKQjorZC0cZDfWjOV+yj1U5RrMmOD/JFmKV6JBRfCzPnjTAY9xXB/8HokbQILO
         1Nmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rZt97/8ROY3+UKnKOkybgWpfp57iv+flrkhWaztw2B4=;
        b=eg8a7xk8fnANcNwV/Yoo0VhQizspKA0LQmdYxBkRgZ+Pj3QEId+I3KslqwMBESmPgk
         4/OdLJUM05E7R/VkP3LMlJprU7BuRLRKYFbXMQSOJB+5mnDLIT/J8KPpTVF+jdU/B0N4
         UxFJ6sju9W67S1URAI0daWVG+E4GT+qastktmmv114DOTkRrP5S5H8TlpooGDTNqikfa
         ew7WcaCh+PwU95iOpUjSs/2BGkEkowa/isg8PXUU4IAWfXuKig0YQnfkMe3ICGwhLixY
         6y2mtg8qrEgoN/mh5lRzducTRpE9p1myYM01TzfEWy5d7MsYjkxBHVF3GuA6A6PXmUgb
         e9TA==
X-Gm-Message-State: AOAM532zzHMl4RqECcg5hboI1vjhjZizhbpNGHBi+gszE6gwJjWu8MVh
        92T677KW7aFLUjj6Sa3NmikXLg+m3S8PkvpntEkn3Q==
X-Google-Smtp-Source: ABdhPJxnnpaw8noZfnF3Z83h+7aPBZguIP6vpvycsBalPzDcqBtgoaWBC8+48r0zPplursG/0OyeH/mYz65iclJX4Ww=
X-Received: by 2002:a25:c983:: with SMTP id z125mr1039624ybf.132.1644392731988;
 Tue, 08 Feb 2022 23:45:31 -0800 (PST)
MIME-Version: 1.0
References: <20211101031651.75851-1-songmuchun@bytedance.com>
 <CAMZfGtUeL45=WG3ceaZ_tALMGZTLtuD9jbfKEzeQv270OnaLYQ@mail.gmail.com>
 <35c5217d-eb8f-6f70-544a-a3e8bd009a46@oracle.com> <CAMZfGtW=e___8kpe1B5a1rK+SV63bP_Nwucj89QKaX4ZOMUpaw@mail.gmail.com>
 <CAMZfGtV0JKcjVL0qGoYCQJ-LsXdng7Z2UjBym5hf_WM0LcYi=Q@mail.gmail.com>
 <20211123190952.7d1e0cac2d72acacd2df016c@linux-foundation.org> <CAMZfGtW+DoKp_gCcPSy33Urc86A58rRp8HJ+-GOuW9vFP-BwxQ@mail.gmail.com>
In-Reply-To: <CAMZfGtW+DoKp_gCcPSy33Urc86A58rRp8HJ+-GOuW9vFP-BwxQ@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 9 Feb 2022 15:44:54 +0800
Message-ID: <CAMZfGtV-ODDGQ6dUuo_eSEDn2kDSiUjNDc=nyFwoRRSxNLsTeg@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] Free the 2nd vmemmap page associated with each
 HugeTLB page
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Fam Zheng <fam.zheng@bytedance.com>,
        Muchun Song <smuchun@gmail.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Barry Song <21cnbao@gmail.com>,
        "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>,
        Jue Wang <juew@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 4:04 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Wed, Nov 24, 2021 at 11:09 AM Andrew Morton
> <akpm@linux-foundation.org> wrote:
> >
> > On Mon, 22 Nov 2021 12:21:32 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > > On Wed, Nov 10, 2021 at 2:18 PM Muchun Song <songmuchun@bytedance.com> wrote:
> > > >
> > > > On Tue, Nov 9, 2021 at 3:33 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > > > >
> > > > > On 11/8/21 12:16 AM, Muchun Song wrote:
> > > > > > On Mon, Nov 1, 2021 at 11:22 AM Muchun Song <songmuchun@bytedance.com> wrote:
> > > > > >>
> > > > > >> This series can minimize the overhead of struct page for 2MB HugeTLB pages
> > > > > >> significantly. It further reduces the overhead of struct page by 12.5% for
> > > > > >> a 2MB HugeTLB compared to the previous approach, which means 2GB per 1TB
> > > > > >> HugeTLB. It is a nice gain. Comments and reviews are welcome. Thanks.
> > > > > >>
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > Ping guys. Does anyone have any comments or suggestions
> > > > > > on this series?
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > >
> > > > > I did look over the series earlier.  I have no issue with the hugetlb and
> > > > > vmemmap modifications as they are enhancements to the existing
> > > > > optimizations.  My primary concern is the (small) increased overhead
> > > > > for the helpers as outlined in your cover letter.  Since these helpers
> > > > > are not limited to hugetlb and used throughout the kernel, I would
> > > > > really like to get comments from others with a better understanding of
> > > > > the potential impact.
> > > >
> > > > Thanks Mike. I'd like to hear others' comments about this as well.
> > > > From my point of view, maybe the (small) overhead is acceptable
> > > > since it only affects the head page, however Matthew Wilcox's folio
> > > > series could reduce this situation as well.
> >
> > I think Mike was inviting you to run some tests to quantify the
> > overhead ;)
>
> Hi Andrew,
>
> Sorry for the late reply.
>
> Specific overhead figures are already in the cover letter. Also,
> I did some other tests, e.g. kernel compilation, sysbench. I didn't
> see any regressions.

The overhead is introduced by page_fixed_fake_head() which
has an "if" statement and an access to a possible cold cache line.
I think the main overhead is from the latter. However, probabilistically,
only 1/64 of the pages need to do the latter.  And
page_fixed_fake_head() is already simple (I mean the overhead
is small enough) and many performance bottlenecks in mm are
not in compound_head().  This also matches the tests I did.
I didn't see any regressions after enabling this feature.

I knew Mike's concern is the increased overhead to use cases
beyond HugeTLB. If we really want to avoid the access to
a possible cold cache line, we can introduce a new page
flag like PG_hugetlb and test if it is set in the page->flags,
if so, then return the read head page struct. Then
page_fixed_fake_head() looks like below.

static __always_inline const struct page *page_fixed_fake_head(const
struct page *page)
{
        if (!hugetlb_free_vmemmap_enabled())
                return page;

        if (test_bit(PG_hugetlb, &page->flags)) {
                unsigned long head = READ_ONCE(page[1].compound_head);

                if (likely(head & 1))
                        return (const struct page *)(head - 1);
        }
        return page;
}

But I don't think it's worth doing this.

Hi Mike and Andrew,

Since these helpers are not limited to hugetlb and used throughout the
kernel, I would really like to get comments from others with a better
understanding of the potential impact. Do you have any appropriate
reviewers to invite?

Thanks.
>
> >
> > > Ping guys.
> > >
> > > Hi Andrew,
> > >
> > > Do you have any suggestions on this series to move it on?
> > >
> >
> > I tossed it in there for some testing but yes please, additional
> > reviewing?
>
> It's already been in the next-tree (also in our ByteDance servers)
> for several months, and I didn't receive any negative feedback.
>
> Do you think it is ready for 5.17?
>
> Thanks.
