Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901784B97DB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 05:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbiBQErL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 23:47:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiBQErI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 23:47:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9513C1A3751
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 20:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645073213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w67bokXv1wnn2sDvhXuLtvR4gKRz+41c8sPAHA3v48M=;
        b=WdalS02kso22+bTIxdB97hoUWALbwzJhg1ag4wfYJ2Ta5y29ejVVrBzFDcIoln6TldfUdS
        cGEcPmGvvY8TkAdV6c5z4ywgJUNdxSTJORz7OMKnJMRg7jnuRxfuKyWEmf5hEfoT94U9cn
        SbWp0SQVGTNLCb78fN2dn0zDuZol7PE=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-tgs5gHBnPBO0CA9u2sKSQg-1; Wed, 16 Feb 2022 23:46:52 -0500
X-MC-Unique: tgs5gHBnPBO0CA9u2sKSQg-1
Received: by mail-pf1-f199.google.com with SMTP id d5-20020a623605000000b004e01ccd08abso2569710pfa.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 20:46:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w67bokXv1wnn2sDvhXuLtvR4gKRz+41c8sPAHA3v48M=;
        b=7vhPQv8YCzbA5AW1T3oii8DWb/48EWIvOepZEQsZy4CP8XBcQ+r/8G6EXLzrVMkQpF
         7DWMC5aJU3KEtGv5qKarv+B3Dbai7+NolIgvBs4/vZhgGzQDdAhlqZuE2Zf5qJ8GNJU4
         K9q6EebyWuKdSihwmlrAhRs3y9P1ee5+vZ3qlIqSpyYjLqTAz1m6r7/XcPUys5UmE+FY
         wjRWb2gPZhOzTRN2Jvb88+cuLU+i7DNu8wXbNI/9qd4miSvyDVyT4j101/8MY6vFlQ8i
         Ci5k6ee8GX0LTw8b/eipGOv0dNxIHpCK2T6N7enSEm6DEFRmkhYMqtgzvEOxPTv2kyJW
         atTA==
X-Gm-Message-State: AOAM533oXqHD0Low2gP6x3zY8TZUeG5nkOw/En7Xa7R7m7sIlFjMAm5J
        9KzaTXCvW5iiZe+jWrPXwYEATtvErFImDyLbiKKfu2Ndk6jZnZdTRtWwBlFPBmy+OFwdIzAg4s0
        myGUq4S2qNTRzFV/C3claXzSU
X-Received: by 2002:a17:902:ea09:b0:14d:9644:6f03 with SMTP id s9-20020a170902ea0900b0014d96446f03mr1270235plg.110.1645073211119;
        Wed, 16 Feb 2022 20:46:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJypK27oNtj2dgWzTF2J96OC/kIj9OSuLw/VdHj5CfJxFDd6QPZLvNSUGDUBjHfWS1Rb5182HQ==
X-Received: by 2002:a17:902:ea09:b0:14d:9644:6f03 with SMTP id s9-20020a170902ea0900b0014d96446f03mr1270216plg.110.1645073210743;
        Wed, 16 Feb 2022 20:46:50 -0800 (PST)
Received: from xz-m1.local ([94.177.118.126])
        by smtp.gmail.com with ESMTPSA id k9sm47270513pfc.157.2022.02.16.20.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 20:46:44 -0800 (PST)
Date:   Thu, 17 Feb 2022 12:46:32 +0800
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v4 1/4] mm: Don't skip swap entry even if zap_details
 specified
Message-ID: <Yg3TKD6i9JjoRe80@xz-m1.local>
References: <20220216094810.60572-1-peterx@redhat.com>
 <20220216094810.60572-2-peterx@redhat.com>
 <da98141f-c8d8-f796-d8ec-352d9b2abd6a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <da98141f-c8d8-f796-d8ec-352d9b2abd6a@nvidia.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 07:15:30PM -0800, John Hubbard wrote:
