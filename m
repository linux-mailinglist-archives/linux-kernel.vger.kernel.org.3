Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875784A301C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 15:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347253AbiA2OuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 09:50:22 -0500
Received: from mga05.intel.com ([192.55.52.43]:9694 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345805AbiA2OuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 09:50:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643467820; x=1675003820;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bjiZDoSBaAf95B5bl6IeYq0Ba8sBJ6C/t5gxFd5KaM0=;
  b=dVlJVvp0+TpSienCuF2o36SU/dOpt1GOmIVBfk0vZRQpL3WR6uv/v6g+
   /p8e7kcY9NUsSAZXBLpeUc3SY55vR5lHzDkRV23GIPSRKz49/lRqixs/1
   thfKDYtzAjC27bR/bIwJu6pRF2keHItR93U/kF1yg9+W7Tlms0XPwWMKl
   ruE8LLMd1UP+9ABT0mcwnDo25aV2kczyZTVDu2Y5zN/kMw/vzOG3ij2y6
   w6j7VhVZ4g/F1MOOgpwO+8TYTNkpakJZVEgE0/knqNnlYXNMLFdG9ZmYe
   kCOX64Usq4v3K/m4OCd5hrW3iEnUahNgzEF92KxS/Vql8ZLrQnpMO3de5
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="333630160"
X-IronPort-AV: E=Sophos;i="5.88,326,1635231600"; 
   d="scan'208";a="333630160"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2022 06:50:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,326,1635231600"; 
   d="scan'208";a="582161957"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 29 Jan 2022 06:50:17 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDp3Q-000PKB-Qx; Sat, 29 Jan 2022 14:50:16 +0000
Date:   Sat, 29 Jan 2022 22:49:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Changbin Du <changbin.du@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH v2] riscv: fix oops caused by irq on/off tracer
Message-ID: <202201292238.F1q5U57j-lkp@intel.com>
References: <20220129004226.32868-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129004226.32868-1-changbin.du@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Changbin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.17-rc1 next-20220128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Changbin-Du/riscv-fix-oops-caused-by-irq-on-off-tracer/20220129-084342
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 169387e2aa291a4e3cb856053730fe99d6cec06f
config: riscv-randconfig-c006-20220125 (https://download.01.org/0day-ci/archive/20220129/202201292238.F1q5U57j-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 33b45ee44b1f32ffdbc995e6fec806271b4b3ba4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/0day-ci/linux/commit/389bbb8268ab6ab20c8a76808dfe52997577a06b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Changbin-Du/riscv-fix-oops-caused-by-irq-on-off-tracer/20220129-084342
        git checkout 389bbb8268ab6ab20c8a76808dfe52997577a06b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/riscv/kernel/trace_irq.c:11: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * trace_hardirqs_on/off requires at least two parent call frames.


vim +11 arch/riscv/kernel/trace_irq.c

     9	
    10	/**
  > 11	 * trace_hardirqs_on/off requires at least two parent call frames.
    12	 * Here we add one extra level so they can be safely called by low
    13	 * level entry code.
    14	 */
    15	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
