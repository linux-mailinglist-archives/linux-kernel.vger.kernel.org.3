Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8241509ACC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386727AbiDUIhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386760AbiDUIhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:37:04 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BB61FA7D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650530054; x=1682066054;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1cXpoS5/u+aVzzPU2HiSj5G2lNI0FBcN6o0Pk+VSTXk=;
  b=KpmsuN5JO4/VTC1TiF+nYFRizuOc8Q1KmTu5i8SDyBw83AJnSujnwfwC
   12DEWehx30xmFRGwdw6Cw2ucjCEsYfT0LZGJQlKhKUZ2WoXzW7w9UlKB6
   qCyrLOA2aJCTRsVhQWu1Dgcg96YeD8KeQBF/QMVQp4m55v0CyyEIdUq72
   wTZ68LHzyquK7xbjrW12TGbKBnUd13AdnvXODMEVYo1wpeNewkicMZX7u
   I1JyVRPqtMqxj0fNPKPfrmS35z1m4xJIsfDjUNDAgFQXxKhcQwralEA4k
   dFPiazytFjejHawQN6/0kaPGocpFvL5CPrnkAt9gaiDMVN+Lj7LJe9YFQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="246176695"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="246176695"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 01:34:13 -0700
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="555655055"
Received: from hanyulon-mobl1.ccr.corp.intel.com ([10.254.214.143])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 01:34:11 -0700
Message-ID: <6f7210be7353d1c01dc9f872b2692b83f87f5452.camel@intel.com>
Subject: Re: [PATCH] mm: swap: determine swap device by using page nid
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 21 Apr 2022 16:34:09 +0800
In-Reply-To: <YmETEHnK/FiNbLO7@ziqianlu-desk1>
References: <20220407020953.475626-1-shy828301@gmail.com>
         <Yk6cutNf5sOuYbDl@ziqianlu-nuc9qn>
         <CAHbLzkq+eKcKCsxXDTiOcBxk8FjMdWBqOxwi4N_NG7PZWbAAkA@mail.gmail.com>
         <Yl/FS9enAD4V8jG3@ziqianlu-nuc9qn>
         <f27ec36beb3cf1dbbfc3b8835e586d5d6fe7f561.camel@intel.com>
         <YmETEHnK/FiNbLO7@ziqianlu-desk1>
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

