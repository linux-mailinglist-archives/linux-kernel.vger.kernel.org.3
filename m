Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3BE046CCD4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 06:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhLHFNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 00:13:00 -0500
Received: from mga09.intel.com ([134.134.136.24]:4733 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230316AbhLHFM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 00:12:59 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="237565333"
X-IronPort-AV: E=Sophos;i="5.87,296,1631602800"; 
   d="scan'208";a="237565333"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 21:09:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,296,1631602800"; 
   d="scan'208";a="462629629"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 07 Dec 2021 21:09:26 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mupCo-00006G-9O; Wed, 08 Dec 2021 05:09:26 +0000
Date:   Wed, 8 Dec 2021 13:08:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kees:memcpy/step2/next-20211206 7/19]
 include/linux/fortify-string.h:267:25: warning: call to
 '__write_overflow_field' declared with attribute warning: detected write
 beyond size of field (1st parameter); maybe use struct_group()?
Message-ID: <202112081218.SHPzkHBb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git memcpy/step2/next-20211206
head:   082faead4a3c2e5d9f541f97d8d4d5fa0f88dce0
commit: a91965903a44bf236856efc7e20c6334c4e07388 [7/19] fortify: Detect struct member overflows in memcpy() at compile-time
config: powerpc-randconfig-c023-20211207 (https://download.01.org/0day-ci/archive/20211208/202112081218.SHPzkHBb-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=a91965903a44bf236856efc7e20c6334c4e07388
        git remote add kees https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
        git fetch --no-tags kees memcpy/step2/next-20211206
        git checkout a91965903a44bf236856efc7e20c6334c4e07388
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/net/ethernet/intel/iavf/ fs/dlm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/string.h:253,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/tracepoint.h:15,
                    from include/trace/events/dlm.h:10,
                    from fs/dlm/lock.c:56:
   In function 'fortify_memcpy_chk',
       inlined from 'send_repeat_remove' at fs/dlm/lock.c:4075:2:
>> include/linux/fortify-string.h:267:25: warning: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
     267 |                         __write_overflow_field(p_size_field, size);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In function 'fortify_memcpy_chk',
       inlined from 'shrink_bucket' at fs/dlm/lock.c:1792:3:
>> include/linux/fortify-string.h:267:25: warning: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
     267 |                         __write_overflow_field(p_size_field, size);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/__write_overflow_field +267 include/linux/fortify-string.h

   213	
   214	/*
   215	 * To make sure the compiler can enforce protection against buffer overflows,
   216	 * memcpy(), memmove(), and memset() must not be used beyond individual
   217	 * struct members. If you need to copy across multiple members, please use
   218	 * struct_group() to create a named mirror of an anonymous struct union.
   219	 * (e.g. see struct sk_buff.)
   220	 *
   221	 * Mitigation coverage
   222	 *					Bounds checking at:
   223	 *					+-------+-------+-------+-------+
   224	 *					| Compile time  | Run time      |
   225	 * memcpy() argument sizes:		| write | read  | write | read  |
   226	 *					+-------+-------+-------+-------+
   227	 * memcpy(known,   known,   constant)	|   y   |   y   |  n/a  |  n/a  |
   228	 * memcpy(unknown, known,   constant)	|   n   |   y   |   V   |  n/a  |
   229	 * memcpy(known,   unknown, constant)	|   y   |   n   |  n/a  |   V   |
   230	 * memcpy(unknown, unknown, constant)	|   n   |   n   |   V   |   V   |
   231	 * memcpy(known,   known,   dynamic)	|   n   |   n   |   b   |   B   |
   232	 * memcpy(unknown, known,   dynamic)	|   n   |   n   |   V   |   B   |
   233	 * memcpy(known,   unknown, dynamic)	|   n   |   n   |   b   |   V   |
   234	 * memcpy(unknown, unknown, dynamic)	|   n   |   n   |   V   |   V   |
   235	 *					+-------+-------+-------+-------+
   236	 *
   237	 * y = deterministic compile-time bounds checking
   238	 * n = cannot do deterministic compile-time bounds checking
   239	 * n/a = no run-time bounds checking needed since compile-time deterministic
   240	 * b = perform run-time bounds checking
   241	 * B = can perform run-time bounds checking, but current unenforced
   242	 * V = vulnerable to run-time overflow
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
 > 267				__write_overflow_field(p_size_field, size);
   268			/*
   269			 * Warn for source field over-read when building with W=1
   270			 * or when an over-write happened, so both can be fixed at
   271			 * the same time.
   272			 */
   273			if ((IS_ENABLED(KBUILD_EXTRA_WARN1) || p_size_field < size) &&
   274			    q_size_field < size)
   275				__read_overflow2_field(q_size_field, size);
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
