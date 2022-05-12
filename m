Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C033E5253CB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357115AbiELRiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352513AbiELRiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:38:07 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B69A5C35C
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 10:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652377085; x=1683913085;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nEYj3OOQ3m648qxqkrIqIyY2ESb4SDyzBsyU91pQbJw=;
  b=DiIeKgnJRnsB6c8jAZcd4x8FH4c4BsY1NTNXvig5PqY4UFvmUBlahPpC
   3rWBVy4sxjCdbykthFA6iBsoHok8BcYV5Vwdeddy/5dJW08k+DBKf32Ba
   NJEG6cqdAOfVHNizSEq3LtgtzoxupLdEY9Ri2PD4DyW6ocYS77bziOIjE
   f5KecKGyQW/6bM3faovBwOhg9D+S19xvbr8jEfEb90hGymtYLeH1Ryj6v
   dxNfcdzr45cM2FP/9elywXJu0m6H4RLmhXk8KXNuEMXDAk7X/tqYruzYY
   VrT5E4HO8iVFeEEDmFvWo1s5mG1QI6IHOZWc4meTVEYuYFY7VwMTj8ZSz
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="257632538"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="257632538"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 10:32:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="624502461"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 12 May 2022 10:32:41 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npCg4-000KkM-EI;
        Thu, 12 May 2022 17:32:40 +0000
Date:   Fri, 13 May 2022 01:32:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: ld.lld: error: section .dynamic file range overlaps with .text
Message-ID: <202205130116.ow8tWsMr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tong,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   feb9c5e19e913b53cb536a7aa7c9f20107bb51ec
commit: dffe11e280a42c2501e5b0cdebd85a77f539bb05 riscv/vdso: Add support for time namespaces
date:   7 months ago
config: riscv-randconfig-r035-20220512 (https://download.01.org/0day-ci/archive/20220513/202205130116.ow8tWsMr-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 18dd123c56754edf62c7042dcf23185c3727610f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dffe11e280a42c2501e5b0cdebd85a77f539bb05
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout dffe11e280a42c2501e5b0cdebd85a77f539bb05
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: section .dynamic file range overlaps with .text
   >>> .dynamic range is [0x710, 0x83F]
   >>> .text range is [0x800, 0x11E7]
--
>> ld.lld: error: section .text file range overlaps with _ftrace_annotated_branch
   >>> .text range is [0x800, 0x11E7]
   >>> _ftrace_annotated_branch range is [0x840, 0xB9F]
--
>> ld.lld: error: section .dynamic virtual address range overlaps with .text
   >>> .dynamic range is [0x710, 0x83F]
   >>> .text range is [0x800, 0x11E7]
--
>> ld.lld: error: section .text virtual address range overlaps with _ftrace_annotated_branch
   >>> .text range is [0x800, 0x11E7]
   >>> _ftrace_annotated_branch range is [0x840, 0xB9F]
--
>> ld.lld: error: section .dynamic load address range overlaps with .text
   >>> .dynamic range is [0x710, 0x83F]
   >>> .text range is [0x800, 0x11E7]
--
>> ld.lld: error: section .text load address range overlaps with _ftrace_annotated_branch
   >>> .text range is [0x800, 0x11E7]
   >>> _ftrace_annotated_branch range is [0x840, 0xB9F]
--
>> ld.lld: error: section .text load address range overlaps with _ftrace_annotated_branch
   >>> .text range is [0x800, 0x11E7]
   >>> _ftrace_annotated_branch range is [0x840, 0xB9F]
--
   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
>> ld.lld: error: section .dynamic file range overlaps with .text
   >>> .dynamic range is [0x710, 0x83F]
   >>> .text range is [0x800, 0x11E7]
--
>> ld.lld: error: section .text load address range overlaps with _ftrace_annotated_branch
   >>> .text range is [0x800, 0x11E7]
   >>> _ftrace_annotated_branch range is [0x840, 0xB9F]
   llvm-nm: error: arch/riscv/kernel/vdso/vdso.so.dbg: No such file or directory

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
