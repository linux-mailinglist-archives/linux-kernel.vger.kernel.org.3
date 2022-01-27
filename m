Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E8449D983
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 05:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbiA0EEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 23:04:43 -0500
Received: from mga18.intel.com ([134.134.136.126]:18844 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235900AbiA0EEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 23:04:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643256281; x=1674792281;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=M2yEvkVH4mua/nTchbfxC/2s0HwjJow6QTRLFw4uGNY=;
  b=N25UvpuYNx5cOQ8ExQ/kAXVMOl+o1Df33W+cxN5y8CNXwxP9quyJGa++
   pvPtF665bgWZ69SaY3YRf5dxdtzZV4wJZFAQvvIjgaV260DqUS+y/NrmV
   dGYr6nE8WRQF41I71zNNs1zW3Rau2Z3W6FnNAiQdcxWVrhwQF0hY/Znmd
   p7nZDCySDP1FHnq7x7rGjICq23TmTv1OQNW5alhWLWI+td+OvsMf6DSMI
   JuaVk7DDoVDKBUv8+G/OyDIyO7HqrO3SVKy/AtiFGqKBjT8uUOML5Ssy3
   Slz2L3zpB0cFYPIAyk6j+ozaNdn+XG3yQqw5/yTwqfcgQXuDnc407rRn0
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="230315326"
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="230315326"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 20:04:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="628543046"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 Jan 2022 20:04:40 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCw1X-000M4x-Fk; Thu, 27 Jan 2022 04:04:39 +0000
Date:   Thu, 27 Jan 2022 12:04:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Ekstrand <jason@jlekstrand.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [mlankhorst:xe 124/165] drivers/gpu/drm/xe/xe_vm.c:160:3: error:
 implicit declaration of function 'writeq'; did you mean 'writel'?
Message-ID: <202201271251.UUO143AR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://people.freedesktop.org/~mlankhorst/linux xe
head:   4bc3039b4403c76a13d58f7ac1f7c07dca6f88d8
commit: 5b618f2bacec0b689def464e9771e604cada24d7 [124/165] xe/vm: Use writeq when is_iomem
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220127/202201271251.UUO143AR-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        git remote add mlankhorst git://people.freedesktop.org/~mlankhorst/linux
        git fetch --no-tags mlankhorst xe
        git checkout 5b618f2bacec0b689def464e9771e604cada24d7
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/xe/xe_vm.c: In function '__xe_pt_write':
>> drivers/gpu/drm/xe/xe_vm.c:160:3: error: implicit declaration of function 'writeq'; did you mean 'writel'? [-Werror=implicit-function-declaration]
     160 |   writeq(data, (uint64_t __iomem *)map_u64);
         |   ^~~~~~
         |   writel
   drivers/gpu/drm/xe/xe_vm.c: At top level:
   drivers/gpu/drm/xe/xe_vm.c:165:15: error: no previous prototype for 'xe_pt_create' [-Werror=missing-prototypes]
     165 | struct xe_pt *xe_pt_create(struct xe_vm *vm, unsigned int level)
         |               ^~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +160 drivers/gpu/drm/xe/xe_vm.c

   151	
   152	static void __xe_pt_write(struct ttm_bo_kmap_obj *map,
   153				  unsigned int idx, uint64_t data)
   154	{
   155		bool is_iomem;
   156		uint64_t *map_u64;
   157	
   158		map_u64 = ttm_kmap_obj_virtual(map, &is_iomem);
   159		if (is_iomem)
 > 160			writeq(data, (uint64_t __iomem *)map_u64);
   161		else
   162			map_u64[idx] = data;
   163	}
   164	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
