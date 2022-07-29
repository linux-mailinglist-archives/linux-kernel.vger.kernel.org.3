Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D35D585314
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 17:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238000AbiG2Pr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 11:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237977AbiG2Prz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 11:47:55 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC5287F4A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 08:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659109674; x=1690645674;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=57j7+Rr2khf+4no1MtJTPN4zj/VUnqBTlsqYu5nPK68=;
  b=HopuDYoCX5/U2Wypoqiu8Dk69YtUB3i8uLCrVBmXKu33dzd/597ZaYTb
   NHfPHYLllS9SyYRuXuPFxFOaF7DaDKv9Um9eWbmUoAM8c06MCenRHcXMj
   E2L1pcCrpxTLC35b91/htvkg3VqmeoLFTdw90xYb81cGI34BZC/ktyj8E
   4=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 29 Jul 2022 08:47:54 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 08:47:53 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 29 Jul 2022 08:47:53 -0700
Received: from [10.216.48.47] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 29 Jul
 2022 08:47:48 -0700
Message-ID: <6b646ff2-b6f6-052e-f3f4-3bf05243f049@quicinc.com>
Date:   Fri, 29 Jul 2022 21:17:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V2] mm: fix use-after free of page_ext after race with
 memory-offline
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
CC:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <quic_pkondeti@quicinc.com>, <pasha.tatashin@soleen.com>,
        <sjpark@amazon.de>, <sieberf@amazon.com>, <shakeelb@google.com>,
        <dhowells@redhat.com>, <willy@infradead.org>, <minchan@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <1658931303-17024-1-git-send-email-quic_charante@quicinc.com>
 <YuKfQoOHG1celfBK@dhcp22.suse.cz>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <YuKfQoOHG1celfBK@dhcp22.suse.cz>
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

Thanks Michal for the reviews!!

On 7/28/2022 8:07 PM, Michal Hocko wrote:
>> FAQ's:
>> Q) Should page_ext_[get|put]() needs to be used for every page_ext
>> access?
>> A) NO, the synchronization is really not needed in all the paths of
>> accessing page_ext. One case is where extra refcount is taken on a
>> page for which memory block, this pages falls into, offline operation is
>> being performed. This extra refcount makes the offline operation not to
>> succeed hence the freeing of page_ext.  Another case is where the page
>> is already being freed and we do reset its page_owner.
> This is just subtlety and something that can get misunderstood over
> time. Moreover there is no documentation explaining the difference.
> What is the reason to have these two different APIs in the first place.
> RCU read side is almost zero cost. So what is the point?
Currently not all the places where page_ext is being used is put under
the rcu_lock. I just used rcu lock in the places where it is possible to
have the use-after-free of page_ext. You recommend to use rcu lock while
using with page_ext in all the places?

My only point here is since there may be a non-atomic context exist
across page_ext_get/put() and If users are sure that this page's
page_ext will not be freed by parallel offline operation, they need not
get the rcu lock.

I agree that this can be misunderstood over time, let me check if I can
use page_ext_get/put in all the places.

>> @@ -57,6 +60,11 @@ static inline void page_ext_init(void)
>>  
>>  struct page_ext *lookup_page_ext(const struct page *page);
>>  
>> +static inline bool page_ext_invalid(struct page_ext *page_ext)
>> +{
>> +	return !page_ext || (((unsigned long)page_ext & PAGE_EXT_INVALID) == 1);
>> +}
>> +
> No real reason to expose this into a header file. Nothing but page_ext.c
> should know and care about this.
Agree. Will move it accordingly.

> 
>> +static inline struct page_ext *page_ext_get(struct page *page)
>> +{
>> +	struct page_ext *page_ext;
>> +
>> +	rcu_read_lock();
>> +	page_ext = lookup_page_ext(page);
>> +	if (!page_ext) {
>> +		rcu_read_unlock();
>> +		return NULL;
>> +	}
>> +
>> +	return page_ext;
> If you make this an extern you can actually hide lookup_page_ext and
> prevent from future bugs where people are using non serialized API
> without realizing that.

This design looks good. Let me check the feasibility in its implementation.

>> diff --git a/mm/page_ext.c b/mm/page_ext.c
>> index 3dc715d..404a2eb 100644
>> --- a/mm/page_ext.c
>> +++ b/mm/page_ext.c
>> @@ -211,15 +211,17 @@ struct page_ext *lookup_page_ext(const struct page *page)
>>  {
>>  	unsigned long pfn = page_to_pfn(page);
>>  	struct mem_section *section = __pfn_to_section(pfn);
>> +	struct page_ext *page_ext = READ_ONCE(section->page_ext);
>> +
> 	WARN_ON_ONCE(!rcu_read_lock_held());

Again this requires page_ext usage should be under the rcu lock always
by the user.

> 
>>  static void *__meminit alloc_page_ext(size_t size, int nid)
>> @@ -298,9 +300,26 @@ static void __free_page_ext(unsigned long pfn)
>>  	ms = __pfn_to_section(pfn);
>>  	if (!ms || !ms->page_ext)
>>  		return;
>> -	base = get_entry(ms->page_ext, pfn);
>> +
>> +	base = READ_ONCE(ms->page_ext);
>> +	if (page_ext_invalid(base))
>> +		base = (void *)base - PAGE_EXT_INVALID;
> All page_ext accesses should use the same fetched pointer including the
> ms->page_ext check. Also page_ext_invalid _must_ be true here otherwise
> something bad is going on so I would go with
> 	if (WARN_ON_ONCE(!page_ext_invalid(base)))
> 		return;
> 	base = (void *)base - PAGE_EXT_INVALID;

The roll back operation in the online_page_ext(), where we free the
allocated page_ext's, will not have the PAGE_EXT_INVALID flag thus
WARN() may not work here. no?
> 

Thanks,
Charan
