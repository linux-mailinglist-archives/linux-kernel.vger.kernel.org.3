Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15694E6222
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 12:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345652AbiCXLLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 07:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240042AbiCXLLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 07:11:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A77F381B0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 04:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648120179; x=1679656179;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=88Y7nd8cX7T1WR9HjlQBgeq9aRByaJ+VG3TomndjrcQ=;
  b=NM6Qf4jDxbTyXaxz94Ay7dwyIeEvlI7Vxd6kJ7FUSoW1jDiVFO6so+l3
   Pb0oNu2W1STIO6DHOvAuWAizl5kQUwytO4UB25Gqy2VG3BTFs+H1d4Gua
   //ptFjVdMMH10bKHnvDllIgH23FbzaaSGffkmUIk2H0/RjeCscnUjUwqr
   8+bSDgkCEvq5gVCP987EU78KYrB+Zln+5Jv2SS63RsItbmZqMeuqpAWFe
   70YiHT4BBXpL+CMP74rdlze2qz3gQdDZwIQBplIti8jdvxQCcWfpdIdZu
   uKB0mTqxAagTACuRHHAGvMTIYyYsJZRRqYQJ+hW75NGkCty71ze3VxnKS
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="344780473"
X-IronPort-AV: E=Sophos;i="5.90,207,1643702400"; 
   d="scan'208";a="344780473"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 04:09:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,207,1643702400"; 
   d="scan'208";a="584040294"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 24 Mar 2022 04:09:34 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXLLR-000L0h-OF; Thu, 24 Mar 2022 11:09:33 +0000
Date:   Thu, 24 Mar 2022 19:08:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Mark Rutland <mark.rutland@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] arm64, scs: save scs_sp values per-cpu when
 switching stacks
Message-ID: <202203241922.UDw4JHPD-lkp@intel.com>
References: <f75c58b17bfaa419f84286cd174e3a08f971b779.1648049113.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f75c58b17bfaa419f84286cd174e3a08f971b779.1648049113.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I love your patch! Yet something to improve:

[auto build test ERROR on next-20220323]
[also build test ERROR on v5.17]
[cannot apply to arm64/for-next/core hnaz-mm/master linus/master v5.17 v5.17-rc8 v5.17-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/andrey-konovalov-linux-dev/kasan-arm64-scs-stacktrace-collect-stack-traces-from-Shadow-Call-Stack/20220323-233436
base:    b61581ae229d8eb9f21f8753be3f4011f7692384
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20220324/202203241922.UDw4JHPD-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/da5bedb1ac7aa0b303f6d996d306e675860b6e12
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review andrey-konovalov-linux-dev/kasan-arm64-scs-stacktrace-collect-stack-traces-from-Shadow-Call-Stack/20220323-233436
        git checkout da5bedb1ac7aa0b303f6d996d306e675860b6e12
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/percpu.h:7,
                    from arch/arm64/include/asm/percpu.h:248,
                    from include/linux/irqflags.h:17,
                    from include/linux/spinlock.h:58,
                    from include/linux/irq.h:14,
                    from arch/arm64/kernel/irq.c:13:
   arch/arm64/kernel/irq.c: In function 'init_irq_scs':
>> arch/arm64/kernel/irq.c:44:25: error: 'irq_shadow_call_stack_ptr' undeclared (first use in this function)
      44 |                 per_cpu(irq_shadow_call_stack_ptr, cpu) =
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/percpu-defs.h:269:35: note: in expansion of macro 'per_cpu_ptr'
     269 | #define per_cpu(var, cpu)       (*per_cpu_ptr(&(var), cpu))
         |                                   ^~~~~~~~~~~
   arch/arm64/kernel/irq.c:44:17: note: in expansion of macro 'per_cpu'
      44 |                 per_cpu(irq_shadow_call_stack_ptr, cpu) =
         |                 ^~~~~~~
   arch/arm64/kernel/irq.c:44:25: note: each undeclared identifier is reported only once for each function it appears in
      44 |                 per_cpu(irq_shadow_call_stack_ptr, cpu) =
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/percpu-defs.h:269:35: note: in expansion of macro 'per_cpu_ptr'
     269 | #define per_cpu(var, cpu)       (*per_cpu_ptr(&(var), cpu))
         |                                   ^~~~~~~~~~~
   arch/arm64/kernel/irq.c:44:17: note: in expansion of macro 'per_cpu'
      44 |                 per_cpu(irq_shadow_call_stack_ptr, cpu) =
         |                 ^~~~~~~
   arch/arm64/kernel/irq.c: At top level:
   arch/arm64/kernel/irq.c:105:13: warning: no previous prototype for 'init_IRQ' [-Wmissing-prototypes]
     105 | void __init init_IRQ(void)
         |             ^~~~~~~~


vim +/irq_shadow_call_stack_ptr +44 arch/arm64/kernel/irq.c

ac20ffbb0279aa Sami Tolvanen 2020-11-30  35  
ac20ffbb0279aa Sami Tolvanen 2020-11-30  36  static void init_irq_scs(void)
ac20ffbb0279aa Sami Tolvanen 2020-11-30  37  {
ac20ffbb0279aa Sami Tolvanen 2020-11-30  38  	int cpu;
ac20ffbb0279aa Sami Tolvanen 2020-11-30  39  
ac20ffbb0279aa Sami Tolvanen 2020-11-30  40  	if (!IS_ENABLED(CONFIG_SHADOW_CALL_STACK))
ac20ffbb0279aa Sami Tolvanen 2020-11-30  41  		return;
ac20ffbb0279aa Sami Tolvanen 2020-11-30  42  
ac20ffbb0279aa Sami Tolvanen 2020-11-30  43  	for_each_possible_cpu(cpu)
ac20ffbb0279aa Sami Tolvanen 2020-11-30 @44  		per_cpu(irq_shadow_call_stack_ptr, cpu) =
ac20ffbb0279aa Sami Tolvanen 2020-11-30  45  			scs_alloc(cpu_to_node(cpu));
ac20ffbb0279aa Sami Tolvanen 2020-11-30  46  }
ac20ffbb0279aa Sami Tolvanen 2020-11-30  47  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
