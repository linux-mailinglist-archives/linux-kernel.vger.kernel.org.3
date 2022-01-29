Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659994A2A71
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 01:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351897AbiA2AJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 19:09:12 -0500
Received: from mga04.intel.com ([192.55.52.120]:35279 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235611AbiA2AJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 19:09:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643414951; x=1674950951;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/L/Hfv09ye6EfL1N83glkJDzTXpiNiAAHTEY4p7wj7U=;
  b=bXei/i8F309DOur08N/dzXV5d2TyT5gO32UWBSZ/LIPrTDFzy/NJvw93
   ldxEdhaWa6BfCd/1or5GGWuryXyahQXmxQcRuZ7H/hl99/PP1faRcqN5c
   mxkyipuShJIvU0y2XA4T6eqK4+2sSu8Dpqf5Do4qcmHFvn1duXL4qsCHS
   PglFJpXkpBx02Dmd0V8eOn60C45DDPVYak/F3B4uY1DsS/DtwmDWfxS+0
   B7SLRwNdlod4iX/5QcOmLigoAvOkRzktyTxnw5FPAWrNs9Qv+8K58DTH7
   1jGBE90lNqgf3XoNMy+jH+NYVJ+FIWXQClLR/Xa/QeIcVXobgovRb6iLG
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="246061019"
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="246061019"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 16:09:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="536340379"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 28 Jan 2022 16:09:08 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDbIh-000OUT-IQ; Sat, 29 Jan 2022 00:09:07 +0000
Date:   Sat, 29 Jan 2022 08:08:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michel Lespinasse <michel@lespinasse.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, kernel-team@fb.com,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Jerome Glisse <jglisse@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v2 12/35] mm: separate mmap locked assertion from find_vma
Message-ID: <202201290752.GKB0XPLn-lkp@intel.com>
References: <20220128131006.67712-13-michel@lespinasse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128131006.67712-13-michel@lespinasse.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michel,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.17-rc1 next-20220128]
[cannot apply to tip/x86/mm arm64/for-next/core powerpc/next hnaz-mm/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Michel-Lespinasse/Speculative-page-faults/20220128-212122
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 145d9b498fc827b79c1260b4caa29a8e59d4c2b9
config: arm-randconfig-c002-20220124 (https://download.01.org/0day-ci/archive/20220129/202201290752.GKB0XPLn-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 33b45ee44b1f32ffdbc995e6fec806271b4b3ba4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/0day-ci/linux/commit/d9d603df22594c13d340d1036653e0b039f975eb
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Michel-Lespinasse/Speculative-page-faults/20220128-212122
        git checkout d9d603df22594c13d340d1036653e0b039f975eb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> mm/nommu.c:666:24: error: redefinition of 'find_vma'
   struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
                          ^
   include/linux/mm.h:2759:24: note: previous definition is here
   struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
                          ^
   1 error generated.


vim +/find_vma +666 mm/nommu.c

8feae13110d60cc David Howells     2009-01-08  661  
8feae13110d60cc David Howells     2009-01-08  662  /*
8feae13110d60cc David Howells     2009-01-08  663   * look up the first VMA in which addr resides, NULL if none
c1e8d7c6a7a682e Michel Lespinasse 2020-06-08  664   * - should be called with mm->mmap_lock at least held readlocked
8feae13110d60cc David Howells     2009-01-08  665   */
8feae13110d60cc David Howells     2009-01-08 @666  struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
8feae13110d60cc David Howells     2009-01-08  667  {
8feae13110d60cc David Howells     2009-01-08  668  	struct vm_area_struct *vma;
8feae13110d60cc David Howells     2009-01-08  669  
8feae13110d60cc David Howells     2009-01-08  670  	/* check the cache first */
615d6e8756c8714 Davidlohr Bueso   2014-04-07  671  	vma = vmacache_find(mm, addr);
615d6e8756c8714 Davidlohr Bueso   2014-04-07  672  	if (likely(vma))
8feae13110d60cc David Howells     2009-01-08  673  		return vma;
8feae13110d60cc David Howells     2009-01-08  674  
e922c4c5360980b Namhyung Kim      2011-05-24  675  	/* trawl the list (there may be multiple mappings in which addr
8feae13110d60cc David Howells     2009-01-08  676  	 * resides) */
e922c4c5360980b Namhyung Kim      2011-05-24  677  	for (vma = mm->mmap; vma; vma = vma->vm_next) {
8feae13110d60cc David Howells     2009-01-08  678  		if (vma->vm_start > addr)
8feae13110d60cc David Howells     2009-01-08  679  			return NULL;
8feae13110d60cc David Howells     2009-01-08  680  		if (vma->vm_end > addr) {
615d6e8756c8714 Davidlohr Bueso   2014-04-07  681  			vmacache_update(addr, vma);
8feae13110d60cc David Howells     2009-01-08  682  			return vma;
8feae13110d60cc David Howells     2009-01-08  683  		}
8feae13110d60cc David Howells     2009-01-08  684  	}
8feae13110d60cc David Howells     2009-01-08  685  
8feae13110d60cc David Howells     2009-01-08  686  	return NULL;
8feae13110d60cc David Howells     2009-01-08  687  }
8feae13110d60cc David Howells     2009-01-08  688  EXPORT_SYMBOL(find_vma);
8feae13110d60cc David Howells     2009-01-08  689  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
