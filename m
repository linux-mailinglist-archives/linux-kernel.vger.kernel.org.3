Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FA74EB7EE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 03:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241709AbiC3BsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 21:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237034AbiC3BsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 21:48:23 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3477BF56
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 18:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648604799; x=1680140799;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qbyCDmYtPUSUSQF/ImiQwGKuEEb49FyM1MQ7n7XgOJ4=;
  b=LXnlb7tqXD4LNQNeoegwlXuolIPpNgiWZ90a+udH/YL7xTaHs8/jBNiw
   Dp6Hyna/IqgeN0SiKu+R0fVWZFnT2DdLexGXIj6ZoDIwyqtEkP+XTiWo5
   osCU9xXhlDNIl/imrubE6GGxlpF+izCAnLtqhNoKW9gtlIG12sI1AhdeH
   /U5x7GbLn6PwGhR50ZNI20jiva2u/iF5wun2rYtQlGEWKubKUzD4IN9zs
   NMNXL1uDVP7nJ9ZYxloqWA8E5oDsyPbpHeptNVxS3zcjrEjZVO/xxgkzH
   lZO8brCOqbS2BfCLryn15r8mWoYE7I36nwzKGL6f5jhE+i4lPNmvf95iV
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="284326795"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="284326795"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 18:46:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="585815499"
Received: from lkp-server01.sh.intel.com (HELO 3965e2759b93) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 29 Mar 2022 18:46:37 -0700
Received: from kbuild by 3965e2759b93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZNPw-0000sL-QU; Wed, 30 Mar 2022 01:46:36 +0000
Date:   Wed, 30 Mar 2022 09:45:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: arch/arm64/kernel/elfcore.c:25:12: warning: stack frame size (2144)
 exceeds limit (2048) in 'mte_dump_tag_range'
Message-ID: <202203300903.AceWJDUu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1c24a186398f59c80adb9a967486b65c1423a59d
commit: 6dd8b1a0b6cb3ed93d24110e02e67ff9d006610a arm64: mte: Dump the MTE tags in the core file
date:   6 weeks ago
config: arm64-randconfig-r002-20220330 (https://download.01.org/0day-ci/archive/20220330/202203300903.AceWJDUu-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6dd8b1a0b6cb3ed93d24110e02e67ff9d006610a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6dd8b1a0b6cb3ed93d24110e02e67ff9d006610a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kernel/elfcore.c:25:12: warning: stack frame size (2144) exceeds limit (2048) in 'mte_dump_tag_range' [-Wframe-larger-than]
   static int mte_dump_tag_range(struct coredump_params *cprm,
              ^
   1 warning generated.


vim +/mte_dump_tag_range +25 arch/arm64/kernel/elfcore.c

    23	
    24	/* Derived from dump_user_range(); start/end must be page-aligned */
  > 25	static int mte_dump_tag_range(struct coredump_params *cprm,
    26				      unsigned long start, unsigned long end)
    27	{
    28		unsigned long addr;
    29	
    30		for (addr = start; addr < end; addr += PAGE_SIZE) {
    31			char tags[MTE_PAGE_TAG_STORAGE];
    32			struct page *page = get_dump_page(addr);
    33	
    34			/*
    35			 * get_dump_page() returns NULL when encountering an empty
    36			 * page table entry that would otherwise have been filled with
    37			 * the zero page. Skip the equivalent tag dump which would
    38			 * have been all zeros.
    39			 */
    40			if (!page) {
    41				dump_skip(cprm, MTE_PAGE_TAG_STORAGE);
    42				continue;
    43			}
    44	
    45			/*
    46			 * Pages mapped in user space as !pte_access_permitted() (e.g.
    47			 * PROT_EXEC only) may not have the PG_mte_tagged flag set.
    48			 */
    49			if (!test_bit(PG_mte_tagged, &page->flags)) {
    50				put_page(page);
    51				dump_skip(cprm, MTE_PAGE_TAG_STORAGE);
    52				continue;
    53			}
    54	
    55			mte_save_page_tags(page_address(page), tags);
    56			put_page(page);
    57			if (!dump_emit(cprm, tags, MTE_PAGE_TAG_STORAGE))
    58				return 0;
    59		}
    60	
    61		return 1;
    62	}
    63	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
