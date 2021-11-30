Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2EF46413D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbhK3W14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:27:56 -0500
Received: from mga09.intel.com ([134.134.136.24]:15864 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235555AbhK3W1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:27:50 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="236151021"
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="236151021"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 14:24:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="477288379"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 30 Nov 2021 14:24:28 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1msBY4-000DpU-6q; Tue, 30 Nov 2021 22:24:28 +0000
Date:   Wed, 1 Dec 2021 06:23:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Blakey <paulb@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
        Oz Shlomo <ozsh@nvidia.com>
Subject: [saeed:testing/mlx5-queue-next 597/628]
 net/openvswitch/flow.c:915:19: warning: variable 'zone' is uninitialized
 when used here
Message-ID: <202112010637.b4mONzF9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git testing/mlx5-queue-next
head:   28c32f565d2be3795dfe2acd0c00b7dcda32645a
commit: 0685a5cf41c932ac2392ebb9145cd002c5b687d0 [597/628] net: openvswitch: Fix matching zone id for invalid conns arriving from tc
config: x86_64-randconfig-r022-20211130 (https://download.01.org/0day-ci/archive/20211201/202112010637.b4mONzF9-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 25eb7fa01d7ebbe67648ea03841cda55b4239ab2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git/commit/?id=0685a5cf41c932ac2392ebb9145cd002c5b687d0
        git remote add saeed https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git
        git fetch --no-tags saeed testing/mlx5-queue-next
        git checkout 0685a5cf41c932ac2392ebb9145cd002c5b687d0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash net/openvswitch/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/openvswitch/flow.c:915:19: warning: variable 'zone' is uninitialized when used here [-Wuninitialized]
                           key->ct_zone = zone;
                                          ^~~~
   net/openvswitch/flow.c:864:10: note: initialize the variable 'zone' to silence this warning
           u16 zone;
                   ^
                    = 0
   1 warning generated.


vim +/zone +915 net/openvswitch/flow.c

   910	
   911		err = key_extract(skb, key);
   912		if (!err) {
   913			ovs_ct_fill_key(skb, key, post_ct);   /* Must be after key_extract(). */
   914			if (post_ct && !skb_get_nfct(skb))
 > 915				key->ct_zone = zone;
   916		}
   917		return err;
   918	}
   919	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
