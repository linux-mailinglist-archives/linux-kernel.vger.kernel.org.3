Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4642446DED3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 00:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241067AbhLHXGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 18:06:35 -0500
Received: from mga17.intel.com ([192.55.52.151]:58834 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237516AbhLHXGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 18:06:35 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="218657664"
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="218657664"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 15:03:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="503254766"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 08 Dec 2021 15:02:59 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mv5xj-0001Ac-4x; Wed, 08 Dec 2021 23:02:59 +0000
Date:   Thu, 9 Dec 2021 07:02:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "charles.park" <charles.park@hardkernel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Dongjin Kim <tobetter@gmail.com>
Subject: [tobetter:odroid-5.16.y 31/75] drivers/thermal/thermal_helpers.c:79:
 warning: expecting prototype for thermal_zone_get_temp(). Prototype was for
 CRITICAL_TEMP() instead
Message-ID: <202112090618.OVdb1IM2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/tobetter/linux odroid-5.16.y
head:   04f296b5f991198f16f76ba15a23e9e00e30aac4
commit: 4ea975cf78cb5d4519abedbe526e1098882bdc88 [31/75] ODROID-XU4: Update hack avoiding the invalid temperature by TMU broken
config: i386-randconfig-a013-20211207 (https://download.01.org/0day-ci/archive/20211209/202112090618.OVdb1IM2-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/tobetter/linux/commit/4ea975cf78cb5d4519abedbe526e1098882bdc88
        git remote add tobetter https://github.com/tobetter/linux
        git fetch --no-tags tobetter odroid-5.16.y
        git checkout 4ea975cf78cb5d4519abedbe526e1098882bdc88
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kernel/ drivers/thermal/ mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/thermal/thermal_helpers.c:79: warning: expecting prototype for thermal_zone_get_temp(). Prototype was for CRITICAL_TEMP() instead


vim +79 drivers/thermal/thermal_helpers.c

    67	
    68	/**
    69	 * thermal_zone_get_temp() - returns the temperature of a thermal zone
    70	 * @tz: a valid pointer to a struct thermal_zone_device
    71	 * @temp: a valid pointer to where to store the resulting temperature.
    72	 *
    73	 * When a valid thermal zone reference is passed, it will fetch its
    74	 * temperature and fill @temp.
    75	 *
    76	 * Return: On success returns 0, an error code otherwise
    77	 */
    78	
  > 79	#define	CRITICAL_TEMP	120000
    80	int thermal_zone_data[4] = { 0, };
    81	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
