Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE3F51D287
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389687AbiEFHv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 03:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389677AbiEFHvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:51:14 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4747C674ED
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 00:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651823252; x=1683359252;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3A8GZh/NCRmAcPvtj5dIuY1f64clZGOdeTAlOLOkrMI=;
  b=gXTr1phxDTseNofQLf5Eb547WZcy5w0symqN7P7JKTvBQ83IBVtg4ezi
   Qt50Oz6RO4If13Sf24RO/R5ELKZnGX9mNKFLZvnIspw0lvof0M9Z1QhSB
   HqQcbM+8Vs3/mMVJQZ5/iHZ8F4b2UlSmVQH7jl/Jg6gXvJUUxItUBCexp
   phgVQWB8vG9KkCnCeKY/ATOJpvmis/J3HlQCdiuWE6EdAqT1JBO9ra462
   DVgBOn5PZuvdX3pdTlOc6XeKHkhoiVPYQhP4tFTZNl02Eu8PZT5kwEwZX
   4lJRgGUiHnphqpRNhNko2FKDif/xbShNlGXPsNYqfqSa1GBKIJ/EPdP9p
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="255866992"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="255866992"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 00:47:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="568998320"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 06 May 2022 00:47:27 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmsgQ-000DGR-FU;
        Fri, 06 May 2022 07:47:26 +0000
Date:   Fri, 6 May 2022 15:47:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        peterx@redhat.com, Johannes Weiner <hannes@cmpxchg.org>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH] mm: Avoid unnecessary page fault retires on shared
 memory types
Message-ID: <202205061513.jhn9vVtI-lkp@intel.com>
References: <20220505211748.41127-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505211748.41127-1-peterx@redhat.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hnaz-mm/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Xu/mm-Avoid-unnecessary-page-fault-retires-on-shared-memory-types/20220506-051845
base:   https://github.com/hnaz/linux-mm master
config: sparc-defconfig (https://download.01.org/0day-ci/archive/20220506/202205061513.jhn9vVtI-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e5356147afd3824144b605c428f1b892addd11d0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Peter-Xu/mm-Avoid-unnecessary-page-fault-retires-on-shared-memory-types/20220506-051845
        git checkout e5356147afd3824144b605c428f1b892addd11d0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/sparc/mm/fault_32.c: In function 'force_user_fault':
>> arch/sparc/mm/fault_32.c:347:13: error: 'fault' undeclared (first use in this function)
     347 |         if (fault & VM_FAULT_COMPLETED)
         |             ^~~~~
   arch/sparc/mm/fault_32.c:347:13: note: each undeclared identifier is reported only once for each function it appears in


vim +/fault +347 arch/sparc/mm/fault_32.c

   309	
   310	/* This always deals with user addresses. */
   311	static void force_user_fault(unsigned long address, int write)
   312	{
   313		struct vm_area_struct *vma;
   314		struct task_struct *tsk = current;
   315		struct mm_struct *mm = tsk->mm;
   316		unsigned int flags = FAULT_FLAG_USER;
   317		int code;
   318	
   319		code = SEGV_MAPERR;
   320	
   321		mmap_read_lock(mm);
   322		vma = find_vma(mm, address);
   323		if (!vma)
   324			goto bad_area;
   325		if (vma->vm_start <= address)
   326			goto good_area;
   327		if (!(vma->vm_flags & VM_GROWSDOWN))
   328			goto bad_area;
   329		if (expand_stack(vma, address))
   330			goto bad_area;
   331	good_area:
   332		code = SEGV_ACCERR;
   333		if (write) {
   334			if (!(vma->vm_flags & VM_WRITE))
   335				goto bad_area;
   336			flags |= FAULT_FLAG_WRITE;
   337		} else {
   338			if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
   339				goto bad_area;
   340		}
   341		switch (handle_mm_fault(vma, address, flags, NULL)) {
   342		case VM_FAULT_SIGBUS:
   343		case VM_FAULT_OOM:
   344			goto do_sigbus;
   345		}
   346		/* The fault is fully completed (including releasing mmap lock) */
 > 347		if (fault & VM_FAULT_COMPLETED)
   348			return;
   349		mmap_read_unlock(mm);
   350		return;
   351	bad_area:
   352		mmap_read_unlock(mm);
   353		__do_fault_siginfo(code, SIGSEGV, tsk->thread.kregs, address);
   354		return;
   355	
   356	do_sigbus:
   357		mmap_read_unlock(mm);
   358		__do_fault_siginfo(BUS_ADRERR, SIGBUS, tsk->thread.kregs, address);
   359	}
   360	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