> On 2/16/22 1:48 AM, Peter Xu wrote:
> > The "details" pointer shouldn't be the token to decide whether we should skip
> > swap entries.  For example, when the user specified details->zap_mapping==NULL,
> > it means the user wants to zap all the pages (including COWed pages), then we
> > need to look into swap entries because there can be private COWed pages that
> > was swapped out.
> 
> Hi Peter,
> 
> The changes look good, just some minor readability suggestions below:
> 
> (btw, hch is going to ask you to reflow all of the commit descriptions
> to 72 cols, so you might as well do it in advance. :)

Thanks for the heads-up. :)

I personally used 78/79 col width for a long time for different projects, but
sure I can adjust my config.  I found that the "official guide" points us to
75 instead:

https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html

  The body of the explanation, line wrapped at 75 columns, which will be copied
  to the permanent changelog to describe this patch.

I'll follow that.

[...]

> > @@ -1320,11 +1331,15 @@ struct zap_details {
> >  static inline bool
> >  zap_skip_check_mapping(struct zap_details *details, struct page *page)
> >  {
> > -	if (!details || !page)
> > +	/* If we can make a decision without *page.. */
> > +	if (should_zap_cows(details))
> >  		return false;
> >  
> > -	return details->zap_mapping &&
> > -		(details->zap_mapping != page_rmapping(page));
> > +	/* E.g. zero page */
> 
> It's a bit confusing to see a comment that "this could be the zero page", if 
> the value is NULL. Maybe, "the caller passes NULL for the case of a zero 
> page", or something along those lines? 

It didn't show much difference here.. but for sure I can coordinate.

> 
> 
> > +	if (!page)
> > +		return false;
> > +
> > +	return details->zap_mapping != page_rmapping(page);
> >  }
> >  
> >  static unsigned long zap_pte_range(struct mmu_gather *tlb,
> > @@ -1405,17 +1420,29 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> >  			continue;
> >  		}
> >  
> > -		/* If details->check_mapping, we leave swap entries. */
> > -		if (unlikely(details))
> > -			continue;
> > -
> > -		if (!non_swap_entry(entry))
> > +		if (!non_swap_entry(entry)) {
> > +			/*
> > +			 * If this is a genuine swap entry, then it must be an
> > +			 * private anon page.  If the caller wants to skip
> > +			 * COWed pages, ignore it.
> > +			 */
> 
> How about this instead:
> 
> 			/* Genuine swap entry, and therefore a private anon page. */

Yes the last sentence is kind of redundant.

> 
> > +			if (!should_zap_cows(details))
> > +				continue;
> >  			rss[MM_SWAPENTS]--;
> > -		else if (is_migration_entry(entry)) {
> 
> Can we put a newline here, and before each "else" block? Because now it
> is getting very dense, and the visual separation really helps.

The thing is we don't have a rule to add empty lines here, or do we?  Changing
it could make it less like what we have had.

Personally it looks fine, because separations are done with either new lines or
indents.  Here it's done via indents, IMHO.

> 
> > +		} else if (is_migration_entry(entry)) {
> >  			struct page *page;
> >  
> >  			page = pfn_swap_entry_to_page(entry);
> > +			if (zap_skip_check_mapping(details, page))
> > +				continue;
> >  			rss[mm_counter(page)]--;
> 
> Newline here.
> 
> > +		} else if (is_hwpoison_entry(entry)) {
> > +			/* If the caller wants to skip COWed pages, ignore it */
> 
> Likewise, I'd prefer we delete that comment, because it exactly matches 
> what the following line of code says.

Will do.

> 
> > +			if (!should_zap_cows(details))
> > +				continue;
> 
> And newline here too.
> 
> > +		} else {
> > +			/* We should have covered all the swap entry types */
> > +			WARN_ON_ONCE(1);
> >  		}
> >  		if (unlikely(!free_swap_and_cache(entry)))
> >  			print_bad_pte(vma, addr, ptent, NULL);
> 
> Those are all just nits, and as I mentioned, the actual changes look good
> to me, so:
> 
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>

Thanks,

-- 
Peter Xu

