Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1AB519552
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 04:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245227AbiEDCHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 22:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243167AbiEDCHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 22:07:09 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A203FDC5
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 19:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651629815; x=1683165815;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SaDiayL72AA9TGo8je0ypoIe2eI0QEYm3nLs7LcNJss=;
  b=UTJdB494wPqEEHuoyAa5y1MFy1vYgotkRYhvJWBdmowIaArj2uavyDJ0
   3S2H/tNb5fDXdt9MTG9aDqIMHd/CjbbjCnatZbxSooAwTKMNLh6xdVdpf
   gLPQTwWhvTeGLkAwGbzDEMUlRQ/inN2aUhKfaXHj6Ing8B25cCGWSl7og
   0Kw55hTuamkiIVSF5xVmSbrfPd6ZqX0TQbSoj9IClV1ZSrQHa6CYqFJ5z
   HBRd5nR1jmDTXEQfMZEbPNlPAAG1SmN/iI2x5SjrAv2gSQJ7w26vFniPX
   aIhhf9uD0wuXDg2FzhRclf3WuqWV27wppKAGnQY9OI2wccVXqd26YwQZZ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="330626272"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="330626272"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 19:03:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="692969961"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 03 May 2022 19:03:34 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nm4MX-000Axn-Fr;
        Wed, 04 May 2022 02:03:33 +0000
Date:   Wed, 4 May 2022 10:02:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [norov:gup 45/48] lib/bitmap.c:1570:17: error: initializing
 'unsigned long *' with an expression of type 'const unsigned long *'
 discards qualifiers
Message-ID: <202205041022.rYfACmSF-lkp@intel.com>
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

Hi Yury,

FYI, the error/warning still remains.

tree:   https://github.com/norov/linux gup
head:   c96226d23c745b114dc041e0d8d0c272b280c71a
commit: f1cbd19c47bf73d532ff30571601c7ede57d5f82 [45/48] lib: add bitmap_{from,to}_arr64
config: mips-randconfig-r015-20220501 (https://download.01.org/0day-ci/archive/20220504/202205041022.rYfACmSF-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 363b3a645a1e30011cc8da624f13dac5fd915628)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/norov/linux/commit/f1cbd19c47bf73d532ff30571601c7ede57d5f82
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov gup
        git checkout f1cbd19c47bf73d532ff30571601c7ede57d5f82
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> lib/bitmap.c:1570:17: error: initializing 'unsigned long *' with an expression of type 'const unsigned long *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           unsigned long *end = bitmap + BITS_TO_LONGS(nbits);
                          ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/bitmap.c:1575:22: warning: shift count >= width of type [-Wshift-count-overflow]
                           *buf |= *bitmap++ << 32;
                                             ^  ~~
   1 warning and 1 error generated.


vim +1570 lib/bitmap.c

  1561	
  1562	/**
  1563	 * bitmap_to_arr64 - copy the contents of bitmap to a u64 array of bits
  1564	 *	@buf: array of u64 (in host byte order), the dest bitmap
  1565	 *	@bitmap: array of unsigned longs, the source bitmap
  1566	 *	@nbits: number of bits in @bitmap
  1567	 */
  1568	void bitmap_to_arr64(u64 *buf, const unsigned long *bitmap, unsigned int nbits)
  1569	{
> 1570		unsigned long *end = bitmap + BITS_TO_LONGS(nbits);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
