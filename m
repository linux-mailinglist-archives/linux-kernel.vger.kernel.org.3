Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6637B468C78
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 18:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236951AbhLERwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 12:52:04 -0500
Received: from mga11.intel.com ([192.55.52.93]:64253 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236689AbhLERwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 12:52:04 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="234713037"
X-IronPort-AV: E=Sophos;i="5.87,289,1631602800"; 
   d="scan'208";a="234713037"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2021 09:48:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,289,1631602800"; 
   d="scan'208";a="656783709"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 05 Dec 2021 09:48:35 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtvco-000KN0-DB; Sun, 05 Dec 2021 17:48:34 +0000
Date:   Mon, 6 Dec 2021 01:48:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Mathieu Poirier <mathieu.poirer@linaro.org>
Subject: drivers/remoteproc/imx_rproc.c:298:12: sparse: sparse: incorrect
 type in assignment (different address spaces)
Message-ID: <202112060157.aVGv35QJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   79a72162048e42a677bc7336a9f5d86fc3ff9558
commit: 2df7062002d0263bde70b453f671bb4f8493e169 remoteproc: imx_proc: enable virtio/mailbox
date:   9 months ago
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20211206/202112060157.aVGv35QJ-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2df7062002d0263bde70b453f671bb4f8493e169
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2df7062002d0263bde70b453f671bb4f8493e169
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/dma/ drivers/gpu/drm/tegra/ drivers/net/wireless/mediatek/mt76/mt7915/ drivers/remoteproc/ drivers/staging/ fs/proc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/remoteproc/imx_rproc.c:298:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *va @@     got void [noderef] __iomem * @@
   drivers/remoteproc/imx_rproc.c:298:12: sparse:     expected void *va
   drivers/remoteproc/imx_rproc.c:298:12: sparse:     got void [noderef] __iomem *
>> drivers/remoteproc/imx_rproc.c:315:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got void *va @@
   drivers/remoteproc/imx_rproc.c:315:20: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/remoteproc/imx_rproc.c:315:20: sparse:     got void *va

vim +298 drivers/remoteproc/imx_rproc.c

a0ff4aa6f01080 Oleksij Rempel 2017-08-17  290  
b29b4249f8f0ca Peng Fan       2021-03-06  291  static int imx_rproc_mem_alloc(struct rproc *rproc,
b29b4249f8f0ca Peng Fan       2021-03-06  292  			       struct rproc_mem_entry *mem)
b29b4249f8f0ca Peng Fan       2021-03-06  293  {
b29b4249f8f0ca Peng Fan       2021-03-06  294  	struct device *dev = rproc->dev.parent;
b29b4249f8f0ca Peng Fan       2021-03-06  295  	void *va;
b29b4249f8f0ca Peng Fan       2021-03-06  296  
b29b4249f8f0ca Peng Fan       2021-03-06  297  	dev_dbg(dev, "map memory: %p+%zx\n", &mem->dma, mem->len);
b29b4249f8f0ca Peng Fan       2021-03-06 @298  	va = ioremap_wc(mem->dma, mem->len);
b29b4249f8f0ca Peng Fan       2021-03-06  299  	if (IS_ERR_OR_NULL(va)) {
b29b4249f8f0ca Peng Fan       2021-03-06  300  		dev_err(dev, "Unable to map memory region: %p+%zx\n",
b29b4249f8f0ca Peng Fan       2021-03-06  301  			&mem->dma, mem->len);
b29b4249f8f0ca Peng Fan       2021-03-06  302  		return -ENOMEM;
b29b4249f8f0ca Peng Fan       2021-03-06  303  	}
b29b4249f8f0ca Peng Fan       2021-03-06  304  
b29b4249f8f0ca Peng Fan       2021-03-06  305  	/* Update memory entry va */
b29b4249f8f0ca Peng Fan       2021-03-06  306  	mem->va = va;
b29b4249f8f0ca Peng Fan       2021-03-06  307  
b29b4249f8f0ca Peng Fan       2021-03-06  308  	return 0;
b29b4249f8f0ca Peng Fan       2021-03-06  309  }
b29b4249f8f0ca Peng Fan       2021-03-06  310  
b29b4249f8f0ca Peng Fan       2021-03-06  311  static int imx_rproc_mem_release(struct rproc *rproc,
b29b4249f8f0ca Peng Fan       2021-03-06  312  				 struct rproc_mem_entry *mem)
b29b4249f8f0ca Peng Fan       2021-03-06  313  {
b29b4249f8f0ca Peng Fan       2021-03-06  314  	dev_dbg(rproc->dev.parent, "unmap memory: %pa\n", &mem->dma);
b29b4249f8f0ca Peng Fan       2021-03-06 @315  	iounmap(mem->va);
b29b4249f8f0ca Peng Fan       2021-03-06  316  
b29b4249f8f0ca Peng Fan       2021-03-06  317  	return 0;
b29b4249f8f0ca Peng Fan       2021-03-06  318  }
b29b4249f8f0ca Peng Fan       2021-03-06  319  

:::::: The code at line 298 was first introduced by commit
:::::: b29b4249f8f0cad1a1787cbe59e638ff23d489ed remoteproc: imx_rproc: add i.MX specific parse fw hook

:::::: TO: Peng Fan <peng.fan@nxp.com>
:::::: CC: Bjorn Andersson <bjorn.andersson@linaro.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
