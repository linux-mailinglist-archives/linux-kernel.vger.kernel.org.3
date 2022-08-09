Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96EA58D59B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 10:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236554AbiHIIpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 04:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbiHIIpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:45:39 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3796350
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 01:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660034738; x=1691570738;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=Z9+RwjgfJBkrpirf/lbuc83Z7Jh6lUPmK3soFoYeQ3I=;
  b=mOJBHjwqNvxt1UajKsI+6KGUgqBCO8Zh7VfJ520ye0HNEMnOzRM5YyN/
   jRzRxNi3sPigflR6HSWDvGJmxbJLCGf6oxRgAJrpx5RgiE+K75jpnR+sj
   jcAPgMhyLXtslLRTg8iOH3jQELJg0Twh7TWZNuqFImBz+XXIUGWDEUd7T
   y3QjRf1e3/0begEMazzQ1/yxN2oHHLP04+AIhr9H2VY/09jcHDD3YLyVr
   kNwnwO+BuKylwvvsgtKjUKFknrFl6+6xIA7+bV/Z3zxAL4xdzD4bnUyMt
   Bw7KG7G3V9NDOmHU27a1+0WTiEHOwOgznwLJVR18RH9gkOElyvIlVj3tl
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="291574936"
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="291574936"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 01:45:38 -0700
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="580715048"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 01:45:35 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Nadav Amit <nadav.amit@gmail.com>, Linux MM <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Andi Kleen <andi.kleen@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v2 2/2] mm: Remember young/dirty bit for page migrations
References: <20220804203952.53665-1-peterx@redhat.com>
        <20220804203952.53665-3-peterx@redhat.com>
        <A84CB6A0-86C8-4CAB-A977-47495D877C31@gmail.com>
        <Yu1FkCkjJ00+H0sF@xz-m1.local>
Date:   Tue, 09 Aug 2022 16:45:32 +0800
In-Reply-To: <Yu1FkCkjJ00+H0sF@xz-m1.local> (Peter Xu's message of "Fri, 5 Aug
        2022 12:30:08 -0400")
Message-ID: <8735e5hkk3.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:

> On Thu, Aug 04, 2022 at 03:40:57PM -0700, Nadav Amit wrote:
>> On Aug 4, 2022, at 1:39 PM, Peter Xu <peterx@redhat.com> wrote:
>> > +
>> > static inline bool is_pfn_swap_entry(swp_entry_t entry);
>> > 
>> > /* Clear all flags but only keep swp_entry_t related information */
>> > @@ -265,6 +285,57 @@ static inline swp_entry_t make_writable_migration_entry(pgoff_t offset)
>> > 	return swp_entry(SWP_MIGRATION_WRITE, offset);
>> > }
>> > 
>> > +/*
>> > + * Returns whether the host has large enough swap offset field to support
>> > + * carrying over pgtable A/D bits for page migrations.  The result is
>> > + * pretty much arch specific.
>> > + */
>> > +static inline bool migration_entry_supports_ad(void)
>> > +{
>> > +	/*
>> > +	 * max_swapfile_size() returns the max supported swp-offset plus 1.
>> > +	 * We can support the migration A/D bits iff the pfn swap entry has
>> > +	 * the offset large enough to cover all of them (PFN, A & D bits).
>> > +	 */
>> > +#ifdef CONFIG_SWAP
>> > +	return max_swapfile_size() >= (1UL << SWP_MIG_TOTAL_BITS);
>> 
>> This is an actual a function call (unless LTO has some trick). A bit of a
>> shame it cannot be at least memoized.
>> 
>> Or at least mark max_swapfile_size() as __attribute_const__ so it would not
>> be called twice for make_migration_entry_young() and
>> make_migration_entry_dirty().
>
> I didn't take too much effort on this one since we're on swap path and I
> assumed that's not a super hot path.  But __attribute_const__ sounds good
> and easy to get, thanks.
>
> Perhaps I should mark it on migration_entry_supports_ad() as a whole?  Note
> that unfortunately SWP_MIG_TOTAL_BITS may not be a const either (see how
> that define roots back to MAX_PHYSMEM_BITS, where on x86_64 it needs to
> check 5-lvl).

I think it's possible to memorize max_swapfile_size() or
migration_entry_supports_ad().  Although they are not constant, they are
not changed after initialized.  The challenge is to find a clean way to
initialize it.

Best Regards,
Huang, Ying
