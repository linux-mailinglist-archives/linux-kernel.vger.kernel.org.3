Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0679E466BB7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 22:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377134AbhLBVmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 16:42:07 -0500
Received: from mga02.intel.com ([134.134.136.20]:56566 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242456AbhLBVmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 16:42:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="224083057"
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="224083057"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 13:38:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="513378495"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 02 Dec 2021 13:38:42 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mstmr-000Gi1-Pj; Thu, 02 Dec 2021 21:38:41 +0000
Date:   Fri, 3 Dec 2021 05:38:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:x86/wip.ibt 7/15] arch/x86/kernel/setup.c:65:1:
 warning: 'nocf_check' attribute ignored. Use '-fcf-protection' option to
 enable it
Message-ID: <202112030528.CvcSEK5l-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt
head:   a2453d618b87ec61000fecf66dee9cbd109e2e50
commit: d7103a390456460fd2b7d93081cd64b3e55c10f9 [7/15] x86: Don't generate ENDBR in .discard.text
config: i386-randconfig-m021-20211202 (https://download.01.org/0day-ci/archive/20211203/202112030528.CvcSEK5l-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=d7103a390456460fd2b7d93081cd64b3e55c10f9
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue x86/wip.ibt
        git checkout d7103a390456460fd2b7d93081cd64b3e55c10f9
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kernel/ arch/x86/mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/setup.c:65:1: warning: 'nocf_check' attribute ignored. Use '-fcf-protection' option to enable it [-Wattributes]
      65 | RESERVE_BRK(dmi_alloc, 65536);
         | ^~~~~~~~~~~
--
>> arch/x86/mm/init.c:178:1: warning: 'nocf_check' attribute ignored. Use '-fcf-protection' option to enable it [-Wattributes]
     178 | RESERVE_BRK(early_pgt_alloc, INIT_PGT_BUF_SIZE);
         | ^~~~~~~~~~~


vim +65 arch/x86/kernel/setup.c

2b72394e4089643 Pekka Enberg                  2009-04-28  63  
e808bae2407a087 Thadeu Lima de Souza Cascardo 2010-02-09  64  #ifdef CONFIG_DMI
796216a57fe45c0 Jeremy Fitzhardinge           2009-03-12 @65  RESERVE_BRK(dmi_alloc, 65536);
e808bae2407a087 Thadeu Lima de Souza Cascardo 2010-02-09  66  #endif
796216a57fe45c0 Jeremy Fitzhardinge           2009-03-12  67  
c0b5842a457d44c Ingo Molnar                   2009-01-27  68  

:::::: The code at line 65 was first introduced by commit
:::::: 796216a57fe45c04adc35bda1f0782efec78a713 x86: allow extend_brk users to reserve brk space

:::::: TO: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
:::::: CC: H. Peter Anvin <hpa@zytor.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
