Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589CB46DB44
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239103AbhLHSlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 13:41:31 -0500
Received: from mga09.intel.com ([134.134.136.24]:63481 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239090AbhLHSl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:41:29 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="237708308"
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="237708308"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 10:37:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="480003898"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 08 Dec 2021 10:37:53 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mv1pA-0000uX-Fg; Wed, 08 Dec 2021 18:37:52 +0000
Date:   Thu, 9 Dec 2021 02:37:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     kbuild-all@lists.01.org, Jacob Pan <jacob.jun.pan@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Raj Ashok <ashok.raj@intel.com>
Subject: Re: [PATCH 4/4] dmaengine: idxd: Use DMA API for in-kernel DMA with
 PASID
Message-ID: <202112090231.mEK0hpuw-lkp@intel.com>
References: <1638884834-83028-5-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638884834-83028-5-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

I love your patch! Yet something to improve:

[auto build test ERROR on joro-iommu/next]
[also build test ERROR on vkoul-dmaengine/next linux/master linus/master v5.16-rc4 next-20211208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jacob-Pan/Enable-PASID-for-DMA-API-users/20211208-063637
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: x86_64-randconfig-a013-20211208 (https://download.01.org/0day-ci/archive/20211209/202112090231.mEK0hpuw-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/018108bcd08fc145526791870b4b58edeecfca1e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jacob-Pan/Enable-PASID-for-DMA-API-users/20211208-063637
        git checkout 018108bcd08fc145526791870b4b58edeecfca1e
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/dma/idxd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/dma/idxd/init.c: In function 'idxd_enable_system_pasid':
>> drivers/dma/idxd/init.c:532:10: error: implicit declaration of function 'iommu_enable_pasid_dma'; did you mean 'iommu_enable_nesting'? [-Werror=implicit-function-declaration]
     532 |  pasid = iommu_enable_pasid_dma(&idxd->pdev->dev);
         |          ^~~~~~~~~~~~~~~~~~~~~~
         |          iommu_enable_nesting
   drivers/dma/idxd/init.c: In function 'idxd_disable_system_pasid':
>> drivers/dma/idxd/init.c:544:2: error: implicit declaration of function 'iommu_disable_pasid_dma' [-Werror=implicit-function-declaration]
     544 |  iommu_disable_pasid_dma(&idxd->pdev->dev);
         |  ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +532 drivers/dma/idxd/init.c

   527	
   528	static int idxd_enable_system_pasid(struct idxd_device *idxd)
   529	{
   530		u32 pasid;
   531	
 > 532		pasid = iommu_enable_pasid_dma(&idxd->pdev->dev);
   533		if (pasid == INVALID_IOASID) {
   534			dev_err(&idxd->pdev->dev, "No kernel DMA PASID\n");
   535			return -ENODEV;
   536		}
   537		idxd->pasid = pasid;
   538	
   539		return 0;
   540	}
   541	
   542	static void idxd_disable_system_pasid(struct idxd_device *idxd)
   543	{
 > 544		iommu_disable_pasid_dma(&idxd->pdev->dev);
   545		idxd->pasid = 0;
   546	}
   547	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
