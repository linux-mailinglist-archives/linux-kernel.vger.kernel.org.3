Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7047C5834C1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 23:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236374AbiG0VNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 17:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiG0VNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 17:13:04 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670F74B4AA;
        Wed, 27 Jul 2022 14:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658956383; x=1690492383;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HJc/rY+H6mWEpjZOCYuB/wZU/zZ6wQtxR/IUmxdYdw8=;
  b=LC/BeAxBV3A2f8TV+BNPautRlnSwXY3i2nMSxPW2Vnh65+FXhvhJyGdv
   0NzTDCwUYZWsF5hlcpwDj9e6RVetOunUU/yTlA32lefLx2fk+JjnXkEt5
   BZq95LKX7Rfw4abb1/1JjqwbTsHBUnlwS2HK5mRlRVhnW4DtAr0pX91RE
   3jz+d1WBBFaqhbNeyUpNTkGe3XsTu5EaUg4OV+PD3SYt9yb/b9rgKoy7W
   AwL1OFzkqmgHucVzEbmKokUSB6BOlMqA92WHpBGVeiNuVY9596srOx37q
   PxIPg9wPdLimyfmaV2bptkCTrw4/wEl7i5pFDzXyInUz5vzJno2cP13RG
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="285896266"
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="285896266"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 14:12:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="742804666"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jul 2022 14:12:55 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGoKt-00097K-0F;
        Wed, 27 Jul 2022 21:12:55 +0000
Date:   Thu, 28 Jul 2022 05:12:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH] rcu: Display registers of self-detected stall as far as
 possible
Message-ID: <202207280520.yvgjXjJx-lkp@intel.com>
References: <20220727060929.1149-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727060929.1149-1-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhen,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on paulmck-rcu/dev]
[also build test ERROR on linus/master v5.19-rc8 next-20220727]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhen-Lei/rcu-Display-registers-of-self-detected-stall-as-far-as-possible/20220727-141107
base:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220728/202207280520.yvgjXjJx-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 8dfaecc4c24494337933aff9d9166486ca0949f1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9f3fe5a0e46546db5bcfd1f33f12d87339e5de98
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Zhen-Lei/rcu-Display-registers-of-self-detected-stall-as-far-as-possible/20220727-141107
        git checkout 9f3fe5a0e46546db5bcfd1f33f12d87339e5de98
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/rcu/tree.c:4641:
>> kernel/rcu/tree_stall.h:358:10: error: call to undeclared function 'get_irq_regs'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   regs = get_irq_regs();
                          ^
>> kernel/rcu/tree_stall.h:358:8: error: incompatible integer to pointer conversion assigning to 'struct pt_regs *' from 'int' [-Wint-conversion]
                   regs = get_irq_regs();
                        ^ ~~~~~~~~~~~~~~
   2 errors generated.


vim +/get_irq_regs +358 kernel/rcu/tree_stall.h

   352	
   353	static void rcu_dump_cpu_task(int cpu)
   354	{
   355		if (cpu == smp_processor_id() && in_irq()) {
   356			struct pt_regs *regs;
   357	
 > 358			regs = get_irq_regs();
   359			if (regs) {
   360				show_regs(regs);
   361				return;
   362			}
   363		}
   364	
   365		dump_cpu_task(cpu);
   366	}
   367	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
