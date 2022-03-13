Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417974D782C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 21:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbiCMUXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 16:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiCMUXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 16:23:17 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90BA7A9B1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 13:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647202929; x=1678738929;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9YapVSMVKThjCQUu7poc5w6eEUHWTa3pA/0z4XDeDIY=;
  b=dXM5nfCJ1sgK9gJLeY3/stfABq8GE1GXfMnG9rz622/BaK4uwJDX/kwX
   bm0GIGcWAz1EJKV+0+GqGbjJGI+azeyuuAzN3Ut9/C/+WYvfV95Pxh2xJ
   lEeAyHv1RqDtjPfrB9e020eKJ0ZXWMowdeVrqhajZuGc/L+Q2ZQP8Exhw
   3nX0pRBpN8+cw4IfK72rv/CB7MPygGV3tEwppea2D9j2YdTsOCK/WB9mC
   2VOw0CCbiV2toBrXqlcHJn7Go4Pf/ur51axWQcn5A9vzCfgIO/y/e+zSI
   /nO+eFfODndRCyzaVMa6KpoO+MEE4kximVz7kMj0SeP8+dx+wFRh8rYVO
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="255626718"
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="255626718"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 13:22:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="597669843"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 13 Mar 2022 13:22:07 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTUj8-0009FW-Cf; Sun, 13 Mar 2022 20:22:06 +0000
Date:   Mon, 14 Mar 2022 04:21:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gal Pressman <gal@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        Eric Dumazet <edumazet@google.com>
Subject: arch/mips/boot/compressed/uart-16550.c:44:6: warning: no previous
 prototype for function 'putc'
Message-ID: <202203140415.rtqGbgJn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gal,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f0e18b03fcafd8344539101f564ae358950ae892
commit: 48cec899e357cfb92d022a9c0df6bbe72a7f6951 tcp: Add a stub for sk_defer_free_flush()
date:   7 weeks ago
config: mips-randconfig-r016-20220313 (https://download.01.org/0day-ci/archive/20220314/202203140415.rtqGbgJn-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0467eb2cb7654c15ae366967ef35093c5724c416)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=48cec899e357cfb92d022a9c0df6bbe72a7f6951
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 48cec899e357cfb92d022a9c0df6bbe72a7f6951
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/mips/boot/compressed/uart-16550.c:44:6: warning: no previous prototype for function 'putc' [-Wmissing-prototypes]
   void putc(char c)
        ^
   arch/mips/boot/compressed/uart-16550.c:44:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void putc(char c)
   ^
   static 
   1 warning generated.


vim +/putc +44 arch/mips/boot/compressed/uart-16550.c

1b93b3c3e94be2 Wu Zhangjin 2009-10-14  43  
1b93b3c3e94be2 Wu Zhangjin 2009-10-14 @44  void putc(char c)

:::::: The code at line 44 was first introduced by commit
:::::: 1b93b3c3e94be2605759735a89fc935ba5f58dcf MIPS: Add support for GZIP / BZIP2 / LZMA compressed kernel images

:::::: TO: Wu Zhangjin <wuzhangjin@gmail.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
