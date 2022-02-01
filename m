Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0594A57B1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 08:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbiBAHW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 02:22:29 -0500
Received: from mga07.intel.com ([134.134.136.100]:26917 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231442AbiBAHW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 02:22:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643700148; x=1675236148;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=345Ki+DkLB68FVkiQKL21duYaEtgTMo8sK+Jj3ijCWQ=;
  b=nBgXGO8sshWyJzPWvQEKVun17A/zTVjpjjPPj4Lmu3W0BmMNmkQVJ1bX
   6A9mMyfB5S5/6duD6aKMNGdMNYaaVycL9pDMccG0mccoTqeMjbuX/wJBc
   2+CjWenEylAJiZ1gowIVjIkc8nuuFD5PBFrVIHxDWBt7QZSoSBOJyAdqs
   g2+becFYul4/mLGwAyAL6DuKZwB3VbUTs/iNOk7yd16ursnatynz9B9Mj
   puyA8QvKPiHUOw1+VJXFA2H0d9DK5U4L2/l1qko9Dg8/mrZWZV90MA5BH
   i5XaO53lGjVA6tKgIXAUgxBKg44pgcrX5NU40YAgXudTt6uWTHNcVEtJ1
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="310942462"
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="310942462"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 23:22:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="497260156"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 31 Jan 2022 23:22:26 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEnUf-000SxV-Dt; Tue, 01 Feb 2022 07:22:25 +0000
Date:   Tue, 1 Feb 2022 15:21:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: arch/arm64/kernel/mte.c:197:13: warning: no previous prototype for
 'kasan_hw_tags_enable'
Message-ID: <202202011512.JpvyKwtH-lkp@intel.com>
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
head:   26291c54e111ff6ba87a164d85d4a4e134b7315c
commit: e5af50a5df571c1d0268b02f924de49b742c990f arm64: kasan: mte: move GCR_EL1 switch to task switch when KASAN disabled
date:   4 months ago
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20220201/202202011512.JpvyKwtH-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e5af50a5df571c1d0268b02f924de49b742c990f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e5af50a5df571c1d0268b02f924de49b742c990f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kernel/mte.c:197:13: warning: no previous prototype for 'kasan_hw_tags_enable' [-Wmissing-prototypes]
     197 | void __init kasan_hw_tags_enable(struct alt_instr *alt, __le32 *origptr,
         |             ^~~~~~~~~~~~~~~~~~~~


vim +/kasan_hw_tags_enable +197 arch/arm64/kernel/mte.c

   196	
 > 197	void __init kasan_hw_tags_enable(struct alt_instr *alt, __le32 *origptr,
   198					 __le32 *updptr, int nr_inst)
   199	{
   200		BUG_ON(nr_inst != 1); /* Branch -> NOP */
   201	
   202		if (kasan_hw_tags_enabled())
   203			*updptr = cpu_to_le32(aarch64_insn_gen_nop());
   204	}
   205	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
