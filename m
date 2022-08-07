Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0908C58BB15
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 15:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbiHGNr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 09:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbiHGNry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 09:47:54 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30925A458
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 06:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659880073; x=1691416073;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=77FBl3vUx49zjQlv3n6/4RN63oc5IH0eL4s0Jvvhj8Y=;
  b=hPGi83YuDz4lllnDqBEPKP0sbdjtggGaXBtEBd/EvOxWIlmU4zS647BA
   7aeQVaRxzZ8XK12/A1sUSpOR5+eU7WF++BUZj0jDuYMQiwW3zeYC6oyJf
   WmF8LlmEk2+kXJp9i+VD7P1NqtF6e4auwtBNMFl0/rbMsZRUiF6IlL+jI
   +xr81YEWDbxZNLTgJBiRHriq8IeBKuJQ0dOEsraScHg9LPKM5O9uGoKb6
   6L6KXugvdS0D404qGy5ppTvebwmzQ/A+ZKx247yLXXReq6dT5EzzSTOYn
   XM0/iFXsO9mx6BG6rsG6/yDdMOqkzSNsziZU01RauuktgiWZ3dKUF1+aD
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="354438638"
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="354438638"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 06:47:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="554620105"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 07 Aug 2022 06:47:33 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKgcv-000LKn-0b;
        Sun, 07 Aug 2022 13:47:33 +0000
Date:   Sun, 7 Aug 2022 21:47:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>, will@kernel.org,
        arnd@arndb.de, catalin.marinas@arm.com, mark.rutland@arm.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2] arm64: run softirqs on the per-CPU IRQ stack
Message-ID: <202208072125.pTMPctXF-lkp@intel.com>
References: <20220802065325.39740-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802065325.39740-1-zhengqi.arch@bytedance.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on soc/for-next]
[also build test WARNING on v5.19]
[cannot apply to arm64/for-next/core linus/master next-20220805]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qi-Zheng/arm64-run-softirqs-on-the-per-CPU-IRQ-stack/20220802-145547
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
config: arm64-randconfig-r032-20220801 (https://download.01.org/0day-ci/archive/20220807/202208072125.pTMPctXF-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/34ac9375ce5e75127084159f724fcb2208c022a3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Qi-Zheng/arm64-run-softirqs-on-the-per-CPU-IRQ-stack/20220802-145547
        git checkout 34ac9375ce5e75127084159f724fcb2208c022a3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kernel/irq.c:81:6: warning: no previous prototype for function 'do_softirq_own_stack' [-Wmissing-prototypes]
   void do_softirq_own_stack(void)
        ^
   arch/arm64/kernel/irq.c:81:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void do_softirq_own_stack(void)
   ^
   static 
   arch/arm64/kernel/irq.c:120:13: warning: no previous prototype for function 'init_IRQ' [-Wmissing-prototypes]
   void __init init_IRQ(void)
               ^
   arch/arm64/kernel/irq.c:120:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init init_IRQ(void)
   ^
   static 
   2 warnings generated.


vim +/do_softirq_own_stack +81 arch/arm64/kernel/irq.c

    80	
  > 81	void do_softirq_own_stack(void)
    82	{
    83		call_on_irq_stack(NULL, ____do_softirq);
    84	}
    85	#endif
    86	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
