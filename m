Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F67533D64
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243596AbiEYNLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236743AbiEYNLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:11:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D283A3380
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653484257; x=1685020257;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yTFmjuVJzZeVwWDM7Bs3IwCz1WgeJQrvSFJ69LNLCgI=;
  b=Z3iBI/+S/7Btt8ugYoqErR9WyKrz2qAS6dDtfon2GYCPDkfQRICDz476
   k6R4Tya0tDawMXHgupxpK+qz1Kf6sYoLShyEPHHPtY3WjcmqFf6pxPU5J
   lCH4uZG8CqA/IztkB3b+hqzJNYihlRjLOqEuj9XoDJ9lbRVZyBilelzlj
   Tz6xJxleHlJwqTLe8ibjy3a7/XWWtCPaTxFa8NaZApAeA8nlWMWJP3z/8
   e42z0K/EvsfqJqMHUXr4U59+DFHES+bFzdgpFyylO/65VDJ9Rzr9X4puc
   msrB2XHaOxHasvWZcHV7vM6X+F5cmiMiv7y5enPknLMo3Gu60dW/cAyY8
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="255872361"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="255872361"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 06:10:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="703990916"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 25 May 2022 06:10:55 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntqms-00031y-Bx;
        Wed, 25 May 2022 13:10:54 +0000
Date:   Wed, 25 May 2022 21:10:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: include/linux/fortify-string.h:336:4: warning: call to
 __read_overflow2_field declared with 'warning' attribute: detected read
 beyond size of field (2nd parameter); maybe use struct_group()?
Message-ID: <202205252132.Owgo8tkv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fdaf9a5840acaab18694a19e0eb0aa51162eeeed
commit: 281d0c962752fb40866dd8d4cade68656f34bd1f fortify: Add Clang support
date:   3 months ago
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220525/202205252132.Owgo8tkv-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d52a6e75b0c402c7f3b42a2b1b2873f151220947)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=281d0c962752fb40866dd8d4cade68656f34bd1f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 281d0c962752fb40866dd8d4cade68656f34bd1f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/nvme/host/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/nvme/host/core.c:7:
   In file included from include/linux/blkdev.h:5:
   In file included from include/linux/sched.h:14:
   In file included from include/linux/pid.h:5:
   In file included from include/linux/rculist.h:11:
   In file included from include/linux/rcupdate.h:27:
   In file included from include/linux/preempt.h:78:
   In file included from arch/x86/include/asm/preempt.h:7:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/x86/include/asm/thread_info.h:53:
   In file included from arch/x86/include/asm/cpufeature.h:5:
   In file included from arch/x86/include/asm/processor.h:22:
   In file included from arch/x86/include/asm/msr.h:11:
   In file included from arch/x86/include/asm/cpumask.h:5:
   In file included from include/linux/cpumask.h:12:
   In file included from include/linux/bitmap.h:11:
   In file included from include/linux/string.h:253:
>> include/linux/fortify-string.h:336:4: warning: call to __read_overflow2_field declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
                           __read_overflow2_field(q_size_field, size);
                           ^
>> include/linux/fortify-string.h:336:4: warning: call to __read_overflow2_field declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
   2 warnings generated.


vim +/warning +336 include/linux/fortify-string.h

