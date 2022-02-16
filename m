Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B18B4B93A1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 23:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236335AbiBPWHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 17:07:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiBPWHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 17:07:06 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD91170D78;
        Wed, 16 Feb 2022 14:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645049213; x=1676585213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eh2+wIJwPhsyAITQqGz0mlyqdm1obMslzcq+p1zNUzQ=;
  b=f0jieK8bhAdFI/MKBCWp+pua7WedLsNDK7X0RjpJrS5+atayQZF8/V7G
   Gz6DtASPwKDRWMl2yUvUT8UTOtKhK4IhgyO5erVo8jmcSCjsPTInyAtEA
   Ytm8rFE7886kgsBmGJ0pobFS4mKxZI+Zb5gAYK21k/69qBGAJujdO4vO4
   S7f+q+WNwc+MPVp0ys90/G/2hrFSxb6c+/nwtx/WsA3w6GC4Q9d9Yt8Jd
   wGyij0crfhGsBdEC+TOLxbldFH91QDXY2RF5iUYavl5XzUYRrF+hh87F+
   /eIVFrT/0wqYZHbFinjy0Dc7u06z/dPefImDvQc4/A/mOSCceCsUiiLmS
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="311476979"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="311476979"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 14:06:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="500179434"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 16 Feb 2022 14:06:51 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKSRm-000BAC-JJ; Wed, 16 Feb 2022 22:06:50 +0000
Date:   Thu, 17 Feb 2022 06:06:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     kbuild-all@lists.01.org, Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lkdtm/usercopy: Expand size of "out of frame" object
Message-ID: <202202170604.hO1q7HZU-lkp@intel.com>
References: <20220216201743.2088344-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216201743.2088344-1-keescook@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

I love your patch! Yet something to improve:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on soc/for-next kees/for-next/pstore v5.17-rc4 next-20220216]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Kees-Cook/lkdtm-usercopy-Expand-size-of-out-of-frame-object/20220217-041936
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git e6cb9c167eeb8f90ab924666c573e69e85e700a0
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20220217/202202170604.hO1q7HZU-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/aa676e88f535bd79a3e22a1cc70c9b6cc51dbbfe
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Kees-Cook/lkdtm-usercopy-Expand-size-of-out-of-frame-object/20220217-041936
        git checkout aa676e88f535bd79a3e22a1cc70c9b6cc51dbbfe
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash drivers/misc/lkdtm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:29,
                    from drivers/misc/lkdtm/lkdtm.h:7,
                    from drivers/misc/lkdtm/usercopy.c:6:
   drivers/misc/lkdtm/usercopy.c: In function 'do_usercopy_stack':
>> drivers/misc/lkdtm/usercopy.c:74:46: error: 'current_stack_pointer' undeclared (first use in this function); did you mean 'kernel_stack_pointer'?
      74 |         pr_info("stack     : %px\n", (void *)current_stack_pointer);
         |                                              ^~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:418:33: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:519:9: note: in expansion of macro 'printk'
     519 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   drivers/misc/lkdtm/usercopy.c:74:9: note: in expansion of macro 'pr_info'
      74 |         pr_info("stack     : %px\n", (void *)current_stack_pointer);
         |         ^~~~~~~
   drivers/misc/lkdtm/usercopy.c:74:46: note: each undeclared identifier is reported only once for each function it appears in
      74 |         pr_info("stack     : %px\n", (void *)current_stack_pointer);
         |                                              ^~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:418:33: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:519:9: note: in expansion of macro 'printk'
     519 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   drivers/misc/lkdtm/usercopy.c:74:9: note: in expansion of macro 'pr_info'
      74 |         pr_info("stack     : %px\n", (void *)current_stack_pointer);
         |         ^~~~~~~


