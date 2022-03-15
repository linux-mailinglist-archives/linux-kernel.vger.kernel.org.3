Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298A44DA384
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351501AbiCOT4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbiCOT4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:56:23 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C513C46B31
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647374110; x=1678910110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6AU4bmQHpzfCMff2LynTkVDLCExMM3FHo7azCwgzSc4=;
  b=lD49rp0AWD9Hx8UbjwiHcbZUNqQN3kGPOyDZwD4JJPhViFDo6OLsfZZa
   odWXrAqQ9yqsrRaRhDw/bwWYdb6QrmfYCUyj3kI/OPQkjT2s6kcul93Mv
   QguuGfIrJJF1rXYWJtUpAnikrADuSkBjsrb4ClJrZCFHSPa35TpDGdpxq
   OickCsEV9GAKS57aLZUq7preh7IyBFBd9ZnZvz0Iij7QV3eu7HjsO0bLL
   tM2g+ybRaBqL6+OyamIM+DlmuqKY1sqfePsn6yrU2o9Bgu+5FfEWwpITf
   9VcicPBJA2/oZVU74UzldQsf9w63DX3LUSqmvdoW/NcLOASoS+OB6A1ks
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="243862759"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="243862759"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 12:55:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="690329395"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 15 Mar 2022 12:55:07 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUDG7-000BRS-AK; Tue, 15 Mar 2022 19:55:07 +0000
Date:   Wed, 16 Mar 2022 03:54:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        James Morse <james.morse@arm.com>,
        Christoffer Dall <cdall@linaro.org>
Subject: Re: [PATCH] arm64: add the printing of tpidr_elx in __show_regs()
Message-ID: <202203160347.f7ls2XFW-lkp@intel.com>
References: <20220315110926.1060-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315110926.1060-1-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhen,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on arm-perf/for-next/perf arm/for-next xilinx-xlnx/master soc/for-next kvmarm/next v5.17-rc8 next-20220315]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Zhen-Lei/arm64-add-the-printing-of-tpidr_elx-in-__show_regs/20220315-191234
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm64-buildonly-randconfig-r002-20220313 (https://download.01.org/0day-ci/archive/20220316/202203160347.f7ls2XFW-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6b2f50fb47da3baeee10b1906da6e30ac5d26ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/1a42e34104d70b0b90fe074ba96f2c04d33ffb23
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Zhen-Lei/arm64-add-the-printing-of-tpidr_elx-in-__show_regs/20220315-191234
        git checkout 1a42e34104d70b0b90fe074ba96f2c04d33ffb23
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kernel/process.c:220:30: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
                   printk("tpidr : %016lx\n", this_cpu_ptr(NULL));
                                              ^~~~~~~~~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                              ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                                   ^~~~~~~~~~~
   include/linux/percpu-defs.h:252:27: note: expanded from macro 'this_cpu_ptr'
   #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
                             ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:241:2: note: expanded from macro 'raw_cpu_ptr'
           __verify_pcpu_ptr(ptr);                                         \
           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:52: note: expanded from macro '__verify_pcpu_ptr'
           const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
                                                       ~~~~~ ^
>> arch/arm64/kernel/process.c:220:30: warning: format specifies type 'unsigned long' but the argument has type 'typeof (*(((void *)0))) *' (aka 'void *') [-Wformat]
                   printk("tpidr : %016lx\n", this_cpu_ptr(NULL));
                                   ~~~~~~     ^~~~~~~~~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   include/linux/percpu-defs.h:252:27: note: expanded from macro 'this_cpu_ptr'
   #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
                             ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:239:31: note: expanded from macro 'raw_cpu_ptr'
   #define raw_cpu_ptr(ptr)                                                \
                                                                           ^
   2 warnings generated.


vim +220 arch/arm64/kernel/process.c

   200	
   201	void __show_regs(struct pt_regs *regs)
   202	{
   203		int i, top_reg;
   204		u64 lr, sp;
   205	
   206		if (compat_user_mode(regs)) {
   207			lr = regs->compat_lr;
   208			sp = regs->compat_sp;
   209			top_reg = 12;
   210		} else {
   211			lr = regs->regs[30];
   212			sp = regs->sp;
   213			top_reg = 29;
   214		}
   215	
   216		show_regs_print_info(KERN_DEFAULT);
   217		print_pstate(regs);
   218	
   219		if (IS_ENABLED(CONFIG_SMP))
 > 220			printk("tpidr : %016lx\n", this_cpu_ptr(NULL));
   221	
   222		if (!user_mode(regs)) {
   223			printk("pc : %pS\n", (void *)regs->pc);
   224			printk("lr : %pS\n", (void *)ptrauth_strip_insn_pac(lr));
   225		} else {
   226			printk("pc : %016llx\n", regs->pc);
   227			printk("lr : %016llx\n", lr);
   228		}
   229	
   230		printk("sp : %016llx\n", sp);
   231	
   232		if (system_uses_irq_prio_masking())
   233			printk("pmr_save: %08llx\n", regs->pmr_save);
   234	
   235		i = top_reg;
   236	
   237		while (i >= 0) {
   238			printk("x%-2d: %016llx", i, regs->regs[i]);
   239	
   240			while (i-- % 3)
   241				pr_cont(" x%-2d: %016llx", i, regs->regs[i]);
   242	
   243			pr_cont("\n");
   244		}
   245	}
   246	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
