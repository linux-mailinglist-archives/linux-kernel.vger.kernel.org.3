Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD54573124
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbiGMIak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235238AbiGMIaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:30:35 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F74071BE0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657701035; x=1689237035;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=YQUSBazFo/c4fVEPXFT3RG1PGjmSxbf7eA6p2HwqTTo=;
  b=GUTfm0VASzTQ05aMMkq2k7jDE5CaolM1Z6Qr1L9mucIGJ4Fm5kMqmebZ
   jQubqqeiQf0M/SsISnMjx+A83nommhqxsu5/gK5JQJTufAvhonhg355BY
   9A7/3lrvit4Pyj0C64tEoK0hTcUezajeiP6fHHox+XOXQzAW/+Ds0EhjS
   E6wwyOddTJjYdELAbZ6oI1yL6eVgpdyhW4EkQ4QSGsOlE52Pvy0pHGcrK
   owtfBvljnEB4C17vyHQzOkkNGQenCPTwx5BtW9DVhLe3RG/ZfnypbHfaY
   2RzLGC8jrA/KN2mhbcDTFq31HHZf4VNdM2Et5uitOKzPT/06EoYJJcRM+
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="283905557"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="283905557"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 01:30:34 -0700
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="570535384"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 01:30:32 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH -V2 5/7] migrate_pages(): fix failure counting for THP
 on -ENOSYS
References: <20220711084948.274787-1-ying.huang@intel.com>
        <20220711084948.274787-6-ying.huang@intel.com>
        <YswW7C5jzQNmeOsL@localhost.localdomain>
Date:   Wed, 13 Jul 2022 16:30:27 +0800
In-Reply-To: <YswW7C5jzQNmeOsL@localhost.localdomain> (Oscar Salvador's
        message of "Mon, 11 Jul 2022 14:26:20 +0200")
Message-ID: <87wnch4dp8.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Oscar Salvador <osalvador@suse.de> writes:

> On Mon, Jul 11, 2022 at 04:49:46PM +0800, Huang Ying wrote:
>> If THP or hugetlbfs page migration isn't supported, unmap_and_move()
>> or unmap_and_move_huge_page() will return -ENOSYS.  For THP, splitting
>> will be tried, but if splitting doesn't succeed, the THP will be left
>> in "from" list wrongly.  If some other pages are retried, the THP
>> migration failure will counted again.  This is fixed via moving the
>> failure THP from "from" to "ret_pages".
>> 
>> Another issue of the original code is that the unsupported failure
>> processing isn't consistent between THP and hugetlbfs page.  Make them
>> consistent in this patch to make the code easier to be understood too.
>> 
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Fixes: 5984fabb6e82 ("mm: move_pages: report the number of non-attempted pages")
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Yang Shi <shy828301@gmail.com>
>> ---
>>  mm/migrate.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 4bceba143db0..8cce73b7c046 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1192,10 +1192,8 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
>>  	 * tables or check whether the hugepage is pmd-based or not before
>>  	 * kicking migration.
>>  	 */
>> -	if (!hugepage_migration_supported(page_hstate(hpage))) {
>> -		list_move_tail(&hpage->lru, ret);
>> +	if (!hugepage_migration_supported(page_hstate(hpage)))
>>  		return -ENOSYS;
>> -	}
>>  
>>  	if (page_count(hpage) == 1) {
>>  		/* page was freed from under us. So we are done. */
>> @@ -1392,6 +1390,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>  			 *		 page will be put back
>>  			 *	-EAGAIN: stay on the from list
>>  			 *	-ENOMEM: stay on the from list
>> +			 *	-ENOSYS: stay on the from list
>>  			 *	Other errno: put on ret_pages list then splice to
>>  			 *		     from list
>>  			 */
>> @@ -1421,6 +1420,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>  				}
>>  
>>  				nr_failed_pages += nr_subpages;
>> +				list_move_tail(&page->lru, &ret_pages);
>
> I must be missing something, but migrate_pages() calls unmap_and_move_huge_page() 
> with ret being ret_pages, so
>
> list_move_tail(&hpage->lru, ret) == list_move_tail(&page->lru, &ret_pages)
>
> Yet, you say "This is fixed via moving the failure THP from "from" to "ret_pages"".
> /me confused.

To make it consistent between hugetlb page and THP/normal page, I have
revised the unmap_and_move_huge_page() via deleting the list_move_tail()
there for ENOSYS.  After that, we move the hugetlb page and THP/normal
page in the same way in migrate_pages().

Best Regards,
Huang, Ying
