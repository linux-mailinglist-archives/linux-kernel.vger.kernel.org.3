Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C4352F8EC
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 07:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348056AbiEUFbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 01:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiEUFbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 01:31:37 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7229554A7
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 22:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653111094; x=1684647094;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pp3WYBxYIXv2CWVlcuu3e3VMZaw3NZhSkcaGgRnzNKM=;
  b=c8p4X23GYH3kzKJWVNWtvbv1o26LMGlmhVUL4QCRcNIn9Lgwomv7ZM2F
   BGmKfFxoisEd3HLDZ8+3RosvngVENT4aVf+w/I6oI8ItIEhQ3TXVHKORw
   4Vo3L4qawJ007iV+k7aO7ik77qJx/c2gnsVOHCTo3ujNnfbeHrhL1usc6
   beX17McVfLHaRHCB5LcIwFBy2XCXGIGGpfcPO/d3KAxQLVP5byUuPJjH0
   yXRbFsekF0mKslCvkhy62U0CvyL0JiyG6z9h3RVYU0Qslnj0mFkhyLL8N
   1YOC/ylGwRJnelU5CmsygaP1gIlAfoRBiHedqljJm6Ocg+8pv3O6oo5oZ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="254861577"
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="254861577"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 22:31:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="607337678"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 20 May 2022 22:31:30 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsHi6-0005yM-1w;
        Sat, 21 May 2022 05:31:30 +0000
Date:   Sat, 21 May 2022 13:31:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peng Wu <wupeng58@huawei.com>, maz@kernel.org, james.morse@arm.com,
        alexandru.elisei@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc:     kbuild-all@lists.01.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        liwei391@huawei.com, yuehaibing@huawei.com, wupeng58@huawei.com
Subject: Re: [PATCH] KVM: arm64: cancel the return value check of
 kvm_arm_init_sve()
Message-ID: <202205211307.MWDiBNQS-lkp@intel.com>
References: <20220520084911.44253-1-wupeng58@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520084911.44253-1-wupeng58@huawei.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on kvmarm/next]
[also build test ERROR on v5.18-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Peng-Wu/KVM-arm64-cancel-the-return-value-check-of-kvm_arm_init_sve/20220520-165501
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git next
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220521/202205211307.MWDiBNQS-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/4f7983bee8e912289335be279fb1f0a0abd6b31b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Peng-Wu/KVM-arm64-cancel-the-return-value-check-of-kvm_arm_init_sve/20220520-165501
        git checkout 4f7983bee8e912289335be279fb1f0a0abd6b31b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/arm64/kvm/reset.c:46:6: error: conflicting types for 'kvm_arm_init_sve'; have 'void(void)'
      46 | void kvm_arm_init_sve(void)
         |      ^~~~~~~~~~~~~~~~
   In file included from include/linux/kvm_host.h:45,
                    from arch/arm64/kvm/reset.c:13:
   arch/arm64/include/asm/kvm_host.h:70:5: note: previous declaration of 'kvm_arm_init_sve' with type 'int(void)'
      70 | int kvm_arm_init_sve(void);
         |     ^~~~~~~~~~~~~~~~


vim +46 arch/arm64/kvm/reset.c

    45	
  > 46	void kvm_arm_init_sve(void)
    47	{
    48		if (system_supports_sve()) {
    49			kvm_sve_max_vl = sve_max_virtualisable_vl();
    50	
    51			/*
    52			 * The get_sve_reg()/set_sve_reg() ioctl interface will need
    53			 * to be extended with multiple register slice support in
    54			 * order to support vector lengths greater than
    55			 * VL_ARCH_MAX:
    56			 */
    57			if (WARN_ON(kvm_sve_max_vl > VL_ARCH_MAX))
    58				kvm_sve_max_vl = VL_ARCH_MAX;
    59	
    60			/*
    61			 * Don't even try to make use of vector lengths that
    62			 * aren't available on all CPUs, for now:
    63			 */
    64			if (kvm_sve_max_vl < sve_max_vl())
    65				pr_warn("KVM: SVE vector length for guests limited to %u bytes\n",
    66					kvm_sve_max_vl);
    67		}
    68	}
    69	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
