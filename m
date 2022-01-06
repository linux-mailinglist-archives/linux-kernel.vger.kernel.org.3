Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE5A485E67
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 03:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344585AbiAFCDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 21:03:13 -0500
Received: from mga02.intel.com ([134.134.136.20]:57012 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344582AbiAFCDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 21:03:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641434585; x=1672970585;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5DZFzriPP1VDbGGyAdL6nk60CNLgZxX2BcJp9/5+VuI=;
  b=gD0XxBtS9LN8UcdtdjB3AMlz4bKj0osBxN033JLxPjijugjfbpKQ2Nkp
   5eukn1WY02PcEPy8UZp4WRWFlArEQKBj3oBcmpI2tui9EfStB6Z2GdARx
   g7assHkY3ffJmbiNV6SVXn2cbSTyW31O8fcqNx4Pi1+C/8r95GVWk8fYN
   a3YT5FR50ZXzeSE59ePnmeEe1zFUsHDzfcc7gKNqVodbd75IZwbAFn1iI
   LgctzgS5Uhj08mYZpwQqtHwt0tiLL8RNLc1itaAQGpy8jjEyqlTNqc7Fl
   Xo0pDoepP/UQ3oOS/KANgXbvpGKITUuowYo27e+sWaOR6KEDdxZi8uAMP
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="229896842"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="229896842"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 18:03:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="668300261"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 05 Jan 2022 18:03:02 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5I7J-000HEt-TJ; Thu, 06 Jan 2022 02:03:01 +0000
Date:   Thu, 6 Jan 2022 10:02:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [bigeasy-staging:memcg 5/5] mm/memcontrol.c:2133:2: warning:
 #warning Optimisation in place
Message-ID: <202201060957.kIjdfilS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bigeasy/staging.git memcg
head:   47e47279015085e921d201c2d7f46f138c55d6f0
commit: 47e47279015085e921d201c2d7f46f138c55d6f0 [5/5] memcg: Kind of micro benchmark.
config: m68k-randconfig-r014-20220105 (https://download.01.org/0day-ci/archive/20220106/202201060957.kIjdfilS-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/bigeasy/staging.git/commit/?id=47e47279015085e921d201c2d7f46f138c55d6f0
        git remote add bigeasy-staging https://git.kernel.org/pub/scm/linux/kernel/git/bigeasy/staging.git
        git fetch --no-tags bigeasy-staging memcg
        git checkout 47e47279015085e921d201c2d7f46f138c55d6f0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/memcontrol.c:2133:2: warning: #warning Optimisation in place [-Wcpp]
    2133 | #warning Optimisation in place
         |  ^~~~~~~


vim +2133 mm/memcontrol.c

  2126	
  2127	struct memcg_stock_pcp {
  2128		/* Protects memcg_stock_pcp */
  2129		local_lock_t stock_lock;
  2130		struct mem_cgroup *cached; /* this never be root cgroup */
  2131		unsigned int nr_pages;
  2132	#ifndef DO_NO_OPTIMISATION
> 2133	#warning Optimisation in place
  2134		/* Protects only task_obj */
  2135		local_lock_t task_obj_lock;
  2136		struct obj_stock task_obj;
  2137	#endif
  2138		struct obj_stock irq_obj;
  2139	
  2140		struct work_struct work;
  2141		unsigned long flags;
  2142	#define FLUSHING_CACHED_CHARGE	0
  2143	};
  2144	static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock) = {
  2145		.stock_lock = INIT_LOCAL_LOCK(stock_lock),
  2146	#ifndef DO_NO_OPTIMISATION
  2147		.task_obj_lock = INIT_LOCAL_LOCK(task_obj_lock),
  2148	#endif
  2149	};
  2150	static DEFINE_MUTEX(percpu_charge_mutex);
  2151	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
