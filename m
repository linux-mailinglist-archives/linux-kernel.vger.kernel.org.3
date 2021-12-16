Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168B8477433
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhLPOQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:16:10 -0500
Received: from mga03.intel.com ([134.134.136.65]:18329 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229612AbhLPOQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:16:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639664169; x=1671200169;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=621safIb6bZUJucghAaAXD0yFhuNm0A5U0sV7yFBEhU=;
  b=UhuLWU0CQ9+5wqBDn+PndRUoHthqAtzpX4KQORNXtsDvrPOpzNQwRDwE
   5/LjedFOO/EiLemFPO5dJ5QvQxu+NAv9FOo3zoVwdg0LjqO9hjEPcz6B2
   gctfSnYzKCRIXaJ0IqqDo+6Qf1Zl6YHgzNr+Lfam8eo8fW+5oDljrPGi8
   c4JLx/U98S1cA4ELfNsWAD6Vu8IlMZMhIlj0sowCz5kPJPpPwPxnP+MZD
   ZWRH9MW/+hjU+VDtgajjIpRDyDhqrwX7hux3PN1vrzBGCAK+8Gi051Zyo
   mYWd8K2JDklJkLPhVN5rMmTxRPvN+OCBPn5wJm3ddTHoGnNLXSAhmRRL3
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="239450345"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="239450345"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 06:16:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="605535019"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Dec 2021 06:16:07 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxrYE-0003JX-R5; Thu, 16 Dec 2021 14:16:06 +0000
Date:   Thu, 16 Dec 2021 22:15:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lauri Kasanen <cand@gmx.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: arch/mips/lib/uncached.c:50 run_uncached() warn: always true
 condition '(sp >= (9223372036854775808 | ((0) << 59) | (0))) =>
 (s64min-s64max >= s64min)'
Message-ID: <202112162231.WVjq5Lh3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lauri,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2b14864acbaaf03d9c01982e243a84632524c3ac
commit: baec970aa5ba11099ad7a91773350c91fb2113f0 mips: Add N64 machine type
date:   11 months ago
config: mips-randconfig-m031-20211216 (https://download.01.org/0day-ci/archive/20211216/202112162231.WVjq5Lh3-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
arch/mips/lib/uncached.c:50 run_uncached() warn: always true condition '(sp >= (9223372036854775808 | ((0) << 59) | (0))) => (s64min-s64max >= s64min)'
arch/mips/lib/uncached.c:62 run_uncached() warn: always true condition '(lfunc >= (9223372036854775808 | ((0) << 59) | (0))) => (s64min-s64max >= s64min)'
arch/mips/kernel/unaligned.c:347 emulate_load_store_insn() warn: ignoring unreachable code.
arch/mips/kernel/unaligned.c:1136 emulate_load_store_microMIPS() warn: ignoring unreachable code.
arch/mips/kernel/unaligned.c:1402 emulate_load_store_MIPS16e() warn: ignoring unreachable code.
arch/mips/math-emu/dsemul.c:264 mips_dsemul() warn: 'break_math' 33685517 can't fit into 65535 '*(_badinst.halfword[1])'
kernel/bpf/ringbuf.c:334 __bpf_ringbuf_reserve() error: uninitialized symbol 'flags'.

Old smatch warnings:
arch/mips/kernel/unaligned.c:370 emulate_load_store_insn() warn: ignoring unreachable code.
arch/mips/kernel/unaligned.c:433 emulate_load_store_insn() warn: ignoring unreachable code.
arch/mips/kernel/unaligned.c:1158 emulate_load_store_microMIPS() warn: ignoring unreachable code.
arch/mips/kernel/unaligned.c:1200 emulate_load_store_microMIPS() warn: ignoring unreachable code.
arch/mips/kernel/unaligned.c:1426 emulate_load_store_MIPS16e() warn: ignoring unreachable code.
arch/mips/kernel/unaligned.c:1474 emulate_load_store_MIPS16e() warn: ignoring unreachable code.

vim +50 arch/mips/lib/uncached.c

ba5187dbb4b2ea Thiemo Seufer  2005-04-25  22  
ba5187dbb4b2ea Thiemo Seufer  2005-04-25  23  /*
ba5187dbb4b2ea Thiemo Seufer  2005-04-25  24   * FUNC is executed in one of the uncached segments, depending on its
ba5187dbb4b2ea Thiemo Seufer  2005-04-25  25   * original address as follows:
ba5187dbb4b2ea Thiemo Seufer  2005-04-25  26   *
ba5187dbb4b2ea Thiemo Seufer  2005-04-25  27   * 1. If the original address is in CKSEG0 or CKSEG1, then the uncached
ba5187dbb4b2ea Thiemo Seufer  2005-04-25  28   *    segment used is CKSEG1.
ba5187dbb4b2ea Thiemo Seufer  2005-04-25  29   * 2. If the original address is in XKPHYS, then the uncached segment
ba5187dbb4b2ea Thiemo Seufer  2005-04-25  30   *    used is XKPHYS(2).
ba5187dbb4b2ea Thiemo Seufer  2005-04-25  31   * 3. Otherwise it's a bug.
ba5187dbb4b2ea Thiemo Seufer  2005-04-25  32   *
ba5187dbb4b2ea Thiemo Seufer  2005-04-25  33   * The same remapping is done with the stack pointer.  Stack handling
ba5187dbb4b2ea Thiemo Seufer  2005-04-25  34   * works because we don't handle stack arguments or more complex return
ba5187dbb4b2ea Thiemo Seufer  2005-04-25  35   * values, so we can avoid sharing the same stack area between a cached
ba5187dbb4b2ea Thiemo Seufer  2005-04-25  36   * and the uncached mode.
ba5187dbb4b2ea Thiemo Seufer  2005-04-25  37   */
078a55fc824c16 Paul Gortmaker 2013-06-18  38  unsigned long run_uncached(void *func)
ba5187dbb4b2ea Thiemo Seufer  2005-04-25  39  {
ba5187dbb4b2ea Thiemo Seufer  2005-04-25  40  	register long ret __asm__("$2");
ba5187dbb4b2ea Thiemo Seufer  2005-04-25  41  	long lfunc = (long)func, ufunc;
ba5187dbb4b2ea Thiemo Seufer  2005-04-25  42  	long usp;
5b058973d32055 Anders Roxell  2020-12-11  43  	long sp;
5b058973d32055 Anders Roxell  2020-12-11  44  
5b058973d32055 Anders Roxell  2020-12-11  45  	__asm__("move %0, $sp" : "=r" (sp));
ba5187dbb4b2ea Thiemo Seufer  2005-04-25  46  
ba5187dbb4b2ea Thiemo Seufer  2005-04-25  47  	if (sp >= (long)CKSEG0 && sp < (long)CKSEG2)
ba5187dbb4b2ea Thiemo Seufer  2005-04-25  48  		usp = CKSEG1ADDR(sp);
c55197eb549dc0 Yoichi Yuasa   2007-02-06  49  #ifdef CONFIG_64BIT
48ef2626aeecac Andrew Sharp   2007-10-31 @50  	else if ((long long)sp >= (long long)PHYS_TO_XKPHYS(0, 0) &&
48ef2626aeecac Andrew Sharp   2007-10-31  51  		 (long long)sp < (long long)PHYS_TO_XKPHYS(8, 0))
48ef2626aeecac Andrew Sharp   2007-10-31  52  		usp = PHYS_TO_XKPHYS(K_CALG_UNCACHED,
ba5187dbb4b2ea Thiemo Seufer  2005-04-25  53  				     XKPHYS_TO_PHYS((long long)sp));
c55197eb549dc0 Yoichi Yuasa   2007-02-06  54  #endif
ba5187dbb4b2ea Thiemo Seufer  2005-04-25  55  	else {
ba5187dbb4b2ea Thiemo Seufer  2005-04-25  56  		BUG();
ba5187dbb4b2ea Thiemo Seufer  2005-04-25  57  		usp = sp;
ba5187dbb4b2ea Thiemo Seufer  2005-04-25  58  	}
ba5187dbb4b2ea Thiemo Seufer  2005-04-25  59  	if (lfunc >= (long)CKSEG0 && lfunc < (long)CKSEG2)
ba5187dbb4b2ea Thiemo Seufer  2005-04-25  60  		ufunc = CKSEG1ADDR(lfunc);
c55197eb549dc0 Yoichi Yuasa   2007-02-06  61  #ifdef CONFIG_64BIT
48ef2626aeecac Andrew Sharp   2007-10-31 @62  	else if ((long long)lfunc >= (long long)PHYS_TO_XKPHYS(0, 0) &&

:::::: The code at line 50 was first introduced by commit
:::::: 48ef2626aeecac3b160d1aee38ac46d6c3540122 [MIPS] Put cast inside macro instead of all the callers

:::::: TO: Andrew Sharp <andy.sharp@onstor.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
