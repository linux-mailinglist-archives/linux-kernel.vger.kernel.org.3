Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DF2518BED
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241046AbiECSME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240965AbiECSMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:12:00 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6683EABC
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 11:08:28 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso2997677pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 11:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TttXqLUVM2RUYcddmpbzTO7OqJ9zNGbHPbTMQOyiNYg=;
        b=ekJaSHYhcsRmVQABuTaZ47dOTUN9IgcSoi9eRGTW2HnBfftv2scK1Zn6X+TrUXW01C
         1IBEHbKciriXj6hlLOAMMLNB7e8205lSTnbb+lVpAAjLR9Qq74WxNEYpcFXpVI7nqXIa
         0xG1fOTj7+tpDRHvxKX7dy361g+gRJpEk2GeYeFU3am+0+MIcnT+5TaVus6D/7qDgzS7
         rGanXqJy7MhRwVU3LaxijcSYkLozjAIzaMkCnCxBBtk1Zd5bKQMVnLFRYKr+YtxGneQy
         d251Hsi+ICvSjFyqsWvbQ9kkx83gSTww87m+o5mVr5BZ8DxhNUNyek9NCnppgvkab49N
         GXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=TttXqLUVM2RUYcddmpbzTO7OqJ9zNGbHPbTMQOyiNYg=;
        b=FDS8pI/BRNURXxWxKycz+HRDsG/rYfeQSNRCjxHKZIyzdvpwVe85k5nXlCUQThd3+z
         kzxBM/PTIBrOa3dGiMWcn6UYxd7jZcuq59OVgmZPsCUGSqX/VDYV3stW698hzZo0bs2g
         CtvI+Ed8biVQhejt7H3genaPJW03nc66kXDFiBIP8YjPT354Uuv+QCM5tsrsPFcw8ZJB
         Nd2MQyHXzaXqmSskIFy84RT2tx5eesFll4/1ZRe2d0KXPCNop1iTkr+Dvogrb8vjFGjI
         BuJ4Ae3zI/VM5ah/dFpSzBc2AaiFww51y07uaOS737kC5r/ogg9FpCvkPoJLKUQnf3PX
         3tnw==
X-Gm-Message-State: AOAM53056b+tnrOXix84MVQSvKqU0InYJ7M5Z2jJs9MMTNkEuqGBPrAm
        /5Rl7/fzpOtgGvlZ/7F6Tiw=
X-Google-Smtp-Source: ABdhPJydu4K9sL6j3Nm0fG7o8gS9ZV86d0mg8BCm5EO9+gPM3A5XHTLmCJZxSM/8Zy0jHkWpvvWOXg==
X-Received: by 2002:a17:90a:4f0b:b0:1d9:acbd:1204 with SMTP id p11-20020a17090a4f0b00b001d9acbd1204mr6031920pjh.201.1651601307400;
        Tue, 03 May 2022 11:08:27 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:8998:54e:9def:1e7c])
        by smtp.gmail.com with ESMTPSA id w3-20020a17090a8a0300b001cd4989ff40sm1655162pjn.7.2022.05.03.11.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 11:08:26 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 3 May 2022 11:08:25 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        John Dias <joaodias@google.com>
Subject: Re: [PATCH] mm: fix is_pinnable_page against on cma page
Message-ID: <YnFvmc+eMoXvLCWf@google.com>
References: <20220502173558.2510641-1-minchan@kernel.org>
 <29d0c1c3-a44e-4573-7e7e-32be07544dbe@redhat.com>
 <YnAhaRNjmIhtGUjk@google.com>
 <08e9855c-395d-f40c-de3d-1ec8b644bfe8@redhat.com>
 <YnFJss0doXGCmq3w@google.com>
 <da07530d-92ad-7aef-2f2b-d115f878ef76@redhat.com>
 <YnFkZmvW2thpIn8o@google.com>
 <f271ca5e-c573-1c48-35a7-b59e9f2e122e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f271ca5e-c573-1c48-35a7-b59e9f2e122e@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 07:27:06PM +0200, David Hildenbrand wrote:
