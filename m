Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C374464B83
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 11:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348612AbhLAKZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 05:25:45 -0500
Received: from mga09.intel.com ([134.134.136.24]:51096 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232177AbhLAKZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 05:25:44 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="236250208"
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="236250208"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 02:22:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="500191766"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 01 Dec 2021 02:22:22 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1msMkn-000EkF-BS; Wed, 01 Dec 2021 10:22:21 +0000
Date:   Wed, 1 Dec 2021 18:21:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [intel-tdx:guest-upstream 21/28] arch/x86/kernel/tdx.c:102:7:
 warning: this statement may fall through
Message-ID: <202112011845.7xW5IRjl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-upstream
head:   e6dbebc1d0c8a4a2449cd0800c025fb25078a6ac
commit: 466e3f43adbeeab45d4e4213a078c823edf35fc8 [21/28] x86/tdx: Add helper to convert memory between shared and private
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20211201/202112011845.7xW5IRjl-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/466e3f43adbeeab45d4e4213a078c823edf35fc8
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-upstream
        git checkout 466e3f43adbeeab45d4e4213a078c823edf35fc8
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/x86/kernel/tdx.c:296:8: error: return type defaults to 'int' [-Werror=return-type]
     296 | static tdx_mmio_write(int size, unsigned long addr, unsigned long *val)
         |        ^~~~~~~~~~~~~~
   arch/x86/kernel/tdx.c: In function 'tdx_accept_page':
>> arch/x86/kernel/tdx.c:102:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
     102 |   gpa |= 1;
         |   ~~~~^~~~
   arch/x86/kernel/tdx.c:103:2: note: here
     103 |  case PG_LEVEL_1G:
         |  ^~~~
   arch/x86/kernel/tdx.c:104:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
     104 |   gpa |= 2;
         |   ~~~~^~~~
   arch/x86/kernel/tdx.c:105:2: note: here
     105 |  default:
         |  ^~~~~~~
   cc1: some warnings being treated as errors


vim +102 arch/x86/kernel/tdx.c

    89	
    90	static bool tdx_accept_page(phys_addr_t gpa, enum pg_level pg_level)
    91	{
    92		/*
    93		 * Pass the page physical address to the TDX module to accept the
    94		 * pending, private page.
    95		 *
    96		 * Bits 2:0 if GPA encodes page size: 0 - 4K, 1 - 2M.
    97		 */
    98		switch (pg_level) {
    99		case PG_LEVEL_4K:
   100			break;
   101		case PG_LEVEL_2M:
 > 102			gpa |= 1;
   103		case PG_LEVEL_1G:
   104			gpa |= 2;
   105		default:
   106			return true;
   107		}
   108	
   109		return __tdx_module_call(TDX_ACCEPT_PAGE, gpa, 0, 0, 0, NULL);
   110	}
   111	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
