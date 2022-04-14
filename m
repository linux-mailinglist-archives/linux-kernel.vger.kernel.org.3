Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A19450189E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbiDNQO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347774AbiDNQKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 12:10:13 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19DC93183
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649951754; x=1681487754;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Cox/lk173R1lAWkMXSn8T0qitOusiwh1PkHxQFAhQ88=;
  b=ZmQdnfIEbLfMFkGl4u7e0onE2Dn6lgv8p9X4tOp6YOz2lVpVHGX7c/Au
   ocPMXmXv9L5aGt4Fda2YHNUA5XAkLEc5B79qnZ9j4QTYRTU3ggkQyudI6
   884rnS4LccCme0eu86MVIEGOwm2aIxo6klziW/EOjrPtEY+uQ71JvOYTV
   K5n+Gr1ezepgEQ0Xm2isfQF9wFldEkIxOgOuSdxaU4hK36zHKLUJYvbRE
   ihrF+JtR76boSs4bsChb17CiSkqldJyPfN2YvTM9JUhe0aXUtS0dLoFr1
   ZZbJ3QVp2LhFoECFEyiKXTDv+qreGwRNYkUbHLmEdZvYx7ZT215dplot2
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="243549331"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="243549331"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 08:54:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="508457350"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 14 Apr 2022 08:54:18 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nf1nV-00015l-Ll;
        Thu, 14 Apr 2022 15:54:17 +0000
Date:   Thu, 14 Apr 2022 23:54:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: include/linux/fortify-string.h:267:25: warning: call to
 '__write_overflow_field' declared with attribute warning: detected write
 beyond size of field (1st parameter); maybe use struct_group()?
Message-ID: <202204142318.vDqjjSFn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
head:   a19944809fe9942e6a96292490717904d0690c21
commit: f68f2ff91512c199ec24883001245912afc17873 fortify: Detect struct member overflows in memcpy() at compile-time
date:   9 weeks ago
config: arm-randconfig-r012-20220414 (https://download.01.org/0day-ci/archive/20220414/202204142318.vDqjjSFn-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f68f2ff91512c199ec24883001245912afc17873
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f68f2ff91512c199ec24883001245912afc17873
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/usb/serial/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/string.h:253,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from drivers/usb/serial/whiteheat.c:17:
   In function 'fortify_memcpy_chk',
       inlined from 'firm_send_command' at drivers/usb/serial/whiteheat.c:587:4:
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
