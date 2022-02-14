Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3CB4B41F9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 07:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240838AbiBNG21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 01:28:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiBNG20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 01:28:26 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D554C55499
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 22:28:18 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id u3so16324192oiv.12
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 22:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=DdJUI5FTpYGzpyS2d91zd0UtXmPra7JlEA7vdJLkTz8=;
        b=Zwy3NLdy3OJuLKssvPEmtNN+TKK1BWI/R4Fd+WIZ/Rwu4v9y5kfejhJ2a+ckbtA2a5
         aLSAS19N4u5nc1tBwV/oU1/lAE1TQh1MqvzhBMMy/gmRxNndufsnMcegq5MoBLIc8wz8
         Vp/45FY1f5AHK+W2di1F6xrLhDm8eJqyhf2hurwe2FAeziKRimNdnYkYeUVHfO8nLNJi
         9onpXsRNAj+JcrJ/8QnuGKHlmHQknGj8s7Ei6/bBf4UbWL7kgFqv2XhWkfGPDMICgXg0
         grMC/FC9sLExmH3qhcL29u0GHFaLC81V+ToHGdhuWC8g8CznW9ljkN+tO8SlJaA9U5Ob
         R2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=DdJUI5FTpYGzpyS2d91zd0UtXmPra7JlEA7vdJLkTz8=;
        b=1jwEu3lYc8xK7zrtS7zOhbSe32Lcp6onVFHaqJLVD/6roE6k5ii2tvHCoK8XAe5c0X
         ECS9cM281M4OItdGmV8CjbSKDokBgh6lQ0Spc8lVAbMugVoNXv5C562S1mXni5D6gsR8
         eQQH21T/DBQYxlKuRbDFKZQO3GamMao6T/B7nHfSA04TNfdLp/PJghpN0EkXWdOP8Q3v
         6gjaTD1F+4sS5/hAJuOf5u76kMQ/o//ng3Ba97Jyq8GlT3l2pdElm8FWfwV/jvv6bOAv
         ryPHSj183h20HlBvYyq+7OdCPWcV6Vywg65U2K/LM1eVb7DmWHnmnjsys9876lZeBtYb
         C9PA==
X-Gm-Message-State: AOAM532u/PRWFgDP5hK7h5jq3bNlAIfAw0e9M4Ncp2H1dDdTgxntB41t
        hziDs3Hnu8CjmhngmCCLAqAtWA==
X-Google-Smtp-Source: ABdhPJyZt0Xgmlu8ZlvkLQ3B0aktsKbWwbW9w83j+P1mpVhf2q+tWnCZI/6rqfNobw2s7ZdbZzwOJg==
X-Received: by 2002:a05:6808:140c:: with SMTP id w12mr5103513oiv.265.1644820097343;
        Sun, 13 Feb 2022 22:28:17 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a128sm12219256oob.17.2022.02.13.22.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 22:28:16 -0800 (PST)
Date:   Sun, 13 Feb 2022 22:28:14 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 06/13] mm/munlock: maintain page->mlock_count while
 unevictable
In-Reply-To: <0e2dbdf3-f831-abbb-5ca8-02c8d1ab1a01@suse.cz>
Message-ID: <db241e60-864e-b238-d83a-f822f87aa6df@google.com>
References: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com> <3d204af4-664f-e4b0-4781-16718a2efb9c@google.com> <0e2dbdf3-f831-abbb-5ca8-02c8d1ab1a01@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2022, Vlastimil Babka wrote:
> On 2/6/22 22:40, Hugh Dickins wrote:
> > @@ -72,19 +91,40 @@ void mlock_page(struct page *page)
> >   */
> >  void munlock_page(struct page *page)
> >  {
> > +	struct lruvec *lruvec;
> > +	int nr_pages = thp_nr_pages(page);
> > +
> >  	VM_BUG_ON_PAGE(PageTail(page), page);
> >  
> > +	lock_page_memcg(page);
> 
> Hm this (and unlock_page_memcg() below) didn't catch my attention until I
> see patch 10/13 removes it again. It also AFAICS wasn't present in the code
> removed by patch 1. Am I missing something or it wasn't necessary to add it
> in the first place?

Something is needed to stabilize page->memcg, whoops I'm way out of date,
folio->memcg_data, before trying to get the lock on the relevant lruvec.

In commit_charge(), Johannes gives us a choice between four tools:
	 * - the page lock
	 * - LRU isolation
	 * - lock_page_memcg()
	 * - exclusive reference

The original code was using TestClearPageLRU inside isolate_lru_page()
to do it (also happened to have the page lock, but one tool is enough).

But I chose to use lock_page_memcg() at this stage, because we want to
do the TestClearPageMlocked part of the business even when !PageLRU;
and I don't entirely love the TestClearPageLRU method, since one will
fail if two try it concurrently.

Later, when doing the pagevec implementation, it seemed to become
more natural to use the TestClearPageLRU method - because that's how
pagevec_lru_move_fn() does it, or did I have a stronger reason for
making a different choice at that stage?  Maybe: I might have been
trying to keep the different functions as similar as possible.

But really we have too many ways to do that same thing, and my
choices may have been arbitrary, according to mood.  (When Alex Shi
popularized the TestClearPageLRU method, I did devise a patch which
used the lock_page_memcg() method throughout instead; but it was not
obviously better, so I didn't waste anyone else's time with it.)

I'm afraid that looking here again has led me to wonder whether
__munlock_page() in the final (10/13 pagevec) implementaton is correct
to be using __operations in its !isolated case.  But I'll have to come
back and think about that another time, must push forward tonight.

Hugh

> 
> > +	lruvec = folio_lruvec_lock_irq(page_folio(page));
> > +	if (PageLRU(page) && PageUnevictable(page)) {
> > +		/* Then mlock_count is maintained, but might undercount */
> > +		if (page->mlock_count)
> > +			page->mlock_count--;
> > +		if (page->mlock_count)
> > +			goto out;
> > +	}
> > +	/* else assume that was the last mlock: reclaim will fix it if not */
> > +
> >  	if (TestClearPageMlocked(page)) {
> > -		int nr_pages = thp_nr_pages(page);
> > -
> > -		mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
> > -		if (!isolate_lru_page(page)) {
> > -			putback_lru_page(page);
> > -			count_vm_events(UNEVICTABLE_PGMUNLOCKED, nr_pages);
> > -		} else if (PageUnevictable(page)) {
> > -			count_vm_events(UNEVICTABLE_PGSTRANDED, nr_pages);
> > -		}
> > +		__mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
> > +		if (PageLRU(page) || !PageUnevictable(page))
> > +			__count_vm_events(UNEVICTABLE_PGMUNLOCKED, nr_pages);
> > +		else
> > +			__count_vm_events(UNEVICTABLE_PGSTRANDED, nr_pages);
> > +	}
> > +
> > +	/* page_evictable() has to be checked *after* clearing Mlocked */
> > +	if (PageLRU(page) && PageUnevictable(page) && page_evictable(page)) {
> > +		del_page_from_lru_list(page, lruvec);
> > +		ClearPageUnevictable(page);
> > +		add_page_to_lru_list(page, lruvec);
> > +		__count_vm_events(UNEVICTABLE_PGRESCUED, nr_pages);
> >  	}
> > +out:
> > +	unlock_page_lruvec_irq(lruvec);
> > +	unlock_page_memcg(page);
> >  }
> >  
> >  /*
