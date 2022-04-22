Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808C650C509
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiDVXS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 19:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbiDVXRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 19:17:38 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272B3133E60
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 15:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650667943; x=1682203943;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3ZvQFbp4k30eVgkzTG7NKho9OkhYNJu6NRiznVhTZe4=;
  b=GAb2pIBuhaD9jcMairry+sfJ3yN899lUdO/oiTi0p0RK4AEceYzGnfra
   zctlX6kEmEgK+fm6a6HBMynxpJuvfvvaWeZjZwdpb/HK0lms2DNaqn38P
   w8iWWidV3faCxDpfKZ/9R9vaM6ZWm7IJa3R+/gv/oA9ilx3xwt2DKukZJ
   9TzjiH2RM67GE07Y/Ubsc0rWbgLfyuvGYX+UuSG5oC0L53TyqIo9KnhYh
   9sIY6/VEv7ZKKVj4AeU5AeHuyI1TRrIZPOP2xi0j9UGZwy2Uy7MLyKer0
   R0vuDt9oSPR8yTZ9i93ym55qS9jfaDdFx3a5mTx8tO07L0cHwzF9Pq81B
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264583197"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="264583197"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 15:52:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="594345364"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 22 Apr 2022 15:52:21 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ni28S-000Adi-Oy;
        Fri, 22 Apr 2022 22:52:20 +0000
Date:   Sat, 23 Apr 2022 06:51:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [intel-tdx:kvm-upstream-workaround 190/293]
 arch/x86/virt/vmx/tdx/tdx_debug.c:38:6: warning: variable 'ret' is used
 uninitialized whenever 'if' condition is false
Message-ID: <202204230602.MCSINBa4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   d32e9a403c5c4f16dc577cbe92148e5b80f79d59
commit: eed43994431837da508aed7b50717777818c1837 [190/293] [REVERTME] debugfs to operation on TDX debug op
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20220423/202204230602.MCSINBa4-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5bd87350a5ae429baf8f373cb226a57b62f87280)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/eed43994431837da508aed7b50717777818c1837
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout eed43994431837da508aed7b50717777818c1837
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/virt/vmx/tdx/tdx_debug.c:38:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (debugconfig_supported) {
               ^~~~~~~~~~~~~~~~~~~~~
   arch/x86/virt/vmx/tdx/tdx_debug.c:46:10: note: uninitialized use occurs here
           return  ret;
                   ^~~
   arch/x86/virt/vmx/tdx/tdx_debug.c:38:2: note: remove the 'if' if its condition is always true
           if (debugconfig_supported) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/virt/vmx/tdx/tdx_debug.c:36:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   1 warning generated.


vim +38 arch/x86/virt/vmx/tdx/tdx_debug.c

    32	
    33	static inline u64 tddebugconfig(u64 subleaf, u64 param1, u64 param2)
    34	{
    35		static bool debugconfig_supported = true;
    36		int ret;
    37	
  > 38		if (debugconfig_supported) {
    39			ret = __seamcall(SEAMCALL_TDDEBUGCONFIG, subleaf, param1, param2, 0, NULL);
    40			if (ret) {
    41				pr_info("DEBUGCONFIG SEAMCALL isn't supported.\n");
    42				debugconfig_supported = false;
    43			}
    44		}
    45	
    46		return  ret;
    47	}
    48	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
