Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1437D4673BD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 10:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379480AbhLCJQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 04:16:47 -0500
Received: from mga03.intel.com ([134.134.136.65]:55792 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351182AbhLCJQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 04:16:29 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="236880928"
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="236880928"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 01:13:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="513199598"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 03 Dec 2021 01:13:02 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mt4co-000HJn-01; Fri, 03 Dec 2021 09:13:02 +0000
Date:   Fri, 3 Dec 2021 17:12:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     sgoutham@marvell.com, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, sunil.kovvuri@gmail.com,
        Sunil Goutham <sgoutham@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Joseph Longever <jlongever@marvell.com>
Subject: Re: [PATCH] hwrng: cn10k: Add random number generator support
Message-ID: <202112031752.wdInk91s-lkp@intel.com>
References: <1638208423-21494-1-git-send-email-sgoutham@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638208423-21494-1-git-send-email-sgoutham@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I love your patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on herbert-cryptodev-2.6/master linux/master linus/master v5.16-rc3 next-20211202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/sgoutham-marvell-com/hwrng-cn10k-Add-random-number-generator-support/20211130-015707
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 5d331b5922551637c586cdf5fdc1778910fc937f
config: arm64-randconfig-s031-20211203 (https://download.01.org/0day-ci/archive/20211203/202112031752.wdInk91s-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/395a6a89774841f3f1c9d994b7d8cdfaf25bc428
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review sgoutham-marvell-com/hwrng-cn10k-Add-random-number-generator-support/20211130-015707
        git checkout 395a6a89774841f3f1c9d994b7d8cdfaf25bc428
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/char/hw_random/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/char/hw_random/cn10k-rng.c:88:17: sparse: sparse: cast removes address space '__iomem' of expression

vim +/__iomem +88 drivers/char/hw_random/cn10k-rng.c

    82	
    83	static int cn10k_read_trng(struct cn10k_rng *rng, u64 *value)
    84	{
    85		u64 addr, result = 0;
    86		int retry_count = 5;
    87	
  > 88		addr = (u64)rng->reg_base + RNM_PF_RANDOM;
    89		/* TRNG and status need to be read at a time */
    90		while (!result && retry_count) {
    91			__asm__ volatile("ldp  %0,%1,[%2]" :\
    92					 "=r" (*value), "=r" (result) : "r" (addr) : );
    93	
    94			retry_count--;
    95		}
    96	
    97		return retry_count ? 0 : -EIO;
    98	}
    99	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
