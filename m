Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6094B076D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 08:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236421AbiBJHpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 02:45:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236403AbiBJHpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 02:45:42 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEF5D71
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 23:45:43 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id p19so12955973ybc.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 23:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H0bpw8ZiHtzokDVaZikQejorexIqOBZeSJyqUU8svCs=;
        b=0cKvSKcc1KKaEgZvwZfBB/sT+3/J1bnyZKqgjpIZH3rOhPAVTwoVlFnAwsIH1eY6+w
         xG5HvcMtYGBEMZD95shkO5qKpKZQqrDhZBPWJUNSKw8AEoiJQlXPfzDggY1b02YLIVYz
         INdKXKl5tkMhiaCPWdSeatI0sUHNHWRnSzSN4bC74ET3lwztwbIa3iQlEurjNt9gYOfG
         9vxZ8pfHutYzYB+KdqxiEDx7G0XFvBEbc8IXucA0do8ZjID/HpgHx8FpfUxtWOjH11DW
         1lJ7dT2Nuhmr/xXRAnR1K+TaX8CFHjHf+2L5A0sDifPNWsD3JWVNe0TV/JJPl+7m/uQv
         AWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H0bpw8ZiHtzokDVaZikQejorexIqOBZeSJyqUU8svCs=;
        b=KPM9FOStDJTJefU/XS4rsj8m7JSBUJjdl45oLMJdH4Lvhpgy4GXoCjHVG4eoK6j3K2
         XebHaPBncAXP/FUGS4r+CMfuAT1nH1UEh6+YVjxe+ckP4l4OwjTTaAZNDhXUNtaVnwiv
         ux1xg/z8XZ5DAbsvgWtIvlS7Ju48b37YboZ2RDa39Wa58OlEXUNnKdLD9cXcFh1/BWGM
         0pz+PC2fkGaeTx8ymNPN94rqqEXUwkMXAUrGVRlQdsXV9KXpQOcvk2WHcjjrAPxEAKgx
         T5E9eCf5vflocgW1GYjCYyiYKUAjWTFjWuahN+7EkO7ZVEE6sw89GNyOUSkArSRQ6oix
         L/nA==
X-Gm-Message-State: AOAM532pC/WikTVNRfMTivtyFdWe/Cs+0SVhVhqjefa9KGfKhCsZuHmJ
        cxG6nbJMLPGS30hPwk3kKEd4o+pt6m49AujotdK49Q==
X-Google-Smtp-Source: ABdhPJy551ndV8++kKVWq1nu0+LX/n1eH0hGXi+5byk51qcTH4o+UpUO/ZlPArXPB3Hi3VB75BpAsJShzG4LcxV+yJ4=
X-Received: by 2002:a81:4051:: with SMTP id m17mr5819673ywn.319.1644479143117;
 Wed, 09 Feb 2022 23:45:43 -0800 (PST)
MIME-Version: 1.0
References: <20211101031651.75851-1-songmuchun@bytedance.com>
 <CAMZfGtUeL45=WG3ceaZ_tALMGZTLtuD9jbfKEzeQv270OnaLYQ@mail.gmail.com>
 <35c5217d-eb8f-6f70-544a-a3e8bd009a46@oracle.com> <CAMZfGtW=e___8kpe1B5a1rK+SV63bP_Nwucj89QKaX4ZOMUpaw@mail.gmail.com>
 <CAMZfGtV0JKcjVL0qGoYCQJ-LsXdng7Z2UjBym5hf_WM0LcYi=Q@mail.gmail.com>
 <20211123190952.7d1e0cac2d72acacd2df016c@linux-foundation.org>
 <CAMZfGtW+DoKp_gCcPSy33Urc86A58rRp8HJ+-GOuW9vFP-BwxQ@mail.gmail.com>
 <CAMZfGtV-ODDGQ6dUuo_eSEDn2kDSiUjNDc=nyFwoRRSxNLsTeg@mail.gmail.com> <fd4a237e-7494-9bd5-1952-164c22896c43@oracle.com>
In-Reply-To: <fd4a237e-7494-9bd5-1952-164c22896c43@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 10 Feb 2022 15:45:06 +0800
Message-ID: <CAMZfGtXPUNWheky0PLCOryDBMxGA7vghkzVFC8xahX7+_sUQ8w@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] Free the 2nd vmemmap page associated with each
 HugeTLB page
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
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

