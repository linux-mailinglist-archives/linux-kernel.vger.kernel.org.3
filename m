Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A32545969
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 03:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241470AbiFJBD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 21:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiFJBD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 21:03:57 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24AA62A09
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 18:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654823036; x=1686359036;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=llu1rO6goque8rjpfrvxvxCSuUsDhs/BU/UWBdqD+Is=;
  b=l1q9zsGHl5oKQIzp3IcVJjOEynpiTP7qhWT+yXQT4aP0Hz/XdZGeFs/c
   7fGGTAHtz2uGuN5r/zQy+KvkxJ98HUxhB8FJL1V+EfWKpNY2ZM1LQ92+H
   V7nVBFv+vfkj0UpaQ/Qf2pWBgo/jrnQJZdLKiLVji8lml3kiZXaoZJ0iU
   pSHVVRzzjVzpLI1F69JGOsNaJjd9hZwFcYoKkjkSCulSMzJKavUEukDxD
   8ylMneWxth0pdf3UTGy2Cb7T0hI5hSskaLsxYOvtTIAdW1FVjCna94XqR
   BoZZKE5VPtgqBzcxFeN0QZa399asWRPhbLLBg+5eIdKX04nZL8oi/w97F
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="257297706"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="257297706"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 18:03:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="827920647"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 09 Jun 2022 18:03:55 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzT46-000GXx-CU;
        Fri, 10 Jun 2022 01:03:54 +0000
Date:   Fri, 10 Jun 2022 09:03:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: arch/arm64/kernel/mte.c:197:13: warning: no previous prototype for
 'kasan_hw_tags_enable'
Message-ID: <202206100910.yGy51caX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   874c8ca1e60b2c564a48f7e7acc40d328d5c8733
commit: e5af50a5df571c1d0268b02f924de49b742c990f arm64: kasan: mte: move GCR_EL1 switch to task switch when KASAN disabled
date:   8 months ago
config: arm64-alldefconfig (https://download.01.org/0day-ci/archive/20220610/202206100910.yGy51caX-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e5af50a5df571c1d0268b02f924de49b742c990f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e5af50a5df571c1d0268b02f924de49b742c990f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

Note: functions only called from assembly code should be annotated with the asmlinkage attribute
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
