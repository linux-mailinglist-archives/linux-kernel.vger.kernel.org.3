Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950DB46828F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 07:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbhLDF6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 00:58:04 -0500
Received: from mga03.intel.com ([134.134.136.65]:57475 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230083AbhLDF6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 00:58:03 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="237038640"
X-IronPort-AV: E=Sophos;i="5.87,286,1631602800"; 
   d="scan'208";a="237038640"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 21:54:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,286,1631602800"; 
   d="scan'208";a="541837346"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 03 Dec 2021 21:54:37 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtO0L-000IXd-2P; Sat, 04 Dec 2021 05:54:37 +0000
Date:   Sat, 4 Dec 2021 13:53:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mark:linkage/alias-rework 1/5] arch/xtensa/kernel/mcount.S:83:
 Error: unaligned entry instruction
Message-ID: <202112041345.PfJaTqQU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git linkage/alias-rework
head:   237447148f41ca99a7b980037060b7a6f3afe535
commit: 2d97e9dfa461e64eb9c641fc1b6d4f077caa652f [1/5] linkage: add SYM_{ENTRY,START,END}_AT()
config: xtensa-randconfig-r005-20211203 (https://download.01.org/0day-ci/archive/20211204/202112041345.PfJaTqQU-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=2d97e9dfa461e64eb9c641fc1b6d4f077caa652f
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark linkage/alias-rework
        git checkout 2d97e9dfa461e64eb9c641fc1b6d4f077caa652f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash arch/xtensa/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/xtensa/kernel/mcount.S: Assembler messages:
>> arch/xtensa/kernel/mcount.S:83: Error: unaligned entry instruction


vim +83 arch/xtensa/kernel/mcount.S

478ba61afccd3a Max Filippov 2013-05-24  81  
478ba61afccd3a Max Filippov 2013-05-24  82  ENTRY(ftrace_stub)
d6d5f19e21d98c Max Filippov 2019-05-12 @83  	abi_entry_default

:::::: The code at line 83 was first introduced by commit
:::::: d6d5f19e21d98c0607ff029e4e2e508d4cdd1d5a xtensa: abstract 'entry' and 'retw' in assembly code

:::::: TO: Max Filippov <jcmvbkbc@gmail.com>
:::::: CC: Max Filippov <jcmvbkbc@gmail.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
