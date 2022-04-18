Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FE0504D9F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 10:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237163AbiDRITN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 04:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237165AbiDRIS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 04:18:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26A2167D8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 01:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650269780; x=1681805780;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bPti10TZGFx1CmO8NhrPGn7v52XxuSobwrT7YpiQuFY=;
  b=ioNMSxfFsbozKg3PYj0NmDY3Cm+Rt8n9UkUH8dbzHrviuFxo6Vuj/cUg
   +zkkCw1ImWz0j8LP+ppm9sB4VldH66pg5Pkfu9B2z4HhJsYT4nJfFQt/p
   oIfGUDQcR/3rQph1MrrCqINZft1KYdwmCH0qxbDsCmEHNDl6NyTKgAFHP
   bz5WHs43lz3wCRHoypKll62K7GqGjvUQA5RVGDesOUnhiJm874ymiQ8ad
   1qSJB4eUpYOt+B65VwkKH+JMOT1aW0lHPcFZWAsurqtPAr3Ex1fUxGEiE
   6rISPAiJHVTUGNIIh9APRz/B9iK9keEgxm0s1ehB8M6fxSdPKWTg0bjzl
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="326378390"
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="326378390"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 01:16:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="613534397"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 18 Apr 2022 01:16:18 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngMYT-0004TH-DX;
        Mon, 18 Apr 2022 08:16:17 +0000
Date:   Mon, 18 Apr 2022 16:15:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [norov:bitmap 44/47] include/linux/fortify-string.h:328:4: warning:
 call to __write_overflow_field declared with 'warning' attribute: detected
 write beyond size of field (1st parameter); maybe use struct_group()?
Message-ID: <202204181643.okMUZGDj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux bitmap
head:   45a9e3feb171ccf077979b7ff6a0c6a732cfc17b
commit: 44fa42b086fd02ab7d41d92800b6888ee240fcdf [44/47] lib/bitmap: don't implement bitmap_(from,to)_arr32 on LE systems
config: x86_64-randconfig-a012-20220418 (https://download.01.org/0day-ci/archive/20220418/202204181643.okMUZGDj-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b27430f9f46b88bcd54d992debc8d72e131e1bd0)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/norov/linux/commit/44fa42b086fd02ab7d41d92800b6888ee240fcdf
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov bitmap
        git checkout 44fa42b086fd02ab7d41d92800b6888ee240fcdf
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash net/bluetooth/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from net/bluetooth/mgmt.c:27:
   In file included from include/linux/module.h:13:
   In file included from include/linux/stat.h:19:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:65:
   In file included from arch/x86/include/asm/timex.h:5:
   In file included from arch/x86/include/asm/processor.h:22:
   In file included from arch/x86/include/asm/msr.h:11:
   In file included from arch/x86/include/asm/cpumask.h:5:
   In file included from include/linux/cpumask.h:12:
   In file included from include/linux/bitmap.h:11:
   In file included from include/linux/string.h:253:
>> include/linux/fortify-string.h:328:4: warning: call to __write_overflow_field declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
                           __write_overflow_field(p_size_field, size);
                           ^
>> include/linux/fortify-string.h:328:4: warning: call to __write_overflow_field declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
>> include/linux/fortify-string.h:328:4: warning: call to __write_overflow_field declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
   include/linux/fortify-string.h:336:4: warning: call to __read_overflow2_field declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
                           __read_overflow2_field(q_size_field, size);
                           ^
   4 warnings generated.


vim +/warning +328 include/linux/fortify-string.h

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
f68f2ff91512c1 Kees Cook      2021-04-20 @328  			__write_overflow_field(p_size_field, size);
f68f2ff91512c1 Kees Cook      2021-04-20  329  		/*
f68f2ff91512c1 Kees Cook      2021-04-20  330  		 * Warn for source field over-read when building with W=1
f68f2ff91512c1 Kees Cook      2021-04-20  331  		 * or when an over-write happened, so both can be fixed at
f68f2ff91512c1 Kees Cook      2021-04-20  332  		 * the same time.
f68f2ff91512c1 Kees Cook      2021-04-20  333  		 */
f68f2ff91512c1 Kees Cook      2021-04-20  334  		if ((IS_ENABLED(KBUILD_EXTRA_WARN1) || p_size_field < size) &&
f68f2ff91512c1 Kees Cook      2021-04-20  335  		    q_size_field < size)
f68f2ff91512c1 Kees Cook      2021-04-20  336  			__read_overflow2_field(q_size_field, size);
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

:::::: The code at line 328 was first introduced by commit
:::::: f68f2ff91512c199ec24883001245912afc17873 fortify: Detect struct member overflows in memcpy() at compile-time

:::::: TO: Kees Cook <keescook@chromium.org>
:::::: CC: Kees Cook <keescook@chromium.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
