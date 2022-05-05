Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB2151BFB5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 14:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376973AbiEEMt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 08:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240170AbiEEMtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 08:49:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D6B21C12F
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 05:45:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF040106F;
        Thu,  5 May 2022 05:45:41 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.29.132])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7DD33F885;
        Thu,  5 May 2022 05:45:40 -0700 (PDT)
Date:   Thu, 5 May 2022 13:45:37 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     kernel test robot <lkp@intel.com>,
        Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [kees:for-next/kspp 21/25] drivers/misc/lkdtm/stackleak.c:17:39:
 error: call to undeclared function 'stackleak_task_low_bound'; ISO C99 and
 later do not support implicit function declarations
Message-ID: <YnPG8dGulGqxMHt6@FVFF77S0Q05N.cambridge.arm.com>
References: <202205050943.HDgeO9iV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205050943.HDgeO9iV-lkp@intel.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

I hadn't realised the LKDTM STACKLEAK test could be built with
CONFIG_STACKLEAK=n, and my rework of that depends upon helpers that only exist
when CONFIG_STACKLEAK=y.

IMO the test is nonsensical for CONFIG_STACKLEAK=n, and I reckon we should
either:

a) Not build the stackleak test at all when CONFIG_STACKLEAK=n

b) Have a small stub that just logs that CONFIG_STACKLEAK=n and the test is
   being skipped.

Do you have any preference between the two?

Thanks,
Mark.

On Thu, May 05, 2022 at 09:43:36AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/kspp
> head:   d46ac904fd35edfccc5080818e950d4d3b4697c4
> commit: f4cfacd92972cc440d534b5156df23d0a2136bab [21/25] lkdtm/stackleak: rework boundary management
> config: s390-randconfig-r044-20220502 (https://download.01.org/0day-ci/archive/20220505/202205050943.HDgeO9iV-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 363b3a645a1e30011cc8da624f13dac5fd915628)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install s390 cross compiling tool for clang build
>         # apt-get install binutils-s390x-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=f4cfacd92972cc440d534b5156df23d0a2136bab
>         git remote add kees https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
>         git fetch --no-tags kees for-next/kspp
>         git checkout f4cfacd92972cc440d534b5156df23d0a2136bab
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/misc/lkdtm/stackleak.c:17:39: error: call to undeclared function 'stackleak_task_low_bound'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>            const unsigned long task_stack_low = stackleak_task_low_bound(current);
>                                                 ^
> >> drivers/misc/lkdtm/stackleak.c:18:40: error: call to undeclared function 'stackleak_task_high_bound'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>            const unsigned long task_stack_high = stackleak_task_high_bound(current);
>                                                  ^
>    drivers/misc/lkdtm/stackleak.c:19:22: warning: incompatible pointer to integer conversion initializing 'const unsigned long' with an expression of type 'unsigned long (void)' [-Wint-conversion]
>            const unsigned long current_sp = current_stack_pointer;
>                                ^            ~~~~~~~~~~~~~~~~~~~~~
>    drivers/misc/lkdtm/stackleak.c:20:43: error: no member named 'lowest_stack' in 'struct task_struct'; did you mean 'ret_stack'?
>            const unsigned long lowest_sp = current->lowest_stack;
>                                                     ^~~~~~~~~~~~
>                                                     ret_stack
>    include/linux/sched.h:1365:28: note: 'ret_stack' declared here
>            struct ftrace_ret_stack         *ret_stack;
>                                             ^
>    drivers/misc/lkdtm/stackleak.c:20:22: warning: incompatible pointer to integer conversion initializing 'const unsigned long' with an expression of type 'struct ftrace_ret_stack *' [-Wint-conversion]
>            const unsigned long lowest_sp = current->lowest_stack;
>                                ^           ~~~~~~~~~~~~~~~~~~~~~
>    drivers/misc/lkdtm/stackleak.c:42:16: error: call to undeclared function 'stackleak_find_top_of_poison'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>            poison_high = stackleak_find_top_of_poison(task_stack_low, untracked_high);
>                          ^
>    2 warnings and 4 errors generated.
> 
> 
> vim +/stackleak_task_low_bound +17 drivers/misc/lkdtm/stackleak.c
> 
>     13	
>     14	void lkdtm_STACKLEAK_ERASING(void)
>     15	{
>     16		const unsigned long task_stack_base = (unsigned long)task_stack_page(current);
>   > 17		const unsigned long task_stack_low = stackleak_task_low_bound(current);
>   > 18		const unsigned long task_stack_high = stackleak_task_high_bound(current);
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
