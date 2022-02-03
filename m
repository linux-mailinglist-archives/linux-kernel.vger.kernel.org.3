Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646EB4A8861
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 17:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242680AbiBCQKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 11:10:25 -0500
Received: from mga17.intel.com ([192.55.52.151]:40926 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242913AbiBCQKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 11:10:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643904622; x=1675440622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PbLL7Pq2WIl6nfJMtAPyeW76Fx8pn8wcSccJqg1jtig=;
  b=AklhiPIAKWM139R14oCBm/7bFB9NPOcO9+3PmJNPQNNnuuSQ7LFJmDzH
   +MWU5xvyefZvhkBx8Kqs92JIeb+ybb+DWzL3sbQOLAHtxtYNhJ50guRVG
   mxcCnhjK97pKXBOFtdyon0x4vt4DnxbInObi//064HK52AOBIH1wD4RZs
   wPeaNIf9HA7Eg5PktHa3yed7F8Rzxvy3z6bFGA3VYsKy9qRiOdvBSchpv
   xopnMrY6OKgKQPCm5MTOms/C1ZXZAb+HZlHvLvUAEVS9cobrkIWhAxb2E
   9zb2zlkXpRoW2tR/n7Hw6kMCVQJMS+QjZwQJN/rwguB2DYiWSQKSTxHu9
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="228827226"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="228827226"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 08:10:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="631385941"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 03 Feb 2022 08:10:19 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFegd-000WJo-93; Thu, 03 Feb 2022 16:10:19 +0000
Date:   Fri, 4 Feb 2022 00:09:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, arnd@arndb.de, boqun.feng@gmail.com,
        mark.rutland@arm.com, peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH] atomics: fix atomic64_{read_acquire,set_release}
 fallbacks
Message-ID: <202202032312.7YDqjour-lkp@intel.com>
References: <20220203143848.3934515-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203143848.3934515-1-mark.rutland@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

I love your patch! Yet something to improve:

[auto build test ERROR on linux/master]
[also build test ERROR on soc/for-next linus/master v5.17-rc2 next-20220203]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Mark-Rutland/atomics-fix-atomic64_-read_acquire-set_release-fallbacks/20220203-224037
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2c271fe77d52a0555161926c232cd5bc07178b39
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220203/202202032312.7YDqjour-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/a4f59a24830e45bbd94645639aae50597b148388
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Mark-Rutland/atomics-fix-atomic64_-read_acquire-set_release-fallbacks/20220203-224037
        git checkout a4f59a24830e45bbd94645639aae50597b148388
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/um/user-offsets.c:18:6: warning: no previous prototype for 'foo' [-Wmissing-prototypes]
      18 | void foo(void)
         |      ^~~
   In file included from include/linux/atomic.h:80,
                    from include/linux/rcupdate.h:25,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from arch/x86/um/shared/sysdep/kernel-offsets.h:3,
                    from arch/um/kernel/asm-offsets.c:1:
   include/linux/atomic/atomic-arch-fallback.h: In function 'arch_atomic64_read_acquire':
>> include/linux/atomic/atomic-arch-fallback.h:1280:26: error: passing argument 1 of 'arch_atomic_read' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1280 |   ret = arch_atomic_read(v);
         |                          ^
         |                          |
         |                          const atomic64_t * {aka const struct <anonymous> *}
   In file included from include/linux/atomic.h:7,
                    from include/linux/rcupdate.h:25,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from arch/x86/um/shared/sysdep/kernel-offsets.h:3,
                    from arch/um/kernel/asm-offsets.c:1:
   arch/x86/include/asm/atomic.h:23:61: note: expected 'const atomic_t *' {aka 'const struct <anonymous> *'} but argument is of type 'const atomic64_t *' {aka 'const struct <anonymous> *'}
      23 | static __always_inline int arch_atomic_read(const atomic_t *v)
         |                                             ~~~~~~~~~~~~~~~~^
   In file included from include/linux/atomic.h:80,
                    from include/linux/rcupdate.h:25,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from arch/x86/um/shared/sysdep/kernel-offsets.h:3,
                    from arch/um/kernel/asm-offsets.c:1:
   include/linux/atomic/atomic-arch-fallback.h: In function 'arch_atomic64_set_release':
>> include/linux/atomic/atomic-arch-fallback.h:1297:19: error: passing argument 1 of 'arch_atomic_set' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1297 |   arch_atomic_set(v, i);
         |                   ^
         |                   |
         |                   atomic64_t * {aka struct <anonymous> *}
   In file included from include/linux/atomic.h:7,
                    from include/linux/rcupdate.h:25,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from arch/x86/um/shared/sysdep/kernel-offsets.h:3,
                    from arch/um/kernel/asm-offsets.c:1:
   arch/x86/include/asm/atomic.h:39:55: note: expected 'atomic_t *' {aka 'struct <anonymous> *'} but argument is of type 'atomic64_t *' {aka 'struct <anonymous> *'}
      39 | static __always_inline void arch_atomic_set(atomic_t *v, int i)
         |                                             ~~~~~~~~~~^
   In file included from arch/um/kernel/asm-offsets.c:1:
   arch/x86/um/shared/sysdep/kernel-offsets.h: At top level:
   arch/x86/um/shared/sysdep/kernel-offsets.h:9:6: warning: no previous prototype for 'foo' [-Wmissing-prototypes]
       9 | void foo(void)
         |      ^~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:121: arch/um/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1191: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/arch_atomic_read +1280 include/linux/atomic/atomic-arch-fallback.h

  1270	
  1271	#ifndef arch_atomic64_read_acquire
  1272	static __always_inline s64
  1273	arch_atomic64_read_acquire(const atomic64_t *v)
  1274	{
  1275		s64 ret;
  1276	
  1277		if (__native_word(atomic64_t)) {
  1278			ret = smp_load_acquire(&(v)->counter);
  1279		} else {
> 1280			ret = arch_atomic_read(v);
  1281			__atomic_acquire_fence();
  1282		}
  1283	
  1284		return ret;
  1285	}
  1286	#define arch_atomic64_read_acquire arch_atomic64_read_acquire
  1287	#endif
  1288	
  1289	#ifndef arch_atomic64_set_release
  1290	static __always_inline void
  1291	arch_atomic64_set_release(atomic64_t *v, s64 i)
  1292	{
  1293		if (__native_word(atomic64_t)) {
  1294			smp_store_release(&(v)->counter, i);
  1295		} else {
  1296			__atomic_release_fence();
> 1297			arch_atomic_set(v, i);
  1298		}
  1299	}
  1300	#define arch_atomic64_set_release arch_atomic64_set_release
  1301	#endif
  1302	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
