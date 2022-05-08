Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273C851EAB3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 02:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbiEHAXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 20:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiEHAXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 20:23:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F63CC12
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 17:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651969160; x=1683505160;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+vxAPkzxveR0ymbI5x+v5m759Qha/1RTi6UuTu9YXSY=;
  b=QjZ0zTdZ0A0M4sAwDC3Ns5G5pg/ArtVuxxf85+yFi5KwktunsVo2OsJ4
   HhXaqPHoTiAWuCFuHsuYFv0TR00kiiCZfb1RmuCfUuewGIDWx0nmQG8CT
   TMKejLZtC4MvFXlUEJ3V+20FtbeABOjGICcz4okjGR7MvjdUz98937gys
   og1H+2bcEH9FIWXTZUgx2yO+lIccCmMsiEsmFccKkGJzd2LOt5SVPBDAI
   Hc6RQWWkp9hJaZ1uo80/vXk1Hqd98J84uTHBd5qhCpCtno5b8N/4G0gqV
   nv8D2yyy8ej4Co2LQBhJk7Q307KIl/lnACw2tawqKnjk/+C3lRpjxHXct
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10340"; a="266360624"
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; 
   d="scan'208";a="266360624"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 17:19:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; 
   d="scan'208";a="518621052"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 07 May 2022 17:19:18 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nnUdp-000F5H-G5;
        Sun, 08 May 2022 00:19:17 +0000
Date:   Sun, 8 May 2022 08:18:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: arch/arm64/kernel/mte.c:197:13: warning: no previous prototype for
 'kasan_hw_tags_enable'
Message-ID: <202205080852.hDqWRhyQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   30c8e80f79329617012f07b09b70114592092ea4
commit: e5af50a5df571c1d0268b02f924de49b742c990f arm64: kasan: mte: move GCR_EL1 switch to task switch when KASAN disabled
date:   7 months ago
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20220508/202205080852.hDqWRhyQ-lkp@intel.com/config)
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
