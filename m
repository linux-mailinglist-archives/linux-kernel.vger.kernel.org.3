Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A52058974D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 07:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237555AbiHDFT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 01:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiHDFTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 01:19:24 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481603ED58
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 22:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659590360; x=1691126360;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=qTXg76Xk7C7UMD2yV3rIhJoi0cq734Wu0jvaFWh/TwY=;
  b=bXaKiZxXEKP1shhHu/J6WKi5YtHPsRnXnkzRCXQOiwXFQLVmF2GpgL+2
   /7QtqJb0sqvUZMrYoyHyMBW1czKrtPura0/vTfzpMlgCIuN1ZOOQK8a7g
   eynS/bqcLFXKty/ZbxpncRvkFQmAqhWhlKBMvQLV1wQTZAS1Pwxe1DdkS
   86v6sXIPJa8vFgso3LzbOwEXGmbuZWP3pOmJSRh1vHy8JtAC5KMD1C9qT
   7oeAbFGiwYpuRs0TolIP64s5uq4pVkE/w+udUhavvF14L1m+LlQVtoyCF
   UTYGT3X3JG0ACPUSU36+IgYudE9lTCI2YXEzIbCoQR9AB99XmGXMGnYqz
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="315714065"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="315714065"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 22:19:19 -0700
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="553584426"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 22:19:15 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, Wei Xu <weixugc@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com,
        Jagdish Gediya <jvgediya@linux.ibm.com>
Subject: Re: [PATCH v11 1/8] mm/demotion: Add support for explicit memory tiers
References: <20220728190436.858458-1-aneesh.kumar@linux.ibm.com>
        <20220728190436.858458-2-aneesh.kumar@linux.ibm.com>
        <62e890da7f784_577a029473@dwillia2-xfh.jf.intel.com.notmuch>
        <874jyvjpw9.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <62e89c9addcc_62c2a29443@dwillia2-xfh.jf.intel.com.notmuch>
        <87zggni13h.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <4a96a3ff-9cb7-4e71-3e9f-95fbd99f5201@linux.ibm.com>
        <87r11wj07a.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <30212141-9f72-6727-ce7b-74623c25552c@linux.ibm.com>
Date:   Thu, 04 Aug 2022 13:19:11 +0800
In-Reply-To: <30212141-9f72-6727-ce7b-74623c25552c@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Thu, 4 Aug 2022 10:19:42 +0530")
Message-ID: <87iln8io1c.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:

