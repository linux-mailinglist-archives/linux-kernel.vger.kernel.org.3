Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2184FD59E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378798AbiDLINN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 04:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355641AbiDLH1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:27:52 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805344EDD5;
        Tue, 12 Apr 2022 00:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C3gL28B3Gc2aOWbp9TEABQMn0ckE3NlAT3ZMfiId2yM=; b=NX/1HLFCyl0vrt8Ykxe6Lw8tiL
        ibR3HLppnOGAHLzmEZvRQ/ps/npWEuslAuQ2wxMgrPuhsEQkGaiMW2OiO1XheO1U3zr16ITSbJ8Y+
        Ae9IZrmFSo1ePtVSKuXbWenTKQO/im6/8EfYem0M57zrvOvDuysy2DB2JtTtAHbPS0gJvq3rTLGCn
        JABlC1yiyKBFK2laSPj5AeOq1wFEjyTxA5jmTRL8kbQ6/qmVUwnY4arjso2s6ilmC/rusTxHmZQPf
        mW1ZsqDJP4bqkJcpLqsI2kQVkPz/MBRWHAqfCiikArrTB2F6+jnEO3oGsTxbLbckXcGPgQ4wZQLg5
        o54RZ5SQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1neAbS-004F4r-Tz; Tue, 12 Apr 2022 07:06:19 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6172F98619A; Tue, 12 Apr 2022 09:06:16 +0200 (CEST)
Date:   Tue, 12 Apr 2022 09:06:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yu Zhao <yuzhao@google.com>, Stephen Rothwell <sfr@rothwell.id.au>,
        linux-mm@kvack.org, Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, page-reclaim@google.com,
        x86@kernel.org, Brian Geffon <bgeffon@google.com>,
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
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v10 05/14] mm: multi-gen LRU: groundwork
Message-ID: <20220412070616.GT2731@worktop.programming.kicks-ass.net>
References: <20220407031525.2368067-1-yuzhao@google.com>
 <20220407031525.2368067-6-yuzhao@google.com>
 <20220411191615.a34959bdcc25ef3f9c16a7ce@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411191615.a34959bdcc25ef3f9c16a7ce@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 07:16:15PM -0700, Andrew Morton wrote:

> > +{
> > +	int gen;
> > +	unsigned long old_flags, new_flags;
> > +
> > +	do {
> > +		new_flags = old_flags = READ_ONCE(folio->flags);
> > +		if (!(new_flags & LRU_GEN_MASK))
> > +			return false;
> > +
> > +		VM_BUG_ON_FOLIO(folio_test_active(folio), folio);
> > +		VM_BUG_ON_FOLIO(folio_test_unevictable(folio), folio);
> > +
> > +		gen = ((new_flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
> > +
> > +		new_flags &= ~LRU_GEN_MASK;
> > +		/* for shrink_page_list() */
> > +		if (reclaiming)
> > +			new_flags &= ~(BIT(PG_referenced) | BIT(PG_reclaim));
> > +		else if (lru_gen_is_active(lruvec, gen))
> > +			new_flags |= BIT(PG_active);
> > +	} while (cmpxchg(&folio->flags, old_flags, new_flags) != old_flags);

Also; please use the form:

	unsigned long new, old = READ_ONCE(folio->flags);

	do {
		new = /* something */ old;
	} while (!try_cmpxchg(&folio->flags, &old, new))

