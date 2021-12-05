Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B084688FE
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 04:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbhLED2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 22:28:47 -0500
Received: from mga03.intel.com ([134.134.136.65]:51416 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229682AbhLED2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 22:28:46 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10188"; a="237099676"
X-IronPort-AV: E=Sophos;i="5.87,288,1631602800"; 
   d="scan'208";a="237099676"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2021 19:25:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,288,1631602800"; 
   d="scan'208";a="610861298"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 04 Dec 2021 19:25:18 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mti9O-000Jkc-0o; Sun, 05 Dec 2021 03:25:18 +0000
Date:   Sun, 5 Dec 2021 11:24:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: drivers/net/ethernet/mediatek/mtk_ppe_offload.c:89:19: sparse:
 sparse: cast to restricted __be32
Message-ID: <202112051143.BEmnOe4O-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   23b55d673d7527b093cd97b7c217c82e70cd1af0
commit: 502e84e2382d92654a2ecbc52cdbdb5a11cdcec7 net: ethernet: mtk_eth_soc: add flow offloading support
date:   9 months ago
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20211205/202112051143.BEmnOe4O-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=502e84e2382d92654a2ecbc52cdbdb5a11cdcec7
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 502e84e2382d92654a2ecbc52cdbdb5a11cdcec7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/dma/ drivers/gpu/drm/msm/ drivers/gpu/drm/tegra/ drivers/interconnect/qcom/ drivers/net/ethernet/mediatek/ drivers/net/vmxnet3/ drivers/net/wireless/mediatek/mt76/mt7915/ drivers/remoteproc/ drivers/scsi/bnx2fc/ drivers/scsi/lpfc/ drivers/staging/ fs/proc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/mediatek/mtk_ppe_offload.c:89:19: sparse: sparse: cast to restricted __be32
>> drivers/net/ethernet/mediatek/mtk_ppe_offload.c:93:41: sparse: sparse: restricted __be32 degrades to integer
   drivers/net/ethernet/mediatek/mtk_ppe_offload.c:46:10: sparse: sparse: Initializer entry defined twice
   drivers/net/ethernet/mediatek/mtk_ppe_offload.c:47:10: sparse:   also defined here

vim +89 drivers/net/ethernet/mediatek/mtk_ppe_offload.c

    83	
    84	
    85	static int
    86	mtk_flow_mangle_ports(const struct flow_action_entry *act,
    87			      struct mtk_flow_data *data)
    88	{
  > 89		u32 val = ntohl(act->mangle.val);
    90	
    91		switch (act->mangle.offset) {
    92		case 0:
  > 93			if (act->mangle.mask == ~htonl(0xffff))
    94				data->dst_port = cpu_to_be16(val);
    95			else
    96				data->src_port = cpu_to_be16(val >> 16);
    97			break;
    98		case 2:
    99			data->dst_port = cpu_to_be16(val);
   100			break;
   101		default:
   102			return -EINVAL;
   103		}
   104	
   105		return 0;
   106	}
   107	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
