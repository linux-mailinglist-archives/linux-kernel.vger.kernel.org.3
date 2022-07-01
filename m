Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC8A563892
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 19:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiGAR1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 13:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiGAR07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 13:26:59 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5DD35DFB
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 10:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656696419; x=1688232419;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vck+4XbfKzgiBiwFSWO94G/QusWXFYDCXSQdw3JT4zY=;
  b=ENHFa4UhpbU90DUwMW2BB+/+r6KvFXqrhQUcKoOS/xA9BD4fulsRUvBQ
   aEPXY0QHY/Ih7x2R//BeXBI4JCp7XZclOtBzoRvgfGI3Gmf16C0JcoLYg
   NU3D7q6e4Ui+l2L1/iLIyI5fHHohY4AXqkFCDT3SWNTizU40HRmNJQimk
   v0ZEkNj+MUbGDyP0iBI1tHFKcaxyRLcUNYRF+3i2Q/rqhrxA9fuRQ/iez
   Z89DFD8Ic2cPatGk7aOOzEq29LADbbbSh8C9bxi1vF6ZyzVPGmM2weu/K
   gsZdjSgnzuEMKdQcIc+Al7NDuUJTfXl5ns0d/DC12S1MFF2zYv+evMQGk
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="281465882"
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="281465882"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 10:26:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="596332334"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 01 Jul 2022 10:26:57 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7KPw-000EBu-Fp;
        Fri, 01 Jul 2022 17:26:56 +0000
Date:   Sat, 2 Jul 2022 01:26:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yupeng Li <liyupeng@zbhlos.com>, fweisbec@gmail.com,
        tglx@linutronix.de, mingo@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, caizp2008@163.com,
        linux-kernel@vger.kernel.org, Yupeng Li <liyupeng@zbhlos.com>
Subject: Re: [PATCH 1/1] timers/nohz: fix build with CONFIG_NO_HZ_FULL
 warnning.
Message-ID: <202207020130.RZbvd92n-lkp@intel.com>
References: <20220701033647.911334-1-liyupeng@zbhlos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701033647.911334-1-liyupeng@zbhlos.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yupeng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/timers/nohz]
[also build test WARNING on linus/master v5.19-rc4 next-20220701]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Yupeng-Li/timers-nohz-fix-build-with-CONFIG_NO_HZ_FULL-warnning/20220701-114723
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 09fe880ed7a160ebbffb84a0a9096a075e314d2f
config: x86_64-randconfig-k001 (https://download.01.org/0day-ci/archive/20220702/202207020130.RZbvd92n-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a9119143a2d1f4d0d0bc1fe0d819e5351b4e0deb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d7397dd311be292d170c1fbd0f3bdc5104c06849
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yupeng-Li/timers-nohz-fix-build-with-CONFIG_NO_HZ_FULL-warnning/20220701-114723
        git checkout d7397dd311be292d170c1fbd0f3bdc5104c06849
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0x19a091): Section mismatch in reference from the function tick_nohz_full_setup() to the function .init.text:alloc_bootmem_cpumask_var()
The function tick_nohz_full_setup() references
the function __init alloc_bootmem_cpumask_var().
This is often because tick_nohz_full_setup lacks a __init
annotation or the annotation of alloc_bootmem_cpumask_var is wrong.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
