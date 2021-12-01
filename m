Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9B4464C6B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 12:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348890AbhLALQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 06:16:48 -0500
Received: from mga05.intel.com ([192.55.52.43]:41868 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232968AbhLALQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 06:16:47 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="322682220"
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="322682220"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 03:13:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="747511791"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 01 Dec 2021 03:13:25 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1msNYC-000EoM-SW; Wed, 01 Dec 2021 11:13:24 +0000
Date:   Wed, 1 Dec 2021 19:12:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luo bin <luobin9@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/huawei/hinic/hinic_main.c:796:25: sparse:
 sparse: cast to restricted __be16
Message-ID: <202112011907.Q6F2ZYJU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   58e1100fdc5990b0cc0d4beaf2562a92e621ac7d
commit: 1f62cfa19a619f82c098468660b7950477101d45 hinic: add net_device_ops associated with vf
date:   1 year, 7 months ago
config: x86_64-randconfig-s022-20211124 (https://download.01.org/0day-ci/archive/20211201/202112011907.Q6F2ZYJU-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1f62cfa19a619f82c098468660b7950477101d45
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 1f62cfa19a619f82c098468660b7950477101d45
        # save the config file to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/huawei/hinic/hinic_main.c:796:25: sparse: sparse: cast to restricted __be16
>> drivers/net/ethernet/huawei/hinic/hinic_main.c:796:25: sparse: sparse: cast to restricted __be16
>> drivers/net/ethernet/huawei/hinic/hinic_main.c:796:25: sparse: sparse: cast to restricted __be16
>> drivers/net/ethernet/huawei/hinic/hinic_main.c:796:25: sparse: sparse: cast to restricted __be16

vim +796 drivers/net/ethernet/huawei/hinic/hinic_main.c

   778	
   779	static void hinic_tx_timeout(struct net_device *netdev, unsigned int txqueue)
   780	{
   781		struct hinic_dev *nic_dev = netdev_priv(netdev);
   782		u16 sw_pi, hw_ci, sw_ci;
   783		struct hinic_sq *sq;
   784		u16 num_sqs, q_id;
   785	
   786		num_sqs = hinic_hwdev_num_qps(nic_dev->hwdev);
   787	
   788		netif_err(nic_dev, drv, netdev, "Tx timeout\n");
   789	
   790		for (q_id = 0; q_id < num_sqs; q_id++) {
   791			if (!netif_xmit_stopped(netdev_get_tx_queue(netdev, q_id)))
   792				continue;
   793	
   794			sq = hinic_hwdev_get_sq(nic_dev->hwdev, q_id);
   795			sw_pi = atomic_read(&sq->wq->prod_idx) & sq->wq->mask;
 > 796			hw_ci = be16_to_cpu(*(u16 *)(sq->hw_ci_addr)) & sq->wq->mask;
   797			sw_ci = atomic_read(&sq->wq->cons_idx) & sq->wq->mask;
   798			netif_err(nic_dev, drv, netdev, "Txq%d: sw_pi: %d, hw_ci: %d, sw_ci: %d, napi->state: 0x%lx\n",
   799				  q_id, sw_pi, hw_ci, sw_ci,
   800				  nic_dev->txqs[q_id].napi.state);
   801		}
   802	}
   803	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
