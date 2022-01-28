Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A4949F966
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 13:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348473AbiA1MbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 07:31:23 -0500
Received: from mga03.intel.com ([134.134.136.65]:25085 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348447AbiA1MbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 07:31:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643373082; x=1674909082;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0hgtHcXWkT4mXYTnIOz0FL8Ag79iS4KwXPEHaBfTZH0=;
  b=jVx3BiFs/PsGYnnSmR5HpkiCGYIRdG1POGbA4aCfFvtPCKZaIBgEVkiG
   t13GpLLiW/iEob7F8O3bxQIqm1wlJOxmXf2Mr/HyNog0WidYrIGNIy8EI
   oQZQKcVu0I88qXd7UstzQzI78WRxE4xrU6JCHPcb9ckxBi4B9Ga0qyxAh
   /KW+luARB3wOYnWlUEGNi2WPSf4xgCMBKEpUbE64f9k14J87RebEof7mU
   R/9vn/qs+EVqE6OWjPX0zBkcwwKopK2HLcyxvHUE14bykt1MKZ5pLKaif
   igS/a4Wgax7v9JWeu3yiNJIC+p7j9iGigQWyYKKZcQ1Y1mRoXyTKF3nbU
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="247059199"
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="247059199"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 04:31:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="770098068"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jan 2022 04:31:20 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDQPP-000Nr6-LT; Fri, 28 Jan 2022 12:31:19 +0000
Date:   Fri, 28 Jan 2022 20:30:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/mm/ptdump/hashpagetable.c:264:29: sparse: sparse:
 restricted __be64 degrades to integer
Message-ID: <202201282005.bbjaq1tc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   23a46422c56144939c091c76cf389aa863ce9c18
commit: e084728393a58e7fdafeee2e6b20e0faff09b557 powerpc/ptdump: Convert powerpc to GENERIC_PTDUMP
date:   5 months ago
config: powerpc64-randconfig-s032-20220128 (https://download.01.org/0day-ci/archive/20220128/202201282005.bbjaq1tc-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e084728393a58e7fdafeee2e6b20e0faff09b557
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e084728393a58e7fdafeee2e6b20e0faff09b557
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/mm/ptdump/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/powerpc/mm/ptdump/hashpagetable.c:264:29: sparse: sparse: restricted __be64 degrades to integer
   arch/powerpc/mm/ptdump/hashpagetable.c:265:49: sparse: sparse: restricted __be64 degrades to integer
>> arch/powerpc/mm/ptdump/hashpagetable.c:267:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] @@     got restricted __be64 [usertype] v @@
   arch/powerpc/mm/ptdump/hashpagetable.c:267:36: sparse:     expected unsigned long long [usertype]
   arch/powerpc/mm/ptdump/hashpagetable.c:267:36: sparse:     got restricted __be64 [usertype] v
>> arch/powerpc/mm/ptdump/hashpagetable.c:268:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] @@     got restricted __be64 [usertype] r @@
   arch/powerpc/mm/ptdump/hashpagetable.c:268:36: sparse:     expected unsigned long long [usertype]
   arch/powerpc/mm/ptdump/hashpagetable.c:268:36: sparse:     got restricted __be64 [usertype] r

vim +264 arch/powerpc/mm/ptdump/hashpagetable.c

