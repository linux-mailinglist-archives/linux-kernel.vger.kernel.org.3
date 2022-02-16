Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F89A4B943E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 23:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238088AbiBPW6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 17:58:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236590AbiBPW6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 17:58:09 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0952A22BF;
        Wed, 16 Feb 2022 14:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645052276; x=1676588276;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3nDVg0ZMV12L+QQ0qFHSYQQ0u6Vucqad2IoLdsACIeQ=;
  b=T1nhiLlG2X+sqAxzlF6xxpIWUb9yUg9qTXAQK6ISPvO/PaaZ/5rX85rX
   cwyjZJnveIE+fD0Sq8j2uX0SjN5cpdEwUAuhztIeggOUfwlcr53OTUgEx
   wWneJGe/BcWkqSG+dEv0BoqPedV22fDatAoGBJ51+0VsKT2bHI3FIBETl
   oEGv2HSjAJOaKZjzt09ODw3SvqqEk+cVfR30C2QyJzwBcjlj4duV4q9lZ
   C7xZTar2/OOE/zV3JIvAb3tjop1x3uY1ZmCKvmuadkAHJ6/ujbUFYuouV
   L1hMzMXijJW3pF73TAgE3e8prbj3eL5I2+bWMjHdB+s3lSSY14cfN97qL
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="250684025"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="250684025"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 14:57:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="625651573"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Feb 2022 14:57:53 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKTFA-000BDA-UF; Wed, 16 Feb 2022 22:57:52 +0000
Date:   Thu, 17 Feb 2022 06:56:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lkdtm/usercopy: Expand size of "out of frame" object
Message-ID: <202202170613.eIFMv4np-lkp@intel.com>
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
config: hexagon-randconfig-r045-20220216 (https://download.01.org/0day-ci/archive/20220217/202202170613.eIFMv4np-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0e628a783b935c70c80815db6c061ec84f884af5)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/aa676e88f535bd79a3e22a1cc70c9b6cc51dbbfe
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Kees-Cook/lkdtm-usercopy-Expand-size-of-out-of-frame-object/20220217-041936
        git checkout aa676e88f535bd79a3e22a1cc70c9b6cc51dbbfe
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/misc/lkdtm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/misc/lkdtm/usercopy.c:74:39: error: use of undeclared identifier 'current_stack_pointer'
           pr_info("stack     : %px\n", (void *)current_stack_pointer);
                                                ^
   1 error generated.


vim +/current_stack_pointer +74 drivers/misc/lkdtm/usercopy.c

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
