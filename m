Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2C046C86B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 01:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242564AbhLHAGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 19:06:07 -0500
Received: from mga05.intel.com ([192.55.52.43]:64247 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238533AbhLHAGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 19:06:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="323974210"
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="323974210"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 16:01:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="611887767"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 07 Dec 2021 16:01:17 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mukOa-000N64-I9; Wed, 08 Dec 2021 00:01:16 +0000
Date:   Wed, 8 Dec 2021 08:00:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [kees:memcpy/step2/next-20211206 19/19]
 include/linux/fortify-string.h:324:4: warning: call to
 __read_overflow2_field declared with 'warning' attribute: detected read
 beyond size of field (2nd parameter); maybe use struct_group()?
Message-ID: <202112080732.rL3hdjwC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git memcpy/step2/next-20211206
head:   082faead4a3c2e5d9f541f97d8d4d5fa0f88dce0
commit: 082faead4a3c2e5d9f541f97d8d4d5fa0f88dce0 [19/19] fortify: Work around Clang inlining bugs
config: i386-randconfig-a013-20211207 (https://download.01.org/0day-ci/archive/20211208/202112080732.rL3hdjwC-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=082faead4a3c2e5d9f541f97d8d4d5fa0f88dce0
        git remote add kees https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
        git fetch --no-tags kees memcpy/step2/next-20211206
        git checkout 082faead4a3c2e5d9f541f97d8d4d5fa0f88dce0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/entry/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/entry/common.c:3:
   In file included from include/linux/context_tracking.h:5:
   In file included from include/linux/sched.h:14:
   In file included from include/linux/pid.h:5:
   In file included from include/linux/rculist.h:11:
   In file included from include/linux/rcupdate.h:27:
   In file included from include/linux/preempt.h:78:
   In file included from arch/x86/include/asm/preempt.h:7:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/x86/include/asm/thread_info.h:12:
   In file included from arch/x86/include/asm/page.h:14:
   In file included from arch/x86/include/asm/page_32.h:35:
   In file included from include/linux/string.h:253:
>> include/linux/fortify-string.h:324:4: warning: call to __read_overflow2_field declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
                           __read_overflow2_field(q_size_field, size);
                           ^
>> include/linux/fortify-string.h:324:4: warning: call to __read_overflow2_field declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
   2 warnings generated.


vim +/warning +324 include/linux/fortify-string.h

2fc46de99fed34 Kees Cook      2021-06-16  255  
2fc46de99fed34 Kees Cook      2021-06-16  256  /*
2fc46de99fed34 Kees Cook      2021-06-16  257   * __builtin_object_size() must be captured here to avoid evaluating argument
2fc46de99fed34 Kees Cook      2021-06-16  258   * side-effects further into the macro layers.
2fc46de99fed34 Kees Cook      2021-06-16  259   */
2fc46de99fed34 Kees Cook      2021-06-16  260  #define memset(p, c, s) __fortify_memset_chk(p, c, s,			\
2fc46de99fed34 Kees Cook      2021-06-16  261  		__builtin_object_size(p, 0), __builtin_object_size(p, 1))
a28a6e860c6cf2 Francis Laniel 2021-02-25  262  
a91965903a44bf Kees Cook      2021-04-20  263  /*
a91965903a44bf Kees Cook      2021-04-20  264   * To make sure the compiler can enforce protection against buffer overflows,
a91965903a44bf Kees Cook      2021-04-20  265   * memcpy(), memmove(), and memset() must not be used beyond individual
a91965903a44bf Kees Cook      2021-04-20  266   * struct members. If you need to copy across multiple members, please use
a91965903a44bf Kees Cook      2021-04-20  267   * struct_group() to create a named mirror of an anonymous struct union.
a91965903a44bf Kees Cook      2021-04-20  268   * (e.g. see struct sk_buff.)
a91965903a44bf Kees Cook      2021-04-20  269   *
a91965903a44bf Kees Cook      2021-04-20  270   * Mitigation coverage
a91965903a44bf Kees Cook      2021-04-20  271   *					Bounds checking at:
a91965903a44bf Kees Cook      2021-04-20  272   *					+-------+-------+-------+-------+
a91965903a44bf Kees Cook      2021-04-20  273   *					| Compile time  | Run time      |
a91965903a44bf Kees Cook      2021-04-20  274   * memcpy() argument sizes:		| write | read  | write | read  |
a91965903a44bf Kees Cook      2021-04-20  275   *					+-------+-------+-------+-------+
a91965903a44bf Kees Cook      2021-04-20  276   * memcpy(known,   known,   constant)	|   y   |   y   |  n/a  |  n/a  |
a91965903a44bf Kees Cook      2021-04-20  277   * memcpy(unknown, known,   constant)	|   n   |   y   |   V   |  n/a  |
a91965903a44bf Kees Cook      2021-04-20  278   * memcpy(known,   unknown, constant)	|   y   |   n   |  n/a  |   V   |
a91965903a44bf Kees Cook      2021-04-20  279   * memcpy(unknown, unknown, constant)	|   n   |   n   |   V   |   V   |
a91965903a44bf Kees Cook      2021-04-20  280   * memcpy(known,   known,   dynamic)	|   n   |   n   |   b   |   B   |
a91965903a44bf Kees Cook      2021-04-20  281   * memcpy(unknown, known,   dynamic)	|   n   |   n   |   V   |   B   |
a91965903a44bf Kees Cook      2021-04-20  282   * memcpy(known,   unknown, dynamic)	|   n   |   n   |   b   |   V   |
a91965903a44bf Kees Cook      2021-04-20  283   * memcpy(unknown, unknown, dynamic)	|   n   |   n   |   V   |   V   |
a91965903a44bf Kees Cook      2021-04-20  284   *					+-------+-------+-------+-------+
a91965903a44bf Kees Cook      2021-04-20  285   *
a91965903a44bf Kees Cook      2021-04-20  286   * y = deterministic compile-time bounds checking
a91965903a44bf Kees Cook      2021-04-20  287   * n = cannot do deterministic compile-time bounds checking
a91965903a44bf Kees Cook      2021-04-20  288   * n/a = no run-time bounds checking needed since compile-time deterministic
a91965903a44bf Kees Cook      2021-04-20  289   * b = perform run-time bounds checking
a91965903a44bf Kees Cook      2021-04-20  290   * B = can perform run-time bounds checking, but current unenforced
a91965903a44bf Kees Cook      2021-04-20  291   * V = vulnerable to run-time overflow
a91965903a44bf Kees Cook      2021-04-20  292   *
a91965903a44bf Kees Cook      2021-04-20  293   */
a91965903a44bf Kees Cook      2021-04-20  294  __FORTIFY_INLINE void fortify_memcpy_chk(__kernel_size_t size,
a91965903a44bf Kees Cook      2021-04-20  295  					 const size_t p_size,
a91965903a44bf Kees Cook      2021-04-20  296  					 const size_t q_size,
a91965903a44bf Kees Cook      2021-04-20  297  					 const size_t p_size_field,
a91965903a44bf Kees Cook      2021-04-20  298  					 const size_t q_size_field,
a91965903a44bf Kees Cook      2021-04-20  299  					 const char *func)
a28a6e860c6cf2 Francis Laniel 2021-02-25  300  {
a28a6e860c6cf2 Francis Laniel 2021-02-25  301  	if (__builtin_constant_p(size)) {
a91965903a44bf Kees Cook      2021-04-20  302  		/*
a91965903a44bf Kees Cook      2021-04-20  303  		 * Length argument is a constant expression, so we
a91965903a44bf Kees Cook      2021-04-20  304  		 * can perform compile-time bounds checking where
a91965903a44bf Kees Cook      2021-04-20  305  		 * buffer sizes are known.
a91965903a44bf Kees Cook      2021-04-20  306  		 */
a91965903a44bf Kees Cook      2021-04-20  307  
a91965903a44bf Kees Cook      2021-04-20  308  		/* Error when size is larger than enclosing struct. */
a91965903a44bf Kees Cook      2021-04-20  309  		if (p_size > p_size_field && p_size < size)
a28a6e860c6cf2 Francis Laniel 2021-02-25  310  			__write_overflow();
a91965903a44bf Kees Cook      2021-04-20  311  		if (q_size > q_size_field && q_size < size)
a28a6e860c6cf2 Francis Laniel 2021-02-25  312  			__read_overflow2();
a91965903a44bf Kees Cook      2021-04-20  313  
a91965903a44bf Kees Cook      2021-04-20  314  		/* Warn when write size argument larger than dest field. */
a91965903a44bf Kees Cook      2021-04-20  315  		if (p_size_field < size)
a91965903a44bf Kees Cook      2021-04-20  316  			__write_overflow_field(p_size_field, size);
a91965903a44bf Kees Cook      2021-04-20  317  		/*
a91965903a44bf Kees Cook      2021-04-20  318  		 * Warn for source field over-read when building with W=1
a91965903a44bf Kees Cook      2021-04-20  319  		 * or when an over-write happened, so both can be fixed at
a91965903a44bf Kees Cook      2021-04-20  320  		 * the same time.
a91965903a44bf Kees Cook      2021-04-20  321  		 */
a91965903a44bf Kees Cook      2021-04-20  322  		if ((IS_ENABLED(KBUILD_EXTRA_WARN1) || p_size_field < size) &&
a91965903a44bf Kees Cook      2021-04-20  323  		    q_size_field < size)
a91965903a44bf Kees Cook      2021-04-20 @324  			__read_overflow2_field(q_size_field, size);
a28a6e860c6cf2 Francis Laniel 2021-02-25  325  	}
a91965903a44bf Kees Cook      2021-04-20  326  	/*
a91965903a44bf Kees Cook      2021-04-20  327  	 * At this point, length argument may not be a constant expression,
a91965903a44bf Kees Cook      2021-04-20  328  	 * so run-time bounds checking can be done where buffer sizes are
a91965903a44bf Kees Cook      2021-04-20  329  	 * known. (This is not an "else" because the above checks may only
a91965903a44bf Kees Cook      2021-04-20  330  	 * be compile-time warnings, and we want to still warn for run-time
a91965903a44bf Kees Cook      2021-04-20  331  	 * overflows.)
a91965903a44bf Kees Cook      2021-04-20  332  	 */
a91965903a44bf Kees Cook      2021-04-20  333  
a91965903a44bf Kees Cook      2021-04-20  334  	/*
a91965903a44bf Kees Cook      2021-04-20  335  	 * Always stop accesses beyond the struct that contains the
a91965903a44bf Kees Cook      2021-04-20  336  	 * field, when the buffer's remaining size is known.
a91965903a44bf Kees Cook      2021-04-20  337  	 * (The -1 test is to optimize away checks where the buffer
a91965903a44bf Kees Cook      2021-04-20  338  	 * lengths are unknown.)
a91965903a44bf Kees Cook      2021-04-20  339  	 */
a91965903a44bf Kees Cook      2021-04-20  340  	if ((p_size != (size_t)(-1) && p_size < size) ||
a91965903a44bf Kees Cook      2021-04-20  341  	    (q_size != (size_t)(-1) && q_size < size))
a91965903a44bf Kees Cook      2021-04-20  342  		fortify_panic(func);
a28a6e860c6cf2 Francis Laniel 2021-02-25  343  }
a28a6e860c6cf2 Francis Laniel 2021-02-25  344  

:::::: The code at line 324 was first introduced by commit
:::::: a91965903a44bf236856efc7e20c6334c4e07388 fortify: Detect struct member overflows in memcpy() at compile-time

:::::: TO: Kees Cook <keescook@chromium.org>
:::::: CC: Kees Cook <keescook@chromium.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
