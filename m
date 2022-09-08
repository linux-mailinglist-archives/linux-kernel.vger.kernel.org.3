Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04BB5B2864
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 23:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiIHVTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 17:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiIHVTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:19:37 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B60E193C7
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 14:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662671974; x=1694207974;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hPK/Pv0LGYyLuxyhio+4Qw0tsqTk3tEa/oIwXYx8sWg=;
  b=Fr88ZCaabgdRT1N7cs769qFmVdzIiE5wD81oiyBJ/6czBVKp9HxB58tP
   XQq732ZuCJgdL6mbAeTdtE7+FocHGh18ulPGCw61LAldSgtkDJ4FAiooy
   hjPXrW+3B8Dae81XdcM79mIMDhM1emdTu4zjzaUQz/f4L2XxZtIORJjoP
   udi7SpsYVibTmp1VjqiT4E8OJjJyS+xc60idwCBG73iXcErD8y3JC9ZGU
   JLRz7GvbXEIWztdgNzyWoN2U5OvrLFZOeMjTmAgfiFYxkwBcMZ9o9+7ut
   5bmFN0wZrAQUisQ0OFGmgNM2SoTH4DdU81qiH7VKEi4FK0bQsWf7f/9XW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="277715687"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="277715687"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 14:19:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="566108806"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 08 Sep 2022 14:19:31 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWOvq-0000KL-0R;
        Thu, 08 Sep 2022 21:19:30 +0000
Date:   Fri, 9 Sep 2022 05:18:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdso: fix NULL deference in vdso_join_timens() when vfork
Message-ID: <202209090531.SgtAsnCi-lkp@intel.com>
References: <20220907165831.457-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907165831.457-1-jszhang@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.0-rc4]
[cannot apply to next-20220908]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jisheng-Zhang/vdso-fix-NULL-deference-in-vdso_join_timens-when-vfork/20220908-011001
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 0066f1b0e27556381402db3ff31f85d2a2265858
config: riscv-randconfig-r012-20220907 (https://download.01.org/0day-ci/archive/20220909/202209090531.SgtAsnCi-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 1546df49f5a6d09df78f569e4137ddb365a3e827)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/247635b442c42937dc9f0c0a04711fb3f86df2a9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jisheng-Zhang/vdso-fix-NULL-deference-in-vdso_join_timens-when-vfork/20220908-011001
        git checkout 247635b442c42937dc9f0c0a04711fb3f86df2a9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/riscv/kernel/vdso.c:158:10: error: use of undeclared identifier 'rv_compat_vdso_maps'
                   .dm = &rv_compat_vdso_maps[RV_VDSO_MAP_VVAR],
                          ^
   arch/riscv/kernel/vdso.c:159:10: error: use of undeclared identifier 'rv_compat_vdso_maps'
                   .cm = &rv_compat_vdso_maps[RV_VDSO_MAP_VDSO],
                          ^
   2 errors generated.


vim +/rv_compat_vdso_maps +158 arch/riscv/kernel/vdso.c

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
