Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872B8467F69
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 22:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354078AbhLCVjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 16:39:51 -0500
Received: from mga11.intel.com ([192.55.52.93]:41150 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229665AbhLCVju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 16:39:50 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="234569380"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="234569380"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 13:36:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="478463744"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 03 Dec 2021 13:36:23 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtGEA-000I4Q-Fs; Fri, 03 Dec 2021 21:36:22 +0000
Date:   Sat, 4 Dec 2021 05:35:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jgunthorpe:iommufd 7/9] drivers/iommu/iommufd/selftest.c:204:1:
 warning: the frame size of 1052 bytes is larger than 1024 bytes
Message-ID: <202112040504.mo85qmGT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jgunthorpe/linux iommufd
head:   adaf58fcdccd96a03a9d6783e08303612fa3da85
commit: 947b2f74edc5dcad1f9532abd9bdd42a25a00490 [7/9] iommufd: Add a selftest
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20211204/202112040504.mo85qmGT-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/jgunthorpe/linux/commit/947b2f74edc5dcad1f9532abd9bdd42a25a00490
        git remote add jgunthorpe https://github.com/jgunthorpe/linux
        git fetch --no-tags jgunthorpe iommufd
        git checkout 947b2f74edc5dcad1f9532abd9bdd42a25a00490
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/iommu/iommufd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/iommu/iommufd/selftest.c: In function 'iommufd_test_mock_domain.isra.0':
>> drivers/iommu/iommufd/selftest.c:204:1: warning: the frame size of 1052 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     204 | }
         | ^


vim +204 drivers/iommu/iommufd/selftest.c

   181	
   182	/* Create an hw_pagetable with the mock domain so we can test the domain ops */
   183	static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
   184					    struct iommu_test_cmd *cmd)
   185	{
   186		struct bus_type mock_bus = {.iommu_ops = &domain_mock_ops};
   187		struct device mock_dev = {.bus = &mock_bus};
   188		struct iommufd_hw_pagetable *hwpt;
   189	
   190		hwpt = iommufd_hw_pagetable_from_id(ucmd->ictx, cmd->id, &mock_dev);
   191		if (IS_ERR(hwpt))
   192			return PTR_ERR(hwpt);
   193		if (WARN_ON(refcount_read(&hwpt->obj.users) != 1)) {
   194			iommufd_hw_pagetable_put(ucmd->ictx, hwpt);
   195			return -EINVAL;
   196		}
   197	
   198		/* Convert auto domain to user created */
   199		list_del_init(&hwpt->auto_domains_item);
   200	
   201		/* Leak on error */
   202		cmd->id = hwpt->obj.id;
   203		return iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 > 204	}
   205	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
