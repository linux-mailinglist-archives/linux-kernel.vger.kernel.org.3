Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734EA57B4B1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 12:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbiGTKnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 06:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiGTKna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 06:43:30 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D891066AF1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 03:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658313808; x=1689849808;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bXOtkSkNPN/B9tmbWziX3PgrKXqM7+mLUw/3t2EA2Ug=;
  b=H7j0togztSW7QGAvIqWRWS/BNQgBU9r6fomhL461kx8u75HyEQLAvqAp
   +T38oaiy+7DcwEYWXfwLIeXmF01+a+rg1Bm6HRtWtIJS2yECR+LADSZ/+
   jkEF5yzaR/ME1Veaq6eixFyaB8hkpY5roE2Ku9SByDTnwRu16pUnK2OY0
   U=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 20 Jul 2022 03:43:28 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 03:43:28 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 03:43:27 -0700
Received: from [10.216.34.46] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 20 Jul
 2022 03:43:22 -0700
Message-ID: <f7e1efa4-43da-22e0-b748-d0855ecc7456@quicinc.com>
Date:   Wed, 20 Jul 2022 16:13:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] mm: fix use-after free of page_ext after race with
 memory-offline
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     <akpm@linux-foundation.org>, <pasha.tatashin@soleen.com>,
        <sjpark@amazon.de>, <sieberf@amazon.com>, <shakeelb@google.com>,
        <dhowells@redhat.com>, <willy@infradead.org>, <vbabka@suse.cz>,
        <david@redhat.com>, <minchan@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>
References: <1657810063-28938-1-git-send-email-quic_charante@quicinc.com>
 <YtVJBQ/ZOt22o8+B@dhcp22.suse.cz>
 <fca23df7-37b0-f32d-ece3-58317dfad210@quicinc.com>
 <YtV0PSMAGG46Pq0K@dhcp22.suse.cz>
 <aaeec83d-bdf8-280c-b943-ad510f1d8db2@quicinc.com>
 <20220720082112.GA14437@hu-pkondeti-hyd.qualcomm.com>
 <YtfGeUUoi9cq3g0A@dhcp22.suse.cz>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <YtfGeUUoi9cq3g0A@dhcp22.suse.cz>
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

Thanks Michal & Pavan,

On 7/20/2022 2:40 PM, Michal Hocko wrote:
>>>> Thanks! The most imporant part is how the exclusion is actual achieved
>>>> because that is not really clear at first sight
>>>>
>>>> CPU1					CPU2
>>>> lookup_page_ext(PageA)			offlining
>>>> 					  offline_page_ext
>>>> 					    __free_page_ext(addrA)
>>>> 					      get_entry(addrA)
>>>> 					      ms->page_ext = NULL
>>>> 					      synchronize_rcu()
>>>> 					      free_page_ext
>>>> 					        free_pages_exact (now addrA is unusable)
>>>> 					
>>>>   rcu_read_lock()
>>>>   entryA = get_entry(addrA)
>>>>     base + page_ext_size * index # an address not invalidated by the freeing path
>>>>   do_something(entryA)
>>>>   rcu_read_unlock()
>>>>
>>>> CPU1 never checks ms->page_ext so it cannot bail out early when the
>>>> thing is torn down. Or maybe I am missing something. I am not familiar
>>>> with page_ext much.
>>>
>>> Thanks a lot for catching this Michal. You are correct that the proposed
>>> code from me is still racy. I Will correct this along with the proper
>>> commit message in the next version of this patch.
>>>
>> Trying to understand your discussion with Michal. What part is still racy? We
>> do check for mem_section::page_ext and bail out early from lookup_page_ext(),
>> no?
>>
>> Also to make this scheme explicit, we can annotate page_ext member with __rcu
>> and use rcu_assign_pointer() on the writer side.

Annotating with __rcu requires all the read and writes to ms->page_ext
to be under rcu_[access|assign]_pointer which is a big patch. I think
READ_ONCE and WRITE_ONCE, mentioned by Michal, below should does the job.

>>
>> struct page_ext *lookup_page_ext(const struct page *page)
>> {
>>         unsigned long pfn = page_to_pfn(page);
>>         struct mem_section *section = __pfn_to_section(pfn);
>>         /*
>>          * The sanity checks the page allocator does upon freeing a
>>          * page can reach here before the page_ext arrays are
>>          * allocated when feeding a range of pages to the allocator
>>          * for the first time during bootup or memory hotplug.
>>          */
>>         if (!section->page_ext)
>>                 return NULL;
>>         return get_entry(section->page_ext, pfn);
>> }
> You are right. I was looking at the wrong implementation and misread
> ifdef vs. ifndef CONFIG_SPARSEMEM. My bad.
> 

There is still a small race window b/n ms->page_ext setting NULL and its
access even under CONFIG_SPARSEMEM. In the above mentioned example:

 CPU1					CPU2
 rcu_read_lock()
 lookup_page_ext(PageA):		offlining
 					  offline_page_ext
 					    __free_page_ext(addrA)
 					      get_entry(addrA)
    if (!section->page_ext)
       turns to be false.
 					      ms->page_ext = NULL
						
   addrA = get_entry(base=section->page_ext):
     base + page_ext_size * index;
     **Since base is NULL here, caller
     can still do the dereference on
     the invalid pointer address.**
						
 					      synchronize_rcu()
 					      free_page_ext
 					        free_pages_exact (now )


> Memory hotplug is not supported outside of CONFIG_SPARSEMEM so the
> scheme should really work. I would use READ_ONCE for ms->page_ext and
> WRITE_ONCE on the initialization side.

Yes, I should be using the READ_ONCE() and WRITE_ONCE() here.

Thanks,
Charan
