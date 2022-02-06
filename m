Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248454AAD9A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 04:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358853AbiBFDXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 22:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiBFDXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 22:23:03 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A61DC043186
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 19:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644117782; x=1675653782;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zRFZcFJxNOvl7gkKaNqqxG6U0Rwhutvl9H+hCyQSK1M=;
  b=XG5Zu3HJL/6Vj8ZoDwVvIw1vIYlJAea75IcLY/Ww3uAOdY5hkCGckIkT
   4gCPj44KUyjMlJ/6uXHK/4ViP4SVrej/PtUQRecfRS0SQrGzb+xBHhlFn
   G08wmwINo4RyCGkV/i+D9i5c2pWppPgjVLMFC0AAAJKpI47W2QQrqBet9
   XvFtovzEW4aL1zHOjod8mYiMcq1weoYJRXbT9muqDI4O2kGwLyNooGWZ6
   nNQ0g8sbn6SyQWHjrHpmNINFhQ7Zl8uKVUSazJ4V+xAuro9oVpBWboi4g
   IjCLMsfH92RUhvEUCQ5/OZPmY72QL5ZkGCeBOnHp5L8KHt++v5wiHeGx5
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10249"; a="273064415"
X-IronPort-AV: E=Sophos;i="5.88,346,1635231600"; 
   d="scan'208";a="273064415"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 19:23:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,346,1635231600"; 
   d="scan'208";a="481212395"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 05 Feb 2022 19:23:00 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nGY8h-000ZpT-GB; Sun, 06 Feb 2022 03:22:59 +0000
Date:   Sun, 6 Feb 2022 11:22:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: arch/arm64/kernel/mte.c:197:13: warning: no previous prototype for
 function 'kasan_hw_tags_enable'
Message-ID: <202202061150.YiFFY3QD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   90c9e950c0def5c354b4a6154a2ddda3e5f214ac
commit: e5af50a5df571c1d0268b02f924de49b742c990f arm64: kasan: mte: move GCR_EL1 switch to task switch when KASAN disabled
date:   4 months ago
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20220206/202202061150.YiFFY3QD-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project dee058c670593b999fec19c458dbbd882ad9de56)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e5af50a5df571c1d0268b02f924de49b742c990f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e5af50a5df571c1d0268b02f924de49b742c990f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/ drivers/ata/ drivers/usb/dwc3/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kernel/mte.c:197:13: warning: no previous prototype for function 'kasan_hw_tags_enable' [-Wmissing-prototypes]
   void __init kasan_hw_tags_enable(struct alt_instr *alt, __le32 *origptr,
               ^
   arch/arm64/kernel/mte.c:197:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init kasan_hw_tags_enable(struct alt_instr *alt, __le32 *origptr,
   ^
   static 
   arch/arm64/kernel/mte.c:103:20: warning: unused function '__mte_enable_kernel' [-Wunused-function]
   static inline void __mte_enable_kernel(const char *mode, unsigned long tcf)
                      ^
   2 warnings generated.


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
