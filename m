Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DE8570CB9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiGKVbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiGKVbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:31:45 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A571228E3F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657575104; x=1689111104;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eTJe6TGm1wlUsvFnmKRHIcBxhcTdjUMjqpmUdR/JPrk=;
  b=l3tJ+QOnBfQ3XXpuMkPboVBOKk3le+2Wx7aM2gT526Vc702ceAHj5E/h
   D4LLx+FTFX2NLE4aFUVqtDkZht13T/h6VhDgwl+VoDDcRgmoQ+KuQtTi1
   x0MuaAXuU74y28uwS4qpY3iByOlGann1+TTIq6lApsP/3yFlE2O5guGqF
   AAIf0IzyIznHGEaCEKvWA1c9OIr/nZHJej9Y+CV4jp6euEmP8f9ZnstSH
   trFAu7x11lKDmKULfPqwH8/AU4ZNXI4bKYLQUIN4bVI3tkd1lygu73dum
   JCcxHxxmZevG6Gm9iElxpFR7UIIhEQ16MsvOnOl2SRtB1qSQZljOZfN6H
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="285516359"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="285516359"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 14:31:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="545172273"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 11 Jul 2022 14:31:42 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oB10H-0001F1-O1;
        Mon, 11 Jul 2022 21:31:41 +0000
Date:   Tue, 12 Jul 2022 05:31:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Moshe Tal <moshet@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>
Subject: [saeed:net-next 1/52]
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c:3466:12: warning: stack
 frame size (1068) exceeds limit (1024) in 'mlx5e_setup_tc'
Message-ID: <202207120503.gFGvtnc8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git net-next
head:   f42c9d1eb0a1e2c7f986e0c2f6b362fddd0cdae7
commit: b229566876d91a99322a682e98beaa68dc38f9c9 [1/52] net/mlx5e: Fix mqprio_rl handling on devlink reload
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220712/202207120503.gFGvtnc8-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6ce63e267aab79ca87bf63453d34dd3909ab978d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git/commit/?id=b229566876d91a99322a682e98beaa68dc38f9c9
        git remote add saeed https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git
        git fetch --no-tags saeed net-next
        git checkout b229566876d91a99322a682e98beaa68dc38f9c9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/hid/ drivers/md/ drivers/net/ethernet/mellanox/mlx5/core/ drivers/vfio/pci/mlx5/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/mellanox/mlx5/core/en_main.c:3466:12: warning: stack frame size (1068) exceeds limit (1024) in 'mlx5e_setup_tc' [-Wframe-larger-than]
   static int mlx5e_setup_tc(struct net_device *dev, enum tc_setup_type type,
              ^
   1 warning generated.


vim +/mlx5e_setup_tc +3466 drivers/net/ethernet/mellanox/mlx5/core/en_main.c

955bcb6ea0df0d Pablo Neira Ayuso  2019-07-09  3465  
9afe9a53537789 Or Gerlitz         2018-01-01 @3466  static int mlx5e_setup_tc(struct net_device *dev, enum tc_setup_type type,
de4784ca030fed Jiri Pirko         2017-08-07  3467  			  void *type_data)
0cf0f6d3d39672 Jiri Pirko         2017-08-07  3468  {
4e95bc268b915c Pablo Neira Ayuso  2019-07-09  3469  	struct mlx5e_priv *priv = netdev_priv(dev);
2ff349c5edfe3e Roi Dayan          2020-09-16  3470  	bool tc_unbind = false;
214baf22870cfa Maxim Mikityanskiy 2021-01-19  3471  	int err;
4e95bc268b915c Pablo Neira Ayuso  2019-07-09  3472  
2ff349c5edfe3e Roi Dayan          2020-09-16  3473  	if (type == TC_SETUP_BLOCK &&
2ff349c5edfe3e Roi Dayan          2020-09-16  3474  	    ((struct flow_block_offload *)type_data)->command == FLOW_BLOCK_UNBIND)
2ff349c5edfe3e Roi Dayan          2020-09-16  3475  		tc_unbind = true;
2ff349c5edfe3e Roi Dayan          2020-09-16  3476  
2ff349c5edfe3e Roi Dayan          2020-09-16  3477  	if (!netif_device_present(dev) && !tc_unbind)
2ff349c5edfe3e Roi Dayan          2020-09-16  3478  		return -ENODEV;
2ff349c5edfe3e Roi Dayan          2020-09-16  3479  
0cf0f6d3d39672 Jiri Pirko         2017-08-07  3480  	switch (type) {
daa664a5cdd599 Vlad Buslov        2019-08-29  3481  	case TC_SETUP_BLOCK: {
daa664a5cdd599 Vlad Buslov        2019-08-29  3482  		struct flow_block_offload *f = type_data;
daa664a5cdd599 Vlad Buslov        2019-08-29  3483  
c9f14470d04830 Vlad Buslov        2019-08-26  3484  		f->unlocked_driver_cb = true;
955bcb6ea0df0d Pablo Neira Ayuso  2019-07-09  3485  		return flow_block_cb_setup_simple(type_data,
955bcb6ea0df0d Pablo Neira Ayuso  2019-07-09  3486  						  &mlx5e_block_cb_list,
4e95bc268b915c Pablo Neira Ayuso  2019-07-09  3487  						  mlx5e_setup_tc_block_cb,
4e95bc268b915c Pablo Neira Ayuso  2019-07-09  3488  						  priv, priv, true);
daa664a5cdd599 Vlad Buslov        2019-08-29  3489  	}
575ed7d39e2fbe Nogah Frankel      2017-11-06  3490  	case TC_SETUP_QDISC_MQPRIO:
e2aeac448f06ac Tariq Toukan       2021-07-06  3491  		mutex_lock(&priv->state_lock);
e2aeac448f06ac Tariq Toukan       2021-07-06  3492  		err = mlx5e_setup_tc_mqprio(priv, type_data);
e2aeac448f06ac Tariq Toukan       2021-07-06  3493  		mutex_unlock(&priv->state_lock);
e2aeac448f06ac Tariq Toukan       2021-07-06  3494  		return err;
214baf22870cfa Maxim Mikityanskiy 2021-01-19  3495  	case TC_SETUP_QDISC_HTB:
214baf22870cfa Maxim Mikityanskiy 2021-01-19  3496  		mutex_lock(&priv->state_lock);
214baf22870cfa Maxim Mikityanskiy 2021-01-19  3497  		err = mlx5e_setup_tc_htb(priv, type_data);
214baf22870cfa Maxim Mikityanskiy 2021-01-19  3498  		mutex_unlock(&priv->state_lock);
214baf22870cfa Maxim Mikityanskiy 2021-01-19  3499  		return err;
0cf0f6d3d39672 Jiri Pirko         2017-08-07  3500  	default:
0cf0f6d3d39672 Jiri Pirko         2017-08-07  3501  		return -EOPNOTSUPP;
0cf0f6d3d39672 Jiri Pirko         2017-08-07  3502  	}
08fb1dacdd7634 Saeed Mahameed     2016-02-22  3503  }
08fb1dacdd7634 Saeed Mahameed     2016-02-22  3504  

:::::: The code at line 3466 was first introduced by commit
:::::: 9afe9a5353778994d4396f3d5ff639221bfa5cc9 net/mlx5e: Eliminate build warnings on no previous prototype

:::::: TO: Or Gerlitz <ogerlitz@mellanox.com>
:::::: CC: Saeed Mahameed <saeedm@mellanox.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
