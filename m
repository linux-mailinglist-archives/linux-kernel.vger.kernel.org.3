Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18B54B94DA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 01:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238667AbiBQANd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 19:13:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiBQANb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 19:13:31 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B6B2A0D5F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 16:13:18 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id d7so1086580ilf.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 16:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eDkDJp0W+TGI2PKdmA1svRD0zMvxreAEeyOGvxc2rHY=;
        b=IjelJn0CvWn6f63gveYbF2hM3Cey98RR9lPq/Z4J6mwKQUVqLGQm8xtclnxQzP6AyQ
         FNpZ1ydKfxvkqQdng+buUE79I5Xgb97KYVDniAPQvL96/EsGhkpe38ryBtTn/tN4nLS7
         CjzF76sMAmXrUlxA1KYLLY99fVFDwH1S33SkcYrmqETzWXtplb/1asoRXAREUE3nNtsi
         ovLLLiTsDWNOyDNJVeZWFZ/TLOa6o+GllsrquHV7+in+38aepeVNEhH1Ylz0oju5emdf
         jdpMpOBRcD0k7wZZ6M8g/mPwTfWts5T/MaD7SSx9RoD04UEic0qCX2igoAmMyxlZXcay
         YPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eDkDJp0W+TGI2PKdmA1svRD0zMvxreAEeyOGvxc2rHY=;
        b=UH8HxImsztx72bbwr/c10l9tPy71nQwoavTKfOa/436HlCfOPuWoeWA1447skj8/pK
         Ex0PxkHtJrCf9QiGOPgpIyi/6C/jC9foGkA3cE8YcPTeD0gia5mx36cEEVr4O8MZfH1I
         zZfH76z+q579K/YMjvLDNQ9asrCEgqIZcddyMuSJsai/RTilf1/82D7wS9wDChXtxEJR
         Jp5dB/40Blu15u2Tc+IDp5RrYt+hFvwDv4eO1+Jp4a9dV3mL80DRRkVlwBHON49i9l37
         tUFrwW6V5Vfn9MPSpEDFAsNVn90Eb0UXoQP9QHHvFkyO/e3YyyzDP2akMSjks2xx0hfO
         T3eA==
X-Gm-Message-State: AOAM5331hXjHOO7e62trGE+cCLcurH8qyQVZxoWCpZcDuupLcG+asen4
        O2UdpTKzwpO1S/7EYGaVnZdim7/i8vxovgeU
X-Google-Smtp-Source: ABdhPJxoHtl1atRf/3OEaZW/KOI1eZbyM33kmHCph2zTG6d/i4c11kCCNXgE+z6D5y19FGpi8IZLBw==
X-Received: by 2002:a05:6e02:b45:b0:2be:19d0:d73f with SMTP id f5-20020a056e020b4500b002be19d0d73fmr218408ilu.261.1645056797299;
        Wed, 16 Feb 2022 16:13:17 -0800 (PST)
Received: from google.com ([2620:15c:183:200:5929:5114:bf56:ccb6])
        by smtp.gmail.com with ESMTPSA id f13sm839961ion.18.2022.02.16.16.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 16:13:16 -0800 (PST)
Date:   Wed, 16 Feb 2022 17:13:13 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v7 05/12] mm: multigenerational LRU: minimal
 implementation
Message-ID: <Yg2TGSruRVMGpxqk@google.com>
References: <20220208081902.3550911-1-yuzhao@google.com>
 <20220213100417.1183-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220213100417.1183-1-hdanton@sina.com>
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

On Sun, Feb 13, 2022 at 06:04:17PM +0800, Hillf Danton wrote:

Hi Hillf,

