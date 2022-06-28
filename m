Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA0D55E623
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346716AbiF1Nmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346770AbiF1Nmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:42:33 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D76B240B6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656423752; x=1687959752;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eU6cDt2dD8mM+1EzptzQ28Y5zLtIBvSjYlse5iTMKDQ=;
  b=LWtmcrYMVp2ol8jQv/34zVCWwtGX/CHVxdHCSJekdcOzJq3o1IF8U7N6
   G+1GuaKZvYxGMbgTal73I5lwhGViDi0ZLfCZ0YVUFFvpnm1VS/siey0V0
   VJyiKgJBpyD/kw5Vk/qYZi4ajn3OGaKbiXtF9gpgwq4hb/Iqn8dPBYFI1
   M=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Jun 2022 06:42:31 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 06:42:31 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 28 Jun 2022 06:42:31 -0700
Received: from [10.216.8.122] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 28 Jun
 2022 06:42:28 -0700
Message-ID: <78bfc1da-0bc4-ea43-474f-c51a84920a5c@quicinc.com>
Date:   Tue, 28 Jun 2022 19:12:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Discussion on race between freed page_ext access and memory
 offline operation
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Minchan Kim <minchan@kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <59edde13-4167-8550-86f0-11fc67882107@quicinc.com>
 <8fefe59d-c893-39f4-3225-65343086c867@redhat.com>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <8fefe59d-c893-39f4-3225-65343086c867@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks David for the inputs!!

On 6/27/2022 10:05 PM, David Hildenbrand wrote:
> On 27.06.22 18:09, Charan Teja Kalla wrote:
>> The below race between page_ext and online/offline of the respective
>> memory blocks will cause use-after-free on the access of page_ext structure.
>>
>> process1			    process2
>> ---------			    ---------
>> a)doing /proc/page_owner            doing memory offline	
>> 			            through offline_pages
>>
>> b)PageBuddy check is failed
>> thus proceed to get the
>> page_owner information
>> through page_ext access.
>> page_ext = lookup_page_ext(page);
>> 				
>> 				  migrate_pages();
>> 				 ................
>> 				Since all pages are successfully
>> 				migrated as part of the offline
>> 				operation,send MEM_OFFLINE notification
>> 				where for page_ext it calls:
>> 				offline_page_ext()-->
>> 				  __free_page_ext()-->
>> 				    free_page_ext()-->
>> 				      vfree(ms->page_ext)
>> 				mem_section->page_ext = NULL
>>
>> c) Check for the PAGE_EXT flags
>> in the page_ext->flags access
>> results into the use-after-free(leading
>> to the translation faults).
>>
>> As mentioned above, there is really no synchronization between page_ext
>> access and its freeing in the memory_offline.  The above is just one
>> example but the problem persists in the other paths too involving
>> page_ext->flags access(eg: page_is_idle()).
>>
>> The memory offline steps(roughly) on a memory block is as below:
>> 1) Isolate all the pages
>> 2) while(1)
>>   try free the pages to buddy.(->free_list[MIGRATE_ISOLATE])
>> 3) delete the pages from this buddy list.
>> 4) Then free page_ext.(Note: The struct page is still alive as it is
>> freed only during hot remove of the memory which frees the memmap, which
>> steps the user might not perform).
>>
>> This design leads to the state where struct page is alive but the struct
>> page_ext is freed, where the later is ideally part of the former which
>> just representing the page_flags. This seems to be a wrong design where
>> 'struct page' as a whole is not accessible(Thanks to Minchan for
>> pointing this out).
> Accessing the struct page -- including any extensions -- is invalid if
> the memory section is marked offline.
> 
> Usual PFN walkers use pfn_to_online_page() to make sure we have PFN with
> an actual meaning in it.

Is there such enforcement from the kernel side to use the
pfn_to_online_page() while doing the pfn walk?  Eg: In the same
read_page_owner()(Not sure of the other places), it is not used while
doing the pfn walk.

> 
> There is no real synchronization between pfn_to_online_page() and memory
> offline code. For now it wasn't required because it was never relevant
> in practice.
> 

Isn't the race here makes the code to still use the page despite it got
offlined parallel there by making the statement 'Accessing the struct
page -- including any extensions -- is invalid' applicable here.  Eg: In
the same read_page_owner(), it can go and try to dump the page_owner of
a page(agree that it dumps the proper page_owner) in print_page_owner(),
where it accesses the page->flags?

> After pfn_to_online_page() it takes quite a long time until memory is
> actually offlined and then, the memmap is removed. Maybe it's different
> for page_ext.
> 
As you already well aware, the memmap will not be removed as long as we
are playing just with the offline/online operation but page_ext is freed
even during the offline operation making **part of the struct page is
mapped and the other part is not**.

> 
> It smells like page_ext should use some mechanism during  MEM_OFFLINE to
> synchronize against any users of its metadata. Generic memory offlining
> code might be the wrong place for that.
> 
> page_ext needs a mechanism to synchronize against any users of the data
> it manages. Maybe RCU can help?

Let me give a thought about the feasibility of this. But this requires
making code at all the places where moving the page_ext users under
rcu_lock.
