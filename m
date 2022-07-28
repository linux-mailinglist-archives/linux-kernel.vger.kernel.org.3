Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2F0583B8E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 11:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbiG1Jx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 05:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235453AbiG1Jx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 05:53:57 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5061E62A40
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 02:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659002036; x=1690538036;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3qs3DxGVSPNfGTT1wKezXNqrhoxf5Ecu42p6xBUn5gw=;
  b=xshzPeksr7ft1jEJMkPPw632L3zTKDNWKkE9f8lSlz7c58EVMtj/P3Va
   LN/RPpuaaR5inXgUF6Zc9od0BPIYuVpcrwftBCo0SN4Am2NWcrEFTGhSn
   C4RfWSYxi5dqGkEWghoqsnxtwhy9saR5qtMXMDgLWmxe542e0heR8X567
   M=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Jul 2022 02:53:56 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 02:53:55 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 28 Jul 2022 02:53:55 -0700
Received: from [10.214.20.211] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 28 Jul
 2022 02:53:50 -0700
Message-ID: <a26ce299-aed1-b8ad-711e-a49e82bdd180@quicinc.com>
Date:   Thu, 28 Jul 2022 15:23:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V2] mm: fix use-after free of page_ext after race with
 memory-offline
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>,
        <quic_pkondeti@quicinc.com>, <pasha.tatashin@soleen.com>,
        <sjpark@amazon.de>, <sieberf@amazon.com>, <shakeelb@google.com>,
        <dhowells@redhat.com>, <willy@infradead.org>,
        <liuting.0x7c00@bytedance.com>, <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <1658931303-17024-1-git-send-email-quic_charante@quicinc.com>
 <6168cf49-bf75-2ebb-ab55-30de473835e3@redhat.com>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <6168cf49-bf75-2ebb-ab55-30de473835e3@redhat.com>
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

Thanks David for the inputs!!

On 7/27/2022 10:59 PM, David Hildenbrand wrote:
>> Fix those paths where offline races with page_ext access by maintaining
>> synchronization with rcu lock and is achieved in 3 steps:
>> 1) Invalidate all the page_ext's of the sections of a memory block by
>> storing a flag in the LSB of mem_section->page_ext.
>>
>> 2) Wait till all the existing readers to finish working with the
>> ->page_ext's with synchronize_rcu(). Any parallel process that starts
>> after this call will not get page_ext, through lookup_page_ext(), for
>> the block parallel offline operation is being performed.
>>
>> 3) Now safely free all sections ->page_ext's of the block on which
>> offline operation is being performed.
>>
>> Thanks to David Hildenbrand for his views/suggestions on the initial
>> discussion[1] and Pavan kondeti for various inputs on this patch.
>>
>> FAQ's:
>> Q) Should page_ext_[get|put]() needs to be used for every page_ext
>> access?
>> A) NO, the synchronization is really not needed in all the paths of
>> accessing page_ext. One case is where extra refcount is taken on a
>> page for which memory block, this pages falls into, offline operation is
>> being performed. This extra refcount makes the offline operation not to
>> succeed hence the freeing of page_ext.  Another case is where the page
>> is already being freed and we do reset its page_owner.
>>
>> Some examples where the rcu_lock is not taken while accessing the
>> page_ext are:
>> 1) In migration (where we also migrate the page_owner information), we
>> take the extra refcount on the source and destination pages and then
>> start the migration. This extra refcount makes the test_pages_isolated()
>> function to fail thus retry the offline operation.
>>
>> 2) In free_pages_prepare(), we do reset the page_owner(through page_ext)
>> which again doesn't need the protection to access because the page is
>> already freeing (through only one path).
>>
>> So, users need not to use page_ext_[get|put]() when they are sure that
>> extra refcount is taken on a page preventing the offline operation.
>>
>> Q) Why can't the page_ext is freed in the hot_remove path, where memmap
>> is also freed ?
>>
>> A) As per David's answers, there are many reasons and a few are:
>> 1) Discussions had happened in the past to eventually also use rcu
>> protection for handling pfn_to_online_page(). So doing it cleanly here
>> is certainly an improvement.
>>
>> 2) It's not good having to scatter section online checks all over the
>> place in page ext code. Once there is a difference between active vs.
>> stale page ext data things get a bit messy and error prone. This is
>> already ugly enough in our generic memmap handling code.
>>
>> 3) Having on-demand allocations, such as KASAN or page ext from the
>> memory online notifier is at least currently cleaner, because we don't
>> have to handle each and every subsystem that hooks into that during the
>> core memory hotadd/remove phase, which primarily only setups the
>> vmemmap, direct map and memory block devices.
>>
>> [1] https://lore.kernel.org/linux-mm/59edde13-4167-8550-86f0-11fc67882107@quicinc.com/
>>
> I guess if we care about the synchronize_rcu() we could go crazy with
> temporary allocations for data-to-free + call_rcu().

IMO, single synchronize_rcu() call overhead shouldn't be cared
especially if the memory offline operation it self is expected to
complete in seconds. On the Snapdragon system, I can see the lowest it
can complete in 3-4secs for a complete memory block of size 512M. And
agree that this time depends on lot of other factors too but wanted to
raise a point that it is really not a path where tiny optimizations
should be strictly considered. __Please help in correcting me If I am
really downplaying the scenario here__.

But then I moved to single synchronize_rcu() just to avoid any visible
effects that can cause by multiple synchronize_rcu() for a single memory
block with lot of sections.

Having said that, I am open to go for call_rcu() and infact it will be a
much simple change where I can do the freeing of page_ext in the
__free_page_ext() itself which is called for every section there by
avoid the extra tracking flag PAGE_EXT_INVALID.
      ...........
        WRITE_ONCE(ms->page_ext, NULL);
	call_rcu(rcu_head, fun); // Free in fun()
       .............

Or your opinion is to use call_rcu () only once in place of
synchronize_rcu() after invalidating all the page_ext's of memory block?

Thanks,
Charan
