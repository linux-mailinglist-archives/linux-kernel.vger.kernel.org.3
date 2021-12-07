Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D94146C547
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 21:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbhLGVBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:01:08 -0500
Received: from mga07.intel.com ([134.134.136.100]:54588 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236269AbhLGVAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:00:55 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="301068578"
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="301068578"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 12:57:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="542950075"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 07 Dec 2021 12:57:14 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muhWT-000Mxu-E2; Tue, 07 Dec 2021 20:57:13 +0000
Date:   Wed, 8 Dec 2021 04:56:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [intel-tdx:guest 54/144] arch/x86/kernel/tdx.c:225:5: warning: no
 previous prototype for 'tdx_hcall_set_notify_intr'
Message-ID: <202112080412.ewbt4zCb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest
head:   41fe88a1b3c28543f49fa6ed9e0e9b6650ed7614
commit: 7315ae7f753386e793da1941e073c4cb1112e767 [54/144] x86/tdx: Add SetupEventNotifyInterrupt TDX hypercall support
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20211208/202112080412.ewbt4zCb-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/7315ae7f753386e793da1941e073c4cb1112e767
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest
        git checkout 7315ae7f753386e793da1941e073c4cb1112e767
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/tdx.c:225:5: warning: no previous prototype for 'tdx_hcall_set_notify_intr' [-Wmissing-prototypes]
     225 | int tdx_hcall_set_notify_intr(u8 vector)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/tdx_hcall_set_notify_intr +225 arch/x86/kernel/tdx.c

   217	
   218	/*
   219	 * tdx_hcall_set_notify_intr() - Setup Event Notify Interrupt Vector.
   220	 *
   221	 * @vector        : Vector address to be used for notification.
   222	 *
   223	 * return 0 on success or failure error number.
   224	 */
 > 225	int tdx_hcall_set_notify_intr(u8 vector)
   226	{
   227		u64 ret;
   228	
   229		/* Minimum vector value allowed is 32 */
   230		if (vector < 32)
   231			return -EINVAL;
   232	
   233		/*
   234		 * Register callback vector address with VMM. More details
   235		 * about the ABI can be found in TDX Guest-Host-Communication
   236		 * Interface (GHCI), sec 3.5.
   237		 */
   238		ret = _trace_tdx_hypercall(TDVMCALL_SETUP_NOTIFY_INTR, vector, 0, 0, 0,
   239					   NULL);
   240	
   241		if (ret == TDVMCALL_SUCCESS)
   242			return 0;
   243		else if (ret == TDCALL_INVALID_OPERAND)
   244			return -EINVAL;
   245	
   246		return -EIO;
   247	}
   248	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
