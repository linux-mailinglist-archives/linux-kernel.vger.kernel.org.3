Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85434639F2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 16:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244288AbhK3P0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 10:26:40 -0500
Received: from mga07.intel.com ([134.134.136.100]:31244 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245721AbhK3PZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 10:25:24 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="299627555"
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="299627555"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 07:14:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="676867551"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 30 Nov 2021 07:14:54 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ms4qL-000DSs-Ak; Tue, 30 Nov 2021 15:14:53 +0000
Date:   Tue, 30 Nov 2021 23:14:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "charles.park" <charles.park@hardkernel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dongjin Kim <tobetter@gmail.com>
Subject: [tobetter:odroid-5.15.y 32/83]
 drivers/thermal/thermal_helpers.c:80:5: sparse: sparse: symbol
 'thermal_zone_data' was not declared. Should it be static?
Message-ID: <202111302347.ywvT3s48-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/tobetter/linux odroid-5.15.y
head:   31b3089969f700a8f6d8833b66ca89e104ba01ee
commit: 80ab63aad57c0100e5277218c03ce79f4256d8c4 [32/83] ODROID-XU4: Update hack avoiding the invalid temperature by TMU broken
config: i386-randconfig-s001-20211128 (https://download.01.org/0day-ci/archive/20211130/202111302347.ywvT3s48-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/tobetter/linux/commit/80ab63aad57c0100e5277218c03ce79f4256d8c4
        git remote add tobetter https://github.com/tobetter/linux
        git fetch --no-tags tobetter odroid-5.15.y
        git checkout 80ab63aad57c0100e5277218c03ce79f4256d8c4
        # save the config file to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/thermal/thermal_helpers.c:80:5: sparse: sparse: symbol 'thermal_zone_data' was not declared. Should it be static?

vim +/thermal_zone_data +80 drivers/thermal/thermal_helpers.c

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
    79	#define	CRITICAL_TEMP	120000
  > 80	int thermal_zone_data[4] = { 0, };
    81	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
