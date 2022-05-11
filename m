Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B66523649
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245204AbiEKOzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245187AbiEKOyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:54:53 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09E020CA53
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652280892; x=1683816892;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CxZ8DWGT3126lXFzulen/UfD8p/GQnRhvlXVPw4+no4=;
  b=l3DEbZIZmUV2dIE+G11N2FGTKdiswi2TjcvNWIiqWdA27c/xhK39kt99
   JxO+iZTyJoxxP5HdCuKMiZ6StS3q31fraNNiofkan4TGNLNZZLfG0xTXs
   OiP2SFteYRDmZo/S2IOUXRu509IJ0aLGRsViF9jrjq0o+4H8C1UBDOqjF
   VKRlaZpPzsrTcUZe8GM4NLhuDidUHJpULcqe4Oi3Uvk19dejTTA7uAItn
   O4z2D8qdV+lXmOMGu96YuXTShoD3Sc3lTrXjTvrUlphciKMDFFxQwX+8+
   oSBThtcFxbloVBQNPlPy3Hvzontq2tBZbz2Z/BahpkgLfzOit6oe1iq2K
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="269852108"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="269852108"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 07:54:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="602968674"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 11 May 2022 07:54:50 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nonjl-000JDE-H4;
        Wed, 11 May 2022 14:54:49 +0000
Date:   Wed, 11 May 2022 22:54:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Greentime Hu <greentime.hu@sifive.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH v10 08/16] riscv: Add task switch support for vector
Message-ID: <202205112214.QkYvxlUq-lkp@intel.com>
References: <3f544b952369e55f72a8771d0bec387c2ff49ae0.1652257230.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f544b952369e55f72a8771d0bec387c2ff49ae0.1652257230.git.greentime.hu@sifive.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20220511/202205112214.QkYvxlUq-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/dcb5b4bc0fc33bba0eb3219b9a8d29ddff58bbef
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Greentime-Hu/riscv-Add-vector-ISA-support/20220511-163610
        git checkout dcb5b4bc0fc33bba0eb3219b9a8d29ddff58bbef
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/riscv/kernel/process.c:149:6: warning: no previous prototype for 'arch_release_task_struct' [-Wmissing-prototypes]
     149 | void arch_release_task_struct(struct task_struct *tsk)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~


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
