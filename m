Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A0D5855E2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 22:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239033AbiG2UHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 16:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiG2UHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 16:07:23 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5049177A56
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 13:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659125242; x=1690661242;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=n9VPcmGyb4APXNfilDXyG45keSxqJQDhTPJwEDOtIIY=;
  b=mE98cIO7PW8u3CxSShpSWT8/GAwo6yJY5DHQWZ2arpMtEJvADxhU/bjA
   0gj4SfthEUNnfIWsY4oJttog1y+FaeJv46Soi5t9xduAl9AbDWWtlGL7k
   1glhwi74DAUy7udVX41zQ0H5SvN9suzWsvokONoy7KgnmlsXPn3WFLA6J
   uqbp7pfC4vj/3WOBCGMeCymBgrjEgVSJ6oxe3kqi/W9FFFtBzi6zsShka
   uu5PAQfgFEx/S7BdhhKlE3LVMdWG30m4ibpxmzPmfLqDD07FccLIark/E
   StB5fm/q2fmTu8dHekzvyscz4MFitLnkO/XRTRd2mTQPT7y8NfhmzwLEs
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="288852654"
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="288852654"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 13:07:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="928857590"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jul 2022 13:07:20 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHWGW-000C3N-1B;
        Fri, 29 Jul 2022 20:07:20 +0000
Date:   Sat, 30 Jul 2022 04:06:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: arch/arm/boot/compressed/atags_to_fdt.c:129:5: warning: stack frame
 size (1344) exceeds limit (1280) in 'atags_to_fdt'
Message-ID: <202207300353.NK0xv7rn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bb83c99d3d0aa2f51ba0b2abd7115002620118e6
commit: 672513bf583157cc088a32e75bd850dd9f81564c ARM: decompressor: disable stack protector
date:   8 months ago
config: arm-randconfig-r016-20220724 (https://download.01.org/0day-ci/archive/20220730/202207300353.NK0xv7rn-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 83882606dbd7ffb0bdd3460356202d97705809c8)
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

>> arch/arm/boot/compressed/atags_to_fdt.c:129:5: warning: stack frame size (1344) exceeds limit (1280) in 'atags_to_fdt' [-Wframe-larger-than]
   int atags_to_fdt(void *atag_list, void *fdt, int total_space)
       ^
   1 warning generated.


vim +/atags_to_fdt +129 arch/arm/boot/compressed/atags_to_fdt.c

31d0b9f9982f8e3 Ben Dooks          2018-10-12  120  
b90b9a38251e9c8 Nicolas Pitre      2011-09-13  121  /*
b90b9a38251e9c8 Nicolas Pitre      2011-09-13  122   * Convert and fold provided ATAGs into the provided FDT.
b90b9a38251e9c8 Nicolas Pitre      2011-09-13  123   *
4716e2e34a22a8c Geert Uytterhoeven 2021-05-19  124   * Return values:
b90b9a38251e9c8 Nicolas Pitre      2011-09-13  125   *    = 0 -> pretend success
b90b9a38251e9c8 Nicolas Pitre      2011-09-13  126   *    = 1 -> bad ATAG (may retry with another possible ATAG pointer)
b90b9a38251e9c8 Nicolas Pitre      2011-09-13  127   *    < 0 -> error from libfdt
b90b9a38251e9c8 Nicolas Pitre      2011-09-13  128   */
b90b9a38251e9c8 Nicolas Pitre      2011-09-13 @129  int atags_to_fdt(void *atag_list, void *fdt, int total_space)

:::::: The code at line 129 was first introduced by commit
:::::: b90b9a38251e9c89c34179eccde57411ceb5f1aa ARM: zImage: allow supplementing appended DTB with traditional ATAG data

:::::: TO: Nicolas Pitre <nicolas.pitre@linaro.org>
:::::: CC: Nicolas Pitre <nico@fluxnic.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
