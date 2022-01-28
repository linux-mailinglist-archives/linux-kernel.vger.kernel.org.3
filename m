Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5654249FA44
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238097AbiA1NCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:02:46 -0500
Received: from mga11.intel.com ([192.55.52.93]:64906 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241183AbiA1NCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643374965; x=1674910965;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8mMLujb7iVmZdhkOykr3f4/XewFX7OlGegWQn2rdGLI=;
  b=CZDwgyGitkXb27n4SwsX0gi3AZ6MogBCulCTlF4S8B6s6czmYlHlWktw
   Bik0ObYZp4cWRucvRh/qbJMO0kXW+UPmXxnn3vnQLncK0kjYvMAXJHKjn
   4QZlQLvBgTtJqnBN7GLiIsv0BbXafCvHD4VnnZE2pCbJs2oCruDorq6c3
   6qWkZtRRXbrX7dFbDK2Gf0sStoAls+oF4SgyAqQ8PwyMZ5aadsNTh4/ee
   wX2OfKinpoR99crQEWGiJ0xD78Wl6/KHcoPrcyMJPbfB7MrUe7G93AU5v
   5vevoWdgjtAgC9iTldM3Ntl11Sjdw31WNFdmG39eZbCyN0HAHwHIoJ9YM
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="244716943"
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="244716943"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 05:02:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="618716839"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jan 2022 05:02:22 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDQtQ-000NtD-Sl; Fri, 28 Jan 2022 13:02:20 +0000
Date:   Fri, 28 Jan 2022 21:01:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [mtd:spi-mem-ecc 29/29] drivers/spi/spi-mxic.c:688: undefined
 reference to `nand_ecc_unregister_on_host_hw_engine'
Message-ID: <202201282024.dNzYfD56-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-mem-ecc
head:   493b08141c0086ddb2126179cca7a8a7936b3582
commit: 493b08141c0086ddb2126179cca7a8a7936b3582 [29/29] spi: mxic: Add support for pipelined ECC operations
config: i386-randconfig-a014-20210930 (https://download.01.org/0day-ci/archive/20220128/202201282024.dNzYfD56-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/commit/?id=493b08141c0086ddb2126179cca7a8a7936b3582
        git remote add mtd https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
        git fetch --no-tags mtd spi-mem-ecc
        git checkout 493b08141c0086ddb2126179cca7a8a7936b3582
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: drivers/spi/spi-mxic.o: in function `mxic_spi_mem_ecc_remove':
>> drivers/spi/spi-mxic.c:688: undefined reference to `nand_ecc_unregister_on_host_hw_engine'


vim +688 drivers/spi/spi-mxic.c

   683	
   684	static void mxic_spi_mem_ecc_remove(struct mxic_spi *mxic)
   685	{
   686		if (mxic->ecc.pipelined_engine) {
   687			mxic_ecc_put_pipelined_engine(mxic->ecc.pipelined_engine);
 > 688			nand_ecc_unregister_on_host_hw_engine(mxic->ecc.pipelined_engine);
   689		}
   690	}
   691	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
