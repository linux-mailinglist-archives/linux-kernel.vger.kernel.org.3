Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CF646DDE7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 22:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237668AbhLHV6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 16:58:19 -0500
Received: from mga11.intel.com ([192.55.52.93]:60216 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232640AbhLHV6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 16:58:19 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="235470580"
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="235470580"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 13:41:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="480071395"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 08 Dec 2021 13:40:58 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mv4gL-00015P-RE; Wed, 08 Dec 2021 21:40:57 +0000
Date:   Thu, 9 Dec 2021 05:40:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Brian Kim <brian.kim@hardkernel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Dongjin Kim <tobetter@gmail.com>,
        memeka <mihailescu2m@gmail.com>, Yang Deokgyu <secugyu@gmail.com>
Subject: [tobetter:odroid-5.16.y 20/75] drivers/char/exynos-gpiomem.c:121:22:
 error: implicit declaration of function 'phys_mem_access_prot'
Message-ID: <202112090524.JyN1VmD0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/tobetter/linux odroid-5.16.y
head:   04f296b5f991198f16f76ba15a23e9e00e30aac4
commit: 6720769118c835b66f65eb40c2d476fd615d9549 [20/75] ODROID-XU4: char: exynos: add /dev/gpiomem device for rootless user GPIO access
config: hexagon-randconfig-r021-20211207 (https://download.01.org/0day-ci/archive/20211209/202112090524.JyN1VmD0-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/tobetter/linux/commit/6720769118c835b66f65eb40c2d476fd615d9549
        git remote add tobetter https://github.com/tobetter/linux
        git fetch --no-tags tobetter odroid-5.16.y
        git checkout 6720769118c835b66f65eb40c2d476fd615d9549
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/char/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/char/exynos-gpiomem.c:121:22: error: implicit declaration of function 'phys_mem_access_prot' [-Werror,-Wimplicit-function-declaration]
           vma->vm_page_prot = phys_mem_access_prot(file, vma->vm_pgoff,
                               ^
>> drivers/char/exynos-gpiomem.c:121:20: error: assigning to 'pgprot_t' from incompatible type 'int'
           vma->vm_page_prot = phys_mem_access_prot(file, vma->vm_pgoff,
                             ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 errors generated.


vim +/phys_mem_access_prot +121 drivers/char/exynos-gpiomem.c

   106	
   107	static int exynos_gpiomem_mmap(struct file *file, struct vm_area_struct *vma)
   108	{
   109		int gpio_area = 0;
   110	
   111		while (gpio_area < inst->gpio_area_count) {
   112			if ((inst->gpio_regs_phys[gpio_area] >> PAGE_SHIFT) == vma->vm_pgoff)
   113				goto found;
   114	
   115			gpio_area++;
   116		}
   117	
   118		return -EACCES;
   119	
   120	found:
 > 121		vma->vm_page_prot = phys_mem_access_prot(file, vma->vm_pgoff,
   122				PAGE_SIZE,
   123				vma->vm_page_prot);
   124	
   125		vma->vm_ops = &exynos_gpiomem_vm_ops;
   126	
   127		if (remap_pfn_range(vma, vma->vm_start,
   128					vma->vm_pgoff,
   129					PAGE_SIZE,
   130					vma->vm_page_prot)) {
   131			return -EAGAIN;
   132		}
   133	
   134		return 0;
   135	}
   136	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
