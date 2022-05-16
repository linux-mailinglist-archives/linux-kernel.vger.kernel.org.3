Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90C152925C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 23:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348426AbiEPVHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 17:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349315AbiEPVGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 17:06:47 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1D062E0
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 13:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652733953; x=1684269953;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GR4TGEMQ7jippiGwucw3egChFg5sOwZmyYttdXNMnQg=;
  b=HRRlVmjY/hmpxbKNZBZKeGzcUaFHYk+GD6zNV8z4rM5Y0OHiAK+js2Pe
   GuydOJyRq5NxQCNS0eTbiQvwkNhpxRR5PNtbzG000lMqVNGU4XDfl5Pea
   8aT8kUrlKRP6ydPMJjnXfB73r02C1POljqKSa7YwIFuUNiTi52phZB3PS
   3WBCiaZsm1uR4//wG2c/KRIO6GYHvbWyxFDY2uEpTcxOjvm9oCxBxyk8o
   8fOHKAaAWSUyc8Jf0W74jGjEoSOxlgmCy50nIDZ7cTcBMSoctuK96zonz
   Qsv0o1Bo1LSJdh5nS31cux3ZdE/SKHtJxx/tesm/PR6GjLWm8tJBO7jG2
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="251474255"
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="251474255"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 13:45:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="741421080"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 16 May 2022 13:45:50 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqhbB-0000Jx-Uo;
        Mon, 16 May 2022 20:45:49 +0000
Date:   Tue, 17 May 2022 04:44:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [nsaenz-rpi:ct-work-defer-wip 25/25] vmlinux.o: warning: objtool:
 ct_enter_work+0x135: call to __flush_tlb_all() leaves .noinstr.text section
Message-ID: <202205170451.WsdoDOQq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git ct-work-defer-wip
head:   ed63029652239a6befad96dd473b16332913f889
commit: ed63029652239a6befad96dd473b16332913f889 [25/25] context_tracking,x86: Fix Kernel cachei vs NOHZ_FULL
config: x86_64-randconfig-a014-20220516 (https://download.01.org/0day-ci/archive/20220517/202205170451.WsdoDOQq-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git/commit/?id=ed63029652239a6befad96dd473b16332913f889
        git remote add nsaenz-rpi https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git
        git fetch --no-tags nsaenz-rpi ct-work-defer-wip
        git checkout ed63029652239a6befad96dd473b16332913f889
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: vmx_l1d_flush+0x13: call to static_key_count() leaves .noinstr.text section
   vmlinux.o: warning: objtool: vmx_vcpu_enter_exit+0x24: call to static_key_count() leaves .noinstr.text section
   vmlinux.o: warning: objtool: vmx_update_host_rsp+0x3e: call to static_key_count() leaves .noinstr.text section
   vmlinux.o: warning: objtool: enter_from_user_mode+0x1c: call to __kcsan_check_access() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x21: call to __kcsan_check_access() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x1c: call to __kcsan_check_access() leaves .noinstr.text section
   vmlinux.o: warning: objtool: exit_to_user_mode+0x17: call to static_key_count() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_exit_to_user_mode+0x31: call to static_key_count() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x1c: call to __kcsan_check_access() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_exit_to_user_mode+0x1e: call to static_key_count() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: ct_enter_work+0x135: call to __flush_tlb_all() leaves .noinstr.text section
   vmlinux.o: warning: objtool: __ct_user_exit+0x59: call to __kcsan_check_access() leaves .noinstr.text section
   vmlinux.o: warning: objtool: __ct_user_enter+0xd6: call to __kcsan_check_access() leaves .noinstr.text section

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
