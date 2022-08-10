Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E9358E71C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 08:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiHJGFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 02:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbiHJGE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 02:04:58 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E1961B3F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 23:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660111488; x=1691647488;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=E5YCWou/67pE3W1963fIKNZ34NBDTyuwKuFBri39tSI=;
  b=eqn8ODP2TDHsx6Ugaqbvgki9wlApVY3ldqUPW3+xsu0zdGFG7bw4PZbu
   V4qDeNGRE2421OgKEGYQJ5sq6rIRAFwk3WJTe2mUlJh/SOmm0rEbpppvi
   2kvceodV7ntkLZEqba+nTOtscmDAZ3gJYBpvvLAZcSS3xb3Nlh9RsgoLN
   ZbSbRIWdNP1cBj+FNnWiU8/C774kfm0NFIfxOaF92GAO5pQSuwwYfdqSv
   Ux0YTRgHFzBrsXtrQVI3YHKWMI0SyNSCNmrD7e2LNVaSjDysWCBvHpYLB
   ZKTY4uhnJk58UtQGZeKynZyMzycJgkM4O2UthvVdAjaLlHxKygsy4LPUU
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="316950897"
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="316950897"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 23:04:47 -0700
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="581103271"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 23:04:44 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v3 3/7] mm/swap: Add swp_offset_pfn() to fetch PFN from
 swap entry
References: <20220809220100.20033-1-peterx@redhat.com>
        <20220809220100.20033-4-peterx@redhat.com>
Date:   Wed, 10 Aug 2022 14:04:32 +0800
In-Reply-To: <20220809220100.20033-4-peterx@redhat.com> (Peter Xu's message of
        "Tue, 9 Aug 2022 18:00:56 -0400")
Message-ID: <87bkssfxcf.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:

> We've got a bunch of special swap entries that stores PFN inside the swap
> offset fields.  To fetch the PFN, normally the user just calls swp_offset()
> assuming that'll be the PFN.
>
> Add a helper swp_offset_pfn() to fetch the PFN instead, fetching only the
> max possible length of a PFN on the host, meanwhile doing proper check with
> MAX_PHYSMEM_BITS to make sure the swap offsets can actually store the PFNs
> properly always using the BUILD_BUG_ON() in is_pfn_swap_entry().
>
> One reason to do so is we never tried to sanitize whether swap offset can
> really fit for storing PFN.  At the meantime, this patch also prepares us
> with the future possibility to store more information inside the swp offset
> field, so assuming "swp_offset(entry)" to be the PFN will not stand any
> more very soon.
>
> Replace many of the swp_offset() callers to use swp_offset_pfn() where
> proper.  Note that many of the existing users are not candidates for the
> replacement, e.g.:
>
>   (1) When the swap entry is not a pfn swap entry at all, or,
>   (2) when we wanna keep the whole swp_offset but only change the swp type.
>
> For the latter, it can happen when fork() triggered on a write-migration
> swap entry pte, we may want to only change the migration type from
> write->read but keep the rest, so it's not "fetching PFN" but "changing
> swap type only".  They're left aside so that when there're more information
> within the swp offset they'll be carried over naturally in those cases.
>
> Since at it, dropping hwpoison_entry_to_pfn() because that's exactly what
> the new swp_offset_pfn() is about.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

The patch itself looks good.  But I searched swp_entry() in kernel
source code, and found that we need to do more.

For example, in pte_to_pagemap_entry()

			frame = swp_type(entry) |
				(swp_offset(entry) << MAX_SWAPFILES_SHIFT);

If it's a migration entry, we need

			frame = swp_type(entry) |
				(swp_offset_pfn(entry) << MAX_SWAPFILES_SHIFT);

So I think you need to search all swp_offset() calling in the kernel
source and check whether they need to be changed.

Best Regards,
Huang, Ying

[snip]
