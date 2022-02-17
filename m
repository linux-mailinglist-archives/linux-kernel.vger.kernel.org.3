Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE99F4B9534
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 02:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiBQBAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 20:00:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiBQBA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 20:00:28 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A694D27AA3C;
        Wed, 16 Feb 2022 17:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645059614; x=1676595614;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JOE3Z+fvMcnJ/xlaJj15KpF9bdp81h8xkVXrYehasK0=;
  b=na6bMpsAPLxPcV74evCMuz82PWMRPew62sczDcIp4nBmgoVO7SzriPYm
   mg34clRrqAizNF51QFn1WQLVrSA7YJKu/DYBAbQZL0YKUtFdb+xuYmitT
   sYYm5m7NRvSNCEixCPTdf3w8MNMBVEaw1EEmooLzakMb8Y9Vr4NlpempR
   7BCQOAOyTAGF1Tb81VxGCN97ynUYpK3dl4bw/olOWY7qAODaRlD/0VbT8
   kYaUjAqAKQmalu1atC83LOZlXBdF987hV/i9LtQiGKS2l+A3f/tSED95l
   6WudPkV/Y1NxjNycN90YYER8J+vRaiM2X+o0Eti4poYWohnC2Er6WlNF1
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="311501972"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="311501972"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 16:59:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="704537496"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 16 Feb 2022 16:59:55 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKV9G-000BH7-ID; Thu, 17 Feb 2022 00:59:54 +0000
Date:   Thu, 17 Feb 2022 08:59:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     kbuild-all@lists.01.org, Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] usercopy: Check valid lifetime via stack depth
Message-ID: <202202170844.jnpFFEmh-lkp@intel.com>
References: <20220216201449.2087956-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216201449.2087956-1-keescook@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

I love your patch! Yet something to improve:

[auto build test ERROR on hnaz-mm/master]
[also build test ERROR on kees/for-next/pstore v5.17-rc4 next-20220216]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Kees-Cook/usercopy-Check-valid-lifetime-via-stack-depth/20220217-041611
base:   https://github.com/hnaz/linux-mm master
config: openrisc-randconfig-r002-20220216 (https://download.01.org/0day-ci/archive/20220217/202202170844.jnpFFEmh-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/77944e5fa0cf5a29903b72466a22152c6a5d41ac
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Kees-Cook/usercopy-Check-valid-lifetime-via-stack-depth/20220217-041611
        git checkout 77944e5fa0cf5a29903b72466a22152c6a5d41ac
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=openrisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/usercopy.c: In function 'check_stack_object':
>> mm/usercopy.c:41:42: error: 'current_stack_pointer' undeclared (first use in this function); did you mean 'user_stack_pointer'?
      41 |         const void * const low = (void *)current_stack_pointer;
         |                                          ^~~~~~~~~~~~~~~~~~~~~
         |                                          user_stack_pointer
   mm/usercopy.c:41:42: note: each undeclared identifier is reported only once for each function it appears in
   mm/usercopy.c: In function '__check_object_size':
   mm/usercopy.c:287:41: error: 'current_stack_pointer' undeclared (first use in this function); did you mean 'user_stack_pointer'?
     287 |                                 (void *)current_stack_pointer - ptr,
         |                                         ^~~~~~~~~~~~~~~~~~~~~
         |                                         user_stack_pointer


vim +41 mm/usercopy.c

    24	
    25	/*
    26	 * Checks if a given pointer and length is contained by the current
    27	 * stack frame (if possible).
    28	 *
    29	 * Returns:
    30	 *	NOT_STACK: not at all on the stack
    31	 *	GOOD_FRAME: fully within a valid stack frame
    32	 *	GOOD_STACK: within the current stack (when can't frame-check exactly)
    33	 *	BAD_STACK: error condition (invalid stack position or bad stack frame)
    34	 */
    35	static noinline int check_stack_object(const void *obj, unsigned long len)
    36	{
    37		const void * const stack = task_stack_page(current);
    38		const void * const stackend = stack + THREAD_SIZE;
    39	#ifndef CONFIG_STACK_GROWSUP
    40		const void * const high = stackend;
  > 41		const void * const low = (void *)current_stack_pointer;
    42	#else
    43		const void * const high = (void *)current_stack_pointer;
    44		const void * const low = stack;
    45	#endif
    46		int ret;
    47	
    48		/* Object is not on the stack at all. */
    49		if (obj + len <= stack || stackend <= obj)
    50			return NOT_STACK;
    51	
    52		/*
    53		 * Reject: object partially overlaps the stack (passing the
    54		 * check above means at least one end is within the stack,
    55		 * so if this check fails, the other end is outside the stack).
    56		 */
    57		if (obj < stack || stackend < obj + len)
    58			return BAD_STACK;
    59	
    60		/* Check if object is safely within a valid frame. */
    61		ret = arch_within_stack_frames(stack, stackend, obj, len);
    62		if (ret)
    63			return ret;
    64	
    65		/*
    66		 * Reject: object not within current stack depth.
    67		 */
    68		if (obj < low || high < obj + len)
    69			return BAD_STACK;
    70	
    71		return GOOD_STACK;
    72	}
    73	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
