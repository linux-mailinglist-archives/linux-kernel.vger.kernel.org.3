Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A1C55A941
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 13:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbiFYLIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 07:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbiFYLIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 07:08:07 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50C42937C
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 04:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656155285; x=1687691285;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Hcy8DWwyI6xhh+fL0gNBRQNP/QN1ASLNj0xyXAsEqjM=;
  b=H4Nbj2jxVDxsz2PgYd1CVSLlakubTTNkwwaNdhMYMn4hkCiyZBLp7IRv
   nfLGTYim4Anw2TpwBNEb7lbieix0iaWwDUnTdaDw3ZiI/ePdaFAQO8epl
   Q0+aOYrvcHjjc2i/Z/IWyWmn/t+55xkI/18IzQPa0dWjs6497pO+sSCjI
   b9cvzIm6McU/dOyB9SYOVNrf8wP9kzGFveMv0kTTEgUOlyMhkCLh0Op9T
   FmuxHu3kt/n/5NcFidRnbqEf4/cE7w7BWuLQ0tp2VjuHInBvSiVj+o50K
   qkk+RVYQzp6HG4ucnoeMgzF13tTNNEc5O03K+8PP1nK7TG5JQaZ4HNaqF
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="261592956"
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="261592956"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 04:08:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="656996027"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 25 Jun 2022 04:08:04 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o53dz-0005fv-U4;
        Sat, 25 Jun 2022 11:08:03 +0000
Date:   Sat, 25 Jun 2022 19:07:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [alobakin:bitops 8/9] include/asm-generic/percpu.h:21:44: warning:
 array subscript 4 is above array bounds of 'long unsigned int[4]'
Message-ID: <202206251907.ub7v6PxL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/alobakin/linux bitops
head:   3d9705b33014389e95ff8ac2eeadd081934aa571
commit: 45be1aaa8e3d90c437780823a2824e53fd13a867 [8/9] bitmap: don't assume compiler evaluates small mem*() builtins calls
config: arc-randconfig-c024-20220625
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/alobakin/linux/commit/45be1aaa8e3d90c437780823a2824e53fd13a867
        git remote add alobakin https://github.com/alobakin/linux
        git fetch --no-tags alobakin bitops
        git checkout 45be1aaa8e3d90c437780823a2824e53fd13a867
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash kernel/sched/ kernel/trace/ mm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/compiler_types.h:93,
                    from <command-line>:
   kernel/sched/topology.c: In function 'build_overlap_sched_groups':
>> include/asm-generic/percpu.h:21:44: warning: array subscript 4 is above array bounds of 'long unsigned int[4]' [-Warray-bounds]
      21 | #define per_cpu_offset(x) (__per_cpu_offset[x])
   include/linux/compiler-gcc.h:35:33: note: in definition of macro 'RELOC_HIDE'
      35 |         (typeof(ptr)) (__ptr + (off));                                  \
         |                                 ^~~
   include/linux/percpu-defs.h:236:9: note: in expansion of macro 'SHIFT_PERCPU_PTR'
     236 |         SHIFT_PERCPU_PTR((ptr), per_cpu_offset((cpu)));                 \
         |         ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:236:33: note: in expansion of macro 'per_cpu_offset'
     236 |         SHIFT_PERCPU_PTR((ptr), per_cpu_offset((cpu)));                 \
         |                                 ^~~~~~~~~~~~~~
   kernel/sched/topology.c:969:20: note: in expansion of macro 'per_cpu_ptr'
     969 |         sg->sgc = *per_cpu_ptr(sdd->sgc, cpu);
         |                    ^~~~~~~~~~~
   In file included from ./arch/arc/include/generated/asm/percpu.h:1,
                    from include/linux/irqflags.h:17,
                    from include/linux/rcupdate.h:26,
                    from include/linux/rculist.h:11,
                    from include/linux/sched/signal.h:5,
                    from include/linux/sched/cputime.h:5,
                    from kernel/sched/build_utility.c:13:
   include/asm-generic/percpu.h:19:22: note: while referencing '__per_cpu_offset'
      19 | extern unsigned long __per_cpu_offset[NR_CPUS];
         |                      ^~~~~~~~~~~~~~~~


vim +21 include/asm-generic/percpu.h

^1da177e4c3f41 Linus Torvalds 2005-04-16  20  
a875a69f8b00a3 Ingo Molnar    2006-07-03 @21  #define per_cpu_offset(x) (__per_cpu_offset[x])
acdac87202a408 travis@sgi.com 2008-01-30  22  #endif
acdac87202a408 travis@sgi.com 2008-01-30  23  

:::::: The code at line 21 was first introduced by commit
:::::: a875a69f8b00a38b4f40d9632a4fc71a159f0e0d [PATCH] lockdep: add per_cpu_offset()

:::::: TO: Ingo Molnar <mingo@elte.hu>
:::::: CC: Linus Torvalds <torvalds@g5.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
