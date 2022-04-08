Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817FD4F9BF4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 19:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbiDHRsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 13:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbiDHRsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 13:48:08 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5145D24948
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 10:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649439961; x=1680975961;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8MQrW2cQdTJYQiTVd2QlUFiCFLoHQQW+6hkqj+kpU2c=;
  b=e1TJt5i5I+S7MRcj4vSMYZUtrTUEIrpoJH/FEhlxgO+GYMDkkHgCIYrS
   ejsGjVItrNQQw9qlleJgIaB7RjjvsKVp2tNUkHvh/XZ4rQYkF2nf11Cmk
   mHA7OmE1wIAOY7GwDTmahQm+ccsH+H60T+dhVRnk2OAVJj4J27bdsjTiW
   1CCQnaBgGVKRBmI7LCMmUX4vYbGVmeu7Nw5V0N83WaicUFT+V2GsQEC+P
   dD3/jBmzQpe3xU8QebQXEAxyfjstDK5YlV0x0nGecuLAQk5igs6SdGmb8
   tkDOopGiOQGVSh6AlOjqJLv1rY3gG+Ajg0vo4hFGqgwwd2o/k6IKY5O+q
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="261642527"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="261642527"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 10:46:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="506643431"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 08 Apr 2022 10:45:58 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncsgI-0000VZ-8i;
        Fri, 08 Apr 2022 17:45:58 +0000
Date:   Sat, 9 Apr 2022 01:45:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     popcornmix <popcornmix@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.org>,
        Christian Lamparter <chunkeey@gmail.com>,
        Christopher Blake <chrisrblake93@gmail.com>
Subject: [l1k:smsc95xx_5.17 74/887] arch/arm/lib/uaccess_with_memcpy.c:137:1:
 warning: no previous prototype for '__copy_to_user_memcpy'
