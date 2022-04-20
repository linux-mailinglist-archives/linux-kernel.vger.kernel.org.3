Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7C350811F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 08:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245300AbiDTG1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 02:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344623AbiDTG1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 02:27:19 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DF33A5CD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 23:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650435863; x=1681971863;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=66coJSZhQ3pAvyYP5fa2AkzhxCBt3q1rcOyoDYuNoX0=;
  b=PDXD8KaSF826AwGZXig1SCyFiplvHOGTSFfS1WdPCwqc5WqZs1b4aCZw
   mctjR4Cg9Ee8c48Bf7luUoZgAKA/+/I8Vd95jGIqSmHoYNVgZMPOsTgdr
   2vLb6u6aswzKcj6UIk2cID6MfpVMuVDuFGagwZIHr6CpkRELvJzJVFnmC
   qnJfblD3O4t7swbg9tz/2TKhmzbDazfzsdQCwezJb98bFn/VjlnL9ddzE
   UC6+Z5PurqYb7sIL2QJc+1rBryRNBDq0aVPZ13gI2NC4uBUOBhViX7D8+
   euCKYWKrb7RM96T6/bUSZ0lTxSFGUM+06GbSc5j7G+zVsHzazbucIrJ9w
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="263414396"
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="263414396"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 23:24:23 -0700
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="529618010"
Received: from haowanx-mobl.ccr.corp.intel.com ([10.254.212.178])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 23:24:18 -0700
Message-ID: <d397577e14a5ca04f883d866e4ef1a1fddf19c8d.camel@intel.com>
Subject: Re: [sched/fair]  2cfb7a1b03:  stress-ng.fstat.ops_per_sec -19.8%
 regression
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com, aubrey.li@linux.intel.com,
        yu.c.chen@intel.com, kernel test robot <oliver.sang@intel.com>
Date:   Wed, 20 Apr 2022 14:24:13 +0800
In-Reply-To: <20220418141856.GC25584@xsang-OptiPlex-9020>
References: <20220418141856.GC25584@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mel,

