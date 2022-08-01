Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1656258658A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 09:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiHAHNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 03:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiHAHNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 03:13:12 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E9F32478
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 00:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659337991; x=1690873991;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=V0G6j28IaHxr9oC8YL9qnfip8DUfa6h6YBjToRwmjiE=;
  b=Iq2WpJ4EOOYbR1YyFm9DyViQiiFCtjysmJluh/Zk8iKY87NJ6rGJU/M1
   TRXFScxbBBB33OMxQ0NRDygK4Gk78N2F/Ip49PNPdlbyV3AXIRtQo6s2r
   SQfLnYjrly9tfVyyVhP9r4YfLafrzg4TxkLnheVSbns8q6jdummtAtDTL
   R2XZMYXpaTXTiKCMbAv1tQ5NcQDi1UXkMK2yMxZF/BfnYMMJhwn5uzqC3
   tOp18s9FP2E93rerqLIGS3/bdT3lGjTzUh83jrkXjbuXQo8kcbCW35g72
   ITZvD/JdexnvKwxuFadm+K/A0ufvSGvZBknBKWLfuCHNOtwIuJFws4tMx
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="314902910"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="314902910"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 00:13:11 -0700
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="929447841"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 00:13:08 -0700
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
Subject: Re: [PATCH v11 4/8] mm/demotion/dax/kmem: Set node's abstract
 distance to MEMTIER_ADISTANCE_PMEM
References: <20220728190436.858458-1-aneesh.kumar@linux.ibm.com>
        <20220728190436.858458-5-aneesh.kumar@linux.ibm.com>
        <875yjgmocg.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <87bkt8s7w9.fsf@linux.ibm.com>
        <87k07slnt7.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <e5545c90-9595-d08c-8a1c-1c15e3b94999@linux.ibm.com>
        <87tu6wk0q5.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <826fbdbc-219f-8f4a-7373-41c718287533@linux.ibm.com>
        <87les8jwpu.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <1aba0c44-b096-8c75-8086-62d3cffc08b3@linux.ibm.com>
Date:   Mon, 01 Aug 2022 15:13:04 +0800
In-Reply-To: <1aba0c44-b096-8c75-8086-62d3cffc08b3@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Mon, 1 Aug 2022 12:25:04 +0530")
Message-ID: <87h72wjv27.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On 8/1/22 12:07 PM, Huang, Ying wrote:
>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>> 
>>> On 8/1/22 10:40 AM, Huang, Ying wrote:
>>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>>>
>>>>> On 8/1/22 7:36 AM, Huang, Ying wrote:
>>>>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>>>>>
>>>>>>> "Huang, Ying" <ying.huang@intel.com> writes:
>>>>>>>
>>>>>>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>
> ....
>
>>>>>
>>>>> With the module unload, it is kind of force removing the usage of the specific memtype.
>>>>> Considering module unload will remove the usage of specific memtype from other parts
>>>>> of the kernel and we already do all the required reset in memory hot unplug, do we
>>>>> need to do the clear_node_memory_type above? 
>>>>
>>>> Per my understanding, we need to call clear_node_memory_type() in
>>>> dev_dax_kmem_remove().  After that, we have nothing to do in
>>>> dax_kmem_exit().
>>>>
>>>
>>> Ok, I guess you are suggesting to do the clear_node_memory_type even if we fail the memory remove. 
>> 
>> Can we use node_memory_types[] to indicate whether a node is managed by
>> a driver?
>> 
>> Regardless being succeeded or failed, dev_dax_kmem_remove() will set
>> node_memory_types[] = NULL.  But until node is offlined, we will still
>> keep the node in the memory_dev_type (dax_pmem_type).
>> 
>> And we will prevent dax/kmem from unloading via try_module_get() and add
>> "struct module *" to struct memory_dev_type.
>> 
>
> Current dax/kmem driver is not holding any module reference and allows the module to be unloaded
> anytime. Even if the memory onlined by the driver fails to be unplugged. Addition of memory_dev_type
> as suggested by you will be different than that. Page demotion can continue to work without the
> support of dax_pmem_type as long as we keep the older demotion order. Any new demotion order
> rebuild will remove the the memory node which was not hotunplugged  from the demotion order. Isn't that
> a much simpler implementation? 

Per my understanding, unbinding/binding the dax/kmem driver means
changing the memory type of a memory device.  For example, unbinding
dax/kmem driver may mean changing the memory type from dax_pmem_type to
default_memory_type (or default_dram_type).  That appears strange.  But
if we force the NUMA node to be offlined for unbinding, we can avoid to
change the memory type to default_memory_type.

Best Regards,
Huang, Ying
