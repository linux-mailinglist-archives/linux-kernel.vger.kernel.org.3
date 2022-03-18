Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E252A4DD356
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 03:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiCRC6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 22:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbiCRC6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 22:58:05 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED421F2DD6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 19:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647572206; x=1679108206;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=fGRUqDJ9TzC2mvRt08bbN29OrS60uo2l/Y+yPcvnFsE=;
  b=GN4gsCUHK69PBOZ43+awEQlEkPkHR5zeOvSKWm4rcRAJvAmwQ6pW+Xyc
   OHb4HAxotArV2tzqoKnUuTsPF3DGT7GPBRnFvSnCCmWgyF0mQlJrfTrP4
   mIVAffR1Cs/cL2V7Pur6p6MzWD2V0CzFi14WrTk/n96xZmS/rclQxH5N9
   pO95hhtM2aUqYu1zRq5UiIbokKSoknnvrmYYGb31ZXTH7lcQW7ZnnGfKw
   98OUlNPvll2KQBZ6o+gGOZ+m+984d5xc4NNewENmvASO8JH7T3gYku7bm
   q0gPslm7p0YlxIMsSQsqFY/wMWafLx4NRDraJeZ03lO1Pczrp7o6rgWS/
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="281837613"
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="281837613"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 19:56:46 -0700
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="558213982"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 19:56:43 -0700
Date:   Fri, 18 Mar 2022 10:56:31 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "zhengjun.xing@linux.intel.com" <zhengjun.xing@linux.intel.com>,
        "fengwei.yin@intel.com" <fengwei.yin@intel.com>
Subject: Re: [x86/mm/tlb] 6035152d8e: will-it-scale.per_thread_ops -13.2%
 regression
Message-ID: <20220318025631.GA12658@xsang-OptiPlex-9020>
References: <20220317090415.GE735@xsang-OptiPlex-9020>
 <c85ae95a-6603-ca0d-a653-b3f2f7069e20@intel.com>
 <3B958B13-75F0-4B81-B8CF-99CD140436EB@vmware.com>
 <96f9b880-876f-bf4d-8eb0-9ae8bbc8df6d@intel.com>
 <DC37F01B-A80F-4839-B4FB-C21F64943E64@vmware.com>
 <285cf565-ebf7-8cf5-4e57-2245608e79fb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <285cf565-ebf7-8cf5-4e57-2245608e79fb@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave, Hi Nadav,

On Thu, Mar 17, 2022 at 01:49:48PM -0700, Dave Hansen wrote:
> On 3/17/22 13:32, Nadav Amit wrote:
> > Can you please clarify how the bot works - did it notice a performance
> > regression and then started bisecting, or did it just check one patch
> > at a time?
> 
> Oliver can tell us for sure, but it usually finds things by bisecting.
> It will pick an upstream commit and compare it to the latest baseline.
> If it sees a delta it starts bisecting for the triggering commit.
> 
> It isn't a literal 'git bisect', but it's logically similar.

yes, this is exactly how 0-day bot works.

