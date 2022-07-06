Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528F6569654
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 01:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbiGFXi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 19:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbiGFXi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 19:38:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3532725
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 16:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657150705; x=1688686705;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QAZsvJf1BerwqsqDWfz9Ex516FwclGK3+0CKzld2eyU=;
  b=kvEv3/1OOt+k0Z4z5VdISLGb/ZWq7D5PZr7UFdWBNtMGLZhqImNuGjW4
   CyCK3dJa7eQ8Fz+q4NYzOZ9KpGai1FrG49EQQxZlZI9gWDfZPy352iw7G
   CZEzcpLwDz7gkmYW59st/pPDFn0Ju0+yzV8jD6uObnQy9NabfYfx37/US
   J6EWU/4qYsdYfZiDMkHiVLzX5747g4mDHxjkJ/YQg61xDTLeVsRvYgNUE
   SSQ6LJwmccUW0MfzGg46ZdC/YuF8jllmelYvXPhDbFx2na0FEcdOgyZrI
   NeNDuixAvxfhY4/ES2zlBerjBQm+ypGhyBKzy26csUEHkC0Go61liNPqn
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="272683635"
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="272683635"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 16:38:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="593525909"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 06 Jul 2022 16:38:15 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9Eb0-000LG5-Nu;
        Wed, 06 Jul 2022 23:38:14 +0000
Date:   Thu, 7 Jul 2022 07:38:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Conor Dooley <mail@conchuod.ie>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Zong Li <zong.li@sifive.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Jonas Hahnfeld <hahnjo@hahnjo.de>, Guo Ren <guoren@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Changbin Du <changbin.du@intel.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Brice Goglin <Brice.Goglin@inria.fr>
Subject: Re: [PATCH] riscv: arch-topology: fix default topology reporting
Message-ID: <202207070728.MiQn5fv0-lkp@intel.com>
References: <20220706184558.2557301-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706184558.2557301-1-mail@conchuod.ie>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

I love your patch! Yet something to improve:

[auto build test ERROR on b6f1f2fa2bddd69ff46a190b8120bd440fd50563]

url:    https://github.com/intel-lab-lkp/linux/commits/Conor-Dooley/riscv-arch-topology-fix-default-topology-reporting/20220707-024856
base:   b6f1f2fa2bddd69ff46a190b8120bd440fd50563
config: riscv-randconfig-r042-20220706 (https://download.01.org/0day-ci/archive/20220707/202207070728.MiQn5fv0-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f553287b588916de09c66e3e32bf75e5060f967f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/824f4c3cb56ada865e6e3b14457c0582fa255cbf
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Conor-Dooley/riscv-arch-topology-fix-default-topology-reporting/20220707-024856
        git checkout 824f4c3cb56ada865e6e3b14457c0582fa255cbf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/riscv/kernel/topology.c:17:37: error: use of undeclared identifier 'cpu_topology'
           struct cpu_topology *cpuid_topo = &cpu_topology[cpuid];
                                              ^
>> arch/riscv/kernel/topology.c:31:2: error: call to undeclared function 'update_siblings_masks'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           update_siblings_masks(cpuid);
           ^
   2 errors generated.


vim +/cpu_topology +17 arch/riscv/kernel/topology.c

    14	
    15	void store_cpu_topology(unsigned int cpuid)
    16	{
  > 17		struct cpu_topology *cpuid_topo = &cpu_topology[cpuid];
    18	
    19		if (cpuid_topo->package_id != -1)
    20			goto topology_populated;
    21	
    22		cpuid_topo->thread_id = -1;
    23		cpuid_topo->core_id = cpuid;
    24		cpuid_topo->package_id = cpu_to_node(cpuid);
    25	
    26		pr_debug("CPU%u: package %d core %d thread %d\n",
    27			 cpuid, cpuid_topo->package_id, cpuid_topo->core_id,
    28			 cpuid_topo->thread_id);
    29	
    30	topology_populated:
  > 31		update_siblings_masks(cpuid);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
