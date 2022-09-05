Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98AC5AC9B5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 07:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbiIEFOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 01:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiIEFOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 01:14:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4F322B05
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 22:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662354840; x=1693890840;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=D4k1oFGhLcXnX4/OlSg3hXa8MNslOOX6+1favOdynTg=;
  b=nLwah0aYAdFRFmRZwekWKiW9bZ0kdHuh6vLfMIvndgUyKIQLamEGz5JH
   jTKBOPnjMTSGAtL97xvd3eo2XvgRwQXQLFhaijKxfvFO/SXslkj96duwd
   zKQ+m1j8RStJwMZuYxj5NG6ad4s5pS0AaQeoyzvpnRx5xKfoitLs6pyGh
   1aRR4FanTfPTXR0i2sF6gQpLHxoM56MdiDLdYdxTjgzhtZ77atS2cKqqs
   T4i1vc9ODcxI84wHAoC3xN2vQHRFTihyzCPyKUXF2rWqhtQK/53+ofzA5
   GpZCXF8FH0xe7rQmUqCHfxzT1vrf9sGJwxE8y64JE4VNr0meJqqfQrFh1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="279323017"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="279323017"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2022 22:13:59 -0700
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="681934668"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2022 22:13:49 -0700
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
        <877d2mz3c1.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <45488760-02b5-115b-c16d-5219303f2f33@linux.ibm.com>
        <CAAPL-u_UoAQ9koo892sG-Tx4bi4xDRe9PUtjmFSsn90uU-n31g@mail.gmail.com>
        <871qsuyzr2.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <672e528d-40b7-fc12-9b0c-1591d586c079@linux.ibm.com>
        <87wnamxi30.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <5aaf395d-514a-2717-58c6-3845b97692bd@linux.ibm.com>
        <87sfl6y4d0.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <dbd5b8e4-2b74-97cd-f05c-1b57a2df5c0c@linux.ibm.com>
