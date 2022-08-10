Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2B558E44F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 03:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiHJBDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 21:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiHJBDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 21:03:15 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985E37FE64
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 18:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660093394; x=1691629394;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=QU0QFQIlk9ihlrAWfjh63Fch4PO6/pP1o8deWPkNo3o=;
  b=fkkRxeQyuAaS6flj+E5Zi/yVuS2YW6F4X58ovyXJLA+UqGj99xR0oITm
   2N2UDZ7Kzx+oB+xbgDy7jx241uJ1rwZwCYQpcCtGkKWCcw/Eohh+3Zwsm
   0BdfGN6PEcwYQF6t1YtcKcQoImKi0o7CtAnggdpy+gjKpPmTCEAy6K7Dt
   idpmrfJAvKpwmlYrjeqPZZ14YUSBqtDGHj4p+YOpX0ZlLfvR8OU85fBg7
   p3JvFHKVjDFdFRrG4sdh4yoW0PSrilHzr2DPtz2yoK4d/5jBqGDcfx+Vy
   3RGDLoXb5cLUBvr+W2YBMZOKm7wNkTlWRQnz0kqwTQiGj3jaltmqeYX05
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="274019588"
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="274019588"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 18:03:13 -0700
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="581026940"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 18:03:09 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Wei Xu <weixugc@google.com>, Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com
Subject: Re: [PATCH v13 6/9] mm/demotion: Add pg_data_t member to track node
 memory tier details
References: <20220808062601.836025-1-aneesh.kumar@linux.ibm.com>
        <20220808062601.836025-7-aneesh.kumar@linux.ibm.com>
        <87bksugfex.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <f3590060-3b7b-e576-0742-bd0dae8c760d@linux.ibm.com>
Date:   Wed, 10 Aug 2022 09:03:06 +0800
In-Reply-To: <f3590060-3b7b-e576-0742-bd0dae8c760d@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Tue, 9 Aug 2022 11:11:15 +0530")
Message-ID: <87sfm4gbat.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:

> On 8/9/22 10:51 AM, Huang, Ying wrote:
>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>> 
>>> Also update different helpes to use NODE_DATA()->memtier. Since
>>> node specific memtier can change based on the reassignment of
>>> NUMA node to a different memory tiers, accessing NODE_DATA()->memtier
>>> needs to happen under an rcu read lock or memory_tier_lock.
>>>
>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>> ---
>>>  include/linux/mmzone.h |  3 +++
>>>  mm/memory-tiers.c      | 38 ++++++++++++++++++++++++++++++++------
>>>  2 files changed, 35 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>>> index aab70355d64f..353812495a70 100644
>>> --- a/include/linux/mmzone.h
>>> +++ b/include/linux/mmzone.h
>>> @@ -928,6 +928,9 @@ typedef struct pglist_data {
>>>  	/* Per-node vmstats */
>>>  	struct per_cpu_nodestat __percpu *per_cpu_nodestats;
>>>  	atomic_long_t		vm_stat[NR_VM_NODE_STAT_ITEMS];
>>> +#ifdef CONFIG_NUMA
>>> +	struct memory_tier __rcu *memtier;
>>> +#endif
>>>  } pg_data_t;
>>>  
>>>  #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
>>> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
>>> index 02e514e87d5c..3778ac6a44a1 100644
>>> --- a/mm/memory-tiers.c
>>> +++ b/mm/memory-tiers.c
>>> @@ -5,6 +5,7 @@
>>>  #include <linux/kobject.h>
>>>  #include <linux/memory.h>
>>>  #include <linux/random.h>
>>> +#include <linux/mmzone.h>
>>>  #include <linux/memory-tiers.h>
>>>  
>>>  #include "internal.h"
>>> @@ -137,12 +138,18 @@ static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memty
>>>  
>>>  static struct memory_tier *__node_get_memory_tier(int node)
>>>  {
>>> -	struct memory_dev_type *memtype;
>>> +	pg_data_t *pgdat;
>>>  
>>> -	memtype = node_memory_types[node];
>>> -	if (memtype && node_isset(node, memtype->nodes))
>>> -		return memtype->memtier;
>>> -	return NULL;
>> 
>> After adding pgdat->memtier, it appears there's unnecessary to keep
>> memtype->memtier?
>> 
>
> It do simplify find_create_memory_tier() where I use if (memtype->memtier) 
> to check whether the memtype is already added to a memory tier. I could switch
> that to list_empty(memtype->tier_sibiling). But I felt the current one is much
> cleaner

I prefer "list_empty(memtype->tier_sibiling)".  But I will let you to
decide.

Best Regards,
Huang, Ying

