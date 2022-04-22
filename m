Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161F250B2AA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 10:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445506AbiDVIOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 04:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbiDVIOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 04:14:50 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0CA52B35
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 01:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650615118; x=1682151118;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cK0QbodZ/3uZEk4psLp/3izywPUoNzicZxBVh2alexk=;
  b=nRRJugU76KQmSZ0mB8cpff4kJ+dx/HnuFlesyvovbSwNEg3uBEQTNvNm
   8ePXKLdW1Drs1Ax0RMUGVqUXduvWrNCJqseTuNepgol6t8BOKThJ2VfFZ
   yovc0qzCfTegy5JnZHBaYqE+NjQdyuiPfDlauu7GU0PPGtbjCcE15x6Dq
   nKCYgzQQoUdWfujO8ptt5dyHqxME9IHA9wgZzkLSE7WCK4O17mp37f5GZ
   VnZsSp2wftDn889SRhooa+b5CnKCQ4+3lQAZv5GllQhOX/R249w/sch77
   dUTWYU0r+pMTXvCI/LoQcUlbVOiMVFOzVtjTaW8p69JsaR3P8lh5r5Rul
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264782158"
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="264782158"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 01:11:58 -0700
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="577751144"
Received: from jiejingx-mobl1.ccr.corp.intel.com ([10.254.215.31])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 01:11:55 -0700
Message-ID: <8335c2c389c2aee51d91a79bee977f4df6f8fb77.camel@intel.com>
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
Date:   Fri, 22 Apr 2022 16:11:52 +0800
In-Reply-To: <d397577e14a5ca04f883d866e4ef1a1fddf19c8d.camel@intel.com>
References: <20220418141856.GC25584@xsang-OptiPlex-9020>
         <d397577e14a5ca04f883d866e4ef1a1fddf19c8d.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mel,

