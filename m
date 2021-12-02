Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472B4466046
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356377AbhLBJ1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:27:39 -0500
Received: from mga14.intel.com ([192.55.52.115]:50523 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356342AbhLBJ1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:27:35 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="236898111"
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="236898111"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 01:24:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="500659586"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 02 Dec 2021 01:24:11 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1msiK2-000G7r-Tu; Thu, 02 Dec 2021 09:24:10 +0000
Date:   Thu, 2 Dec 2021 17:24:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yejune Deng <yejune.deng@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Rich Felker <dalias@libc.org>
Subject: arch/sh/kernel/crash_dump.c:37:61: sparse: sparse: incorrect type in
 argument 2 (different address spaces)
Message-ID: <202112021718.p7G5HuSW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   58e1100fdc5990b0cc0d4beaf2562a92e621ac7d
commit: 12285ff8667bf06c168113c10d3619834e423ae6 sh: kdump: add some attribute to function
date:   3 months ago
config: sh-randconfig-s032-20211202 (https://download.01.org/0day-ci/archive/20211202/202112021718.p7G5HuSW-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=12285ff8667bf06c168113c10d3619834e423ae6
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 12285ff8667bf06c168113c10d3619834e423ae6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sh SHELL=/bin/bash arch/sh/kernel/ fs/proc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/sh/kernel/crash_dump.c:37:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void [noderef] __iomem * @@
   arch/sh/kernel/crash_dump.c:37:61: sparse:     expected void const *from
   arch/sh/kernel/crash_dump.c:37:61: sparse:     got void [noderef] __iomem *
>> arch/sh/kernel/crash_dump.c:42:28: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *__from @@     got void [noderef] __iomem * @@
   arch/sh/kernel/crash_dump.c:42:28: sparse:     expected void const *__from
   arch/sh/kernel/crash_dump.c:42:28: sparse:     got void [noderef] __iomem *

vim +37 arch/sh/kernel/crash_dump.c

    12	
    13	/**
    14	 * copy_oldmem_page - copy one page from "oldmem"
    15	 * @pfn: page frame number to be copied
    16	 * @buf: target memory address for the copy; this can be in kernel address
    17	 *	space or user address space (see @userbuf)
    18	 * @csize: number of bytes to copy
    19	 * @offset: offset in bytes into the page (based on pfn) to begin the copy
    20	 * @userbuf: if set, @buf is in user address space, use copy_to_user(),
    21	 *	otherwise @buf is in kernel address space, use memcpy().
    22	 *
    23	 * Copy a page from "oldmem". For this page, there is no pte mapped
    24	 * in the current kernel. We stitch up a pte, similar to kmap_atomic.
    25	 */
    26	ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
    27	                               size_t csize, unsigned long offset, int userbuf)
    28	{
    29		void  __iomem *vaddr;
    30	
    31		if (!csize)
    32			return 0;
    33	
    34		vaddr = ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);
    35	
    36		if (userbuf) {
  > 37			if (copy_to_user((void __user *)buf, (vaddr + offset), csize)) {
    38				iounmap(vaddr);
    39				return -EFAULT;
    40			}
    41		} else
  > 42		memcpy(buf, (vaddr + offset), csize);

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
