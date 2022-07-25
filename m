Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920FE57F94B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 08:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiGYGDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 02:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiGYGC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 02:02:58 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB5B7646
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 23:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658728977; x=1690264977;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=xMvvaH+s6vqY1Iy3PvmDnSThXUYdc1gpUxDXwIleWbw=;
  b=URnaX0QDvIDZm2ua66tZSnxldCO8qIFn9xUq7wwhrtMMn2N8+zkwaG5P
   8q2eB/c5qou6b4W1LgHXHXu1j5Vr9O6QiirsoSmFvsjU3+5YmC9sdDUUy
   6GYuoG7kqD4sAuEikSxhfcVeVCeGTLPcG2/nuJfdMN6nfHoNz1h+X6cWM
   vn+P1/lOA0kWFjQHEmy28aKq8qQ0rxw4OgvUWIP2zP4vpDpk8s5boH0H9
   HQiuaXLEDPUHOCfkbr7VXpL3Utl+rlsTMmW/6syqZuyokiZ9flXNcpHmE
   v8gVa412yIYWChIldSiMXTYUiUFjse3gqpY6TrbyCEphWFeALhfDJaCy5
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="351614349"
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="351614349"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 23:02:57 -0700
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="574913607"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 23:02:53 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Wei Xu <weixugc@google.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Linux MM" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Yang Shi" <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Alistair Popple" <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <jvgediya.oss@gmail.com>
Subject: Re: [PATCH v8 00/12] mm/demotion: Memory tiers and demotion
References: <20220704070612.299585-1-aneesh.kumar@linux.ibm.com>
        <87r130b2rh.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <60e97fa2-0b89-cf42-5307-5a57c956f741@linux.ibm.com>
        <87r12r5dwu.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <0a55e48a-b4b7-4477-a72f-73644b5fc4cb@linux.ibm.com>
        <87mtde6cla.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <fef35622-0bd4-f220-26bd-37d8e0112c4d@linux.ibm.com>
        <87ilo267jl.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ad4b095b-bb85-b01f-5d69-383219384c29@linux.ibm.com>
        <87edyp67m1.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAAPL-u8pH1f+x+e5vSqq_m1zb+rPe0F-FH4GeJPu8-MrRS4mjQ@mail.gmail.com>
        <875yk15svi.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <20220719150032.000066a6@Huawei.com>
Date:   Mon, 25 Jul 2022 14:02:49 +0800
In-Reply-To: <20220719150032.000066a6@Huawei.com> (Jonathan Cameron's message
        of "Tue, 19 Jul 2022 15:00:32 +0100")
Message-ID: <878rohzq46.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jonathan,

Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:

> On Wed, 13 Jul 2022 16:17:21 +0800
> "Huang, Ying" <ying.huang@intel.com> wrote:
>
>> Wei Xu <weixugc@google.com> writes:

[snip]
>> >
>> > Th "memory type" and "abstract distance" concepts sound to me similar
>> > to the memory tier "rank" idea.  
>> 
>> Yes.  "abstract distance" is similar as "rank".
>> 
>> > We can have some well-defined type/distance/rank values, e.g. HBM,
>> > DRAM, CXL_DRAM, PMEM, CXL_PMEM, which a device can register with.  The
>> > memory tiers will build from these values.  It can be configurable to
>> > whether/how to collapse several values into a single tier.  
>> 
>> The memory types are registered by drivers (such as kmem_dax).  And the
>> distances can come from SLIT, HMAT, and other firmware or driver
>> specific information sources.
>> 
>> Per my understanding, this solution may make memory tier IDs more
>> unstable.  For example, the memory ID of a node may be changed after the
>> user override the distance of a memory type.  Although I think the
>> overriding should be a rare operations, will it be a real issue for your
>> use cases?
>
> Not sure how common it is, but I'm aware of systems that have dynamic
> access characteristics.  i.e. the bandwidth and latency of a access
> to a given memory device will change dynamically at runtime (typically
> due to something like hardware degradation / power saving etc).  Potentially
> leading to memory in use needing to move in 'demotion order'.  We could
> handle that with a per device tier and rank that changes...
>
> Just thought I'd throw that out there to add to the complexity ;)
> I don't consider it important to support initially but just wanted to
> point out this will only get more complex over time.
>

Thanks for your information!

If we make the mapping from the abstract distance range to the memory
tier ID stable at some degree, the memory tier ID can be stable at some
degree, e.g.,

abstract distance range         memory tier ID
1  -100                         0
101-200                         1
201-300                         2
301-400                         3
401-500                         4
500-                            5

Then if the abstract distance of a memory device changes at run time,
its memory tier ID will change.  But the memory tier ID of other memory
devices can be unchanged.

If so, the memory tier IDs are unstable mainly when we change the
mapping from the abstract distance range to memory tier ID.

Best Regards,
Huang, Ying
