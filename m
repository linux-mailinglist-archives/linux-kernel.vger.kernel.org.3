Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18CC55B5EC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 06:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbiF0D7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 23:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiF0D7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 23:59:52 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7462AF2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 20:59:50 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VHRf2d0_1656302386;
Received: from 30.32.122.103(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VHRf2d0_1656302386)
          by smtp.aliyun-inc.com;
          Mon, 27 Jun 2022 11:59:47 +0800
Message-ID: <22f7b831-7734-2969-a477-473c4367f61e@linux.alibaba.com>
Date:   Mon, 27 Jun 2022 11:59:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 4/7] migrate_pages(): fix failure counting for THP
 subpages retrying
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>
References: <20220624025309.1033400-1-ying.huang@intel.com>
 <20220624025309.1033400-5-ying.huang@intel.com>
 <f2e1ea63-d0ca-7a80-fc16-90622ef2017d@linux.alibaba.com>
 <87zghy7ua0.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <87zghy7ua0.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/27/2022 9:46 AM, Huang, Ying wrote:
> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> 
>> On 6/24/2022 10:53 AM, Huang Ying wrote:
>>> If THP is failed to be migrated for -ENOSYS and -ENOMEM, the THP will
>>> be split into thp_split_pages, and after other pages are migrated,
>>> pages in thp_split_pages will be migrated with no_subpage_counting ==
>>> true, because its failure have been counted already.  If some pages in
>>> thp_split_pages are retried during migration, we should not count
>>> their failure if no_subpage_counting == true too.  This is done this
>>> patch to fix the failure counting for THP subpages retrying.
>>
>> Good catch. Totally agree with you. It seems we can move the condition
>> into -EAGAIN case like other cases did?
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 1ece23d80bc4..491c2d07402b 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1463,7 +1463,7 @@ int migrate_pages(struct list_head *from,
>> new_page_t get_new_page,
>>                          case -EAGAIN:
>>                                  if (is_thp)
>>                                          thp_retry++;
>> -                               else
>> +                               else if (!no_subpage_counting)
>>                                          retry++;
>>                                  break;
> 
> This has another effect except fixing the failure counting.  That is,
> the split subpages of THP will not be retried for 10 times for -EAGAIN.

Ah, yes.

> TBH, I think that we should do that.  But because this has some behavior

OK. So you afraid that 10 times retry for each subpage of THP will waste 
lots of time?

> change, it's better to be done in a separate patch?  Do you have
> interest to do that on top of this patchset?

Sure. I can send a patch which can be folded into your series. Is this 
OK for you?

By the way, if I do like I said, the patch 4 can be avoided.

> 
>> Anyway this patch looks good to me.
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> Thanks!
> 
> Best Regards,
> Huang, Ying
> 
>>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>>> Fixes: 5984fabb6e82 ("mm: move_pages: report the number of non-attempted pages")
>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> Cc: Zi Yan <ziy@nvidia.com>
>>> Cc: Yang Shi <shy828301@gmail.com>
>>> --- >   mm/migrate.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index 542533e4e3cf..61dab3025a1d 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -1477,7 +1477,8 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>    			}
>>>    		}
>>>    	}
>>> -	nr_failed += retry;
>>> +	if (!no_subpage_counting)
>>> +		nr_failed += retry;
>>>    	nr_thp_failed += thp_retry;
>>>    	/*
>>>    	 * Try to migrate subpages of fail-to-migrate THPs, no nr_failed
