Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F44510F94
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 05:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357507AbiD0DiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 23:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241363AbiD0DiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 23:38:07 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D73F5B3D8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 20:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651030497; x=1682566497;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4kziqPK6l4x/fvzzWWLFecRORja1cSYYYy4cJwdbDVg=;
  b=FolAZUXc47cw6IiTU/w8kF8uaCDsZUG/exHFENdc5uxL7Y6WO/saGvqs
   Ehkx1CfcKblLyh3ekgUm0SABPJDmCC//iQh9kGSbiFLQPQIzPj2YbomSz
   Ep+c0HGDZrx/6AgzhE4b7DkQrn3Rt5plBQ9atuNHoflBDjg/n2PnSIqfI
   NCpMx6/xcPsO0D475+tSgDvDMBqd2MgZq8D1v+Py6/AH/A6PAdEI5vUta
   uPlf22xazk5IsKgoQjRYNSNGvrf+rxF/94wBg6tfHWE12GDNlsIzHeBsa
   0Ezk6chN312iNPQYpJhgS7JOx5b9VDeYi7FbuPdpOTRxfP23tflhXIG7F
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="247729926"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="247729926"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 20:34:56 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="580336047"
Received: from mhuan11-mobl8.ccr.corp.intel.com ([10.254.213.180])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 20:34:53 -0700
Message-ID: <76be9f84bac12e2283a1414da11ca1d470924ee4.camel@intel.com>
Subject: Re: [PATCH v3 0/7] mm: demotion: Introduce new node state
 N_DEMOTION_TARGETS
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        dave.hansen@linux.intel.com, shy828301@gmail.com,
        weixugc@google.com, gthelen@google.com, dan.j.williams@intel.com
Date:   Wed, 27 Apr 2022 11:34:51 +0800
In-Reply-To: <4a9eaf06-294c-032d-9b85-14c1d91fb732@linux.ibm.com>
References: <20220422195516.10769-1-jvgediya@linux.ibm.com>
         <4b986b46afb2fe888c127d8758221d0f0d3ec55f.camel@intel.com>
         <YmaC2jw6WaQ4X+8W@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
         <20220425145735.000007ca@Huawei.com>
         <8a8d14ca-0976-41cc-02cb-dd1680fa37ef@linux.ibm.com>
         <0b2fd48049e8f59fb132f260df9e2a84b58e4577.camel@intel.com>
         <4a9eaf06-294c-032d-9b85-14c1d91fb732@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-04-27 at 08:27 +0530, Aneesh Kumar K V wrote:
> On 4/27/22 6:59 AM, ying.huang@intel.com wrote:
> > On Mon, 2022-04-25 at 20:14 +0530, Aneesh Kumar K V wrote:
> > > On 4/25/22 7:27 PM, Jonathan Cameron wrote:
> > > > On Mon, 25 Apr 2022 16:45:38 +0530
> > > > Jagdish Gediya <jvgediya@linux.ibm.com> wrote:
> > > > 
> > > > > On Sun, Apr 24, 2022 at 11:19:53AM +0800, ying.huang@intel.com wrote:
> > > > > > On Sat, 2022-04-23 at 01:25 +0530, Jagdish Gediya wrote:
> > > > > > > Some systems(e.g. PowerVM) can have both DRAM(fast memory) only
> > > > > > > NUMA node which are N_MEMORY and slow memory(persistent memory)
> > > > > > > only NUMA node which are also N_MEMORY. As the current demotion
> > > > > > > target finding algorithm works based on N_MEMORY and best distance,
> > > > > > > it will choose DRAM only NUMA node as demotion target instead of
> > > > > > > persistent memory node on such systems. If DRAM only NUMA node is
> > > > > > > filled with demoted pages then at some point new allocations can
> > > > > > > start falling to persistent memory, so basically cold pages are in
> > > > > > > fast memor (due to demotion) and new pages are in slow memory, this
> > > > > > > is why persistent memory nodes should be utilized for demotion and
> > > > > > > dram node should be avoided for demotion so that they can be used
> > > > > > > for new allocations.
> > > > > > > 
> > > > > > > Current implementation can work fine on the system where the memory
> > > > > > > only numa nodes are possible only for persistent/slow memory but it
> > > > > > > is not suitable for the like of systems mentioned above.
> > > > > > 
> > > > > > Can you share the NUMA topology information of your machine?  And the
> > > > > > demotion order before and after your change?
> > > > > > 
> > > > > > Whether it's good to use the PMEM nodes as the demotion targets of the
> > > > > > DRAM-only node too?
> > > > > 
> > > > > $ numactl -H
> > > > > available: 2 nodes (0-1)
> > > > > node 0 cpus: 0 1 2 3 4 5 6 7
> > > > > node 0 size: 14272 MB
> > > > > node 0 free: 13392 MB
> > > > > node 1 cpus:
> > > > > node 1 size: 2028 MB
> > > > > node 1 free: 1971 MB
> > > > > node distances:
> > > > > node   0   1
> > > > >     0:  10  40
> > > > >     1:  40  10
> > > > > 
> > > > > 1) without N_DEMOTION_TARGETS patch series, 1 is demotion target
> > > > >      for 0 even when 1 is DRAM node and there is no demotion targets for 1.
> > > > 
> > > > I'm not convinced the distinction between DRAM and persistent memory is
> > > > valid. There will definitely be systems with a large pool
> > > > of remote DRAM (and potentially no NV memory) where the right choice
> > > > is to demote to that DRAM pool.
> > > > 
> > > > Basing the decision on whether the memory is from kmem or
> > > > normal DRAM doesn't provide sufficient information to make the decision.
> > > > 
> > > 
> > > Hence the suggestion for the ability to override this from userspace.
> > > Now, for example, we could build a system with memory from the remote
> > > machine (memory inception in case of power which will mostly be plugged
> > > in as regular hotpluggable memory ) and a slow CXL memory or OpenCAPI
> > > memory.
> > > 
> > > In the former case, we won't consider that for demotion with this series
> > > because that is not instantiated via dax kmem. So yes definitely we
> > > would need the ability to override this from userspace so that we could
> > > put these remote memory NUMA nodes as demotion targets if we want.
> > > > > 
> > 
> > Is there a driver for the device (memory from the remote machine)?  If
> > so, we can adjust demotion order for it in the driver.
> > 
> 
> At this point, it is managed by hypervisor, is hotplugged into the the 
> LPAR with more additional properties specified via device tree. So there 
> is no inception specific device driver.

Because there's information in device tree, I still think it's doable in
the kernel.  But it's up to you to choose the appropriate way.

Best Regards,
Huang, Ying

> > In general, I think that we can adjust demotion order inside kernel from
> > various information sources.  In addition to ACPI SLIT, we also have
> > HMAT, kmem driver, other drivers, etc.
> > 
> 
> Managing inception memory will any way requires a userspace component to 
> track the owner machine for the remote memory. So we should be ok to 
> have userspace manage demotion order.
> 
> -aneesh
> 