Date:   Mon, 05 Sep 2022 13:13:37 +0800
In-Reply-To: <dbd5b8e4-2b74-97cd-f05c-1b57a2df5c0c@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Mon, 5 Sep 2022 09:20:14 +0530")
Message-ID: <87ilm2xv26.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On 9/5/22 7:22 AM, Huang, Ying wrote:
>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>> 
>>> On 9/2/22 2:34 PM, Huang, Ying wrote:
>>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>>>
>>>>> On 9/2/22 1:27 PM, Huang, Ying wrote:
>>>>>> Wei Xu <weixugc@google.com> writes:
>>>>>>
>>>>>>> On Thu, Sep 1, 2022 at 11:44 PM Aneesh Kumar K V
>>>>>>> <aneesh.kumar@linux.ibm.com> wrote:
>>>>>>>>
>>>>>>>> On 9/2/22 12:10 PM, Huang, Ying wrote:
>>>>>>>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>>>>>>>>
>>>>>>>>>> On 9/2/22 11:42 AM, Huang, Ying wrote:
>>>>>>>>>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>>>>>>>>>>
>>>>>>>>>>>> On 9/2/22 11:10 AM, Huang, Ying wrote:
>>>>>>>>>>>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>>>>>>>>>>>>
>>>>>>>>>>>>>> On 9/2/22 10:39 AM, Wei Xu wrote:
>>>>>>>>>>>>>>> On Thu, Sep 1, 2022 at 5:33 PM Huang, Ying <ying.huang@intel.com> wrote:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> On 9/1/22 12:31 PM, Huang, Ying wrote:
>>>>>>>>>>>>>>>>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> This patch adds /sys/devices/virtual/memory_tiering/ where all memory tier
>>>>>>>>>>>>>>>>>>> related details can be found. All allocated memory tiers will be listed
>>>>>>>>>>>>>>>>>>> there as /sys/devices/virtual/memory_tiering/memory_tierN/
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> The nodes which are part of a specific memory tier can be listed via
>>>>>>>>>>>>>>>>>>> /sys/devices/virtual/memory_tiering/memory_tierN/nodes
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> I think "memory_tier" is a better subsystem/bus name than
>>>>>>>>>>>>>>>>>> memory_tiering.  Because we have a set of memory_tierN devices inside.
>>>>>>>>>>>>>>>>>> "memory_tier" sounds more natural.  I know this is subjective, just my
>>>>>>>>>>>>>>>>>> preference.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I missed replying to this earlier. I will keep memory_tiering as subsystem name in v4
>>>>>>>>>>>>>> because we would want it to a susbsystem where all memory tiering related details can be found
>>>>>>>>>>>>>> including memory type in the future. This is as per discussion
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> https://lore.kernel.org/linux-mm/CAAPL-u9TKbHGztAF=r-io3gkX7gorUunS2UfstudCWuihrA=0g@mail.gmail.com
>>>>>>>>>>>>>
>>>>>>>>>>>>> I don't think that it's a good idea to mix 2 types of devices in one
>>>>>>>>>>>>> subsystem (bus).  If my understanding were correct, that breaks the
>>>>>>>>>>>>> driver core convention.
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> All these are virtual devices .I am not sure i follow what you mean by 2 types of devices.
>>>>>>>>>>>> memory_tiering is a subsystem that represents all the details w.r.t memory tiering. It shows
>>>>>>>>>>>> details of memory tiers and can possibly contain details of different memory types .
>>>>>>>>>>>
>>>>>>>>>>> IMHO, memory_tier and memory_type are 2 kind of devices.  They have
>>>>>>>>>>> almost totally different attributes (sysfs file).  So, we should create
>>>>>>>>>>> 2 buses for them.  Each has its own attribute group.  "virtual" itself
>>>>>>>>>>> isn't a subsystem.
>>>>>>>>>>
>>>>>>>>>> Considering both the details are related to memory tiering, wouldn't it be much simpler we consolidate
>>>>>>>>>> them within the same subdirectory? I am still not clear why you are suggesting they need to be in different
>>>>>>>>>> sysfs hierarchy.  It doesn't break any driver core convention as you mentioned earlier.
>>>>>>>>>>
>>>>>>>>>> /sys/devices/virtual/memory_tiering/memory_tierN
>>>>>>>>>> /sys/devices/virtual/memory_tiering/memory_typeN
>>>>>>>>>
>>>>>>>>> I think we should add
>>>>>>>>>
>>>>>>>>>  /sys/devices/virtual/memory_tier/memory_tierN
>>>>>>>>>  /sys/devices/virtual/memory_type/memory_typeN
>>>>>>>>>
>>>>>>>>
>>>>>>>> I am trying to find if there is a technical reason to do the same?
>>>>>>>>
>>>>>>>>> I don't think this is complex.  Devices of same bus/subsystem should
>>>>>>>>> have mostly same attributes.  This is my understanding of driver core
>>>>>>>>> convention.
>>>>>>>>>
>>>>>>>>
>>>>>>>> I was not looking at this from code complexity point. Instead of having multiple directories
>>>>>>>> with details w.r.t memory tiering, I was looking at consolidating the details
>>>>>>>> within the directory /sys/devices/virtual/memory_tiering. (similar to all virtual devices
>>>>>>>> are consolidated within /sys/devics/virtual/).
>>>>>>>>
>>>>>>>> -aneesh
>>>>>>>
>>>>>>> Here is an example of /sys/bus/nd/devices (I know it is not under
>>>>>>> /sys/devices/virtual, but it can still serve as a reference):
>>>>>>>
>>>>>>> ls -1 /sys/bus/nd/devices
>>>>>>>
>>>>>>> namespace2.0
>>>>>>> namespace3.0
>>>>>>> ndbus0
>>>>>>> nmem0
>>>>>>> nmem1
>>>>>>> region0
>>>>>>> region1
>>>>>>> region2
>>>>>>> region3
>>>>>>>
>>>>>>> So I think it is not unreasonable if we want to group memory tiering
>>>>>>> related interfaces within a single top directory.
>>>>>>
>>>>>> Thanks for pointing this out.  My original understanding of driver core
>>>>>> isn't correct.
>>>>>>
>>>>>> But I still think it's better to separate instead of mixing memory_tier
>>>>>> and memory_type.  Per my understanding, memory_type shows information
>>>>>> (abstract distance, latency, bandwidth, etc.) of memory types (and
>>>>>> nodes), it can be useful even without memory tiers.  That is, memory
>>>>>> types describes the physical characteristics, while memory tier reflects
>>>>>> the policy.
>>>>>>
>>>>>
>>>>> The latency and bandwidth details are already exposed via 
>>>>>
>>>>> 	/sys/devices/system/node/nodeY/access0/initiators/
>>>>>
>>>>> Documentation/admin-guide/mm/numaperf.rst
>>>>>
>>>>> That is the interface that libraries like libmemkind will look at for finding
>>>>> details w.r.t latency/bandwidth
>>>>
>>>> Yes.  Only with that, it's still inconvenient to find out which nodes
>>>> belong to same memory type (has same performance, same topology, managed
>>>> by same driver, etc).  So memory types can still provide useful
>>>> information even without memory tiering.
>>>>
>>>
>>> I am not sure i quiet follow what to conclude from your reply. I used the subsystem name
>>> "memory_tiering" so that all memory tiering related information can be consolidated there.
>>> I guess you agreed to the above part that we can consolidated things like that. 
>> 
>> I just prefer to separate memory_tier and memory_type sysfs directories
>> personally.  Because memory_type describes the physical memory types and
>> performance, while memory_tier is more about the policy to group
>> memory_types.
>>
> IMHO we can decide on that based on why we end up adding memory_type details to sysfs. If that
> is only for memory tier modification from userspace we can look at adding that in the memory tiering
> sysfs hierarchy. 
>
> Also since we have precedence of consolidating things within a sysfs hierarchy as explained in previous emails,
> I think we should keep "memory_tiering" as sysfs subsystem name? I hope we can get an agreement on that
> for now?

I prefer to separate memory_tier and memory_type, so the subsystem name
should be "memory_tier".  You prefer to consolidate memory_tier and
memory_type, so the subsystem name should be "memory_tiering".

The main reason behind my idea is that memory_type isn't tied with
memory tiering directly.  It describes some hardware property.  Even if
we don't use memory tiering, we can still use that to classify the
memory devices in the system.

Why do you want to consolidate them?  To reduce one directory from
sysfs?

I want to get opinions from other people too.

Best Regards,
Huang, Ying
