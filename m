Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4093350E649
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243656AbiDYQ6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243655AbiDYQ5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:57:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB88638BD8;
        Mon, 25 Apr 2022 09:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650905665; x=1682441665;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JN/SorDXqzvUKBLRtFmcEB8pUjvFWKzz1hmvzpWygFQ=;
  b=cR+o7QycE2UYNwSSGNHwCd7UuBZ0ERDZYpV7nsrrEzoEuppk8JcH4Vs6
   2EsGQh/+dDs0AXzyXCPcwIgga6WwTQWhp1QpNFYWYQtHOahrnRNKoFkOv
   OrGKM3pB9T3Gh8Y4kIqVg1zT0Gm7cVvJlF7ryT386sIaDBpU9hdob0s1f
   RJFT2nexCK8yHK3P1vY+5NbngzNKT7j1px79Lr0tvTCsAkKhnzDWNemo3
   yEXsN+THDCIJgQ9MPruO15p53DX5RLeG0bCOCzk1yg+Ku7wO1Iyf0Z+Mn
   Grtcr+30sfEJE32DcfYsthkRPagrtdy1YxupFYdV1vMIfStYgxsM3InpX
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="245230173"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="245230173"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 09:54:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="729824378"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 25 Apr 2022 09:54:22 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nj1yg-0002iA-7e;
        Mon, 25 Apr 2022 16:54:22 +0000
Date:   Tue, 26 Apr 2022 00:54:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zqiang <qiang1.zhang@intel.com>, paulmck@kernel.org,
        frederic@kernel.org
Cc:     kbuild-all@lists.01.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Add nocb_cb_kthread check to
 rcu_is_callbacks_kthread()