> On 8/4/22 6:26 AM, Huang, Ying wrote:
>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>> 
>>> On 8/2/22 12:27 PM, Huang, Ying wrote:
>>>> Dan Williams <dan.j.williams@intel.com> writes:
>>>>
>>>>> Huang, Ying wrote:
>>>>>> Dan Williams <dan.j.williams@intel.com> writes:
>>>>>>
>>>>>>> Aneesh Kumar K.V wrote:
>>>>>>>> In the current kernel, memory tiers are defined implicitly via a demotion path
>>>>>>>> relationship between NUMA nodes, which is created during the kernel
>>>>>>>> initialization and updated when a NUMA node is hot-added or hot-removed. The
>>>>>>>> current implementation puts all nodes with CPU into the highest tier, and builds
>>>>>>>> the tier hierarchy tier-by-tier by establishing the per-node demotion targets
>>>>>>>> based on the distances between nodes.
>>>>>>>>
>>>>>>>> This current memory tier kernel implementation needs to be improved for several
>>>>>>>> important use cases,
>>>>>>>>
>>>>>>>> The current tier initialization code always initializes each memory-only NUMA
>>>>>>>> node into a lower tier. But a memory-only NUMA node may have a high performance
>>>>>>>> memory device (e.g. a DRAM-backed memory-only node on a virtual machine) that
>>>>>>>> should be put into a higher tier.
>>>>>>>>
>>>>>>>> The current tier hierarchy always puts CPU nodes into the top tier. But on a
>>>>>>>> system with HBM or GPU devices, the memory-only NUMA nodes mapping these devices
>>>>>>>> should be in the top tier, and DRAM nodes with CPUs are better to be placed into
>>>>>>>> the next lower tier.
>>>>>>>>
>>>>>>>> With current kernel higher tier node can only be demoted to nodes with shortest
>>>>>>>> distance on the next lower tier as defined by the demotion path, not any other
>>>>>>>> node from any lower tier. This strict, demotion order does not work in all use
>>>>>>>> cases (e.g. some use cases may want to allow cross-socket demotion to another
>>>>>>>> node in the same demotion tier as a fallback when the preferred demotion node is
>>>>>>>> out of space), This demotion order is also inconsistent with the page allocation
>>>>>>>> fallback order when all the nodes in a higher tier are out of space: The page
>>>>>>>> allocation can fall back to any node from any lower tier, whereas the demotion
>>>>>>>> order doesn't allow that.
>>>>>>>>
>>>>>>>> This patch series address the above by defining memory tiers explicitly.
>>>>>>>>
>>>>>>>> Linux kernel presents memory devices as NUMA nodes and each memory device is of
>>>>>>>> a specific type. The memory type of a device is represented by its abstract
>>>>>>>> distance. A memory tier corresponds to a range of abstract distance. This allows
>>>>>>>> for classifying memory devices with a specific performance range into a memory
>>>>>>>> tier.
>>>>>>>>
>>>>>>>> This patch configures the range/chunk size to be 128. The default DRAM
>>>>>>>> abstract distance is 512. We can have 4 memory tiers below the default DRAM
>>>>>>>> abstract distance which cover the range 0 - 127, 127 - 255, 256- 383, 384 - 511.
>>>>>>>> Slower memory devices like persistent memory will have abstract distance below
>>>>>>>> the default DRAM level and hence will be placed in these 4 lower tiers.
>>>>>>>>
>>>>>>>> A kernel parameter is provided to override the default memory tier.
>>>>>>>>
>>>>>>>> Link: https://lore.kernel.org/linux-mm/CAAPL-u9Wv+nH1VOZTj=9p9S70Y3Qz3+63EkqncRDdHfubsrjfw@mail.gmail.com
>>>>>>>> Link: https://lore.kernel.org/linux-mm/7b72ccf4-f4ae-cb4e-f411-74d055482026@linux.ibm.com
>>>>>>>>
>>>>>>>> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
>>>>>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>>>>>> ---
>>>>>>>>  include/linux/memory-tiers.h |  17 ++++++
>>>>>>>>  mm/Makefile                  |   1 +
>>>>>>>>  mm/memory-tiers.c            | 102 +++++++++++++++++++++++++++++++++++
>>>>>>>>  3 files changed, 120 insertions(+)
>>>>>>>>  create mode 100644 include/linux/memory-tiers.h
>>>>>>>>  create mode 100644 mm/memory-tiers.c
>>>>>>>>
>>>>>>>> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
>>>>>>>> new file mode 100644
>>>>>>>> index 000000000000..8d7884b7a3f0
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/include/linux/memory-tiers.h
>>>>>>>> @@ -0,0 +1,17 @@
>>>>>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>>>>>> +#ifndef _LINUX_MEMORY_TIERS_H
>>>>>>>> +#define _LINUX_MEMORY_TIERS_H
>>>>>>>> +
>>>>>>>> +/*
>>>>>>>> + * Each tier cover a abstrace distance chunk size of 128
>>>>>>>> + */
>>>>>>>> +#define MEMTIER_CHUNK_BITS	7
>>>>>>>> +#define MEMTIER_CHUNK_SIZE	(1 << MEMTIER_CHUNK_BITS)
>>>>>>>> +/*
>>>>>>>> + * For now let's have 4 memory tier below default DRAM tier.
>>>>>>>> + */
>>>>>>>> +#define MEMTIER_ADISTANCE_DRAM	(1 << (MEMTIER_CHUNK_BITS + 2))
>>>>>>>> +/* leave one tier below this slow pmem */
>>>>>>>> +#define MEMTIER_ADISTANCE_PMEM	(1 << MEMTIER_CHUNK_BITS)
>>>>>>>
>>>>>>> Why is memory type encoded in these values? There is no reason to
>>>>>>> believe that PMEM is of a lower performance tier than DRAM. Consider
>>>>>>> high performance energy backed DRAM that makes it "PMEM", consider CXL
>>>>>>> attached DRAM over a switch topology and constrained links that makes it
>>>>>>> a lower performance tier than locally attached DRAM. The names should be
>>>>>>> associated with tiers that indicate their usage. Something like HOT,
>>>>>>> GENERAL, and COLD. Where, for example, HOT is low capacity high
>>>>>>> performance compared to the general purpose pool, and COLD is high
>>>>>>> capacity low performance intended to offload the general purpose tier.
>>>>>>>
>>>>>>> It does not need to be exactly that ontology, but please try to not
>>>>>>> encode policy meaning behind memory types. There has been explicit
>>>>>>> effort to avoid that to date because types are fraught for declaring
>>>>>>> relative performance characteristics, and the relative performance
>>>>>>> changes based on what memory types are assembled in a given system.
>>>>>>
>>>>>> Yes.  MEMTIER_ADISTANCE_PMEM is something over simplified.  That is only
>>>>>> used in this very first version to make it as simple as possible.  
>>>>>
>>>>> I am failing to see the simplicity of using names that convey a
>>>>> performance contract that are invalid depending on the system.
>>>>>
>>>>>> I think we can come up with something better in the later version.
>>>>>> For example, identify the abstract distance of a PMEM device based on
>>>>>> HMAT, etc. 
>>>>>
>>>>> Memory tiering has nothing to do with persistence why is PMEM in the
>>>>> name at all?
>>>>>
>>>>>>  And even in this first version, we should put MEMTIER_ADISTANCE_PMEM
>>>>>>  in dax/kmem.c.  Because it's just for that specific type of memory
>>>>>>  used now, not for all PMEM.
>>>>>
>>>>> dax/kmem.c also handles HBM and "soft reserved" memory in general. There
>>>>> is also nothing PMEM specific about the device-dax subsystem.
>>>>
>>>> Ah... I see the issue here.  For the systems in our hand, dax/kmem.c is
>>>> used to online PMEM only.  Even the "soft reserved" memory is used for
>>>> PMEM or simulating PMEM too.  So to make the code as simple as possible,
>>>> we treat all memory devices onlined by dax/kmem as PMEM in the first
>>>> version.  And plan to support more memory types in the future versions.
>>>>
>>>> But from your above words, our assumption are wrong here.  dax/kmem.c
>>>> can online HBM and other memory devices already.  If so, how do we
>>>> distinguish between them and how to get the performance character of
>>>> these devices?  We can start with SLIT?
>>>>
>>>
>>> We would let low level driver register memory_dev_types for the NUMA nodes
>>> that will be mapped to these devices. ie, a papr_scm, ACPI NFIT or CXL
>>> can register different memory_dev_type based on device tree, HMAT or CDAT. 
>> 
>> I didn't find ACPI NFIT can provide any performance information, just
>> whether it's non-volatile.  HMAT or CDAT should help here, but it's not
>> available always.  For now, what we have is just SLIT at least for quite
>> some machines.
>> 
>
>
> The lower level driver that is creating the nvdimm regions can assign a
> memory type to the numa node which it associates with the region. For now,
> drivers like papr_scm do that on ppc64. When it associates a numa node to
> nvdimm regions, it can query every detail available (device tree
> in case of papr_scm, can be HMAT/SLIT or CDAT) to associate the NUMA node
> to a memory type. 

If we have only one information source, it's OK to create all memory
type with this source.  But if we have multiple sources, we need a
mechanism to coordinate among these sources.  It gives us good
flexibility to create memory types in driver.  Because drivers can
use any information sources.

Best Regards,
Huang, Ying

>> I prefer to create memory_dev_type in high level driver like dax/kmem.
>> And it may query low level driver like SLIT, HMAT, CDAT, etc for more
>> information based on availability etc.
>> 
>> Best Regards,
>> Huang, Ying
