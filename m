Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00574496DEE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 21:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiAVUQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 15:16:15 -0500
Received: from mga17.intel.com ([192.55.52.151]:47675 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230262AbiAVUQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 15:16:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642882565; x=1674418565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6cDpzKEP+djJhWstrzK5T9awOgBJZ4bZORnAZis/OM4=;
  b=gDZtnwTqzSQY4ZNzoH9oq7fL10Wjwhy5svhj0oaBpn1yDieAxzuY8ebK
   wa7a1rWyIMkiKcoCB+TjsuNkV/95S/71YbjU7lDfKfcCpyTv0ufXy+jr+
   19AWEAx0UZK4gg3cn1LliNHquwxt6vOnC6Pnm1+j4RvJv9MkFmFOvcOA7
   0PPRSDywoGr98NvO3P6a6vIA7vyIueATiWqgYKhFh5YrMRbTuPbBsuAob
   EZo8UhN1pIfeJQJ4JZlzB+Ftc6+bFAjPdIXZ09iAhfIW8hUydGAFfhChj
   LwN39cgZHdzGE6rJXj2+08j4bqnR0Ec9goP2X2qM8t4devxoHR+Pv/fQV
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10235"; a="226521608"
X-IronPort-AV: E=Sophos;i="5.88,308,1635231600"; 
   d="scan'208";a="226521608"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2022 12:16:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,308,1635231600"; 
   d="scan'208";a="531709586"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 22 Jan 2022 12:16:03 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBMnq-000GjN-Co; Sat, 22 Jan 2022 20:16:02 +0000
Date:   Sun, 23 Jan 2022 04:15:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Michael T. Kloos" <michael@michaelkloos.com>,
        paul.walmsley@sifive.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Michael T. Kloos" <michael@michaelkloos.com>
Subject: Re: [PATCH] Fixed: Misaligned memory access.  Fixed pointer
 comparison.
Message-ID: <202201230123.GN7Kvrlq-lkp@intel.com>
References: <20220120233427.262098-1-michael@michaelkloos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120233427.262098-1-michael@michaelkloos.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Michael,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.16 next-20220121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Michael-T-Kloos/Fixed-Misaligned-memory-access-Fixed-pointer-comparison/20220121-074148
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2c271fe77d52a0555161926c232cd5bc07178b39
config: riscv-randconfig-r021-20220120 (https://download.01.org/0day-ci/archive/20220123/202201230123.GN7Kvrlq-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 7b3d30728816403d1fd73cc5082e9fb761262bce)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/0day-ci/linux/commit/c1930afcc76babc4e2313f67d0fe103a26f07712
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Michael-T-Kloos/Fixed-Misaligned-memory-access-Fixed-pointer-comparison/20220121-074148
        git checkout c1930afcc76babc4e2313f67d0fe103a26f07712
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/riscv/lib/memmove.S:113:16: error: operand must be a symbol with %lo/%pcrel_lo/%tprel_lo modifier or an integer in the range [-2048, 2047]
    1: jalr zero, (t0)
                  ^


vim +113 arch/riscv/lib/memmove.S

     8	
     9	SYM_FUNC_START(__memmove)
    10	SYM_FUNC_START_ALIAS(memmove)
    11		/*
    12		 * Returns
    13		 *   a0 - dest
    14		 *
    15		 * Parameters
    16		 *   a0 - Inclusive first byte of dest
    17		 *   a1 - Inclusive first byte of src
    18		 *   a2 - Length of copy
    19		 *
    20		 * Because the return matches the parameter register a0,
    21		 * we will not clobber or modify that register.
    22		 */
    23	
    24		/* Return if nothing to do */
    25		beq a0, a1, exit_memmove
    26		beqz a2, exit_memmove
    27	
    28		/*
    29		 * Register Uses
    30		 *   a3 - Inclusive first multibyte of src
    31		 *   a4 - Non-inclusive last multibyte of src
    32		 *   a5 - Non-inclusive last byte of src
    33		 *
    34		 * During the copy
    35		 *      Forward Copy: a1 - Index counter of src
    36		 *      Reverse Copy: a5 - Index counter of src
    37		 *   Both Copy Modes: t2 - Index counter of dest
    38		 *   Both Copy Modes: t1 - Temporary for load-store
    39		 *   Both Copy Modes: t0 - Link
    40		 */
    41	
    42		/*
    43		 * Solve for last byte now.  We will solve the rest when
    44		 * they are needed for the copy because either byte copy
    45		 * does not require any of the others (Wasted effort if
    46		 * byte copy gets used) or we do not yet have enough
    47		 * information to solve them.
    48		 */
    49		add  a5, a1, a2
    50	
    51		/*
    52		 * Byte copy if copying less than SZREG bytes.
    53		 * This can cause problems with the bulk copy
    54		 * implementation below and is small enough not
    55		 * to bother.
    56		 */
    57		andi t0, a2, -SZREG
    58		beqz t0, byte_copy
    59	
    60		/* Determine the maximum granularity of co-alignment. */
    61		xor  t0, a0, a1
    62	#if   SZREG >= 8
    63		andi t1, t0, 0x7
    64		beqz t1, doubleword_copy
    65	#endif
    66		andi t1, t0, 0x3
    67		beqz t1, word_copy
    68		andi t1, t0, 0x1
    69		beqz t1, halfword_copy
    70		/* Fall through to byte copy if nothing larger is found. */
    71	
    72	byte_copy:
    73		bltu a1, a0, byte_copy_reverse
    74	
    75	byte_copy_forward:
    76		add  t2, a0, zero
    77	byte_copy_fw_callin:
    78		beq  a1, a5, exit_memmove
    79		lb   t1, (a1)
    80		sb   t1, (t2)
    81		addi a1, a1, 1
    82		addi t2, t2, 1
    83		j byte_copy_fw_callin
    84	
    85	byte_copy_reverse:
    86		add  t2, a0, a2
    87	byte_copy_rv_callin:
    88		beq  a1, a5, exit_memmove
    89		addi a5, a5, -1
    90		addi t2, t2, -1
    91		lb   t1, (a5)
    92		sb   t1, (t2)
    93		j byte_copy_rv_callin
    94	
    95	exit_memmove:
    96		ret
    97	
    98	copy_bytes_until_aligned_fw:
    99		beq  a1, a3, 1f /* Reuse the return from the other copy loop */
   100		lb   t1, (a1)
   101		sb   t1, (t2)
   102		addi a1, a1, 1
   103		addi t2, t2, 1
   104		j copy_bytes_until_aligned_fw
   105	
   106	copy_bytes_until_aligned_rv:
   107		beq  a4, a5, 1f
   108		addi a5, a5, -1
   109		addi t2, t2, -1
   110		lb   t1, (a5)
   111		sb   t1, (t2)
   112		j copy_bytes_until_aligned_rv
 > 113		1: jalr zero, (t0) /* Return */
   114	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