On Wed, 2022-04-20 at 14:24 +0800, ying.huang@intel.com wrote:
> Hi, Mel,
> 
> On Mon, 2022-04-18 at 22:18 +0800, kernel test robot wrote:
> > (please be noted we reported "[sched/fair]  2cfb7a1b03:  fsmark.files_per_sec
> > -26.2% regression" at
> > https://lore.kernel.org/all/20220303153108.GC14527@xsang-OptiPlex-9020/
> > when this is still on branch:
> > commit: 2cfb7a1b031b0e816af7a6ee0c6ab83b0acdf05a ("sched/fair: Improve consistency of allowed NUMA balance calculations")
> > https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/core
> > 
> > now we noticed the similar performance changes as well as some others are
> > still existing on mainline, so report this again for information)
> > 
> > 
> > Greeting,
> > 
> > FYI, we noticed a -19.8% regression of stress-ng.fstat.ops_per_sec due to commit:
> > 
> > 
> > commit: 2cfb7a1b031b0e816af7a6ee0c6ab83b0acdf05a ("sched/fair: Improve consistency of allowed NUMA balance calculations")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > in testcase: stress-ng
> > on test machine: 96 threads 2 sockets Ice Lake with 256G memory
> > with following parameters:
> > 
> > 	nr_threads: 10%
> > 	disk: 1HDD
> > 	testtime: 60s
> > 	fs: f2fs
> > 	class: filesystem
> > 	test: fstat
> > 	cpufreq_governor: performance
> > 	ucode: 0xb000280
> > 
> > 
> > In addition to that, the commit also has significant impact on the following tests:
> > 
> > +------------------+-------------------------------------------------------------------------------------+
> > > testcase: change | phoronix-test-suite: phoronix-test-suite.neatbench.CPU.fps 12.5% improvement        |
> > > test machine     | 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 512G memory      |
> > > test parameters  | cpufreq_governor=performance                                                        |
> > >                  | option_a=CPU                                                                        |
> > >                  | test=neatbench-1.0.4                                                                |
> > >                  | ucode=0x500320a                                                                     |
> > +------------------+-------------------------------------------------------------------------------------+
> > > testcase: change | phoronix-test-suite: phoronix-test-suite.neatbench.All.fps 15.2% improvement        |
> > > test machine     | 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 512G memory      |
> > > test parameters  | cpufreq_governor=performance                                                        |
> > >                  | option_a=All (CPU + GPU)                                                            |
> > >                  | test=neatbench-1.0.4                                                                |
> > >                  | ucode=0x500320a                                                                     |
> > +------------------+-------------------------------------------------------------------------------------+
> > > testcase: change | fsmark: fsmark.files_per_sec -9.9% regression                                       |
> > > test machine     | 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
> > > test parameters  | cpufreq_governor=performance                                                        |
> > >                  | disk=1BRD_48G                                                                       |
> > >                  | filesize=4M                                                                         |
> > >                  | fs=f2fs                                                                             |
> > >                  | iterations=1x                                                                       |
> > >                  | nr_threads=64t                                                                      |
> > >                  | sync_method=fsyncBeforeClose                                                        |
> > >                  | test_size=24G                                                                       |
> > >                  | ucode=0x500320a                                                                     |
> > +------------------+-------------------------------------------------------------------------------------+
> > > testcase: change | fsmark: fsmark.files_per_sec -26.2% regression                                      |
> > > test machine     | 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
> > > test parameters  | cpufreq_governor=performance                                                        |
> > >                  | disk=1BRD_48G                                                                       |
> > >                  | filesize=4M                                                                         |
> > >                  | fs=ext4                                                                             |
> > >                  | iterations=1x                                                                       |
> > >                  | nr_threads=64t                                                                      |
> > >                  | sync_method=NoSync                                                                  |
> > >                  | test_size=24G                                                                       |
> > >                  | ucode=0x500320a                                                                     |
> > +------------------+-------------------------------------------------------------------------------------+
> > > testcase: change | stress-ng: stress-ng.fstat.ops_per_sec -20.1% regression                            |
> > > test machine     | 96 threads 2 sockets Ice Lake with 256G memory                                      |
> > > test parameters  | class=filesystem                                                                    |
> > >                  | cpufreq_governor=performance                                                        |
> > >                  | disk=1HDD                                                                           |
> > >                  | fs=xfs                                                                              |
> > >                  | nr_threads=10%                                                                      |
> > >                  | test=fstat                                                                          |
> > >                  | testtime=60s                                                                        |
> > >                  | ucode=0xb000280                                                                     |
> > +------------------+-------------------------------------------------------------------------------------+
> > > testcase: change | fsmark: fsmark.files_per_sec -16.3% regression                                      |
> > > test machine     | 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
> > > test parameters  | cpufreq_governor=performance                                                        |
> > >                  | disk=1BRD_48G                                                                       |
> > >                  | filesize=4M                                                                         |
> > >                  | fs=ext4                                                                             |
> > >                  | iterations=1x                                                                       |
> > >                  | nr_threads=64t                                                                      |
> > >                  | sync_method=fsyncBeforeClose                                                        |
> > >                  | test_size=24G                                                                       |
> > >                  | ucode=0x500320a                                                                     |
> > +------------------+-------------------------------------------------------------------------------------+
> > > testcase: change | stress-ng: stress-ng.fstat.ops_per_sec -20.2% regression                            |
> > > test machine     | 96 threads 2 sockets Ice Lake with 256G memory                                      |
> > > test parameters  | class=filesystem                                                                    |
> > >                  | cpufreq_governor=performance                                                        |
> > >                  | disk=1HDD                                                                           |
> > >                  | fs=xfs                                                                              |
> > >                  | nr_threads=10%                                                                      |
> > >                  | test=fstat                                                                          |
> > >                  | testtime=60s                                                                        |
> > >                  | ucode=0xb000280                                                                     |
> > +------------------+-------------------------------------------------------------------------------------+
> > 
> 
> When I worked on the following regression report,
> 
> https://lore.kernel.org/lkml/87tuc7fp9k.fsf@yhuang6-desk2.ccr.corp.intel.com/
> 
> I found stress-ng throughput will regress if the tasks are distrubuted
> more evenly among NUMA nodes.  So for this regression, I re-tested with
> mpstat per node statistics.  The results are as follows,
> 
> 	mpstat.node.0.user%	mpstat.node.1.user%	mpstat.node.0.sys%	mpstat.node.1.sys%
> 889c5d60fb	       3.04		       2.65		      30.0		      25.8
> 2cfb7a1b03	       2.39		       2.28		      31.2		      28.9
> 
> It can be found that the task are balanced better with the commit
> 2cfb7a1b03.  So I think the regression isn't a real problem.

I think stress-ng isn't a good workload to evaluate the effect of this
patch.  Can you teach me which workloads are appropriate?

Best Regards,
Huang, Ying

