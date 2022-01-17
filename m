Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A83A490236
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 07:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbiAQG62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 01:58:28 -0500
Received: from mga17.intel.com ([192.55.52.151]:36473 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231831AbiAQG61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 01:58:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642402707; x=1673938707;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QJXNXylfBc3pDhoBdU0ktl/4GL3d03MxcuSmgZPA+BA=;
  b=mVCJ1CT1Esyve3CWNemkP/l4zhthBo5scrW8brxQn0T8ocLb+e27mVUw
   WSatCrAWpAVpGIDkFC80tCYozU2NX2Z74i52AvRpHNZ0WLPdvkqNkoXIn
   7pNpXS+WeuCQsOLWAlcYtmXyynEgYB0bVAT0Qazll6M44StHvzNZPv0f/
   T5ylidONMN2nk5+2jPlU6Js2R5ZNwoMxe3EdhKV2meN0PkT9ISkyMsUHD
   Po/156/0X2BDsM1UmRirzZYt+2FJ6CzCptF9m1KD4aYJHYy/bzvGzTQ0F
   86iMiNnt6ATjhr3IekYFSKJn6Q0dCu7UuGG4fYGao9CxpAGkQR0CaeBbz
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="225245249"
X-IronPort-AV: E=Sophos;i="5.88,294,1635231600"; 
   d="scan'208";a="225245249"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 22:58:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,294,1635231600"; 
   d="scan'208";a="692967973"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 16 Jan 2022 22:58:26 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9LyD-000BKL-Kh; Mon, 17 Jan 2022 06:58:25 +0000
Date:   Mon, 17 Jan 2022 14:57:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Schnelle <svens@stackframe.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Helge Deller <deller@gmx.de>
Subject: arch/parisc/kernel/toc.c:61:32: warning: no previous prototype for
 'toc_intr'
Message-ID: <202201171401.TSfnAVql-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   35ce8ae9ae2e471f92759f9d6880eab42cc1c3b6
commit: bc294838cc3443a2fbec58f8936ad4bd0a0b3055 parisc: add support for TOC (transfer of control)
date:   3 months ago
config: parisc-randconfig-r022-20220116 (https://download.01.org/0day-ci/archive/20220117/202201171401.TSfnAVql-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bc294838cc3443a2fbec58f8936ad4bd0a0b3055
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout bc294838cc3443a2fbec58f8936ad4bd0a0b3055
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash arch/parisc/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/parisc/kernel/toc.c:61:32: warning: no previous prototype for 'toc_intr' [-Wmissing-prototypes]
      61 | void notrace __noreturn __cold toc_intr(struct pt_regs *regs)
         |                                ^~~~~~~~


vim +/toc_intr +61 arch/parisc/kernel/toc.c

    60	
  > 61	void notrace __noreturn __cold toc_intr(struct pt_regs *regs)
    62	{
    63		struct pdc_toc_pim_20 pim_data20;
    64		struct pdc_toc_pim_11 pim_data11;
    65	
    66		nmi_enter();
    67	
    68		if (boot_cpu_data.cpu_type >= pcxu) {
    69			if (pdc_pim_toc20(&pim_data20))
    70				panic("Failed to get PIM data");
    71			toc20_to_pt_regs(regs, &pim_data20);
    72		} else {
    73			if (pdc_pim_toc11(&pim_data11))
    74				panic("Failed to get PIM data");
    75			toc11_to_pt_regs(regs, &pim_data11);
    76		}
    77	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
