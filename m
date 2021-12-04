Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69625468525
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 14:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385121AbhLDNtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 08:49:31 -0500
Received: from mga01.intel.com ([192.55.52.88]:46781 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1385117AbhLDNtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 08:49:18 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="261140439"
X-IronPort-AV: E=Sophos;i="5.87,287,1631602800"; 
   d="scan'208";a="261140439"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2021 05:45:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,287,1631602800"; 
   d="scan'208";a="598328709"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Dec 2021 05:45:51 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtVMM-000J3a-Uj; Sat, 04 Dec 2021 13:45:50 +0000
Date:   Sat, 4 Dec 2021 21:45:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: fs/proc/vmcore.c:161:34: sparse: sparse: incorrect type in argument
 1 (different address spaces)
Message-ID: <202112042119.Lqv1OiGv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   12119cfa1052d512a92524e90ebee85029a918f8
commit: c1e63117711977cc4295b2ce73de29dd17066c82 proc/vmcore: fix clearing user buffer by properly using clear_user()
date:   2 weeks ago
config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20211204/202112042119.Lqv1OiGv-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c1e63117711977cc4295b2ce73de29dd17066c82
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c1e63117711977cc4295b2ce73de29dd17066c82
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=ia64 SHELL=/bin/bash fs/proc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/proc/vmcore.c:161:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __user *p @@     got char *buf @@
   fs/proc/vmcore.c:161:34: sparse:     expected void const [noderef] __user *p
   fs/proc/vmcore.c:161:34: sparse:     got char *buf
>> fs/proc/vmcore.c:161:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user * @@     got char *buf @@
   fs/proc/vmcore.c:161:34: sparse:     expected void [noderef] __user *
   fs/proc/vmcore.c:161:34: sparse:     got char *buf

vim +161 fs/proc/vmcore.c

   133	
   134	/* Reads a page from the oldmem device from given offset. */
   135	ssize_t read_from_oldmem(char *buf, size_t count,
   136				 u64 *ppos, int userbuf,
   137				 bool encrypted)
   138	{
   139		unsigned long pfn, offset;
   140		size_t nr_bytes;
   141		ssize_t read = 0, tmp;
   142	
   143		if (!count)
   144			return 0;
   145	
   146		offset = (unsigned long)(*ppos % PAGE_SIZE);
   147		pfn = (unsigned long)(*ppos / PAGE_SIZE);
   148	
   149		down_read(&vmcore_cb_rwsem);
   150		do {
   151			if (count > (PAGE_SIZE - offset))
   152				nr_bytes = PAGE_SIZE - offset;
   153			else
   154				nr_bytes = count;
   155	
   156			/* If pfn is not ram, return zeros for sparse dump files */
   157			if (!pfn_is_ram(pfn)) {
   158				tmp = 0;
   159				if (!userbuf)
   160					memset(buf, 0, nr_bytes);
 > 161				else if (clear_user(buf, nr_bytes))
   162					tmp = -EFAULT;
   163			} else {
   164				if (encrypted)
   165					tmp = copy_oldmem_page_encrypted(pfn, buf,
   166									 nr_bytes,
   167									 offset,
   168									 userbuf);
   169				else
   170					tmp = copy_oldmem_page(pfn, buf, nr_bytes,
   171							       offset, userbuf);
   172			}
   173			if (tmp < 0) {
   174				up_read(&vmcore_cb_rwsem);
   175				return tmp;
   176			}
   177	
   178			*ppos += nr_bytes;
   179			count -= nr_bytes;
   180			buf += nr_bytes;
   181			read += nr_bytes;
   182			++pfn;
   183			offset = 0;
   184		} while (count);
   185	
   186		up_read(&vmcore_cb_rwsem);
   187		return read;
   188	}
   189	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
