Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7FB4E88F6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 18:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236076AbiC0Qrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 12:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbiC0Qry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 12:47:54 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A35B13CED
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 09:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648399575; x=1679935575;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XVjQIJQWU4zdDML3/4MxnSO2eQb5MByU3lPMrxh6eLw=;
  b=WhN2LRnnBVQcjkRr1faq41pOV/rolDKjLaJr8KLt128EgMv1thyqr7K4
   OcwO7Kc3hx+ydLEhSYeqLAwmTFMGYCU/x3DDfXUJUeJbYNEcmTxunZmZ9
   v9q8scrIdPiAMh9mY9JYN6/SL0nR0H4bocmV9qLA6kbg9bQJeXIqH2gxc
   Js4ChTadAdGV96rM3pFQA8jaw6+bBiZouS0jBUv2IUo/VTrNmu7ubs2fm
   /YZGiLl29N2cWEAjorTdMBsFNUYRoaDFfiS9rOBsK4Xgp/nzLvyerjhtl
   m7BIt1ThuvS7qFyL4pXrh8i4iKhV/VPWL+8++5CiL8mSfUqjJAnSRoZVM
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="256437244"
X-IronPort-AV: E=Sophos;i="5.90,215,1643702400"; 
   d="scan'208";a="256437244"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2022 09:46:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,215,1643702400"; 
   d="scan'208";a="650840098"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 27 Mar 2022 09:46:13 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYW1s-0001FG-U3; Sun, 27 Mar 2022 16:46:12 +0000
Date:   Mon, 28 Mar 2022 00:46:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: include/linux/fortify-string.h:275:4: warning: call to
 '__read_overflow2_field' declared with attribute warning: detected read
 beyond size of field (2nd parameter); maybe use struct_group()?
Message-ID: <202203280039.25eZrV5Z-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f022814633e1c600507b3a99691b4d624c2813f0
commit: f68f2ff91512c199ec24883001245912afc17873 fortify: Detect struct member overflows in memcpy() at compile-time
date:   6 weeks ago
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220328/202203280039.25eZrV5Z-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f68f2ff91512c199ec24883001245912afc17873
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f68f2ff91512c199ec24883001245912afc17873
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/string.h:253,
                    from arch/x86/include/asm/page_32.h:22,
                    from arch/x86/include/asm/page.h:14,
                    from arch/x86/include/asm/processor.h:19,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/skbuff.h:15,
                    from net/core/flow_dissector.c:3:
   In function 'fortify_memcpy_chk',
       inlined from '__skb_flow_dissect' at net/core/flow_dissector.c:1034:3:
>> include/linux/fortify-string.h:275:4: warning: call to '__read_overflow2_field' declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
     275 |    __read_overflow2_field(q_size_field, size);
         |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/__read_overflow2_field +275 include/linux/fortify-string.h

   213	
   214	/*
   215	 * To make sure the compiler can enforce protection against buffer overflows,
   216	 * memcpy(), memmove(), and memset() must not be used beyond individual
   217	 * struct members. If you need to copy across multiple members, please use
   218	 * struct_group() to create a named mirror of an anonymous struct union.
   219	 * (e.g. see struct sk_buff.) Read overflow checking is currently only
   220	 * done when a write overflow is also present, or when building with W=1.
   221	 *
   222	 * Mitigation coverage matrix
   223	 *					Bounds checking at:
   224	 *					+-------+-------+-------+-------+
   225	 *					| Compile time  |   Run time    |
   226	 * memcpy() argument sizes:		| write | read  | write | read  |
   227	 *        dest     source   length      +-------+-------+-------+-------+
   228	 * memcpy(known,   known,   constant)	|   y   |   y   |  n/a  |  n/a  |
   229	 * memcpy(known,   unknown, constant)	|   y   |   n   |  n/a  |   V   |
   230	 * memcpy(known,   known,   dynamic)	|   n   |   n   |   B   |   B   |
   231	 * memcpy(known,   unknown, dynamic)	|   n   |   n   |   B   |   V   |
   232	 * memcpy(unknown, known,   constant)	|   n   |   y   |   V   |  n/a  |
   233	 * memcpy(unknown, unknown, constant)	|   n   |   n   |   V   |   V   |
   234	 * memcpy(unknown, known,   dynamic)	|   n   |   n   |   V   |   B   |
   235	 * memcpy(unknown, unknown, dynamic)	|   n   |   n   |   V   |   V   |
   236	 *					+-------+-------+-------+-------+
   237	 *
   238	 * y = perform deterministic compile-time bounds checking
   239	 * n = cannot perform deterministic compile-time bounds checking
   240	 * n/a = no run-time bounds checking needed since compile-time deterministic
   241	 * B = can perform run-time bounds checking (currently unimplemented)
   242	 * V = vulnerable to run-time overflow (will need refactoring to solve)
   243	 *
   244	 */
   245	__FORTIFY_INLINE void fortify_memcpy_chk(__kernel_size_t size,
   246						 const size_t p_size,
   247						 const size_t q_size,
   248						 const size_t p_size_field,
   249						 const size_t q_size_field,
   250						 const char *func)
   251	{
   252		if (__builtin_constant_p(size)) {
   253			/*
   254			 * Length argument is a constant expression, so we
   255			 * can perform compile-time bounds checking where
   256			 * buffer sizes are known.
   257			 */
   258	
   259			/* Error when size is larger than enclosing struct. */
   260			if (p_size > p_size_field && p_size < size)
   261				__write_overflow();
   262			if (q_size > q_size_field && q_size < size)
   263				__read_overflow2();
   264	
   265			/* Warn when write size argument larger than dest field. */
   266			if (p_size_field < size)
   267				__write_overflow_field(p_size_field, size);
   268			/*
   269			 * Warn for source field over-read when building with W=1
   270			 * or when an over-write happened, so both can be fixed at
   271			 * the same time.
   272			 */
   273			if ((IS_ENABLED(KBUILD_EXTRA_WARN1) || p_size_field < size) &&
   274			    q_size_field < size)
 > 275				__read_overflow2_field(q_size_field, size);
   276		}
   277		/*
   278		 * At this point, length argument may not be a constant expression,
   279		 * so run-time bounds checking can be done where buffer sizes are
   280		 * known. (This is not an "else" because the above checks may only
   281		 * be compile-time warnings, and we want to still warn for run-time
   282		 * overflows.)
   283		 */
   284	
   285		/*
   286		 * Always stop accesses beyond the struct that contains the
   287		 * field, when the buffer's remaining size is known.
   288		 * (The -1 test is to optimize away checks where the buffer
   289		 * lengths are unknown.)
   290		 */
   291		if ((p_size != (size_t)(-1) && p_size < size) ||
   292		    (q_size != (size_t)(-1) && q_size < size))
   293			fortify_panic(func);
   294	}
   295	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
