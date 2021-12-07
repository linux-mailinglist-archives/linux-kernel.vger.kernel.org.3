Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE92E46C6EC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbhLGVvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:51:48 -0500
Received: from mga04.intel.com ([192.55.52.120]:35747 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230374AbhLGVvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:51:47 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="236431509"
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="236431509"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 13:48:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="502769803"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 07 Dec 2021 13:48:15 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muiJq-000N0I-Cm; Tue, 07 Dec 2021 21:48:14 +0000
Date:   Wed, 8 Dec 2021 05:47:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [intel-tdx:guest 104/144] arch/x86/kernel/tdx.c:491:14: warning: no
 previous prototype for 'tdx_write_msr'
Message-ID: <202112080508.FqEbBAvi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest
head:   41fe88a1b3c28543f49fa6ed9e0e9b6650ed7614
commit: 112748701181f3a7ab49d21bcf7920b983b05af2 [104/144] x86/tdx: Use direct paravirt call for wrmsrl
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20211208/202112080508.FqEbBAvi-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/112748701181f3a7ab49d21bcf7920b983b05af2
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest
        git checkout 112748701181f3a7ab49d21bcf7920b983b05af2
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/x86/kernel/tdx.c:268:5: warning: no previous prototype for 'tdx_hcall_set_notify_intr' [-Wmissing-prototypes]
     268 | int tdx_hcall_set_notify_intr(u8 vector)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/x86/kernel/tdx.c:491:14: warning: no previous prototype for 'tdx_write_msr' [-Wmissing-prototypes]
     491 | void notrace tdx_write_msr(unsigned int msr, u32 low, u32 high)
         |              ^~~~~~~~~~~~~


vim +/tdx_write_msr +491 arch/x86/kernel/tdx.c

   490	
 > 491	void notrace tdx_write_msr(unsigned int msr, u32 low, u32 high)
   492	{
   493		if (tdx_fast_tdcall_path_msr(msr))
   494			tdx_write_msr_safe(msr, low, high);
   495		else
   496			native_write_msr(msr, low, high);
   497	}
   498	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