1515ab93215625 arch/powerpc/mm/dump_hashpagetable.c   Rashmica Gupta   2016-05-27  238  
1515ab93215625 arch/powerpc/mm/dump_hashpagetable.c   Rashmica Gupta   2016-05-27  239  static int pseries_find(unsigned long ea, int psize, bool primary, u64 *v, u64 *r)
1515ab93215625 arch/powerpc/mm/dump_hashpagetable.c   Rashmica Gupta   2016-05-27  240  {
1515ab93215625 arch/powerpc/mm/dump_hashpagetable.c   Rashmica Gupta   2016-05-27  241  	struct hash_pte ptes[4];
1515ab93215625 arch/powerpc/mm/dump_hashpagetable.c   Rashmica Gupta   2016-05-27  242  	unsigned long vsid, vpn, hash, hpte_group, want_v;
1515ab93215625 arch/powerpc/mm/dump_hashpagetable.c   Rashmica Gupta   2016-05-27  243  	int i, j, ssize = mmu_kernel_ssize;
1515ab93215625 arch/powerpc/mm/dump_hashpagetable.c   Rashmica Gupta   2016-05-27  244  	long lpar_rc = 0;
1515ab93215625 arch/powerpc/mm/dump_hashpagetable.c   Rashmica Gupta   2016-05-27  245  	unsigned long shift = mmu_psize_defs[psize].shift;
1515ab93215625 arch/powerpc/mm/dump_hashpagetable.c   Rashmica Gupta   2016-05-27  246  
1515ab93215625 arch/powerpc/mm/dump_hashpagetable.c   Rashmica Gupta   2016-05-27  247  	/* calculate hash */
1515ab93215625 arch/powerpc/mm/dump_hashpagetable.c   Rashmica Gupta   2016-05-27  248  	vsid = get_kernel_vsid(ea, ssize);
1515ab93215625 arch/powerpc/mm/dump_hashpagetable.c   Rashmica Gupta   2016-05-27  249  	vpn  = hpt_vpn(ea, vsid, ssize);
1515ab93215625 arch/powerpc/mm/dump_hashpagetable.c   Rashmica Gupta   2016-05-27  250  	hash = hpt_hash(vpn, shift, ssize);
1515ab93215625 arch/powerpc/mm/dump_hashpagetable.c   Rashmica Gupta   2016-05-27  251  	want_v = hpte_encode_avpn(vpn, psize, ssize);
1515ab93215625 arch/powerpc/mm/dump_hashpagetable.c   Rashmica Gupta   2016-05-27  252  
1515ab93215625 arch/powerpc/mm/dump_hashpagetable.c   Rashmica Gupta   2016-05-27  253  	/* to check in the secondary hash table, we invert the hash */
1515ab93215625 arch/powerpc/mm/dump_hashpagetable.c   Rashmica Gupta   2016-05-27  254  	if (!primary)
1515ab93215625 arch/powerpc/mm/dump_hashpagetable.c   Rashmica Gupta   2016-05-27  255  		hash = ~hash;
1531cff44b5bb3 arch/powerpc/mm/dump_hashpagetable.c   Aneesh Kumar K.V 2018-06-29  256  	hpte_group = (hash & htab_hash_mask) * HPTES_PER_GROUP;
1515ab93215625 arch/powerpc/mm/dump_hashpagetable.c   Rashmica Gupta   2016-05-27  257  	/* see if we can find an entry in the hpte with this hash */
1515ab93215625 arch/powerpc/mm/dump_hashpagetable.c   Rashmica Gupta   2016-05-27  258  	for (i = 0; i < HPTES_PER_GROUP; i += 4, hpte_group += 4) {
1515ab93215625 arch/powerpc/mm/dump_hashpagetable.c   Rashmica Gupta   2016-05-27  259  		lpar_rc = plpar_pte_read_4(0, hpte_group, (void *)ptes);
1515ab93215625 arch/powerpc/mm/dump_hashpagetable.c   Rashmica Gupta   2016-05-27  260  
7c466b0807960e arch/powerpc/mm/ptdump/hashpagetable.c Christophe Leroy 2020-06-15  261  		if (lpar_rc)
1515ab93215625 arch/powerpc/mm/dump_hashpagetable.c   Rashmica Gupta   2016-05-27  262  			continue;
1515ab93215625 arch/powerpc/mm/dump_hashpagetable.c   Rashmica Gupta   2016-05-27  263  		for (j = 0; j < 4; j++) {
1515ab93215625 arch/powerpc/mm/dump_hashpagetable.c   Rashmica Gupta   2016-05-27 @264  			if (HPTE_V_COMPARE(ptes[j].v, want_v) &&
1515ab93215625 arch/powerpc/mm/dump_hashpagetable.c   Rashmica Gupta   2016-05-27  265  					(ptes[j].v & HPTE_V_VALID)) {
1515ab93215625 arch/powerpc/mm/dump_hashpagetable.c   Rashmica Gupta   2016-05-27  266  				/* HPTE matches */
1515ab93215625 arch/powerpc/mm/dump_hashpagetable.c   Rashmica Gupta   2016-05-27 @267  				*v = ptes[j].v;
1515ab93215625 arch/powerpc/mm/dump_hashpagetable.c   Rashmica Gupta   2016-05-27 @268  				*r = ptes[j].r;
1515ab93215625 arch/powerpc/mm/dump_hashpagetable.c   Rashmica Gupta   2016-05-27  269  				return 0;
1515ab93215625 arch/powerpc/mm/dump_hashpagetable.c   Rashmica Gupta   2016-05-27  270  			}
1515ab93215625 arch/powerpc/mm/dump_hashpagetable.c   Rashmica Gupta   2016-05-27  271  		}
1515ab93215625 arch/powerpc/mm/dump_hashpagetable.c   Rashmica Gupta   2016-05-27  272  	}
1515ab93215625 arch/powerpc/mm/dump_hashpagetable.c   Rashmica Gupta   2016-05-27  273  	return -1;
1515ab93215625 arch/powerpc/mm/dump_hashpagetable.c   Rashmica Gupta   2016-05-27  274  }
1515ab93215625 arch/powerpc/mm/dump_hashpagetable.c   Rashmica Gupta   2016-05-27  275  

:::::: The code at line 264 was first introduced by commit
:::::: 1515ab932156257afd8a5864506dab80f63ff38b powerpc/mm: Dump hash table

:::::: TO: Rashmica Gupta <rashmicy@gmail.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
