Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4345693B0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 22:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbiGFUy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 16:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiGFUy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 16:54:28 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE991CB1D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 13:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657140867; x=1688676867;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Si73b53CWRzRLHnLQZQCCRSvhNPSk6MH6cvs7vBca2w=;
  b=dZ/KiLLSabibirj+fCXWrdJ9jk2nsWF8PbAZGWkzChfSb78lRUTiNd9q
   ON8qNLEgbaAdzQ1ORl1C0Xwa6ZpMe0HX+ymD78eCKS2sZjhnsY52Z7QJM
   /g6sXQMftxf+WMFo0nruuNACJwh+3Q9IzMGcT629mF9Bp9vimt55POJLa
   A/EcNH9JDDXNfy5UUkMS+SUPQsEffPatOU2L4d0UjNlet/rQ1SheBW1mq
   giJoPxO70PuH3Rs3Q7gwcz3T20oELT9pgF1IQf4InCwnHUQD4Sidil0ud
   RKVPCA8hNquSL7TC2HfxFsLdPslkYrj6BhMGEJD48DRTDGRKZwbsXUFh4
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="347850490"
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="347850490"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 13:54:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="650839699"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jul 2022 13:54:25 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9C2T-000L2D-3L;
        Wed, 06 Jul 2022 20:54:25 +0000
Date:   Thu, 7 Jul 2022 04:54:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: ld.lld: error: section .dynamic file range overlaps with .text
Message-ID: <202207070418.WugtuACs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tong,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9f09069cde34dcd86f5ecf3a3139fd752020812f
commit: dffe11e280a42c2501e5b0cdebd85a77f539bb05 riscv/vdso: Add support for time namespaces
date:   9 months ago
config: riscv-randconfig-r014-20220706 (https://download.01.org/0day-ci/archive/20220707/202207070418.WugtuACs-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f553287b588916de09c66e3e32bf75e5060f967f)
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

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: section .dynamic file range overlaps with .text
   >>> .dynamic range is [0x710, 0x83F]
   >>> .text range is [0x800, 0x175F]
--
>> ld.lld: error: section .text file range overlaps with _ftrace_branch
   >>> .text range is [0x800, 0x175F]
   >>> _ftrace_branch range is [0x840, 0x997]
--
>> ld.lld: error: section .dynamic virtual address range overlaps with .text
   >>> .dynamic range is [0x710, 0x83F]
   >>> .text range is [0x800, 0x175F]
--
>> ld.lld: error: section .text virtual address range overlaps with _ftrace_branch
   >>> .text range is [0x800, 0x175F]
   >>> _ftrace_branch range is [0x840, 0x997]
--
>> ld.lld: error: section .dynamic load address range overlaps with .text
   >>> .dynamic range is [0x710, 0x83F]
   >>> .text range is [0x800, 0x175F]
--
>> ld.lld: error: section .text load address range overlaps with _ftrace_branch
   >>> .text range is [0x800, 0x175F]
   >>> _ftrace_branch range is [0x840, 0x997]
--
>> ld.lld: error: section .text load address range overlaps with _ftrace_branch
   >>> .text range is [0x800, 0x175F]
   >>> _ftrace_branch range is [0x840, 0x997]
--
   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
>> ld.lld: error: section .dynamic file range overlaps with .text
   >>> .dynamic range is [0x710, 0x83F]
   >>> .text range is [0x800, 0x175F]
--
>> ld.lld: error: section .text load address range overlaps with _ftrace_branch
   >>> .text range is [0x800, 0x175F]
   >>> _ftrace_branch range is [0x840, 0x997]
   llvm-nm: error: arch/riscv/kernel/vdso/vdso.so.dbg: No such file or directory

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
