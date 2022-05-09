Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A2B51F271
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 03:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbiEIBc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 21:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbiEIATe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 20:19:34 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282842606
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 17:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652055342; x=1683591342;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=knKEC0Iq6KIveFyK+ZG8yscddesG/kcvyLkhx3K9FUo=;
  b=kzakYx2CgJBVjbK2Y+cveOrw9X0hxoqg72OIjupf9n3smZu+v5ecCl69
   Vt9U8jlb1X8Ooi2eaeaZM0gaP7csp7byogyEZY7nnmzFNiPtD6d5vgVH5
   n4Lf9kO6p04hVj16PcRnfSFYphr+GLNz3qxub4XU02EqXRDdZBDqaL/1K
   cclHuJ+4fhUUpLwUhJvMcqxHWrjy+GVjUENkaXik9IYFH+d8dthFzjyhG
   pk7JZneEazw26bkV9SSyodIhWJt7wbmTCWDLxmMCi7HsgeO4m6rC5BEQN
   /Zl7N5j+JH6dWdYTHOGyMJYIhVfhkgw+mJrXb0JH8gSn8v+khl3l/aUOr
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="331921848"
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="331921848"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 17:15:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="737890833"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 May 2022 17:15:40 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nnr3r-000FyQ-Pw;
        Mon, 09 May 2022 00:15:39 +0000
Date:   Mon, 9 May 2022 08:14:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: WARNING: modpost: vmlinux.o(.text+0xa76d36): Section mismatch in
 reference from the function rtc_update_irq() to the variable .init.text:.L0
Message-ID: <202205090847.j9NvIYxI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a
commit: 170f37d6aa6ad4582eefd7459015de79e244536e block: Do not call folio_next() on an unreferenced folio
date:   4 days ago
config: riscv-randconfig-r042-20220509 (https://download.01.org/0day-ci/archive/20220509/202205090847.j9NvIYxI-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=170f37d6aa6ad4582eefd7459015de79e244536e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 170f37d6aa6ad4582eefd7459015de79e244536e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0xa76d36): Section mismatch in reference from the function rtc_update_irq() to the variable .init.text:.L0
The function rtc_update_irq() references
the variable __init .L0 .
This is often because rtc_update_irq lacks a __init
annotation or the annotation of .L0 is wrong.

Note: the below error/warnings can be found in parent commit:
<< WARNING: modpost: vmlinux.o(.text+0xa7418e): Section mismatch in reference from the function rtc_month_days() to the variable .init.setup:__setup_root_delay_setup
<< WARNING: modpost: vmlinux.o(.text+0xb2080e): Section mismatch in reference from the function thermal_zone_device_unregister() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xb34ff0): Section mismatch in reference from the function btintel_enter_mfg() to the variable .init.text:.LBB18955
<< WARNING: modpost: vmlinux.o(.text+0xb5964e): Section mismatch in reference from the function cpuidle_switch_governor() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xbacbfa): Section mismatch in reference from the function comedi_buf_map_get() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(__ex_table+0x141c): Section mismatch in reference from the variable .L0 to the variable .debug_str:.LASF1100

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
