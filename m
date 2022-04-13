Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC894FED33
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 04:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiDMCz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 22:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiDMCzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 22:55:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DC5506FB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 19:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649818411; x=1681354411;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iAv5dkbR0+970v7u956ZWhweZIRufdGjsylm0ge4jKY=;
  b=HkirIRPdTOCsylo0O12ry/v9ZbYsrX6ZOQYmiJR+jx8vLSO3HvKIkKPg
   36rJB4r3Mj0DJLFdtY4HX75ig+WqENOowSU1NOdJaTpx2uuyMPk9v80de
   nB2ngevhEWLyGEH8EsZM+ohHvKwQilqaPke7OoAwMnGGjkCXAo3cWD5Dq
   OpNCfuFIop5nSrYelMt24qS6oesx9nivi31dJ6XNhv99Yd6zkO7Bj2OOq
   uWZQULOIInXAWcEkxyRB7Hk+fxYi0J1ms5LkO5JpEEvIrgDSJckZqDqiv
   SM/sOGWGUxmMrrpNXVc9OUO6F+YqPL4P5RPZsBk6bi+Vkv8psr+22HkXi
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="244442982"
X-IronPort-AV: E=Sophos;i="5.90,255,1643702400"; 
   d="scan'208";a="244442982"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 19:53:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,255,1643702400"; 
   d="scan'208";a="724719960"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 12 Apr 2022 19:53:28 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neT8K-0003Ni-4f;
        Wed, 13 Apr 2022 02:53:28 +0000
Date:   Wed, 13 Apr 2022 10:52:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     kbuild-all@lists.01.org, Christoph Hellwig <hch@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch V4 1/2] smp: Rename flush_smp_call_function_from_idle()
Message-ID: <202204131011.m9M80Uip-lkp@intel.com>
References: <20220412204353.655068649@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412204353.655068649@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

I love your patch! Perhaps something to improve:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on hch-configfs/for-next linus/master linux/master v5.18-rc2 next-20220412]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Gleixner/smp-Make-softirq-handling-RT-friendly/20220413-045944
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 089c02ae2771a14af2928c59c56abfb9b885a8d7
config: arc-defconfig (https://download.01.org/0day-ci/archive/20220413/202204131011.m9M80Uip-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7c7c3b99f3599eb409f237b32f330fa06bffcd5d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Thomas-Gleixner/smp-Make-softirq-handling-RT-friendly/20220413-045944
        git checkout 7c7c3b99f3599eb409f237b32f330fa06bffcd5d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/smp.c:697:6: warning: no previous prototype for 'flush_smp_call_function_queue' [-Wmissing-prototypes]
     697 | void flush_smp_call_function_queue(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/flush_smp_call_function_queue +697 kernel/smp.c

   683	
   684	
   685	/**
   686	 * flush_smp_call_function_queue - Flush pending smp-call-function callbacks
   687	 *				   from task context (idle, migration thread)
   688	 *
   689	 * When TIF_POLLING_NRFLAG is supported and a CPU is in idle and has it
   690	 * set, then remote CPUs can avoid sending IPIs and wake the idle CPU by
   691	 * setting TIF_NEED_RESCHED. The idle task on the woken up CPU has to
   692	 * handle queued SMP function calls before scheduling.
   693	 *
   694	 * The migration thread has to ensure that an eventually pending wakeup has
   695	 * been handled before it migrates a task.
   696	 */
 > 697	void flush_smp_call_function_queue(void)
   698	{
   699		unsigned long flags;
   700	
   701		if (llist_empty(this_cpu_ptr(&call_single_queue)))
   702			return;
   703	
   704		cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->idle, CFD_SEQ_NOCPU,
   705			      smp_processor_id(), CFD_SEQ_IDLE);
   706		local_irq_save(flags);
   707		__flush_smp_call_function_queue(true);
   708		if (local_softirq_pending())
   709			do_softirq();
   710	
   711		local_irq_restore(flags);
   712	}
   713	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
