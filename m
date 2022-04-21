Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E185099F9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386225AbiDUHwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386207AbiDUHwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:52:20 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049C01CFCE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650527366; x=1682063366;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ETP06IA+RyjcwFgY+scj0+OYU3vSsMZK3PEoX7of2Qw=;
  b=NuB2+U7VQKY30WO146d64UKMBaq2FmQIGR+jWAwSXif0xTk6DvmPidfu
   HJe8psXxGtspCXOQeVSQowuWrLuipFk9zguAQqZ9fhVmCg+Ll6KTN7pr3
   /kc9DcaW6QevOEYO2S51sug1fYYVZ/ksNrfZ+CwoeU1WT03R3yYUt0Us3
   MrMhLznwE3rDoG9obQzNeQLO56wRNpNvLN8S0PVHHWXnDXZA8DhZV68kL
   WV0RGbsbxSRfRE2q7sbJgwJZyCAUC1tNnUejGpQty/phi5JnrbXJY1UoD
   NWejp7Kxbmte4pVbD++skAEGUOU+tRPPcchC3p8QOfuIFU5B3FTa8YfJe
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="289383368"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="289383368"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 00:49:25 -0700
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="577079489"
Received: from hanyulon-mobl1.ccr.corp.intel.com ([10.254.214.143])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 00:49:23 -0700
Message-ID: <f27ec36beb3cf1dbbfc3b8835e586d5d6fe7f561.camel@intel.com>
Subject: Re: [PATCH] mm: swap: determine swap device by using page nid
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Aaron Lu <aaron.lu@intel.com>, Yang Shi <shy828301@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 21 Apr 2022 15:49:21 +0800
In-Reply-To: <Yl/FS9enAD4V8jG3@ziqianlu-nuc9qn>
References: <20220407020953.475626-1-shy828301@gmail.com>
         <Yk6cutNf5sOuYbDl@ziqianlu-nuc9qn>
         <CAHbLzkq+eKcKCsxXDTiOcBxk8FjMdWBqOxwi4N_NG7PZWbAAkA@mail.gmail.com>
         <Yl/FS9enAD4V8jG3@ziqianlu-nuc9qn>
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

On Wed, 2022-04-20 at 16:33 +0800, Aaron Lu wrote:
> On Thu, Apr 07, 2022 at 10:36:54AM -0700, Yang Shi wrote:
> > On Thu, Apr 7, 2022 at 1:12 AM Aaron Lu <aaron.lu@intel.com> wrote:
> > > 
> > > On Wed, Apr 06, 2022 at 07:09:53PM -0700, Yang Shi wrote:
> > > > The swap devices are linked to per node priority lists, the swap device
> > > > closer to the node has higher priority on that node's priority list.
> > > > This is supposed to improve I/O latency, particularly for some fast
> > > > devices.  But the current code gets nid by calling numa_node_id() which
> > > > actually returns the nid that the reclaimer is running on instead of the
> > > > nid that the page belongs to.
> > > > 
> > > 
> > > Right.
> > > 
> > > > Pass the page's nid dow to get_swap_pages() in order to pick up the
> > > > right swap device.  But it doesn't work for the swap slots cache which
> > > > is per cpu.  We could skip swap slots cache if the current node is not
> > > > the page's node, but it may be overkilling. So keep using the current
> > > > node's swap slots cache.  The issue was found by visual code inspection
> > > > so it is not sure how much improvement could be achieved due to lack of
> > > > suitable testing device.  But anyway the current code does violate the
> > > > design.
> > > > 
> > > 
> > > I intentionally used the reclaimer's nid because I think when swapping
> > > out to a device, it is faster when the device is on the same node as
> > > the cpu.
> > 
> > OK, the offline discussion with Huang Ying showed the design was to
> > have page's nid in order to achieve better I/O performance (more
> > noticeable on faster devices) since the reclaimer may be running on a
> > different node from the reclaimed page.
> > 
> > > 
> > > Anyway, I think I can make a test case where the workload allocates all
> > > its memory on the remote node and its workingset memory is larger then
> > > the available memory so swap is triggered, then we can see which way
> > > achieves better performance. Sounds reasonable to you?
> > 
> > Yeah, definitely, thank you so much. I don't have a fast enough device
> > by hand to show the difference right now. If you could get some data
> > it would be perfect.
> > 
> 
> Failed to find a test box that has two NVMe disks attached to different
> nodes and since Shanghai is locked down right now, we couldn't install
> another NVMe on the box so I figured it might be OK to test on a box that
> has a single NVMe attached to node 0 like this:
> 
> 1) restrict the test processes to run on node 0 and allocate on node 1;
> 2) restrict the test processes to run on node 1 and allocate on node 0.
> 
> In case 1), the reclaimer's node id is the same as the swap device's so
> it's the same as current behaviour and in case 2), the page's node id is
> the same as the swap device's so it's what your patch proposed.
> 
> The test I used is vm-scalability/case-swap-w-rand:
> https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-swap-w-seq
> which spawns $nr_task processes and each will mmap $size and then
> randomly write to that area. I set nr_task=32 and $size=4G, so a total
> of 128G memory will be needed and I used memory.limit_in_bytes to
> restrict the available memory to 64G, to make sure swap is triggered.
> 
> The reason why cgroup is used is to avoid waking up the per-node kswapd
> which can trigger swapping with reclaimer/page/swap device all having the
> same node id.
> 
> And I don't see a measuable difference from the result:
> case1(using reclaimer's node id) vm-scalability.throughput: 10574 KB/s
> case2(using page's node id)      vm-scalability.throughput: 10567 KB/s
> 
> My interpretation of the result is, when reclaiming a remote page, it
> doesn't matter much which swap device to use if the swap device is a IO
> device.
> 
> Later Ying reminded me we have test box that has optane installed on
> different nodes so I also tested there: Icelake 2 sockets server with 2
> optane installed on each node. I did the test there like this:
> 1) restrict the test processes to run on node 0 and allocate on node 1
>    and only swapon pmem0, which is the optane backed swap device on node 0;
> 2) restrict the test processes to run on node 0 and allocate on node 1
>    and only swapon pmem1, which is the optane backed swap device on node 1.
> 
> So case 1) is current behaviour and case 2) is what your patch proposed.
> 
> With the same test and the same nr_task/size, the result is:
> case1(using reclaimer's node id) vm-scalability.throughput: 71033 KB/s
> case2(using page's node id)      vm-scalability.throughput: 58753 KB/s
> 

The per-node swap device support is more about swap-in latency than
swap-out throughput.  I suspect the test case is more about swap-out
throughput.  perf profiling can show this.

For swap-in latency, we can use pmbench, which can output latency
information.

Best Regards,
Huang, Ying


[snip]

