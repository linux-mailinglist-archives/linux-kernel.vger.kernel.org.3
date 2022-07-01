Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAED563996
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 21:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiGATJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 15:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiGATJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 15:09:05 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027C73AA51
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 12:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656702543; x=1688238543;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0uGCuF379RS82NhV0F88IdWA9IGH3LNU3IMBNYsgfsk=;
  b=TyG2MKw477f1d2yaR0HLJfkKXeGwv6k/4eS5x/CAd4iO1PdOStV28KcX
   LfW2aw5erswTgfPGLIX5XUO1CCx/Z8m38iKt2MUtPZftrBmIdSVH4SsXV
   X9AQ3GVZv4O5HPzEl/RLT5dcWpU/vlT5WXk8LJ0mgM9cD2hoAxsEgAlQ5
   erKZlpUTGBfl//tK8IssBStq4uKDSzV50zb+IthQORQqa+TxKcJOsyoMp
   CXwoXOlnpm6veKdcZv2CE9n1uzBwhz+Ho8RAikd71ZEPcqNKZ88JL+kLE
   +795f/6CCth6pNz3arjRyvoTl+4IyhfS4iz8xTRuiLWreRlzac9hz1NNf
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="271497024"
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="271497024"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 12:09:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="838154558"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 01 Jul 2022 12:09:00 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7M0h-000EGw-VO;
        Fri, 01 Jul 2022 19:08:59 +0000
Date:   Sat, 2 Jul 2022 03:08:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yupeng Li <liyupeng@zbhlos.com>, fweisbec@gmail.com,
        tglx@linutronix.de, mingo@kernel.org
Cc:     kbuild-all@lists.01.org, caizp2008@163.com,
        linux-kernel@vger.kernel.org, Yupeng Li <liyupeng@zbhlos.com>
Subject: Re: [PATCH 1/1] timers/nohz: fix build with CONFIG_NO_HZ_FULL
 warnning.
Message-ID: <202207020218.PMbzdwKY-lkp@intel.com>
References: <20220701033647.911334-1-liyupeng@zbhlos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701033647.911334-1-liyupeng@zbhlos.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220702/202207020218.PMbzdwKY-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/d7397dd311be292d170c1fbd0f3bdc5104c06849
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yupeng-Li/timers-nohz-fix-build-with-CONFIG_NO_HZ_FULL-warnning/20220701-114723
        git checkout d7397dd311be292d170c1fbd0f3bdc5104c06849
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0x5b7f13): Section mismatch in reference from the function tick_nohz_full_setup() to the function .init.text:alloc_bootmem_cpumask_var()
The function tick_nohz_full_setup() references
the function __init alloc_bootmem_cpumask_var().
This is often because tick_nohz_full_setup lacks a __init
annotation or the annotation of alloc_bootmem_cpumask_var is wrong.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
