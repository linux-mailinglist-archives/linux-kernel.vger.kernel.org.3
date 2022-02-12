Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DF24B3344
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 06:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbiBLFqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 00:46:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbiBLFqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 00:46:30 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A2B28E29
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 21:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644644788; x=1676180788;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AQ9szTLzH8p4ZzKApvUor4Tkzkm+eqoA6a52bjEco+k=;
  b=QzEXp/+F5+sWcokuzkQJw1YIdOYAcXW5d2gl7tHiB4vzKQCXKp7BquQA
   3kUGQB/Akiq/HWotZEmmjtpJLqZcq4pXCwESnSgvrZmtV1uTqXQzByFgU
   fyRtyspIWLeoF08mtnWyAZth0mYcoPI4S6DVbM0k/TcLWw8+dSx/OcxNK
   L2CqH7yfvc69jTZUjfdYUgKZWNkiMLphsmr8Ikcm5mnYMKa+bv11i+0HA
   O81y/uYXnakCkaC6bmR7LdWoiB3/RcOTZCO6+TSlsQNbhR1euAuwWPcG2
   3RMGZa4pe8i9s/wpBZM/icF+aGg0CvxRkH5A1ziLg51WZ2u4jyPY+Kc1H
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="274418064"
X-IronPort-AV: E=Sophos;i="5.88,363,1635231600"; 
   d="scan'208";a="274418064"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 21:46:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,363,1635231600"; 
   d="scan'208";a="774444145"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 11 Feb 2022 21:46:26 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIlEo-0005hP-1U; Sat, 12 Feb 2022 05:46:26 +0000
Date:   Sat, 12 Feb 2022 13:45:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [intel-tdx:kvm-upstream-workaround 7/145]
 arch/x86/kernel/cpu/tdx/tdx.c:148:30: warning: variable 'err' is
 uninitialized when used within its own initialization
Message-ID: <202202121324.DClhLKTq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   f40698d38196025a38e79a2bdf22058de944b38a
commit: 474e0c5f940be499b7c8996ba8e64c31f56d21fe [7/145] x86/cpu: Do logical cpu level TDX module initialization
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220212/202202121324.DClhLKTq-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c7eb84634519e6497be42f5fe323f9a04ed67127)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/474e0c5f940be499b7c8996ba8e64c31f56d21fe
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout 474e0c5f940be499b7c8996ba8e64c31f56d21fe
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/cpu/tdx/ drivers/gpu/drm/i915/

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
