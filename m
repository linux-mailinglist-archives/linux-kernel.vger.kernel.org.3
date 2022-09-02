Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDF95AA831
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 08:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbiIBGks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 02:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235431AbiIBGkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 02:40:43 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC6848C88
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 23:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662100837; x=1693636837;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=sE6sa0vwx0FKfcHDMJ+oRYmOnHHQlFAFE5YS9SVeHls=;
  b=ACdLLXSQhHKQVlq+f7NBWTbCrPac9vtrG3rVltleSIW53Lfpoea7YRGs
   EgH04HkwflMCiOvIP85Rs5ZujbAUR1py5+WIcZYKdtymqj2x58VMNcW8w
   NJ4CnbuAjpoyJw+vskz5HPJfCRyKFefqz3HtOCWKA/9Y6NzS00w1y8Q+r
   EgKa/9Eye0Jw0qa4+tppQdsZXHOZQWKseT16qMkRLDFKB09N5ENSRkSdd
   0zimH3/TfYEt7qJrHOElhDaxJ1Kg6IwsQXRls3rkjBdqsi2QLJQ/r9iqM
   CSKSSZ2G3oKRtsYDCezT1adFE4gh9OnGyQ7o4fPpu6OlJfzdTjHIYIqMg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="278925047"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="278925047"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 23:40:36 -0700
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="941173805"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 23:40:32 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     Wei Xu <weixugc@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        jvgediya.oss@gmail.com, Bharata B Rao <bharata@amd.com>,
        Greg Thelen <gthelen@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 updated] mm/demotion: Expose memory tier details via
 sysfs
References: <20220830081736.119281-1-aneesh.kumar@linux.ibm.com>
        <87tu5rzigc.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ad19e105-9290-922d-59e6-e6813a30f5f0@linux.ibm.com>
        <87pmgezkhp.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAAPL-u8MEs04DkHy6kaS788VjdYZZjAYOgzMnioOzDXbc0ZhhQ@mail.gmail.com>
        <d91beb53-e940-e02a-f9ca-3326bf914da7@linux.ibm.com>
        <87fshaz63h.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <698120ce-d4df-3d13-dea9-a8f5c298783c@linux.ibm.com>
        <87bkryz4nh.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <2b4ddc45-74ae-27df-d973-6724f61f4e18@linux.ibm.com>
Date:   Fri, 02 Sep 2022 14:40:30 +0800
In-Reply-To: <2b4ddc45-74ae-27df-d973-6724f61f4e18@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Fri, 2 Sep 2022 12:01:43 +0530")
Message-ID: <877d2mz3c1.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:

> On 9/2/22 11:42 AM, Huang, Ying wrote:
>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>> 
>>> On 9/2/22 11:10 AM, Huang, Ying wrote:
>>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>>>
>>>>> On 9/2/22 10:39 AM, Wei Xu wrote:
>>>>>> On Thu, Sep 1, 2022 at 5:33 PM Huang, Ying <ying.huang@intel.com> wrote:
>>>>>>>
>>>>>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>>>>>>
>>>>>>>> On 9/1/22 12:31 PM, Huang, Ying wrote:
>>>>>>>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>>>>>>>>
>>>>>>>>>> This patch adds /sys/devices/virtual/memory_tiering/ where all memory tier
>>>>>>>>>> related details can be found. All allocated memory tiers will be listed
>>>>>>>>>> there as /sys/devices/virtual/memory_tiering/memory_tierN/
>>>>>>>>>>
>>>>>>>>>> The nodes which are part of a specific memory tier can be listed via
>>>>>>>>>> /sys/devices/virtual/memory_tiering/memory_tierN/nodes
>>>>>>>>>
>>>>>>>>> I think "memory_tier" is a better subsystem/bus name than
>>>>>>>>> memory_tiering.  Because we have a set of memory_tierN devices inside.
>>>>>>>>> "memory_tier" sounds more natural.  I know this is subjective, just my
>>>>>>>>> preference.
>>>>>>>>>
>>>>>
>>>>>
>>>>> I missed replying to this earlier. I will keep memory_tiering as subsystem name in v4 
>>>>> because we would want it to a susbsystem where all memory tiering related details can be found
>>>>> including memory type in the future. This is as per discussion 
>>>>>
>>>>> https://lore.kernel.org/linux-mm/CAAPL-u9TKbHGztAF=r-io3gkX7gorUunS2UfstudCWuihrA=0g@mail.gmail.com
>>>>
>>>> I don't think that it's a good idea to mix 2 types of devices in one
>>>> subsystem (bus).  If my understanding were correct, that breaks the
>>>> driver core convention.
>>>>
>>>
>>> All these are virtual devices .I am not sure i follow what you mean by 2 types of devices.
>>> memory_tiering is a subsystem that represents all the details w.r.t memory tiering. It shows
>>> details of memory tiers and can possibly contain details of different memory types .
>> 
>> IMHO, memory_tier and memory_type are 2 kind of devices.  They have
>> almost totally different attributes (sysfs file).  So, we should create
>> 2 buses for them.  Each has its own attribute group.  "virtual" itself
>> isn't a subsystem.
>
> Considering both the details are related to memory tiering, wouldn't it be much simpler we consolidate
> them within the same subdirectory? I am still not clear why you are suggesting they need to be in different
> sysfs hierarchy.  It doesn't break any driver core convention as you mentioned earlier. 
>
> /sys/devices/virtual/memory_tiering/memory_tierN
> /sys/devices/virtual/memory_tiering/memory_typeN

I think we should add

 /sys/devices/virtual/memory_tier/memory_tierN
 /sys/devices/virtual/memory_type/memory_typeN

I don't think this is complex.  Devices of same bus/subsystem should
have mostly same attributes.  This is my understanding of driver core
convention.

Best Regards,
Huang, Ying