On Mon, 2022-04-18 at 22:18 +0800, kernel test robot wrote:
> (please be noted we reported "[sched/fair]  2cfb7a1b03:  fsmark.files_per_sec
> -26.2% regression" at
> https://lore.kernel.org/all/20220303153108.GC14527@xsang-OptiPlex-9020/
> when this is still on branch:
> commit: 2cfb7a1b031b0e816af7a6ee0c6ab83b0acdf05a ("sched/fair: Improve consistency of allowed NUMA balance calculations")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/core
> 
> now we noticed the similar performance changes as well as some others are
> still existing on mainline, so report this again for information)
> 
> 
> Greeting,
> 
> FYI, we noticed a -19.8% regression of stress-ng.fstat.ops_per_sec due to commit:
> 
> 
> commit: 2cfb7a1b031b0e816af7a6ee0c6ab83b0acdf05a ("sched/fair: Improve consistency of allowed NUMA balance calculations")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: stress-ng
> on test machine: 96 threads 2 sockets Ice Lake with 256G memory
> with following parameters:
> 
> 	nr_threads: 10%
> 	disk: 1HDD
> 	testtime: 60s
> 	fs: f2fs
> 	class: filesystem
> 	test: fstat
> 	cpufreq_governor: performance
> 	ucode: 0xb000280
> 
> 
> In addition to that, the commit also has significant impact on the following tests:
> 
> +------------------+-------------------------------------------------------------------------------------+
> > testcase: change | phoronix-test-suite: phoronix-test-suite.neatbench.CPU.fps 12.5% improvement        |
> > test machine     | 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 512G memory      |
> > test parameters  | cpufreq_governor=performance                                                        |
> >                  | option_a=CPU                                                                        |
> >                  | test=neatbench-1.0.4                                                                |
> >                  | ucode=0x500320a                                                                     |
> +------------------+-------------------------------------------------------------------------------------+
> > testcase: change | phoronix-test-suite: phoronix-test-suite.neatbench.All.fps 15.2% improvement        |
> > test machine     | 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 512G memory      |
> > test parameters  | cpufreq_governor=performance                                                        |
> >                  | option_a=All (CPU + GPU)                                                            |
> >                  | test=neatbench-1.0.4                                                                |
> >                  | ucode=0x500320a                                                                     |
> +------------------+-------------------------------------------------------------------------------------+
> > testcase: change | fsmark: fsmark.files_per_sec -9.9% regression                                       |
> > test machine     | 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
> > test parameters  | cpufreq_governor=performance                                                        |
> >                  | disk=1BRD_48G                                                                       |
> >                  | filesize=4M                                                                         |
> >                  | fs=f2fs                                                                             |
> >                  | iterations=1x                                                                       |
> >                  | nr_threads=64t                                                                      |
> >                  | sync_method=fsyncBeforeClose                                                        |
> >                  | test_size=24G                                                                       |
> >                  | ucode=0x500320a                                                                     |
> +------------------+-------------------------------------------------------------------------------------+
> > testcase: change | fsmark: fsmark.files_per_sec -26.2% regression                                      |
> > test machine     | 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
> > test parameters  | cpufreq_governor=performance                                                        |
> >                  | disk=1BRD_48G                                                                       |
> >                  | filesize=4M                                                                         |
> >                  | fs=ext4                                                                             |
> >                  | iterations=1x                                                                       |
> >                  | nr_threads=64t                                                                      |
> >                  | sync_method=NoSync                                                                  |
> >                  | test_size=24G                                                                       |
> >                  | ucode=0x500320a                                                                     |
> +------------------+-------------------------------------------------------------------------------------+
> > testcase: change | stress-ng: stress-ng.fstat.ops_per_sec -20.1% regression                            |
> > test machine     | 96 threads 2 sockets Ice Lake with 256G memory                                      |
> > test parameters  | class=filesystem                                                                    |
> >                  | cpufreq_governor=performance                                                        |
> >                  | disk=1HDD                                                                           |
> >                  | fs=xfs                                                                              |
> >                  | nr_threads=10%                                                                      |
> >                  | test=fstat                                                                          |
> >                  | testtime=60s                                                                        |
> >                  | ucode=0xb000280                                                                     |
> +------------------+-------------------------------------------------------------------------------------+
> > testcase: change | fsmark: fsmark.files_per_sec -16.3% regression                                      |
> > test machine     | 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
> > test parameters  | cpufreq_governor=performance                                                        |
> >                  | disk=1BRD_48G                                                                       |
> >                  | filesize=4M                                                                         |
> >                  | fs=ext4                                                                             |
> >                  | iterations=1x                                                                       |
> >                  | nr_threads=64t                                                                      |
> >                  | sync_method=fsyncBeforeClose                                                        |
> >                  | test_size=24G                                                                       |
> >                  | ucode=0x500320a                                                                     |
> +------------------+-------------------------------------------------------------------------------------+
> > testcase: change | stress-ng: stress-ng.fstat.ops_per_sec -20.2% regression                            |
> > test machine     | 96 threads 2 sockets Ice Lake with 256G memory                                      |
> > test parameters  | class=filesystem                                                                    |
> >                  | cpufreq_governor=performance                                                        |
> >                  | disk=1HDD                                                                           |
> >                  | fs=xfs                                                                              |
> >                  | nr_threads=10%                                                                      |
> >                  | test=fstat                                                                          |
> >                  | testtime=60s                                                                        |
> >                  | ucode=0xb000280                                                                     |
> +------------------+-------------------------------------------------------------------------------------+
> 

When I worked on the following regression report,

https://lore.kernel.org/lkml/87tuc7fp9k.fsf@yhuang6-desk2.ccr.corp.intel.com/

I found stress-ng throughput will regress if the tasks are distrubuted
more evenly among NUMA nodes.  So for this regression, I re-tested with
mpstat per node statistics.  The results are as follows,

	mpstat.node.0.user%	mpstat.node.1.user%	mpstat.node.0.sys%	mpstat.node.1.sys%
889c5d60fb	       3.04		       2.65		      30.0		      25.8
2cfb7a1b03	       2.39		       2.28		      31.2		      28.9

It can be found that the task are balanced better with the commit
2cfb7a1b03.  So I think the regression isn't a real problem.

Best Regards,
Huang, Ying




