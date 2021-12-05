Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C684B468D5D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 21:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239058AbhLEUyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 15:54:11 -0500
Received: from mga04.intel.com ([192.55.52.120]:50472 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238875AbhLEUyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 15:54:08 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="235946632"
X-IronPort-AV: E=Sophos;i="5.87,290,1631602800"; 
   d="scan'208";a="235946632"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2021 12:50:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,290,1631602800"; 
   d="scan'208";a="461595019"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 05 Dec 2021 12:50:39 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtyT0-000KUu-KP; Sun, 05 Dec 2021 20:50:38 +0000
Date:   Mon, 6 Dec 2021 04:50:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: drivers/remoteproc/imx_rproc.c:413:17: sparse: sparse: cast removes
 address space '__iomem' of expression
Message-ID: <202112060443.rxnbCl3h-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   944207047ca4dabe8e288f653e7ec6da05e70230
commit: 5e4c1243071d29ed5511121d044116b942ba6a7b remoteproc: imx_rproc: support remote cores booted before Linux Kernel
date:   8 months ago
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20211206/202112060443.rxnbCl3h-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5e4c1243071d29ed5511121d044116b942ba6a7b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 5e4c1243071d29ed5511121d044116b942ba6a7b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/dma/ drivers/gpu/drm/tegra/ drivers/net/wireless/mediatek/mt76/mt7915/ drivers/remoteproc/ drivers/staging/ fs/proc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/remoteproc/imx_rproc.c:299:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *va @@     got void [noderef] __iomem * @@
   drivers/remoteproc/imx_rproc.c:299:12: sparse:     expected void *va
   drivers/remoteproc/imx_rproc.c:299:12: sparse:     got void [noderef] __iomem *
   drivers/remoteproc/imx_rproc.c:316:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got void *va @@
   drivers/remoteproc/imx_rproc.c:316:20: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/remoteproc/imx_rproc.c:316:20: sparse:     got void *va
>> drivers/remoteproc/imx_rproc.c:413:17: sparse: sparse: cast removes address space '__iomem' of expression

vim +/__iomem +413 drivers/remoteproc/imx_rproc.c

   403	
   404	static struct resource_table *imx_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
   405	{
   406		struct imx_rproc *priv = rproc->priv;
   407	
   408		/* The resource table has already been mapped in imx_rproc_addr_init */
   409		if (!priv->rsc_table)
   410			return NULL;
   411	
   412		*table_sz = SZ_1K;
 > 413		return (struct resource_table *)priv->rsc_table;
   414	}
   415	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