Message-ID: <202204260032.l8IuJNr9-lkp@intel.com>
References: <20220425082309.3328723-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425082309.3328723-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zqiang,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on paulmck-rcu/dev]
[also build test ERROR on v5.18-rc4 next-20220422]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Zqiang/rcu-Add-nocb_cb_kthread-check-to-rcu_is_callbacks_kthread/20220425-162445
base:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
config: arc-randconfig-r015-20220425 (https://download.01.org/0day-ci/archive/20220426/202204260032.l8IuJNr9-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c909d116f928cbb9de2daf60a572f3f8a81cc4f4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Zqiang/rcu-Add-nocb_cb_kthread-check-to-rcu_is_callbacks_kthread/20220425-162445
        git checkout c909d116f928cbb9de2daf60a572f3f8a81cc4f4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/asm-generic/percpu.h:7,
                    from ./arch/arc/include/generated/asm/percpu.h:1,
                    from include/linux/irqflags.h:17,
                    from arch/arc/include/asm/smp.h:102,
                    from arch/arc/include/asm/cmpxchg.h:13,
                    from arch/arc/include/asm/atomic.h:13,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/arc/include/asm/bitops.h:188,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:22,
                    from kernel/rcu/tree.c:21:
   kernel/rcu/tree_plugin.h: In function 'rcu_is_callbacks_kthread':
>> kernel/rcu/tree_plugin.h:1161:41: error: 'struct rcu_data' has no member named 'nocb_cb_kthread'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                                         ^
   include/linux/percpu-defs.h:318:16: note: in definition of macro '__pcpu_size_call_return'
     318 |         typeof(variable) pscr_ret__;                                    \
         |                ^~~~~~~~
   include/linux/percpu-defs.h:446:9: note: in expansion of macro 'raw_cpu_read'
     446 |         raw_cpu_read(pcp);                                              \
         |         ^~~~~~~~~~~~
   kernel/rcu/tree_plugin.h:1161:17: note: in expansion of macro '__this_cpu_read'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                 ^~~~~~~~~~~~~~~
>> kernel/rcu/tree_plugin.h:1161:41: error: 'struct rcu_data' has no member named 'nocb_cb_kthread'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                                         ^
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/percpu-defs.h:420:41: note: in expansion of macro '__pcpu_size_call_return'
     420 | #define raw_cpu_read(pcp)               __pcpu_size_call_return(raw_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:446:9: note: in expansion of macro 'raw_cpu_read'
     446 |         raw_cpu_read(pcp);                                              \
         |         ^~~~~~~~~~~~
   kernel/rcu/tree_plugin.h:1161:17: note: in expansion of macro '__this_cpu_read'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                 ^~~~~~~~~~~~~~~
>> kernel/rcu/tree_plugin.h:1161:41: error: 'struct rcu_data' has no member named 'nocb_cb_kthread'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                                         ^
   include/linux/percpu-defs.h:320:23: note: in definition of macro '__pcpu_size_call_return'
     320 |         switch(sizeof(variable)) {                                      \
         |                       ^~~~~~~~
   include/linux/percpu-defs.h:446:9: note: in expansion of macro 'raw_cpu_read'
     446 |         raw_cpu_read(pcp);                                              \
         |         ^~~~~~~~~~~~
   kernel/rcu/tree_plugin.h:1161:17: note: in expansion of macro '__this_cpu_read'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                 ^~~~~~~~~~~~~~~
>> kernel/rcu/tree_plugin.h:1161:41: error: 'struct rcu_data' has no member named 'nocb_cb_kthread'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                                         ^
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/asm-generic/percpu.h:67:10: note: in expansion of macro 'raw_cpu_ptr'
      67 |         *raw_cpu_ptr(&(pcp));                                           \
         |          ^~~~~~~~~~~
   include/asm-generic/percpu.h:195:41: note: in expansion of macro 'raw_cpu_generic_read'
     195 | #define raw_cpu_read_1(pcp)             raw_cpu_generic_read(pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:321:30: note: in expansion of macro 'raw_cpu_read_1'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:420:41: note: in expansion of macro '__pcpu_size_call_return'
     420 | #define raw_cpu_read(pcp)               __pcpu_size_call_return(raw_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:446:9: note: in expansion of macro 'raw_cpu_read'
     446 |         raw_cpu_read(pcp);                                              \
         |         ^~~~~~~~~~~~
   kernel/rcu/tree_plugin.h:1161:17: note: in expansion of macro '__this_cpu_read'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                 ^~~~~~~~~~~~~~~
   In file included from include/linux/compiler_types.h:93,
                    from <command-line>:
>> kernel/rcu/tree_plugin.h:1161:41: error: 'struct rcu_data' has no member named 'nocb_cb_kthread'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                                         ^
   include/linux/compiler-gcc.h:34:41: note: in definition of macro 'RELOC_HIDE'
      34 |         __asm__ ("" : "=r"(__ptr) : "0"(ptr));                          \
         |                                         ^~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
      44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
         |                               ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
     242 |         arch_raw_cpu_ptr(ptr);                                          \
         |         ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:67:10: note: in expansion of macro 'raw_cpu_ptr'
      67 |         *raw_cpu_ptr(&(pcp));                                           \
         |          ^~~~~~~~~~~
   include/asm-generic/percpu.h:195:41: note: in expansion of macro 'raw_cpu_generic_read'
     195 | #define raw_cpu_read_1(pcp)             raw_cpu_generic_read(pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:321:30: note: in expansion of macro 'raw_cpu_read_1'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:420:41: note: in expansion of macro '__pcpu_size_call_return'
     420 | #define raw_cpu_read(pcp)               __pcpu_size_call_return(raw_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:446:9: note: in expansion of macro 'raw_cpu_read'
     446 |         raw_cpu_read(pcp);                                              \
         |         ^~~~~~~~~~~~
   kernel/rcu/tree_plugin.h:1161:17: note: in expansion of macro '__this_cpu_read'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                 ^~~~~~~~~~~~~~~
>> kernel/rcu/tree_plugin.h:1161:41: error: 'struct rcu_data' has no member named 'nocb_cb_kthread'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                                         ^
   include/linux/compiler-gcc.h:34:41: note: in definition of macro 'RELOC_HIDE'
      34 |         __asm__ ("" : "=r"(__ptr) : "0"(ptr));                          \
         |                                         ^~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
      44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
         |                               ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
     242 |         arch_raw_cpu_ptr(ptr);                                          \
         |         ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:67:10: note: in expansion of macro 'raw_cpu_ptr'
      67 |         *raw_cpu_ptr(&(pcp));                                           \
         |          ^~~~~~~~~~~
   include/asm-generic/percpu.h:195:41: note: in expansion of macro 'raw_cpu_generic_read'
     195 | #define raw_cpu_read_1(pcp)             raw_cpu_generic_read(pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:321:30: note: in expansion of macro 'raw_cpu_read_1'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:420:41: note: in expansion of macro '__pcpu_size_call_return'
     420 | #define raw_cpu_read(pcp)               __pcpu_size_call_return(raw_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:446:9: note: in expansion of macro 'raw_cpu_read'
     446 |         raw_cpu_read(pcp);                                              \
         |         ^~~~~~~~~~~~
   kernel/rcu/tree_plugin.h:1161:17: note: in expansion of macro '__this_cpu_read'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                 ^~~~~~~~~~~~~~~
>> kernel/rcu/tree_plugin.h:1161:41: error: 'struct rcu_data' has no member named 'nocb_cb_kthread'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                                         ^
   include/linux/compiler-gcc.h:35:17: note: in definition of macro 'RELOC_HIDE'
      35 |         (typeof(ptr)) (__ptr + (off));                                  \
         |                 ^~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
      44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
         |                               ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
     242 |         arch_raw_cpu_ptr(ptr);                                          \
         |         ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:67:10: note: in expansion of macro 'raw_cpu_ptr'
      67 |         *raw_cpu_ptr(&(pcp));                                           \
         |          ^~~~~~~~~~~
   include/asm-generic/percpu.h:195:41: note: in expansion of macro 'raw_cpu_generic_read'
     195 | #define raw_cpu_read_1(pcp)             raw_cpu_generic_read(pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:321:30: note: in expansion of macro 'raw_cpu_read_1'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:420:41: note: in expansion of macro '__pcpu_size_call_return'
     420 | #define raw_cpu_read(pcp)               __pcpu_size_call_return(raw_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:446:9: note: in expansion of macro 'raw_cpu_read'
     446 |         raw_cpu_read(pcp);                                              \
         |         ^~~~~~~~~~~~
   kernel/rcu/tree_plugin.h:1161:17: note: in expansion of macro '__this_cpu_read'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                 ^~~~~~~~~~~~~~~
>> kernel/rcu/tree_plugin.h:1161:41: error: 'struct rcu_data' has no member named 'nocb_cb_kthread'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                                         ^
   include/linux/compiler-gcc.h:35:17: note: in definition of macro 'RELOC_HIDE'
      35 |         (typeof(ptr)) (__ptr + (off));                                  \
         |                 ^~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
      44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
         |                               ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
     242 |         arch_raw_cpu_ptr(ptr);                                          \
         |         ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:67:10: note: in expansion of macro 'raw_cpu_ptr'
      67 |         *raw_cpu_ptr(&(pcp));                                           \
         |          ^~~~~~~~~~~
   include/asm-generic/percpu.h:195:41: note: in expansion of macro 'raw_cpu_generic_read'
     195 | #define raw_cpu_read_1(pcp)             raw_cpu_generic_read(pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:321:30: note: in expansion of macro 'raw_cpu_read_1'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:420:41: note: in expansion of macro '__pcpu_size_call_return'
     420 | #define raw_cpu_read(pcp)               __pcpu_size_call_return(raw_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:446:9: note: in expansion of macro 'raw_cpu_read'
     446 |         raw_cpu_read(pcp);                                              \
         |         ^~~~~~~~~~~~
   kernel/rcu/tree_plugin.h:1161:17: note: in expansion of macro '__this_cpu_read'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                 ^~~~~~~~~~~~~~~
   In file included from include/asm-generic/percpu.h:7,
                    from ./arch/arc/include/generated/asm/percpu.h:1,
                    from include/linux/irqflags.h:17,
                    from arch/arc/include/asm/smp.h:102,
                    from arch/arc/include/asm/cmpxchg.h:13,
                    from arch/arc/include/asm/atomic.h:13,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/arc/include/asm/bitops.h:188,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:22,
                    from kernel/rcu/tree.c:21:
>> kernel/rcu/tree_plugin.h:1161:41: error: 'struct rcu_data' has no member named 'nocb_cb_kthread'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                                         ^
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/asm-generic/percpu.h:67:10: note: in expansion of macro 'raw_cpu_ptr'
      67 |         *raw_cpu_ptr(&(pcp));                                           \
         |          ^~~~~~~~~~~
   include/asm-generic/percpu.h:198:41: note: in expansion of macro 'raw_cpu_generic_read'
     198 | #define raw_cpu_read_2(pcp)             raw_cpu_generic_read(pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:322:30: note: in expansion of macro 'raw_cpu_read_2'
     322 |         case 2: pscr_ret__ = stem##2(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:420:41: note: in expansion of macro '__pcpu_size_call_return'
     420 | #define raw_cpu_read(pcp)               __pcpu_size_call_return(raw_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:446:9: note: in expansion of macro 'raw_cpu_read'
     446 |         raw_cpu_read(pcp);                                              \
         |         ^~~~~~~~~~~~
   kernel/rcu/tree_plugin.h:1161:17: note: in expansion of macro '__this_cpu_read'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                 ^~~~~~~~~~~~~~~
   In file included from include/linux/compiler_types.h:93,
                    from <command-line>:
>> kernel/rcu/tree_plugin.h:1161:41: error: 'struct rcu_data' has no member named 'nocb_cb_kthread'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                                         ^
   include/linux/compiler-gcc.h:34:41: note: in definition of macro 'RELOC_HIDE'
      34 |         __asm__ ("" : "=r"(__ptr) : "0"(ptr));                          \
         |                                         ^~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
      44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
         |                               ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
     242 |         arch_raw_cpu_ptr(ptr);                                          \
         |         ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:67:10: note: in expansion of macro 'raw_cpu_ptr'
      67 |         *raw_cpu_ptr(&(pcp));                                           \
         |          ^~~~~~~~~~~
   include/asm-generic/percpu.h:198:41: note: in expansion of macro 'raw_cpu_generic_read'
     198 | #define raw_cpu_read_2(pcp)             raw_cpu_generic_read(pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:322:30: note: in expansion of macro 'raw_cpu_read_2'
     322 |         case 2: pscr_ret__ = stem##2(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:420:41: note: in expansion of macro '__pcpu_size_call_return'
     420 | #define raw_cpu_read(pcp)               __pcpu_size_call_return(raw_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:446:9: note: in expansion of macro 'raw_cpu_read'
     446 |         raw_cpu_read(pcp);                                              \
         |         ^~~~~~~~~~~~
   kernel/rcu/tree_plugin.h:1161:17: note: in expansion of macro '__this_cpu_read'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                 ^~~~~~~~~~~~~~~
>> kernel/rcu/tree_plugin.h:1161:41: error: 'struct rcu_data' has no member named 'nocb_cb_kthread'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                                         ^
   include/linux/compiler-gcc.h:34:41: note: in definition of macro 'RELOC_HIDE'
      34 |         __asm__ ("" : "=r"(__ptr) : "0"(ptr));                          \
         |                                         ^~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
      44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
         |                               ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
     242 |         arch_raw_cpu_ptr(ptr);                                          \
         |         ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:67:10: note: in expansion of macro 'raw_cpu_ptr'
      67 |         *raw_cpu_ptr(&(pcp));                                           \
         |          ^~~~~~~~~~~
   include/asm-generic/percpu.h:198:41: note: in expansion of macro 'raw_cpu_generic_read'
     198 | #define raw_cpu_read_2(pcp)             raw_cpu_generic_read(pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:322:30: note: in expansion of macro 'raw_cpu_read_2'
     322 |         case 2: pscr_ret__ = stem##2(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:420:41: note: in expansion of macro '__pcpu_size_call_return'
     420 | #define raw_cpu_read(pcp)               __pcpu_size_call_return(raw_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:446:9: note: in expansion of macro 'raw_cpu_read'
     446 |         raw_cpu_read(pcp);                                              \
         |         ^~~~~~~~~~~~
   kernel/rcu/tree_plugin.h:1161:17: note: in expansion of macro '__this_cpu_read'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                 ^~~~~~~~~~~~~~~
>> kernel/rcu/tree_plugin.h:1161:41: error: 'struct rcu_data' has no member named 'nocb_cb_kthread'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                                         ^
   include/linux/compiler-gcc.h:35:17: note: in definition of macro 'RELOC_HIDE'
      35 |         (typeof(ptr)) (__ptr + (off));                                  \
         |                 ^~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
      44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
         |                               ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
     242 |         arch_raw_cpu_ptr(ptr);                                          \
         |         ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:67:10: note: in expansion of macro 'raw_cpu_ptr'
      67 |         *raw_cpu_ptr(&(pcp));                                           \
         |          ^~~~~~~~~~~
   include/asm-generic/percpu.h:198:41: note: in expansion of macro 'raw_cpu_generic_read'
     198 | #define raw_cpu_read_2(pcp)             raw_cpu_generic_read(pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:322:30: note: in expansion of macro 'raw_cpu_read_2'
     322 |         case 2: pscr_ret__ = stem##2(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:420:41: note: in expansion of macro '__pcpu_size_call_return'
     420 | #define raw_cpu_read(pcp)               __pcpu_size_call_return(raw_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:446:9: note: in expansion of macro 'raw_cpu_read'
     446 |         raw_cpu_read(pcp);                                              \
         |         ^~~~~~~~~~~~
   kernel/rcu/tree_plugin.h:1161:17: note: in expansion of macro '__this_cpu_read'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                 ^~~~~~~~~~~~~~~
>> kernel/rcu/tree_plugin.h:1161:41: error: 'struct rcu_data' has no member named 'nocb_cb_kthread'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                                         ^
   include/linux/compiler-gcc.h:35:17: note: in definition of macro 'RELOC_HIDE'
      35 |         (typeof(ptr)) (__ptr + (off));                                  \
         |                 ^~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
      44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
         |                               ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
     242 |         arch_raw_cpu_ptr(ptr);                                          \
         |         ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:67:10: note: in expansion of macro 'raw_cpu_ptr'
      67 |         *raw_cpu_ptr(&(pcp));                                           \
         |          ^~~~~~~~~~~
   include/asm-generic/percpu.h:198:41: note: in expansion of macro 'raw_cpu_generic_read'
     198 | #define raw_cpu_read_2(pcp)             raw_cpu_generic_read(pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:322:30: note: in expansion of macro 'raw_cpu_read_2'
     322 |         case 2: pscr_ret__ = stem##2(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:420:41: note: in expansion of macro '__pcpu_size_call_return'
     420 | #define raw_cpu_read(pcp)               __pcpu_size_call_return(raw_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:446:9: note: in expansion of macro 'raw_cpu_read'
     446 |         raw_cpu_read(pcp);                                              \
         |         ^~~~~~~~~~~~
   kernel/rcu/tree_plugin.h:1161:17: note: in expansion of macro '__this_cpu_read'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                 ^~~~~~~~~~~~~~~
   In file included from include/asm-generic/percpu.h:7,
                    from ./arch/arc/include/generated/asm/percpu.h:1,
                    from include/linux/irqflags.h:17,
                    from arch/arc/include/asm/smp.h:102,
                    from arch/arc/include/asm/cmpxchg.h:13,
                    from arch/arc/include/asm/atomic.h:13,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/arc/include/asm/bitops.h:188,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:22,
                    from kernel/rcu/tree.c:21:
>> kernel/rcu/tree_plugin.h:1161:41: error: 'struct rcu_data' has no member named 'nocb_cb_kthread'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                                         ^
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/asm-generic/percpu.h:67:10: note: in expansion of macro 'raw_cpu_ptr'
      67 |         *raw_cpu_ptr(&(pcp));                                           \
         |          ^~~~~~~~~~~
   include/asm-generic/percpu.h:201:41: note: in expansion of macro 'raw_cpu_generic_read'
     201 | #define raw_cpu_read_4(pcp)             raw_cpu_generic_read(pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:323:30: note: in expansion of macro 'raw_cpu_read_4'
     323 |         case 4: pscr_ret__ = stem##4(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:420:41: note: in expansion of macro '__pcpu_size_call_return'
     420 | #define raw_cpu_read(pcp)               __pcpu_size_call_return(raw_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:446:9: note: in expansion of macro 'raw_cpu_read'
     446 |         raw_cpu_read(pcp);                                              \
         |         ^~~~~~~~~~~~
   kernel/rcu/tree_plugin.h:1161:17: note: in expansion of macro '__this_cpu_read'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                 ^~~~~~~~~~~~~~~
   In file included from include/linux/compiler_types.h:93,
                    from <command-line>:
>> kernel/rcu/tree_plugin.h:1161:41: error: 'struct rcu_data' has no member named 'nocb_cb_kthread'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                                         ^
   include/linux/compiler-gcc.h:34:41: note: in definition of macro 'RELOC_HIDE'
      34 |         __asm__ ("" : "=r"(__ptr) : "0"(ptr));                          \
         |                                         ^~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
      44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
         |                               ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
     242 |         arch_raw_cpu_ptr(ptr);                                          \
         |         ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:67:10: note: in expansion of macro 'raw_cpu_ptr'
      67 |         *raw_cpu_ptr(&(pcp));                                           \
         |          ^~~~~~~~~~~
   include/asm-generic/percpu.h:201:41: note: in expansion of macro 'raw_cpu_generic_read'
     201 | #define raw_cpu_read_4(pcp)             raw_cpu_generic_read(pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:323:30: note: in expansion of macro 'raw_cpu_read_4'
     323 |         case 4: pscr_ret__ = stem##4(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:420:41: note: in expansion of macro '__pcpu_size_call_return'
     420 | #define raw_cpu_read(pcp)               __pcpu_size_call_return(raw_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:446:9: note: in expansion of macro 'raw_cpu_read'
     446 |         raw_cpu_read(pcp);                                              \
         |         ^~~~~~~~~~~~
   kernel/rcu/tree_plugin.h:1161:17: note: in expansion of macro '__this_cpu_read'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                 ^~~~~~~~~~~~~~~
>> kernel/rcu/tree_plugin.h:1161:41: error: 'struct rcu_data' has no member named 'nocb_cb_kthread'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                                         ^
   include/linux/compiler-gcc.h:34:41: note: in definition of macro 'RELOC_HIDE'
      34 |         __asm__ ("" : "=r"(__ptr) : "0"(ptr));                          \
         |                                         ^~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
      44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
         |                               ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
     242 |         arch_raw_cpu_ptr(ptr);                                          \
         |         ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:67:10: note: in expansion of macro 'raw_cpu_ptr'
      67 |         *raw_cpu_ptr(&(pcp));                                           \
         |          ^~~~~~~~~~~
   include/asm-generic/percpu.h:201:41: note: in expansion of macro 'raw_cpu_generic_read'
     201 | #define raw_cpu_read_4(pcp)             raw_cpu_generic_read(pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:323:30: note: in expansion of macro 'raw_cpu_read_4'
     323 |         case 4: pscr_ret__ = stem##4(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:420:41: note: in expansion of macro '__pcpu_size_call_return'
     420 | #define raw_cpu_read(pcp)               __pcpu_size_call_return(raw_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:446:9: note: in expansion of macro 'raw_cpu_read'
     446 |         raw_cpu_read(pcp);                                              \
         |         ^~~~~~~~~~~~
   kernel/rcu/tree_plugin.h:1161:17: note: in expansion of macro '__this_cpu_read'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                 ^~~~~~~~~~~~~~~
>> kernel/rcu/tree_plugin.h:1161:41: error: 'struct rcu_data' has no member named 'nocb_cb_kthread'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                                         ^
   include/linux/compiler-gcc.h:35:17: note: in definition of macro 'RELOC_HIDE'
      35 |         (typeof(ptr)) (__ptr + (off));                                  \
         |                 ^~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
      44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
         |                               ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
     242 |         arch_raw_cpu_ptr(ptr);                                          \
         |         ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:67:10: note: in expansion of macro 'raw_cpu_ptr'
      67 |         *raw_cpu_ptr(&(pcp));                                           \
         |          ^~~~~~~~~~~
   include/asm-generic/percpu.h:201:41: note: in expansion of macro 'raw_cpu_generic_read'
     201 | #define raw_cpu_read_4(pcp)             raw_cpu_generic_read(pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:323:30: note: in expansion of macro 'raw_cpu_read_4'
     323 |         case 4: pscr_ret__ = stem##4(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:420:41: note: in expansion of macro '__pcpu_size_call_return'
     420 | #define raw_cpu_read(pcp)               __pcpu_size_call_return(raw_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:446:9: note: in expansion of macro 'raw_cpu_read'
     446 |         raw_cpu_read(pcp);                                              \
         |         ^~~~~~~~~~~~
   kernel/rcu/tree_plugin.h:1161:17: note: in expansion of macro '__this_cpu_read'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                 ^~~~~~~~~~~~~~~
>> kernel/rcu/tree_plugin.h:1161:41: error: 'struct rcu_data' has no member named 'nocb_cb_kthread'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                                         ^
   include/linux/compiler-gcc.h:35:17: note: in definition of macro 'RELOC_HIDE'
      35 |         (typeof(ptr)) (__ptr + (off));                                  \
         |                 ^~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
      44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
         |                               ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
     242 |         arch_raw_cpu_ptr(ptr);                                          \
         |         ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:67:10: note: in expansion of macro 'raw_cpu_ptr'
      67 |         *raw_cpu_ptr(&(pcp));                                           \
         |          ^~~~~~~~~~~
   include/asm-generic/percpu.h:201:41: note: in expansion of macro 'raw_cpu_generic_read'
     201 | #define raw_cpu_read_4(pcp)             raw_cpu_generic_read(pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:323:30: note: in expansion of macro 'raw_cpu_read_4'
     323 |         case 4: pscr_ret__ = stem##4(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:420:41: note: in expansion of macro '__pcpu_size_call_return'
     420 | #define raw_cpu_read(pcp)               __pcpu_size_call_return(raw_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:446:9: note: in expansion of macro 'raw_cpu_read'
     446 |         raw_cpu_read(pcp);                                              \
         |         ^~~~~~~~~~~~
   kernel/rcu/tree_plugin.h:1161:17: note: in expansion of macro '__this_cpu_read'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                 ^~~~~~~~~~~~~~~
   In file included from include/asm-generic/percpu.h:7,
                    from ./arch/arc/include/generated/asm/percpu.h:1,
                    from include/linux/irqflags.h:17,
                    from arch/arc/include/asm/smp.h:102,
                    from arch/arc/include/asm/cmpxchg.h:13,
                    from arch/arc/include/asm/atomic.h:13,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/arc/include/asm/bitops.h:188,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:22,
                    from kernel/rcu/tree.c:21:
>> kernel/rcu/tree_plugin.h:1161:41: error: 'struct rcu_data' has no member named 'nocb_cb_kthread'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                                         ^
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/asm-generic/percpu.h:67:10: note: in expansion of macro 'raw_cpu_ptr'
      67 |         *raw_cpu_ptr(&(pcp));                                           \
         |          ^~~~~~~~~~~
   include/asm-generic/percpu.h:204:41: note: in expansion of macro 'raw_cpu_generic_read'
     204 | #define raw_cpu_read_8(pcp)             raw_cpu_generic_read(pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:324:30: note: in expansion of macro 'raw_cpu_read_8'
     324 |         case 8: pscr_ret__ = stem##8(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:420:41: note: in expansion of macro '__pcpu_size_call_return'
     420 | #define raw_cpu_read(pcp)               __pcpu_size_call_return(raw_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:446:9: note: in expansion of macro 'raw_cpu_read'
     446 |         raw_cpu_read(pcp);                                              \
         |         ^~~~~~~~~~~~
   kernel/rcu/tree_plugin.h:1161:17: note: in expansion of macro '__this_cpu_read'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                 ^~~~~~~~~~~~~~~
   In file included from include/linux/compiler_types.h:93,
                    from <command-line>:
>> kernel/rcu/tree_plugin.h:1161:41: error: 'struct rcu_data' has no member named 'nocb_cb_kthread'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                                         ^
   include/linux/compiler-gcc.h:34:41: note: in definition of macro 'RELOC_HIDE'
      34 |         __asm__ ("" : "=r"(__ptr) : "0"(ptr));                          \
         |                                         ^~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
      44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
         |                               ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
     242 |         arch_raw_cpu_ptr(ptr);                                          \
         |         ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:67:10: note: in expansion of macro 'raw_cpu_ptr'
      67 |         *raw_cpu_ptr(&(pcp));                                           \
         |          ^~~~~~~~~~~
   include/asm-generic/percpu.h:204:41: note: in expansion of macro 'raw_cpu_generic_read'
     204 | #define raw_cpu_read_8(pcp)             raw_cpu_generic_read(pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:324:30: note: in expansion of macro 'raw_cpu_read_8'
     324 |         case 8: pscr_ret__ = stem##8(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:420:41: note: in expansion of macro '__pcpu_size_call_return'
     420 | #define raw_cpu_read(pcp)               __pcpu_size_call_return(raw_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:446:9: note: in expansion of macro 'raw_cpu_read'
     446 |         raw_cpu_read(pcp);                                              \
         |         ^~~~~~~~~~~~
   kernel/rcu/tree_plugin.h:1161:17: note: in expansion of macro '__this_cpu_read'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                 ^~~~~~~~~~~~~~~
   kernel/rcu/tree_plugin.h:1161:41: error: 'struct rcu_data' has no member named 'nocb_cb_kthread'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                                         ^
   include/linux/compiler-gcc.h:34:41: note: in definition of macro 'RELOC_HIDE'
      34 |         __asm__ ("" : "=r"(__ptr) : "0"(ptr));                          \
         |                                         ^~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
      44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
         |                               ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
     242 |         arch_raw_cpu_ptr(ptr);                                          \
         |         ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:67:10: note: in expansion of macro 'raw_cpu_ptr'
      67 |         *raw_cpu_ptr(&(pcp));                                           \
         |          ^~~~~~~~~~~
   include/asm-generic/percpu.h:204:41: note: in expansion of macro 'raw_cpu_generic_read'
     204 | #define raw_cpu_read_8(pcp)             raw_cpu_generic_read(pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:324:30: note: in expansion of macro 'raw_cpu_read_8'
     324 |         case 8: pscr_ret__ = stem##8(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:420:41: note: in expansion of macro '__pcpu_size_call_return'
     420 | #define raw_cpu_read(pcp)               __pcpu_size_call_return(raw_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:446:9: note: in expansion of macro 'raw_cpu_read'
     446 |         raw_cpu_read(pcp);                                              \
         |         ^~~~~~~~~~~~
   kernel/rcu/tree_plugin.h:1161:17: note: in expansion of macro '__this_cpu_read'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                 ^~~~~~~~~~~~~~~
   kernel/rcu/tree_plugin.h:1161:41: error: 'struct rcu_data' has no member named 'nocb_cb_kthread'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                                         ^
   include/linux/compiler-gcc.h:35:17: note: in definition of macro 'RELOC_HIDE'
      35 |         (typeof(ptr)) (__ptr + (off));                                  \
         |                 ^~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
      44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
         |                               ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
     242 |         arch_raw_cpu_ptr(ptr);                                          \
         |         ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:67:10: note: in expansion of macro 'raw_cpu_ptr'
      67 |         *raw_cpu_ptr(&(pcp));                                           \
         |          ^~~~~~~~~~~
   include/asm-generic/percpu.h:204:41: note: in expansion of macro 'raw_cpu_generic_read'
     204 | #define raw_cpu_read_8(pcp)             raw_cpu_generic_read(pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:324:30: note: in expansion of macro 'raw_cpu_read_8'
     324 |         case 8: pscr_ret__ = stem##8(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:420:41: note: in expansion of macro '__pcpu_size_call_return'
     420 | #define raw_cpu_read(pcp)               __pcpu_size_call_return(raw_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:446:9: note: in expansion of macro 'raw_cpu_read'
     446 |         raw_cpu_read(pcp);                                              \
         |         ^~~~~~~~~~~~
   kernel/rcu/tree_plugin.h:1161:17: note: in expansion of macro '__this_cpu_read'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                 ^~~~~~~~~~~~~~~
   kernel/rcu/tree_plugin.h:1161:41: error: 'struct rcu_data' has no member named 'nocb_cb_kthread'
    1161 |                 __this_cpu_read(rcu_data.nocb_cb_kthread) == current;
         |                                         ^
   include/linux/compiler-gcc.h:35:17: note: in definition of macro 'RELOC_HIDE'
      35 |         (typeof(ptr)) (__ptr + (off));                                  \
         |                 ^~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
      44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
         |                               ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
     242 |         arch_raw_cpu_ptr(ptr);                                          \


vim +1161 kernel/rcu/tree_plugin.h

  1153	
  1154	/*
  1155	 * Is the current CPU running the RCU-callbacks kthread?
  1156	 * Caller must have preemption disabled.
  1157	 */
  1158	static bool rcu_is_callbacks_kthread(void)
  1159	{
  1160		return __this_cpu_read(rcu_data.rcu_cpu_kthread_task) == current ||
> 1161			__this_cpu_read(rcu_data.nocb_cb_kthread) == current;
  1162	}
  1163	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
