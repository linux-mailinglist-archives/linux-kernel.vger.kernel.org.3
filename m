Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BFD513E91
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 00:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352898AbiD1Whu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 18:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236003AbiD1Whq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 18:37:46 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0232BF945
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 15:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651185270; x=1682721270;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5Xaif9XTCLVj9HMqW7PV8obS8KjvJ3OUPUcIY2cWs4U=;
  b=i0paNuGSZXnEfzWGGezoIgvFK4jR+G4i0YFGhZqus1JD0Bn9a8qR7wuL
   krl9IpMNM0/eBKq4Ewo3wfq5W062BXURsASTPxijpNN58M70IWhQ6ediZ
   imLLr4yAMrVAemeCwSc+b10hv+O8ok9F6YiGwat2K49ce7ht5rhMTm0Wi
   kBOh5bUq0rQ8DKl/fOCCZ4l52mGwZVQAtAYU6mltV9nfNUDQaVXqhnZug
   4ajLmw5hF2aZ47OMpTok8Bx9oVAVa6MvfbKMr3+Nol1PDGCVqoGUZpazM
   5Rzo2qHncfvUP6+bKj9A0DsdqIb6lnD0ZZX7H+Tbu9gipRRwLykB/mNDM
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="329388635"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="329388635"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 15:34:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="597008914"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 28 Apr 2022 15:34:28 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkCiR-0005k1-S9;
        Thu, 28 Apr 2022 22:34:27 +0000
Date:   Fri, 29 Apr 2022 06:33:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: fs/proc/vmcore.c:443:42: warning: unused variable 'vmcore_mmap_ops'
Message-ID: <202204290642.I2dLZBgO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   249aca0d3d631660aa3583c6a3559b75b6e971b4
commit: 5640975003d0234da08559677e22ec25b9cb3267 RISC-V: Add crash kernel support
date:   1 year ago
config: riscv-randconfig-c006-20220428 (https://download.01.org/0day-ci/archive/20220429/202204290642.I2dLZBgO-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c59473aacce38cd7dd77eebceaf3c98c5707ab3b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5640975003d0234da08559677e22ec25b9cb3267
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 5640975003d0234da08559677e22ec25b9cb3267
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/proc/vmcore.c:443:42: warning: unused variable 'vmcore_mmap_ops' [-Wunused-const-variable]
   static const struct vm_operations_struct vmcore_mmap_ops = {
                                            ^
   8 warnings generated.


vim +/vmcore_mmap_ops +443 fs/proc/vmcore.c

9cb218131de1c59 Michael Holzheu 2013-09-11  442  
9cb218131de1c59 Michael Holzheu 2013-09-11 @443  static const struct vm_operations_struct vmcore_mmap_ops = {
9cb218131de1c59 Michael Holzheu 2013-09-11  444  	.fault = mmap_vmcore_fault,
9cb218131de1c59 Michael Holzheu 2013-09-11  445  };
9cb218131de1c59 Michael Holzheu 2013-09-11  446  

:::::: The code at line 443 was first introduced by commit
:::::: 9cb218131de1c59dca9063b2efe876f053f316af vmcore: introduce remap_oldmem_pfn_range()

:::::: TO: Michael Holzheu <holzheu@linux.vnet.ibm.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