> On Tue,  8 Feb 2022 01:18:55 -0700 Yu Zhao wrote:
> > +
> > +/******************************************************************************
> > + *                          the aging
> > + ******************************************************************************/
> > +
> > +static int folio_inc_gen(struct lruvec *lruvec, struct folio *folio, bool reclaiming)
> > +{
> > +	unsigned long old_flags, new_flags;
> > +	int type = folio_is_file_lru(folio);
> > +	struct lru_gen_struct *lrugen = &lruvec->lrugen;
> > +	int new_gen, old_gen = lru_gen_from_seq(lrugen->min_seq[type]);
> > +
> > +	do {
> > +		new_flags = old_flags = READ_ONCE(folio->flags);
> > +		VM_BUG_ON_FOLIO(!(new_flags & LRU_GEN_MASK), folio);
> > +
> > +		new_gen = ((new_flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
> 
> Is the chance zero for deadloop if new_gen != old_gen?

No, because the counter is only cleared during isolation, and here
it's protected again isolation (under the LRU lock, which is asserted
in the lru_gen_balance_size() -> lru_gen_update_size() path).

> > +		new_gen = (old_gen + 1) % MAX_NR_GENS;
> > +
> > +		new_flags &= ~LRU_GEN_MASK;
> > +		new_flags |= (new_gen + 1UL) << LRU_GEN_PGOFF;
> > +		new_flags &= ~(LRU_REFS_MASK | LRU_REFS_FLAGS);
> > +		/* for folio_end_writeback() */
> 
> 		/* for folio_end_writeback() and sort_folio() */ in terms of
> reclaiming?

Right.

> > +		if (reclaiming)
> > +			new_flags |= BIT(PG_reclaim);
> > +	} while (cmpxchg(&folio->flags, old_flags, new_flags) != old_flags);
> > +
> > +	lru_gen_balance_size(lruvec, folio, old_gen, new_gen);
> > +
> > +	return new_gen;
> > +}
> 
> ...
> 
> > +/******************************************************************************
> > + *                          the eviction
> > + ******************************************************************************/
> > +
> > +static bool sort_folio(struct lruvec *lruvec, struct folio *folio, int tier_idx)
> > +{
> 
> Nit, the 80-column-char format is prefered.

Will do.

> > +	bool success;
> > +	int gen = folio_lru_gen(folio);
> > +	int type = folio_is_file_lru(folio);
> > +	int zone = folio_zonenum(folio);
> > +	int tier = folio_lru_tier(folio);
> > +	int delta = folio_nr_pages(folio);
> > +	struct lru_gen_struct *lrugen = &lruvec->lrugen;
> > +
> > +	VM_BUG_ON_FOLIO(gen >= MAX_NR_GENS, folio);
> > +
> > +	if (!folio_evictable(folio)) {
> > +		success = lru_gen_del_folio(lruvec, folio, true);
> > +		VM_BUG_ON_FOLIO(!success, folio);
> > +		folio_set_unevictable(folio);
> > +		lruvec_add_folio(lruvec, folio);
> > +		__count_vm_events(UNEVICTABLE_PGCULLED, delta);
> > +		return true;
> > +	}
> > +
> > +	if (type && folio_test_anon(folio) && folio_test_dirty(folio)) {
> > +		success = lru_gen_del_folio(lruvec, folio, true);
> > +		VM_BUG_ON_FOLIO(!success, folio);
> > +		folio_set_swapbacked(folio);
> > +		lruvec_add_folio_tail(lruvec, folio);
> > +		return true;
> > +	}
> > +
> > +	if (tier > tier_idx) {
> > +		int hist = lru_hist_from_seq(lrugen->min_seq[type]);
> > +
> > +		gen = folio_inc_gen(lruvec, folio, false);
> > +		list_move_tail(&folio->lru, &lrugen->lists[gen][type][zone]);
> > +
> > +		WRITE_ONCE(lrugen->promoted[hist][type][tier - 1],
> > +			   lrugen->promoted[hist][type][tier - 1] + delta);
> > +		__mod_lruvec_state(lruvec, WORKINGSET_ACTIVATE_BASE + type, delta);
> > +		return true;
> > +	}
> > +
> > +	if (folio_test_locked(folio) || folio_test_writeback(folio) ||
> > +	    (type && folio_test_dirty(folio))) {
> > +		gen = folio_inc_gen(lruvec, folio, true);
> > +		list_move(&folio->lru, &lrugen->lists[gen][type][zone]);
> > +		return true;
> 
> Make the cold dirty page cache younger instead of writeout in the backgroungd
> reclaimer context, and the question rising is if laundry is defered until the
> flusher threads are waken up in the following patches.

This is a good point. In contrast to the active/inactive LRU, MGLRU
doesn't write out dirty file pages (kswapd or direct reclaimers) --
this is writeback's job and it should be better at doing this. In
fact, commit 21b4ee7029 ("xfs: drop ->writepage completely") has
disabled dirty file page writeouts in the reclaim path completely.

Reclaim indirectly wakes up writeback after clean file pages drop
below a threshold (dirty ratio). However, dirty pages might be under
counted on a system that uses a large number of mmapped file pages.
MGLRU optimizes this by calling folio_mark_dirty() on pages mapped
by dirty PTEs when scanning page tables. (Why not since it's already
looking at the accessed bit.)

The commit above explained this design choice from the performance
aspect. From the implementation aspect, it also creates a boundary
between reclaim and writeback. This simplifies things, e.g., the
PageWriteback() check in shrink_page_list is no longer relevant for
MGLRU, neither is the top half of the PageDirty() check.