> >> GUP would see MIGRATE_ISOLATE and would reject pinning. The page has to
> >> be migrated, which can fail if the page is temporarily unmovable.
> > 
> > Why is the page temporarily unmovable? The GUP didn't increase the
> > refcount in the case. If it's not migrabtable, that's not a fault
> > from the GUP but someone is already holding the temporal refcount.
> > It's not the scope this patchset would try to solve it.
> 
> You can have other references on the page that turn it temporarily
> unmovable, for example, via FOLL_GET, short-term FOLL_PIN.

Sure. However, user didn't passed the FOLL_LONGTERM. In that case,
the temporal page migration failure was expected.
What we want to guarantee for successful page migration is only
FOLL_LONGTERM.

If you are talking about the general problem(any GUP API without
FOLL_LONGTERM flag which is supposed to be short-term could turn
into long-term pinning by several reasons - I had struggled with
those issues - FOLL_LONGTERM is misnormer to me), yeah, I agree
we need to fix it but it's orthgonal issue.

> 
> > 
> >>
> >> See my point? We will try migrating in cases where we don't have to
> > 
> > Still not clear for me what you are concerning.
> > 
> >> migrate. I think what we would want to do is always reject pinning a CMA
> >> page, independent of the isolation status. but we don't have that
> > 
> > Always reject pinning a CMA page if it is *FOLL_LONGTERM*
> 
> Yes.
> 
> > 
> >> information available.
> > 
> > page && (MIGRATE_CMA | MIGRATE_ISOLATE) && gup_flags is not enough
> > for it?
> > 
> >>
> >> I raised in the past that we should look into preserving the migration
> >> type and turning MIGRATE_ISOLATE essentially into an additional flag.
> >>
> >>
> >> So I guess this patch is the right thing to do for now, but I wanted to
> >> spell out the implications.
> > 
> > I want but still don't understand what you want to write further
> > about the implication parts. If you make more clear, I am happy to
> > include it.
> 
> What I am essentially saying is that when rejecting to long-term
> FOLL_PIN something that is MIGRATE_ISOLATE now, we might now end up
> having to migrate pages that are actually fine to get pinned, because
> they are not actual CMA pages. And any such migration might fail when
> pages are temporarily unmovable.

Now I understand concern. Then how about introducing cma areas list
and use it instead of migrate type in is_pinnable_page

struct cma  {
  ..
  ..
  list_head list
};

bool is_cma_page(unsigned long pfn) {
    for cma in cma_list
      if (pfn >= cma->base_pfn && pfn < cma->base_pfn + count
        return true;

    return false;
}

Do you want to fix it at this moment or just write down the
possibility in the description and then we could fix once it
really happens later?

> 
> 
> > 
> >>
> >>>
> >>> A thing to get some attention is whether we need READ_ONCE or not
> >>> for the local variable mt.
> >>>
> >>
> >> Hmm good point. Staring at __get_pfnblock_flags_mask(), I don't think
> >> there is anything stopping the compiler from re-reading the value. But
> >> we don't care if we're reading MIGRATE_CMA or MIGRATE_ISOLATE, not
> >> something in between.
> > 
> > How about this?
> > 
> >      CPU A                                                      CPU B
> > 
> > is_pinnable_page
> >   ..
> >   ..                                                set_pageblock_migratetype(MIGRATE_ISOLATE)
> >   mt == MIGRATE_CMA
> >     get_pageblock_miratetype(page)
> >         returns MIGRATE_ISOLATE
> >   mt == MIGRATE_ISOLATE                             set_pageblock_migratetype(MIGRATE_CMA)
> >     get_pageblock_miratetype(page)
> >         returns MIGRATE_CMA
> >  
> > So both conditions fails to detect it.
> 
> I think you're right. That's nasty.

Ccing Paul to borrow expertise. :)

int mt = get_pageblock_migratetype(page);

if (mt == MIGRATE_CMA)
  return true;

if (mt == MIGRATE_ISOLATE)
  return true;

I'd like to keep use the local variable mt's value in folloing
conditions checks instead of refetching the value from
get_pageblock_migratetype.

What's the right way to achieve it?

Thanks in advance!
