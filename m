Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4B84CF0CD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 06:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbiCGFDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 00:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbiCGFDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 00:03:44 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB405F82
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 21:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646629369; x=1678165369;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=fSzZifNYct0Has80OHs9poHqh4YGD9Xak8s4xLdqB7U=;
  b=XVWncK0WA8LJy4CGclOg8eGM8bGoskNxinkaOvAXPbho1MCmHlXSMPoU
   dj8++DaRN4++DPKzxrUqTdrgRljzrLCBxch2wUtlSGuFFzF009k+LNVTk
   EjQXE7X20MOuu1y1anbrCSm0UykxMWfkYUR1ha28RfAyPhuXUrfivh1SB
   unWP7SQnbZdAXAmn6+v4fbWTPlTjsFXKxISX31bBQMYjGv0jWb6axNhKG
   4nVZbt3/CYlL6jsdoCgn+53Wo7+cm7puU2P5BwoDG1zppj9jEulkJzaji
   txEi0w+EHpOorEfTWj0hJhJOFP63SpQ5IXyas/AUo6t4v26DFIaCTDtSi
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="254028485"
X-IronPort-AV: E=Sophos;i="5.90,160,1643702400"; 
   d="scan'208";a="254028485"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 21:02:38 -0800
X-IronPort-AV: E=Sophos;i="5.90,160,1643702400"; 
   d="scan'208";a="512535412"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 21:02:33 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, <akpm@linux-foundation.org>,
        <mike.kravetz@oracle.com>, <shy828301@gmail.com>,
        <willy@infradead.org>, <ziy@nvidia.com>, <minchan@kernel.org>,
        <apopple@nvidia.com>, <ave.hansen@linux.intel.com>,
        <o451686892@gmail.com>, <almasrymina@google.com>,
        <jhubbard@nvidia.com>, <rcampbell@nvidia.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <mhocko@suse.com>, <riel@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/16] mm/migration: fix potential page refcounts leak
 in migrate_pages
References: <20220304093409.25829-1-linmiaohe@huawei.com>
        <20220304093409.25829-13-linmiaohe@huawei.com>
        <20f47ec9-3b5b-5326-b1c3-4b1a0c38ef46@linux.alibaba.com>
Date:   Mon, 07 Mar 2022 13:02:27 +0800
In-Reply-To: <20f47ec9-3b5b-5326-b1c3-4b1a0c38ef46@linux.alibaba.com> (Baolin
        Wang's message of "Mon, 7 Mar 2022 09:57:30 +0800")
Message-ID: <87mti25p98.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> Hi Miaohe,
>
> On 3/4/2022 5:34 PM, Miaohe Lin wrote:
>> In -ENOMEM case, there might be some subpages of fail-to-migrate THPs
>> left in thp_split_pages list. We should move them back to migration
>> list so that they could be put back to the right list by the caller
>> otherwise the page refcnt will be leaked here. Also adjust nr_failed
>> and nr_thp_failed accordingly to make vm events account more accurate.
>> Fixes: b5bade978e9b ("mm: migrate: fix the return value of
>> migrate_pages()")
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>   mm/migrate.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index e0db06927f02..6c2dfed2ddb8 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1422,6 +1422,15 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>   				}
>>     				nr_failed_pages += nr_subpages;
>> +				/*
>> +				 * There might be some subpages of fail-to-migrate THPs
>> +				 * left in thp_split_pages list. Move them back to migration
>> +				 * list so that they could be put back to the right list by
>> +				 * the caller otherwise the page refcnt will be leaked.
>> +				 */
>> +				list_splice_init(&thp_split_pages, from);
>> +				nr_failed += retry;
>> +				nr_thp_failed += thp_retry;
>
> Yes, I think we missed this case before, and your patch looks
> right. But we should also update the 'rc' to return the correct number
> of pages that were not migrated, right?

Per my understanding, -ENOMEM should be returned to indicate an fatal
error.

Best Regards,
Huang, Ying
