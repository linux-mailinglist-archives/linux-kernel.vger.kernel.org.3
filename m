Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733B25227AA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 01:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237882AbiEJXbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 19:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbiEJXbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 19:31:36 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B5FEAA
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 16:31:34 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id bo5so480186pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 16:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fi2XWZRiKG8R44JA1gyWZVRd9uVzp+b2EIhv+c2c8l4=;
        b=daMLt6RwVmSTYqST1VgoWQAqKYEkpL6JH/mgdIrY9J9RlIBlGx5J18pgdxeVhAT51q
         B1Qzih1qJ88fUPbO9n0bFHQAl10/uHoiAoSoEKC2WdBuQPyMS0jUS6F6vO009HFbFM7R
         lsNs1t9FcZ9+uli78UzHHgS5kz2dV56JeVDtsJH16TIaC/3qjuPFpig8rMnPEjPhzA1q
         g/5iUvSk6JFhWP4oJdrRaLWRdnw3roKfwUJS2h6M0chCKReDkzoKyB4bDWNMSunbfcIL
         5XemXTHIaEPxFkvdhteyaTKl1sNWTAI8mW9Q4uCO0YPb/5/Vf4mn2gRhKMF3gOc2BUlh
         bkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=fi2XWZRiKG8R44JA1gyWZVRd9uVzp+b2EIhv+c2c8l4=;
        b=xTsQrrkypvTCC/3RqXCiFWDaRLOpC/AELJlJOIbW+DlnAe0lwXTLP27rMGrPGazMTr
         i+quXz+JXi8OV6FXbMT8eAhacG2UvupigS/YiU4/VAtNkkxrVvzge6xkJtlT+8c4RFmN
         JOK39YcWTP8yvZwP7lj9Fz1AvbNfnimIT5Abfv+H04xD8R92XVhy0se5/AjnriMa5qk+
         hVta1sNXC0E1XQo9r9CJttAka4u3f0f5WTYBi6nqOAUzvAWlDHTk5PlTYLyd+C7knrnU
         FcYBKWUtOB5+LF7bZTJVgXSTex1qx3dut2aw/bVKX0dFtv64n3B5KhXRE7AcvhI5Gwwj
         lUqg==
X-Gm-Message-State: AOAM530HcnHz4NbCx/NJa9z6Shv5L3XDRSfYRno9NmFfhD6sp5RrBBdl
        xwaevjUCZLi8jKqjljVqtTg=
X-Google-Smtp-Source: ABdhPJxhcy+qVFIs4/FlGIm+uBUr5exz2tDeB3rAyEeMMkubJAQ0OJg8ALIK0cB2aH+6+mGDz7OYXQ==
X-Received: by 2002:a63:747:0:b0:3d4:8682:ca7e with SMTP id 68-20020a630747000000b003d48682ca7emr4853580pgh.137.1652225493460;
        Tue, 10 May 2022 16:31:33 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:c98a:65b0:edca:b69a])
        by smtp.gmail.com with ESMTPSA id m8-20020a6545c8000000b003c14af5062csm260945pgr.68.2022.05.10.16.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 16:31:33 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 10 May 2022 16:31:31 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Message-ID: <Ynr10y6pkH6WwbQo@google.com>
References: <20220510211743.95831-1-minchan@kernel.org>
 <857d21da-5de2-fa3e-b1ce-41cc1cfb0191@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <857d21da-5de2-fa3e-b1ce-41cc1cfb0191@nvidia.com>
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

Hi John,

On Tue, May 10, 2022 at 03:56:37PM -0700, John Hubbard wrote:
> On 5/10/22 14:17, Minchan Kim wrote:
> > Pages on CMA area could have MIGRATE_ISOLATE as well as MIGRATE_CMA
> > so current is_pinnable_page could miss CMA pages which has MIGRATE_
> > ISOLATE. It ends up pinning CMA pages as longterm at pin_user_pages
> > APIs so CMA allocation keep failed until the pin is released.
> > 
> > 
> >       CPU 0                                   CPU 1 - Task B
> > 
> > cma_alloc
> > alloc_contig_range
> > 					pin_user_pages_fast(FOLL_LONGTERM)
> > change pageblock as MIGRATE_ISOLATE
> > 					internal_get_user_pages_fast
> >                                          lockless_pages_from_mm
> >                                          gup_pte_range
> >                                          try_grab_folio
> >                                          is_pinnable_page
> >                                            return true;
> >                                          So, pinned the page successfully.
> > page migration failure with pinned page
> > 					..
> >                                          .. After 30 sec
> > 					unpin_user_page(page)
> > 
> > CMA allocation succeeded after 30 sec.
> 
> Hi Minchan,
> 
> Thanks for spelling out how this works, that really speeds up the
> review and helps others quickly learn what is going on with the code.
> 
> For my own information, mainly: where is CMA blocking, so that
> it waits (apparently) for the during of the pin, before proceeding?
> (Or is the caller retrying?)

