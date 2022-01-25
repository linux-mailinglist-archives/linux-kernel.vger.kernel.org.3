Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F8C49A894
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1319553AbiAYDJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:09:07 -0500
Received: from mga09.intel.com ([134.134.136.24]:19971 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231483AbiAYCgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 21:36:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643078181; x=1674614181;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iVWmi0NYMq09PnDrKJZIGnXwDprwNIKzw5zU1ymktuY=;
  b=l3xe8GnS0nNbqm/c3r1v770o2uoY6I5xBb2bbm5p/j1w+AsMz9+QOM+h
   5j/Y3KY6W5tUOM7wb1WW47CIwC0ttTzK5eDzi/Hcf3w5nziMlXy8b5qbv
   F/wlYSej+c1tVN40/H6/5a9g9q5Wq+1SzaVGXSOIunIvU7LjaRXxNYZTn
   hr12Nx4/ARXFgDEi0wAFl1qFoEBv+qUfunVMyH9Df0Ej8UIANDfhxWttb
   b+DKOualLB88dyaUlqCnm/2YTuRiWVhSdIU1aRGo5jCC7GzkIdmnQd9go
   EFYd3giRwL1lPrSpbGTddlzOlgiI5aULaVqM5n3v9EJmvD/x+//nS2xx9
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="245983371"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="245983371"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 18:36:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="695656665"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 24 Jan 2022 18:36:19 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCBgx-000JEZ-3Z; Tue, 25 Jan 2022 02:36:19 +0000
Date:   Tue, 25 Jan 2022 10:35:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: mm/kasan/sw_tags.c:211:6: warning: no previous prototype for
 'kasan_tag_mismatch'
Message-ID: <202201251032.njnCerSX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0
commit: 1cbdf60bd1b74e397d48aa877367cfc621f45ffe kasan: arm64: support specialized outlined tag mismatch checks
date:   8 months ago
config: arm64-randconfig-r005-20220124 (https://download.01.org/0day-ci/archive/20220125/202201251032.njnCerSX-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1cbdf60bd1b74e397d48aa877367cfc621f45ffe
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 1cbdf60bd1b74e397d48aa877367cfc621f45ffe
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/kasan/sw_tags.c:211:6: warning: no previous prototype for 'kasan_tag_mismatch' [-Wmissing-prototypes]
     211 | void kasan_tag_mismatch(unsigned long addr, unsigned long access_info,
         |      ^~~~~~~~~~~~~~~~~~


vim +/kasan_tag_mismatch +211 mm/kasan/sw_tags.c

   210	
 > 211	void kasan_tag_mismatch(unsigned long addr, unsigned long access_info,

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
