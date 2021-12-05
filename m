Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719D7468937
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 06:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhLEFVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 00:21:50 -0500
Received: from mga05.intel.com ([192.55.52.43]:26687 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230086AbhLEFVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 00:21:48 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10188"; a="323417422"
X-IronPort-AV: E=Sophos;i="5.87,288,1631602800"; 
   d="scan'208";a="323417422"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2021 21:18:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,288,1631602800"; 
   d="scan'208";a="514280619"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 04 Dec 2021 21:18:20 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtjul-000Jpx-R5; Sun, 05 Dec 2021 05:18:19 +0000
Date:   Sun, 5 Dec 2021 13:17:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mark:linkage/alias-rework 5/5]
 arch/x86/crypto/aesni-intel_asm.S:1755: Error: no such instruction:
 `sym_func_start_local_alias(_key_expansion_128)'
Message-ID: <202112051321.BwUtDKGE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git linkage/alias-rework
head:   bd779ad653870d718d0df57731b1637dae509337
commit: bd779ad653870d718d0df57731b1637dae509337 [5/5] linkage: remove START/END ALIAS macros
config: x86_64-randconfig-a001-20211203 (https://download.01.org/0day-ci/archive/20211205/202112051321.BwUtDKGE-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=bd779ad653870d718d0df57731b1637dae509337
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark linkage/alias-rework
        git checkout bd779ad653870d718d0df57731b1637dae509337
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/crypto/aesni-intel_asm.S: Assembler messages:
>> arch/x86/crypto/aesni-intel_asm.S:1755: Error: no such instruction: `sym_func_start_local_alias(_key_expansion_128)'
>> arch/x86/crypto/aesni-intel_asm.S:1767: Error: invalid character '(' in mnemonic


vim +1755 arch/x86/crypto/aesni-intel_asm.S

0bd82f5f635577 Tadeusz Struk  2010-11-04  1753  
0bd82f5f635577 Tadeusz Struk  2010-11-04  1754  
e9b9d020c4873d Jiri Slaby     2019-10-11 @1755  SYM_FUNC_START_LOCAL_ALIAS(_key_expansion_128)
74d8b90a889022 Jiri Slaby     2019-10-11  1756  SYM_FUNC_START_LOCAL(_key_expansion_256a)
54b6a1bd5364ac Huang Ying     2009-01-18  1757  	pshufd $0b11111111, %xmm1, %xmm1
54b6a1bd5364ac Huang Ying     2009-01-18  1758  	shufps $0b00010000, %xmm0, %xmm4
54b6a1bd5364ac Huang Ying     2009-01-18  1759  	pxor %xmm4, %xmm0
54b6a1bd5364ac Huang Ying     2009-01-18  1760  	shufps $0b10001100, %xmm0, %xmm4
54b6a1bd5364ac Huang Ying     2009-01-18  1761  	pxor %xmm4, %xmm0
54b6a1bd5364ac Huang Ying     2009-01-18  1762  	pxor %xmm1, %xmm0
0d258efb6a58fe Mathias Krause 2010-11-27  1763  	movaps %xmm0, (TKEYP)
0d258efb6a58fe Mathias Krause 2010-11-27  1764  	add $0x10, TKEYP
54b6a1bd5364ac Huang Ying     2009-01-18  1765  	ret
74d8b90a889022 Jiri Slaby     2019-10-11  1766  SYM_FUNC_END(_key_expansion_256a)
e9b9d020c4873d Jiri Slaby     2019-10-11 @1767  SYM_FUNC_END_ALIAS(_key_expansion_128)
54b6a1bd5364ac Huang Ying     2009-01-18  1768  

:::::: The code at line 1755 was first introduced by commit
:::::: e9b9d020c4873d5e90d9986cfd137afbafbc5bfa x86/asm: Annotate aliases

:::::: TO: Jiri Slaby <jslaby@suse.cz>
:::::: CC: Borislav Petkov <bp@suse.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
