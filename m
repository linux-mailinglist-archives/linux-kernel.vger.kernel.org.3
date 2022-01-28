Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1414A0284
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 22:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351329AbiA1VEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 16:04:23 -0500
Received: from mga06.intel.com ([134.134.136.31]:32648 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344412AbiA1VEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 16:04:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643403846; x=1674939846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CsbBeYktg2WNwHPoxMz+XO9nL0GGkj0XgJqtxuN+gCY=;
  b=BgUK49LWXRrr1fxXubLJi5fcx7q2UEBtn+sIpGP1GN5QuhKJijhwpbN2
   QIqEx/S9GZyJhI04xH4GHo0GIBmaurO6bntMOc4t1RL4gDFUXxAm3Z1u5
   KReBzgLezcKhFy1IEexbMu/nULGx65e8VqHJD9bWnwl80JN0OPXaNTkLr
   jqo+opVz3gCF/2HI49Xj19/9F4XMOUB4egP5Kvhfs+QYprKOq6TY81+3w
   E15Rcse7yqKPF1BwRtrIqK8b/tpJa3KinYQrJzRfVta1/rS5+X3aCVRqa
   egYAxG1U1iIg6Jbeg4Gpoo/cvVODcmVSFle9XaIetZBTuuUkNd5tnfnE8
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="307926879"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="307926879"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 13:04:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="536288881"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 28 Jan 2022 13:04:02 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDYPa-000OJs-6H; Fri, 28 Jan 2022 21:04:02 +0000
Date:   Sat, 29 Jan 2022 05:03:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Changbin Du <changbin.du@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     kbuild-all@lists.01.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH] riscv: fix oops caused by irq on/off tracer
Message-ID: <202201290448.aKF0qISQ-lkp@intel.com>
References: <20220128152939.99544-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128152939.99544-1-changbin.du@gmail.com>
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

url:    https://github.com/0day-ci/linux/commits/Changbin-Du/riscv-fix-oops-caused-by-irq-on-off-tracer/20220128-233136
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 145d9b498fc827b79c1260b4caa29a8e59d4c2b9
config: riscv-buildonly-randconfig-r003-20220127 (https://download.01.org/0day-ci/archive/20220129/202201290448.aKF0qISQ-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/d3adbc803a5b4d49e649489eec980048266e2a72
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Changbin-Du/riscv-fix-oops-caused-by-irq-on-off-tracer/20220128-233136
        git checkout d3adbc803a5b4d49e649489eec980048266e2a72
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/riscv/kernel/trace_irq.c:14:6: warning: no previous prototype for '__trace_hardirqs_on' [-Wmissing-prototypes]
      14 | void __trace_hardirqs_on(void)
         |      ^~~~~~~~~~~~~~~~~~~
>> arch/riscv/kernel/trace_irq.c:20:6: warning: no previous prototype for '__trace_hardirqs_off' [-Wmissing-prototypes]
      20 | void __trace_hardirqs_off(void)
         |      ^~~~~~~~~~~~~~~~~~~~
--
>> arch/riscv/kernel/trace_irq.c:10: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * trace_hardirqs_on/off requires at least two parent call frames. Here we add


vim +/__trace_hardirqs_on +14 arch/riscv/kernel/trace_irq.c

     8	
     9	/**
  > 10	 * trace_hardirqs_on/off requires at least two parent call frames. Here we add
    11	 * one extra level so they can be safely called by low level entry code.
    12	 */
    13	
  > 14	void __trace_hardirqs_on(void)
    15	{
    16		trace_hardirqs_on();
    17	}
    18	NOKPROBE_SYMBOL(__trace_hardirqs_on);
    19	
  > 20	void __trace_hardirqs_off(void)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
