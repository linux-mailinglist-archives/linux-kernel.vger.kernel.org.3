Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8603F5AE36E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239470AbiIFItg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239607AbiIFIsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:48:45 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA857A501
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 01:46:03 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MMJm60R7tzkX2K;
        Tue,  6 Sep 2022 16:42:14 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 6 Sep 2022 16:46:01 +0800
CC:     <yangyicong@hisilicon.com>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <bristot@redhat.com>,
        <prime.zeng@huawei.com>, <jonathan.cameron@huawei.com>,
        <ego@linux.vnet.ibm.com>, <srikar@linux.vnet.ibm.com>,
        <linuxarm@huawei.com>, <21cnbao@gmail.com>,
        <guodong.xu@linaro.org>, <hesham.almatary@huawei.com>,
        <john.garry@huawei.com>, <shenyang39@huawei.com>,
        <yu.c.chen@intel.com>, <wuyun.abel@bytedance.com>
Subject: Re: [PATCH v7 0/2] sched/fair: Scan cluster before scanning LLC in
 wake-up path
To:     K Prateek Nayak <kprateek.nayak@amd.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <tim.c.chen@linux.intel.com>,
        <gautham.shenoy@amd.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220822073610.27205-1-yangyicong@huawei.com>
 <d49aeabd-ee4e-cc81-06d1-b16029a901ee@amd.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <551e64af-6837-f1c3-209f-4fe0b4ba8597@huawei.com>