On Thu, 2022-04-21 at 16:17 +0800, Aaron Lu wrote:
> On Thu, Apr 21, 2022 at 03:49:21PM +0800, ying.huang@intel.com wrote:
> > On Wed, 2022-04-20 at 16:33 +0800, Aaron Lu wrote:
> > > On Thu, Apr 07, 2022 at 10:36:54AM -0700, Yang Shi wrote:
> > > > On Thu, Apr 7, 2022 at 1:12 AM Aaron Lu <aaron.lu@intel.com> wrote:
> > > > > 
> > > > > On Wed, Apr 06, 2022 at 07:09:53PM -0700, Yang Shi wrote:
> > > > > > The swap devices are linked to per node priority lists, the swap device
> > > > > > closer to the node has higher priority on that node's priority list.
> > > > > > This is supposed to improve I/O latency, particularly for some fast
> > > > > > devices.  But the current code gets nid by calling numa_node_id() which
> > > > > > actually returns the nid that the reclaimer is running on instead of the
> > > > > > nid that the page belongs to.
> > > > > > 
> > > > > 
> > > > > Right.
> > > > > 
> > > > > > Pass the page's nid dow to get_swap_pages() in order to pick up the
> > > > > > right swap device.  But it doesn't work for the swap slots cache which
> > > > > > is per cpu.  We could skip swap slots cache if the current node is not
> > > > > > the page's node, but it may be overkilling. So keep using the current
> > > > > > node's swap slots cache.  The issue was found by visual code inspection
> > > > > > so it is not sure how much improvement could be achieved due to lack of
> > > > > > suitable testing device.  But anyway the current code does violate the
> > > > > > design.
> > > > > > 
> > > > > 
> > > > > I intentionally used the reclaimer's nid because I think when swapping
> > > > > out to a device, it is faster when the device is on the same node as
> > > > > the cpu.
> > > > 
> > > > OK, the offline discussion with Huang Ying showed the design was to
> > > > have page's nid in order to achieve better I/O performance (more
> > > > noticeable on faster devices) since the reclaimer may be running on a
> > > > different node from the reclaimed page.
> > > > 
> > > > > 
> > > > > Anyway, I think I can make a test case where the workload allocates all
> > > > > its memory on the remote node and its workingset memory is larger then
> > > > > the available memory so swap is triggered, then we can see which way
> > > > > achieves better performance. Sounds reasonable to you?
> > > > 
> > > > Yeah, definitely, thank you so much. I don't have a fast enough device
> > > > by hand to show the difference right now. If you could get some data
> > > > it would be perfect.
> > > > 
> > > 
> > > Failed to find a test box that has two NVMe disks attached to different
> > > nodes and since Shanghai is locked down right now, we couldn't install
> > > another NVMe on the box so I figured it might be OK to test on a box that
> > > has a single NVMe attached to node 0 like this:
> > > 
> > > 1) restrict the test processes to run on node 0 and allocate on node 1;
> > > 2) restrict the test processes to run on node 1 and allocate on node 0.
> > > 
> > > In case 1), the reclaimer's node id is the same as the swap device's so
> > > it's the same as current behaviour and in case 2), the page's node id is
> > > the same as the swap device's so it's what your patch proposed.
> > > 
> > > The test I used is vm-scalability/case-swap-w-rand:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-swap-w-seq
> > > which spawns $nr_task processes and each will mmap $size and then
> > > randomly write to that area. I set nr_task=32 and $size=4G, so a total
> > > of 128G memory will be needed and I used memory.limit_in_bytes to
> > > restrict the available memory to 64G, to make sure swap is triggered.
> > > 
> > > The reason why cgroup is used is to avoid waking up the per-node kswapd
> > > which can trigger swapping with reclaimer/page/swap device all having the
> > > same node id.
> > > 
> > > And I don't see a measuable difference from the result:
> > > case1(using reclaimer's node id) vm-scalability.throughput: 10574 KB/s
> > > case2(using page's node id)      vm-scalability.throughput: 10567 KB/s
> > > 
> > > My interpretation of the result is, when reclaiming a remote page, it
> > > doesn't matter much which swap device to use if the swap device is a IO
> > > device.
> > > 
> > > Later Ying reminded me we have test box that has optane installed on
> > > different nodes so I also tested there: Icelake 2 sockets server with 2
> > > optane installed on each node. I did the test there like this:
> > > 1) restrict the test processes to run on node 0 and allocate on node 1
> > >    and only swapon pmem0, which is the optane backed swap device on node 0;
> > > 2) restrict the test processes to run on node 0 and allocate on node 1
> > >    and only swapon pmem1, which is the optane backed swap device on node 1.
> > > 
> > > So case 1) is current behaviour and case 2) is what your patch proposed.
> > > 
> > > With the same test and the same nr_task/size, the result is:
> > > case1(using reclaimer's node id) vm-scalability.throughput: 71033 KB/s
> > > case2(using page's node id)      vm-scalability.throughput: 58753 KB/s
> > > 
> > 
> > The per-node swap device support is more about swap-in latency than
> > swap-out throughput.  I suspect the test case is more about swap-out
> > throughput.  perf profiling can show this.
> > 
> 
> Can you elaborate the "perf profiling" part, like which perf metric can
> show this?
> 

Just `perf record`, `perf report` to show where the CPU cycles are spent
with call graph information.

Then you can find most CPU cycles are for swap out or swap in.  Where is
the bottleneck.

> I checked the vmstat output. Initially, it's mostly swap out, then swap
> in starts to be more and more, but swapout is always more than swapin.
> 
> procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu----- -----timestamp-----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st                 UTC
> 20  0      0 259772032      8 2428796    0    0     2     0  365   74  1  1 98  0  0 2022-04-19 11:44:37
>  4  0      0 259149824      8 2439084    0    0     0     0 148536 22298  1  3 96  0  0 2022-04-19 11:44:38
> 35  0      0 236926192   1052 2572000    0    0  2163  2048 392940 3690  1 24 75  0  0 2022-04-19 11:44:39
> 32  0      0 205170832   1052 2572280    0    0     0     0 193095 1280  2 33 65  0  0 2022-04-19 11:44:40
> 40  0 136448 192211008   1052 2439412  268 133760     0     0 532052 3571  0 40 59  0  0 2022-04-19 11:44:43
> 33  0 4224000 192182464   1052 2450936 130636 4211460     0     0 1145644 15600  1 33 65  0  0 2022-04-19 11:44:44
> 32  0 6908708 192179408   1052 2460836 239456 2924392     0     0 863325 10731  1 34 65  0  0 2022-04-19 11:44:45
> 33  0 9005036 192163936   1052 2469112 279200 2371924     0     0 739330 9635  1 34 65  0  0 2022-04-19 11:44:46
> 32  0 10769408 192154864   1052 2476172 305516 2071440     0     0 673619 9044  1 34 65  0  0 2022-04-19 11:44:47
> 32  0 12318720 192149344   1052 2482708 324312 1875224     0     0 627868 9404  1 35 65  0  0 2022-04-19 11:44:48
> 33  0 13735796 192146752   1052 2488520 340684 1756308     0     0 601933 11815  1 35 65  0  0 2022-04-19 11:44:49
> ... ...
> 32  0 47465984 192000400   1052 2636472 456228 652756     0     0 335570 4359  0 35 65  0  0 2022-04-19 11:46:11
> 33  0 47652352 191996784   1052 2637932 437368 622652     0     0 328532 3627  1 35 65  0  0 2022-04-19 11:46:12
> 33  0 47830272 191998800   1052 2639296 428224 607516     0     0 325651 3847  1 35 65  0  0 2022-04-19 11:46:13
> 34  0 48014492 192001504   1052 2640596 441592 625308     0     0 329752 4199  1 35 65  0  0 2022-04-19 11:46:14
> 32  0 48200960 191996240   1052 2642148 458724 645744     0     0 333806 3988  0 35 65  0  0 2022-04-19 11:46:15
> 45  0 48379904 191991904   1052 2643576 442948 621268     0     0 329070 4529  0 35 65  0  0 2022-04-19 11:46:16
> 33  0 48557504 191996960   1052 2644812 444420 621948     0     0 328916 7249  1 35 64  0  0 2022-04-19 11:46:17
> 33  0 48729564 191995744   1052 2646272 447396 619376     0     0 329126 4565  0 35 65  0  0 2022-04-19 11:46:18
> 32  0 48959268 191989024   1052 2647828 595888 825480     0     0 368714 8096  0 35 65  0  0 2022-04-19 11:46:19
> 32  0 49242368 191990304   1052 2650036 746212 1028524     0     0 411140 10949  0 34 65  0  0 2022-04-19 11:46:20
> 32  0 49520792 191984080   1052 2652372 758208 1037236     0     0 415505 10094  0 34 65  0  0 2022-04-19 11:46:21
> 32  0 49799168 191994240   1052 2654724 767236 1046964     0     0 418405 10726  0 35 65  0  0 2022-04-19 11:46:22
> 32  0 50067712 191989104   1052 2657092 759192 1028600     0     0 415356 10173  0 35 65  0  0 2022-04-19 11:46:23
> 33  0 50333440 191980320   1052 2659332 750764 1014732     0     0 412144 9197  0 34 65  0  0 2022-04-19 11:46:24
> 32  0 50584052 191973824   1052 2661576 737720 988964     0     0 406620 8752  0 35 65  0  0 2022-04-19 11:46:25
> 32  0 50816000 191976080   1052 2663660 689248 921108     0     0 391782 8517  0 34 65  0  0 2022-04-19 11:46:26
> 32  0 51036416 191970464   1052 2665612 668004 888220     0     0 385112 7310  1 34 65  0  0 2022-04-19 11:46:27
> 32  0 51256576 191962224   1052 2667536 678464 897872     0     0 388494 12547  0 35 65  0  0 2022-04-19 11:46:28
> 33  0 51464680 191966304   1052 2669472 654540 862720     0     0 380869 7069  1 34 65  0  0 2022-04-19 11:46:29
> 32  0 51597232 191971840   1052 2670848 419772 552324     0     0 314325 4029  1 35 65  0  0 2022-04-19 11:46:30
> 33  0 51722448 191969456   1052 2672072 409300 535892     0     0 310720 4014  1 35 65  0  0 2022-04-19 11:46:31
> 32  0 51850496 191963472   1052 2673236 413160 541076     0     0 311652 3583  1 35 65  0  0 2022-04-19 11:46:32
> 32  0 51978872 191968208   1052 2674452 415844 543464     0     0 312411 3579  1 35 65  0  0 2022-04-19 11:46:33
> 32  0 52105724 191974640   1052 2675616 418104 545728     0     0 312731 4183  1 35 65  0  0 2022-04-19 11:46:34
> 34  0 52232928 191964336   1052 2676964 426200 552956     0     0 314230 3834  1 35 64  0  0 2022-04-19 11:46:35
> 
> The full vmstat is attached.
> 
> > For swap-in latency, we can use pmbench, which can output latency
> > information.
> > 
> 
> OK, I'll give pmbench a run, thanks for the suggestion.

Better to construct a senario with more swapin than swapout.  For
example, start a memory eater, then kill it later.

Best Regards,
Huang, Ying

