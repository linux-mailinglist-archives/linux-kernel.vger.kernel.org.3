Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0E1576D55
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 12:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiGPKpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 06:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGPKpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 06:45:09 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512A22315A
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 03:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657968308; x=1689504308;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XXoIdsI06ApUFAXOZr8yxTpQ7ca8CjvUBMrdyW0LJ1A=;
  b=OaZselLOXGIOkW7gzG6vZnuwEUHHnhuXATAjv2DsubgAlA1wdAdLVpJk
   Epv5T7aTPbAjm22aHI0FouArMYWExVyYkcf2qtiAyp5XmwY+ygv0WNhTT
   DtrNxu96R+TgyOk8aZfGS4uJ7Rl6YDV99trSEtw25y1BXZLIF2axQxn1/
   PEZI9W2zT+yksWnsZkc12+GvZeQ/Ehl64TxEGQo+qru6bznfP4IGopgz4
   vHLXhTkEwn6potILLYWx4jGvtvLKUvOZWMswEJB5s0LBj8OO5FifHZ2OU
   nDWw/Sv7QMcjslTd4cgZ48b0YhEV/m9XlVyC0Hx+VkFXikMCm3D9o6Lbf
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="284725829"
X-IronPort-AV: E=Sophos;i="5.92,276,1650956400"; 
   d="scan'208";a="284725829"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 03:45:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,276,1650956400"; 
   d="scan'208";a="664483674"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 16 Jul 2022 03:45:06 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCfII-0001No-6L;
        Sat, 16 Jul 2022 10:45:06 +0000
Date:   Sat, 16 Jul 2022 18:44:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: ERROR: modpost: "clk_get_io" [drivers/watchdog/lantiq_wdt.ko]
 undefined!
Message-ID: <202207161803.gts1T5UA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9b59ec8d50a1f28747ceff9a4f39af5deba9540e
commit: c434b9f80b0923e6460031b0fd964f8b0bf3c6a6 MIPS: Kconfig: add MIPS_GENERIC_KERNEL symbol
date:   1 year, 10 months ago
config: mips-buildonly-randconfig-r006-20220715 (https://download.01.org/0day-ci/archive/20220716/202207161803.gts1T5UA-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 2da550140aa98cf6a3e96417c87f1e89e3a26047)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c434b9f80b0923e6460031b0fd964f8b0bf3c6a6
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c434b9f80b0923e6460031b0fd964f8b0bf3c6a6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "clk_get_io" [drivers/watchdog/lantiq_wdt.ko] undefined!
ERROR: modpost: "vhost_iotlb_itree_next" [drivers/vdpa/mlx5/mlx5_vdpa.ko] undefined!
ERROR: modpost: "vhost_iotlb_itree_first" [drivers/vdpa/mlx5/mlx5_vdpa.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
