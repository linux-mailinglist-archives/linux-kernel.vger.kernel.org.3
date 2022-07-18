Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D07A57848F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbiGRN61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiGRN6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:58:23 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AC327FC8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658152702; x=1689688702;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vf4REEPL4Gjd3BgNJelj9yn/G1FQopQlzM8XP/ubJLU=;
  b=gkXlx/JOdgSw1tJyBHzecLKQmSzw6uFbe/yGOjMRTQW5F8RM9QlNU9Fh
   EUYUbwX1WvUiXHoW/nJZyyOMMhplFwv0GOJlwtfVjlUTLvQCIlNHVneXY
   vOzwiwm6KtZB4F/iRo7XdIGGNm+ECgu1ZPgissEx8G/DXhHu4ddfQgb8Z
   g=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 18 Jul 2022 06:58:22 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 06:58:21 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 18 Jul 2022 06:58:21 -0700
Received: from [10.216.50.214] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 18 Jul
 2022 06:58:16 -0700
Message-ID: <fca23df7-37b0-f32d-ece3-58317dfad210@quicinc.com>
Date:   Mon, 18 Jul 2022 19:28:13 +0530
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
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>
References: <1657810063-28938-1-git-send-email-quic_charante@quicinc.com>
 <YtVJBQ/ZOt22o8+B@dhcp22.suse.cz>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <YtVJBQ/ZOt22o8+B@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Michal for the comments!!

On 7/18/2022 5:20 PM, Michal Hocko wrote:
>> The above mentioned race is just one example __but the problem persists
>> in the other paths too involving page_ext->flags access(eg:
>> page_is_idle())__. Since offline waits till the last reference on the
>> page goes down i.e. any path that took the refcount on the page can make
>> the memory offline operation to wait. Eg: In the migrate_pages()
>> operation, we do take the extra refcount on the pages that are under
>> migration and then we do copy page_owner by accessing page_ext. For
>>
>> Fix those paths where offline races with page_ext access by maintaining
>> synchronization with rcu lock.
> Please be much more specific about the synchronization. How does RCU
> actually synchronize the offlining and access? Higher level description
> of all the actors would be very helpful not only for the review but also
> for future readers.

I will improve the commit message about this synchronization change
using RCU's.

> 
> Also, more specifically
> [...]
>> diff --git a/mm/page_ext.c b/mm/page_ext.c
>> index 3dc715d..5ccd3ee 100644
>> --- a/mm/page_ext.c
>> +++ b/mm/page_ext.c
>> @@ -299,8 +299,9 @@ static void __free_page_ext(unsigned long pfn)
>>  	if (!ms || !ms->page_ext)
>>  		return;
>>  	base = get_entry(ms->page_ext, pfn);
>> -	free_page_ext(base);
>>  	ms->page_ext = NULL;
>> +	synchronize_rcu();
>> +	free_page_ext(base);
>>  }
> So you are imposing the RCU grace period for each page_ext! This can get
> really expensive. Have you tried to measure the effect?
> 

I didn't really measure the effect. Let me measure it and post these in V2.

> Is there any reason why page_ext is freed during offlining rather when
> it is hotremoved?

This is something I am struggling to get the answer. IMO, this is even
wrong design where I don't have page_ext but page. Moving the freeing of
page_ext to hotremove path actually solves the problem but somehow this
idea didn't liked[1].  copying the excerpt here:

">
> 3) Change the design where the page_ext is valid as long as the struct
> page is alive.

:/ Doesn't spark joy."


@Joonsoo : We see that you did commit eefa864b701d ("mm/page_ext:
resurrect struct page extending code for debugging").  Any reason why
the page_ext is chosen to free at offline operation rather than the
remove operation of a memory block?


[1]
https://lore.kernel.org/linux-mm/8fefe59d-c893-39f4-3225-65343086c867@redhat.com/
> 
> Thanks!
