Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1EE4A353F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 09:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354399AbiA3Iya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 03:54:30 -0500
Received: from mga14.intel.com ([192.55.52.115]:45922 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236235AbiA3Iy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 03:54:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643532868; x=1675068868;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GTk8Xu4/TXobac8GeUdeDgPsOSM15t/8NBKtcg6eQok=;
  b=Fxp6HiTSc5AAxxZpyvrY8bV44jFsQVkLyktiHVM/kNVyNrNz5fxs22cg
   G534XBdeAKT6U+jhp6Wu4zW+HMFyKxLX7gt2aSKDh2MjcEbY5+PrO33NX
   79zGzVOC5uNOhsJezUeewexwNO96dkk+0uDJ0B8CBKLp/DFNULsEdobkt
   ecaJZ7XNf4YY7GXMhhB6bvWxkMOcZ0hyRaBE8NbUTEyAVvR91z83ZVVTL
   j5P8mdveSIvbvVKX45OzOh5qJ3gMsMJ5xiqaSn08QjdNUtzUYHScg61mo
   CGab5KPPLy+sLXaEekE0zbL71FyjOkwhLv8+W6bxeBLg0G1fDRu3q97LY
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10242"; a="247549482"
X-IronPort-AV: E=Sophos;i="5.88,328,1635231600"; 
   d="scan'208";a="247549482"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 00:54:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,328,1635231600"; 
   d="scan'208";a="496555967"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 30 Jan 2022 00:54:26 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nE5yc-000QHS-5u; Sun, 30 Jan 2022 08:54:26 +0000
Date:   Sun, 30 Jan 2022 16:53:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: arch/powerpc/kernel/eeh_driver.c:43:17: sparse: sparse: cast from
 restricted pci_ers_result_t
Message-ID: <202201301501.QOFGw42Q-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f8c7e4ede46fe63ff10000669652648aab09d112
commit: 791f3465c4afde02d7f16cf7424ca87070b69396 io_uring: fix UAF due to missing POLLFREE handling
date:   2 weeks ago
config: powerpc64-randconfig-s032-20220130 (https://download.01.org/0day-ci/archive/20220130/202201301501.QOFGw42Q-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=791f3465c4afde02d7f16cf7424ca87070b69396
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 791f3465c4afde02d7f16cf7424ca87070b69396
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/powerpc/kernel/eeh_driver.c:43:17: sparse: sparse: cast from restricted pci_ers_result_t
   arch/powerpc/kernel/eeh_driver.c:64:17: sparse: sparse: cast from restricted pci_ers_result_t

vim +43 arch/powerpc/kernel/eeh_driver.c

67086e32b56481 Wei Yang    2016-03-04  26  
30424e386a30d1 Sam Bobroff 2018-05-25  27  static int eeh_result_priority(enum pci_ers_result result)
30424e386a30d1 Sam Bobroff 2018-05-25  28  {
30424e386a30d1 Sam Bobroff 2018-05-25  29  	switch (result) {
30424e386a30d1 Sam Bobroff 2018-05-25  30  	case PCI_ERS_RESULT_NONE:
30424e386a30d1 Sam Bobroff 2018-05-25  31  		return 1;
30424e386a30d1 Sam Bobroff 2018-05-25  32  	case PCI_ERS_RESULT_NO_AER_DRIVER:
30424e386a30d1 Sam Bobroff 2018-05-25  33  		return 2;
30424e386a30d1 Sam Bobroff 2018-05-25  34  	case PCI_ERS_RESULT_RECOVERED:
30424e386a30d1 Sam Bobroff 2018-05-25  35  		return 3;
30424e386a30d1 Sam Bobroff 2018-05-25  36  	case PCI_ERS_RESULT_CAN_RECOVER:
30424e386a30d1 Sam Bobroff 2018-05-25  37  		return 4;
30424e386a30d1 Sam Bobroff 2018-05-25  38  	case PCI_ERS_RESULT_DISCONNECT:
30424e386a30d1 Sam Bobroff 2018-05-25  39  		return 5;
30424e386a30d1 Sam Bobroff 2018-05-25  40  	case PCI_ERS_RESULT_NEED_RESET:
30424e386a30d1 Sam Bobroff 2018-05-25  41  		return 6;
30424e386a30d1 Sam Bobroff 2018-05-25  42  	default:
30424e386a30d1 Sam Bobroff 2018-05-25 @43  		WARN_ONCE(1, "Unknown pci_ers_result value: %d\n", (int)result);
30424e386a30d1 Sam Bobroff 2018-05-25  44  		return 0;
30424e386a30d1 Sam Bobroff 2018-05-25  45  	}
30424e386a30d1 Sam Bobroff 2018-05-25  46  };
30424e386a30d1 Sam Bobroff 2018-05-25  47  

:::::: The code at line 43 was first introduced by commit
:::::: 30424e386a30d1160a0fdf47beafe8b116d0a8f7 powerpc/eeh: Clean up pci_ers_result handling

:::::: TO: Sam Bobroff <sbobroff@linux.ibm.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
