Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E8F467650
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 12:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380446AbhLCL35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 06:29:57 -0500
Received: from mga09.intel.com ([134.134.136.24]:30453 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243703AbhLCL3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:29:34 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="236770703"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="236770703"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 03:26:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="501155930"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 03 Dec 2021 03:26:08 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mt6hb-000HVv-HU; Fri, 03 Dec 2021 11:26:07 +0000
Date:   Fri, 3 Dec 2021 19:25:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:x86/wip.ibt 9/15] arch/x86/include/asm/ibt.h:19:15:
 error: unknown type name 'bool'
Message-ID: <202112031911.oFNVAdph-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt
head:   80bc7f2a129848b0885cf214fda77f623ba2f5f9
commit: 2d27d6fd4034bc446885ee6bd234df59e2b11cdb [9/15] x86/linkage: Add ENDBR to SYM_FUNC_START*()
config: x86_64-randconfig-r003-20211203 (https://download.01.org/0day-ci/archive/20211203/202112031911.oFNVAdph-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=2d27d6fd4034bc446885ee6bd234df59e2b11cdb
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue x86/wip.ibt
        git checkout 2d27d6fd4034bc446885ee6bd234df59e2b11cdb
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the peterz-queue/x86/wip.ibt HEAD 80bc7f2a129848b0885cf214fda77f623ba2f5f9 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   In file included from arch/x86/include/asm/linkage.h:7,
                    from include/linux/instruction_pointer.h:5,
                    from include/linux/bottom_half.h:5,
                    from net/ipv4/tcp_ipv4.c:50:
>> arch/x86/include/asm/ibt.h:19:15: error: unknown type name 'bool'
      19 | static inline bool is_endbr(const void *addr)
         |               ^~~~


vim +/bool +19 arch/x86/include/asm/ibt.h

7446adeec86172 Peter Zijlstra 2021-11-22  14  
7446adeec86172 Peter Zijlstra 2021-11-22  15  /*
7446adeec86172 Peter Zijlstra 2021-11-22  16   * A bit convoluted, but matches both endbr32 and endbr64 without
7446adeec86172 Peter Zijlstra 2021-11-22  17   * having either as literal in the text.
7446adeec86172 Peter Zijlstra 2021-11-22  18   */
7446adeec86172 Peter Zijlstra 2021-11-22 @19  static inline bool is_endbr(const void *addr)
7446adeec86172 Peter Zijlstra 2021-11-22  20  {
7446adeec86172 Peter Zijlstra 2021-11-22  21  	unsigned int val = ~*(unsigned int *)addr;
7446adeec86172 Peter Zijlstra 2021-11-22  22  	val |= 0x01000000U;
7446adeec86172 Peter Zijlstra 2021-11-22  23  	return val == ~0xfa1e0ff3;
7446adeec86172 Peter Zijlstra 2021-11-22  24  }
7446adeec86172 Peter Zijlstra 2021-11-22  25  

:::::: The code at line 19 was first introduced by commit
:::::: 7446adeec8617255600933e8da5e7daf20eb2263 x86: Base IBT bits

:::::: TO: Peter Zijlstra <peterz@infradead.org>
:::::: CC: Peter Zijlstra <peterz@infradead.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