Message-ID: <202204090126.gjg3vnZv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/l1k/linux smsc95xx_5.17
head:   05d68ced287b30f62f18f95b5476135ef669804a
commit: 375b90433562ce3545ccda0376716268ff974114 [74/887] Improve __copy_to_user and __copy_from_user performance
config: arm-randconfig-p002-20220408 (https://download.01.org/0day-ci/archive/20220409/202204090126.gjg3vnZv-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/l1k/linux/commit/375b90433562ce3545ccda0376716268ff974114
        git remote add l1k https://github.com/l1k/linux
        git fetch --no-tags l1k smsc95xx_5.17
        git checkout 375b90433562ce3545ccda0376716268ff974114
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash
reproduce (cppcheck warning):
        # apt-get install cppcheck
        git checkout 375b90433562ce3545ccda0376716268ff974114
        cppcheck --quiet --enable=style,performance,portability --template=gcc FILE

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm/lib/uaccess_with_memcpy.c:137:1: warning: no previous prototype for '__copy_to_user_memcpy' [-Wmissing-prototypes]
     137 | __copy_to_user_memcpy(void __user *to, const void *from, unsigned long n)
         | ^~~~~~~~~~~~~~~~~~~~~
>> arch/arm/lib/uaccess_with_memcpy.c:190:1: warning: no previous prototype for '__copy_from_user_memcpy' [-Wmissing-prototypes]
     190 | __copy_from_user_memcpy(void *to, const void __user *from, unsigned long n)
         | ^~~~~~~~~~~~~~~~~~~~~~~


cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> arch/arm/mm/fault.c:539:28: warning: Shifting signed 32-bit value by 31 bits is implementation-defined behaviour [shiftTooManyBitsSigned]
    if (!inf->fn(addr, fsr & ~FSR_LNX_PF, regs))
                              ^
   arch/arm/mm/fault.c:569:28: warning: Shifting signed 32-bit value by 31 bits is implementation-defined behaviour [shiftTooManyBitsSigned]
    if (!inf->fn(addr, ifsr | FSR_LNX_PF, regs))
                              ^
>> arch/arm/mm/fault.c:539:28: warning: Signed integer overflow for expression '1<<31'. [integerOverflow]
    if (!inf->fn(addr, fsr & ~FSR_LNX_PF, regs))
                              ^
   arch/arm/mm/fault.c:569:28: warning: Signed integer overflow for expression '1<<31'. [integerOverflow]
    if (!inf->fn(addr, ifsr | FSR_LNX_PF, regs))
                              ^
   arch/arm/mm/fault.c:279:12: warning: Shifting signed 32-bit value by 31 bits is implementation-defined behaviour [shiftTooManyBitsSigned]
    if (fsr & FSR_LNX_PF) {
              ^
   arch/arm/mm/fault.c:279:12: warning: Signed integer overflow for expression '1<<31'. [integerOverflow]
    if (fsr & FSR_LNX_PF) {
              ^

vim +/__copy_to_user_memcpy +137 arch/arm/lib/uaccess_with_memcpy.c

375b90433562ce popcornmix        2016-11-28  135  
375b90433562ce popcornmix        2016-11-28  136  unsigned long noinline
cb9dc92c0a1b76 Nicolas Pitre     2009-05-21 @137  __copy_to_user_memcpy(void __user *to, const void *from, unsigned long n)
39ec58f3fea47c Lennert Buytenhek 2009-03-09  138  {
c014953d84ec21 Russell King      2015-12-05  139  	unsigned long ua_flags;
39ec58f3fea47c Lennert Buytenhek 2009-03-09  140  	int atomic;
39ec58f3fea47c Lennert Buytenhek 2009-03-09  141  
db68ce10c4f0a2 Al Viro           2017-03-20  142  	if (uaccess_kernel()) {
39ec58f3fea47c Lennert Buytenhek 2009-03-09  143  		memcpy((void *)to, from, n);
39ec58f3fea47c Lennert Buytenhek 2009-03-09  144  		return 0;
39ec58f3fea47c Lennert Buytenhek 2009-03-09  145  	}
39ec58f3fea47c Lennert Buytenhek 2009-03-09  146  
39ec58f3fea47c Lennert Buytenhek 2009-03-09  147  	/* the mmap semaphore is taken only if not in an atomic context */
0f64b247e63ac8 Nicolas Pitre     2015-08-12  148  	atomic = faulthandler_disabled();
39ec58f3fea47c Lennert Buytenhek 2009-03-09  149  
39ec58f3fea47c Lennert Buytenhek 2009-03-09  150  	if (!atomic)
d8ed45c5dcd455 Michel Lespinasse 2020-06-08  151  		mmap_read_lock(current->mm);
39ec58f3fea47c Lennert Buytenhek 2009-03-09  152  	while (n) {
39ec58f3fea47c Lennert Buytenhek 2009-03-09  153  		pte_t *pte;
39ec58f3fea47c Lennert Buytenhek 2009-03-09  154  		spinlock_t *ptl;
39ec58f3fea47c Lennert Buytenhek 2009-03-09  155  		int tocopy;
39ec58f3fea47c Lennert Buytenhek 2009-03-09  156  
39ec58f3fea47c Lennert Buytenhek 2009-03-09  157  		while (!pin_page_for_write(to, &pte, &ptl)) {
39ec58f3fea47c Lennert Buytenhek 2009-03-09  158  			if (!atomic)
d8ed45c5dcd455 Michel Lespinasse 2020-06-08  159  				mmap_read_unlock(current->mm);
39ec58f3fea47c Lennert Buytenhek 2009-03-09  160  			if (__put_user(0, (char __user *)to))
39ec58f3fea47c Lennert Buytenhek 2009-03-09  161  				goto out;
39ec58f3fea47c Lennert Buytenhek 2009-03-09  162  			if (!atomic)
d8ed45c5dcd455 Michel Lespinasse 2020-06-08  163  				mmap_read_lock(current->mm);
39ec58f3fea47c Lennert Buytenhek 2009-03-09  164  		}
39ec58f3fea47c Lennert Buytenhek 2009-03-09  165  
39ec58f3fea47c Lennert Buytenhek 2009-03-09  166  		tocopy = (~(unsigned long)to & ~PAGE_MASK) + 1;
39ec58f3fea47c Lennert Buytenhek 2009-03-09  167  		if (tocopy > n)
39ec58f3fea47c Lennert Buytenhek 2009-03-09  168  			tocopy = n;
39ec58f3fea47c Lennert Buytenhek 2009-03-09  169  
c014953d84ec21 Russell King      2015-12-05  170  		ua_flags = uaccess_save_and_enable();
39ec58f3fea47c Lennert Buytenhek 2009-03-09  171  		memcpy((void *)to, from, tocopy);
c014953d84ec21 Russell King      2015-12-05  172  		uaccess_restore(ua_flags);
39ec58f3fea47c Lennert Buytenhek 2009-03-09  173  		to += tocopy;
39ec58f3fea47c Lennert Buytenhek 2009-03-09  174  		from += tocopy;
39ec58f3fea47c Lennert Buytenhek 2009-03-09  175  		n -= tocopy;
39ec58f3fea47c Lennert Buytenhek 2009-03-09  176  
a3a9ea656d1925 Steven Capper     2013-10-14  177  		if (pte)
39ec58f3fea47c Lennert Buytenhek 2009-03-09  178  			pte_unmap_unlock(pte, ptl);
a3a9ea656d1925 Steven Capper     2013-10-14  179  		else
a3a9ea656d1925 Steven Capper     2013-10-14  180  			spin_unlock(ptl);
39ec58f3fea47c Lennert Buytenhek 2009-03-09  181  	}
39ec58f3fea47c Lennert Buytenhek 2009-03-09  182  	if (!atomic)
d8ed45c5dcd455 Michel Lespinasse 2020-06-08  183  		mmap_read_unlock(current->mm);
39ec58f3fea47c Lennert Buytenhek 2009-03-09  184  
39ec58f3fea47c Lennert Buytenhek 2009-03-09  185  out:
39ec58f3fea47c Lennert Buytenhek 2009-03-09  186  	return n;
39ec58f3fea47c Lennert Buytenhek 2009-03-09  187  }
39ec58f3fea47c Lennert Buytenhek 2009-03-09  188  
375b90433562ce popcornmix        2016-11-28  189  unsigned long noinline
375b90433562ce popcornmix        2016-11-28 @190  __copy_from_user_memcpy(void *to, const void __user *from, unsigned long n)
375b90433562ce popcornmix        2016-11-28  191  {
375b90433562ce popcornmix        2016-11-28  192  	unsigned long ua_flags;
375b90433562ce popcornmix        2016-11-28  193  	int atomic;
375b90433562ce popcornmix        2016-11-28  194  
375b90433562ce popcornmix        2016-11-28  195  	if (unlikely(uaccess_kernel())) {
375b90433562ce popcornmix        2016-11-28  196  		memcpy(to, (const void *)from, n);
375b90433562ce popcornmix        2016-11-28  197  		return 0;
375b90433562ce popcornmix        2016-11-28  198  	}
375b90433562ce popcornmix        2016-11-28  199  
375b90433562ce popcornmix        2016-11-28  200  	/* the mmap semaphore is taken only if not in an atomic context */
375b90433562ce popcornmix        2016-11-28  201  	atomic = in_atomic();
375b90433562ce popcornmix        2016-11-28  202  
375b90433562ce popcornmix        2016-11-28  203  	if (!atomic)
375b90433562ce popcornmix        2016-11-28  204  		mmap_read_lock(current->mm);
375b90433562ce popcornmix        2016-11-28  205  	while (n) {
375b90433562ce popcornmix        2016-11-28  206  		pte_t *pte;
375b90433562ce popcornmix        2016-11-28  207  		spinlock_t *ptl;
375b90433562ce popcornmix        2016-11-28  208  		int tocopy;
375b90433562ce popcornmix        2016-11-28  209  
375b90433562ce popcornmix        2016-11-28  210  		while (!pin_page_for_read(from, &pte, &ptl)) {
375b90433562ce popcornmix        2016-11-28  211  			char temp;
375b90433562ce popcornmix        2016-11-28  212  			if (!atomic)
375b90433562ce popcornmix        2016-11-28  213  				mmap_read_unlock(current->mm);
375b90433562ce popcornmix        2016-11-28  214  			if (__get_user(temp, (char __user *)from))
375b90433562ce popcornmix        2016-11-28  215  				goto out;
375b90433562ce popcornmix        2016-11-28  216  			if (!atomic)
375b90433562ce popcornmix        2016-11-28  217  				mmap_read_lock(current->mm);
375b90433562ce popcornmix        2016-11-28  218  		}
375b90433562ce popcornmix        2016-11-28  219  
375b90433562ce popcornmix        2016-11-28  220  		tocopy = (~(unsigned long)from & ~PAGE_MASK) + 1;
375b90433562ce popcornmix        2016-11-28  221  		if (tocopy > n)
375b90433562ce popcornmix        2016-11-28  222  			tocopy = n;
375b90433562ce popcornmix        2016-11-28  223  
375b90433562ce popcornmix        2016-11-28  224  		ua_flags = uaccess_save_and_enable();
375b90433562ce popcornmix        2016-11-28  225  		memcpy(to, (const void *)from, tocopy);
375b90433562ce popcornmix        2016-11-28  226  		uaccess_restore(ua_flags);
375b90433562ce popcornmix        2016-11-28  227  		to += tocopy;
375b90433562ce popcornmix        2016-11-28  228  		from += tocopy;
375b90433562ce popcornmix        2016-11-28  229  		n -= tocopy;
375b90433562ce popcornmix        2016-11-28  230  
375b90433562ce popcornmix        2016-11-28  231  		pte_unmap_unlock(pte, ptl);
375b90433562ce popcornmix        2016-11-28  232  	}
375b90433562ce popcornmix        2016-11-28  233  	if (!atomic)
375b90433562ce popcornmix        2016-11-28  234  		mmap_read_unlock(current->mm);
375b90433562ce popcornmix        2016-11-28  235  
375b90433562ce popcornmix        2016-11-28  236  out:
375b90433562ce popcornmix        2016-11-28  237  	return n;
375b90433562ce popcornmix        2016-11-28  238  }
375b90433562ce popcornmix        2016-11-28  239  

:::::: The code at line 137 was first introduced by commit
:::::: cb9dc92c0a1b76165c8c334402e27191084b2047 [ARM] lower overhead with alternative copy_to_user for small copies

:::::: TO: Nicolas Pitre <nico@cam.org>
:::::: CC: Nicolas Pitre <nico@cam.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
