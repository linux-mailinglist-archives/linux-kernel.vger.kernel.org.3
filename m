Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005FD4FAAF0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 23:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiDIV3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 17:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbiDIV3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 17:29:33 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B640120A3A9
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 14:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649539644; x=1681075644;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9o6LJXVz00we+EG+mWekVd4qIbdAT9iND7KWvwguPOc=;
  b=O5hg5QmYrABN0XsNy1T4FDlXtRFfwmDNo9vXTOrTVciu5Y0I3jKwGGmj
   aChqYpA3/vBK/F8+pVhVUkImEG9VTSVKRv5PRAV4lJ5smnfQuzgVlilu/
   50CPRsqavafsMPpXeDe0XYgCcnq75hjhLKaZD6YRWh3goMTgUUTsdwHRp
   CSWSTrNPfKUXD531pLgMZ5dwRBSXsmdWHTb6T8N/f+fOxYPurKZ6P8FmX
   A3h7eqJjWL6UDPKNsxPRq5ybuF/dRo4SEYGMzpJnFfPeitCAyX8MgN1ep
   r/zq6585u46KxeaAIgHT63eHEjFvDuCzKaktgsjRpBAk/OwCfpwGGGrAT
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10312"; a="242502476"
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; 
   d="scan'208";a="242502476"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2022 14:27:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; 
   d="scan'208";a="698839645"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2022 14:27:22 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndIc6-0000PO-CG;
        Sat, 09 Apr 2022 21:27:22 +0000
Date:   Sun, 10 Apr 2022 05:27:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     popcornmix <popcornmix@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.org>,
        Christian Lamparter <chunkeey@gmail.com>,
        Christopher Blake <chrisrblake93@gmail.com>
Subject: [l1k:smsc95xx_5.17 74/888]
 arch/arm/lib/uaccess_with_memcpy.c:211:30: warning: variable 'temp' set but
 not used
Message-ID: <202204100511.otOdzGCX-lkp@intel.com>
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

tree:   https://github.com/l1k/linux smsc95xx_5.17
head:   240f56c27361c195cd502d95aba51c6b8e5b808c
commit: 375b90433562ce3545ccda0376716268ff974114 [74/888] Improve __copy_to_user and __copy_from_user performance
config: arm-randconfig-c003-20220408 (https://download.01.org/0day-ci/archive/20220410/202204100511.otOdzGCX-lkp@intel.com/config)
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

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   arm-linux-gnueabi-ld: arch/arm/mm/proc-xscale.o: in function `xscale_dma_unmap_area':
>> (.text+0x25c): undefined reference to `xscale_80200_A0_A1_dma_inv_range'
   arm-linux-gnueabi-ld: (.text+0x260): undefined reference to `xscale_80200_A0_A1_dma_clean_range'
   arm-linux-gnueabi-ld: arch/arm/mm/proc-syms.o:(___ksymtab+xscale_dma_clean_range+0x0): undefined reference to `xscale_dma_clean_range'
   arm-linux-gnueabi-ld: arch/arm/mm/proc-syms.o:(___ksymtab+xscale_dma_inv_range+0x0): undefined reference to `xscale_dma_inv_range'
--
   arch/arm/lib/uaccess_with_memcpy.c:137:1: warning: no previous prototype for '__copy_to_user_memcpy' [-Wmissing-prototypes]
     137 | __copy_to_user_memcpy(void __user *to, const void *from, unsigned long n)
         | ^~~~~~~~~~~~~~~~~~~~~
   arch/arm/lib/uaccess_with_memcpy.c:190:1: warning: no previous prototype for '__copy_from_user_memcpy' [-Wmissing-prototypes]
     190 | __copy_from_user_memcpy(void *to, const void __user *from, unsigned long n)
         | ^~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/lib/uaccess_with_memcpy.c: In function '__copy_from_user_memcpy':
>> arch/arm/lib/uaccess_with_memcpy.c:211:30: warning: variable 'temp' set but not used [-Wunused-but-set-variable]
     211 |                         char temp;
         |                              ^~~~


vim +/temp +211 arch/arm/lib/uaccess_with_memcpy.c

   188	
   189	unsigned long noinline
   190	__copy_from_user_memcpy(void *to, const void __user *from, unsigned long n)
   191	{
   192		unsigned long ua_flags;
   193		int atomic;
   194	
   195		if (unlikely(uaccess_kernel())) {
   196			memcpy(to, (const void *)from, n);
   197			return 0;
   198		}
   199	
   200		/* the mmap semaphore is taken only if not in an atomic context */
   201		atomic = in_atomic();
   202	
   203		if (!atomic)
   204			mmap_read_lock(current->mm);
   205		while (n) {
   206			pte_t *pte;
   207			spinlock_t *ptl;
   208			int tocopy;
   209	
   210			while (!pin_page_for_read(from, &pte, &ptl)) {
 > 211				char temp;
   212				if (!atomic)
   213					mmap_read_unlock(current->mm);
   214				if (__get_user(temp, (char __user *)from))
   215					goto out;
   216				if (!atomic)
   217					mmap_read_lock(current->mm);
   218			}
   219	
   220			tocopy = (~(unsigned long)from & ~PAGE_MASK) + 1;
   221			if (tocopy > n)
   222				tocopy = n;
   223	
   224			ua_flags = uaccess_save_and_enable();
   225			memcpy(to, (const void *)from, tocopy);
   226			uaccess_restore(ua_flags);
   227			to += tocopy;
   228			from += tocopy;
   229			n -= tocopy;
   230	
   231			pte_unmap_unlock(pte, ptl);
   232		}
   233		if (!atomic)
   234			mmap_read_unlock(current->mm);
   235	
   236	out:
   237		return n;
   238	}
   239	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
