Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD171468736
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 20:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349287AbhLDTi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 14:38:29 -0500
Received: from mga11.intel.com ([192.55.52.93]:25569 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230379AbhLDTi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 14:38:27 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10188"; a="234652420"
X-IronPort-AV: E=Sophos;i="5.87,288,1631602800"; 
   d="scan'208";a="234652420"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2021 11:35:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,288,1631602800"; 
   d="scan'208";a="562125982"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 04 Dec 2021 11:34:59 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtaoF-000JMV-B5; Sat, 04 Dec 2021 19:34:59 +0000
Date:   Sun, 5 Dec 2021 03:34:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>, Kai Huang <kai.huang@intel.com>
Subject: arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse: sparse: incorrect type
 in assignment (different base types)
Message-ID: <202112050357.x46al1AR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   12119cfa1052d512a92524e90ebee85029a918f8
commit: 540745ddbc70eabdc7dbd3fcc00fe4fb17cd59ba x86/sgx: Introduce virtual EPC for use by KVM guests
date:   8 months ago
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20211205/202112050357.x46al1AR-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=540745ddbc70eabdc7dbd3fcc00fe4fb17cd59ba
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 540745ddbc70eabdc7dbd3fcc00fe4fb17cd59ba
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/hyperv/ arch/x86/kernel/cpu/sgx/ drivers/hv/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected int [assigned] ret @@     got restricted vm_fault_t @@
   arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse:     expected int [assigned] ret
   arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse:     got restricted vm_fault_t
>> arch/x86/kernel/cpu/sgx/virt.c:60:20: sparse: sparse: restricted vm_fault_t degrades to integer
   arch/x86/kernel/cpu/sgx/virt.c:95:35: sparse: sparse: symbol 'sgx_vepc_vm_ops' was not declared. Should it be static?

vim +59 arch/x86/kernel/cpu/sgx/virt.c

    32	
    33	static int __sgx_vepc_fault(struct sgx_vepc *vepc,
    34				    struct vm_area_struct *vma, unsigned long addr)
    35	{
    36		struct sgx_epc_page *epc_page;
    37		unsigned long index, pfn;
    38		int ret;
    39	
    40		WARN_ON(!mutex_is_locked(&vepc->lock));
    41	
    42		/* Calculate index of EPC page in virtual EPC's page_array */
    43		index = vma->vm_pgoff + PFN_DOWN(addr - vma->vm_start);
    44	
    45		epc_page = xa_load(&vepc->page_array, index);
    46		if (epc_page)
    47			return 0;
    48	
    49		epc_page = sgx_alloc_epc_page(vepc, false);
    50		if (IS_ERR(epc_page))
    51			return PTR_ERR(epc_page);
    52	
    53		ret = xa_err(xa_store(&vepc->page_array, index, epc_page, GFP_KERNEL));
    54		if (ret)
    55			goto err_free;
    56	
    57		pfn = PFN_DOWN(sgx_get_epc_phys_addr(epc_page));
    58	
  > 59		ret = vmf_insert_pfn(vma, addr, pfn);
  > 60		if (ret != VM_FAULT_NOPAGE) {
    61			ret = -EFAULT;
    62			goto err_delete;
    63		}
    64	
    65		return 0;
    66	
    67	err_delete:
    68		xa_erase(&vepc->page_array, index);
    69	err_free:
    70		sgx_free_epc_page(epc_page);
    71		return ret;
    72	}
    73	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
