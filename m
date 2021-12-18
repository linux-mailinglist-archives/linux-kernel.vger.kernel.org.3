Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBA8479888
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 05:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbhLREDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 23:03:35 -0500
Received: from mga14.intel.com ([192.55.52.115]:54353 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231923AbhLREDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 23:03:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639800214; x=1671336214;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fNIjOLezgG/Xb6Y2D8mX3U59KONJ+hT0cS36Qmd17o4=;
  b=h2fUk4IKWMlb+DvjdE/kw9NRdv2aKMuBpRtlaKBZTvG0POR2/JlP7IoW
   fvQ6DwxxPjF4vbK4SsJ5o7tZMmNPL7doXFbmg/UoNyLF098S09oKL1zw1
   PBbBvoz61TpJIyoFsUIMt3KcycH9HAkVCEoM56HXNcxkV3m10SSoDxGa+
   9CPHHvjOP3YKPGs6fLNStBlQ0HZ0sToL/WPa03XLsB+NpuH5oqavNfk+1
   sZgkSbnaG75pFlLBkWakj7alkxCy/Z+uq2W3woGS3/ceTKyh2bR3EdPsa
   ToEmJ2Ogw4R/L35s9WftHnZdg1AsEpDE0aPQp+v8eAh+S++qwIqg6gCxd
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="240105918"
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="240105918"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 20:03:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="520031675"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 17 Dec 2021 20:03:32 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1myQwV-0005Zi-JT; Sat, 18 Dec 2021 04:03:31 +0000
Date:   Sat, 18 Dec 2021 12:03:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tianyu Lan <Tianyu.Lan@microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [hyperv:hyperv-next 1/5] kernel/dma/swiotlb.c:166:7: warning: no
 previous prototype for 'swiotlb_mem_remap'
Message-ID: <202112181114.Vxt6EAJR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git hyperv-next
head:   19fd7ca00201c0525452dcf5a490e4b01674ef4c
commit: 32be866293fe5355adbf91da1cd612f439fc71e5 [1/5] swiotlb: Add swiotlb bounce buffer remap function for HV IVM
config: x86_64-randconfig-r001-20211216 (https://download.01.org/0day-ci/archive/20211218/202112181114.Vxt6EAJR-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/commit/?id=32be866293fe5355adbf91da1cd612f439fc71e5
        git remote add hyperv https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
        git fetch --no-tags hyperv hyperv-next
        git checkout 32be866293fe5355adbf91da1cd612f439fc71e5
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/dma/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/dma/swiotlb.c:166:7: warning: no previous prototype for 'swiotlb_mem_remap' [-Wmissing-prototypes]
     166 | void *swiotlb_mem_remap(struct io_tlb_mem *mem, unsigned long bytes)
         |       ^~~~~~~~~~~~~~~~~


vim +/swiotlb_mem_remap +166 kernel/dma/swiotlb.c

   160	
   161	/*
   162	 * Remap swioltb memory in the unencrypted physical address space
   163	 * when swiotlb_unencrypted_base is set. (e.g. for Hyper-V AMD SEV-SNP
   164	 * Isolation VMs).
   165	 */
 > 166	void *swiotlb_mem_remap(struct io_tlb_mem *mem, unsigned long bytes)
   167	{
   168		void *vaddr = NULL;
   169	
   170		if (swiotlb_unencrypted_base) {
   171			phys_addr_t paddr = mem->start + swiotlb_unencrypted_base;
   172	
   173			vaddr = memremap(paddr, bytes, MEMREMAP_WB);
   174			if (!vaddr)
   175				pr_err("Failed to map the unencrypted memory %llx size %lx.\n",
   176				       paddr, bytes);
   177		}
   178	
   179		return vaddr;
   180	}
   181	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
