Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30D046CE8D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 08:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244590AbhLHH6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 02:58:10 -0500
Received: from mga06.intel.com ([134.134.136.31]:49996 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231634AbhLHH6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 02:58:09 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="298572874"
X-IronPort-AV: E=Sophos;i="5.87,296,1631602800"; 
   d="scan'208";a="298572874"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 23:54:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,296,1631602800"; 
   d="scan'208";a="543116227"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 07 Dec 2021 23:54:35 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1murmc-0000FQ-TW; Wed, 08 Dec 2021 07:54:34 +0000
Date:   Wed, 8 Dec 2021 15:53:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [intel-tdx:guest 112/144]
 drivers/firmware/efi/libstub/x86-stub.c:646:31: warning: cast from pointer
 to integer of different size
Message-ID: <202112081509.OILzXDqW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest
head:   41fe88a1b3c28543f49fa6ed9e0e9b6650ed7614
commit: 102129224696b1fd61f13fc1493fd922cd281448 [112/144] efi/x86: Implement support for unaccepted memory
config: i386-randconfig-a003-20211207 (https://download.01.org/0day-ci/archive/20211208/202112081509.OILzXDqW-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/102129224696b1fd61f13fc1493fd922cd281448
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest
        git checkout 102129224696b1fd61f13fc1493fd922cd281448
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/firmware/efi/libstub/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/firmware/efi/libstub/x86-stub.c: In function 'allocate_e820':
>> drivers/firmware/efi/libstub/x86-stub.c:646:31: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     646 |   params->unaccepted_memory = (u64)unaccepted_memory;
         |                               ^


vim +646 drivers/firmware/efi/libstub/x86-stub.c

   579	
   580	static efi_status_t allocate_e820(struct boot_params *params,
   581					  struct efi_boot_memmap *map,
   582					  struct setup_data **e820ext,
   583					  u32 *e820ext_size)
   584	{
   585		efi_status_t status;
   586		__u32 nr_desc;
   587		bool unaccepted_memory_present = false;
   588		u64 max_addr = 0;
   589		int i;
   590	
   591		status = efi_get_memory_map(map);
   592		if (status != EFI_SUCCESS)
   593			return status;
   594	
   595		nr_desc = *map->map_size / *map->desc_size;
   596		if (nr_desc > ARRAY_SIZE(params->e820_table) - EFI_MMAP_NR_SLACK_SLOTS) {
   597			u32 nr_e820ext = nr_desc - ARRAY_SIZE(params->e820_table) +
   598				EFI_MMAP_NR_SLACK_SLOTS;
   599	
   600			status = alloc_e820ext(nr_e820ext, e820ext, e820ext_size);
   601			if (status != EFI_SUCCESS)
   602				goto out;
   603		}
   604	
   605		if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
   606			goto out;
   607	
   608		/* Check if there's any unaccepted memory and find the max address */
   609		for (i = 0; i < nr_desc; i++) {
   610			efi_memory_desc_t *d;
   611	
   612			d = efi_early_memdesc_ptr(*map->map, *map->desc_size, i);
   613			if (d->type == EFI_UNACCEPTED_MEMORY)
   614				unaccepted_memory_present = true;
   615			if (d->phys_addr + d->num_pages * PAGE_SIZE > max_addr)
   616				max_addr = d->phys_addr + d->num_pages * PAGE_SIZE;
   617		}
   618	
   619		/*
   620		 * If unaccepted memory present allocate a bitmap to track what memory
   621		 * has to be accepted before access.
   622		 *
   623		 * One bit in the bitmap represents 2MiB in the address space: one 4k
   624		 * page is enough to track 64GiB or physical address space.
   625		 *
   626		 * In the worst case scenario -- a huge hole in the middle of the
   627		 * address space -- It needs 256MiB to handle 4PiB of the address
   628		 * space.
   629		 *
   630		 * TODO: handle situation if params->unaccepted_memory has already set.
   631		 * It's required to deal with kexec.
   632		 *
   633		 * The bitmap will be populated in setup_e820() according to the memory
   634		 * map after efi_exit_boot_services().
   635		 */
   636		if (unaccepted_memory_present) {
   637			unsigned long *unaccepted_memory = NULL;
   638			u64 size = DIV_ROUND_UP(max_addr, PMD_SIZE * BITS_PER_BYTE);
   639	
   640			status = efi_allocate_pages(size,
   641						    (unsigned long *)&unaccepted_memory,
   642						    ULONG_MAX);
   643			if (status != EFI_SUCCESS)
   644				goto out;
   645			memset(unaccepted_memory, 0, size);
 > 646			params->unaccepted_memory = (u64)unaccepted_memory;
   647		}
   648	
   649	out:
   650		efi_bs_call(free_pool, *map->map);
   651		return status;
   652	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
