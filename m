Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BD55AD6D7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238430AbiIEPtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbiIEPth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:49:37 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B1CBE2E;
        Mon,  5 Sep 2022 08:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662392974; x=1693928974;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j4dSqL5ePx7/RgmSjVnwY1XTrQJDptROJraA9QiwKZo=;
  b=cJviAoSe1FeewcYUkdmYPBKDsq1s66nmr68wV9uk8T5QYrW5pgkDHIVR
   GWu9gjTkfCfdj51+vkVY3825+OnEYizxAwsrytoy/mWOOAYNiscbtmWE8
   898TGfZQJL93JzTemy2c1uNVVEHYgzJ+dWOQ2ZhydA0SCfCbRY2kYNXYS
   cQuKO76fE1o545fgKMURS/roqLVktpztLtoUfdfU0ucT2KKYCzorwlH2Z
   JQtSbU5TuzZ0uvQWX7tECaeVJq+ISyGsnyxhUu81jcxI5wAVjsXWGc2Dl
   H8zkb8Mov2YqK2ZswRTDnVQkDzhC2ITecSyj9C1qRVpE1dFkPglkyYMNS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="294000823"
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="294000823"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 08:49:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="702933706"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Sep 2022 08:49:32 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVELr-0004IN-3C;
        Mon, 05 Sep 2022 15:49:31 +0000
Date:   Mon, 5 Sep 2022 23:48:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] kbuild: move -Wundef from KBUILD_CFLAGS to
 KBUILD_CPPFLAGS
Message-ID: <202209052329.sY4Fx2fi-lkp@intel.com>
References: <20220905083619.672091-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905083619.672091-2-masahiroy@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

I love your patch! Perhaps something to improve:

[auto build test WARNING on masahiroy-kbuild/for-next]
[also build test WARNING on linus/master v6.0-rc4]
[cannot apply to next-20220901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Masahiro-Yamada/kbuild-move-Werror-from-KBUILD_CFLAGS-to-KBUILD_CPPFLAGS/20220905-164209
base:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git for-next
config: riscv-randconfig-r042-20220905 (https://download.01.org/0day-ci/archive/20220905/202209052329.sY4Fx2fi-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c55b41d5199d2394dd6cdb8f52180d8b81d809d4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/2f8ee1865d7d00ad27460d94056c7752cad8481f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Masahiro-Yamada/kbuild-move-Werror-from-KBUILD_CFLAGS-to-KBUILD_CPPFLAGS/20220905-164209
        git checkout 2f8ee1865d7d00ad27460d94056c7752cad8481f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/riscv/kernel/head.S:329:5: warning: 'CONFIG_RISCV_BOOT_SPINWAIT' is not defined, evaluates to 0 [-Wundef]
   #if CONFIG_RISCV_BOOT_SPINWAIT
       ^
   1 warning generated.


vim +/CONFIG_RISCV_BOOT_SPINWAIT +329 arch/riscv/kernel/head.S

76d2a0493a17d4 Palmer Dabbelt    2017-07-10  316  
76d4467a97bd8c Qiu Wenbo         2020-08-13  317  	call setup_trap_vector
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  318  	/* Restore C environment */
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  319  	la tp, init_task
c637b911e06697 Christoph Hellwig 2019-04-15  320  	la sp, init_thread_union + THREAD_SIZE
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  321  
8ad8b72721d0f0 Nick Hu           2020-01-06  322  #ifdef CONFIG_KASAN
8ad8b72721d0f0 Nick Hu           2020-01-06  323  	call kasan_early_init
8ad8b72721d0f0 Nick Hu           2020-01-06  324  #endif
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  325  	/* Start the kernel */
335b139057ef79 Damien Le Moal    2020-03-16  326  	call soc_early_init
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  327  	tail start_kernel
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  328  
2ffc48fc7071da Atish Patra       2022-01-20 @329  #if CONFIG_RISCV_BOOT_SPINWAIT
0b39eb38f85908 Atish Patra       2022-01-20  330  .Lsecondary_start:
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  331  	/* Set trap vector to spin forever to help debug */
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  332  	la a3, .Lsecondary_park
a4c3733d32a72f Christoph Hellwig 2019-10-28  333  	csrw CSR_TVEC, a3
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  334  
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  335  	slli a3, a0, LGREG
c78f94f35cf648 Atish Patra       2022-01-20  336  	la a1, __cpu_spinwait_stack_pointer
44c922572952d8 Vitaly Wool       2021-04-13  337  	XIP_FIXUP_OFFSET a1
c78f94f35cf648 Atish Patra       2022-01-20  338  	la a2, __cpu_spinwait_task_pointer
44c922572952d8 Vitaly Wool       2021-04-13  339  	XIP_FIXUP_OFFSET a2
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  340  	add a1, a3, a1
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  341  	add a2, a3, a2
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  342  
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  343  	/*
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  344  	 * This hart didn't win the lottery, so we wait for the winning hart to
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  345  	 * get far enough along the boot process that it should continue.
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  346  	 */
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  347  .Lwait_for_cpu_up:
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  348  	/* FIXME: We should WFI to save some energy here. */
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  349  	REG_L sp, (a1)
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  350  	REG_L tp, (a2)
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  351  	beqz sp, .Lwait_for_cpu_up
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  352  	beqz tp, .Lwait_for_cpu_up
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  353  	fence
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  354  
153c46faf6ae49 Jisheng Zhang     2021-11-29  355  	tail .Lsecondary_start_common
2ffc48fc7071da Atish Patra       2022-01-20  356  #endif /* CONFIG_RISCV_BOOT_SPINWAIT */
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  357  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
