Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5AF48E212
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 02:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbiANBSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 20:18:20 -0500
Received: from mga14.intel.com ([192.55.52.115]:3486 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230237AbiANBST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 20:18:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642123099; x=1673659099;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=k61ukGPp1G9ctxiAMspSi107hhKLz6ggVd6jEFfeBig=;
  b=ZsSvD7FsA6KbY44NnBmoGqEJeOD4Yd9RypCXhHTvHXk4oDjUhVOKNLaK
   kcgmF2rIPFnMmusoGZl6Q9N9wPO5qoT4pQR6fjMIgmPNML6j8NA+qvYk3
   NIJR1PEt5kBPRJnlbEh6JXWKz0jJ8kdIEfpF0fxCd1hAkUxLGb6goS2/N
   s7UFTOTfEiLE73xy48ObMUTJI5v5miNGubrS71s9/LF+21bzAqP61IIrT
   1MeWpQwjx1yTSEg64zJIYPLnbCyrA9rV0mSFtLXsI7wrLqkaEOI0cs/li
   CgzEGO5F7Y5fGI0V2ZB8cH5GeDoQRqyZrFC6+V3vsS0rg1PXC++WKLJ7l
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="244359440"
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="244359440"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 17:18:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="670703998"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jan 2022 17:18:18 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8BEP-0007t3-Gf; Fri, 14 Jan 2022 01:18:17 +0000
Date:   Fri, 14 Jan 2022 09:17:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eric Biggers <ebiggers@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ebiggers:blk-crypto-sysfs-testing 4/4]
 drivers/block/virtio_blk.c:763:10: error: 'struct request_queue' has no
 member named 'crypto_profile'
Message-ID: <202201140941.edAqs2GB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git blk-crypto-sysfs-testing
head:   59eaf05f0496aed45c6825a931254a94381d36ac
commit: 59eaf05f0496aed45c6825a931254a94381d36ac [4/4] virtio-blk: add fake crypto profile for testing
config: csky-randconfig-r002-20220113 (https://download.01.org/0day-ci/archive/20220114/202201140941.edAqs2GB-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/commit/?id=59eaf05f0496aed45c6825a931254a94381d36ac
        git remote add ebiggers https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git
        git fetch --no-tags ebiggers blk-crypto-sysfs-testing
        git checkout 59eaf05f0496aed45c6825a931254a94381d36ac
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=csky SHELL=/bin/bash drivers/block/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/block/virtio_blk.c: In function 'virtblk_add_crypto_profile':
>> drivers/block/virtio_blk.c:763:10: error: 'struct request_queue' has no member named 'crypto_profile'
     763 |         q->crypto_profile = profile;
         |          ^~


vim +763 drivers/block/virtio_blk.c

   751	
   752	static void virtblk_add_crypto_profile(struct request_queue *q)
   753	{
   754		struct blk_crypto_profile *profile;
   755	
   756		profile = kzalloc(sizeof(*profile), GFP_KERNEL);
   757	
   758		blk_crypto_profile_init(profile, 32);
   759		profile->modes_supported[BLK_ENCRYPTION_MODE_AES_256_XTS] =
   760			4096 | 8192;
   761		profile->max_dun_bytes_supported = 8;
   762	
 > 763		q->crypto_profile = profile;
   764	}
   765	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
