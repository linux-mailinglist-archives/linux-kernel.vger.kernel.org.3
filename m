Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B384D9C19
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348644AbiCON1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348631AbiCON1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:27:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2084D42ED0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647350761; x=1678886761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DUJkbhEMYFfC7vCg5ediYDdzNR4Ys1q6v/5bpfUlhlo=;
  b=ldyBJymT44HD7cLPTGQ9hqxOHQiMRGL8YbRGSM86J6PvxiSyG3YRp1OS
   PqkFgqFWrTjoFmCIthoDg7hMMzf3nOxNVPWc0cTeamf5YZyo3tz4ATKdc
   oEd81U4hLPZqBkCD7w1vE93Gmj52kavcY6HFppQH1lf4cMCGWWwOdWF4+
   JtR4xe/T5PY7lBxDU01i8DLphp01Gq7IIDuP3H2td2mAnkjmOOEoWi8rB
   0ZK8w/Bv85FRww3+EsqgYbqCtxXZv5ZBU969iQQO3EP+47kCdZQEiBT+3
   VFw3GcZlyJ8GmDBKzcCvAE1ddz0CI9+K/zc34uug+mLGe+fFic+0BX4IZ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="253856931"
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="253856931"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 06:26:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="515864016"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Mar 2022 06:25:54 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nU7BS-000B1u-5i; Tue, 15 Mar 2022 13:25:54 +0000
Date:   Tue, 15 Mar 2022 21:24:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qing Wang <wangqing@vivo.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Wang Qing <wangqing@vivo.com>
Subject: Re: [PATCH] sched: dynamic config sd_flags if described in DT
Message-ID: <202203152145.vPr4Qv42-lkp@intel.com>
References: <1647331137-69890-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1647331137-69890-1-git-send-email-wangqing@vivo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qing,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on driver-core/driver-core-testing tip/sched/core linus/master v5.17-rc8 next-20220310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Qing-Wang/sched-dynamic-config-sd_flags-if-described-in-DT/20220315-160039
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: riscv-randconfig-r025-20220314 (https://download.01.org/0day-ci/archive/20220315/202203152145.vPr4Qv42-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6b2f50fb47da3baeee10b1906da6e30ac5d26ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/0day-ci/linux/commit/3322560249c42b0a3e719b19842a3ace7d5ffb6a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Qing-Wang/sched-dynamic-config-sd_flags-if-described-in-DT/20220315-160039
        git checkout 3322560249c42b0a3e719b19842a3ace7d5ffb6a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/base/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/base/arch_topology.c:648:23: error: use of undeclared identifier 'cpu'
                   if (!cache_topology[cpu][cache_level])
                                       ^
   drivers/base/arch_topology.c:654:23: error: use of undeclared identifier 'cpu'
                           if (cache_topology[cpu][cache_level] == cache_topology[cpu_id][cache_level]) {
                                              ^
   2 errors generated.


vim +/cpu +648 drivers/base/arch_topology.c

   639	
   640	int cpus_share_self_cache(const struct cpumask *cpu_map)
   641	{
   642		int cache_level, cpu_id;
   643		int first, last;
   644		int id = cpumask_first(cpu_map);
   645		int size = cpumask_weight(cpu_map);
   646	
   647		for (cache_level = 0; cache_level < MAX_CACHE_LEVEL; cache_level++) {
 > 648			if (!cache_topology[cpu][cache_level])
   649				return -1;
   650	
   651			first = -1;
   652			last = id;
   653			for (cpu_id = 0; cpu_id < NR_CPUS; cpu_id++) {
   654				if (cache_topology[cpu][cache_level] == cache_topology[cpu_id][cache_level]) {
   655					if (cpu_id < id || cpu_id >= id + size)
   656						return 0;
   657	
   658					first = (first == -1)?cpu_id:first;
   659					last = cpu_id;
   660				}
   661			}
   662	
   663			if (first == id && last == id + size)
   664				return 1;
   665		}
   666	
   667		return 0;
   668	}
   669	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
