Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C71547C24
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 23:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbiFLVH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 17:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbiFLVHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 17:07:23 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B61A2E8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 14:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655068042; x=1686604042;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=liaL97G6wyURrRI/6hQHFGySPrDP8U/qY+PdmbQzbjs=;
  b=ATVjKv8Lkw8o+mDANb7XC2HuBv6L6ygKo02AdvBUC+lluKPdTEF0Iexg
   WDGI/zKco5Mzwtykh3jgIP0K0N7xR8rxJs/2ddEKk9rc8mUcE0/pMBHOp
   OmAoiReCkXRO5umibNwDZBj6a4/58GHDXkN1Yy1ZJGCLELql1KGoQbqSX
   yu/Q6vew+rGP+h+rLC6WN5ngvmdIc2XYtppMfwZUAlmSuSEhuxSI2I3j0
   HCdoSiMCqcK0weVt4zlsXb274X73xWf2dD8bW21fU5LOU/kq1ycah4RnA
   2kj5kepIYc1hYMO3R/WXGHOCRCk7XRDiZvFTEAAVR2Ezb+FNukRPlFQo3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="258537080"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="258537080"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2022 14:07:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="567615159"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 12 Jun 2022 14:07:20 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0Unn-000KEH-Oc;
        Sun, 12 Jun 2022 21:07:19 +0000
Date:   Mon, 13 Jun 2022 05:07:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: arch/arm/boot/compressed/atags_to_fdt.c:129:5: warning: stack frame
 size (1344) exceeds limit (1280) in 'atags_to_fdt'
Message-ID: <202206130405.5RwllP8f-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   997952851843935024962b51fc36c61b3c2d1ed4
commit: 672513bf583157cc088a32e75bd850dd9f81564c ARM: decompressor: disable stack protector
date:   6 months ago
config: arm-randconfig-r024-20220613 (https://download.01.org/0day-ci/archive/20220613/202206130405.5RwllP8f-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6466c9abf3674bade1f6ee859f24ebc7aaf9cd88)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=672513bf583157cc088a32e75bd850dd9f81564c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 672513bf583157cc088a32e75bd850dd9f81564c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/arm/boot/compressed/atags_to_fdt.c:129:5: warning: no previous prototype for function 'atags_to_fdt' [-Wmissing-prototypes]
   int atags_to_fdt(void *atag_list, void *fdt, int total_space)
       ^
   arch/arm/boot/compressed/atags_to_fdt.c:129:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int atags_to_fdt(void *atag_list, void *fdt, int total_space)
   ^
   static 
>> arch/arm/boot/compressed/atags_to_fdt.c:129:5: warning: stack frame size (1344) exceeds limit (1280) in 'atags_to_fdt' [-Wframe-larger-than]
   int atags_to_fdt(void *atag_list, void *fdt, int total_space)
       ^
   2 warnings generated.


vim +/atags_to_fdt +129 arch/arm/boot/compressed/atags_to_fdt.c

31d0b9f9982f8e Ben Dooks          2018-10-12  120  
b90b9a38251e9c Nicolas Pitre      2011-09-13  121  /*
b90b9a38251e9c Nicolas Pitre      2011-09-13  122   * Convert and fold provided ATAGs into the provided FDT.
b90b9a38251e9c Nicolas Pitre      2011-09-13  123   *
4716e2e34a22a8 Geert Uytterhoeven 2021-05-19  124   * Return values:
b90b9a38251e9c Nicolas Pitre      2011-09-13  125   *    = 0 -> pretend success
b90b9a38251e9c Nicolas Pitre      2011-09-13  126   *    = 1 -> bad ATAG (may retry with another possible ATAG pointer)
b90b9a38251e9c Nicolas Pitre      2011-09-13  127   *    < 0 -> error from libfdt
b90b9a38251e9c Nicolas Pitre      2011-09-13  128   */
b90b9a38251e9c Nicolas Pitre      2011-09-13 @129  int atags_to_fdt(void *atag_list, void *fdt, int total_space)

:::::: The code at line 129 was first introduced by commit
:::::: b90b9a38251e9c89c34179eccde57411ceb5f1aa ARM: zImage: allow supplementing appended DTB with traditional ATAG data

:::::: TO: Nicolas Pitre <nicolas.pitre@linaro.org>
:::::: CC: Nicolas Pitre <nico@fluxnic.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
