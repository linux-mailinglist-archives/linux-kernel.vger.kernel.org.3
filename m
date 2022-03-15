Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339D34DA447
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 21:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346765AbiCOU53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 16:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238045AbiCOU52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 16:57:28 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A36B4839E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 13:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647377776; x=1678913776;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wcWxfBz7gIpbcf19I34sSPdP/pedEjqYkrqf1/Sz/y8=;
  b=fz2ZdnDVRZidUxm7Av/vhhMo+mvOc2ylRyyuAsx70hAFTFAD6ns+sWz+
   R7+zOiDYFuaMGe7kaxz49wdEFLFF3qqyij1ax7BijAklx7SX6CVHX8mZ6
   4CkKqyFQtILh8Eq0Rn147OIIQCyRJYMxRIrCHA/aY/G6gN7oBC9Y7ct6c
   TLFIph7kNEnfSHr+nqNonXlv3J5biODsZtGgLL1VAA1Rw7UJbgZNEDldP
   ysMBDk+n5q8YoGj4HlOt3uNCc/0UTDd4UmiTfFzSBN40sk7IEQWIOvxtG
   SK2yLceQM1CET51qpmDulChQQ68XlUZxx6IWR/HM728bm/XA7V/D8Hf9Q
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256373652"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="256373652"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 13:56:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="634732935"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Mar 2022 13:56:12 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUEDD-000BVI-Nz; Tue, 15 Mar 2022 20:56:11 +0000
Date:   Wed, 16 Mar 2022 04:55:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Zhen Lei <thunder.leizhen@huawei.com>,
        James Morse <james.morse@arm.com>,
        Christoffer Dall <cdall@linaro.org>
Subject: Re: [PATCH] arm64: add the printing of tpidr_elx in __show_regs()
Message-ID: <202203160439.K5AL4Spr-lkp@intel.com>
References: <20220315110926.1060-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315110926.1060-1-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
config: arm64-randconfig-s032-20220313 (https://download.01.org/0day-ci/archive/20220316/202203160439.K5AL4Spr-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/1a42e34104d70b0b90fe074ba96f2c04d33ffb23
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Zhen-Lei/arm64-add-the-printing-of-tpidr_elx-in-__show_regs/20220315-191234
        git checkout 1a42e34104d70b0b90fe074ba96f2c04d33ffb23
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/arm64/kernel/process.c:220:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void * @@
   arch/arm64/kernel/process.c:220:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/arm64/kernel/process.c:220:17: sparse:     got void *
   arch/arm64/kernel/process.c:437:1: sparse: sparse: symbol '__pcpu_scope___entry_task' was not declared. Should it be static?

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
