Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661A4565596
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbiGDMiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbiGDMij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:38:39 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F381115E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656938318; x=1688474318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CXE68/NBCOnjNde66mFZ4mCdRcjLag4srd5W0fNVK4c=;
  b=BoW7tNb6eJycg1zsJqPxub3jXodSXZ5bCSiNZxmAnCWXmVjVi6BfCo4A
   UmPIrP3PQw+WPcZvx0nELUNB5Kr/PhykWPXYRDvZbzrlnezoJvk1D350o
   qYVwivE+A8s0nD9LcgYoIkagVRMW7BB9hUoAU7J/8QVsfHkzMUKK1YFnD
   hBhScBaI7NJavxdA6QX7n+ybcrdbhp8tqqbWgDxZQVwZ7w87WRqwfdh2B
   16ur1fdPTOxFfvAZjaRwHF1z38kGPFV+QhE2/9W61mirczcAUjrksJH/F
   mFN+t/6F8wf+iLNXjpFCCcmPjMtqGHd5GpVXVfkJlDj/A7QKM9hqhURYR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="266145128"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="266145128"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 05:38:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="649585606"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jul 2022 05:38:36 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 264CcZF0021610;
        Mon, 4 Jul 2022 13:38:35 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [lkp@intel.com: [norov:fns 9/23] include/asm-generic/percpu.h:21:44: warning: array subscript 4 is above array bounds of 'long unsigned int[4]']
Date:   Mon,  4 Jul 2022 14:38:18 +0200
Message-Id: <20220704123818.4828-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <Yr+udMjfCFZP7FAs@yury-laptop>
References: <Yr+udMjfCFZP7FAs@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yury Norov <yury.norov@gmail.com>
Date: Fri, 1 Jul 2022 19:33:24 -0700

> Hi Alexander,

Hi!

> 
> I'm working on top of your recent cons bitmap series, and again
> received a bug report from LKP regarding one of you patches. Can
> you please look at this report?
> 
> I tried reproduce it myself, but the build is failed for me:
> arch/arc/kernel/entry.S: Assembler messages:
> arch/arc/kernel/entry.S:280: Error: operand out of range (260 is not between -256 and 255)
> make[2]: *** [scripts/Makefile.build:322: arch/arc/kernel/entry-compact.o] Error 1
> make[2]: *** Waiting for unfinished jobs....
> 
> If you think it's mis-attributed, we should let LKP people know that
> something is wrong on their side.
> 
> Thanks,
> Yury
> 
> ----- Forwarded message from kernel test robot <lkp@intel.com> -----
> 
> Date: Sat, 2 Jul 2022 08:42:59 +0800
> From: kernel test robot <lkp@intel.com>
> To: Yury Norov <yury.norov@gmail.com>
> Cc: kbuild-all@lists.01.org
> Subject: [norov:fns 9/23] include/asm-generic/percpu.h:21:44: warning: array subscript 4 is above array bounds of
> 	'long unsigned int[4]'
> 
> tree:   https://github.com/norov/linux fns
> head:   1df9509fd92a58cb37e9a419235823bbb13367de
> commit: 3e7e5baaaba78075a7f3a57432609e363bf2a486 [9/23] bitmap: don't assume compiler evaluates small mem*() builtins calls
> config: arc-randconfig-r035-20220629 (https://download.01.org/0day-ci/archive/20220702/202207020812.oTFxIVue-lkp@intel.com/config)
> compiler: arc-elf-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/norov/linux/commit/3e7e5baaaba78075a7f3a57432609e363bf2a486
>         git remote add norov https://github.com/norov/linux
>         git fetch --no-tags norov fns
>         git checkout 3e7e5baaaba78075a7f3a57432609e363bf2a486
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash kernel/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/compiler_types.h:93,
>                     from <command-line>:
>    kernel/sched/topology.c: In function 'build_sched_domains':
> >> include/asm-generic/percpu.h:21:44: warning: array subscript 4 is above array bounds of 'long unsigned int[4]' [-Warray-bounds]
>       21 | #define per_cpu_offset(x) (__per_cpu_offset[x])
>    include/linux/compiler-gcc.h:35:33: note: in definition of macro 'RELOC_HIDE'
>       35 |         (typeof(ptr)) (__ptr + (off));                                  \
>          |                                 ^~~
>    include/linux/percpu-defs.h:236:9: note: in expansion of macro 'SHIFT_PERCPU_PTR'
>      236 |         SHIFT_PERCPU_PTR((ptr), per_cpu_offset((cpu)));                 \
>          |         ^~~~~~~~~~~~~~~~
>    include/linux/percpu-defs.h:236:33: note: in expansion of macro 'per_cpu_offset'
>      236 |         SHIFT_PERCPU_PTR((ptr), per_cpu_offset((cpu)));                 \
>          |                                 ^~~~~~~~~~~~~~
>    kernel/sched/topology.c:969:20: note: in expansion of macro 'per_cpu_ptr'
>      969 |         sg->sgc = *per_cpu_ptr(sdd->sgc, cpu);
>          |                    ^~~~~~~~~~~
>    In file included from ./arch/arc/include/generated/asm/percpu.h:1,
>                     from include/linux/irqflags.h:17,
>                     from include/linux/rcupdate.h:26,
>                     from include/linux/rculist.h:11,
>                     from include/linux/sched/signal.h:5,
>                     from include/linux/sched/cputime.h:5,
>                     from kernel/sched/build_utility.c:13:
>    include/asm-generic/percpu.h:19:22: note: while referencing '__per_cpu_offset'
>       19 | extern unsigned long __per_cpu_offset[NR_CPUS];
>          |                      ^~~~~~~~~~~~~~~~

Ah, I've seen that one and tried to reproduce it hardly, but didn't
manage to do that. Then I took a look at the code mentioned here,
but again couldn't find any code pieces which would go past the
array (with CPU ID higher than 3 on a 4-CPU kernel).
I've heard that `-Warray-bounds` is still somewhat noisy and
produces a fair amount of false-positives, so that it's been even
disabled for 5.19-rc1 after being enabled during the merge window.

I'm super fine with letting lkp guys know that it's an unrelated
stuff, whom should I write to?
BTW, I didn't receive any reports from the linux-next bots and
haven't found a single over the LKML, so looks like it should be
okay in general :)

> 
> 
> vim +21 include/asm-generic/percpu.h
> 
> ^1da177e4c3f415 Linus Torvalds 2005-04-16  20  
> a875a69f8b00a38 Ingo Molnar    2006-07-03 @21  #define per_cpu_offset(x) (__per_cpu_offset[x])
> acdac87202a4081 travis@sgi.com 2008-01-30  22  #endif
> acdac87202a4081 travis@sgi.com 2008-01-30  23  
> 
> :::::: The code at line 21 was first introduced by commit
> :::::: a875a69f8b00a38b4f40d9632a4fc71a159f0e0d [PATCH] lockdep: add per_cpu_offset()
> 
> :::::: TO: Ingo Molnar <mingo@elte.hu>
> :::::: CC: Linus Torvalds <torvalds@g5.osdl.org>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
> 
> ----- End forwarded message -----

Thanks,
Olek
