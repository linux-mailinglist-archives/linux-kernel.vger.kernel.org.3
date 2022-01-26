Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC7B49D216
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244308AbiAZSyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:54:46 -0500
Received: from mga12.intel.com ([192.55.52.136]:46710 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244301AbiAZSyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:54:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643223285; x=1674759285;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1p0cblke1yExFuE7116c1ku2DF+OVoMFfwOVJEjFF1M=;
  b=Gc183lltCn5Fpq3exV2Jnf3WSnKnoFdSDx8Uf5D+ghEQqtAPKHKHgqY2
   g3j81Ykuf8vPYdc43JwKI93qi8fC7kqxddEZwwHL6L/ElmgsxBfm8XLW4
   pXKudVM9kd0EnsRP8HxQJgRrapSQRHO9y27qOrw0C81ifzMvh8UGuW/8f
   FOhvuwtDSCPz2MibUPImcTPD3GPt6m0thnDY6vkIgftGp2W8/jUUN+5nf
   rBwvHuE+n26Wfx+JNE6Ia8u4GbotGAfwfg0P4GHXq7f8qAkr1j60Wx2mM
   9ezPa9NvyY3YMtvGVjD1gEWHBmXS/BSE6cT54xuDJd9im+1qysLlRwTK1
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="226600323"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="226600323"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 10:53:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="628397799"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 Jan 2022 10:53:10 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCnPp-000LWg-NG; Wed, 26 Jan 2022 18:53:09 +0000
Date:   Thu, 27 Jan 2022 02:52:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [intel-tdx:host-upstream 7/18] arch/x86/kernel/cpu/tdx/tdx.c:148:30:
 warning: variable 'err' is uninitialized when used within its own
 initialization
Message-ID: <202201270252.bK9LlDe7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git host-upstream
head:   6806a9874cdac7e51e15c056986098bf94a062aa
commit: b9feae73d1b45e81a7d573531ee2e594ccea51b5 [7/18] x86/cpu: Do logical cpu level TDX module initialization
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20220127/202201270252.bK9LlDe7-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 2a1b7aa016c0f4b5598806205bdfbab1ea2d92c4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/b9feae73d1b45e81a7d573531ee2e594ccea51b5
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx host-upstream
        git checkout b9feae73d1b45e81a7d573531ee2e594ccea51b5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/cpu/tdx/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/cpu/tdx/tdx.c:148:30: warning: variable 'err' is uninitialized when used within its own initialization [-Wuninitialized]
           atomic_t *err = (atomic_t *)err;
                     ~~~               ^~~
   1 warning generated.


vim +/err +148 arch/x86/kernel/cpu/tdx/tdx.c

   144	
   145	/* SMP call function to run TDH.SYS.LP.INIT */
   146	static void smp_call_tdx_cpu_init(void *data)
   147	{
 > 148		atomic_t *err = (atomic_t *)err;
   149	
   150		if (tdh_sys_lp_init())
   151			atomic_set(err, -1);
   152	}
   153	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
