Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6EA53187D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238949AbiEWQdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238906AbiEWQdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:33:12 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3D068316
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:33:10 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id z11so4716772pjc.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5tDQKdG9kWYVmaajJtTxi2aIE/n1fHAJvs7gBOrSJGE=;
        b=CAFc6Kb4a5jeMcq2Dm8+NXWFdVfri+0CMXOrtJfbFy8rYFJOVsgzYgP5RkVh8WiCrx
         LoeKKjGqPpQBUnTPlu/1aVACw7f7JTPh1wQz7tlp4HzgDc/wLR7HAaN3hKjqZSHd3k6U
         aHvxNB/5PaVPb4M8IMJSEM0G7pBZMsK8JUoJvqFL0APZGh9b8F5iP1O/S6fzrZDBzXxn
         o4wP59lVv66pYHK4jRKELx9uuYfqz5oEDYK9VRK2mSiaW+N3Nh0BdbwTsxCJnkYSJjjK
         PW12BXF08oZrEy6WfQYdfHVhb1CS9f9llxXdSukzBvz9l6iQLiil5bWcYN6g+iJp5Q6s
         X/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=5tDQKdG9kWYVmaajJtTxi2aIE/n1fHAJvs7gBOrSJGE=;
        b=auAX0n2UPsQ2bb86KSv+4CXWpA8ik3Y77NH47RKMUrCACIoY9Ex7o+g5q2mxXILTiQ
         8uiek+ofQptpco7gan0TvlKuAOoOAinYoDAcTx+n4jQZhXEndCscDVxHoJ3zAhcvwIVv
         kW0smb1TICFu2yLN9MYMuHYyRq80c+iVBoSQap949NM/EDS5btf2az2XuZlYMiI97Sda
         9V5zhP7VZJ6C1VYeFstduu3vGBDllXfXD/IukfeOccCVUlayXvoTNl3u0mJ6R2bh2G0D
         a1lE515rKIfAnC5oA6LyQxHU1+ADNZ5qiC5id8pviOt2uPUgSz3amhNBBPgzYuQ1NrLk
         mQlA==
X-Gm-Message-State: AOAM530rErgA3D7bzgpLJ+/+3tId6dx1DdRKFeJ3u8+uedVX2ojWcf/v
        SbhsRy2zlzMI28cIa/zLOw1uVDQm5ao=
X-Google-Smtp-Source: ABdhPJy0Ls1q3U+6SXA1GvTCL9MA14HVQwtc71UoWl6XdWj6+Juk7OWFUyB+iphXKqZQJTySlj/rKA==
X-Received: by 2002:a17:902:ce84:b0:162:cbe:f39a with SMTP id f4-20020a170902ce8400b001620cbef39amr10584283plg.79.1653323589739;
        Mon, 23 May 2022 09:33:09 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:c004:5d89:478f:e308])
        by smtp.gmail.com with ESMTPSA id y6-20020aa78546000000b0051844f3f637sm4242350pfn.40.2022.05.23.09.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 09:33:09 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 23 May 2022 09:33:07 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Message-ID: <You3Q/VFaCoS0mC8@google.com>
References: <f7ff4186-e629-a5da-3f4d-ec629b0c8dd9@nvidia.com>
 <20220512004949.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnxczoehQJ+x6m9Y@google.com>
 <0accce46-fac6-cdfb-db7f-d08396bf9d35@nvidia.com>
 <aafc0954-80df-dceb-03f2-2caea29cbbda@nvidia.com>
 <YnyCqwY4DxcZ/NjM@google.com>
 <20220517140049.GF63055@ziepe.ca>
 <ef901bdb-6117-bad4-2f26-c80df270b86e@nvidia.com>
 <20220517192825.GM63055@ziepe.ca>
 <b6eef200-43d1-7913-21ed-176b05fcb4fe@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6eef200-43d1-7913-21ed-176b05fcb4fe@nvidia.com>
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

On Tue, May 17, 2022 at 01:12:02PM -0700, John Hubbard wrote:
> On 5/17/22 12:28, Jason Gunthorpe wrote:
> > > If you compare this to the snippet above, you'll see that there is
> > > an extra mov statement, and that one dereferences a pointer from
> > > %rax:
> > > 
> > >      mov    (%rax),%rbx
> > 
> > That is the same move as:
> > 
> >     mov    0x8(%rdx,%rax,8),%rbx
> > 
> > Except that the EA calculation was done in advance and stored in rax.
> > 
> > lea isn't a memory reference, it is just computing the pointer value
> > that 0x8(%rdx,%rax,8) represents. ie the lea computes
> > 
> >    %rax = %rdx + %rax*8 + 6
> > 
> > Which is then fed into the mov. Maybe it is an optimization to allow
> > one pipe to do the shr and an other to the EA - IDK, seems like a
> > random thing for the compiler to do.
> 
> Apologies for getting that wrong, and thanks for walking me through the
> asm.
> 
> [...]
> > 
> > Paul can correct me, but I understand we do not have a list of allowed
> > operations that are exempted from the READ_ONCE() requirement. ie it
> > is not just conditional branching that requires READ_ONCE().
> > 
> > This is why READ_ONCE() must always be on the memory load, because the
> > point is to sanitize away the uncertainty that comes with an unlocked
> > read of unstable memory contents. READ_ONCE() samples the value in
> > memory, and removes all tearing, multiload, etc "instability" that may
> > effect down stream computations. In this way down stream compulations
> > become reliable.
> > 
> > Jason
> 
> So then:
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0e42038382c1..b404f87e2682 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -482,7 +482,12 @@ unsigned long __get_pfnblock_flags_mask(const struct page *page,
>         word_bitidx = bitidx / BITS_PER_LONG;
>         bitidx &= (BITS_PER_LONG-1);
> 
> -       word = bitmap[word_bitidx];
> +       /*
> +        * This races, without locks, with set_pageblock_migratetype(). Ensure
                                                 
                                             set_pfnblock_flags_mask would be better?
                          
> +        * a consistent (non-tearing) read of the memory array, so that results,

Thanks for proceeding and suggestion, John.

IIUC, the load tearing wouldn't be an issue since [1] fixed the issue. 

The concern in our dicussion was aggressive compiler(e.g., LTO) or code refactoring
to make the code inline in *future* could potentially cause forcing refetching(i.e.,
re-read) tie bitmap[word_bitidx].

If so, shouldn't the comment be the one you helped before?

/*
 * Defend against future compiler LTO features, or code refactoring
 * that inlines the above function, by forcing a single read. Because,
 * re-reads of bitmap[word_bitidx] by inlining could cause trouble
 * for whom believe they use a local variable for the value.
 */

[1] e58469bafd05, mm: page_alloc: use word-based accesses for get/set pageblock bitmaps

> +        * even though racy, are not corrupted.
> +        */
> +       word = READ_ONCE(bitmap[word_bitidx]);
>         return (word >> bitidx) & mask;
>  }
> 
> 
> thanks,
> -- 
> John Hubbard
> NVIDIA
