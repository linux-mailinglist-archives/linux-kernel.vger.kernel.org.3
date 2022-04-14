Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1679500486
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 05:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239672AbiDNDKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 23:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiDNDK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 23:10:29 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C0A329A7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 20:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649905685; x=1681441685;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=A1UjxvQL6fwlQI2CZdSe5hSYU0puaYMCnXL/iorGGaU=;
  b=OCIZkWIExKNm2UXR7fACqgdm/A5dbaK2lG4s7Ro25UAU7A5rwrHzmexr
   MkLE0RBmZ3YJ2RO4xM/eTtzTYz9ofsjyRt4W/941V2rS65ppbuF7YPCMk
   118DPPEIGR9RzytRAjP5XdAvRhJDi6Va5k+0Q94fhu0aFhBNfgKxWoaek
   1y7Iw0vLyggzod+y7+IpnxG7K0hb5GiyVRs7JbIREtG8I/YlrevXw6o4I
   mFCJkBsatxybsSVXRHNZNd/US5nZW6vTrgLspjsaM7q5XSrrdCQdtgSeY
   +CNK+zWsEF+NBQVj/fYfJ8V01yfsdYieOhqqTjGQniuXCexEckM1v7C9N
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="250122650"
X-IronPort-AV: E=Sophos;i="5.90,258,1643702400"; 
   d="scan'208";a="250122650"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 20:07:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,258,1643702400"; 
   d="scan'208";a="508230450"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 13 Apr 2022 20:07:48 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neppk-0000nl-7F;
        Thu, 14 Apr 2022 03:07:48 +0000
Date:   Thu, 14 Apr 2022 11:07:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yishai Hadas <yishaih@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Leon Romanovsky <leon@kernel.org>
Subject: [leon-rdma:rdma-next 57/58] drivers/vfio/pci/mlx5/main.c:599:7:
 warning: variable 'ret' is used uninitialized whenever 'if' condition is
 true
Message-ID: <202204141155.DFh8ASSY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git rdma-next
head:   11b31c1f85bc8c8add385529aa3f307c3b383a11
commit: 07dcaed2de6ecba1f723f2937a15c4ed3d3bbd4d [57/58] vfio/mlx5: Run the SAVE state command in an async mode
config: arm64-buildonly-randconfig-r005-20220413 (https://download.01.org/0day-ci/archive/20220414/202204141155.DFh8ASSY-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6b7e6ea489f6dd45a9b0da9ac20871560917b9b0)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/commit/?id=07dcaed2de6ecba1f723f2937a15c4ed3d3bbd4d
        git remote add leon-rdma https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git
        git fetch --no-tags leon-rdma rdma-next
        git checkout 07dcaed2de6ecba1f723f2937a15c4ed3d3bbd4d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/vfio/pci/mlx5/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/vfio/pci/mlx5/main.c:599:7: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
                   if (!mvdev->cb_wq)
                       ^~~~~~~~~~~~~
   drivers/vfio/pci/mlx5/main.c:623:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/vfio/pci/mlx5/main.c:599:3: note: remove the 'if' if its condition is always false
                   if (!mvdev->cb_wq)
                   ^~~~~~~~~~~~~~~~~~
   drivers/vfio/pci/mlx5/main.c:589:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   1 warning generated.


vim +599 drivers/vfio/pci/mlx5/main.c

   584	
   585	static int mlx5vf_pci_probe(struct pci_dev *pdev,
   586				    const struct pci_device_id *id)
   587	{
   588		struct mlx5vf_pci_core_device *mvdev;
   589		int ret;
   590	
   591		mvdev = kzalloc(sizeof(*mvdev), GFP_KERNEL);
   592		if (!mvdev)
   593			return -ENOMEM;
   594		vfio_pci_core_init_device(&mvdev->core_device, pdev, &mlx5vf_pci_ops);
   595	
   596		if (pdev->is_virtfn && mlx5vf_cmd_is_migratable(mvdev)) {
   597			mvdev->migrate_cap = 1;
   598			mvdev->cb_wq = alloc_ordered_workqueue("mlx5vf_wq", 0);
 > 599			if (!mvdev->cb_wq)
   600				goto out_free;
   601			mvdev->core_device.vdev.migration_flags =
   602				VFIO_MIGRATION_STOP_COPY |
   603				VFIO_MIGRATION_P2P;
   604			mutex_init(&mvdev->state_mutex);
   605			spin_lock_init(&mvdev->reset_lock);
   606		}
   607	
   608		ret = vfio_pci_core_register_device(&mvdev->core_device);
   609		if (ret)
   610			goto out_free;
   611	
   612		dev_set_drvdata(&pdev->dev, mvdev);
   613		return 0;
   614	
   615	out_free:
   616		if (mvdev->migrate_cap) {
   617			mlx5vf_cmd_remove_migratable(mvdev);
   618			if (mvdev->cb_wq)
   619				destroy_workqueue(mvdev->cb_wq);
   620		}
   621		vfio_pci_core_uninit_device(&mvdev->core_device);
   622		kfree(mvdev);
   623		return ret;
   624	}
   625	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
