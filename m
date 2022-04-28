Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BCE5131F7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345334AbiD1LD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 07:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239726AbiD1LDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:03:00 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56346985AC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 03:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651143562; x=1682679562;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GftF7yIiVe+kgQHRxHFbcO/CqgnlYPlkprPfMtVr4V8=;
  b=GyC5n4yhNW5yG33Nj5KM50u6TZR4bDacbWWKtp46+vzW/rXhqhhcbEL0
   S0SUYtwi2lvSD49WGmLchYshUDbFVfbumn7zcrZ3oz1QJbmRj4ijzF3eA
   Ybz0mKRMcRYtjmD6YvL7WRJQI6NVRVISyp64m50x+LQbftPRLDNbRXHPi
   IUvDtTascleLBjkYMnJzhR0Hlfii1r/5vGT3+wZtWbqDHgHCsEkMDxQAO
   MNnsEJev6fj4A9houBcqiUt/gNoZixASEJsjpStn7HXrPyF3oEFWSvzp1
   xZT+Yf6RQ3tKXGC9xbRe2lGk8w0pIcoZ/S3XjVPZkCb1u+/pxMKYvsmra
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="265099367"
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="265099367"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 03:59:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="731398569"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 28 Apr 2022 03:59:20 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nk1rj-0005Id-E0;
        Thu, 28 Apr 2022 10:59:19 +0000
Date:   Thu, 28 Apr 2022 18:58:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mark:stackleak/rework 9/13] drivers/misc/lkdtm/stackleak.c:17:46:
 error: implicit declaration of function 'stackleak_task_low_bound'
Message-ID: <202204281826.6EyBPye1-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git stackleak/rework
head:   eceae38b5363e034fea5ad4cf977734a864a2bb0
commit: 4aac8d85c42a73f2d4dcb11acf3e4ec669919e08 [9/13] lkdtm/stackleak: rework boundary management
config: arc-randconfig-r043-20220428 (https://download.01.org/0day-ci/archive/20220428/202204281826.6EyBPye1-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=4aac8d85c42a73f2d4dcb11acf3e4ec669919e08
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark stackleak/rework
        git checkout 4aac8d85c42a73f2d4dcb11acf3e4ec669919e08
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/misc/lkdtm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/misc/lkdtm/stackleak.c: In function 'lkdtm_STACKLEAK_ERASING':
>> drivers/misc/lkdtm/stackleak.c:17:46: error: implicit declaration of function 'stackleak_task_low_bound' [-Werror=implicit-function-declaration]
      17 |         const unsigned long task_stack_low = stackleak_task_low_bound(current);
         |                                              ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/misc/lkdtm/stackleak.c:18:47: error: implicit declaration of function 'stackleak_task_high_bound'; did you mean 'stackleak_task_init'? [-Werror=implicit-function-declaration]
      18 |         const unsigned long task_stack_high = stackleak_task_high_bound(current);
         |                                               ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                                               stackleak_task_init
>> drivers/misc/lkdtm/stackleak.c:19:42: error: 'current_stack_pointer' undeclared (first use in this function); did you mean 'user_stack_pointer'?
      19 |         const unsigned long current_sp = current_stack_pointer;
         |                                          ^~~~~~~~~~~~~~~~~~~~~
         |                                          user_stack_pointer
   drivers/misc/lkdtm/stackleak.c:19:42: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/misc/lkdtm/stackleak.c:20:48: error: 'struct task_struct' has no member named 'lowest_stack'
      20 |         const unsigned long lowest_sp = current->lowest_stack;
         |                                                ^~
>> drivers/misc/lkdtm/stackleak.c:42:23: error: implicit declaration of function 'stackleak_find_top_of_poison' [-Werror=implicit-function-declaration]
      42 |         poison_high = stackleak_find_top_of_poison(task_stack_low, untracked_high);
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/stackleak_task_low_bound +17 drivers/misc/lkdtm/stackleak.c

    13	
    14	void lkdtm_STACKLEAK_ERASING(void)
    15	{
    16		const unsigned long task_stack_base = (unsigned long)task_stack_page(current);
  > 17		const unsigned long task_stack_low = stackleak_task_low_bound(current);
  > 18		const unsigned long task_stack_high = stackleak_task_high_bound(current);
  > 19		const unsigned long current_sp = current_stack_pointer;
  > 20		const unsigned long lowest_sp = current->lowest_stack;
    21		unsigned long untracked_high;
    22		unsigned long poison_high, poison_low;
    23		bool test_failed = false;
    24	
    25		/*
    26		 * Depending on what has run prior to this test, the lowest recorded
    27		 * stack pointer could be above or below the current stack pointer.
    28		 * Start from the lowest of the two.
    29		 *
    30		 * Poison values are naturally-aligned unsigned longs. As the current
    31		 * stack pointer might not be sufficiently aligned, we must align
    32		 * downwards to find the lowest known stack pointer value. This is the
    33		 * high boundary for a portion of the stack which may have been used
    34		 * without being tracked, and has to be scanned for poison.
    35		 */
    36		untracked_high = min(current_sp, lowest_sp);
    37		untracked_high = ALIGN_DOWN(untracked_high, sizeof(unsigned long));
    38	
    39		/*
    40		 * Find the top of the poison in the same way as the erasing code.
    41		 */
  > 42		poison_high = stackleak_find_top_of_poison(task_stack_low, untracked_high);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
