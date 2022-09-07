Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803935B0FE8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 00:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiIGWjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 18:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIGWjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 18:39:46 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D813920BCD
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 15:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662590384; x=1694126384;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u54noPh3UJK+FX3vhqTKecLP1gkZmovHd5fX22CdVUs=;
  b=Ube0zt08Om8Pe4OVifDjOWCZNduLwyLz5y6AVUtI8YE7SpOQUGhkFELt
   MdENyRj/A7J6uLPZ3BH2dzrrhzWFz0qiIVo1GSdO8xUWydnIijZK3GZju
   EKPC6jf69xJmd8MJHPu7GfN4Yshi8Gl8tNmzkyVTRcAuN9uQ2ygKp3VkE
   P4gUoKvAn4TkKX2MTKob13EBulT/+pPsbM6GjSlhveMr9n+atVk9izVpn
   w+3zfAEs8Mwqby6YXdPDUFeq+UIDfeZzgVsyb80mLDJN1QgdoBcJKAGUD
   5LWutJr0R2whRFvt2jKxR3pxKw+9Uo2rl4bDFIOePUcbAAo9e9efpPa9P
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="280045269"
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="280045269"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 15:39:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="565703478"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 07 Sep 2022 15:39:34 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oW3hl-000722-1d;
        Wed, 07 Sep 2022 22:39:33 +0000
Date:   Thu, 8 Sep 2022 06:38:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdso: fix NULL deference in vdso_join_timens() when vfork
Message-ID: <202209080625.DOtyS4G0-lkp@intel.com>
References: <20220907165831.457-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907165831.457-1-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.0-rc4]
[cannot apply to next-20220907]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jisheng-Zhang/vdso-fix-NULL-deference-in-vdso_join_timens-when-vfork/20220908-011001
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 0066f1b0e27556381402db3ff31f85d2a2265858
config: riscv-randconfig-r006-20220907 (https://download.01.org/0day-ci/archive/20220908/202209080625.DOtyS4G0-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/247635b442c42937dc9f0c0a04711fb3f86df2a9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jisheng-Zhang/vdso-fix-NULL-deference-in-vdso_join_timens-when-vfork/20220908-011001
        git checkout 247635b442c42937dc9f0c0a04711fb3f86df2a9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/riscv/kernel/vdso.c:158:24: error: 'rv_compat_vdso_maps' undeclared here (not in a function); did you mean 'rv_vdso_maps'?
     158 |                 .dm = &rv_compat_vdso_maps[RV_VDSO_MAP_VVAR],
         |                        ^~~~~~~~~~~~~~~~~~~
         |                        rv_vdso_maps
   arch/riscv/kernel/vdso.c:165:34: warning: 'rv_compat_vdso_maps' defined but not used [-Wunused-variable]
     165 | static struct vm_special_mapping rv_compat_vdso_maps[] __ro_after_init = {
         |                                  ^~~~~~~~~~~~~~~~~~~


vim +158 arch/riscv/kernel/vdso.c

   144	
   145	static struct __vdso_info vdso_info[] __ro_after_init = {
   146		[VDSO_ABI_RV64] = {
   147			.name = "vdso",
   148			.vdso_code_start = vdso_start,
   149			.vdso_code_end = vdso_end,
   150			.dm = &rv_vdso_maps[RV_VDSO_MAP_VVAR],
   151			.cm = &rv_vdso_maps[RV_VDSO_MAP_VDSO],
   152		},
   153	#ifdef CONFIG_COMPAT
   154		[VDSO_ABI_RV32] = {
   155			.name = "compat_vdso",
   156			.vdso_code_start = compat_vdso_start,
   157			.vdso_code_end = compat_vdso_end,
 > 158			.dm = &rv_compat_vdso_maps[RV_VDSO_MAP_VVAR],
   159			.cm = &rv_compat_vdso_maps[RV_VDSO_MAP_VDSO],
   160		},
   161	#endif
   162	};
   163	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
