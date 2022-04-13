Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12D44FED30
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 04:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbiDMCzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 22:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiDMCzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 22:55:50 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BD3506E7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 19:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649818411; x=1681354411;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hRIWfIYlFrX7ZKl3HBejDOvzl6OoZT8bn+gfQ7L9d5o=;
  b=Qkfo8wSi4Xn9w/JPVe56YmU5uU6iEp7W/MQLWcE88HfXJtbkhrz7gXjY
   jgOnUhYzkMA/fUEwzfBqPPa8sy8GxNIK832aeQ6FMXMWeQLkiMWyDekhu
   UTrXEbH+Fxdi2lTfrnQMbtLzeow79pEZn07PyjvUs3mnz6XXfOjR4omHJ
   EYRVSALSAgoBNjREoft3YRSPmkkI+LY0tdSs7u2oNAind65SHOxOJtCZj
   hZrfpM72cU8qSxU/TW5mqwuBYKldKl37jCr8N1CjISC/i/UqQio3z1hnS
   p7tnVF/V+XKDoaVO6W9ga9VXr4yyNE3q/wbD9uBQLPnxXJ+clWv0aMReS
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="260153494"
X-IronPort-AV: E=Sophos;i="5.90,255,1643702400"; 
   d="scan'208";a="260153494"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 19:53:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,255,1643702400"; 
   d="scan'208";a="611708753"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 12 Apr 2022 19:53:28 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neT8K-0003Nk-67;
        Wed, 13 Apr 2022 02:53:28 +0000
Date:   Wed, 13 Apr 2022 10:53:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Christoph Hellwig <hch@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch V4 1/2] smp: Rename flush_smp_call_function_from_idle()
Message-ID: <202204131056.b582vtMv-lkp@intel.com>
References: <20220412204353.655068649@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412204353.655068649@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
config: hexagon-defconfig (https://download.01.org/0day-ci/archive/20220413/202204131056.b582vtMv-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project fe2478d44e4f7f191c43fef629ac7a23d0251e72)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7c7c3b99f3599eb409f237b32f330fa06bffcd5d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Thomas-Gleixner/smp-Make-softirq-handling-RT-friendly/20220413-045944
        git checkout 7c7c3b99f3599eb409f237b32f330fa06bffcd5d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/smp.c:697:6: warning: no previous prototype for function 'flush_smp_call_function_queue' [-Wmissing-prototypes]
   void flush_smp_call_function_queue(void)
        ^
   kernel/smp.c:697:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void flush_smp_call_function_queue(void)
   ^
   static 
   1 warning generated.


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
