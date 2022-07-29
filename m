Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360375850E7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 15:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbiG2N3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 09:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiG2N3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 09:29:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039626A4AC
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 06:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659101342; x=1690637342;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SAAI+Iht6B1MKDII2o4AFXwjGri9x+VfBRCi3IegauY=;
  b=fEtbthNABwAbGRFwf3X3M6iFCTrgGCs49SgnyttFwj0Hia4tUqNiV1Db
   d/ERqwAqGJnOB/ERzO+AgytnDQQ1IDjT+qCrbNaQiWr4QIPLGduPCqAcA
   YKeiHQw84PKQZ0uWr97GbW1tNkcFpPQzx9RSW4EcngObeEcCdT0ZfIz9z
   LZDIreYWRU2P2nsKIwtwaxcN+C/NcpzMFZhnWwV9BbIw1tArdTMnyqwEL
   1+jLZhnoA9iPttRVSU4WS0GiN1f59pCA4muVSDxAhPBtTFQFvQwYwtcAS
   KxgQMGyme+Q/Y6iCXZKrTXlVombtbVlN4giX+oWtE1B2Di8gyLQYm4N1O
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="352763975"
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="352763975"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 06:29:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="669269596"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 29 Jul 2022 06:29:00 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHQ31-000Bf1-2D;
        Fri, 29 Jul 2022 13:28:59 +0000
Date:   Fri, 29 Jul 2022 21:28:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     kbuild-all@lists.01.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Fix compile warning in init code
Message-ID: <202207292151.dVJwr29D-lkp@intel.com>
References: <20220729100432.22474-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729100432.22474-1-joro@8bytes.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

I love your patch! Yet something to improve:

