Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7644E53F674
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 08:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237235AbiFGGo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 02:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237206AbiFGGox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 02:44:53 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7C17CDF5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 23:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654584288; x=1686120288;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9rkHTm7Ei8ImHRwiNFg80RLRPu9BYHXM2S+xFJHjJeQ=;
  b=dT4mPTRSWK/6g8Y89aUwVj9wExVOYUWEa3v/oDh2zEIzULm7T2DNz/z1
   5+Algq1Jz7Inj9zJArhg0caqa1aV8yddC2qgoNiQWvpDLCMNwWBMhvdSR
   Iv3wMMajEzp0T3Vwm605HYXdDpAMnkYDYSBRsNN74Xm9LKff0dZXTaUAF
   FMaf8DFG8ZYck6QMXD+In7miSMdvzH2Cp2+EVFbJmiX4lXT1ke33nXpAD
   yuajudhVZXBIGjCMwGsLRBEbNHvZS5sqdKzSbeO8GIcB9UnztgIAEGtXr
   EIz475/4wTUdoUAkg7axaPjn0gmVex4p3nvNtL5W/4xiomShadeInrBqW
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="363052549"
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="363052549"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 23:44:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="709362247"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 06 Jun 2022 23:44:45 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nySxI-000DR1-I4;
        Tue, 07 Jun 2022 06:44:44 +0000
Date:   Tue, 7 Jun 2022 14:44:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     kah.jing.lee@intel.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, dinguyen@kernel.org,
        tien.sung.ang@intel.com, Kah Jing Lee <kah.jing.lee@intel.com>,
        Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH 1/2] drivers: misc: intel_sysid: Add sysid from arch to
 drivers
Message-ID: <202206071402.jrrayqsc-lkp@intel.com>
References: <20220602122212.3021232-1-kah.jing.lee@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602122212.3021232-1-kah.jing.lee@intel.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on soc/for-next staging/staging-testing v5.19-rc1 next-20220607]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/kah-jing-lee-intel-com/New-driver-for-Intel-Altera-FPGA-System-ID-softIP/20220602-202553
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 90de6805267f8c79cd2b1a36805071e257c39b5c
config: s390-randconfig-r024-20220607 (https://download.01.org/0day-ci/archive/20220607/202206071402.jrrayqsc-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b92436efcb7813fc481b30f2593a4907568d917a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/bfd40e4202ce67e500bedec9eaaf9b7207f980d0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review kah-jing-lee-intel-com/New-driver-for-Intel-Altera-FPGA-System-ID-softIP/20220602-202553
        git checkout bfd40e4202ce67e500bedec9eaaf9b7207f980d0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/misc/intel_sysid.c:26:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from drivers/misc/intel_sysid.c:26:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from drivers/misc/intel_sysid.c:26:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:609:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:617:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:625:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> drivers/misc/intel_sysid.c:109:34: warning: unused variable 'intel_sysid_match' [-Wunused-const-variable]
   static const struct of_device_id intel_sysid_match[] = {
                                    ^
   13 warnings generated.


vim +/intel_sysid_match +109 drivers/misc/intel_sysid.c

   108	
 > 109	static const struct of_device_id intel_sysid_match[] = {
   110		{ .compatible = "intel,socfpga-sysid-1.0" },
   111		{ /* Sentinel */ }
   112	};
   113	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
