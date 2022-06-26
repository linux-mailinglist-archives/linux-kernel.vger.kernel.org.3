Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF76255ADEE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 03:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbiFZBOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 21:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbiFZBOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 21:14:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B3A12AF3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 18:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656206085; x=1687742085;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9YUx/ia4ZXoU1I26EZo2cnKfqnlMluvbKpEQBK01d8M=;
  b=OQrvY4LTIbO98yBnho1mCSl3ZO47yr+CC0Iw9TbNVKVphGsn/9lYx5iS
   ZbZe95112yJPcAQGUue8TOhtsgTrHVLfx7r9PsC0EtEdlAtzbSodnMfkP
   oGsEBCv+Bh8HSDj+GFhT6VCyBPdYmYFF/BrsD8QIDRzgOt9VULeRYIPkx
   Fh1xepxuUKX7YzpwK4ln1TdUTGzj9KMFS/0TUS5Mq5qe8yKuvQaJcMRXF
   vq3jcOqMnNjqrAIU9CPybkFADWs79B5bhzp6Z4sB+sy8U5S2z1phjcLnH
   qjod0ZewH29n3T7oZEdOhmIPlim4ZsDfLTl4XFEFuL15FovrOziilgyid
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10389"; a="278778777"
X-IronPort-AV: E=Sophos;i="5.92,223,1650956400"; 
   d="scan'208";a="278778777"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 18:14:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,223,1650956400"; 
   d="scan'208";a="539687955"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 25 Jun 2022 18:14:41 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5GrJ-0006Wv-5k;
        Sun, 26 Jun 2022 01:14:41 +0000
Date:   Sun, 26 Jun 2022 09:14:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: arch/mips/boot/compressed/../../../../lib/lz4/lz4_decompress.c:510:5:
 warning: no previous prototype for function
 'LZ4_decompress_safe_forceExtDict'
Message-ID: <202206260948.akgsho1q-lkp@intel.com>
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

Hi Tiezhu,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0840a7914caa14315a3191178a9f72c742477860
commit: 7e4fd16b38923028b01d3dbadf4ca973d885c53e MIPS: RALINK: Define pci_remap_iospace under CONFIG_PCI_DRIVERS_GENERIC
date:   4 weeks ago
config: mips-randconfig-r035-20220626
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 42a7ddb428c999229491b0effbb1a4059149fba8)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mipsel-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7e4fd16b38923028b01d3dbadf4ca973d885c53e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7e4fd16b38923028b01d3dbadf4ca973d885c53e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/mips/boot/compressed/decompress.c:42:6: warning: no previous prototype for function 'error' [-Wmissing-prototypes]
   void error(char *x)
        ^
   arch/mips/boot/compressed/decompress.c:42:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void error(char *x)
   ^
   static 
   In file included from arch/mips/boot/compressed/decompress.c:64:
   In file included from arch/mips/boot/compressed/../../../../lib/decompress_unlz4.c:10:
>> arch/mips/boot/compressed/../../../../lib/lz4/lz4_decompress.c:510:5: warning: no previous prototype for function 'LZ4_decompress_safe_forceExtDict' [-Wmissing-prototypes]
   int LZ4_decompress_safe_forceExtDict(const char *source, char *dest,
       ^
   arch/mips/boot/compressed/../../../../lib/lz4/lz4_decompress.c:510:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int LZ4_decompress_safe_forceExtDict(const char *source, char *dest,
   ^
   static 
   arch/mips/boot/compressed/decompress.c:85:6: warning: no previous prototype for function '__stack_chk_fail' [-Wmissing-prototypes]
   void __stack_chk_fail(void)
        ^
   arch/mips/boot/compressed/decompress.c:85:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __stack_chk_fail(void)
   ^
   static 
   arch/mips/boot/compressed/decompress.c:90:6: warning: no previous prototype for function 'decompress_kernel' [-Wmissing-prototypes]
   void decompress_kernel(unsigned long boot_heap_start)
        ^
   arch/mips/boot/compressed/decompress.c:90:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void decompress_kernel(unsigned long boot_heap_start)
   ^
   static 
   4 warnings generated.
--
>> arch/mips/boot/compressed/dbg.c:12:13: warning: no previous prototype for function 'putc' [-Wmissing-prototypes]
   void __weak putc(char c)
               ^
   arch/mips/boot/compressed/dbg.c:12:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __weak putc(char c)
   ^
   static 
>> arch/mips/boot/compressed/dbg.c:16:6: warning: no previous prototype for function 'puts' [-Wmissing-prototypes]
   void puts(const char *s)
        ^
   arch/mips/boot/compressed/dbg.c:16:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void puts(const char *s)
   ^
   static 
>> arch/mips/boot/compressed/dbg.c:26:6: warning: no previous prototype for function 'puthex' [-Wmissing-prototypes]
   void puthex(unsigned long long val)
        ^
   arch/mips/boot/compressed/dbg.c:26:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void puthex(unsigned long long val)
   ^
   static 
   3 warnings generated.


vim +/LZ4_decompress_safe_forceExtDict +510 arch/mips/boot/compressed/../../../../lib/lz4/lz4_decompress.c

cffb78b0e0b3a3 Kyungsik Lee 2013-07-08  509  
2209fda323e2fd Gao Xiang    2018-10-30 @510  int LZ4_decompress_safe_forceExtDict(const char *source, char *dest,
2209fda323e2fd Gao Xiang    2018-10-30  511  				     int compressedSize, int maxOutputSize,
2209fda323e2fd Gao Xiang    2018-10-30  512  				     const void *dictStart, size_t dictSize)
2209fda323e2fd Gao Xiang    2018-10-30  513  {
2209fda323e2fd Gao Xiang    2018-10-30  514  	return LZ4_decompress_generic(source, dest,
2209fda323e2fd Gao Xiang    2018-10-30  515  				      compressedSize, maxOutputSize,
2209fda323e2fd Gao Xiang    2018-10-30  516  				      endOnInputSize, decode_full_block,
2209fda323e2fd Gao Xiang    2018-10-30  517  				      usingExtDict, (BYTE *)dest,
2209fda323e2fd Gao Xiang    2018-10-30  518  				      (const BYTE *)dictStart, dictSize);
2209fda323e2fd Gao Xiang    2018-10-30  519  }
2209fda323e2fd Gao Xiang    2018-10-30  520  

:::::: The code at line 510 was first introduced by commit
:::::: 2209fda323e2fd2a2d0885595fd5097717f8d2aa lib/lz4: update LZ4 decompressor module

:::::: TO: Gao Xiang <gaoxiang25@huawei.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
