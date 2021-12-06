Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58DC64694EF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 12:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242428AbhLFLZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 06:25:57 -0500
Received: from mga04.intel.com ([192.55.52.120]:29130 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242403AbhLFLZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:25:54 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="236032884"
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="236032884"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 03:22:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="514701869"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 06 Dec 2021 03:22:04 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muC4K-000LCe-5o; Mon, 06 Dec 2021 11:22:04 +0000
Date:   Mon, 6 Dec 2021 19:21:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: include/linux/fortify-string.h:194:25: error: call to
 '__read_overflow2' declared with attribute error: detected read beyond size
 of object (2nd parameter)
Message-ID: <202112061929.l7HXpxBv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1
commit: c430f60036af44079170ff71a461b9d7cf5ee431 fortify: Move remaining fortify helpers into fortify-string.h
date:   2 months ago
config: arm-randconfig-r024-20211205 (https://download.01.org/0day-ci/archive/20211206/202112061929.l7HXpxBv-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c430f60036af44079170ff71a461b9d7cf5ee431
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c430f60036af44079170ff71a461b9d7cf5ee431
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash net/smc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   net/smc/smc_llc.c: In function 'smc_llc_add_pending_send':
   include/linux/compiler_types.h:317:45: error: call to '__compiletime_assert_577' declared with attribute error: must increase SMC_WR_BUF_SIZE to at least sizeof(struct smc_llc_msg)
     317 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:298:25: note: in definition of macro '__compiletime_assert'
     298 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:317:9: note: in expansion of macro '_compiletime_assert'
     317 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   net/smc/smc_llc.c:365:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     365 |         BUILD_BUG_ON_MSG(
         |         ^~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:317:45: error: call to '__compiletime_assert_578' declared with attribute error: must adapt SMC_WR_TX_SIZE to sizeof(struct smc_llc_msg); if not all smc_wr upper layer protocols use the same message size any more, must start to set link->wr_tx_sges[i].length on each individual smc_wr_tx_send()
     317 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:298:25: note: in definition of macro '__compiletime_assert'
     298 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:317:9: note: in expansion of macro '_compiletime_assert'
     317 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   net/smc/smc_llc.c:368:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     368 |         BUILD_BUG_ON_MSG(
         |         ^~~~~~~~~~~~~~~~
   In file included from include/linux/string.h:253,
                    from include/linux/bitmap.h:10,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/highmem.h:5,
                    from include/linux/bvec.h:10,
                    from include/linux/skbuff.h:17,
                    from include/linux/tcp.h:17,
                    from include/net/tcp.h:20,
                    from net/smc/smc_llc.c:13:
   In function 'memcpy',
       inlined from 'smc_llc_send_message_wait' at net/smc/smc_llc.c:594:2,
       inlined from 'smc_llc_send_link_delete_all' at net/smc/smc_llc.c:1328:8:
>> include/linux/fortify-string.h:194:25: error: call to '__read_overflow2' declared with attribute error: detected read beyond size of object (2nd parameter)
     194 |                         __read_overflow2();
         |                         ^~~~~~~~~~~~~~~~~~


vim +/__read_overflow2 +194 include/linux/fortify-string.h

a28a6e860c6cf2 Francis Laniel 2021-02-25  184  
a28a6e860c6cf2 Francis Laniel 2021-02-25  185  __FORTIFY_INLINE void *memcpy(void *p, const void *q, __kernel_size_t size)
a28a6e860c6cf2 Francis Laniel 2021-02-25  186  {
a28a6e860c6cf2 Francis Laniel 2021-02-25  187  	size_t p_size = __builtin_object_size(p, 0);
a28a6e860c6cf2 Francis Laniel 2021-02-25  188  	size_t q_size = __builtin_object_size(q, 0);
a28a6e860c6cf2 Francis Laniel 2021-02-25  189  
a28a6e860c6cf2 Francis Laniel 2021-02-25  190  	if (__builtin_constant_p(size)) {
a28a6e860c6cf2 Francis Laniel 2021-02-25  191  		if (p_size < size)
a28a6e860c6cf2 Francis Laniel 2021-02-25  192  			__write_overflow();
a28a6e860c6cf2 Francis Laniel 2021-02-25  193  		if (q_size < size)
a28a6e860c6cf2 Francis Laniel 2021-02-25 @194  			__read_overflow2();
a28a6e860c6cf2 Francis Laniel 2021-02-25  195  	}
a28a6e860c6cf2 Francis Laniel 2021-02-25  196  	if (p_size < size || q_size < size)
a28a6e860c6cf2 Francis Laniel 2021-02-25  197  		fortify_panic(__func__);
a28a6e860c6cf2 Francis Laniel 2021-02-25  198  	return __underlying_memcpy(p, q, size);
a28a6e860c6cf2 Francis Laniel 2021-02-25  199  }
a28a6e860c6cf2 Francis Laniel 2021-02-25  200  

:::::: The code at line 194 was first introduced by commit
:::::: a28a6e860c6cf231cf3c5171c75c342adcd00406 string.h: move fortified functions definitions in a dedicated header.

:::::: TO: Francis Laniel <laniel_francis@privacyrequired.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
