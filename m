Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1840C48F7DE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 17:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbiAOQeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 11:34:14 -0500
Received: from mga09.intel.com ([134.134.136.24]:36160 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232133AbiAOQeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 11:34:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642264453; x=1673800453;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+RjfgmZoxVoA5vZPO0+FEWhMbYY7Ksoi9Z1oLey9S8c=;
  b=Qu3iBUa3mCDmLPJxJI2yhyOVh89usQ4Mg2vUDC39wqNJ7qZCwrYyCY2X
   hxMrZgRdxlxt3dWh9EidT3xusa/e2he/CScMtpn3Vd+S7HDOgGNpLgMeS
   rZoNK8JL4hRiYMlmmYFTLpt0abgXwBdMvkGFj3g2C4lP5tseoloVu7V2L
   jTR7H401/oDPn4olyOLomehl2K/RX8yXrlhGCtja9avM5Z+STirf/m+HS
   9ZR6DL2sh+xbGu8j2JrUrFqyxBZReAml442Q68cmISjZVmjgpzUXSXsTM
   sYsgPjwqhjEwwXqKcVLUz2Fc9Wl02nBVtt/wrtiiRCo8fadKlZdAo2F0T
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="244219989"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="244219989"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2022 08:34:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="671162003"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jan 2022 08:34:09 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8m0G-000A4X-OM; Sat, 15 Jan 2022 16:34:08 +0000
Date:   Sun, 16 Jan 2022 00:33:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     kbuild-all@lists.01.org, gregkh <gregkh@linuxfoundation.org>,
        quic_psodagud@quicinc.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCHv7 5/5] asm-generic/io: Add logging support for MMIO
 accessors
Message-ID: <202201160019.hrsMYj6V-lkp@intel.com>
References: <8085e36ca19787ae111e4cfbb5c555e65bd34be6.1642233364.git.quic_saipraka@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8085e36ca19787ae111e4cfbb5c555e65bd34be6.1642233364.git.quic_saipraka@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sai,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20220115]
[cannot apply to arm64/for-next/core arnd-asm-generic/master arm-perf/for-next/perf linus/master v5.16 v5.16-rc8 v5.16-rc7 v5.16]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Sai-Prakash-Ranjan/lib-rwmmio-arm64-Add-support-to-trace-register-reads-writes/20220115-211708
base:    bd8d9cef2a7932e688ca267ea1adf5ea6557c777
config: nios2-defconfig (https://download.01.org/0day-ci/archive/20220116/202201160019.hrsMYj6V-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/0757812bba83a756f73ce1a84c86ded3e276cd0f
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Sai-Prakash-Ranjan/lib-rwmmio-arm64-Add-support-to-trace-register-reads-writes/20220115-211708
        git checkout 0757812bba83a756f73ce1a84c86ded3e276cd0f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/nios2/include/asm/io.h:41,
                    from include/linux/io.h:13,
                    from arch/nios2/include/asm/pgtable.h:18,
                    from include/linux/pgtable.h:6,
                    from arch/nios2/kernel/nios2_ksyms.c:11:
   include/asm-generic/io.h: In function 'readb':
>> include/asm-generic/io.h:181:32: error: '_THIS_IP_' undeclared (first use in this function)
     181 |         log_read_mmio(8, addr, _THIS_IP_);
         |                                ^~~~~~~~~
   include/asm-generic/io.h:181:32: note: each undeclared identifier is reported only once for each function it appears in
   include/asm-generic/io.h: In function 'readw':
   include/asm-generic/io.h:196:33: error: '_THIS_IP_' undeclared (first use in this function)
     196 |         log_read_mmio(16, addr, _THIS_IP_);
         |                                 ^~~~~~~~~
   include/asm-generic/io.h: In function 'readl':
   include/asm-generic/io.h:211:33: error: '_THIS_IP_' undeclared (first use in this function)
     211 |         log_read_mmio(32, addr, _THIS_IP_);
         |                                 ^~~~~~~~~
   include/asm-generic/io.h: In function 'writeb':
   include/asm-generic/io.h:241:40: error: '_THIS_IP_' undeclared (first use in this function)
     241 |         log_write_mmio(value, 8, addr, _THIS_IP_);
         |                                        ^~~~~~~~~
   include/asm-generic/io.h: In function 'writew':
   include/asm-generic/io.h:253:41: error: '_THIS_IP_' undeclared (first use in this function)
     253 |         log_write_mmio(value, 16, addr, _THIS_IP_);
         |                                         ^~~~~~~~~
   include/asm-generic/io.h: In function 'writel':
   include/asm-generic/io.h:265:41: error: '_THIS_IP_' undeclared (first use in this function)
     265 |         log_write_mmio(value, 32, addr, _THIS_IP_);
         |                                         ^~~~~~~~~


vim +/_THIS_IP_ +181 include/asm-generic/io.h

   169	
   170	/*
   171	 * {read,write}{b,w,l,q}() access little endian memory and return result in
   172	 * native endianness.
   173	 */
   174	
   175	#ifndef readb
   176	#define readb readb
   177	static inline u8 readb(const volatile void __iomem *addr)
   178	{
   179		u8 val;
   180	
 > 181		log_read_mmio(8, addr, _THIS_IP_);
   182		__io_br();
   183		val = __raw_readb(addr);
   184		__io_ar(val);
   185		log_post_read_mmio(val, 8, addr, _THIS_IP_);
   186		return val;
   187	}
   188	#endif
   189	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
