Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3838047662E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 23:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhLOWsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 17:48:24 -0500
Received: from mga07.intel.com ([134.134.136.100]:9615 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230214AbhLOWsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 17:48:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639608503; x=1671144503;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7+iuF3QU/WHGsduwf3PU6Oxcnw2xOrdQLaVXWt/DL/k=;
  b=U5mganHB+kIzzow2SZ4gVs6Wyv6W7nvOvDRKHhWis5fvW3neiHeTr1ce
   +w8ZYk5/YPrGcRbE8/RouBFRzWYmNZxFGg59swmVwADIZJ7SveKHYHxY7
   zwW6LLqVmlCgfs+Ijiyvui8W4uVlUUIqj1rV7ZGwZ8thHnfN5mzibGf3R
   g1QOEdvSrz/JcsyPkCsag0JVEBMg/YhNSHC3fjbTj0O+d7faKj0lhbH/b
   C08yqEHjmNlsSDt2rugLRMzl3tcHxBhTQ6jCe3PKwCyCm79zB4FoVaXcy
   tatld/aMFhk6ncgSbYdjhijI6ChXAGNugakECiNFVUauN782ImU1Vzdhh
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="302726829"
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="302726829"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 14:48:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="506029031"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 15 Dec 2021 14:48:21 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxd4O-0002Qh-Kg; Wed, 15 Dec 2021 22:48:20 +0000
Date:   Thu, 16 Dec 2021 06:47:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/arm/boot/compressed/../../../../lib/xz/xz_dec_stream.c:393:28:
 sparse: sparse: incorrect type in argument 1 (different base types)
Message-ID: <202112160656.JFn67Wnh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5472f14a37421d1bca3dddf33cabd3bd6dbefbbc
commit: 5445a0c0d3366358e7ac44efa108b6fd359873e3 memory: pl353-smc: fix compile test on !ARM_AMBA
date:   1 year, 1 month ago
config: arm-randconfig-s032-20211215 (https://download.01.org/0day-ci/archive/20211216/202112160656.JFn67Wnh-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5445a0c0d3366358e7ac44efa108b6fd359873e3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 5445a0c0d3366358e7ac44efa108b6fd359873e3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   arch/arm/boot/compressed/decompress.c: note: in included file (through arch/arm/boot/compressed/../../../../lib/decompress_unxz.c):
   include/linux/decompress/mm.h:31:30: sparse: sparse: symbol 'malloc_ptr' was not declared. Should it be static?
   include/linux/decompress/mm.h:32:20: sparse: sparse: symbol 'malloc_count' was not declared. Should it be static?
   arch/arm/boot/compressed/decompress.c: note: in included file (through arch/arm/boot/compressed/../../../../lib/decompress_unxz.c):
   arch/arm/boot/compressed/decompress.c: note: in included file (through arch/arm/boot/compressed/../../../../lib/decompress_unxz.c):
>> arch/arm/boot/compressed/../../../../lib/xz/xz_dec_stream.c:393:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
   arch/arm/boot/compressed/../../../../lib/xz/xz_dec_stream.c:393:28: sparse:     expected restricted __le32 const [usertype] *p
   arch/arm/boot/compressed/../../../../lib/xz/xz_dec_stream.c:393:28: sparse:     got unsigned int const [usertype] *
   arch/arm/boot/compressed/../../../../lib/xz/xz_dec_stream.c:427:48: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
   arch/arm/boot/compressed/../../../../lib/xz/xz_dec_stream.c:427:48: sparse:     expected restricted __le32 const [usertype] *p
   arch/arm/boot/compressed/../../../../lib/xz/xz_dec_stream.c:427:48: sparse:     got unsigned int const [usertype] *
   arch/arm/boot/compressed/../../../../lib/xz/xz_dec_stream.c:435:37: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
   arch/arm/boot/compressed/../../../../lib/xz/xz_dec_stream.c:435:37: sparse:     expected restricted __le32 const [usertype] *p
   arch/arm/boot/compressed/../../../../lib/xz/xz_dec_stream.c:435:37: sparse:     got unsigned int const [usertype] *
   arch/arm/boot/compressed/../../../../lib/xz/xz_dec_stream.c:459:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
   arch/arm/boot/compressed/../../../../lib/xz/xz_dec_stream.c:459:28: sparse:     expected restricted __le32 const [usertype] *p
   arch/arm/boot/compressed/../../../../lib/xz/xz_dec_stream.c:459:28: sparse:     got unsigned int const [usertype] *

vim +393 arch/arm/boot/compressed/../../../../lib/xz/xz_dec_stream.c

24fa0402a9b6a53 Lasse Collin 2011-01-12  385  
24fa0402a9b6a53 Lasse Collin 2011-01-12  386  /* Decode the Stream Header field (the first 12 bytes of the .xz Stream). */
24fa0402a9b6a53 Lasse Collin 2011-01-12  387  static enum xz_ret dec_stream_header(struct xz_dec *s)
24fa0402a9b6a53 Lasse Collin 2011-01-12  388  {
24fa0402a9b6a53 Lasse Collin 2011-01-12  389  	if (!memeq(s->temp.buf, HEADER_MAGIC, HEADER_MAGIC_SIZE))
24fa0402a9b6a53 Lasse Collin 2011-01-12  390  		return XZ_FORMAT_ERROR;
24fa0402a9b6a53 Lasse Collin 2011-01-12  391  
24fa0402a9b6a53 Lasse Collin 2011-01-12  392  	if (xz_crc32(s->temp.buf + HEADER_MAGIC_SIZE, 2, 0)
24fa0402a9b6a53 Lasse Collin 2011-01-12 @393  			!= get_le32(s->temp.buf + HEADER_MAGIC_SIZE + 2))
24fa0402a9b6a53 Lasse Collin 2011-01-12  394  		return XZ_DATA_ERROR;
24fa0402a9b6a53 Lasse Collin 2011-01-12  395  
24fa0402a9b6a53 Lasse Collin 2011-01-12  396  	if (s->temp.buf[HEADER_MAGIC_SIZE] != 0)
24fa0402a9b6a53 Lasse Collin 2011-01-12  397  		return XZ_OPTIONS_ERROR;
24fa0402a9b6a53 Lasse Collin 2011-01-12  398  
24fa0402a9b6a53 Lasse Collin 2011-01-12  399  	/*
24fa0402a9b6a53 Lasse Collin 2011-01-12  400  	 * Of integrity checks, we support only none (Check ID = 0) and
24fa0402a9b6a53 Lasse Collin 2011-01-12  401  	 * CRC32 (Check ID = 1). However, if XZ_DEC_ANY_CHECK is defined,
24fa0402a9b6a53 Lasse Collin 2011-01-12  402  	 * we will accept other check types too, but then the check won't
24fa0402a9b6a53 Lasse Collin 2011-01-12  403  	 * be verified and a warning (XZ_UNSUPPORTED_CHECK) will be given.
24fa0402a9b6a53 Lasse Collin 2011-01-12  404  	 */
24fa0402a9b6a53 Lasse Collin 2011-01-12  405  	s->check_type = s->temp.buf[HEADER_MAGIC_SIZE + 1];
24fa0402a9b6a53 Lasse Collin 2011-01-12  406  

:::::: The code at line 393 was first introduced by commit
:::::: 24fa0402a9b6a537e87e38341e78b7da86486846 decompressors: add XZ decompressor module

:::::: TO: Lasse Collin <lasse.collin@tukaani.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
