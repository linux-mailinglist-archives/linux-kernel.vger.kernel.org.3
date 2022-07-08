Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9834056B068
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 04:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236795AbiGHCGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 22:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiGHCGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 22:06:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56311735BE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 19:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657245980; x=1688781980;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OJJ/ukHgC8uRSLr7JWwWMhgzb5sZd3F8ltVCTgbZVFk=;
  b=RtWYMmBLAxS5xrqBEjByQXwOd0dWX31SMXYa5H5W5syNLHvLP+6vp1Bq
   3iPrnI0Hc/Ik/uJ7MkBStQ0r8CVgUrrap59REPR3a9pBIDzilpU5sK7Hh
   DN4RZb2S/BlOd2GR/tx+BFHi5z12HsjIYCqkDVsr0rIQwA045lPLOSH6Z
   QZuuapJ6f237/HvkQ5oTalnFhJdyoZRE6LI87V59QDBdS24jQBzjcvpe4
   X0W8CtKcwJZGQ+A+vo2dtdESwo9rq9zGi90moTbqBJs3qaIVUb6DMPZnz
   WA4xWZNY75zF5kvBjy4r5vOlj52iHzvjSPm4A2MzB88DNpJ7eqmfxiVyz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="272964070"
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="272964070"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 19:06:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="593951502"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 07 Jul 2022 19:06:18 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9dNp-000Mkq-Uy;
        Fri, 08 Jul 2022 02:06:17 +0000
Date:   Fri, 8 Jul 2022 10:05:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [intel-tdx:guest-hardening-rebased 17/23]
 arch/x86/mm/mem_encrypt_amd.c:217:13: warning: no previous prototype for
 'sev_setup_arch'
Message-ID: <202207081056.RE0c8e5l-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-hardening-rebased
head:   64a4c4e66ca9cce1ca55de6d801f32284fbf7c8e
commit: 033b2ce6183a244e12aea7b4f0acee26a7153dec [17/23] x86/swiotlb: Adjust SWIOTLB bounce buffer size for TDX guests
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220708/202207081056.RE0c8e5l-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/033b2ce6183a244e12aea7b4f0acee26a7153dec
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-hardening-rebased
        git checkout 033b2ce6183a244e12aea7b4f0acee26a7153dec
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/coco/tdx/ arch/x86/mm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/mm/mem_encrypt_amd.c:217:13: warning: no previous prototype for 'sev_setup_arch' [-Wmissing-prototypes]
     217 | void __init sev_setup_arch(void)
         |             ^~~~~~~~~~~~~~


vim +/sev_setup_arch +217 arch/x86/mm/mem_encrypt_amd.c

b9d05200bc12444 arch/x86/mm/mem_encrypt.c     Tom Lendacky  2017-07-17  216  
e998879d4fb7991 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10 @217  void __init sev_setup_arch(void)
e998879d4fb7991 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  218  {
e998879d4fb7991 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  219  	phys_addr_t total_mem = memblock_phys_mem_size();
e998879d4fb7991 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  220  	unsigned long size;
e998879d4fb7991 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  221  
4d96f9109109be9 arch/x86/mm/mem_encrypt.c     Tom Lendacky  2021-09-08  222  	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
e998879d4fb7991 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  223  		return;
e998879d4fb7991 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  224  
e998879d4fb7991 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  225  	/*
e998879d4fb7991 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  226  	 * For SEV, all DMA has to occur via shared/unencrypted pages.
e998879d4fb7991 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  227  	 * SEV uses SWIOTLB to make this happen without changing device
e998879d4fb7991 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  228  	 * drivers. However, depending on the workload being run, the
e998879d4fb7991 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  229  	 * default 64MB of SWIOTLB may not be enough and SWIOTLB may
e998879d4fb7991 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  230  	 * run out of buffers for DMA, resulting in I/O errors and/or
e998879d4fb7991 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  231  	 * performance degradation especially with high I/O workloads.
e998879d4fb7991 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  232  	 *
e998879d4fb7991 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  233  	 * Adjust the default size of SWIOTLB for SEV guests using
e998879d4fb7991 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  234  	 * a percentage of guest memory for SWIOTLB buffers.
e998879d4fb7991 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  235  	 * Also, as the SWIOTLB bounce buffer memory is allocated
e998879d4fb7991 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  236  	 * from low memory, ensure that the adjusted size is within
e998879d4fb7991 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  237  	 * the limits of low available memory.
e998879d4fb7991 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  238  	 *
e998879d4fb7991 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  239  	 * The percentage of guest memory used here for SWIOTLB buffers
e998879d4fb7991 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  240  	 * is more of an approximation of the static adjustment which
e998879d4fb7991 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  241  	 * 64MB for <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
e998879d4fb7991 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  242  	 */
e998879d4fb7991 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  243  	size = total_mem * 6 / 100;
e998879d4fb7991 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  244  	size = clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
e998879d4fb7991 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  245  	swiotlb_adjust_size(size);
3f9dfbebdc48ceb arch/x86/mm/mem_encrypt_amd.c Juergen Gross 2022-06-06  246  
3f9dfbebdc48ceb arch/x86/mm/mem_encrypt_amd.c Juergen Gross 2022-06-06  247  	/* Set restricted memory access for virtio. */
3f9dfbebdc48ceb arch/x86/mm/mem_encrypt_amd.c Juergen Gross 2022-06-06  248  	platform_set(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS);
e998879d4fb7991 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  249  }
e998879d4fb7991 arch/x86/mm/mem_encrypt.c     Ashish Kalra  2020-12-10  250  

:::::: The code at line 217 was first introduced by commit
:::::: e998879d4fb7991856916972168cf27c0d86ed12 x86,swiotlb: Adjust SWIOTLB bounce buffer size for SEV guests

:::::: TO: Ashish Kalra <ashish.kalra@amd.com>
:::::: CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
