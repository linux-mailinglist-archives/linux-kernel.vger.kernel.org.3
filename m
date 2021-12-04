Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE20F46850C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 14:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344655AbhLDN3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 08:29:19 -0500
Received: from mga07.intel.com ([134.134.136.100]:37982 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229957AbhLDN3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 08:29:18 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="300504617"
X-IronPort-AV: E=Sophos;i="5.87,287,1631602800"; 
   d="scan'208";a="300504617"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2021 05:25:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,287,1631602800"; 
   d="scan'208";a="461264727"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 04 Dec 2021 05:25:51 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtV30-000J2a-I7; Sat, 04 Dec 2021 13:25:50 +0000
Date:   Sat, 4 Dec 2021 21:25:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mark:linkage/alias-rework 5/5] arch/x86/lib/memset_64.S:27:
 multiple definition of `memset'; mm/kasan/shadow.o:mm/kasan/shadow.c:43:
 first defined here
Message-ID: <202112042133.KForMaM9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git linkage/alias-rework
head:   237447148f41ca99a7b980037060b7a6f3afe535
commit: 237447148f41ca99a7b980037060b7a6f3afe535 [5/5] x86: remove SYM_FUNC_START_WEAK()
config: x86_64-randconfig-m001-20211203 (https://download.01.org/0day-ci/archive/20211204/202112042133.KForMaM9-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=237447148f41ca99a7b980037060b7a6f3afe535
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark linkage/alias-rework
        git checkout 237447148f41ca99a7b980037060b7a6f3afe535
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: arch/x86/lib/memset_64.o: in function `__memset':
>> arch/x86/lib/memset_64.S:27: multiple definition of `memset'; mm/kasan/shadow.o:mm/kasan/shadow.c:43: first defined here


vim +27 arch/x86/lib/memset_64.S

8d379dad8f1670d arch/x86_64/lib/memset.S Jan Beulich     2006-09-26   8  
^1da177e4c3f415 arch/x86_64/lib/memset.S Linus Torvalds  2005-04-16   9  /*
2f19e06ac30771c arch/x86/lib/memset_64.S Fenghua Yu      2011-05-17  10   * ISO C memset - set a memory block to a byte value. This function uses fast
2f19e06ac30771c arch/x86/lib/memset_64.S Fenghua Yu      2011-05-17  11   * string to get better performance than the original function. The code is
6a6256f9e0ebaab arch/x86/lib/memset_64.S Adam Buchbinder 2016-02-23  12   * simpler and shorter than the original function as well.
^1da177e4c3f415 arch/x86_64/lib/memset.S Linus Torvalds  2005-04-16  13   *
^1da177e4c3f415 arch/x86_64/lib/memset.S Linus Torvalds  2005-04-16  14   * rdi   destination
^1da177e4c3f415 arch/x86_64/lib/memset.S Linus Torvalds  2005-04-16  15   * rsi   value (char)
^1da177e4c3f415 arch/x86_64/lib/memset.S Linus Torvalds  2005-04-16  16   * rdx   count (bytes)
^1da177e4c3f415 arch/x86_64/lib/memset.S Linus Torvalds  2005-04-16  17   *
^1da177e4c3f415 arch/x86_64/lib/memset.S Linus Torvalds  2005-04-16  18   * rax   original destination
^1da177e4c3f415 arch/x86_64/lib/memset.S Linus Torvalds  2005-04-16  19   */
6dcc5627f6aec4c arch/x86/lib/memset_64.S Jiri Slaby      2019-10-11  20  SYM_FUNC_START(__memset)
84d95ad4cb9015e arch/x86/lib/memset_64.S Borislav Petkov 2015-02-04  21  	/*
84d95ad4cb9015e arch/x86/lib/memset_64.S Borislav Petkov 2015-02-04  22  	 * Some CPUs support enhanced REP MOVSB/STOSB feature. It is recommended
84d95ad4cb9015e arch/x86/lib/memset_64.S Borislav Petkov 2015-02-04  23  	 * to use it when possible. If not available, use fast string instructions.
84d95ad4cb9015e arch/x86/lib/memset_64.S Borislav Petkov 2015-02-04  24  	 *
84d95ad4cb9015e arch/x86/lib/memset_64.S Borislav Petkov 2015-02-04  25  	 * Otherwise, use original memset function.
84d95ad4cb9015e arch/x86/lib/memset_64.S Borislav Petkov 2015-02-04  26  	 */
84d95ad4cb9015e arch/x86/lib/memset_64.S Borislav Petkov 2015-02-04 @27  	ALTERNATIVE_2 "jmp memset_orig", "", X86_FEATURE_REP_GOOD, \
84d95ad4cb9015e arch/x86/lib/memset_64.S Borislav Petkov 2015-02-04  28  		      "jmp memset_erms", X86_FEATURE_ERMS
84d95ad4cb9015e arch/x86/lib/memset_64.S Borislav Petkov 2015-02-04  29  
8d379dad8f1670d arch/x86_64/lib/memset.S Jan Beulich     2006-09-26  30  	movq %rdi,%r9
5d7244e7c984cec arch/x86/lib/memset_64.S Jan Beulich     2012-01-05  31  	movq %rdx,%rcx
5d7244e7c984cec arch/x86/lib/memset_64.S Jan Beulich     2012-01-05  32  	andl $7,%edx
5d7244e7c984cec arch/x86/lib/memset_64.S Jan Beulich     2012-01-05  33  	shrq $3,%rcx
8d379dad8f1670d arch/x86_64/lib/memset.S Jan Beulich     2006-09-26  34  	/* expand byte value  */
8d379dad8f1670d arch/x86_64/lib/memset.S Jan Beulich     2006-09-26  35  	movzbl %sil,%esi
8d379dad8f1670d arch/x86_64/lib/memset.S Jan Beulich     2006-09-26  36  	movabs $0x0101010101010101,%rax
5d7244e7c984cec arch/x86/lib/memset_64.S Jan Beulich     2012-01-05  37  	imulq %rsi,%rax
8d379dad8f1670d arch/x86_64/lib/memset.S Jan Beulich     2006-09-26  38  	rep stosq
5d7244e7c984cec arch/x86/lib/memset_64.S Jan Beulich     2012-01-05  39  	movl %edx,%ecx
8d379dad8f1670d arch/x86_64/lib/memset.S Jan Beulich     2006-09-26  40  	rep stosb
8d379dad8f1670d arch/x86_64/lib/memset.S Jan Beulich     2006-09-26  41  	movq %r9,%rax
8d379dad8f1670d arch/x86_64/lib/memset.S Jan Beulich     2006-09-26  42  	ret
6dcc5627f6aec4c arch/x86/lib/memset_64.S Jiri Slaby      2019-10-11  43  SYM_FUNC_END(__memset)
784d5699eddc558 arch/x86/lib/memset_64.S Al Viro         2016-01-11  44  EXPORT_SYMBOL(__memset)
8d379dad8f1670d arch/x86_64/lib/memset.S Jan Beulich     2006-09-26  45  

:::::: The code at line 27 was first introduced by commit
:::::: 84d95ad4cb9015ea953bf14cea05ba371d4d42bb x86/lib/memset_64.S: Convert to ALTERNATIVE_2 macro

:::::: TO: Borislav Petkov <bp@suse.de>
:::::: CC: Borislav Petkov <bp@suse.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
