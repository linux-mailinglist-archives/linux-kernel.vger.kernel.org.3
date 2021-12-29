Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A97748172E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 23:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhL2WF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 17:05:27 -0500
Received: from mga14.intel.com ([192.55.52.115]:14727 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229575AbhL2WFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 17:05:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640815521; x=1672351521;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=n55eWpPn5O4rIROz1VDeacgNhdUtxl3KIOXH/qv/94M=;
  b=dx2YvHP2py5swpQov5ss7XRIqENXMVFOquWGJ2/R6yF7wWQErqBZv7Hm
   0hg/sweA6FWTozDE6wm9rQ0cmIrAL8Bktv3rV021XPelnVISw4hTLT56R
   hlzY1AT5TgKS207Z3DaZgrrIlsrao0jlon3eBqXHWyV94lIpI4oaOLSWO
   xvpLiU377bWaOwDUMazeR4JXpV3OXNwc8eJjEn+Ig+AeUnHqV16zc+P8k
   l2vwdg7KMk/2EzM3zww4Voowgzz2Oia76pX2+Tr8JK1X3cCyDmxFdvcQR
   x3aM7F0xsZ/pn23mNBSkt4xN06aAlhuIOACgmUoFuxwybo7kfjAZ/KL+0
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="241787375"
X-IronPort-AV: E=Sophos;i="5.88,246,1635231600"; 
   d="scan'208";a="241787375"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 14:05:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,246,1635231600"; 
   d="scan'208";a="486711411"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 29 Dec 2021 14:05:19 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2h4R-0009SE-22; Wed, 29 Dec 2021 22:05:19 +0000
Date:   Thu, 30 Dec 2021 06:04:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mark:linkage/alias-rework 2/8] arch/xtensa/kernel/mcount.S:83:
 Error: unaligned entry instruction
Message-ID: <202112300547.oqIE3cf0-lkp@intel.com>
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
head:   e490cb2dd79a6c276e2c3830804b84c518fdce0a
commit: fad3ef6e27bd6b593355e7b6e0d88b523266e1cb [2/8] linkage: add SYM_{ENTRY,START,END}_AT()
config: xtensa-randconfig-m031-20211228 (https://download.01.org/0day-ci/archive/20211230/202112300547.oqIE3cf0-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=fad3ef6e27bd6b593355e7b6e0d88b523266e1cb
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark linkage/alias-rework
        git checkout fad3ef6e27bd6b593355e7b6e0d88b523266e1cb
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
