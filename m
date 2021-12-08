Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D74B46DDEE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 23:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237750AbhLHWEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 17:04:06 -0500
Received: from mga01.intel.com ([192.55.52.88]:49901 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237707AbhLHWEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 17:04:05 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="262049324"
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="262049324"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 13:51:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="461875773"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 08 Dec 2021 13:50:59 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mv4q2-00015v-0s; Wed, 08 Dec 2021 21:50:58 +0000
Date:   Thu, 9 Dec 2021 05:50:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [norov:bm-new 5/12] drivers/memstick/core/ms_block.c:160:3: error:
 expected ')'
Message-ID: <202112090503.OzaTxG8D-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux bm-new
head:   3d638c6d3a8a02375f51842f10dd505b91a11c37
commit: feaa500586b1f91d6eeb746885a775a38ac727eb [5/12] rework bitmap_weight
config: hexagon-randconfig-r045-20211208 (https://download.01.org/0day-ci/archive/20211209/202112090503.OzaTxG8D-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/norov/linux/commit/feaa500586b1f91d6eeb746885a775a38ac727eb
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov bm-new
        git checkout feaa500586b1f91d6eeb746885a775a38ac727eb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/memstick/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the norov/bm-new HEAD 3d638c6d3a8a02375f51842f10dd505b91a11c37 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

>> drivers/memstick/core/ms_block.c:160:3: error: expected ')'
                   return 0;
                   ^
   drivers/memstick/core/ms_block.c:158:5: note: to match this '('
           if (bitmap_weight_eq(msb->used_blocks_bitmap, msb->block_count,
              ^
   1 error generated.


vim +160 drivers/memstick/core/ms_block.c

0ab30494bc4f3b Maxim Levitsky 2013-09-11  145  
0ab30494bc4f3b Maxim Levitsky 2013-09-11  146  /* Debug test to validate free block counts */
0ab30494bc4f3b Maxim Levitsky 2013-09-11  147  static int msb_validate_used_block_bitmap(struct msb_data *msb)
0ab30494bc4f3b Maxim Levitsky 2013-09-11  148  {
0ab30494bc4f3b Maxim Levitsky 2013-09-11  149  	int total_free_blocks = 0;
0ab30494bc4f3b Maxim Levitsky 2013-09-11  150  	int i;
0ab30494bc4f3b Maxim Levitsky 2013-09-11  151  
0ab30494bc4f3b Maxim Levitsky 2013-09-11  152  	if (!debug)
0ab30494bc4f3b Maxim Levitsky 2013-09-11  153  		return 0;
0ab30494bc4f3b Maxim Levitsky 2013-09-11  154  
0ab30494bc4f3b Maxim Levitsky 2013-09-11  155  	for (i = 0; i < msb->zone_count; i++)
0ab30494bc4f3b Maxim Levitsky 2013-09-11  156  		total_free_blocks += msb->free_block_count[i];
0ab30494bc4f3b Maxim Levitsky 2013-09-11  157  
feaa500586b1f9 Yury Norov     2021-12-07  158  	if (bitmap_weight_eq(msb->used_blocks_bitmap, msb->block_count,
feaa500586b1f9 Yury Norov     2021-12-07  159  				msb->block_count - total_free_blocks)
0ab30494bc4f3b Maxim Levitsky 2013-09-11 @160  		return 0;
0ab30494bc4f3b Maxim Levitsky 2013-09-11  161  
0ab30494bc4f3b Maxim Levitsky 2013-09-11  162  	pr_err("BUG: free block counts don't match the bitmap");
0ab30494bc4f3b Maxim Levitsky 2013-09-11  163  	msb->read_only = true;
0ab30494bc4f3b Maxim Levitsky 2013-09-11  164  	return -EINVAL;
0ab30494bc4f3b Maxim Levitsky 2013-09-11  165  }
0ab30494bc4f3b Maxim Levitsky 2013-09-11  166  

:::::: The code at line 160 was first introduced by commit
:::::: 0ab30494bc4f3bc1ea4659b7c5d97c5218554a63 memstick: add support for legacy memorysticks

:::::: TO: Maxim Levitsky <maximlevitsky@gmail.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
