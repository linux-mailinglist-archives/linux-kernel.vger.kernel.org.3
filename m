Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D36F55B634
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 06:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbiF0E0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 00:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiF0E0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 00:26:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306385599
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 21:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656303983; x=1687839983;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=Nj9zrpx+N2GmInMC3MZOse65eHoBgmYvf4DV5mrcGc8=;
  b=HQzQXt20542VrDHmUGLRv0OwPwnkP/Br3452SRFWaEB3brT4zRab50nB
   pZtcbjA/nJw4EDxKisMJVIZ52Fof5vds+q/UUkkioWT6/kQ4mFh7xsf1o
   XFfWeRKmAmeiXqx7//Aw7vCyB5q2AuGNsrvXZHL4LYeX0mJTXpq5+ftG3
   etrD29tXnKmkcDzmSNMfnFHCf+atoMXxUI2jf9P53UElupKmacnAWuUfX
   Nw/OH78ntH1WjYG18j+U/4n3pT+bTrho9MH2/waY6bxbQcEgjY2irtcBS
   NYiDmE3GJIelk0qL5SbPzgOPVokqocK7blOJCdRZgccVIwBZgLCI06JlU
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="270095105"
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="270095105"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2022 21:24:01 -0700
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="836021395"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2022 21:23:59 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH 4/7] migrate_pages(): fix failure counting for THP
 subpages retrying
References: <20220624025309.1033400-1-ying.huang@intel.com>
        <20220624025309.1033400-5-ying.huang@intel.com>
        <f2e1ea63-d0ca-7a80-fc16-90622ef2017d@linux.alibaba.com>
        <87zghy7ua0.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <22f7b831-7734-2969-a477-473c4367f61e@linux.alibaba.com>
Date:   Mon, 27 Jun 2022 12:23:39 +0800
In-Reply-To: <22f7b831-7734-2969-a477-473c4367f61e@linux.alibaba.com> (Baolin
        Wang's message of "Mon, 27 Jun 2022 11:59:50 +0800")
Message-ID: <87r13a7n04.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> On 6/27/2022 9:46 AM, Huang, Ying wrote:
>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>> 
>>> On 6/24/2022 10:53 AM, Huang Ying wrote:
>>>> If THP is failed to be migrated for -ENOSYS and -ENOMEM, the THP will
>>>> be split into thp_split_pages, and after other pages are migrated,
>>>> pages in thp_split_pages will be migrated with no_subpage_counting ==
>>>> true, because its failure have been counted already.  If some pages in
>>>> thp_split_pages are retried during migration, we should not count
>>>> their failure if no_subpage_counting == true too.  This is done this
>>>> patch to fix the failure counting for THP subpages retrying.
>>>
>>> Good catch. Totally agree with you. It seems we can move the condition
>>> into -EAGAIN case like other cases did?
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index 1ece23d80bc4..491c2d07402b 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -1463,7 +1463,7 @@ int migrate_pages(struct list_head *from,
>>> new_page_t get_new_page,
>>>                          case -EAGAIN:
>>>                                  if (is_thp)
>>>                                          thp_retry++;
>>> -                               else
>>> +                               else if (!no_subpage_counting)
>>>                                          retry++;
>>>                                  break;
>> This has another effect except fixing the failure counting.  That
>> is,
>> the split subpages of THP will not be retried for 10 times for -EAGAIN.
>
> Ah, yes.
>
>> TBH, I think that we should do that.  But because this has some behavior
>
> OK. So you afraid that 10 times retry for each subpage of THP will
> waste lots of time?

I just think that it's unnecessary.  We have already regarded the
migration as failed.  And for the worst case, we will try 512 * 10 =
5120 times in total.

>> change, it's better to be done in a separate patch?  Do you have
>> interest to do that on top of this patchset?
>
> Sure. I can send a patch which can be folded into your series. Is this
> OK for you?
>
> By the way, if I do like I said, the patch 4 can be avoided.

I tend to keep both.  [4/7] is just a fix.  You patch will introduce the
behavior change.  And your patch needn't to be folded into this series.
You can send it and push it separately.

Best Regards,
Huang, Ying

>> 
>>> Anyway this patch looks good to me.
>>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Thanks!
>> Best Regards,
>> Huang, Ying
>> 
>>>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>>>> Fixes: 5984fabb6e82 ("mm: move_pages: report the number of non-attempted pages")
>>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> Cc: Zi Yan <ziy@nvidia.com>
>>>> Cc: Yang Shi <shy828301@gmail.com>
>>>> --- >   mm/migrate.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>> index 542533e4e3cf..61dab3025a1d 100644
>>>> --- a/mm/migrate.c
>>>> +++ b/mm/migrate.c
>>>> @@ -1477,7 +1477,8 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>>    			}
>>>>    		}
>>>>    	}
>>>> -	nr_failed += retry;
>>>> +	if (!no_subpage_counting)
>>>> +		nr_failed += retry;
>>>>    	nr_thp_failed += thp_retry;
>>>>    	/*
>>>>    	 * Try to migrate subpages of fail-to-migrate THPs, no nr_failed
