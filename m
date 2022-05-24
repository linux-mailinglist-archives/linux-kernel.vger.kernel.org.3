Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6DD532C1A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 16:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238135AbiEXOTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 10:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbiEXOTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 10:19:41 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FDD5E77B
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 07:19:39 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id l82so10416597qke.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 07:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QIFSK7+q86peBNyVF83M929mz5YDWsMa1JplQe+w7Nk=;
        b=Inf+g6txiTsyfphgQvO6mWRJ0v2To4UMd2hLgKSIOSaHtvXY9tUdBiG+GrrEWQMeK2
         rWOuSOQTj/E5eMu/jSqWLm7Nbe8hdaxY6Ggwc4waFUwhOuvk9hlhjwxdWpAoBlbtoKPN
         +SOriD+ZQERrpaJIrmNopEBCZ2I3BI8eH49U+QHxrGYEXxEBFT8RQ8sKJSWa6dzw0tzL
         eK04TQZtOe7bCaXApA7M4/uIcyLGkys5YB3GAzxwHtwmLg14bMbQazrJJ7m6K5PSukNM
         HDQA6l1EQ/0e1NLgpwTzX+g/77xLqkvirgqiANe0VnOa81F3Zze9KIf1Wcz5nQbUl2j+
         JAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QIFSK7+q86peBNyVF83M929mz5YDWsMa1JplQe+w7Nk=;
        b=CzKNrbHH1MiPUGb4K+QIEWm0OJ+Ij2cYSeXgIu41HiYvHCmOW09XDXWTAZHB/R4Dqv
         LMaDV3oTOs8nfD+A4kULU+PfwGxJBv/cZUSgwPz2sAshxubr3zOrqOWLBgBBD5KlHxV/
         sA1fDBoL1rFITcvviJN2LFBF/8qBhp0pIVS7dQtCyuW6PnLKWrdvIuOEYb6MmehElgIM
         HhRnaVwCrNzFkFXENYN2VB6FcUXzY2BhAZiJ8mu1VNJtcazVjCW+gXja/PSY7AUUkaxs
         3mXJyu9nplMIpuTpmD/ro6UawsWCN8GoD1Jy3owrmO3qwcxDME4u8mZrzFJIxZBRTPEi
         MLlA==
X-Gm-Message-State: AOAM530A038VoBMt2+yf+NsXptm2TOjQIUOmLN+QDacDa9De1nydYM9R
        UNotWN1FLS9NX5QdaXHdUBC/iA==
X-Google-Smtp-Source: ABdhPJxOzDiG7VBFbmRvLO2WitMeyjUue0KUWacGzqB401AecLJ3spFnkhPVFUrtg2jKOjn3gxJ22A==
X-Received: by 2002:a05:620a:4544:b0:6a0:40ef:ca7a with SMTP id u4-20020a05620a454400b006a040efca7amr16839267qkp.754.1653401979010;
        Tue, 24 May 2022 07:19:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id w7-20020ac857c7000000b002f9303ce545sm5996376qta.39.2022.05.24.07.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 07:19:38 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1ntVNp-00BBym-J3; Tue, 24 May 2022 11:19:37 -0300
Date:   Tue, 24 May 2022 11:19:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Minchan Kim <minchan@kernel.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Message-ID: <20220524141937.GA2661880@ziepe.ca>
References: <0accce46-fac6-cdfb-db7f-d08396bf9d35@nvidia.com>
 <aafc0954-80df-dceb-03f2-2caea29cbbda@nvidia.com>
 <YnyCqwY4DxcZ/NjM@google.com>
 <20220517140049.GF63055@ziepe.ca>
 <ef901bdb-6117-bad4-2f26-c80df270b86e@nvidia.com>
 <20220517192825.GM63055@ziepe.ca>
 <b6eef200-43d1-7913-21ed-176b05fcb4fe@nvidia.com>
 <You3Q/VFaCoS0mC8@google.com>
 <bcb95d6b-4507-8836-cf17-7c3cd179a3da@nvidia.com>
 <YoxqSud9fvNXqo89@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoxqSud9fvNXqo89@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 10:16:58PM -0700, Minchan Kim wrote:
> On Mon, May 23, 2022 at 07:55:25PM -0700, John Hubbard wrote:
> > On 5/23/22 09:33, Minchan Kim wrote:
> > ...
> > > > So then:
> > > > 
> > > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > > index 0e42038382c1..b404f87e2682 100644
> > > > +++ b/mm/page_alloc.c
> > > > @@ -482,7 +482,12 @@ unsigned long __get_pfnblock_flags_mask(const struct page *page,
> > > >          word_bitidx = bitidx / BITS_PER_LONG;
> > > >          bitidx &= (BITS_PER_LONG-1);
> > > > 
> > > > -       word = bitmap[word_bitidx];
> > > > +       /*
> > > > +        * This races, without locks, with set_pageblock_migratetype(). Ensure
> > >                                               set_pfnblock_flags_mask would be better?
> > > > +        * a consistent (non-tearing) read of the memory array, so that results,
> > > 
> > > Thanks for proceeding and suggestion, John.
> > > 
> > > IIUC, the load tearing wouldn't be an issue since [1] fixed the issue.
> > 
> > Did it? [1] fixed something, but I'm not sure we can claim that that
> > code is now safe against tearing in all possible cases, especially given
> > the recent discussion here. Specifically, having this code do a read,
> > then follow that up with calculations, seems correct. Anything else is
> 
> The load tearing you are trying to explain in the comment would be
> solved by [1] since the bits will always align on a word and accessing
> word size based on word aligned address is always atomic so there is
> no load tearing problem IIUC.

That is not technically true. It is exactly the sort of thing
READ_ONCE is intended to guard against.

> Instead of the tearing problem, what we are trying to solve with
> READ_ONCE is to prevent refetching when the function would be
> inlined in the future.

It is the same problem, who is to say it doesn't refetch while doing
the maths?

Jason