On Thu, Feb 10, 2022 at 6:49 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 2/8/22 23:44, Muchun Song wrote:
> > On Wed, Jan 26, 2022 at 4:04 PM Muchun Song <songmuchun@bytedance.com> wrote:
> >>
> >> On Wed, Nov 24, 2021 at 11:09 AM Andrew Morton
> >> <akpm@linux-foundation.org> wrote:
> >>>
> >>> On Mon, 22 Nov 2021 12:21:32 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
> >>>
> >>>> On Wed, Nov 10, 2021 at 2:18 PM Muchun Song <songmuchun@bytedance.com> wrote:
> >>>>>
> >>>>> On Tue, Nov 9, 2021 at 3:33 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >>>>>>
> >>>>>> On 11/8/21 12:16 AM, Muchun Song wrote:
> >>>>>>> On Mon, Nov 1, 2021 at 11:22 AM Muchun Song <songmuchun@bytedance.com> wrote:
> >>>>>>>>
> >>>>>>>> This series can minimize the overhead of struct page for 2MB HugeTLB pages
> >>>>>>>> significantly. It further reduces the overhead of struct page by 12.5% for
> >>>>>>>> a 2MB HugeTLB compared to the previous approach, which means 2GB per 1TB
> >>>>>>>> HugeTLB. It is a nice gain. Comments and reviews are welcome. Thanks.
> >>>>>>>>
> >>>>>>>
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>> Ping guys. Does anyone have any comments or suggestions
> >>>>>>> on this series?
> >>>>>>>
> >>>>>>> Thanks.
> >>>>>>>
> >>>>>>
> >>>>>> I did look over the series earlier.  I have no issue with the hugetlb and
> >>>>>> vmemmap modifications as they are enhancements to the existing
> >>>>>> optimizations.  My primary concern is the (small) increased overhead
> >>>>>> for the helpers as outlined in your cover letter.  Since these helpers
> >>>>>> are not limited to hugetlb and used throughout the kernel, I would
> >>>>>> really like to get comments from others with a better understanding of
> >>>>>> the potential impact.
> >>>>>
> >>>>> Thanks Mike. I'd like to hear others' comments about this as well.
> >>>>> From my point of view, maybe the (small) overhead is acceptable
> >>>>> since it only affects the head page, however Matthew Wilcox's folio
> >>>>> series could reduce this situation as well.
> >>>
> >>> I think Mike was inviting you to run some tests to quantify the
> >>> overhead ;)
> >>
> >> Hi Andrew,
> >>
> >> Sorry for the late reply.
> >>
> >> Specific overhead figures are already in the cover letter. Also,
> >> I did some other tests, e.g. kernel compilation, sysbench. I didn't
> >> see any regressions.
> >
> > The overhead is introduced by page_fixed_fake_head() which
> > has an "if" statement and an access to a possible cold cache line.
> > I think the main overhead is from the latter. However, probabilistically,
> > only 1/64 of the pages need to do the latter.  And
> > page_fixed_fake_head() is already simple (I mean the overhead
> > is small enough) and many performance bottlenecks in mm are
> > not in compound_head().  This also matches the tests I did.
> > I didn't see any regressions after enabling this feature.
> >
> > I knew Mike's concern is the increased overhead to use cases
> > beyond HugeTLB. If we really want to avoid the access to
> > a possible cold cache line, we can introduce a new page
> > flag like PG_hugetlb and test if it is set in the page->flags,
> > if so, then return the read head page struct. Then
> > page_fixed_fake_head() looks like below.
> >
> > static __always_inline const struct page *page_fixed_fake_head(const
> > struct page *page)
> > {
> >         if (!hugetlb_free_vmemmap_enabled())
> >                 return page;
> >
> >         if (test_bit(PG_hugetlb, &page->flags)) {
> >                 unsigned long head = READ_ONCE(page[1].compound_head);
> >
> >                 if (likely(head & 1))
> >                         return (const struct page *)(head - 1);
> >         }
> >         return page;
> > }
> >
> > But I don't think it's worth doing this.
> >
> > Hi Mike and Andrew,
> >
> > Since these helpers are not limited to hugetlb and used throughout the
> > kernel, I would really like to get comments from others with a better
> > understanding of the potential impact. Do you have any appropriate
> > reviewers to invite?
> >
>
> I think the appropriate people are already on Cc as they provided input on
> the original vmemmap optimization series.
>
> The question that needs to be answered is simple enough:  Is the savings of
> one vmemmap page per hugetlb page worth the extra minimal overhead in
> compound_head()?  Like most things, this depends on workload.
>
> One thing to note is that compound_page() overhead is only introduced if
> hugetlb vmemmap freeing is enabled.  Correct?

Definitely correct.

> During the original vmemmap
> optimization discussions, people thought it important that this be 'opt in'.  I do not know if distos will enable this by default.  But, perhaps the
> potential overhead can be thought of as just part of 'opting in' for
> vmemmap optimizations.

I agree. Does anyone else have a different opinion?

Thanks.