[auto build test ERROR on v5.19-rc8]
[also build test ERROR on linus/master next-20220728]
[cannot apply to joro-iommu/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joerg-Roedel/iommu-amd-Fix-compile-warning-in-init-code/20220729-180535
base:    e0dccc3b76fb35bb257b4118367a883073d7390e
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220729/202207292151.dVJwr29D-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/87617e946268b6df880692ca42bae4f7fb7688de
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Joerg-Roedel/iommu-amd-Fix-compile-warning-in-init-code/20220729-180535
        git checkout 87617e946268b6df880692ca42bae4f7fb7688de
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/iommu/amd/init.c: In function 'iommu_init_pci':
>> drivers/iommu/amd/init.c:1863:15: error: implicit declaration of function 'iommu_init_ga_log'; did you mean 'iommu_init_pci'? [-Werror=implicit-function-declaration]
    1863 |         ret = iommu_init_ga_log(iommu);
         |               ^~~~~~~~~~~~~~~~~
         |               iommu_init_pci
   drivers/iommu/amd/init.c: In function 'iommu_init_irq':
>> drivers/iommu/amd/init.c:2233:9: error: implicit declaration of function 'iommu_ga_log_enable'; did you mean 'iommu_feature_enable'? [-Werror=implicit-function-declaration]
    2233 |         iommu_ga_log_enable(iommu);
         |         ^~~~~~~~~~~~~~~~~~~
         |         iommu_feature_enable
   cc1: some warnings being treated as errors


vim +1863 drivers/iommu/amd/init.c

a44092e326d403c drivers/iommu/amd/init.c       Suravee Suthikulpanit 2021-01-20  1810  
24d2c521749d854 drivers/iommu/amd_iommu_init.c Joerg Roedel          2018-10-05  1811  static int __init iommu_init_pci(struct amd_iommu *iommu)
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1812  {
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1813  	int cap_ptr = iommu->cap_ptr;
8bda0cfbdc1a627 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2016-08-23  1814  	int ret;
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1815  
d5bf0f4f2bade2f drivers/iommu/amd_iommu_init.c Sinan Kaya            2017-12-19  1816  	iommu->dev = pci_get_domain_bus_and_slot(0, PCI_BUS_NUM(iommu->devid),
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1817  						 iommu->devid & 0xff);
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1818  	if (!iommu->dev)
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1819  		return -ENODEV;
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1820  
cbbc00be2ce3af5 drivers/iommu/amd_iommu_init.c Jiang Liu             2015-10-09  1821  	/* Prevent binding other PCI device drivers to IOMMU devices */
cbbc00be2ce3af5 drivers/iommu/amd_iommu_init.c Jiang Liu             2015-10-09  1822  	iommu->dev->match_driver = false;
cbbc00be2ce3af5 drivers/iommu/amd_iommu_init.c Jiang Liu             2015-10-09  1823  
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1824  	pci_read_config_dword(iommu->dev, cap_ptr + MMIO_CAP_HDR_OFFSET,
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1825  			      &iommu->cap);
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1826  
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1827  	if (!(iommu->cap & (1 << IOMMU_CAP_IOTLB)))
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1828  		amd_iommu_iotlb_sup = false;
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1829  
a44092e326d403c drivers/iommu/amd/init.c       Suravee Suthikulpanit 2021-01-20  1830  	late_iommu_features_init(iommu);
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1831  
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1832  	if (iommu_feature(iommu, FEATURE_GT)) {
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1833  		int glxval;
a919a018cccf999 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2014-03-05  1834  		u32 max_pasid;
a919a018cccf999 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2014-03-05  1835  		u64 pasmax;
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1836  
a919a018cccf999 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2014-03-05  1837  		pasmax = iommu->features & FEATURE_PASID_MASK;
a919a018cccf999 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2014-03-05  1838  		pasmax >>= FEATURE_PASID_SHIFT;
a919a018cccf999 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2014-03-05  1839  		max_pasid  = (1 << (pasmax + 1)) - 1;
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1840  
a919a018cccf999 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2014-03-05  1841  		amd_iommu_max_pasid = min(amd_iommu_max_pasid, max_pasid);
a919a018cccf999 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2014-03-05  1842  
a919a018cccf999 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2014-03-05  1843  		BUG_ON(amd_iommu_max_pasid & ~PASID_MASK);
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1844  
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1845  		glxval   = iommu->features & FEATURE_GLXVAL_MASK;
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1846  		glxval >>= FEATURE_GLXVAL_SHIFT;
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1847  
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1848  		if (amd_iommu_max_glx_val == -1)
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1849  			amd_iommu_max_glx_val = glxval;
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1850  		else
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1851  			amd_iommu_max_glx_val = min(amd_iommu_max_glx_val, glxval);
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1852  	}
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1853  
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1854  	if (iommu_feature(iommu, FEATURE_GT) &&
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1855  	    iommu_feature(iommu, FEATURE_PPR)) {
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1856  		iommu->is_iommu_v2   = true;
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1857  		amd_iommu_v2_present = true;
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1858  	}
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1859  
f2c2db53b99eb6c drivers/iommu/amd_iommu_init.c Joerg Roedel          2015-10-20  1860  	if (iommu_feature(iommu, FEATURE_PPR) && alloc_ppr_log(iommu))
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1861  		return -ENOMEM;
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1862  
eb03f2d2f6a4da2 drivers/iommu/amd/init.c       Suravee Suthikulpanit 2021-08-20 @1863  	ret = iommu_init_ga_log(iommu);
8bda0cfbdc1a627 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2016-08-23  1864  	if (ret)
8bda0cfbdc1a627 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2016-08-23  1865  		return ret;
3928aa3f5775fc4 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2016-08-23  1866  
6664340cf1d541c drivers/iommu/amd/init.c       Nadav Amit            2021-07-23  1867  	if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE)) {
47a70bea54b7afa drivers/iommu/amd/init.c       Joerg Roedel          2021-08-02  1868  		pr_info("Using strict mode due to virtualization\n");
47a70bea54b7afa drivers/iommu/amd/init.c       Joerg Roedel          2021-08-02  1869  		iommu_set_dma_strict();
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1870  		amd_iommu_np_cache = true;
6664340cf1d541c drivers/iommu/amd/init.c       Nadav Amit            2021-07-23  1871  	}
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1872  
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  1873  	init_iommu_perf_ctr(iommu);
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  1874  
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1875  	if (is_rd890_iommu(iommu->dev)) {
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1876  		int i, j;
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1877  
d5bf0f4f2bade2f drivers/iommu/amd_iommu_init.c Sinan Kaya            2017-12-19  1878  		iommu->root_pdev =
d5bf0f4f2bade2f drivers/iommu/amd_iommu_init.c Sinan Kaya            2017-12-19  1879  			pci_get_domain_bus_and_slot(0, iommu->dev->bus->number,
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1880  						    PCI_DEVFN(0, 0));
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1881  
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1882  		/*
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1883  		 * Some rd890 systems may not be fully reconfigured by the
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1884  		 * BIOS, so it's necessary for us to store this information so
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1885  		 * it can be reprogrammed on resume
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1886  		 */
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1887  		pci_read_config_dword(iommu->dev, iommu->cap_ptr + 4,
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1888  				&iommu->stored_addr_lo);
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1889  		pci_read_config_dword(iommu->dev, iommu->cap_ptr + 8,
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1890  				&iommu->stored_addr_hi);
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1891  
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1892  		/* Low bit locks writes to configuration space */
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1893  		iommu->stored_addr_lo &= ~1;
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1894  
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1895  		for (i = 0; i < 6; i++)
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1896  			for (j = 0; j < 0x12; j++)
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1897  				iommu->stored_l1[i][j] = iommu_read_l1(iommu, i, j);
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1898  
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1899  		for (i = 0; i < 0x83; i++)
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1900  			iommu->stored_l2[i] = iommu_read_l2(iommu, i);
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1901  	}
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1902  
318fe782539c415 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2013-01-24  1903  	amd_iommu_erratum_746_workaround(iommu);
358875fd52ab8f0 drivers/iommu/amd_iommu_init.c Jay Cornwall          2016-02-10  1904  	amd_iommu_ats_write_check_workaround(iommu);
318fe782539c415 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2013-01-24  1905  
39ab9555c241106 drivers/iommu/amd_iommu_init.c Joerg Roedel          2017-02-01  1906  	iommu_device_sysfs_add(&iommu->iommu, &iommu->dev->dev,
39ab9555c241106 drivers/iommu/amd_iommu_init.c Joerg Roedel          2017-02-01  1907  			       amd_iommu_groups, "ivhd%d", iommu->index);
2d471b20c55e13c drivers/iommu/amd/init.c       Robin Murphy          2021-04-01  1908  	iommu_device_register(&iommu->iommu, &amd_iommu_ops, NULL);
066f2e98d8c7f04 drivers/iommu/amd_iommu_init.c Alex Williamson       2014-06-12  1909  
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1910  	return pci_enable_device(iommu->dev);
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1911  }
23c742db2171135 drivers/iommu/amd_iommu_init.c Joerg Roedel          2012-06-12  1912  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
