Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B724D26D4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiCIBQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiCIBQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:16:09 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6F1E7AF5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 17:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646787610; x=1678323610;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=4URLKVDgh8stZTbeL/CYtqk8VqMopTxqW9DHku7N9ps=;
  b=Ua+a01AonC5HHPwCeue9+sQi9gliZXhgAJTMDFB2T/By88FUT6m89gy0
   jiTcChLxlmcU7t6FN88EhqYd27DByeKJN8MEKOLYPioN6bHQWccsmxTR8
   DS7ysUFpGqaDCuEnSndhUr5aTnmQiQW7AzXVnoompwQfC2pzIcV0Tc/YW
   llM5syHKANu0CFwf5CsFNbuvV1CbmKMNnlbhOlPAJsbSkDVdbDNsMj/6M
   90y3exM3fpM6kF5gbXzfP6sg6VPldKDqaESxLOcqR68b2eEe+SQcju4sr
   DfIe1p790xDpGHZeoWGcw+O7H8GZ5UbziQrPrI155pFnUcuSQSlaznHQ9
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="279577308"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="279577308"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 17:00:09 -0800
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="553874286"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 17:00:03 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <shy828301@gmail.com>, <willy@infradead.org>, <ziy@nvidia.com>,
        <minchan@kernel.org>, <apopple@nvidia.com>,
        <ave.hansen@linux.intel.com>, <o451686892@gmail.com>,
        <almasrymina@google.com>, <jhubbard@nvidia.com>,
        <rcampbell@nvidia.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <mhocko@suse.com>, <riel@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 13/16] mm/migration: return errno when isolate_huge_page
 failed
References: <20220304093409.25829-1-linmiaohe@huawei.com>
        <20220304093409.25829-14-linmiaohe@huawei.com>
        <87ilsq5p0x.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <85acb60f-76a6-2cbc-0896-a593531dfc27@huawei.com>
Date:   Wed, 09 Mar 2022 09:00:01 +0800
In-Reply-To: <85acb60f-76a6-2cbc-0896-a593531dfc27@huawei.com> (Miaohe Lin's
        message of "Tue, 8 Mar 2022 20:12:28 +0800")
Message-ID: <8735jsgctq.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> On 2022/3/7 13:07, Huang, Ying wrote:
>> Miaohe Lin <linmiaohe@huawei.com> writes:
>> 
>>> We should return errno (-EBUSY here) when failed to isolate the huge page
>>> rather than always return 1 which could confuse the user.
>>>
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>> ---
>>>  mm/migrate.c | 6 ++----
>>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index 6c2dfed2ddb8..279940c0c064 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -1618,10 +1618,8 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
>>>  		goto out_putpage;
>>>  
>>>  	if (PageHuge(page)) {
>>> -		if (PageHead(page)) {
>>> -			isolate_huge_page(page, pagelist);
>>> -			err = 1;
>>> -		}
>>> +		if (PageHead(page))
>>> +			err = isolate_huge_page(page, pagelist) ? 1 : -EBUSY;
>> 
>> IMHO, it's better to determine the proper errno inside
>> isolate_huge_page() instead of in the caller.  If you think it's
>> necessary to get errno here.  How about change isolate_huge_page()
>> instead?
>
> IMO, -EBUSY should be enough for the user (as they could not do much) and this
> errno keeps consistent with the non-hugetlb page case. What do you think?

I found the prototype of isolate_lru_page() is as follows,

  int isolate_lru_page(struct page *page)

And it will return errno directly.  I think we should follow same
convention here?

Best Regards,
Huang, Ying
