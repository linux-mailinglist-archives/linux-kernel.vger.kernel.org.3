Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976E24E6A54
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 22:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355191AbiCXVlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 17:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355203AbiCXVlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 17:41:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AD4654B7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 14:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648158005; x=1679694005;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VTSq1ix+3EBzR/DNpL0fzWXKaftzrn905lBpVaHr6Do=;
  b=Okncc7gOlKqSfxJnXQPE3Sx4A2XXQ41BKG5I8TvL1XUBnOYVFJjPUeq7
   KLbrqdaGs3zCybZltJ7tdFp72JSrs6blW9g9zK5dWWQ2s5cPVV0Ul+oHg
   OiCEPqsmHM2IN1p5Rff2XJehwuHdKsTzz5cWTjd3YxhMQMqub7wMqehjO
   tqcrAdBSXUaBj3sCcOV5lORuPDyTIE1RnAcyF8K9euHX2NUXhJ2qbiE+5
   /RKkTgs6AsWhto3EngXgJOusodMfLDJNAORs3y0c/09vbZj3Cqt49LxrQ
   N8NwptNYLCDTlZvNNkrwDmIkc19ufV0kbhj25L3OoaIHWxgSR9sBao5tu
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="238437324"
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="238437324"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 14:40:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="650014103"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 24 Mar 2022 14:40:00 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXVBX-000LT5-JQ; Thu, 24 Mar 2022 21:39:59 +0000
Date:   Fri, 25 Mar 2022 05:39:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Mark Rutland <mark.rutland@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] arm64, scs: save scs_sp values per-cpu when
 switching stacks
Message-ID: <202203250512.yMAPu8rv-lkp@intel.com>
References: <f75c58b17bfaa419f84286cd174e3a08f971b779.1648049113.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f75c58b17bfaa419f84286cd174e3a08f971b779.1648049113.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I love your patch! Yet something to improve:

[auto build test ERROR on next-20220323]
[also build test ERROR on v5.17]
[cannot apply to arm64/for-next/core hnaz-mm/master linus/master v5.17 v5.17-rc8 v5.17-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/andrey-konovalov-linux-dev/kasan-arm64-scs-stacktrace-collect-stack-traces-from-Shadow-Call-Stack/20220323-233436
base:    b61581ae229d8eb9f21f8753be3f4011f7692384
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220325/202203250512.yMAPu8rv-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/da5bedb1ac7aa0b303f6d996d306e675860b6e12
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review andrey-konovalov-linux-dev/kasan-arm64-scs-stacktrace-collect-stack-traces-from-Shadow-Call-Stack/20220323-233436
        git checkout da5bedb1ac7aa0b303f6d996d306e675860b6e12
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/arm64/kernel/sdei.c: In function 'free_sdei_scs':
>> arch/arm64/kernel/sdei.c:124:33: error: 'sdei_shadow_call_stack_normal_ptr' undeclared (first use in this function)
     124 |                 _free_sdei_scs(&sdei_shadow_call_stack_normal_ptr, cpu);
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/sdei.c:124:33: note: each undeclared identifier is reported only once for each function it appears in
>> arch/arm64/kernel/sdei.c:125:33: error: 'sdei_shadow_call_stack_critical_ptr' undeclared (first use in this function); did you mean 'sdei_stack_critical_ptr'?
     125 |                 _free_sdei_scs(&sdei_shadow_call_stack_critical_ptr, cpu);
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                 sdei_stack_critical_ptr
   arch/arm64/kernel/sdei.c: In function 'init_sdei_scs':
   arch/arm64/kernel/sdei.c:150:39: error: 'sdei_shadow_call_stack_normal_ptr' undeclared (first use in this function)
     150 |                 err = _init_sdei_scs(&sdei_shadow_call_stack_normal_ptr, cpu);
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/sdei.c:153:39: error: 'sdei_shadow_call_stack_critical_ptr' undeclared (first use in this function); did you mean 'sdei_stack_critical_ptr'?
     153 |                 err = _init_sdei_scs(&sdei_shadow_call_stack_critical_ptr, cpu);
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                       sdei_stack_critical_ptr


vim +/sdei_shadow_call_stack_normal_ptr +124 arch/arm64/kernel/sdei.c

ac20ffbb0279aae Sami Tolvanen 2020-11-30  118  
ac20ffbb0279aae Sami Tolvanen 2020-11-30  119  static void free_sdei_scs(void)
ac20ffbb0279aae Sami Tolvanen 2020-11-30  120  {
ac20ffbb0279aae Sami Tolvanen 2020-11-30  121  	int cpu;
ac20ffbb0279aae Sami Tolvanen 2020-11-30  122  
ac20ffbb0279aae Sami Tolvanen 2020-11-30  123  	for_each_possible_cpu(cpu) {
ac20ffbb0279aae Sami Tolvanen 2020-11-30 @124  		_free_sdei_scs(&sdei_shadow_call_stack_normal_ptr, cpu);
ac20ffbb0279aae Sami Tolvanen 2020-11-30 @125  		_free_sdei_scs(&sdei_shadow_call_stack_critical_ptr, cpu);
ac20ffbb0279aae Sami Tolvanen 2020-11-30  126  	}
ac20ffbb0279aae Sami Tolvanen 2020-11-30  127  }
ac20ffbb0279aae Sami Tolvanen 2020-11-30  128  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
