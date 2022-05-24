Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE18532DBE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 17:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238974AbiEXPng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 11:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236863AbiEXPnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 11:43:31 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C6D972A4
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 08:43:30 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id p13-20020a17090a284d00b001e0817e77f6so1533842pjf.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 08:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pf0+E+bPvDSgYa/T7iTzIo9HKHg3McchanAWaQlbysQ=;
        b=B5MiMKVQlemTDS03gOO/L3KJ9t7GDmbf79xoMfDT2pfTS1Vq3o0JFHoY7NhoPXPN3Q
         bjRJfqbbcNyYGviExfIPZtiXa5AgXYL8e+4ig+ySXNpoa3BhMeMTypPT2jcwFqTK+wT1
         +AtNYgGdF094q1EvfUsc2ZWZuvdjqoS4fBuo/gj5qR3euhWvR2yDH28pkDLknWOlCHxe
         nYYZH+uohQSCficiCRJcW4R3iS8uAjG/lDgSA184BZo8Yn91hjigBNPZuLmAhZPat8Aq
         thtcd4Q9lyaAiCrccollE1aIqU2wae4maucrm+Ts4rKdcQaAuHo+vA99qDMmfWGfn0Cp
         KodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=pf0+E+bPvDSgYa/T7iTzIo9HKHg3McchanAWaQlbysQ=;
        b=ZNHCtfLC/MydqHbeIDezex7daLZXeqKcOGz2nAwQlyHrJaRPao0FJzMmL8Zpia8yqP
         zdfMiQaDVtK4NFjXdzgLR90iiw8GEUaMl7XxSM6T2xq9o+dqtyaYBLzQ0Ot5cN3aCOLV
         Xus7fTCBmLaRi8dDrhTfbbPSg2DUzN8kqs5sT5CIGFgAwXVEYoiefGlJBtqAHjpaKk2s
         Nvy6ZseZpqZXyq3GsoH5LK8fes2grnttPXXWeF6xRDdsWU1hvmxad8ux3iZm0000kDat
         xuu7TSD/tuWlR8RnupaqoNZz6L1dqRmJZ+V21H4jjvjf4VyU6HUt9prov3VgFi9TkWcn
         yplg==
X-Gm-Message-State: AOAM533Y47Xv9zEFdv2s/IuVEemM2CgRqgFuZRlC1p5bGU4Qlu1O2zhg
        pEOFziGYENBOehWQ+2G7v18+gZfYDMA=
X-Google-Smtp-Source: ABdhPJx8hC6Hbv5o9ECk8v8Rv0hySyLeU0gITGRF2Cj+MALKpzJkb6XVz8ARiwmqWuy0Q0pY0vfO0Q==
X-Received: by 2002:a17:902:d58f:b0:161:9abd:cff1 with SMTP id k15-20020a170902d58f00b001619abdcff1mr27696008plh.135.1653407009504;
        Tue, 24 May 2022 08:43:29 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:20f:8bc7:9098:371f])
        by smtp.gmail.com with ESMTPSA id i23-20020a056a00225700b0050dc7628168sm9506489pfu.66.2022.05.24.08.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 08:43:28 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 24 May 2022 08:43:27 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Message-ID: <Yoz9H95uXbjoKwdC@google.com>
References: <aafc0954-80df-dceb-03f2-2caea29cbbda@nvidia.com>
 <YnyCqwY4DxcZ/NjM@google.com>
 <20220517140049.GF63055@ziepe.ca>
 <ef901bdb-6117-bad4-2f26-c80df270b86e@nvidia.com>
 <20220517192825.GM63055@ziepe.ca>
 <b6eef200-43d1-7913-21ed-176b05fcb4fe@nvidia.com>
 <You3Q/VFaCoS0mC8@google.com>
 <bcb95d6b-4507-8836-cf17-7c3cd179a3da@nvidia.com>
 <YoxqSud9fvNXqo89@google.com>
 <20220524141937.GA2661880@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524141937.GA2661880@ziepe.ca>
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

On Tue, May 24, 2022 at 11:19:37AM -0300, Jason Gunthorpe wrote:
> On Mon, May 23, 2022 at 10:16:58PM -0700, Minchan Kim wrote:
> > On Mon, May 23, 2022 at 07:55:25PM -0700, John Hubbard wrote:
> > > On 5/23/22 09:33, Minchan Kim wrote:
> > > ...
> > > > > So then:
> > > > > 
> > > > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > > > index 0e42038382c1..b404f87e2682 100644
> > > > > +++ b/mm/page_alloc.c
> > > > > @@ -482,7 +482,12 @@ unsigned long __get_pfnblock_flags_mask(const struct page *page,
> > > > >          word_bitidx = bitidx / BITS_PER_LONG;
> > > > >          bitidx &= (BITS_PER_LONG-1);
> > > > > 
> > > > > -       word = bitmap[word_bitidx];
> > > > > +       /*
> > > > > +        * This races, without locks, with set_pageblock_migratetype(). Ensure
> > > >                                               set_pfnblock_flags_mask would be better?
> > > > > +        * a consistent (non-tearing) read of the memory array, so that results,
> > > > 
> > > > Thanks for proceeding and suggestion, John.
> > > > 
> > > > IIUC, the load tearing wouldn't be an issue since [1] fixed the issue.
> > > 
> > > Did it? [1] fixed something, but I'm not sure we can claim that that
> > > code is now safe against tearing in all possible cases, especially given
> > > the recent discussion here. Specifically, having this code do a read,
> > > then follow that up with calculations, seems correct. Anything else is
> > 
> > The load tearing you are trying to explain in the comment would be
> > solved by [1] since the bits will always align on a word and accessing
> > word size based on word aligned address is always atomic so there is
> > no load tearing problem IIUC.
> 
> That is not technically true. It is exactly the sort of thing
> READ_ONCE is intended to guard against.

Oh, does word access based on the aligned address still happen
load tearing? 

I just referred to
https://elixir.bootlin.com/linux/latest/source/Documentation/memory-barriers.txt#L1759

> 
> > Instead of the tearing problem, what we are trying to solve with
> > READ_ONCE is to prevent refetching when the function would be
> > inlined in the future.
> 
> It is the same problem, who is to say it doesn't refetch while doing
> the maths?

I didn't say it doesn't refetch the value without the READ_ONCE.

What I am saying is READ_ONCE(bitmap_word_bitidx] prevents "refetching"
issue rather than "tearing" issue in specific __get_pfnblock_flags_mask
context because I though there is no load-tearing issue there since
bitmap is word-aligned/accessed. No?

If the load tearing would still happens in the bitmap, it would be
better to keep last suggestion from John.

+       /*
+        * This races, without locks, with set_pfnblock_flags_mask(). Ensure
+        * a consistent read of the memory array, so that results, even though
+        *  racy, are not corrupted.
+        */

