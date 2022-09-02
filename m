Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E065AA945
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 09:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbiIBH63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 03:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235608AbiIBH6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:58:15 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82A3BD164
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 00:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662105488; x=1693641488;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=U+sckmWxu/dh7LzjzffyvQqItsRKsl7L7Kdq5ogbtnY=;
  b=cQpgePs6DjCrtKVvKbsaFfqR/9OSObLdjwDxXeZSvvnKVp5QqJI2tjeA
   dlZIRmeTdcyaZh27Hz2zubx0QKpmTcgliW5C2RGlKTWqunVCFVlUq5E1B
   KhsS8sT2s/eqZ1ogERWZQwtdQ3yvqqW1hrfY/vktgVM3PjoZY1FhWc/bC
   PTCz4AhDtICNNZ6o7UXLLG0kCzyclllj7fPGsW3Lpi7dz0HwfTfOA5PiN
   FlP3LZRf6PkrNhM5jM4XwyFIwNupnFFxUgo/vakd32IkS7g5wKQuqs4Nv
   Wa5O8KPn7f+07cw2lhEc9kj5ZtuZpz3m+WYeTrn3bvUqVb3cWBtOI+7JE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="276328292"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="276328292"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 00:58:07 -0700
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="589983425"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 00:58:02 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Wei Xu <weixugc@google.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Linux MM <linux-mm@kvack.org>,
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
In-Reply-To: <CAAPL-u_UoAQ9koo892sG-Tx4bi4xDRe9PUtjmFSsn90uU-n31g@mail.gmail.com>
        (Wei Xu's message of "Fri, 2 Sep 2022 00:02:05 -0700")
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
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Fri, 02 Sep 2022 15:57:53 +0800
Message-ID: <871qsuyzr2.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Xu <weixugc@google.com> writes:

> On Thu, Sep 1, 2022 at 11:44 PM Aneesh Kumar K V
> <aneesh.kumar@linux.ibm.com> wrote:
>>
>> On 9/2/22 12:10 PM, Huang, Ying wrote:
>> > Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>> >
>> >> On 9/2/22 11:42 AM, Huang, Ying wrote:
>> >>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>> >>>
>> >>>> On 9/2/22 11:10 AM, Huang, Ying wrote:
>> >>>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>> >>>>>
>> >>>>>> On 9/2/22 10:39 AM, Wei Xu wrote:
>> >>>>>>> On Thu, Sep 1, 2022 at 5:33 PM Huang, Ying <ying.huang@intel.com> wrote:
>> >>>>>>>>
>> >>>>>>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>> >>>>>>>>
>> >>>>>>>>> On 9/1/22 12:31 PM, Huang, Ying wrote:
>> >>>>>>>>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>> >>>>>>>>>>
>> >>>>>>>>>>> This patch adds /sys/devices/virtual/memory_tiering/ where all memory tier
>> >>>>>>>>>>> related details can be found. All allocated memory tiers will be listed
>> >>>>>>>>>>> there as /sys/devices/virtual/memory_tiering/memory_tierN/
>> >>>>>>>>>>>
>> >>>>>>>>>>> The nodes which are part of a specific memory tier can be listed via
>> >>>>>>>>>>> /sys/devices/virtual/memory_tiering/memory_tierN/nodes
>> >>>>>>>>>>
>> >>>>>>>>>> I think "memory_tier" is a better subsystem/bus name than
>> >>>>>>>>>> memory_tiering.  Because we have a set of memory_tierN devices inside.
>> >>>>>>>>>> "memory_tier" sounds more natural.  I know this is subjective, just my
>> >>>>>>>>>> preference.
>> >>>>>>>>>>
>> >>>>>>
>> >>>>>>
>> >>>>>> I missed replying to this earlier. I will keep memory_tiering as subsystem name in v4
>> >>>>>> because we would want it to a susbsystem where all memory tiering related details can be found
>> >>>>>> including memory type in the future. This is as per discussion
>> >>>>>>
>> >>>>>> https://lore.kernel.org/linux-mm/CAAPL-u9TKbHGztAF=r-io3gkX7gorUunS2UfstudCWuihrA=0g@mail.gmail.com
>> >>>>>
>> >>>>> I don't think that it's a good idea to mix 2 types of devices in one
>> >>>>> subsystem (bus).  If my understanding were correct, that breaks the
>> >>>>> driver core convention.
>> >>>>>
>> >>>>
>> >>>> All these are virtual devices .I am not sure i follow what you mean by 2 types of devices.
>> >>>> memory_tiering is a subsystem that represents all the details w.r.t memory tiering. It shows
>> >>>> details of memory tiers and can possibly contain details of different memory types .
>> >>>
>> >>> IMHO, memory_tier and memory_type are 2 kind of devices.  They have
>> >>> almost totally different attributes (sysfs file).  So, we should create
>> >>> 2 buses for them.  Each has its own attribute group.  "virtual" itself
>> >>> isn't a subsystem.
>> >>
>> >> Considering both the details are related to memory tiering, wouldn't it be much simpler we consolidate
>> >> them within the same subdirectory? I am still not clear why you are suggesting they need to be in different
>> >> sysfs hierarchy.  It doesn't break any driver core convention as you mentioned earlier.
>> >>
>> >> /sys/devices/virtual/memory_tiering/memory_tierN
>> >> /sys/devices/virtual/memory_tiering/memory_typeN
>> >
>> > I think we should add
>> >
>> >  /sys/devices/virtual/memory_tier/memory_tierN
>> >  /sys/devices/virtual/memory_type/memory_typeN
>> >
>>
>> I am trying to find if there is a technical reason to do the same?
>>
>> > I don't think this is complex.  Devices of same bus/subsystem should
>> > have mostly same attributes.  This is my understanding of driver core
>> > convention.
>> >
>>
>> I was not looking at this from code complexity point. Instead of having multiple directories
>> with details w.r.t memory tiering, I was looking at consolidating the details
>> within the directory /sys/devices/virtual/memory_tiering. (similar to all virtual devices
>> are consolidated within /sys/devics/virtual/).
>>
>> -aneesh
>
> Here is an example of /sys/bus/nd/devices (I know it is not under
> /sys/devices/virtual, but it can still serve as a reference):
>
> ls -1 /sys/bus/nd/devices
>
> namespace2.0
> namespace3.0
> ndbus0
> nmem0
> nmem1
> region0
> region1
> region2
> region3
>
> So I think it is not unreasonable if we want to group memory tiering
> related interfaces within a single top directory.

Thanks for pointing this out.  My original understanding of driver core
isn't correct.

But I still think it's better to separate instead of mixing memory_tier
and memory_type.  Per my understanding, memory_type shows information
(abstract distance, latency, bandwidth, etc.) of memory types (and
nodes), it can be useful even without memory tiers.  That is, memory
types describes the physical characteristics, while memory tier reflects
the policy.

Just my 2 cents.

Best Regards,
Huang, Ying
