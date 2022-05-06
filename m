Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A0E51D267
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389623AbiEFHlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 03:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244672AbiEFHlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:41:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93D06213B
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 00:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651822646; x=1683358646;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=toIf4riM0fUf3p8/OWQt28q5FFGojcylLaM+ORZAoXw=;
  b=lk8fo/8zKw2WWa3n5a7AlxTb6dfQEu6r1kt7z8nj3f06UJGQgxE6IrMd
   Qi3Y5jBUYgnL5EkbyW6xyTBUANkSjNz4TYkStlMNWVapXdqVO1g1Tw6cN
   a7NTV8unrKzviRUGF/OmAUBx3AYKg9vjYm+EcKvV4SLR1lI4CKkVuUkY6
   IWJTOzuCrTebWInswgAE5W1i3605v8dnqtoGHBRJZ3KbnGehEr567eMWR
   aq7ejU4jcOsZBoaAq4IQ8JAHNLUVvBT5vxoMbkV3JaJPQ9ySdgzciXYSe
   ZiZFCVpvNBoFCFXM9bOxam92J1XcoYPG80qklTCXgRj9BY+NTan4A+6lD
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="250378903"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="250378903"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 00:37:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="695045803"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 06 May 2022 00:37:25 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmsWi-000DFw-L5;
        Fri, 06 May 2022 07:37:24 +0000
Date:   Fri, 6 May 2022 15:36:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [intel-tdx:kvm-upstream-workaround 292/361]
 arch/x86/virt/vmx/tdx/tdx_debug.c:38:6: warning: variable 'ret' is used
 uninitialized whenever 'if' condition is false
Message-ID: <202205061552.nQdkBaVb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   3b5b338cdf10dca7a2435d1f86b2dd9f1a3ad833
commit: 35b7a73dd22642a50aa614a812f76289a59d1509 [292/361] [REVERTME] debugfs to operation on TDX debug op
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220506/202205061552.nQdkBaVb-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e004fb787698440a387750db7f8028e7cb14cfc)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/35b7a73dd22642a50aa614a812f76289a59d1509
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout 35b7a73dd22642a50aa614a812f76289a59d1509
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
