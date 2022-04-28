Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE1D513840
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349119AbiD1P2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347167AbiD1P2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:28:09 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D765B715D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651159495; x=1682695495;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OB8erSxeEPvD/61c1TWqwknjFG/dDVzfD1qRXPL9Uj4=;
  b=VV4FL/HSpSg5Ua+7LKQdo7ZHOU9ICdEM7adyjrMKvgoZw6GbWEP0Y1K6
   TvDl14lRcFu0iiWXzvrHexKfFPQidkT2LJ5aNROw7pLVlhvk34/OPp4Vd
   EYVS58cPnAf0DexmHUnrrEH8YES+Ohsv+ICkjcaFEyrVjmAFHHdzyQRya
   /9/lqwoBSQIaqG5TPXnEnScNCgv9JIo7beEiOk1z8raBzv38B8Vy9tGGU
   mnhZX/s9lNDP0bXGTW/uCBfg3PFdYagbMccFpo9XHl07e1t3EgecDOhkI
   7KBoT0vztfT3ynl6IqGK+Xf88Oe93MZBNA/cTyMS9gAqTqn+JIwpAJOl8
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="266481913"
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="266481913"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 08:24:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="541408288"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 28 Apr 2022 08:24:53 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nk60i-0005Ti-GE;
        Thu, 28 Apr 2022 15:24:52 +0000
Date:   Thu, 28 Apr 2022 23:23:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mark:stackleak/rework 9/13] drivers/misc/lkdtm/stackleak.c:20:22:
 warning: incompatible pointer to integer conversion initializing 'const
 unsigned long' with an expression of type 'struct ftrace_ret_stack *'
Message-ID: <202204282335.OFfZpgnN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git stackleak/rework
head:   eceae38b5363e034fea5ad4cf977734a864a2bb0
commit: 4aac8d85c42a73f2d4dcb11acf3e4ec669919e08 [9/13] lkdtm/stackleak: rework boundary management
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220428/202204282335.OFfZpgnN-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c59473aacce38cd7dd77eebceaf3c98c5707ab3b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=4aac8d85c42a73f2d4dcb11acf3e4ec669919e08
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark stackleak/rework
        git checkout 4aac8d85c42a73f2d4dcb11acf3e4ec669919e08
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/misc/lkdtm/ drivers/net/wireless/realtek/rtw89/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/misc/lkdtm/stackleak.c:17:39: error: call to undeclared function 'stackleak_task_low_bound'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           const unsigned long task_stack_low = stackleak_task_low_bound(current);
                                                ^
   drivers/misc/lkdtm/stackleak.c:18:40: error: call to undeclared function 'stackleak_task_high_bound'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           const unsigned long task_stack_high = stackleak_task_high_bound(current);
                                                 ^
   drivers/misc/lkdtm/stackleak.c:20:43: error: no member named 'lowest_stack' in 'struct task_struct'; did you mean 'ret_stack'?
           const unsigned long lowest_sp = current->lowest_stack;
                                                    ^~~~~~~~~~~~
                                                    ret_stack
   include/linux/sched.h:1365:28: note: 'ret_stack' declared here
           struct ftrace_ret_stack         *ret_stack;
                                            ^
>> drivers/misc/lkdtm/stackleak.c:20:22: warning: incompatible pointer to integer conversion initializing 'const unsigned long' with an expression of type 'struct ftrace_ret_stack *' [-Wint-conversion]
           const unsigned long lowest_sp = current->lowest_stack;
                               ^           ~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/lkdtm/stackleak.c:42:16: error: call to undeclared function 'stackleak_find_top_of_poison'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           poison_high = stackleak_find_top_of_poison(task_stack_low, untracked_high);
                         ^
   1 warning and 4 errors generated.


vim +20 drivers/misc/lkdtm/stackleak.c

    13	
    14	void lkdtm_STACKLEAK_ERASING(void)
    15	{
    16		const unsigned long task_stack_base = (unsigned long)task_stack_page(current);
    17		const unsigned long task_stack_low = stackleak_task_low_bound(current);
    18		const unsigned long task_stack_high = stackleak_task_high_bound(current);
    19		const unsigned long current_sp = current_stack_pointer;
  > 20		const unsigned long lowest_sp = current->lowest_stack;

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
