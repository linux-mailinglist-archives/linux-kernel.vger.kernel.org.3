Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB93D52C399
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 21:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242040AbiERTj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 15:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242012AbiERTjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 15:39:53 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83A42044FA
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 12:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652902792; x=1684438792;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C3stV0ABX6qDRooG3hgE2hHRrhRrX72uICXYwP6KLhk=;
  b=d4HbB2V2IhzvGIp2e2g3XaYSdcOJJBvyll91IRpfasN6p63gL0whasr/
   MiQmRjyi+3mgaVM6NUK50x4zqDsGchZUxOpYMY1xHgPpI+3OIGG/fZ3Xl
   KCFknxfk5JFvpz15trsuJVk64H919ip5YvGUwU+os8zs6iBd1J7FDyvEA
   N/T+GIoPym3QW/RZyFi7g1gB+Mr3sZ+huC8QKUsuot7Inm0B0GhqiRfYs
   Ru1CDv7tEDrjZkJ4jdNKV19LFxIN99UosKH8rSMkk1QSxdjSifKadwosH
   ypkZCOMYmdFHiJJ0trA4MAbsuIjW8y4U1tJQDeJKh5E+0uLk8H87mq1Lx
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="269450164"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="269450164"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 12:39:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="673620448"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 18 May 2022 12:39:49 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrPWO-0002YN-LW;
        Wed, 18 May 2022 19:39:48 +0000
Date:   Thu, 19 May 2022 03:39:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Donghai Qiao <dqiao@redhat.com>, akpm@linux-foundation.org,
        sfr@canb.auug.org.au, arnd@arndb.de, peterz@infradead.org,
        heying24@huawei.com, andriy.shevchenko@linux.intel.com,
        axboe@kernel.dk, rdunlap@infradead.org, tglx@linutronix.de,
        gor@linux.ibm.com
Cc:     kbuild-all@lists.01.org, donghai.w.qiao@gmail.com,
        linux-kernel@vger.kernel.org, Donghai Qiao <dqiao@redhat.com>
Subject: Re: [PATCH v3 07/11] smp: eliminate smp_call_function_any
Message-ID: <202205190310.ZNhT85tE-lkp@intel.com>
References: <20220517180326.997129-8-dqiao@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517180326.997129-8-dqiao@redhat.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Donghai,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on linus/master v5.18-rc7]
[cannot apply to tip/x86/core powerpc/next next-20220518]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Donghai-Qiao/smp-cross-CPU-call-interface/20220518-020728
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220519/202205190310.ZNhT85tE-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9ccc00bf617be7b23dca37d3a7d845165c365725
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Donghai-Qiao/smp-cross-CPU-call-interface/20220518-020728
        git checkout 9ccc00bf617be7b23dca37d3a7d845165c365725
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/smp.c:1033: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Given cpumask, find an online CPU as close to the local CPU as


vim +1033 kernel/smp.c

  1031	
  1032	/**
> 1033	 * Given cpumask, find an online CPU as close to the local CPU as
  1034	 * possible in the order below:
  1035	 *
  1036	 *   - The first pick is the local CPU if it is present in cpumask.
  1037	 *   - The second pick is a CPU located in the same node of the
  1038	 *     local CPU and it is also present in cpumask.
  1039	 *   - The Third pick is any online CPU which is also in cpumask.
  1040	 *
  1041	 * The callers should disable preemption when using this function.
  1042	 */
  1043	int __smp_cpu_nearby(const struct cpumask *mask)
  1044	{
  1045	        int cpu;
  1046	        const struct cpumask *nodemask;
  1047	
  1048	        cpu = smp_processor_id();
  1049	        if (cpumask_test_cpu(cpu, mask))
  1050	                return cpu;
  1051	
  1052	        /* Any CPU in the same node */
  1053	        nodemask = cpumask_of_node(cpu_to_node(cpu));
  1054	        for (cpu = cpumask_first_and(nodemask, mask); cpu < nr_cpu_ids;
  1055	             cpu = cpumask_next_and(cpu, nodemask, mask)) {
  1056	                if (cpu_online(cpu))
  1057	                        return cpu;
  1058	        }
  1059	
  1060	        /* Any online CPU will do */
  1061	        cpu = cpumask_any_and(mask, cpu_online_mask);
  1062	        return cpu;
  1063	}
  1064	EXPORT_SYMBOL(__smp_cpu_nearby);
  1065	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
