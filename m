Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E053523B88
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345565AbiEKR3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345546AbiEKR3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:29:07 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63498517C8
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652290146; x=1683826146;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bhnfCNtIOXA3pWntWcwwVfFEZU9diSfyJB8QnfCwTDI=;
  b=hIOyk6lLkVJFdTpwKMJJjGDI9sKeN+8av1myvZezginwyYcI4jjx3Zsw
   VJ6BECV513L45PVxDDXFp/qS59bX1WlwHi22mCQAdhsmdJVWMVUa/eEBo
   U6hoZhkGHIjYev06YGxEUiX3ixWIr8Er/7oi6HVPGMY70HFZAxUfXw04B
   5MDr54V7mX6bifTv25W+xJK8fj7KDgOuwzeCjLqIJMq3VEqHQRA0nLxZH
   KEjOZLfnH17YMWjOD3dV/HRkiId3WFAHv8Qki85E4NGgM0qgE6kGVqeaQ
   ErmjwsoNVbj5hDB1Jye0jnCnrpfEgh7RjP2hojedyqXKZk6Yr/hBPjRdZ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="332801541"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="332801541"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 10:29:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="658250318"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 11 May 2022 10:29:01 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noq8z-000JMm-9E;
        Wed, 11 May 2022 17:29:01 +0000
Date:   Thu, 12 May 2022 01:28:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Greentime Hu <greentime.hu@sifive.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org
Subject: Re: [PATCH v10 08/16] riscv: Add task switch support for vector
Message-ID: <202205120146.F7wGCoud-lkp@intel.com>
References: <3f544b952369e55f72a8771d0bec387c2ff49ae0.1652257230.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f544b952369e55f72a8771d0bec387c2ff49ae0.1652257230.git.greentime.hu@sifive.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greentime,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linux/master]
[also build test WARNING on linus/master v5.18-rc6]
[cannot apply to kees/for-next/execve next-20220511]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Greentime-Hu/riscv-Add-vector-ISA-support/20220511-163610
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git feb9c5e19e913b53cb536a7aa7c9f20107bb51ec
config: riscv-randconfig-r031-20220509 (https://download.01.org/0day-ci/archive/20220512/202205120146.F7wGCoud-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 18dd123c56754edf62c7042dcf23185c3727610f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/dcb5b4bc0fc33bba0eb3219b9a8d29ddff58bbef
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Greentime-Hu/riscv-Add-vector-ISA-support/20220511-163610
        git checkout dcb5b4bc0fc33bba0eb3219b9a8d29ddff58bbef
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/riscv/kernel/process.c:149:6: warning: no previous prototype for function 'arch_release_task_struct' [-Wmissing-prototypes]
   void arch_release_task_struct(struct task_struct *tsk)
        ^
   arch/riscv/kernel/process.c:149:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void arch_release_task_struct(struct task_struct *tsk)
   ^
   static 
   1 warning generated.


vim +/arch_release_task_struct +149 arch/riscv/kernel/process.c

   148	
 > 149	void arch_release_task_struct(struct task_struct *tsk)
   150	{
   151		/* Free the vector context of datap. */
   152		if (has_vector() && tsk->thread.vstate.datap)
   153			kfree(tsk->thread.vstate.datap);
   154	}
   155	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
