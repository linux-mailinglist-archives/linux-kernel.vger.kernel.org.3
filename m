Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC054D25B2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 02:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiCIBMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiCIBMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:12:00 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB261C8FA1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 16:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646787273; x=1678323273;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=NPF0pt6z5LWkrWSRrj9elClGQie5MKGKO466HTh0Wvs=;
  b=dYCMACUQdiqAFv4fjMRHde5YQtQbx0SpS0FCIKI2A7gghBSCq5H9TO+l
   kmW4VR5z4KcT1h1xVlaJsd9YCFlgA7Wk3fcFYtlb9hsC4NTYVJPBRHa1R
   b7xuQssxnj8gK9ougYtdc6NKAbgSiYRVcP3CZLMvIhcfDiguQZOVA8eIm
   12A414FoehlxWdDvyC82EzJ8jdfomOmNGXcZuc0nPxrpiVq4qqi4D+RUf
   3qkF7d1naFfifnkC6wKFDHKH+AEzGJGjF7QuoI9Evz4bTIyS2p1cRIPNH
   cxa2trCYNu9AyQszrRVBYtYXCXtwPutQyvWDZjoMPD6OnvQsEOQfQquYj
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="254794809"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="254794809"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 16:54:33 -0800
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="643852690"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 16:54:31 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     <kbuild-all@lists.01.org>, <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Linux Memory Management List" <linux-mm@kvack.org>
Subject: Re: include/linux/pgtable.h:257:16: sparse: sparse: cast to non-scalar
References: <202203090359.xgOwYxvo-lkp@intel.com>
Date:   Wed, 09 Mar 2022 08:54:29 +0800
In-Reply-To: <202203090359.xgOwYxvo-lkp@intel.com> (kernel test robot's
        message of "Wed, 9 Mar 2022 03:14:32 +0800")
Message-ID: <87bkyggd2y.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot <lkp@intel.com> writes:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   ea4424be16887a37735d6550cfd0611528dbe5d9
> commit: b99a342d4f11a5455d999b12f5fee42ab6acaf8c NUMA balancing: reduce TLB flush via delaying mapping on hint page fault
> date:   10 months ago
> config: alpha-randconfig-s031-20220308 (https://download.01.org/0day-ci/archive/20220309/202203090359.xgOwYxvo-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 11.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b99a342d4f11a5455d999b12f5fee42ab6acaf8c
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout b99a342d4f11a5455d999b12f5fee42ab6acaf8c
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
>
> sparse warnings: (new ones prefixed by >>)
>    mm/memory.c:949:17: sparse: sparse: context imbalance in 'copy_pte_range' - different lock contexts for basic block
>    mm/memory.c:1629:16: sparse: sparse: context imbalance in '__get_locked_pte' - different lock contexts for basic block
>    mm/memory.c:1678:9: sparse: sparse: context imbalance in 'insert_page' - different lock contexts for basic block
>    mm/memory.c:2180:17: sparse: sparse: context imbalance in 'remap_pte_range' - different lock contexts for basic block
>    mm/memory.c:2436:17: sparse: sparse: context imbalance in 'apply_to_pte_range' - unexpected unlock
>    mm/memory.c:2692:17: sparse: sparse: context imbalance in 'wp_page_copy' - unexpected unlock
>    mm/memory.c:3038:17: sparse: sparse: context imbalance in 'wp_pfn_shared' - unexpected unlock
>    mm/memory.c:3101:19: sparse: sparse: context imbalance in 'do_wp_page' - different lock contexts for basic block
>    mm/memory.c: note: in included file (through include/linux/mm.h, arch/alpha/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
>>> include/linux/pgtable.h:257:16: sparse: sparse: cast to non-scalar
>>> include/linux/pgtable.h:257:16: sparse: sparse: cast from non-scalar
>    mm/memory.c:4660:5: sparse: sparse: context imbalance in 'follow_invalidate_pte' - different lock contexts for basic block
>    mm/memory.c:4781:9: sparse: sparse: context imbalance in 'follow_pfn' - unexpected unlock
>
> vim +257 include/linux/pgtable.h
>
> e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  253  
> 481e980a7c199c include/linux/pgtable.h       Christophe Leroy 2020-06-15  254  #ifndef __HAVE_ARCH_PTEP_GET
> 481e980a7c199c include/linux/pgtable.h       Christophe Leroy 2020-06-15  255  static inline pte_t ptep_get(pte_t *ptep)
> 481e980a7c199c include/linux/pgtable.h       Christophe Leroy 2020-06-15  256  {
> 481e980a7c199c include/linux/pgtable.h       Christophe Leroy 2020-06-15 @257  	return READ_ONCE(*ptep);

The change isn't introduced by the reported commit apparently.  So
there may be some mistake in the 0-Day bisection.

I am not familiar with alpha architecture.  If the pte_t is always
defined as follows for alpha, the atomicity of the operation should be
OK?

  typedef struct { unsigned long pte; } pte_t;

Best Regards,
Huang, Ying

> 481e980a7c199c include/linux/pgtable.h       Christophe Leroy 2020-06-15  258  }
> 481e980a7c199c include/linux/pgtable.h       Christophe Leroy 2020-06-15  259  #endif
> 481e980a7c199c include/linux/pgtable.h       Christophe Leroy 2020-06-15  260  
>
> :::::: The code at line 257 was first introduced by commit
> :::::: 481e980a7c199c5a4634fd7ea308067dd4ba75fa mm: Allow arches to provide ptep_get()
>
> :::::: TO: Christophe Leroy <christophe.leroy@csgroup.eu>
> :::::: CC: Michael Ellerman <mpe@ellerman.id.au>
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
