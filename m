Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA50587508
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 03:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbiHBBY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 21:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbiHBBY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 21:24:56 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1203FA2C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 18:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659403494; x=1690939494;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=x6ngo09KFtJj089aELQSz1+JdkFMG0KW45Hv53bEcjg=;
  b=HAH/EfJ/+0wMDPTDZIQydZf3rSYDY/Zdp8IOpDClJdULhevKm2G83tLE
   BszOU4YAEBMa5NeJE99wpYhockkggjUB44HP7VptkDkuIxb0DVxv5qiIw
   24VOWzcJCx9qzbdTwD4EnoSxq3g7Mr5DP7x2q0WZykVs+dK+zilg6D+7q
   IND8NBplezGX2f6p981zo/iOFzjNZTf/Ye6pBRQ/ZwFMI7sr64iYXBOMC
   T+YLqKhWLFVUwKwr0mrODnBm2mf6Ir4+Ap31+CEvQNxHPFv/e4b49wGt3
   CEpl0tLGCvknEmHn57pnD0rxLLh6IeUgjKfQ44OkK59IJhUvIFHl7KG6Y
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="315129357"
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="315129357"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 18:24:53 -0700
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="578010627"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 18:24:50 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH RFC 1/4] mm/swap: Add swp_offset_pfn() to fetch PFN from
 swap entry
References: <20220729014041.21292-1-peterx@redhat.com>
        <20220729014041.21292-2-peterx@redhat.com>
        <8735eglkp5.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <YuhTvDIC26trwr18@xz-m1.local>
Date:   Tue, 02 Aug 2022 09:22:52 +0800
In-Reply-To: <YuhTvDIC26trwr18@xz-m1.local> (Peter Xu's message of "Mon, 1 Aug
        2022 18:29:16 -0400")
Message-ID: <87czdjjv6b.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:

> On Mon, Aug 01, 2022 at 11:13:58AM +0800, Huang, Ying wrote:
>> > +/*
>> > + * This should only be called upon a pfn swap entry to get the PFN stored
>> > + * in the swap entry.  Please refers to is_pfn_swap_entry() for definition
>> > + * of pfn swap entry.
>> > + */
>> > +static inline unsigned long swp_offset_pfn(swp_entry_t entry)
>> > +{
>> 
>> Is it good to call is_pfn_swap_entry() here for debug that can be
>> eliminated in the production kernel?
>
> Sure, I'll add a VM_BUG_ON() there in the next spin.
>
>> 
>> > +	return swp_offset(entry) & SWP_PFN_MASK;
>> > +}
>> > +
>> >  /* check whether a pte points to a swap entry */
>> >  static inline int is_swap_pte(pte_t pte)
>> >  {
>> > @@ -369,7 +387,7 @@ static inline int pte_none_mostly(pte_t pte)
>> >  
>> >  static inline struct page *pfn_swap_entry_to_page(swp_entry_t entry)
>> >  {
>> > -	struct page *p = pfn_to_page(swp_offset(entry));
>> > +	struct page *p = pfn_to_page(swp_offset_pfn(entry));
>> >  
>> >  	/*
>> >  	 * Any use of migration entries may only occur while the
>> > @@ -387,6 +405,9 @@ static inline struct page *pfn_swap_entry_to_page(swp_entry_t entry)
>> >   */
>> >  static inline bool is_pfn_swap_entry(swp_entry_t entry)
>> >  {
>> > +	/* Make sure the swp offset can always store the needed fields */
>> > +	BUILD_BUG_ON(SWP_TYPE_SHIFT < SWP_PFN_BITS);
>> 
>> 	BUILD_BUG_ON(SWP_TYPE_SHIFT <= SWP_PFN_BITS);
>
> Logiclaly it's okay to have SWP_TYPE_SHIFT==SWP_PFN_BITS?

Sorry, I misunderstood the original code.  Please ignore this comment.

Best Regards,
Huang, Ying
