Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDEE5A8E5B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 08:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbiIAGhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 02:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiIAGh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 02:37:28 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551C7B276A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 23:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662014247; x=1693550247;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=A2XTYHLdK54zP0UzYmCclABXXG/4WGRskOSTW8QpayU=;
  b=EXLLmujRIFfUJfM/R7PbUsQOuPar1M4I42lZY6sup86tFfB9earcQ6ra
   N19LfMMjCyNiYbsUqyQnz7rCgy5mGr+sJoVo/s6Tv3KKRcfeom9M04G6y
   z1Mqh4W5xzJrWfIBY5D4hVfSD/h6TOz0aFLxeAolcSWmgm8MDy5xA6BYp
   HdjZlP66T4JleWGo9jryERjqzaAQlcwNBFLvASiY+v6eq5cu69ABmKr4a
   +0bJOvvMxQ0snjXAsXWWJ+HUXZSWj4Ua0+ByVb3frajgu2tQ44pGLeGZr
   WuBpv2Uh3uSz7IkWS2dyZGt0U5BR5ZW6WSCOqO1sxTl08Lqepr9JqH+hz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="357347881"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="357347881"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 23:37:26 -0700
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="589357218"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 23:37:23 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Wei Xu <weixugc@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Tim C Chen <tim.c.chen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Alistair Popple <apopple@nvidia.com>, jvgediya.oss@gmail.com,
        Bharata B Rao <bharata@amd.com>
Subject: Re: [PATCH v2] mm/demotion: Expose memory tier details via sysfs
References: <20220829060745.287468-1-aneesh.kumar@linux.ibm.com>
        <CAAPL-u9HRHyQEw7q+bTUvYRQWwii7DWYyx3DCgmxJu+u3panbQ@mail.gmail.com>
        <22cb7a8a-84fe-04c7-41ea-50eff8184dc1@linux.ibm.com>
        <CAAPL-u-YuecdVsyr_Tdery8qqPDnzHxGaQL+CSO8x5xv8QH7kg@mail.gmail.com>
Date:   Thu, 01 Sep 2022 14:37:20 +0800
In-Reply-To: <CAAPL-u-YuecdVsyr_Tdery8qqPDnzHxGaQL+CSO8x5xv8QH7kg@mail.gmail.com>
        (Wei Xu's message of "Tue, 30 Aug 2022 00:17:18 -0700")
Message-ID: <8735db1ty7.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
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

> On Mon, Aug 29, 2022 at 11:46 PM Aneesh Kumar K V
> <aneesh.kumar@linux.ibm.com> wrote:
>>
>> On 8/30/22 12:01 PM, Wei Xu wrote:
>> > On Sun, Aug 28, 2022 at 11:08 PM Aneesh Kumar K.V
>> > <aneesh.kumar@linux.ibm.com> wrote:

[snip]

>> >>
>> >> +
>> >> +What:          /sys/devices/virtual/memory_tiering/memory_tierN/
>> >> +               /sys/devices/virtual/memory_tiering/memory_tierN/abstract_distance
>> >> +               /sys/devices/virtual/memory_tiering/memory_tierN/nodes
>> >> +Date:          August 2022
>> >> +Contact:       Linux memory management mailing list <linux-mm@kvack.org>
>> >> +Description:   Directory with details of a specific memory tier
>> >> +
>> >> +               This is the directory containing information about a particular
>> >> +               memory tier, memtierN, where N is derived based on abstract distance.
>> >> +
>> >> +               A smaller value of N implies a higher (faster) memory tier in the
>> >> +               hierarchy.
>> >
>> > Given that abstract_distance is provided, it would be more flexible if
>> > we don't commit to the interface where N in memtierN also indicates
>> > the memory tier ordering.
>>
>>
>> IIUC this is one of the request that Johannes had ie, to be able to understand the
>> memory tier hierarchy based on memtier name.
>>
>> >> +
>> >> +               abstract_distance: The abstract distance range this specific memory
>> >> +               tier maps to.
>> >
>> > I still think the name of "abstract distance" is kind of confusing
>> > because it is not clear what is the other object that this distance
>> > value is relative to.  Do we have to expose this value at this point
>> > if N in memtierN can already indicate the memory tier ordering?
>> >
>>
>> I do agree that abstract distance is confusing. But IIUC we agreed that it is much better
>> than other names suggested and is closer to already understood "numa distance" term.
>>
>> https://lore.kernel.org/linux-mm/YuLF%2FGG8x5lQvg%2Ff@cmpxchg.org/
>>
>
> "NUMA distance" measures the distance between two NUMA nodes.

Per my understanding, "NUMA distance" measures the distance between the
CPUs of one NUMA node to the memory of another NUMA node.

> I bring it up again because this name will become a user visible
> kernel interface, which we will need to live with for a long time.
> Even if we decide to keep the name, it would be better if we can
> define between which two (abstract) points the abstract distance
> reports.

My opinion is that "abstract distance" reflects the distance
(latency+bandwidth) between the CPUs of one NUMA socket to a type of
memory in the same NUMA socket.

Hi, Johannes,

What do you think about this?  You are the inventor of the "abstract
distance".  Can you elaborate its definition?

Best Regards,
Huang, Ying

> Another option is to remove this interface for now until it becomes
> necessary to report abstract distances to userspace.

[snip]