Date:   Tue, 6 Sep 2022 16:46:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <d49aeabd-ee4e-cc81-06d1-b16029a901ee@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/6 13:28, K Prateek Nayak wrote:
> Hello Yicong,
> 
> We've tested the series on a dual socket Zen3 system (2 x 64C/128T).
> 
> tl;dr
> 
> - The results look good and the changes do not affect the Zen3 machine
>   which doesn't contain any sched domain with SD_CLUSTER flag set.
> 
> - With the latest BIOS, I don't see any regression due to the addition
>   of the new per CPU variables.
>   We had observed a regression in tbench previously when testing the
>   v4 of the series on the system with a slightly outdated BIOS
>   (https://lore.kernel.org/lkml/e000b124-afd4-28e1-fde2-393b0e38ce19@amd.com/)
>   but that doesn't seem to be the case with the latest BIOS :)
> 
> Detailed results from the standard benchmarks are reported below.
> 
> On 8/22/2022 1:06 PM, Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> This is the follow-up work to support cluster scheduler. Previously
>> we have added cluster level in the scheduler for both ARM64[1] and
>> X86[2] to support load balance between clusters to bring more memory
>> bandwidth and decrease cache contention. This patchset, on the other
>> hand, takes care of wake-up path by giving CPUs within the same cluster
>> a try before scanning the whole LLC to benefit those tasks communicating
>> with each other.
>>
>> [1] 778c558f49a2 ("sched: Add cluster scheduler level in core and related Kconfig for ARM64")
>> [2] 66558b730f25 ("sched: Add cluster scheduler level for x86")
>>
> 
> Discussed below are the results from running standard benchmarks on
> a dual socket Zen3 (2 x 64C/128T) machine configured in different
> NPS modes.
> 
> NPS Modes are used to logically divide single socket into
> multiple NUMA region.
> Following is the NUMA configuration for each NPS mode on the system:
> 
> NPS1: Each socket is a NUMA node.
>     Total 2 NUMA nodes in the dual socket machine.
> 
>     Node 0: 0-63,   128-191
>     Node 1: 64-127, 192-255
> 
> NPS2: Each socket is further logically divided into 2 NUMA regions.
>     Total 4 NUMA nodes exist over 2 socket.
>    
>     Node 0: 0-31,   128-159
>     Node 1: 32-63,  160-191
>     Node 2: 64-95,  192-223
>     Node 3: 96-127, 223-255
> 
> NPS4: Each socket is logically divided into 4 NUMA regions.
>     Total 8 NUMA nodes exist over 2 socket.
>    
>     Node 0: 0-15,    128-143
>     Node 1: 16-31,   144-159
>     Node 2: 32-47,   160-175
>     Node 3: 48-63,   176-191
>     Node 4: 64-79,   192-207
>     Node 5: 80-95,   208-223
>     Node 6: 96-111,  223-231
>     Node 7: 112-127, 232-255
> 
> Benchmark Results:
> 
> Kernel versions:
> - tip:      5.19.0 tip sched/core
> - cluster:  5.19.0 tip sched/core + both the patches of the series
> 
> When we started testing, the tip was at:
> commit: 5531ecffa4b9 "sched: Add update_current_exec_runtime helper"
> 
> ~~~~~~~~~~~~~
> ~ hackbench ~
> ~~~~~~~~~~~~~
> 
> NPS1
> 
> Test:		      tip                    cluster
>  1-groups:	   4.31 (0.00 pct)	   4.31 (0.00 pct)
>  2-groups:	   4.93 (0.00 pct)	   4.86 (1.41 pct)
>  4-groups:	   5.38 (0.00 pct)	   5.36 (0.37 pct)
>  8-groups:	   5.59 (0.00 pct)	   5.54 (0.89 pct)
> 16-groups:	   7.18 (0.00 pct)	   7.47 (-4.03 pct)
> 
> NPS2
> 
> Test:		      tip                     cluster
>  1-groups:	   4.25 (0.00 pct)	   4.40 (-3.52 pct)
>  2-groups:	   4.83 (0.00 pct)	   4.73 (2.07 pct)
>  4-groups:	   5.25 (0.00 pct)	   5.18 (1.33 pct)
>  8-groups:	   5.56 (0.00 pct)	   5.45 (1.97 pct)
> 16-groups:	   6.72 (0.00 pct)	   6.63 (1.33 pct)
> 
> NPS4
> 
> Test:		      tip                     cluster
>  1-groups:	   4.24 (0.00 pct)	   4.23 (0.23 pct)
>  2-groups:	   4.88 (0.00 pct)	   4.78 (2.04 pct)
>  4-groups:	   5.30 (0.00 pct)	   5.25 (0.94 pct)
>  8-groups:	   5.66 (0.00 pct)	   5.61 (0.88 pct)
> 16-groups:	   6.79 (0.00 pct)	   7.05 (-3.82 pct)
> 
> ~~~~~~~~~~~~
> ~ schbench ~
> ~~~~~~~~~~~~
> 
> NPS1
> 
> #workers:     tip                       cluster
>   1:	  37.00 (0.00 pct)	     22.00 (40.54 pct)
>   2:	  39.00 (0.00 pct)	     23.00 (41.02 pct)
>   4:	  41.00 (0.00 pct)	     30.00 (26.82 pct)
>   8:	  53.00 (0.00 pct)	     47.00 (11.32 pct)
>  16:	  73.00 (0.00 pct)	     73.00 (0.00 pct)
>  32:	 116.00 (0.00 pct)	    117.00 (-0.86 pct)
>  64:	 217.00 (0.00 pct)	    221.00 (-1.84 pct)
> 128:	 477.00 (0.00 pct)	    444.00 (6.91 pct)
> 256:	1062.00 (0.00 pct)	   1050.00 (1.12 pct)
> 512:   47552.00 (0.00 pct)	  48576.00 (-2.15 pct)
> 
> NPS2
> 
> #workers:     tip                       cluster
>   1:	  20.00 (0.00 pct)	     20.00 (0.00 pct)
>   2:	  22.00 (0.00 pct)	     23.00 (-4.54 pct)
>   4:	  30.00 (0.00 pct)	     31.00 (-3.33 pct)
>   8:	  46.00 (0.00 pct)	     49.00 (-6.52 pct)
>  16:	  70.00 (0.00 pct)	     72.00 (-2.85 pct)
>  32:	 120.00 (0.00 pct)	    118.00 (1.66 pct)
>  64:	 215.00 (0.00 pct)	    216.00 (-0.46 pct)
> 128:	 482.00 (0.00 pct)	    449.00 (6.84 pct)
> 256:	1042.00 (0.00 pct)	    995.00 (4.51 pct)
> 512:   47552.00 (0.00 pct)	  47296.00 (0.53 pct)
> 
> NPS4
> 
> #workers:     tip                       cluster
>   1:	  18.00 (0.00 pct)	     20.00 (-11.11 pct)
>   2:	  23.00 (0.00 pct)	     22.00 (4.34 pct)
>   4:	  27.00 (0.00 pct)	     30.00 (-11.11 pct)
>   8:	  57.00 (0.00 pct)	     60.00 (-5.26 pct)
>  16:	  76.00 (0.00 pct)	     84.00 (-10.52 pct)
>  32:	 120.00 (0.00 pct)	    115.00 (4.16 pct)
>  64:	 219.00 (0.00 pct)	    212.00 (3.19 pct)
> 128:	 459.00 (0.00 pct)	    442.00 (3.70 pct)
> 256:	1078.00 (0.00 pct)	    983.00 (8.81 pct)
> 512:   47040.00 (0.00 pct)	  48192.00 (-2.44 pct)
> 
> Note: schbench displays lot of run to run variance for
> low worker count. This behavior is due to the timing of
> new-idle balance which is not consistent across runs.
> 
> ~~~~~~~~~~
> ~ tbench ~
> ~~~~~~~~~~
> 
> NPS1
> 
> Clients:      tip            	      cluster
>     1	   573.26 (0.00 pct)	   572.61 (-0.11 pct)
>     2	  1131.19 (0.00 pct)	  1122.41 (-0.77 pct)
>     4	  2100.07 (0.00 pct)	  2081.74 (-0.87 pct)
>     8	  3809.88 (0.00 pct)	  3732.14 (-2.04 pct)
>    16	  6560.72 (0.00 pct)	  6289.22 (-4.13 pct)
>    32	 12203.23 (0.00 pct)	 11811.74 (-3.20 pct)
>    64	 22389.81 (0.00 pct)	 21587.79 (-3.58 pct)
>   128	 32449.37 (0.00 pct)	 32967.15 (1.59 pct)
>   256	 58962.40 (0.00 pct)	 56604.63 (-3.99 pct)
>   512	 59608.71 (0.00 pct)	 56529.95 (-5.16 pct) * (Machine Overloaded)
>   512	 57925.05 (0.00 pct)	 56697.38 (-2.11 pct) [Verification Run]
>  1024	 58037.02 (0.00 pct)	 55751.53 (-3.93 pct)
> 
> NPS2
> 
> Clients:      tip                     cluster
>     1	   574.20 (0.00 pct)	   572.49 (-0.29 pct)
>     2	  1131.56 (0.00 pct)	  1149.53 (1.58 pct)
>     4	  2132.26 (0.00 pct)	  2084.18 (-2.25 pct)
>     8	  3812.20 (0.00 pct)	  3683.04 (-3.38 pct)
>    16	  6457.61 (0.00 pct)	  6340.70 (-1.81 pct)
>    32	 12263.82 (0.00 pct)	 11714.15 (-4.48 pct)
>    64	 22224.11 (0.00 pct)	 21226.34 (-4.48 pct)
>   128	 33040.38 (0.00 pct)	 32478.99 (-1.69 pct)
>   256	 56547.25 (0.00 pct)	 52915.71 (-6.42 pct) * (Machine Overloaded)
>   256    55631.80 (0.00 pct)     52905.99 (-4.89 pct) [Verification Run]
>   512	 56220.67 (0.00 pct)	 54735.69 (-2.64 pct)
>  1024	 56048.88 (0.00 pct)	 54426.63 (-2.89 pct)
> 
> NPS4
> 
> Clients:     tip                      cluster
>     1	   575.50 (0.00 pct)	   570.65 (-0.84 pct)
>     2	  1138.70 (0.00 pct)	  1137.75 (-0.08 pct)
>     4	  2070.66 (0.00 pct)	  2103.18 (1.57 pct)
>     8	  3811.70 (0.00 pct)	  3573.52 (-6.24 pct) *
>     8	  3769.53 (0.00 pct)      3653.05 (-3.09 pct) [Verification Run]
>    16	  6312.80 (0.00 pct)	  6212.41 (-1.59 pct)
>    32	 11418.14 (0.00 pct)	 11721.01 (2.65 pct)
>    64	 19671.16 (0.00 pct)	 20053.77 (1.94 pct)
>   128	 30258.53 (0.00 pct)	 32585.15 (7.68 pct)
>   256	 55838.10 (0.00 pct)	 51318.64 (-8.09 pct) * (Machine Overloaded)
>   256	 54291.03 (0.00 pct)     54379.80 (0.16 pct)  [Verification Run]
>   512	 55586.44 (0.00 pct)	 51538.93 (-7.28 pct) * (Machine Overloaded)
>   512	 54190.04 (0.00 pct)     54096.16 (-0.17 pct) [Verification Run]
>  1024	 56370.35 (0.00 pct)	 50768.68 (-9.93 pct) * (Machine Overloaded)
>  1024    56498.36 (0.00 pct)     54661.85 (-3.25 pct) [Verification Run]
> 
> ~~~~~~~~~~
> ~ stream ~
> ~~~~~~~~~~
> 
> NPS1
> 
> - 10 Runs:
> 
> Test:	      tip                  cluster
>  Copy:	 332237.51 (0.00 pct)	 338085.24 (1.76 pct)
> Scale:	 215236.94 (0.00 pct)	 214179.72 (-0.49 pct)
>   Add:	 250753.67 (0.00 pct)	 251181.86 (0.17 pct)
> Triad:	 259467.60 (0.00 pct)	 262541.92 (1.18 pct)
> 
> - 100 Runs:
> 
> Test:	      tip                  cluster
>  Copy:	 329320.65 (0.00 pct)	 336947.39 (2.31 pct)
> Scale:	 218102.78 (0.00 pct)	 219617.85 (0.69 pct)
>   Add:	 251283.30 (0.00 pct)	 251918.03 (0.25 pct)
> Triad:	 258044.33 (0.00 pct)	 261512.99 (1.34 pct)
> 
> NPS2
> 
> - 10 Runs:
> 
> Test:	      tip                  cluster
>  Copy:	 336926.24 (0.00 pct)	 324310.01 (-3.74 pct)
> Scale:	 220120.41 (0.00 pct)	 212795.43 (-3.32 pct)
>   Add:	 252428.34 (0.00 pct)	 254355.80 (0.76 pct)
> Triad:	 274268.23 (0.00 pct)	 261777.03 (-4.55 pct)
> 
> - 100 Runs:
> 
> Test:	      tip                  cluster
>  Copy:   338126.49 (0.00 pct)    338947.03 (0.24 pct)
> Scale:   230229.59 (0.00 pct)    229991.65 (-0.10 pct)
>   Add:   253964.25 (0.00 pct)    264374.57 (4.09 pct)
> Triad:   272176.19 (0.00 pct)    274587.35 (0.88 pct)
> 
> NPS4
> 
> - 10 Runs:
> 
> Test:	      tip                  cluster
>  Copy:   367144.56 (0.00 pct)    375452.26 (2.26 pct)
> Scale:   246928.04 (0.00 pct)    243651.53 (-1.32 pct)
>   Add:   272096.30 (0.00 pct)    272845.33 (0.27 pct)
> Triad:   286644.55 (0.00 pct)    290925.20 (1.49 pct)
> 
> - 100 Runs:
> 
> Test:	      tip                  cluster
>  Copy:	 351980.15 (0.00 pct)	 375854.72 (6.78 pct)
> Scale:	 254918.41 (0.00 pct)	 255904.90 (0.38 pct)
>   Add:	 272722.89 (0.00 pct)	 274075.11 (0.49 pct)
> Triad:   283340.94 (0.00 pct)	 287608.77 (1.50 pct)
> 
> ~~~~~~~~~~~~~~~~~~~~
> ~ Additional notes ~
> ~~~~~~~~~~~~~~~~~~~~
> 
> - schbench is know to have a noticeable run-to-run variation for lower
>   worker counts and any improvements or regression observed can be
>   safely ignored. The results are included to make sure there are
>   no unnecessarily large regressions as a result of task pileup.
> 
> - tbench shows slight run to run variation with larger number of
>   clients on both tip and patched kernel. This is expected as the machine
>   is overloaded at that point (equivalent of two or more tasks per CPU).
>   "Verification Run" shows none of these regressions are persistent.
> 
>>
>> [..snip..]
>>
> 
> Overall, the changes look good and doesn't affect system without a
> SD_CLUSTER domain like the Zen3 system used during testing.
> 
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> 

Thanks a lot for the testing and verification on the Zen3 system.

Regards,
Yicong

