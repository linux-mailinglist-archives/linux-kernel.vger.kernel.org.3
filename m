Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD635756E2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 23:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbiGNV3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 17:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiGNV3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 17:29:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF8B6EE89
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 14:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657834187; x=1689370187;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3c8rieG5/+3xGe+SwE823C2HKOyaQKK2fvLIkpyKg6c=;
  b=TN7qkLVLQCWTE0gS26P3gEKSVJnH4ug+zb5UnoMJZBdW+dtGHKrIz2/X
   GRpZDT/kEDIanai5O8wLJ2WuDT295VkJnpCmSjoTwGpEEp3oNkYFGbs22
   Ta5S1hWmQ364bvbdLG/+o11zNy9fOL9akRq5RMVW08qcvUblS3pMxGfoo
   67e8wU0oVa1CHVoVf5vGNDmVtWTrhtzV2X4lWdFLLh08uEzfO7HRsrt3c
   wkT9MTEltxvVJOGC8pMv6UWCx2WyjuMaCh3xhkbAHabvBbc1Q/481X41Z
   tbtQQH5B9mXifL2XSkb+VC5FGSVibTn68zHgkw498Rxj8mG4Nj0jwHs/P
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="286772285"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="286772285"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 14:29:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="923237838"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jul 2022 14:29:44 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oC6P1-0001An-Qp;
        Thu, 14 Jul 2022 21:29:43 +0000
Date:   Fri, 15 Jul 2022 05:29:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jpoimboe:lkdtm 2/3] drivers/misc/lkdtm/rodata.c:14:26: error:
 expected string literal in 'asm'
Message-ID: <202207150539.2uMSuhwL-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git lkdtm
head:   91b11c81a070d7a1c75c467ccf6703b01cf78cfb
commit: 26fe5d8405b16b3153bdb867dda090256a561b80 [2/3] lkdtm: Disable return thunks in rodata.c
config: hexagon-randconfig-r024-20220714 (https://download.01.org/0day-ci/archive/20220715/202207150539.2uMSuhwL-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e61b9c556267086ef9b743a0b57df302eef831b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/commit/?id=26fe5d8405b16b3153bdb867dda090256a561b80
        git remote add jpoimboe https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git
        git fetch --no-tags jpoimboe lkdtm
        git checkout 26fe5d8405b16b3153bdb867dda090256a561b80
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/misc/lkdtm/rodata.c:14:26: error: expected string literal in 'asm'
                   asm(ANNOTATE_UNRET_SAFE);
                                          ^
   1 error generated.


vim +/asm +14 drivers/misc/lkdtm/rodata.c

     8	
     9	void noinstr lkdtm_rodata_do_nothing(void)
    10	{
    11		/* Does nothing. We just want an architecture agnostic "return". */
    12	
    13		if (IS_ENABLED(CONFIG_OBJTOOL))
  > 14			asm(ANNOTATE_UNRET_SAFE);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