28e77cc1c06866 Kees Cook      2021-06-16  267  
28e77cc1c06866 Kees Cook      2021-06-16  268  /*
28e77cc1c06866 Kees Cook      2021-06-16  269   * __builtin_object_size() must be captured here to avoid evaluating argument
28e77cc1c06866 Kees Cook      2021-06-16  270   * side-effects further into the macro layers.
28e77cc1c06866 Kees Cook      2021-06-16  271   */
28e77cc1c06866 Kees Cook      2021-06-16  272  #define memset(p, c, s) __fortify_memset_chk(p, c, s,			\
28e77cc1c06866 Kees Cook      2021-06-16  273  		__builtin_object_size(p, 0), __builtin_object_size(p, 1))
a28a6e860c6cf2 Francis Laniel 2021-02-25  274  
f68f2ff91512c1 Kees Cook      2021-04-20  275  /*
f68f2ff91512c1 Kees Cook      2021-04-20  276   * To make sure the compiler can enforce protection against buffer overflows,
f68f2ff91512c1 Kees Cook      2021-04-20  277   * memcpy(), memmove(), and memset() must not be used beyond individual
f68f2ff91512c1 Kees Cook      2021-04-20  278   * struct members. If you need to copy across multiple members, please use
f68f2ff91512c1 Kees Cook      2021-04-20  279   * struct_group() to create a named mirror of an anonymous struct union.
f68f2ff91512c1 Kees Cook      2021-04-20  280   * (e.g. see struct sk_buff.) Read overflow checking is currently only
f68f2ff91512c1 Kees Cook      2021-04-20  281   * done when a write overflow is also present, or when building with W=1.
f68f2ff91512c1 Kees Cook      2021-04-20  282   *
f68f2ff91512c1 Kees Cook      2021-04-20  283   * Mitigation coverage matrix
f68f2ff91512c1 Kees Cook      2021-04-20  284   *					Bounds checking at:
f68f2ff91512c1 Kees Cook      2021-04-20  285   *					+-------+-------+-------+-------+
f68f2ff91512c1 Kees Cook      2021-04-20  286   *					| Compile time  |   Run time    |
f68f2ff91512c1 Kees Cook      2021-04-20  287   * memcpy() argument sizes:		| write | read  | write | read  |
f68f2ff91512c1 Kees Cook      2021-04-20  288   *        dest     source   length      +-------+-------+-------+-------+
f68f2ff91512c1 Kees Cook      2021-04-20  289   * memcpy(known,   known,   constant)	|   y   |   y   |  n/a  |  n/a  |
f68f2ff91512c1 Kees Cook      2021-04-20  290   * memcpy(known,   unknown, constant)	|   y   |   n   |  n/a  |   V   |
f68f2ff91512c1 Kees Cook      2021-04-20  291   * memcpy(known,   known,   dynamic)	|   n   |   n   |   B   |   B   |
f68f2ff91512c1 Kees Cook      2021-04-20  292   * memcpy(known,   unknown, dynamic)	|   n   |   n   |   B   |   V   |
f68f2ff91512c1 Kees Cook      2021-04-20  293   * memcpy(unknown, known,   constant)	|   n   |   y   |   V   |  n/a  |
f68f2ff91512c1 Kees Cook      2021-04-20  294   * memcpy(unknown, unknown, constant)	|   n   |   n   |   V   |   V   |
f68f2ff91512c1 Kees Cook      2021-04-20  295   * memcpy(unknown, known,   dynamic)	|   n   |   n   |   V   |   B   |
f68f2ff91512c1 Kees Cook      2021-04-20  296   * memcpy(unknown, unknown, dynamic)	|   n   |   n   |   V   |   V   |
f68f2ff91512c1 Kees Cook      2021-04-20  297   *					+-------+-------+-------+-------+
f68f2ff91512c1 Kees Cook      2021-04-20  298   *
f68f2ff91512c1 Kees Cook      2021-04-20  299   * y = perform deterministic compile-time bounds checking
f68f2ff91512c1 Kees Cook      2021-04-20  300   * n = cannot perform deterministic compile-time bounds checking
f68f2ff91512c1 Kees Cook      2021-04-20  301   * n/a = no run-time bounds checking needed since compile-time deterministic
f68f2ff91512c1 Kees Cook      2021-04-20  302   * B = can perform run-time bounds checking (currently unimplemented)
f68f2ff91512c1 Kees Cook      2021-04-20  303   * V = vulnerable to run-time overflow (will need refactoring to solve)
f68f2ff91512c1 Kees Cook      2021-04-20  304   *
f68f2ff91512c1 Kees Cook      2021-04-20  305   */
f68f2ff91512c1 Kees Cook      2021-04-20  306  __FORTIFY_INLINE void fortify_memcpy_chk(__kernel_size_t size,
f68f2ff91512c1 Kees Cook      2021-04-20  307  					 const size_t p_size,
f68f2ff91512c1 Kees Cook      2021-04-20  308  					 const size_t q_size,
f68f2ff91512c1 Kees Cook      2021-04-20  309  					 const size_t p_size_field,
f68f2ff91512c1 Kees Cook      2021-04-20  310  					 const size_t q_size_field,
f68f2ff91512c1 Kees Cook      2021-04-20  311  					 const char *func)
a28a6e860c6cf2 Francis Laniel 2021-02-25  312  {
a28a6e860c6cf2 Francis Laniel 2021-02-25  313  	if (__builtin_constant_p(size)) {
f68f2ff91512c1 Kees Cook      2021-04-20  314  		/*
f68f2ff91512c1 Kees Cook      2021-04-20  315  		 * Length argument is a constant expression, so we
f68f2ff91512c1 Kees Cook      2021-04-20  316  		 * can perform compile-time bounds checking where
f68f2ff91512c1 Kees Cook      2021-04-20  317  		 * buffer sizes are known.
f68f2ff91512c1 Kees Cook      2021-04-20  318  		 */
f68f2ff91512c1 Kees Cook      2021-04-20  319  
f68f2ff91512c1 Kees Cook      2021-04-20  320  		/* Error when size is larger than enclosing struct. */
f68f2ff91512c1 Kees Cook      2021-04-20  321  		if (p_size > p_size_field && p_size < size)
a28a6e860c6cf2 Francis Laniel 2021-02-25  322  			__write_overflow();
f68f2ff91512c1 Kees Cook      2021-04-20  323  		if (q_size > q_size_field && q_size < size)
a28a6e860c6cf2 Francis Laniel 2021-02-25  324  			__read_overflow2();
f68f2ff91512c1 Kees Cook      2021-04-20  325  
f68f2ff91512c1 Kees Cook      2021-04-20  326  		/* Warn when write size argument larger than dest field. */
f68f2ff91512c1 Kees Cook      2021-04-20  327  		if (p_size_field < size)
f68f2ff91512c1 Kees Cook      2021-04-20  328  			__write_overflow_field(p_size_field, size);
f68f2ff91512c1 Kees Cook      2021-04-20  329  		/*
f68f2ff91512c1 Kees Cook      2021-04-20  330  		 * Warn for source field over-read when building with W=1
f68f2ff91512c1 Kees Cook      2021-04-20  331  		 * or when an over-write happened, so both can be fixed at
f68f2ff91512c1 Kees Cook      2021-04-20  332  		 * the same time.
f68f2ff91512c1 Kees Cook      2021-04-20  333  		 */
f68f2ff91512c1 Kees Cook      2021-04-20  334  		if ((IS_ENABLED(KBUILD_EXTRA_WARN1) || p_size_field < size) &&
f68f2ff91512c1 Kees Cook      2021-04-20  335  		    q_size_field < size)
f68f2ff91512c1 Kees Cook      2021-04-20 @336  			__read_overflow2_field(q_size_field, size);
a28a6e860c6cf2 Francis Laniel 2021-02-25  337  	}
f68f2ff91512c1 Kees Cook      2021-04-20  338  	/*
f68f2ff91512c1 Kees Cook      2021-04-20  339  	 * At this point, length argument may not be a constant expression,
f68f2ff91512c1 Kees Cook      2021-04-20  340  	 * so run-time bounds checking can be done where buffer sizes are
f68f2ff91512c1 Kees Cook      2021-04-20  341  	 * known. (This is not an "else" because the above checks may only
f68f2ff91512c1 Kees Cook      2021-04-20  342  	 * be compile-time warnings, and we want to still warn for run-time
f68f2ff91512c1 Kees Cook      2021-04-20  343  	 * overflows.)
f68f2ff91512c1 Kees Cook      2021-04-20  344  	 */
f68f2ff91512c1 Kees Cook      2021-04-20  345  
f68f2ff91512c1 Kees Cook      2021-04-20  346  	/*
f68f2ff91512c1 Kees Cook      2021-04-20  347  	 * Always stop accesses beyond the struct that contains the
f68f2ff91512c1 Kees Cook      2021-04-20  348  	 * field, when the buffer's remaining size is known.
f68f2ff91512c1 Kees Cook      2021-04-20  349  	 * (The -1 test is to optimize away checks where the buffer
f68f2ff91512c1 Kees Cook      2021-04-20  350  	 * lengths are unknown.)
f68f2ff91512c1 Kees Cook      2021-04-20  351  	 */
f68f2ff91512c1 Kees Cook      2021-04-20  352  	if ((p_size != (size_t)(-1) && p_size < size) ||
f68f2ff91512c1 Kees Cook      2021-04-20  353  	    (q_size != (size_t)(-1) && q_size < size))
f68f2ff91512c1 Kees Cook      2021-04-20  354  		fortify_panic(func);
a28a6e860c6cf2 Francis Laniel 2021-02-25  355  }
a28a6e860c6cf2 Francis Laniel 2021-02-25  356  

:::::: The code at line 336 was first introduced by commit
:::::: f68f2ff91512c199ec24883001245912afc17873 fortify: Detect struct member overflows in memcpy() at compile-time

:::::: TO: Kees Cook <keescook@chromium.org>
:::::: CC: Kees Cook <keescook@chromium.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
