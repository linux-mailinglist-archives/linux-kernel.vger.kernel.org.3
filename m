Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC025480FB5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 05:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238728AbhL2Epo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 23:45:44 -0500
Received: from mga09.intel.com ([134.134.136.24]:2315 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238709AbhL2Epm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 23:45:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640753142; x=1672289142;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UnHahNfQVZ/d9phj/RKq9mi/LvsWOB/CTjrcO6eDLSE=;
  b=P1Z/80S6T405iD+4wMbNBOxIGKqjJBtHAGjbtsdTZT/3d5ggHIh4ttP2
   kuwKHhHDPkNDBiPtl8Px8/R3AixDzgRnDrGmnMm8vXfqIlqftuNwrr3OY
   iZBY4jlNBQE/p5BOgMw/HJ7JGln9+8w58BYu/J4qZrF4VqPEMkHUaAh9p
   xOia2RM0oT4LqCYvNGsx0h7UcqttlOsLoi9GknrVlr6TSAOLh0pfzLT5V
   2dfBijhPFLNDGRETiRGIPk3sX6qX2c/HB1cxoRbAac2R7zsqlr66suFpG
   bFMaWpOsWHmFJdGFIQnrNUP2eVV6tFo42MSIOtV17w+t7Xm/GMHs35g++
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="241265112"
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="241265112"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 20:45:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="666189198"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 28 Dec 2021 20:45:41 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2QqK-0008RE-I6; Wed, 29 Dec 2021 04:45:40 +0000
Date:   Wed, 29 Dec 2021 12:44:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:vectorized-scrub 100/326] fs/xfs/scrub/trace.c:48:24:
 error: dereferencing pointer to incomplete type 'struct xfbtree'
Message-ID: <202112291219.H4IqiT4G-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git vectorized-scrub
head:   f736db09eb704761df6d6534ed9730f38bf136d1
commit: 9bcb3cf01fbbfe96671d56248b516b0a68c5c022 [100/326] xfs: connect in-memory btrees to xfiles
config: i386-randconfig-m021-20211229 (https://download.01.org/0day-ci/archive/20211229/202112291219.H4IqiT4G-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?id=9bcb3cf01fbbfe96671d56248b516b0a68c5c022
        git remote add djwong-xfs https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git
        git fetch --no-tags djwong-xfs vectorized-scrub
        git checkout 9bcb3cf01fbbfe96671d56248b516b0a68c5c022
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/xfs/scrub/trace.c: In function 'xfbtree_ino':
>> fs/xfs/scrub/trace.c:48:24: error: dereferencing pointer to incomplete type 'struct xfbtree'
      48 |  return file_inode(xfbt->target->bt_xfile->file)->i_ino;
         |                        ^~


vim +48 fs/xfs/scrub/trace.c

    43	
    44	static inline unsigned long
    45	xfbtree_ino(
    46		struct xfbtree		*xfbt)
    47	{
  > 48		return file_inode(xfbt->target->bt_xfile->file)->i_ino;
    49	}
    50	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
