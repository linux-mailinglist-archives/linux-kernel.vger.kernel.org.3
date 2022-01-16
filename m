Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF3448FD43
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 14:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbiAPNqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 08:46:06 -0500
Received: from mga04.intel.com ([192.55.52.120]:51885 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230028AbiAPNqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 08:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642340761; x=1673876761;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wn0cjGJKyOCTgNwzAcJvaqvOzJGySCw/4EqvWxkv60c=;
  b=jiiGco9HiH+sK4lLoD2FX1qrFnIOJdej7a4age5PMtfN4AM8UrtTSSVO
   w1xtmeXcEEbWOx3HLay5mlfq05DUsqYbI1ldDR2RefZhyMQduz3bB5I7Z
   o4pRgRww9lGtFg5WNg+Fhdq8GeHQ0DnkLM4loTsgTp0dpW8kYjzBSYjIw
   Dq3CZijh16vfOfjqHqqzcxMJ3uw87ZK/EBwOwUrpkol+kS4HkXxUVH8Y6
   XZFTvpoWPipB0Z8wtdgS09eFo4hx2KHw4oYFqMe10XETgrB17gwGIpaAt
   iT/bLmUArYnEPKdzMHql01VH4O2zIJixO96vIELQq/4MFtT0cuIgd+bnE
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10228"; a="243313400"
X-IronPort-AV: E=Sophos;i="5.88,293,1635231600"; 
   d="scan'208";a="243313400"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 05:46:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,293,1635231600"; 
   d="scan'208";a="692791174"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 16 Jan 2022 05:45:59 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n95r5-000Ak6-0m; Sun, 16 Jan 2022 13:45:59 +0000
Date:   Sun, 16 Jan 2022 21:45:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [bvanassche:scsi-move-scsi-pointer 16/18]
 drivers/scsi/fdomain.c:122:22: warning: no previous prototype for
 'fdomain_scsi_pointer'
Message-ID: <202201162111.5FI8my1D-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux scsi-move-scsi-pointer
head:   7173550f8dd7130891118452742bb6e99b63fd27
commit: 6eea006091e2b2b428a910feb8041bbb99aa707d [16/18] fdomain: Move the SCSI pointer to private command data
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220116/202201162111.5FI8my1D-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/bvanassche/linux/commit/6eea006091e2b2b428a910feb8041bbb99aa707d
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche scsi-move-scsi-pointer
        git checkout 6eea006091e2b2b428a910feb8041bbb99aa707d
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/scsi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/scsi/fdomain.c:122:22: warning: no previous prototype for 'fdomain_scsi_pointer' [-Wmissing-prototypes]
     122 | struct scsi_pointer *fdomain_scsi_pointer(struct scsi_cmnd *cmd)
         |                      ^~~~~~~~~~~~~~~~~~~~


vim +/fdomain_scsi_pointer +122 drivers/scsi/fdomain.c

   121	
 > 122	struct scsi_pointer *fdomain_scsi_pointer(struct scsi_cmnd *cmd)
   123	{
   124		struct fdomain_priv *fcmd = scsi_cmd_priv(cmd);
   125	
   126		return &fcmd->scsi_pointer;
   127	}
   128	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
