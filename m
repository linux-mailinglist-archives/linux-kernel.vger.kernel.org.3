Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E0A48DFF9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 22:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbiAMVxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 16:53:08 -0500
Received: from mga05.intel.com ([192.55.52.43]:34220 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231382AbiAMVxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 16:53:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642110786; x=1673646786;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JI4+Rdd9HprOF4To7OXa52S7mrG5+PwdPnNzNcd86No=;
  b=RDzUJIAJrG5K36b+JnmFE7WKvcKylQ78a08WOA+DJT6PbMyDIumbpPOG
   F95b/Kj7uMPxD/CQJDFBN1KWMiHOWxSkiDzmpZzcqMSDvNrk1DsFYV9u9
   KBSdsxowKG9GStOjDWUtnvh/prY2I8bkTVFpVr5bb/G86mkIDjU6X78+U
   OF8nitcqeB6aweJdkHicVWcVnN5ra9FX4cSJhMjeu3UvW7yx8Sj04sL60
   b600Ryk5xwceeNPD5HY7HgUxocF5olfxdquqnVC+C83a9IIgg5mYWtyoI
   Z5xLr6667RVpeJF5vSKsT7WH4qDx4d0A9uTKR4PrxTh5CktRpqB72tPqr
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="330469016"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="330469016"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 13:53:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="491278845"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 13 Jan 2022 13:53:04 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n881o-0007gH-8C; Thu, 13 Jan 2022 21:53:04 +0000
Date:   Fri, 14 Jan 2022 05:52:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-tdx:tdx/guest-rebased 37/133]
 drivers/firmware/efi/libstub/x86-stub.c:646:31: warning: cast from pointer
 to integer of different size
Message-ID: <202201140508.SjqMqVuQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git tdx/guest-rebased
head:   e3995864d37c56f431c93fc3dc454d9c65f5e9ea
commit: c1d3539441f0c99bf0b530748d6ea9f3cf497719 [37/133] efi/x86: Implement support for unaccepted memory
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220114/202201140508.SjqMqVuQ-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/c1d3539441f0c99bf0b530748d6ea9f3cf497719
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx tdx/guest-rebased
        git checkout c1d3539441f0c99bf0b530748d6ea9f3cf497719
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
