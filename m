Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F10559A981
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 01:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240381AbiHSXc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 19:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiHSXcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 19:32:20 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DA91141BC
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660951939; x=1692487939;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cK2y3zq/UHNXdhzrLcmcGxw12nkzYqryneLPcAANBU0=;
  b=SWY/WTuS4Gmik8NLxwCwnvrcXHJgD2b2LHdKmu12N+WQGytlLQRiGBs3
   ocOCI2OvooQz7Ol55poUL5IlkQci3DLuS/03eh1RPOWhGFGJx3AyHhz6G
   lRpnhS+XhpIHDjO2juoicD5d2wwRrJcotczNXQCJ3VYNQWGnl4ahgn3Hp
   cfyAGLA0XN4W4DuEPh2qeC3jahUPmPYMSo/BFBgot+sHphqZYukLdD/Z6
   XdkN4QvF9ob/RATjP+UFxQBbdrCAD4rESLHz/t/r/SsaIPgycY0pTloCN
   RC6oQKZB4H09mATpOr8O3yCLxwu0gOCb9Be63q12/7NyOHWQn6wfLQ78y
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10444"; a="291872467"
X-IronPort-AV: E=Sophos;i="5.93,249,1654585200"; 
   d="scan'208";a="291872467"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 16:32:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,249,1654585200"; 
   d="scan'208";a="559110741"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 19 Aug 2022 16:32:16 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPBTL-0001v5-13;
        Fri, 19 Aug 2022 23:32:15 +0000
Date:   Sat, 20 Aug 2022 07:32:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [intel-tdx:guest-hardening-rebased 11/36]
 arch/x86/coco/tdx/tdx.c:298:14: warning: no previous prototype for
 'tdx_write_msr'
Message-ID: <202208200701.4mWLrcXi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/x86/coco/tdx/tdx.c
tree:   https://github.com/intel/tdx.git guest-hardening-rebased
head:   d941f409a509c084250b50a3b5fc1c3c84a596a0
commit: a9189da9f0413f85d9072894ccb973cf785d2c0d [11/36] x86/tdx: Use direct paravirt call for wrmsrl
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220820/202208200701.4mWLrcXi-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/a9189da9f0413f85d9072894ccb973cf785d2c0d
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-hardening-rebased
        git checkout a9189da9f0413f85d9072894ccb973cf785d2c0d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/coco/tdx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/coco/tdx/tdx.c:298:14: warning: no previous prototype for 'tdx_write_msr' [-Wmissing-prototypes]
     298 | void notrace tdx_write_msr(unsigned int msr, u32 low, u32 high)
         |              ^~~~~~~~~~~~~


vim +/tdx_write_msr +298 arch/x86/coco/tdx/tdx.c

   297	
 > 298	void notrace tdx_write_msr(unsigned int msr, u32 low, u32 high)
   299	{
   300		struct tdx_hypercall_args args = {
   301			.r10 = TDX_HYPERCALL_STANDARD,
   302			.r11 = hcall_func(EXIT_REASON_MSR_WRITE),
   303			.r12 = msr,
   304			.r13 = (u64)high << 32 | low,
   305		};
   306	
   307		if (tdx_fast_tdcall_path_msr(msr))
   308			__tdx_hypercall(&args, 0);
   309		else
   310			native_write_msr(msr, low, high);
   311	}
   312	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
