Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D3E47532C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 07:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240234AbhLOGuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 01:50:00 -0500
Received: from mga09.intel.com ([134.134.136.24]:52117 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240111AbhLOGuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 01:50:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639551000; x=1671087000;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tlWVm7QvhIjLJzb7sblUOYKNLCH6nsHpLHtq64kzL0A=;
  b=miChE0DIAMdxhs2XO11+RkkJGIQhMabfZIOgCjXvCgCktjkB24jUYdjf
   m9abbZiKzBF9DYg8oZzDw2RnC017CIGzX/0v6j5+xzW92AjpFjBpd9L3e
   VxbRL9agRKdr3XIg0+TxVekc8dPK1ff0jHpPc6g5vyUxRjU6ZDnMkBG1j
   LA1dKCbb4KfkLRZYNfL0PfKsjySKi3UJD8eoRiJD2zRCj7/cyqUnoVq5J
   esfuNxSFhP+qmtm+wvtcYRRzTstoTAm+286gx46pxnOyv7gMeVupDC64t
   Ynbd6psxsRq/ObBlVjgOuVpNLOmOri8NkinEMteLA9F/OtW/iQeKuWZRn
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="238975236"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="238975236"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 22:49:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="614601628"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 14 Dec 2021 22:49:48 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxO6l-0001Ot-VC; Wed, 15 Dec 2021 06:49:47 +0000
Date:   Wed, 15 Dec 2021 14:49:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:queue/5.10 6492/9999] ERROR: modpost:
 "raid6_2data_recov" [fs/btrfs/btrfs.ko] undefined!
Message-ID: <202112151422.M34sDTRZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/5.10
head:   a0e5648b46a984339e8c472bfe5da299dd65fc3b
commit: f7121692795c654b52b460a11107a87285bb1dcd [6492/9999] hexagon: handle {,SOFT}IRQENTRY_TEXT in linker script
config: hexagon-randconfig-r041-20211215 (https://download.01.org/0day-ci/archive/20211215/202112151422.M34sDTRZ-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project b6a2ddb6c8ac29412b1361810972e15221fa021c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=f7121692795c654b52b460a11107a87285bb1dcd
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/5.10
        git checkout f7121692795c654b52b460a11107a87285bb1dcd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: "__raw_writesl" [drivers/i3c/master/i3c-master-cdns.ko] undefined!
ERROR: modpost: "__raw_readsl" [drivers/i3c/master/i3c-master-cdns.ko] undefined!
>> ERROR: modpost: "raid6_2data_recov" [fs/btrfs/btrfs.ko] undefined!
>> ERROR: modpost: "raid6_datap_recov" [fs/btrfs/btrfs.ko] undefined!
>> ERROR: modpost: "raid6_call" [fs/btrfs/btrfs.ko] undefined!
>> ERROR: modpost: "xor_blocks" [fs/btrfs/btrfs.ko] undefined!
>> ERROR: modpost: "__compiletime_assert_963" [fs/btrfs/btrfs.ko] undefined!

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for BTRFS_FS
   Depends on BLOCK && !PPC_256K_PAGES && !PAGE_SIZE_256KB
   Selected by
   - TEST_KMOD && RUNTIME_TESTING_MENU && m && MODULES && NETDEVICES && NET_CORE && INET && BLOCK

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
