Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4BF4D50B2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245152AbiCJRhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237195AbiCJRhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:37:41 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9007190B4F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646933799; x=1678469799;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DmdKyDRTAnvU4sOod75m/tiHVhv+0WGnvl2gkq+N75E=;
  b=UqnR5SZ+nLR1WPt9K9T7oCw0FEFZ+Me/ZaHQMDM9ARkAgvMVDaJykhMa
   ujtSD+kyegYwMtOOZMopJoZkxcKseZNZsuXXjdcVyrL0FaHIVdUVCfE7u
   evwaAFrJv//x+9/8eLcEip8Q+RcSsN5LhdtIKpK+6Gt+YNc28X6F6iJYh
   tNF4LKg4LAF+yCvSrvgJSuDEAdcXzmgwPAgL6iZwAS8XmrbWTEaKqpopY
   pbxzz7dv8ICQQG2XBiPP2Ah/qWhA95wuTA3VAKaWjwCHoCtmA6C1C0NCz
   E7KOu+ncTWIo1jGgGk8tngFo+tTxupJWvl7yCb14T6pyYCTHTi/JSgWFn
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="235922642"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="235922642"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:36:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="815951551"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 10 Mar 2022 09:36:33 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSMiG-0005DV-RY; Thu, 10 Mar 2022 17:36:32 +0000
Date:   Fri, 11 Mar 2022 01:35:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qing Wang <wangqing@vivo.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Wang Qing <wangqing@vivo.com>
Subject: Re: [PATCH] sched: topology: make cache topology separate from cpu
 topology
Message-ID: <202203110141.qsdgjdyC-lkp@intel.com>
References: <1646917125-20038-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646917125-20038-1-git-send-email-wangqing@vivo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qing,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on driver-core/driver-core-testing tip/sched/core linus/master v5.17-rc7 next-20220310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Qing-Wang/sched-topology-make-cache-topology-separate-from-cpu-topology/20220310-210139
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220311/202203110141.qsdgjdyC-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/035814a878b0c4cb313ebd35464e2149d8592d89
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Qing-Wang/sched-topology-make-cache-topology-separate-from-cpu-topology/20220310-210139
        git checkout 035814a878b0c4cb313ebd35464e2149d8592d89
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/sched/topology.c: In function 'set_sd_llc':
   kernel/sched/topology.c:663:38: error: 'MAX_CPU_CACHE_LEVEL' undeclared (first use in this function)
     663 |  for (cache_level = 0; cache_level < MAX_CPU_CACHE_LEVEL; cache_level++) {
         |                                      ^~~~~~~~~~~~~~~~~~~
   kernel/sched/topology.c:663:38: note: each undeclared identifier is reported only once for each function it appears in
   kernel/sched/topology.c:664:8: error: 'cache_topology' undeclared (first use in this function); did you mean 'cpu_topology'?
     664 |   if (!cache_topology[cpu][cache_level])
         |        ^~~~~~~~~~~~~~
         |        cpu_topology
>> kernel/sched/topology.c:653:28: warning: parameter 'cpu' set but not used [-Wunused-but-set-parameter]
     653 | static void set_sd_llc(int cpu, struct sched_domain *sd, int *first_cpu, int *cpu_num)
         |                        ~~~~^~~


vim +/cpu +653 kernel/sched/topology.c

   652	
 > 653	static void set_sd_llc(int cpu, struct sched_domain *sd, int *first_cpu, int *cpu_num)
   654	{
   655		int cache_level, cpu_id;
   656		int first, last;
   657		int id = cpumask_first(sched_domain_span(sd));
   658		int size = cpumask_weight(sched_domain_span(sd));
   659	
   660		*first_cpu = id;
   661		*cpu_num = size;
   662	
 > 663		for (cache_level = 0; cache_level < MAX_CPU_CACHE_LEVEL; cache_level++) {
   664			if (!cache_topology[cpu][cache_level])
   665				break;
   666	
   667			first = -1;
   668			last = id;
   669			for (cpu_id = 0; cpu_id < NR_CPUS; cpu_id++) {
   670				if (cache_topology[cpu][cache_level] == cache_topology[cpu_id][cache_level]) {
   671					if (cpu_id >= id && cpu_id < id + size) {
   672						first = (first == -1)?cpu_id:first;
   673						last = cpu_id;
   674					} else
   675						return;
   676				}
   677			}
   678			*first_cpu = first;
   679			*cpu_num = last - first + 1;
   680		}
   681	}
   682	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
