Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FBB46DEB6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 23:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240736AbhLHW4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 17:56:34 -0500
Received: from mga04.intel.com ([192.55.52.120]:5015 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234435AbhLHW4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 17:56:34 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="236707255"
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="236707255"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 14:53:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="680099181"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 08 Dec 2021 14:52:59 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mv5o3-0001A1-0Q; Wed, 08 Dec 2021 22:52:59 +0000
Date:   Thu, 9 Dec 2021 06:52:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [hare-scsi-devel:ata-trace.v3 2/73]
 drivers/ata/libata-core.c:972:13: warning: no previous prototype for
 function 'ata_dev_class_string'
Message-ID: <202112090629.8XnsDIKk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git ata-trace.v3
head:   d973dee7af0328b9176e4a1710fb73093c334698
commit: 41c489a28ae800ac33f419ad83135261e9eba85c [2/73] libata: Add ata_port_classify() helper
config: i386-randconfig-r021-20211207 (https://download.01.org/0day-ci/archive/20211209/202112090629.8XnsDIKk-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=41c489a28ae800ac33f419ad83135261e9eba85c
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel ata-trace.v3
        git checkout 41c489a28ae800ac33f419ad83135261e9eba85c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kernel/ drivers/ata/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/ata/libata-core.c:972:13: warning: no previous prototype for function 'ata_dev_class_string' [-Wmissing-prototypes]
   const char *ata_dev_class_string(unsigned int class)
               ^
   drivers/ata/libata-core.c:972:7: note: declare 'static' if the function is not intended to be used outside of this translation unit
   const char *ata_dev_class_string(unsigned int class)
         ^
   static 
   1 warning generated.


vim +/ata_dev_class_string +972 drivers/ata/libata-core.c

   971	
 > 972	const char *ata_dev_class_string(unsigned int class)
   973	{
   974		static const char * const class_str[] = {
   975			"unknown",
   976			"ATA",
   977			"ATA (unsupported)",
   978			"ATAPI",
   979			"ATAPI (unsupported",
   980			"PMP",
   981			"PMP (unsupported)",
   982			"SEMB",
   983			"SEMB (unsupported)",
   984			"ZAC",
   985			"ZAC (unsupported)",
   986			"none",
   987		};
   988		if (class == 0 || (class - 1) >= ARRAY_SIZE(class_str))
   989			return "unknown";
   990		return class_str[class - 1];
   991	}
   992	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
