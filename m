Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1580D4C0ED4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 10:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239173AbiBWJG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 04:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237127AbiBWJGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:06:54 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7717ED91
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 01:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645607187; x=1677143187;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UmG8QUkK9khDhXRiw9N34JhJQ0VKWF9hY6tPnln+/Xk=;
  b=XIL8F8FGozAUw9/ypXTljD5mI8fuaciOkDIU+cRe6q5QkyNcfQSrDnOZ
   9zNmU89HqrCxQzFNkAeITIn+pcUgbhaSJt7H//kkiGTlAJ7ySFK9j2w9j
   QQ6MM9i2ycqX746bPQ47FyWHFda2oBxJqhYlfAzlUW40qc0Bp5QaphHx6
   gJBWQAmX6WPlpdZtd8Pbqvx4nYLA6fZQUfoK3H7aHBpsyUHnfYwR9nxdu
   Zc7/EuSlRG7mZSae8LUfyXfTPs/aSkllUPyK3Tdi/cuJaRAAHvwfQEJOy
   pjNkI9R9mgTLFzCVarpkVQYQmDgix6424NgyHmr/eKEY6lIvwY4mJQ0ik
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="232541568"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="232541568"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 01:06:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="543248029"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 23 Feb 2022 01:06:21 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMnbJ-0001C6-7M; Wed, 23 Feb 2022 09:06:21 +0000
Date:   Wed, 23 Feb 2022 17:05:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, will@kernel.org,
        maz@kernel.org, qperret@google.com, tabba@google.com,
        surenb@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Scull <ascull@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v2 6/9] KVM: arm64: Detect and handle hypervisor stack
 overflows
Message-ID: <202202231727.L621fVgD-lkp@intel.com>
References: <20220222165212.2005066-7-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222165212.2005066-7-kaleshsingh@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kalesh,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on cfb92440ee71adcc2105b0890bb01ac3cddb8507]

url:    https://github.com/0day-ci/linux/commits/Kalesh-Singh/KVM-arm64-Hypervisor-stack-enhancements/20220223-010522
base:   cfb92440ee71adcc2105b0890bb01ac3cddb8507
config: arm64-randconfig-r011-20220221 (https://download.01.org/0day-ci/archive/20220223/202202231727.L621fVgD-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/7fe99fd40f7c4b2973218045ca5b9c9160524db1
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Kalesh-Singh/KVM-arm64-Hypervisor-stack-enhancements/20220223-010522
        git checkout 7fe99fd40f7c4b2973218045ca5b9c9160524db1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
   #define NULL ((void *)0)
                ^~~~~~~~~~~
   arch/arm64/kvm/hyp/nvhe/switch.c:200:27: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_FP_ASIMD]           = kvm_hyp_handle_fpsimd,
                                             ^~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/hyp/nvhe/switch.c:196:28: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]          = NULL,
                                             ^~~~
   include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
   #define NULL ((void *)0)
                ^~~~~~~~~~~
   arch/arm64/kvm/hyp/nvhe/switch.c:201:27: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_IABT_LOW]           = kvm_hyp_handle_iabt_low,
                                             ^~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/hyp/nvhe/switch.c:196:28: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]          = NULL,
                                             ^~~~
   include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
   #define NULL ((void *)0)
                ^~~~~~~~~~~
   arch/arm64/kvm/hyp/nvhe/switch.c:202:27: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_DABT_LOW]           = kvm_hyp_handle_dabt_low,
                                             ^~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/hyp/nvhe/switch.c:196:28: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]          = NULL,
                                             ^~~~
   include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
   #define NULL ((void *)0)
                ^~~~~~~~~~~
   arch/arm64/kvm/hyp/nvhe/switch.c:203:22: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_PAC]                = kvm_hyp_handle_ptrauth,
                                             ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/hyp/nvhe/switch.c:196:28: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]          = NULL,
                                             ^~~~
   include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
   #define NULL ((void *)0)
                ^~~~~~~~~~~
   arch/arm64/kvm/hyp/nvhe/switch.c:208:24: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_SYS64]              = kvm_handle_pvm_sys64,
                                             ^~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/hyp/nvhe/switch.c:207:28: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]          = NULL,
                                             ^~~~
   include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
   #define NULL ((void *)0)
                ^~~~~~~~~~~
   arch/arm64/kvm/hyp/nvhe/switch.c:209:22: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_SVE]                = kvm_handle_pvm_restricted,
                                             ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/hyp/nvhe/switch.c:207:28: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]          = NULL,
                                             ^~~~
   include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
   #define NULL ((void *)0)
                ^~~~~~~~~~~
   arch/arm64/kvm/hyp/nvhe/switch.c:210:27: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_FP_ASIMD]           = kvm_handle_pvm_fpsimd,
                                             ^~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/hyp/nvhe/switch.c:207:28: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]          = NULL,
                                             ^~~~
   include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
   #define NULL ((void *)0)
                ^~~~~~~~~~~
   arch/arm64/kvm/hyp/nvhe/switch.c:211:27: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_IABT_LOW]           = kvm_hyp_handle_iabt_low,
                                             ^~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/hyp/nvhe/switch.c:207:28: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]          = NULL,
                                             ^~~~
   include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
   #define NULL ((void *)0)
                ^~~~~~~~~~~
   arch/arm64/kvm/hyp/nvhe/switch.c:212:27: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_DABT_LOW]           = kvm_hyp_handle_dabt_low,
                                             ^~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/hyp/nvhe/switch.c:207:28: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]          = NULL,
                                             ^~~~
   include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
   #define NULL ((void *)0)
                ^~~~~~~~~~~
   arch/arm64/kvm/hyp/nvhe/switch.c:213:22: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_PAC]                = kvm_hyp_handle_ptrauth,
                                             ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/hyp/nvhe/switch.c:207:28: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]          = NULL,
                                             ^~~~
   include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
   #define NULL ((void *)0)
                ^~~~~~~~~~~
   arch/arm64/kvm/hyp/nvhe/switch.c:350:17: warning: no previous prototype for function 'hyp_panic' [-Wmissing-prototypes]
   void __noreturn hyp_panic(void)
                   ^
   arch/arm64/kvm/hyp/nvhe/switch.c:350:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __noreturn hyp_panic(void)
   ^
   static 
>> arch/arm64/kvm/hyp/nvhe/switch.c:372:17: warning: no previous prototype for function 'hyp_panic_bad_stack' [-Wmissing-prototypes]
   void __noreturn hyp_panic_bad_stack(void)
                   ^
   arch/arm64/kvm/hyp/nvhe/switch.c:372:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __noreturn hyp_panic_bad_stack(void)
   ^
   static 
   arch/arm64/kvm/hyp/nvhe/switch.c:377:17: warning: no previous prototype for function 'kvm_unexpected_el2_exception' [-Wmissing-prototypes]
   asmlinkage void kvm_unexpected_el2_exception(void)
                   ^
   arch/arm64/kvm/hyp/nvhe/switch.c:377:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void kvm_unexpected_el2_exception(void)
              ^
              static 
   16 warnings generated.


vim +/hyp_panic_bad_stack +372 arch/arm64/kvm/hyp/nvhe/switch.c

   371	
 > 372	void __noreturn hyp_panic_bad_stack(void)
   373	{
   374		hyp_panic();
   375	}
   376	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
