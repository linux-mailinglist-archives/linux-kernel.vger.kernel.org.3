Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA50466DF1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 00:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349681AbhLBXoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 18:44:09 -0500
Received: from mga07.intel.com ([134.134.136.100]:46035 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232981AbhLBXoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 18:44:08 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="300259040"
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="300259040"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 15:40:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="459856321"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 02 Dec 2021 15:40:44 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1msvgx-000Gmc-DS; Thu, 02 Dec 2021 23:40:43 +0000
Date:   Fri, 3 Dec 2021 07:40:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [bvanassche:ufs-for-next 16/17] drivers/scsi/ufs/ufshcd.c:1086:3:
 warning: variable 'pending' is uninitialized when used here
Message-ID: <202112030740.2OWuHbfI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux ufs-for-next
head:   a4bec7f1327808f88f380bcfc67a0bf56ecc343f
commit: 07dc2a50633fbd851626e61b6b214890bd411050 [16/17] scsi: ufs: Optimize the command queueing code
config: hexagon-randconfig-r006-20211202 (https://download.01.org/0day-ci/archive/20211203/202112030740.2OWuHbfI-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 4b553297ef3ee4dc2119d5429adf3072e90fac38)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/bvanassche/linux/commit/07dc2a50633fbd851626e61b6b214890bd411050
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche ufs-for-next
        git checkout 07dc2a50633fbd851626e61b6b214890bd411050
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/scsi/ufs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/scsi/ufs/ufshcd.c:1086:3: warning: variable 'pending' is uninitialized when used here [-Wuninitialized]
                   pending += sbitmap_weight(&sdev->budget_map);
                   ^~~~~~~
   drivers/scsi/ufs/ufshcd.c:1083:13: note: initialize the variable 'pending' to silence this warning
           u32 pending;
                      ^
                       = 0
   1 warning generated.


vim +/pending +1086 drivers/scsi/ufs/ufshcd.c

  1072	
  1073	/*
  1074	 * Determine the number of pending commands by counting the bits in the SCSI
  1075	 * device budget maps. This approach has been selected because a bit is set in
  1076	 * the budget map before scsi_host_queue_ready() checks the host_self_blocked
  1077	 * flag. The host_self_blocked flag can be modified by calling
  1078	 * scsi_block_requests() or scsi_unblock_requests().
  1079	 */
  1080	static u32 ufshcd_pending_cmds(struct ufs_hba *hba)
  1081	{
  1082		struct scsi_device *sdev;
  1083		u32 pending;
  1084	
  1085		shost_for_each_device(sdev, hba->host)
> 1086			pending += sbitmap_weight(&sdev->budget_map);
  1087	
  1088		return pending;
  1089	}
  1090	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
