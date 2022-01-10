Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3737D489B56
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 15:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbiAJOgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 09:36:03 -0500
Received: from mga11.intel.com ([192.55.52.93]:17615 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230078AbiAJOgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 09:36:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641825361; x=1673361361;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DDIJMaL6iBDpA75linMLvqZD4M1de4xWei1G9dZZafU=;
  b=gTfTqgyNLbPQzCa3HVyZH8Qbjs1MZf8n7TqybpOenTiW9e1UrH8xZ3Tl
   JNSpCiEq2+giHA5yLkihbOf3BIzLApC268c6aznfxK+TMypnRTbDlvb85
   NqbIDSkowsea0Wbbk7dhiI3hubt6MZ6T4snul3icaumPAr4ttswcExc+3
   ZQrSXE5ZfFUZBdnzphP3odR+q95my/TvvL/cxAw3YClFVDjnSHO0p1/7f
   zCM93EVGI1Fisj/03DMbTOAo6ihxfZLTHn+SJjOyIeaYo5E5eMqTRUQFs
   0xDA0q48c0ZFweNnMphEAZ3+MFUsXWALtT40GyRPkp5ApdiY1ok3JjD+X
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="240787924"
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="240787924"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 06:36:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="558002972"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 10 Jan 2022 06:36:00 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6vmB-0003bw-LZ; Mon, 10 Jan 2022 14:35:59 +0000
Date:   Mon, 10 Jan 2022 22:35:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: ERROR: modpost: "devm_ioremap_resource" [drivers/dma/qcom/hdma.ko]
 undefined!
Message-ID: <202201102232.0WNjAoD3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   df0cc57e057f18e44dac8e6c18aba47ab53202f9
commit: ef019c5daf032dce0b95ed4d45bfec93c4fbcb9f PHY: Ingenic: fix unconditional build of phy-ingenic-usb
date:   1 year ago
config: s390-randconfig-r002-20220107 (https://download.01.org/0day-ci/archive/20220110/202201102232.0WNjAoD3-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ef019c5daf032dce0b95ed4d45bfec93c4fbcb9f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ef019c5daf032dce0b95ed4d45bfec93c4fbcb9f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: "devm_ioremap_resource" [drivers/dma/idma64.ko] undefined!
>> ERROR: modpost: "devm_ioremap_resource" [drivers/dma/qcom/hdma.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
