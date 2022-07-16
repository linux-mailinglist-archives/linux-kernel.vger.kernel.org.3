Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E37576C4B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 09:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbiGPHAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 03:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGPHAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 03:00:04 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FB225C4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 00:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657954803; x=1689490803;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/XN5Pnh3nhOaYVsS7ZCS0UOd42gtt8vbOilqxvLu/ZE=;
  b=bEqRb/lEr3o/jn6Z3Iq2vv5tYMCMIaIcD1cByoJqUgahxmRADtmbN/Ox
   4TIdgkXs+5pDoEa+S9v6N8hxBf99BLFApIBPTG5coLXTqEKmGrIEVnN9m
   Y/AUXgoM5FdLEJ6AHupGOjQRzBI0UPy/VkvPgpGpcmFe75JsFlrKBZldO
   BN+qfQ2vqle/ZIM2hp09u1+AY7cemC7c+ZSdc7o8FGl5m+do58hlwWDMp
   sMRa4wbHWUcPYL7VB6XBnq5g4gbKbMMqwZO++vVlkpYQQQLAGWCbljpWr
   ultqHlTlHkYQ9xedNHebg7b7PmMkBGxCadbxxeypDVQYJg00nXG4wvIm0
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="285980039"
X-IronPort-AV: E=Sophos;i="5.92,276,1650956400"; 
   d="scan'208";a="285980039"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 00:00:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,276,1650956400"; 
   d="scan'208";a="664454614"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 16 Jul 2022 00:00:01 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCbmT-0001Fc-8C;
        Sat, 16 Jul 2022 07:00:01 +0000
Date:   Sat, 16 Jul 2022 14:59:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mahesh Bandewar <maheshb@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: ERROR: modpost: "__delay" [drivers/net/mdio/mdio-cavium.ko]
 undefined!
Message-ID: <202207161440.FvNE0J51-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mahesh,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9b59ec8d50a1f28747ceff9a4f39af5deba9540e
commit: 3753d9779038ab011e01b949253492aaa37bf57a net: fix build without CONFIG_SYSCTL definition
date:   1 year, 10 months ago
config: sh-randconfig-r014-20220716 (https://download.01.org/0day-ci/archive/20220716/202207161440.FvNE0J51-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3753d9779038ab011e01b949253492aaa37bf57a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 3753d9779038ab011e01b949253492aaa37bf57a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__delay" [drivers/net/mdio/mdio-cavium.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
