Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318A757D66D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 00:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbiGUWBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 18:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbiGUWBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 18:01:49 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0376393C36;
        Thu, 21 Jul 2022 15:01:47 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 88F5962CA1B;
        Fri, 22 Jul 2022 08:01:44 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oEeEo-003i9f-Da; Fri, 22 Jul 2022 08:01:42 +1000
Date:   Fri, 22 Jul 2022 08:01:42 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Dave Chinner <dchinner@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-xfs@vger.kernel.org, lkp@lists.01.org, lkp@intel.com,
        ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
Subject: Re: [xfs]  016a23388c:  stress-ng.xattr.ops_per_sec 58.4% improvement
Message-ID: <20220721220142.GW3861211@dread.disaster.area>
References: <Yti6PccitrglBtIj@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yti6PccitrglBtIj@xsang-OptiPlex-9020>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=62d9ccc9
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=8nJEP1OIZ-IA:10 a=RgO8CyIxsXoA:10 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8
        a=7-415B0cAAAA:8 a=Cv6hED_WFzwE_hcpyKwA:9 a=wPNLvfGTeEIA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 10:30:21AM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed a 58.4% improvement of stress-ng.xattr.ops_per_sec due to commit:
> 
> 
> commit: 016a23388cdcb2740deb1379dc408f21c84efb11 ("xfs: Add order IDs to log items in CIL")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> in testcase: stress-ng
> on test machine: 96 threads 2 sockets Ice Lake with 256G memory
> with following parameters:
> 
> 	nr_threads: 10%
> 	disk: 1HDD
> 	testtime: 60s
> 	fs: xfs
> 	class: filesystem
> 	test: xattr
> 	cpufreq_governor: performance
> 	ucode: 0xb000280
> 
> 
> 
> 
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>         sudo bin/lkp run generated-yaml-file
> 
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> =========================================================================================
> class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime/ucode:
>   filesystem/gcc-11/performance/1HDD/xfs/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp1/xattr/stress-ng/60s/0xb000280
> 
> commit: 
>   df7a4a2134 ("xfs: convert CIL busy extents to per-cpu")
>   016a23388c ("xfs: Add order IDs to log items in CIL")

This bisect looks like it's identified the wrong commit. The reason
things went faster was:

> df7a4a2134b0a201 016a23388cdcb2740deb1379dc4 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
.....
>      25.64 ±  8%     -25.6        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.xlog_cil_insert_items.xlog_cil_commit.__xfs_trans_commit

A huge amount of spinlock contention in the xlog_commit_cil() path
went away. The commit identified doesn't remove/change any
spinlocks, it actually adds more overhead to the critical section of
the above spinlock in preparation for removing said spinlocks.

That removal happens in the next commit in that series - c0fb4765c508 ("xfs:
convert CIL to unordered per cpu lists") - so I'd be expecting a
bisect to demonstrate that the spinlock contention goes away with
the commit that removed the spinlocks (as it does in all the testing
of this I've done over the past 2 years), not the commit this bisect
identified. Hence I think the bisect went wrong somewhere...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