vim +74 drivers/misc/lkdtm/usercopy.c

   > 6	#include "lkdtm.h"
     7	#include <linux/slab.h>
     8	#include <linux/vmalloc.h>
     9	#include <linux/sched/task_stack.h>
    10	#include <linux/mman.h>
    11	#include <linux/uaccess.h>
    12	#include <asm/cacheflush.h>
    13	
    14	/*
    15	 * Many of the tests here end up using const sizes, but those would
    16	 * normally be ignored by hardened usercopy, so force the compiler
    17	 * into choosing the non-const path to make sure we trigger the
    18	 * hardened usercopy checks by added "unconst" to all the const copies,
    19	 * and making sure "cache_size" isn't optimized into a const.
    20	 */
    21	static volatile size_t unconst;
    22	static volatile size_t cache_size = 1024;
    23	static struct kmem_cache *whitelist_cache;
    24	
    25	static const unsigned char test_text[] = "This is a test.\n";
    26	
    27	/*
    28	 * Instead of adding -Wno-return-local-addr, just pass the stack address
    29	 * through a function to obfuscate it from the compiler.
    30	 */
    31	static noinline unsigned char *trick_compiler(unsigned char *stack)
    32	{
    33		return stack + unconst;
    34	}
    35	
    36	static noinline unsigned char *do_usercopy_stack_callee(int value)
    37	{
    38		unsigned char buf[128];
    39		int i;
    40	
    41		/* Exercise stack to avoid everything living in registers. */
    42		for (i = 0; i < sizeof(buf); i++) {
    43			buf[i] = value & 0xff;
    44		}
    45	
    46		/*
    47		 * Put the target buffer in the middle of stack allocation
    48		 * so that we don't step on future stack users regardless
    49		 * of stack growth direction.
    50		 */
    51		return trick_compiler(&buf[(128/2)-32]);
    52	}
    53	
    54	static noinline void do_usercopy_stack(bool to_user, bool bad_frame)
    55	{
    56		unsigned long user_addr;
    57		unsigned char good_stack[32];
    58		unsigned char *bad_stack;
    59		int i;
    60	
    61		/* Exercise stack to avoid everything living in registers. */
    62		for (i = 0; i < sizeof(good_stack); i++)
    63			good_stack[i] = test_text[i % sizeof(test_text)];
    64	
    65		/* This is a pointer to outside our current stack frame. */
    66		if (bad_frame) {
    67			bad_stack = do_usercopy_stack_callee((uintptr_t)&bad_stack);
    68		} else {
    69			/* Put start address just inside stack. */
    70			bad_stack = task_stack_page(current) + THREAD_SIZE;
    71			bad_stack -= sizeof(unsigned long);
    72		}
    73	
  > 74		pr_info("stack     : %px\n", (void *)current_stack_pointer);
    75		pr_info("good_stack: %px-%px\n", good_stack, good_stack + sizeof(good_stack));
    76		pr_info("bad_stack : %px-%px\n", bad_stack, bad_stack + sizeof(good_stack));
    77	
    78		user_addr = vm_mmap(NULL, 0, PAGE_SIZE,
    79				    PROT_READ | PROT_WRITE | PROT_EXEC,
    80				    MAP_ANONYMOUS | MAP_PRIVATE, 0);
    81		if (user_addr >= TASK_SIZE) {
    82			pr_warn("Failed to allocate user memory\n");
    83			return;
    84		}
    85	
    86		if (to_user) {
    87			pr_info("attempting good copy_to_user of local stack\n");
    88			if (copy_to_user((void __user *)user_addr, good_stack,
    89					 unconst + sizeof(good_stack))) {
    90				pr_warn("copy_to_user failed unexpectedly?!\n");
    91				goto free_user;
    92			}
    93	
    94			pr_info("attempting bad copy_to_user of distant stack\n");
    95			if (copy_to_user((void __user *)user_addr, bad_stack,
    96					 unconst + sizeof(good_stack))) {
    97				pr_warn("copy_to_user failed, but lacked Oops\n");
    98				goto free_user;
    99			}
   100		} else {
   101			/*
   102			 * There isn't a safe way to not be protected by usercopy
   103			 * if we're going to write to another thread's stack.
   104			 */
   105			if (!bad_frame)
   106				goto free_user;
   107	
   108			pr_info("attempting good copy_from_user of local stack\n");
   109			if (copy_from_user(good_stack, (void __user *)user_addr,
   110					   unconst + sizeof(good_stack))) {
   111				pr_warn("copy_from_user failed unexpectedly?!\n");
   112				goto free_user;
   113			}
   114	
   115			pr_info("attempting bad copy_from_user of distant stack\n");
   116			if (copy_from_user(bad_stack, (void __user *)user_addr,
   117					   unconst + sizeof(good_stack))) {
   118				pr_warn("copy_from_user failed, but lacked Oops\n");
   119				goto free_user;
   120			}
   121		}
   122	
   123	free_user:
   124		vm_munmap(user_addr, PAGE_SIZE);
   125	}
   126	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
