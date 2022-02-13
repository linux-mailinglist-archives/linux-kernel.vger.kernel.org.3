Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750144B3DB2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 22:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238391AbiBMVQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 16:16:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbiBMVQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 16:16:21 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCF853B42
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 13:16:14 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id i62so17807898ioa.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 13:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HoEQyB0wXuP36DzZ0QRkHqCD5SbkH+algRG5wEjwJXo=;
        b=h5N69fHGI7cZvuuQQQVEWq5Ocbd1LmgnZQMruZWLFS62Tf0f3r6KH42yPIcbnpUzPe
         TOn2cr/eU2bgt8ZGSdvN9x7aDu4Bhxk+oygox+iO/oUp7WJGV50FSWgs66oeuvA2WYnI
         1sVuzNVISszFEapEIRj7yG/HqKMqyFtZ2ZqqpcerSoEhNeldBdH/ktro0S0cvKStf8Hm
         2xifBMI7o4a9q0RW+OVDeqxbjym3XwIzszWyGaTHbmojx1Jkjbz4tT0rCY4ML4+hfHJt
         uT8ZOyTX5nHvhZHk3nUbalAYxRip7KmO44j/1qtzTwg2iu86F1sZusw7FqD5PtqJ5Hon
         Xabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HoEQyB0wXuP36DzZ0QRkHqCD5SbkH+algRG5wEjwJXo=;
        b=orq0KwoEJ/nMmod8DfPGUibLUEC8kCpyX/u/MLy09ofMR4fFIK5i5HC6RmwNY041Ot
         8Cbu/+2+a/IzxH9q/Rt2YQryeUSEZDvP2PX1bXEsgNRJA1HuG8lWzHc6Ka/Df7zSVcri
         6z8gSFfGmK2NnVIPlhqbUgp2XcWsvz0lsXjwCDoqmDeer/+9CfxDsauKVcJzycDoBiku
         Gm0XdCuk+QaeeQYqb4Y3GFkG7Qc+3MAhQrgDmaBiAjpsux59sBHF054D1R3aWDNeCCjQ
         vFu9JfsVfkvG+Lz5+Vgg2hDYz5kNbrgeBjCokmiI8C+GR+ns+SJu0uhTyN872y3A+WEh
         Su8A==
X-Gm-Message-State: AOAM532RRatF0KcMmMwBpurZ2AA3YerBtgR7kXVOJtcIGAt3tfSwwCy0
        nqHdH28Eg13sdkQ2TnDL8oIvtg==
X-Google-Smtp-Source: ABdhPJx2zA0Qgp3jj6EvOzNNp5e5TWs1qwwakXa6kVQ5HAZUV4wNcOsmNoaH07/PQ38CF5kNKnRKiw==
X-Received: by 2002:a05:6602:1656:: with SMTP id y22mr5599323iow.34.1644786974067;
        Sun, 13 Feb 2022 13:16:14 -0800 (PST)
Received: from google.com ([2620:15c:183:200:4782:b5ed:f641:ee91])
        by smtp.gmail.com with ESMTPSA id q2sm12515494ilt.33.2022.02.13.13.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 13:16:13 -0800 (PST)
Date:   Sun, 13 Feb 2022 14:16:09 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Larabel <Michael@michaellarabel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>
Subject: Re: [PATCH v7 04/12] mm: multigenerational LRU: groundwork
Message-ID: <Ygl1Gf+ATBuI/m2q@google.com>
References: <20220208081902.3550911-1-yuzhao@google.com>
 <20220208081902.3550911-5-yuzhao@google.com>
 <YgWFlYi5jGENGD4G@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgWFlYi5jGENGD4G@casper.infradead.org>
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

On Thu, Feb 10, 2022 at 09:37:25PM +0000, Matthew Wilcox wrote:
> On Tue, Feb 08, 2022 at 01:18:54AM -0700, Yu Zhao wrote:

[...]

> > +++ b/include/linux/page-flags-layout.h
> > @@ -26,6 +26,14 @@
> >  
> >  #define ZONES_WIDTH		ZONES_SHIFT
> >  
> > +#ifdef CONFIG_LRU_GEN
> > +/* LRU_GEN_WIDTH is generated from order_base_2(CONFIG_NR_LRU_GENS + 1). */
> > +#define LRU_REFS_WIDTH		(CONFIG_TIERS_PER_GEN - 2)
> > +#else
> > +#define LRU_GEN_WIDTH		0
> > +#define LRU_REFS_WIDTH		0
> > +#endif /* CONFIG_LRU_GEN */
> 
> I'm concerned about the number of bits being used in page->flags.
> It seems to me that we already have six bits in use to aid us in choosing
> which pages to reclaim: referenced, lru, active, workingset, reclaim,
> unevictable.
> 
> What I was hoping to see from this patch set was reuse of those bits.

Agreed. I have a plan to *reduce* some of those bits but it's a
relatively low priority item on my to-do list.

> That would give us 32 queues in total.  Some would be special (eg pages
> cannot migrate out of the unevictable queue), but it seems to me that you
> effectively have 4 queues for active and 4 queues for inactive at this
> point (unless I misunderstood that).  I think we need special numbers
> for: Not on the LRU and Unevictable, but that still leaves us with 30
> generations to split between active & inactive.
> 
> But maybe we still need some of those bits?  Perhaps it's not OK to say
> that queue id 0 is !LRU, queue 1 is unevictable, queue #2 is workingset,
> queues 3-7 are active, queues 8-15 are various degrees of inactive.
> I'm assuming that it's not sensible to have a page that's marked as both
> "reclaim" and "workingset", but perhaps it is.
> 
> Anyway, I don't understand this area well enough.  I was just hoping
> for some simplification.

I plan to use the spare bits in folio->lru to indicate which lru list
a folio is on, i.e., active/inactive or generations or unevictable.

In addition, swapbacked could go to folio->mapping -- we wouldn't need
it if there were no MADV_FREE, i.e., it would be equivalent to
PageAnon() || shmem_mapping().

These two work items can be done separately and in parallel with
everything else that's been going on lately. It'd awesome if somebody
volunteers, and I can find some resource from our side to test/review
the code so that we can have them done sooner.

The rest, in theory, can also be moved to somewhere but, IMO, it's not
really worth the effort given the situation isn't dire at the moment.
referenced and workingset are already reused between the active/inactive
lru and the multigenerational lru; reclaim is reused for readahead, but
readahead could be split out as an xa tag; lru is reused for isolation
synchronization.
