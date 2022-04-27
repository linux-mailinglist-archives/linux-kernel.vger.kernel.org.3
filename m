Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE924510DE9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 03:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356702AbiD0Bcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 21:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356695AbiD0Bc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 21:32:28 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDB48566D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 18:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651022959; x=1682558959;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/GHGU2iD7h5xBEXZ/qNOmaQtzHNcVbqfxoSX5VFlcw8=;
  b=UZuw78nlKzx0ygJX62C7k5BhW+QA/OlOllmaEyfntUIaNMECIzl383KO
   l8GCrTRCR9aji1KSaooFEWUmcR4gQeIEPqGtwjl2ts+To1OC1+V6FAy0a
   ROoO1Q8hS/ooddMf/DNgNEjSY+3TvYGPacor/7LQq4UqQLgA8e2iQNxRv
   /OoKLlZsm3mSv/7ziqOG5RNnFXYB/6Qh7mqnZumR1hXlrJu3yB/z8NOzh
   UzrvMptIa2tTamrAS3+CWBvf1GZ9S2WGXdHuvHrxuRPthgBOvcbWPMdoj
   W/0SHiWxByAieqTxsDVkG9SOwxWHVyQ+hpetce34E7m8jssp2W3zXS4ZP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="290926795"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="290926795"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 18:29:18 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="730541249"
Received: from mhuan11-mobl8.ccr.corp.intel.com ([10.254.213.180])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 18:29:15 -0700
Message-ID: <0b2fd48049e8f59fb132f260df9e2a84b58e4577.camel@intel.com>
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
Date:   Wed, 27 Apr 2022 09:29:12 +0800
In-Reply-To: <8a8d14ca-0976-41cc-02cb-dd1680fa37ef@linux.ibm.com>
References: <20220422195516.10769-1-jvgediya@linux.ibm.com>
         <4b986b46afb2fe888c127d8758221d0f0d3ec55f.camel@intel.com>
         <YmaC2jw6WaQ4X+8W@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
         <20220425145735.000007ca@Huawei.com>
         <8a8d14ca-0976-41cc-02cb-dd1680fa37ef@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-04-25 at 20:14 +0530, Aneesh Kumar K V wrote:
> On 4/25/22 7:27 PM, Jonathan Cameron wrote:
> > On Mon, 25 Apr 2022 16:45:38 +0530
> > Jagdish Gediya <jvgediya@linux.ibm.com> wrote:
> > 
> > > On Sun, Apr 24, 2022 at 11:19:53AM +0800, ying.huang@intel.com wrote:
> > > > On Sat, 2022-04-23 at 01:25 +0530, Jagdish Gediya wrote:
> > > > > Some systems(e.g. PowerVM) can have both DRAM(fast memory) only
> > > > > NUMA node which are N_MEMORY and slow memory(persistent memory)
> > > > > only NUMA node which are also N_MEMORY. As the current demotion
> > > > > target finding algorithm works based on N_MEMORY and best distance,
> > > > > it will choose DRAM only NUMA node as demotion target instead of
> > > > > persistent memory node on such systems. If DRAM only NUMA node is
> > > > > filled with demoted pages then at some point new allocations can
> > > > > start falling to persistent memory, so basically cold pages are in
> > > > > fast memor (due to demotion) and new pages are in slow memory, this
> > > > > is why persistent memory nodes should be utilized for demotion and
> > > > > dram node should be avoided for demotion so that they can be used
> > > > > for new allocations.
> > > > > 
> > > > > Current implementation can work fine on the system where the memory
> > > > > only numa nodes are possible only for persistent/slow memory but it
> > > > > is not suitable for the like of systems mentioned above.
> > > > 
> > > > Can you share the NUMA topology information of your machine?  And the
> > > > demotion order before and after your change?
> > > > 
> > > > Whether it's good to use the PMEM nodes as the demotion targets of the
> > > > DRAM-only node too?
> > > 
> > > $ numactl -H
> > > available: 2 nodes (0-1)
> > > node 0 cpus: 0 1 2 3 4 5 6 7
> > > node 0 size: 14272 MB
> > > node 0 free: 13392 MB
> > > node 1 cpus:
> > > node 1 size: 2028 MB
> > > node 1 free: 1971 MB
> > > node distances:
> > > node   0   1
> > >    0:  10  40
> > >    1:  40  10
> > > 
> > > 1) without N_DEMOTION_TARGETS patch series, 1 is demotion target
> > >     for 0 even when 1 is DRAM node and there is no demotion targets for 1.
> > 
> > I'm not convinced the distinction between DRAM and persistent memory is
> > valid. There will definitely be systems with a large pool
> > of remote DRAM (and potentially no NV memory) where the right choice
> > is to demote to that DRAM pool.
> > 
> > Basing the decision on whether the memory is from kmem or
> > normal DRAM doesn't provide sufficient information to make the decision.
> > 
> 
> Hence the suggestion for the ability to override this from userspace. 
> Now, for example, we could build a system with memory from the remote 
> machine (memory inception in case of power which will mostly be plugged 
> in as regular hotpluggable memory ) and a slow CXL memory or OpenCAPI 
> memory.
> 
> In the former case, we won't consider that for demotion with this series 
> because that is not instantiated via dax kmem. So yes definitely we 
> would need the ability to override this from userspace so that we could 
> put these remote memory NUMA nodes as demotion targets if we want.
> > > 

Is there a driver for the device (memory from the remote machine)?  If
so, we can adjust demotion order for it in the driver.

In general, I think that we can adjust demotion order inside kernel from
various information sources.  In addition to ACPI SLIT, we also have
HMAT, kmem driver, other drivers, etc.

> > 
Best Regards,
Huang, Ying

