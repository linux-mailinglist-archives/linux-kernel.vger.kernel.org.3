Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BACF48DB6A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 17:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbiAMQKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 11:10:49 -0500
Received: from mga14.intel.com ([192.55.52.115]:18040 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229580AbiAMQKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:10:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642090248; x=1673626248;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CbtqcAL9sNRjSWYeVnC2OMJQxy7u/fu+lEXsTp92Wuk=;
  b=mA0QX2l2mEOBSDYMsVH+9leribnEXP9p28enYc54KueAKeuVsD+/OVhA
   BsFKQCgxgad8l+yyajTSaC49BewWGIHmFjfat9f66hINrf+lpZh41q0F6
   mwmhxA5zXCTGYNTGe2zVUIQZuOPt7x6znucgStBSZjk4bv7Mhi1lM7Qvl
   rgYun0A1yINmMMh9dXmL44zsGYVnZy/hhU5HMd8Ydo3mlxDxejjlcF03e
   a6iFLdkmkgCqam77z/mRF+Smfm+bOkDCnSr9jrjK0Kf13pz1TxSS0TrpI
   EXsebZ2TUBjVlFViGsmYjFwCyDOCpjAW8o97JJKTVx3VyB1hX/K+4WD/R
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="244245748"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="244245748"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 08:09:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="670557059"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jan 2022 08:09:56 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n82fj-0007Pp-Kq; Thu, 13 Jan 2022 16:09:55 +0000
Date:   Fri, 14 Jan 2022 00:09:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dongjin Kim <tobetter@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [tobetter:odroid-5.16.y 36/39]
 drivers/gpu/drm/tiny/ili9488_pio.c:335:36: sparse: sparse: Using plain
 integer as NULL pointer
Message-ID: <202201140003.Wboc0MzQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dongjin,

First bad commit (maybe != root cause):

tree:   https://github.com/tobetter/linux odroid-5.16.y
head:   cb59f7f629212302d4136a919ef9822aa9c84aac
commit: d5c3ea72c0e7fde4122fa642dc8c5169ac68fb01 [36/39] ODROID-COMMON: Revert "drm/dbi: Print errors for mipi_dbi_command()"
config: csky-randconfig-s032-20220113 (https://download.01.org/0day-ci/archive/20220114/202201140003.Wboc0MzQ-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/tobetter/linux/commit/d5c3ea72c0e7fde4122fa642dc8c5169ac68fb01
        git remote add tobetter https://github.com/tobetter/linux
        git fetch --no-tags tobetter odroid-5.16.y
        git checkout d5c3ea72c0e7fde4122fa642dc8c5169ac68fb01
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=csky SHELL=/bin/bash drivers/gpu/drm/tiny/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/tiny/ili9488_pio.c:335:36: sparse: sparse: Using plain integer as NULL pointer
   drivers/gpu/drm/tiny/ili9488_pio.c:336:47: sparse: sparse: Using plain integer as NULL pointer
   drivers/gpu/drm/tiny/ili9488_pio.c: note: in included file (through arch/csky/include/asm/io.h, include/linux/io.h, include/linux/dma-buf-map.h, ...):
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:299:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:299:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:299:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:299:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:299:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:299:22: sparse:     got restricted __le32 [usertype]

vim +335 drivers/gpu/drm/tiny/ili9488_pio.c

2ce4016e1804ca Dongjin Kim 2021-02-09  333  
2ce4016e1804ca Dongjin Kim 2021-02-09  334  static const struct of_device_id ili9488_dt_ids[] = {
2ce4016e1804ca Dongjin Kim 2021-02-09 @335  	{ .compatible = "ili9488", 0 },
2ce4016e1804ca Dongjin Kim 2021-02-09  336  	{ .compatible = "hardkernel,ili9488", 0 },
2ce4016e1804ca Dongjin Kim 2021-02-09  337  	{ },
2ce4016e1804ca Dongjin Kim 2021-02-09  338  };
2ce4016e1804ca Dongjin Kim 2021-02-09  339  

:::::: The code at line 335 was first introduced by commit
:::::: 2ce4016e1804ca6fb2285e3164d848d6975bad07 ODROID-COMMON: gpu/drm: Add new Tiny DRM driver with Ili9488

:::::: TO: Dongjin Kim <tobetter@gmail.com>
:::::: CC: Dongjin Kim <tobetter@gmail.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
