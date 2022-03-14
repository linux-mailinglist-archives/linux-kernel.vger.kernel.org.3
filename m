Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35FB4D8191
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 12:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbiCNLpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 07:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239980AbiCNLnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 07:43:17 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B924992B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 04:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647258051; x=1678794051;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6pomGZNC6bwGmy9YSOXWa0xPgJlHZ0NHIMsbvBWqPYk=;
  b=KFOoVrl0U6rPkGdnqpxSnIAwKP6DlvSGBXiG1YrZz8pOLtYpH6yWLmkl
   SXg50mqGRZEnZRv1cVtEPuRLtqY4IXSRP/tkiQYWX6GtU0Y+ToiPzNL1q
   I90mWzMIes3mQmVRXwrfgWPb2rjwhPZRLBZsbKeWPX2PEaDpbe8DiCnZb
   zP+F/xblmxRJ9LhX3ZV6o69v9yzOSDnWpDpkIZJvdBvb08hMksqRkPAkB
   A6vvTzASVOUTl7h4qFpfFJIuRn1v8+YhCGsj6bALN+2OjVf94aFfOL1UW
   A822Hex11ESTntn+Qjb8vedI0+1pmfLoSQN7DMGxyfUA1E0Q8KzNuK+zH
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="235950838"
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; 
   d="scan'208";a="235950838"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 04:40:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; 
   d="scan'208";a="515392226"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 14 Mar 2022 04:40:49 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTj4C-0009pP-E6; Mon, 14 Mar 2022 11:40:48 +0000
Date:   Mon, 14 Mar 2022 19:40:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [tip:locking/core 4/5] vmlinux.o: warning: objtool:
 do_machine_check()+0x419: call to mca_msr_reg() leaves .noinstr.text section
Message-ID: <202203141947.9KhIyyR7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
head:   cd27ccfc727e99352321c0c75012ab9c5a90321e
commit: acb13ea0baf8db8d05a3910c06e997c90825faad [4/5] asm-generic/bitops: Always inline all bit manipulation helpers
config: x86_64-randconfig-a005-20220314 (https://download.01.org/0day-ci/archive/20220314/202203141947.9KhIyyR7-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=acb13ea0baf8db8d05a3910c06e997c90825faad
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip locking/core
        git checkout acb13ea0baf8db8d05a3910c06e997c90825faad
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: mce_read_aux()+0x42: call to mca_msr_reg() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: do_machine_check()+0x419: call to mca_msr_reg() leaves .noinstr.text section
   vmlinux.o: warning: objtool: enter_from_user_mode()+0x4a: call to on_thread_stack() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode()+0x53: call to on_thread_stack() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare()+0x4a: call to on_thread_stack() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_enter_from_user_mode()+0x4a: call to on_thread_stack() leaves .noinstr.text section

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
