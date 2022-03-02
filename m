Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B264CA2A5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 12:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241138AbiCBLB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 06:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbiCBLB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 06:01:56 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3565F6D85C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 03:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646218873; x=1677754873;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SnTi0TOdYsSei3g1dNB+2AeawdL74DNfmP4PMy+W/Qk=;
  b=K0c6ySohy5d9P0y/fcdooFKYsL8JH4lLyCeWd/X858Gy2E5JyYPaLZ/T
   4quMu1Q3ogIxRue4wGOI1fLnE5koxFuwpubcLCqza5dW2fRj1dMe9Bz/Q
   ZCpyDGVfD7bZT5rnV0nGg9vrC3vaUxrQy62IDRorD/aPLPvn/BI5cIUN6
   E/2KsfY8xlfoX8Lb1zmAOlA8N00WCOuYxzC62cEDQmxWngbD4Xgv7hI8y
   zr1gLtYwpJqw3y9ekrvNWcGcP+z6O73ZSXKSJYHBpyqs3KVES1Si0y+Zv
   Xa2fMkandT7TLs277+ErBk8iIJEE+mDU1UInJU3q8UV+zokivBZvvMv74
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="253298945"
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="253298945"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 03:01:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="535346253"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 02 Mar 2022 03:01:11 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPMhB-0001L9-3u; Wed, 02 Mar 2022 10:59:01 +0000
Date:   Wed, 2 Mar 2022 18:58:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: arch/s390/kernel/syscall.c:56:1: sparse: sparse: Using plain integer
 as NULL pointer
Message-ID: <202203021808.beYRnzDb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fb184c4af9b9f4563e7a126219389986a71d5b5b
commit: 56e62a73702836017564eaacd5212e4d0fa1c01d s390: convert to generic entry
date:   1 year, 1 month ago
config: s390-randconfig-s031-20220302 (https://download.01.org/0day-ci/archive/20220302/202203021808.beYRnzDb-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=56e62a73702836017564eaacd5212e4d0fa1c01d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 56e62a73702836017564eaacd5212e4d0fa1c01d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash arch/s390/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/s390/kernel/syscall.c:56:1: sparse: sparse: Using plain integer as NULL pointer
>> arch/s390/kernel/syscall.c:56:1: sparse: sparse: Using plain integer as NULL pointer

vim +56 arch/s390/kernel/syscall.c

^1da177e4c3f41 arch/s390/kernel/sys_s390.c Linus Torvalds    2005-04-16  55  
a4679373cf4ee0 arch/s390/kernel/sys_s390.c Christoph Hellwig 2010-03-10 @56  SYSCALL_DEFINE1(mmap2, struct s390_mmap_arg_struct __user *, arg)
^1da177e4c3f41 arch/s390/kernel/sys_s390.c Linus Torvalds    2005-04-16  57  {
a4679373cf4ee0 arch/s390/kernel/sys_s390.c Christoph Hellwig 2010-03-10  58  	struct s390_mmap_arg_struct a;
^1da177e4c3f41 arch/s390/kernel/sys_s390.c Linus Torvalds    2005-04-16  59  	int error = -EFAULT;
^1da177e4c3f41 arch/s390/kernel/sys_s390.c Linus Torvalds    2005-04-16  60  
^1da177e4c3f41 arch/s390/kernel/sys_s390.c Linus Torvalds    2005-04-16  61  	if (copy_from_user(&a, arg, sizeof(a)))
^1da177e4c3f41 arch/s390/kernel/sys_s390.c Linus Torvalds    2005-04-16  62  		goto out;
a90f590a1bee36 arch/s390/kernel/sys_s390.c Dominik Brodowski 2018-03-11  63  	error = ksys_mmap_pgoff(a.addr, a.len, a.prot, a.flags, a.fd, a.offset);
^1da177e4c3f41 arch/s390/kernel/sys_s390.c Linus Torvalds    2005-04-16  64  out:
^1da177e4c3f41 arch/s390/kernel/sys_s390.c Linus Torvalds    2005-04-16  65  	return error;
^1da177e4c3f41 arch/s390/kernel/sys_s390.c Linus Torvalds    2005-04-16  66  }
^1da177e4c3f41 arch/s390/kernel/sys_s390.c Linus Torvalds    2005-04-16  67  

:::::: The code at line 56 was first introduced by commit
:::::: a4679373cf4ee0e7792dc56205365732b725c2c1 Add generic sys_old_mmap()

:::::: TO: Christoph Hellwig <hch@lst.de>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
