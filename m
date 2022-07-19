Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEA857A2B1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 17:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238036AbiGSPMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 11:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiGSPMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:12:52 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEDA50186
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658243572; x=1689779572;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w6xmuMUI/C5Hl4hqsAOfaaYdCcZFs5jZOEf5FLED8Ko=;
  b=BKz5oW2qtn3imxSTJCDocH8lSpB7BTQbA7ygt3bQoc1ffMoFIUzheLSO
   95fdWXKC+n4hUYapThuu60MSZP8UmrRu2S4CPrru3VDEiXLrPubE7Hvw+
   AzTgOlsjOBeZA5qpBt0SGH4EQCWDYh/BqwTQGwWa9ZmmlKgZOtnKZi+aA
   g=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 19 Jul 2022 08:12:51 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 08:12:51 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 19 Jul 2022 08:12:50 -0700
Received: from [10.216.34.46] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 19 Jul
 2022 08:12:45 -0700
Message-ID: <aaeec83d-bdf8-280c-b943-ad510f1d8db2@quicinc.com>
Date:   Tue, 19 Jul 2022 20:42:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] mm: fix use-after free of page_ext after race with
 memory-offline
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
CC:     <akpm@linux-foundation.org>, <pasha.tatashin@soleen.com>,
        <sjpark@amazon.de>, <sieberf@amazon.com>, <shakeelb@google.com>,
        <dhowells@redhat.com>, <willy@infradead.org>, <vbabka@suse.cz>,
        <david@redhat.com>, <minchan@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>
References: <1657810063-28938-1-git-send-email-quic_charante@quicinc.com>
 <YtVJBQ/ZOt22o8+B@dhcp22.suse.cz>
 <fca23df7-37b0-f32d-ece3-58317dfad210@quicinc.com>
 <YtV0PSMAGG46Pq0K@dhcp22.suse.cz>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <YtV0PSMAGG46Pq0K@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Michal!!

On 7/18/2022 8:24 PM, Michal Hocko wrote:
>>>> The above mentioned race is just one example __but the problem persists
>>>> in the other paths too involving page_ext->flags access(eg:
>>>> page_is_idle())__. Since offline waits till the last reference on the
>>>> page goes down i.e. any path that took the refcount on the page can make
>>>> the memory offline operation to wait. Eg: In the migrate_pages()
>>>> operation, we do take the extra refcount on the pages that are under
>>>> migration and then we do copy page_owner by accessing page_ext. For
>>>>
>>>> Fix those paths where offline races with page_ext access by maintaining
>>>> synchronization with rcu lock.
>>> Please be much more specific about the synchronization. How does RCU
>>> actually synchronize the offlining and access? Higher level description
>>> of all the actors would be very helpful not only for the review but also
>>> for future readers.
>> I will improve the commit message about this synchronization change
>> using RCU's.
> Thanks! The most imporant part is how the exclusion is actual achieved
> because that is not really clear at first sight
> 
> CPU1					CPU2
> lookup_page_ext(PageA)			offlining
> 					  offline_page_ext
> 					    __free_page_ext(addrA)
> 					      get_entry(addrA)
> 					      ms->page_ext = NULL
> 					      synchronize_rcu()
> 					      free_page_ext
> 					        free_pages_exact (now addrA is unusable)
> 					
>   rcu_read_lock()
>   entryA = get_entry(addrA)
>     base + page_ext_size * index # an address not invalidated by the freeing path
>   do_something(entryA)
>   rcu_read_unlock()
> 
> CPU1 never checks ms->page_ext so it cannot bail out early when the
> thing is torn down. Or maybe I am missing something. I am not familiar
> with page_ext much.


Thanks a lot for catching this Michal. You are correct that the proposed
code from me is still racy. I Will correct this along with the proper
commit message in the next version of this patch.

> 
>>> Also, more specifically
>>> [...]
>>>> diff --git a/mm/page_ext.c b/mm/page_ext.c
>>>> index 3dc715d..5ccd3ee 100644
>>>> --- a/mm/page_ext.c
>>>> +++ b/mm/page_ext.c
>>>> @@ -299,8 +299,9 @@ static void __free_page_ext(unsigned long pfn)
>>>>  	if (!ms || !ms->page_ext)
>>>>  		return;
>>>>  	base = get_entry(ms->page_ext, pfn);
>>>> -	free_page_ext(base);
>>>>  	ms->page_ext = NULL;
>>>> +	synchronize_rcu();
>>>> +	free_page_ext(base);
>>>>  }
>>> So you are imposing the RCU grace period for each page_ext! This can get
>>> really expensive. Have you tried to measure the effect?
> I was wrong here! This is for each memory section which is not as
> terrible as every single page_ext. This can be still quite a lot memory
> sections in a single memory block (e.g. on ppc memory sections are
> ridiculously small).
> 

On the ARM64, I see that the minimum a section size will go is 128MB. I
think 16MB is the section size on ppc. Any inputs on how frequently
offline/online operation is being done on this ppc arch?


>> I didn't really measure the effect. Let me measure it and post these in V2.
> I think it would be much more optimal to split the operation into 2
> phases. Invalidate all the page_ext metadata then synchronize_rcu and
> only then free them all. I am not very familiar with page_ext so I am
> not sure this is easy to be done. Maybe page_ext = NULL can be done in
> the first stage.
> 

Let me explore If this can be easily done.

>>> 3) Change the design where the page_ext is valid as long as the struct
>>> page is alive.
>> :/ Doesn't spark joy."
> I would be wondering why. It should only take to move the callback to
> happen at hotremove. So it shouldn't be very involved of a change. I can
> imagine somebody would be relying on releasing resources when offlining
> memory but is that really the case?

I don't find any hard need of the clients needs to release this page ext
memory.

What I can think of is that page_ext size is proportional to the debug
features(is what for being used on 64bit, as of now) we are enabling.
Eg: Enabling the page_owner requires additional 0x30 bytes per page
which memory is not required when the memory block is offlined. But then
it should be the same case for memory occupied by struct page too for
this offlined block.

One comment from the initial discussion : "It smells like page_ext
should use some mechanism during  MEM_OFFLINE to
synchronize against any users of its metadata. Generic memory offlining
code might be the wrong place for that."  -- I think the page_ext
creation and deletion should fit into the sparse code. I will try to
provide the changes on tomorrow and If it seems unfit there, I will work
on improving the current patch based on the rcu logic.

Thanks,
Charan
