Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B6155CBA2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbiF0GVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 02:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiF0GVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 02:21:37 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546A82BCC
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 23:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656310897; x=1687846897;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=izwFnX+6z545+eh0FSlT5xUFypO7lEFeLqpSq1YYwzY=;
  b=E2IdeWQsewv3U+TmvNLWLHxcvQF1vyaZsjsOdeUinNKKLQAOSLsMm+GD
   V9W1LK+gmr+Hvq5+D9YT4EYfZTTLM/8jXNQWQ3m6Od6kfPzXelWt813NL
   7G1CCvqmOzD8Cwj4qa2/0kMNP1TnQaGSwc3IFJCZllOGyeM+aUhlQgtSD
   btIH2HXZL/4uLuOC5Dh0SP/rY1hGiHgHd4kI8PBx5CZLdVCXliiskwR/c
   1KinAcZHNivNSAMkt0GY8erf0E6/mmYYy0D1VbPoL6zBzc3Xi4FGsVq4v
   GXGYUW2QM+uV3wXpOAy0rpP7T7oeK+pJh/3PHbCkXi4QXxJFDm7WU1oKB
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="264413270"
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="264413270"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2022 23:21:36 -0700
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="836058465"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2022 23:21:35 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <shy828301@gmail.com>, <ziy@nvidia.com>
Subject: Re: [PATCH 7/7] migrate_pages(): fix failure counting for retry
References: <20220624025309.1033400-1-ying.huang@intel.com>
        <20220627022515.1067946-1-ying.huang@intel.com>
        <5b40e07d-7ed3-7eba-ea71-52e5a06c1ec8@linux.alibaba.com>
Date:   Mon, 27 Jun 2022 14:21:31 +0800
In-Reply-To: <5b40e07d-7ed3-7eba-ea71-52e5a06c1ec8@linux.alibaba.com> (Baolin
        Wang's message of "Mon, 27 Jun 2022 12:29:28 +0800")
Message-ID: <87mtdy7hjo.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> On 6/27/2022 10:25 AM, Huang Ying wrote:
>> After 10 retries, we will give up and the remaining pages will be
>> counted as failure in nr_failed and nr_thp_failed.  We should count
>> the failure in nr_failed_pages too.  This is done in this patch.
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Fixes: 5984fabb6e82 ("mm: move_pages: report the number of non-attempted pages")
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Yang Shi <shy828301@gmail.com>
>> ---
>>   mm/migrate.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 70a0e1f34c03..e42bd409d3aa 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1344,6 +1344,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>   	int thp_retry = 1;
>>   	int nr_failed = 0;
>>   	int nr_failed_pages = 0;
>> +	int nr_retry_pages = 0;
>>   	int nr_succeeded = 0;
>>   	int nr_thp_succeeded = 0;
>>   	int nr_thp_failed = 0;
>> @@ -1364,6 +1365,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>   	for (pass = 0; pass < 10 && (retry || thp_retry); pass++) {
>>   		retry = 0;
>>   		thp_retry = 0;
>> +		nr_retry_pages = 0;
>>     		list_for_each_entry_safe(page, page2, from, lru) {
>>   			/*
>> @@ -1449,12 +1451,14 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>   				nr_thp_failed += thp_retry;
>>   				if (!no_subpage_counting)
>>   					nr_failed += retry;
>> +				nr_failed_pages += nr_retry_pages;
>
> Can you move this a little forward to update 'nr_failed_pages' in one
> place, which seems more readable?
> nr_failed_pages += nr_subpages + nr_retry_pages;

Sure.  Will do this in the next version!

> Otherwise,
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Thanks!

Best Regards,
Huang, Ying

>
>>   				goto out;
>>   			case -EAGAIN:
>>   				if (is_thp)
>>   					thp_retry++;
>>   				else
>>   					retry++;
>> +				nr_retry_pages += nr_subpages;
>>   				break;
>>   			case MIGRATEPAGE_SUCCESS:
>>   				nr_succeeded += nr_subpages;
>> @@ -1481,6 +1485,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>   	if (!no_subpage_counting)
>>   		nr_failed += retry;
>>   	nr_thp_failed += thp_retry;
>> +	nr_failed_pages += nr_retry_pages;
>>   	/*
>>   	 * Try to migrate subpages of fail-to-migrate THPs, no nr_failed
>>   	 * counting in this round, since all subpages of a THP is counted
