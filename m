Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A70D5643A5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 05:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiGCDGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 23:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiGCDGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 23:06:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3339599
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 20:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656817589; x=1688353589;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+eAhjPwTCtRt7ojxBcxPVwkBfSLt3zDOOO3wCd70ZAI=;
  b=d/Zn2c5fBHG5Hk21f/9EERJvgHeIj7LyEqmyqopfW3PVd9BK3H3r2oyl
   rtEjETs9kgA3Py9YEtqOQ6aeoraiLhv1LlBGig97lY5u7TWLTn0Ooc6Kr
   JpghU9twYN7nxKjgSaTo3R5bYJfrKhkNhOeFSFtcs3cg5aSw37zzJM6GK
   ZCykyRhsn6HyEknxhyj9fLLXFIIgwaiQzz6f+ck5O9i2dNNbcYoR+uM1y
   1oyruc/rA6lmzPp+gG0TrkB+b2o64Lo6lBJXR1eHIuasu+cu+Ub8cFJrm
   uUHIRuVZ7slAYw0Qlg4Q+tpMMHz0J08H7SxeSjoicMO1mAvHA4hWyvUMP
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10396"; a="308425447"
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="308425447"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 20:06:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="918926215"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 02 Jul 2022 20:06:28 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7pwJ-000G1T-Fp;
        Sun, 03 Jul 2022 03:06:27 +0000
Date:   Sun, 3 Jul 2022 11:06:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: ERROR: modpost: "devm_platform_ioremap_resource"
 [drivers/char/xillybus/xillybus_of.ko] undefined!
Message-ID: <202207031135.AQGof8vl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   69cb6c6556ad89620547318439d6be8bb1629a5a
commit: ef019c5daf032dce0b95ed4d45bfec93c4fbcb9f PHY: Ingenic: fix unconditional build of phy-ingenic-usb
date:   1 year, 6 months ago
config: s390-buildonly-randconfig-r005-20220703 (https://download.01.org/0day-ci/archive/20220703/202207031135.AQGof8vl-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ef019c5daf032dce0b95ed4d45bfec93c4fbcb9f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ef019c5daf032dce0b95ed4d45bfec93c4fbcb9f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: "devm_ioremap_resource" [drivers/crypto/ccree/ccree.ko] undefined!
ERROR: modpost: "debugfs_create_regset32" [drivers/crypto/ccree/ccree.ko] undefined!
>> ERROR: modpost: "devm_platform_ioremap_resource" [drivers/char/xillybus/xillybus_of.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
