Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56D357B930
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbiGTPJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240677AbiGTPJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:09:08 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC7D237D6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658329747; x=1689865747;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XQEIPKoK4Ose4pVN5SW4281GICAnAiZSwLOy+QWsPEU=;
  b=yXON4TKCDgLDyNajycTrbjKXj2lwYYTOZ/xBS8ano+3ykvAHPzYE3CZi
   FEJFOHK4XqzXaKC5joxvGMsD/h0/UtIO1bgCDPgUiPhXVJEuMeBtgoAEX
   FT5ghAmMa3vKgyQp7k/p2VJs56OZs6zE1Ui0HAjER8uL93W1r3Qb6WyrR
   I=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Jul 2022 08:09:07 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 08:09:07 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 08:09:06 -0700
Received: from [10.216.34.46] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 20 Jul
 2022 08:09:01 -0700
Message-ID: <dd4e4b4c-65cd-93e5-3658-e73e754cad71@quicinc.com>
Date:   Wed, 20 Jul 2022 20:38:58 +0530
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
 <aaeec83d-bdf8-280c-b943-ad510f1d8db2@quicinc.com>
 <YtbRF9Z1tVxgw+g0@dhcp22.suse.cz>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <YtbRF9Z1tVxgw+g0@dhcp22.suse.cz>
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

Thanks Michal here!!

On 7/19/2022 9:13 PM, Michal Hocko wrote:
>>>>>> diff --git a/mm/page_ext.c b/mm/page_ext.c
>>>>>> index 3dc715d..5ccd3ee 100644
>>>>>> --- a/mm/page_ext.c
>>>>>> +++ b/mm/page_ext.c
>>>>>> @@ -299,8 +299,9 @@ static void __free_page_ext(unsigned long pfn)
>>>>>>  	if (!ms || !ms->page_ext)
>>>>>>  		return;
>>>>>>  	base = get_entry(ms->page_ext, pfn);
>>>>>> -	free_page_ext(base);
>>>>>>  	ms->page_ext = NULL;
>>>>>> +	synchronize_rcu();
>>>>>> +	free_page_ext(base);
>>>>>>  }
>>>>> So you are imposing the RCU grace period for each page_ext! This can get
>>>>> really expensive. Have you tried to measure the effect?
>>> I was wrong here! This is for each memory section which is not as
>>> terrible as every single page_ext. This can be still quite a lot memory
>>> sections in a single memory block (e.g. on ppc memory sections are
>>> ridiculously small).
>>>
>> On the ARM64, I see that the minimum a section size will go is 128MB. I
>> think 16MB is the section size on ppc. Any inputs on how frequently
>> offline/online operation is being done on this ppc arch?
> I have seen several reports where 16MB sections were used on PPC LPARs
> with a non trivial size. My usual answer to that is tha this is mostly a
> self inflicted injury but I am told that for some reasons I cannot
> udnerstand this is not easy to change. So reasonable or not this is not
> all that uncommon in PPC land.
> 
> We definitely shouldn't optimize for those setups but we shouldn't make
> them suffer even more as well. Besides that it seems that a single
> rcu_synchronize per offline operation should be doable.

I too feel it is doable but the code might look to need to traverse the
sections of a memory block twice.

1) with synchronize_rcu() calling for each memory section of a memblock:
---------------------------------------------------------------------
for (pfn = start; pfn < end; pfn += PAGES_PER_SECTION)
    __free_page_ext(pfn):
         ms->page_ext = NULL
         synchronize_rcu();// Called on every section.
	 free_page_ext();//free the page_ext.

2) With a single synchronize_rcu() for each offlined block:
-------------------------------------------------------
for (pfn = start; pfn < end; pfn += PAGES_PER_SECTION) {
	__free_page_ext(pfn):
	    ms->page_ext = NULL;
}
synchronize_rcu(); // call synchronize_rcu for just once
for (pfn = start; pfn < end; pfn += PAGES_PER_SECTION)
	free_page_ext(); // Free the page_ext.

Any better code you have in mind here please?

But since there are few sections the overhead of traversing them will be
definitely less compared to synchronize_rcu() per memsection.

But I really doubt if there will be a real impact making sync_rcu per
section because,(as david also mentioned and you also corrected it I
think), the concern here is for ppc where the min memblock size is 256M
with section size of 16M and there is a single offline operation on that
block but can end up in calling 16 sync_rcu() calls. Should we really
optimize this case here? If yes, I can go with the approach 2) mentioned
above. Sorry if I am really undermining the problem here.


Thanks,
Charan

