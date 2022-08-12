Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206BB590A4D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 04:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236810AbiHLCdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 22:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbiHLCdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 22:33:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127C248E85
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 19:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660271584; x=1691807584;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=M24ylaQ7N07IlXWcFaN8JMuQq6Bs6bvLHfGnyour5i0=;
  b=m8UAeEUEDb1RNK54S1hDgpWeEMCs5LLm64FezbgRIWCfkO+CRyQN4rs2
   WwL2vTbRCgyvfC0vjQGW8kA0L8KGlaKY/7+uaVD9hewqpsy/1rhKn4kZl
   HnnAYBc7pWm/XPhms2EPk3xQwFjSe7DT3F4LX3z9rsgA3whHDoD1IGldJ
   nzulXV3ptGrM9SceXPA8SbW+71vB9kPqSgI3mjvGsKQgAZk7JGokkwdyY
   anFFvvsWr5axvUBHa6zrR2/XUMk9BJ2ttvHFnVbw8vALKhQChTuSueVD5
   O/H9dQbKSITg8WJrNxtYoGOZ6gWzcgjF8AQSAqdOUsZfEVZv45pYcux0B
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="292769553"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="292769553"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 19:33:02 -0700
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="556369687"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 19:32:59 -0700
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
Subject: Re: [PATCH v3 5/7] mm: Remember young/dirty bit for page migrations
References: <20220809220100.20033-1-peterx@redhat.com>
        <20220809220100.20033-6-peterx@redhat.com>
        <YvUeB0jc6clz59z5@xz-m1.local>
Date:   Fri, 12 Aug 2022 10:32:48 +0800
In-Reply-To: <YvUeB0jc6clz59z5@xz-m1.local> (Peter Xu's message of "Thu, 11
        Aug 2022 11:19:35 -0400")
Message-ID: <87pmh6dwdr.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:

> On Tue, Aug 09, 2022 at 06:00:58PM -0400, Peter Xu wrote:
>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>> index 27fb37d65476..699f821b8443 100644
>> --- a/mm/migrate_device.c
>> +++ b/mm/migrate_device.c
>> @@ -221,6 +221,10 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>>  			else
>>  				entry = make_readable_migration_entry(
>>  							page_to_pfn(page));
>> +			if (pte_young(pte))
>> +				entry = make_migration_entry_young(entry);
>> +			if (pte_dirty(pte))
>> +				entry = make_migration_entry_dirty(entry);
>>  			swp_pte = swp_entry_to_pte(entry);
>>  			if (pte_present(pte)) {
>>  				if (pte_soft_dirty(pte))
>
> This change needs to be wrapped with pte_present() at least..
>
> I also just noticed that this change probably won't help anyway because:
>
>   (1) When ram->device, the pte will finally be replaced with a device
>       private entry, and device private entry does not yet support A/D, it
>       means A/D will be dropped again,
>
>   (2) When device->ram, we are missing information on either A/D bits, or
>       even if device private entries start to suport A/D, it's still not
>       clear whether we should take device read/write into considerations
>       too on the page A/D bits to be accurate.
>
> I think I'll probably keep the code there for completeness, but I think it
> won't really help much until more things are done.

It appears that there are more issues.  Between "pte = *ptep" and pte
clear, CPU may set A/D bit in PTE, so we may need to update pte when
clearing PTE.  And I don't find the TLB is flushed in some cases after
PTE is cleared.

Best Regards,
Huang, Ying
