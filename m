Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4387052E0FB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 02:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343874AbiETAI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 20:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343871AbiETAIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 20:08:52 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED727954A4
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653005331; x=1684541331;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s/7KsvPeNMDurF3yxYHUVMVVAiSrGckgpPPLCAkESf8=;
  b=hA5V7IrJMGsBLpMJmNP5LMzSXdua2EvVlGG2xCHLFTw9hBzhjMxxayhm
   s5zAxb9gtXB+QzWjAO8lJ3P+Vf+7v22ZCWpZ2jiZwyoituK7e2jEryd99
   jCjNwVZmRlQksVcERz2/uEFdNtUKcCgYBV4Tw8DLDKA0QJUeAeyA0o2zQ
   6UyPfjuQis+LN8E7cSDDkWiZWfK9tN30aCoenevy4ZKz1KFgMP4MIASyU
   yQM2+Eo4OkJlNNdffA9KNmxk6PLg7yUaIhJrsS38RodQP44o6z3R5X6Lb
   jC0GBiLnHI1HDeCAu1ShsD3id7XOkPc/Oacl/RtksLJZSaxVXnwbJyPig
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="260003196"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="260003196"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 17:08:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="743203165"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 19 May 2022 17:08:47 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrqCE-00044d-Q7;
        Fri, 20 May 2022 00:08:46 +0000
Date:   Fri, 20 May 2022 08:08:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>
Cc:     kbuild-all@lists.01.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v3 2/2] riscv: turn pgtable_l4|[l5]_enabled to static key
 for RV64
Message-ID: <202205200851.XPf3TixK-lkp@intel.com>
References: <20220519155918.3882-3-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519155918.3882-3-jszhang@kernel.org>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.18-rc7]
[cannot apply to next-20220519]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Jisheng-Zhang/use-static-key-to-optimize-pgtable_l4_enabled/20220520-001459
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git f993aed406eaf968ba3867a76bb46c95336a33d0
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20220520/202205200851.XPf3TixK-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d052c69ebaf48ac2925d6f9fa033d9e394da1074
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jisheng-Zhang/use-static-key-to-optimize-pgtable_l4_enabled/20220520-001459
        git checkout d052c69ebaf48ac2925d6f9fa033d9e394da1074
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/riscv/include/asm/pgtable.h:112,
                    from arch/riscv/include/asm/uaccess.h:12,
                    from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from fs/char_dev.c:9:
   arch/riscv/include/asm/pgtable-64.h: In function 'pgtable_l5_enabled':
>> arch/riscv/include/asm/pgtable-64.h:19:13: error: implicit declaration of function 'static_branch_likely' [-Werror=implicit-function-declaration]
      19 |         if (static_branch_likely(&_pgtable_lx_ready))
         |             ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from arch/riscv/include/asm/pgtable.h:112,
                    from arch/riscv/include/asm/uaccess.h:12,
                    from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/uapi/linux/aio_abi.h:31,
                    from include/linux/syscalls.h:77,
                    from fs/d_path.c:2:
   arch/riscv/include/asm/pgtable-64.h: In function 'pgtable_l5_enabled':
>> arch/riscv/include/asm/pgtable-64.h:19:13: error: implicit declaration of function 'static_branch_likely' [-Werror=implicit-function-declaration]
      19 |         if (static_branch_likely(&_pgtable_lx_ready))
         |             ^~~~~~~~~~~~~~~~~~~~
   fs/d_path.c: At top level:
   fs/d_path.c:318:7: warning: no previous prototype for 'simple_dname' [-Wmissing-prototypes]
     318 | char *simple_dname(struct dentry *dentry, char *buffer, int buflen)
         |       ^~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from arch/riscv/include/asm/pgtable.h:112,
                    from arch/riscv/include/asm/uaccess.h:12,
                    from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/uapi/linux/aio_abi.h:31,
                    from include/linux/syscalls.h:77,
                    from fs/io_uring.c:45:
   arch/riscv/include/asm/pgtable-64.h: In function 'pgtable_l5_enabled':
>> arch/riscv/include/asm/pgtable-64.h:19:13: error: implicit declaration of function 'static_branch_likely' [-Werror=implicit-function-declaration]
      19 |         if (static_branch_likely(&_pgtable_lx_ready))
         |             ^~~~~~~~~~~~~~~~~~~~
   fs/io_uring.c: In function '__io_submit_flush_completions':
   fs/io_uring.c:2660:40: warning: variable 'prev' set but not used [-Wunused-but-set-variable]
    2660 |         struct io_wq_work_node *node, *prev;
         |                                        ^~~~
   cc1: some warnings being treated as errors
--
   In file included from arch/riscv/include/asm/pgtable.h:112,
                    from arch/riscv/include/asm/uaccess.h:12,
                    from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from fs/proc/meminfo.c:2:
   arch/riscv/include/asm/pgtable-64.h: In function 'pgtable_l5_enabled':
>> arch/riscv/include/asm/pgtable-64.h:19:13: error: implicit declaration of function 'static_branch_likely' [-Werror=implicit-function-declaration]
      19 |         if (static_branch_likely(&_pgtable_lx_ready))
         |             ^~~~~~~~~~~~~~~~~~~~
   fs/proc/meminfo.c: At top level:
   fs/proc/meminfo.c:22:28: warning: no previous prototype for 'arch_report_meminfo' [-Wmissing-prototypes]
      22 | void __attribute__((weak)) arch_report_meminfo(struct seq_file *m)
         |                            ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/static_branch_likely +19 arch/riscv/include/asm/pgtable-64.h

    16	
    17	static __always_inline bool pgtable_l5_enabled(void)
    18	{
  > 19		if (static_branch_likely(&_pgtable_lx_ready))
    20			return static_branch_likely(&_pgtable_l5_enabled);
    21		else
    22			return _pgtable_l5_enabled_early;
    23	}
    24	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