It would fail the cma_alloc in the first place since it couldn't
migrate page out due to the elevated refcount and cma_allc would
proceed next pageblocks to keep pages migrated out but it ends up
failing the cma allocation because the user tries to allocate
entire CMA pageblocks, not part of them so one of the pinned page
make the cma allocation failure. Since then, user(e.g., dmabuf)
could retry a few more times but it keeps failed until Task B
release the refcount of the page.

> 
> I noticed a few minor points but was too slow to reply, notes below:
> 
> > 
> > The CMA allocation path protects the migration type change race
> > using zone->lock but what GUP path need to know is just whether the
> > page is on CMA area or not rather than exact migration type.
> > Thus, we don't need zone->lock but just checks migration type in
> > either of (MIGRATE_ISOLATE and MIGRATE_CMA).
> > 
> > Adding the MIGRATE_ISOLATE check in is_pinnable_page could cause
> > rejecting of pinning pages on MIGRATE_ISOLATE pageblocks even
> > though it's neither CMA nor movable zone if the page is temporarily
> > unmovable. However, such a migration failure by unexpected temporal
> > refcount holding is general issue, not only come from MIGRATE_ISOLATE
> > and the MIGRATE_ISOLATE is also transient state like other temporal
> > elevated refcount problem.
> > 
> > Cc: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> > * from v3 - https://lore.kernel.org/all/20220509153430.4125710-1-minchan@kernel.org/
> >    * Fix typo and adding more description - akpm
> > 
> > * from v2 - https://lore.kernel.org/all/20220505064429.2818496-1-minchan@kernel.org/
> >    * Use __READ_ONCE instead of volatile - akpm
> > 
> > * from v1 - https://lore.kernel.org/all/20220502173558.2510641-1-minchan@kernel.org/
> >    * fix build warning - lkp
> >    * fix refetching issue of migration type
> >    * add side effect on !ZONE_MOVABLE and !MIGRATE_CMA in description - david
> > 
> >   include/linux/mm.h | 15 +++++++++++++--
> >   1 file changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 6acca5cecbc5..cbf79eb790e0 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -1625,8 +1625,19 @@ static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
> >   #ifdef CONFIG_MIGRATION
> >   static inline bool is_pinnable_page(struct page *page)
> >   {
> > -	return !(is_zone_movable_page(page) || is_migrate_cma_page(page)) ||
> > -		is_zero_pfn(page_to_pfn(page));
> > +#ifdef CONFIG_CMA
> > +	/*
> > +	 * use volatile to use local variable mt instead of
> > +	 * refetching mt value.
> > +	 */
> 
> This comment is stale and should therefore be deleted.

Yeah.

> 
> > +	int __mt = get_pageblock_migratetype(page);
> > +	int mt = __READ_ONCE(__mt);
> 
> Although I saw the email discussion about this in v2, that discussion
> didn't go far enough. It started with "don't use volatile", and went
> on to "try __READ_ONCE() instead", but it should have continued on
> to "you don't need this at all".

That's really what I want to hear from experts so wanted to learn
"Why". How could we prevent refetching of the mt if we don't use
__READ_ONCE or volatile there?

> 
> Because you don't. There is nothing you are racing with, and adding
> __READ_ONCE() in order to avoid a completely not-going-to-happen
> compiler re-invocation of a significant code block is just very wrong.
> 
> So let's just let it go entirely. :)

Yeah, once it's clear for everyone, I am happy to remove the
unnecessary lines.

> 
> > +
> > +	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
> 
> MIGRATE_ISOLATE is not always defined, and must therefore be protected
> with a check on CONFIG_MEMORY_ISOLATION...oh never mind, I see in
> mm/Kconfig:
> 
> config CMA
> 	...
> 	select MEMORY_ISOLATION
> 
> ...so that's OK. What a tangled web, I wonder if enum migratetype
> really needs to be sliced up like that, but that's a separate topic.
> 
> > +		return false;
> > +#endif
> > +
> > +	return !(is_zone_movable_page(page) || is_zero_pfn(page_to_pfn(page)));
> 
> And actually this area is getting rather nested with the various ifdefs,
> and it is probably time to refactor them a bit, considering the above
> point about MIGRATE_ISOLATE. I had something in mind (which is why I
> delayed my feedback), along the lines of merging _ISOLATE and _CMA and
> the ifdefs. But it's just a fine point and not critical of course, just
> a thought.

Glad to hear someone is looking that.
