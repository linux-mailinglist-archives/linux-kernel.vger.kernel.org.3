Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1AC596705
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 03:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238395AbiHQBt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 21:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237848AbiHQBtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 21:49:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0A297D61
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 18:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660700994; x=1692236994;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=5Qr/rtXTqV1K9DI6syOE1soqcbcEFdZjo5/Won08Vm0=;
  b=LoB1B7WWAjO4esVh5PuMfjvoVcuBlFoTkUy2E7akwzRZQW1wOJqzYnLt
   ZRjTpMhp6xgSbIaDAy1YA9FkhGmDZ9jm8VGsjpXoWsZqNoUkyp4ODe2hF
   0Sl4saL4WY+Ggj3d6ZJSaE7BPLho9HMmOtiajlszX57QwZEpaTvfPT+c6
   zQ01xs+9/V5i/TTdVp+47nK11fEXjBj9bjR5JhAMMNRrz66tK+1bSfymh
   ySVfqyBnxx1KuxEfOVJHQFDhCZhHllBOgU56uyMPg7MuNPNYAelTL/3xj
   A6lfy3wyUklrek15KBxoE0bOrZBJHOwGpDos3jtFYuFYnsq1yAsj+YZCm
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="293652290"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="293652290"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 18:49:53 -0700
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="935153839"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 18:49:50 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH v3 5/7] mm: Remember young/dirty bit for page migrations
References: <20220809220100.20033-1-peterx@redhat.com>
        <20220809220100.20033-6-peterx@redhat.com>
        <YvUeB0jc6clz59z5@xz-m1.local>
        <87pmh6dwdr.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <YvqcGq44oonHNyCO@xz-m1.local>
        <5B21352C-2BE6-4070-BB6B-C1B7A5D4D225@gmail.com>
Date:   Wed, 17 Aug 2022 09:49:48 +0800
In-Reply-To: <5B21352C-2BE6-4070-BB6B-C1B7A5D4D225@gmail.com> (Nadav Amit's
        message of "Mon, 15 Aug 2022 13:52:49 -0700")
Message-ID: <8735dvd4g3.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nadav Amit <nadav.amit@gmail.com> writes:

> On Aug 15, 2022, at 12:18 PM, Peter Xu <peterx@redhat.com> wrote:
>
>> On Fri, Aug 12, 2022 at 10:32:48AM +0800, Huang, Ying wrote:
>>> Peter Xu <peterx@redhat.com> writes:
>>> 
>>>> On Tue, Aug 09, 2022 at 06:00:58PM -0400, Peter Xu wrote:
>>>>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>>>>> index 27fb37d65476..699f821b8443 100644
>>>>> --- a/mm/migrate_device.c
>>>>> +++ b/mm/migrate_device.c
>>>>> @@ -221,6 +221,10 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>>>>> 			else
>>>>> 				entry = make_readable_migration_entry(
>>>>> 							page_to_pfn(page));
>>>>> +			if (pte_young(pte))
>>>>> +				entry = make_migration_entry_young(entry);
>>>>> +			if (pte_dirty(pte))
>>>>> +				entry = make_migration_entry_dirty(entry);
>>>>> 			swp_pte = swp_entry_to_pte(entry);
>>>>> 			if (pte_present(pte)) {
>>>>> 				if (pte_soft_dirty(pte))
>>>> 
>>>> This change needs to be wrapped with pte_present() at least..
>>>> 
>>>> I also just noticed that this change probably won't help anyway because:
>>>> 
>>>>  (1) When ram->device, the pte will finally be replaced with a device
>>>>      private entry, and device private entry does not yet support A/D, it
>>>>      means A/D will be dropped again,
>>>> 
>>>>  (2) When device->ram, we are missing information on either A/D bits, or
>>>>      even if device private entries start to suport A/D, it's still not
>>>>      clear whether we should take device read/write into considerations
>>>>      too on the page A/D bits to be accurate.
>>>> 
>>>> I think I'll probably keep the code there for completeness, but I think it
>>>> won't really help much until more things are done.
>>> 
>>> It appears that there are more issues.  Between "pte = *ptep" and pte
>>> clear, CPU may set A/D bit in PTE, so we may need to update pte when
>>> clearing PTE.
>> 
>> Agreed, I didn't see it a huge problem with current code, but it should be
>> better in that way.
>> 
>>> And I don't find the TLB is flushed in some cases after PTE is cleared.
>> 
>> I think it's okay to not flush tlb if pte not present.  But maybe you're
>> talking about something else?
>
> I think Huang refers to situation in which the PTE is cleared, still not
> flushed, and then A/D is being set by the hardware.

No.  The situation in my mind is PTE with A/D set is cleared, not
flushed.  Then a parallel mprotect or munmap may cause race conditions.
As Alistair pointed out in another thread [1], there is TLB flushing
after PTL unlocked.  But I think we need to flush TLB before unlock.
This has been fixed in Alistair's latest version [2].

[1] https://lore.kernel.org/lkml/87r11gvrx6.fsf@nvdebian.thelocal/
[2] https://lore.kernel.org/lkml/6e77914685ede036c419fa65b6adc27f25a6c3e9.1660635033.git-series.apopple@nvidia.com/

Best Regards,
Huang, Ying