regarding below from Nadav,
> > I ask because I got a different report from the report that a
> > subsequent patch ("x86/mm/tlb: Privatize cpu_tlbstate”) made a
> > 23.3% improvement [1] for a very similar (yet different) test.

yes, we also noticed this:
* 2f4305b19fe6a x86/mm/tlb: Privatize cpu_tlbstate
* 4ce94eabac16b x86/mm/tlb: Flush remote and local TLBs concurrently
* 6035152d8eebe x86/mm/tlb: Open-code on_each_cpu_cond_mask() for tlb_is_not_lazy()
* 4c1ba3923e6c8 x86/mm/tlb: Unify flush_tlb_func_local() and flush_tlb_func_remote()
* a32a4d8a815c4 smp: Run functions concurrently in smp_call_function_many_cond()
* a38fd87484648 (tag: v5.12-rc2,

but we confirmed there is no obvious performance change on this test upon
2f4305b19fe6a ("x86/mm/tlb: Privatize cpu_tlbstate")

below are what we tested along mainline recently, from latest to old for this
test:

7e57714cd0ad2 Linux 5.17-rc6                                                                                             5533 5551 5572 5536 5544 5523
9137eda53752e Merge tag 'configfs-5.17-2022-02-25' of git://git.infradead.org/users/hch/configfs                         5591
53ab78cd6d5ab Merge tag 'clk-fixes-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux                 5571 5569 5525 5542
d8152cfe2f21d Merge tag 'pci-v5.17-fixes-5' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci                 5569 5541
23d04328444a8 Merge tag 'for-5.17/parisc-4' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux         5535 5565 5526
5c1ee569660d4 Merge branch 'for-5.17-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup                   5480 5527 5486
038101e6b2cd5 Merge tag 'platform-drivers-x86-v5.17-3' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86 5508
cfb92440ee71a Linux 5.17-rc5                                                                                             5506
754e0b0e35608 Linux 5.17-rc4                                                                                             5498
e783362eb54cd Linux 5.17-rc1                                                                                             5557
df0cc57e057f1 Linux 5.16                                                                                                 5571
2f4305b19fe6a x86/mm/tlb: Privatize cpu_tlbstate                                                                         5601 5642 5674 5634 5678 5702
6035152d8eebe x86/mm/tlb: Open-code on_each_cpu_cond_mask() for tlb_is_not_lazy()                                        5598 5571 5571 5639 5579 5587 5571 5582
4c1ba3923e6c8 x86/mm/tlb: Unify flush_tlb_func_local() and flush_tlb_func_remote()                                       6292 6508 6478 6505 6411 6475 6269 6494 6474

as above show, the performance drop caused by 6035152d8eebe seems not recover
on 2f4305b19fe6a and following.


as a contrast, for the report
"[x86/mm/tlb] 2f4305b19f: will-it-scale.per_thread_ops 23.3% improvement"
which is a different subtest under will-it-scale, also on another platform:
(we have much more history tests on it before we upgrade the ucode for
this platform, so I only show partial of them):

df0cc57e057f1 Linux 5.16                                                                                                 3247
fc74e0a40e4f9 Linux 5.16-rc7                                                                                             3242
8bb7eca972ad5 Linux 5.15                                                                                                 2856 2879 2900 2871 2890
519d81956ee27 Linux 5.15-rc6                                                                                             2822
64570fbc14f8d Linux 5.15-rc5                                                                                             2820 2839 2852 2833
62fb9874f5da5 Linux 5.13                                                                                                 3311 3299 3288
13311e74253fe Linux 5.13-rc7                                                                                             3302 3316 3303
9f4ad9e425a1d Linux 5.12                                                                                                 2765 2774 2779 2784 2768
1608e4cf31b88 x86/mm/tlb: Remove unnecessary uses of the inline keyword                                                  3448 3447 3483 3506 3494
291c4011dd7ac cpumask: Mark functions as pure                                                                            3469 3520 3419 3437 3418 3499
09c5272e48614 x86/mm/tlb: Do not make is_lazy dirty for no reason                                                        3421 3473 3392 3463 3474 3434
2f4305b19fe6a x86/mm/tlb: Privatize cpu_tlbstate                                                                         3509 3475 3368 3450 3445 3442
4ce94eabac16b x86/mm/tlb: Flush remote and local TLBs concurrently                                                       2796 2792 2796 2812 2784 2796 2779
6035152d8eebe x86/mm/tlb: Open-code on_each_cpu_cond_mask() for tlb_is_not_lazy()                                        2755 2797 2792
4c1ba3923e6c8 x86/mm/tlb: Unify flush_tlb_func_local() and flush_tlb_func_remote()                                       2836 2827 2825
a38fd87484648 Linux 5.12-rc2                                                                                             2997 2981 3003

as above, there is a performance improvement on 2f4305b19fe6a.
but the data from this subtest seems more fluctuated along mainline.

> 
> I did ask the 0day folks privately if they had any more performance data
> on that commit: good, bad or neutral.

we don't have other performance data on this commit so far.
but this may mean there is no other bisection bisected to this commit.

> 
> That commit didn't actually look to me like it was fundamental to
> anything built after it.  It might not revert cleanly, but it doesn't
> look like it would be hard to logically remove.  What other side-effects
> are you worried about?
> 
> BTW, there's also a dirt simple hack to do the on_each_cpu_cond_mask()
> without a retpoline:
> 
> 	if ((cond_func == tlb_is_not_lazy) &&
>             !tlb_is_not_lazy(...))
> 		continue;
> 
> You can't do that literally in arch-independent code, but you get the point.
> 
> I know folks have discussed ways of doing this kind of stuff for other
> high-value indirect calls.  I need to see if there's anything around
> that we could use.
