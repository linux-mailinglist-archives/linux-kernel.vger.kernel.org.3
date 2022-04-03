Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D84A4F0CF9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 01:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376675AbiDCXhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 19:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239505AbiDCXhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 19:37:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB17F252B6
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 16:35:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39FFCB80DA4
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 23:35:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A2BC340ED;
        Sun,  3 Apr 2022 23:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649028910;
        bh=UWaT+2xp+xezsx465/85VDtSgEeo45u69tq3FSt+VsI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lg6antjhcNoGkfRzRi6GFscB/zSudEufb3qEmAH13GrJFNTLtMjTKMmOfxfzGrQhu
         XOBkc5j68NqSe7lddsfuju89pipy8D+4VR0zvkvdHiub+ESeoTUEBHpcJIG6MWMxLG
         QygMs2wrudnxoJyZyzw4bsAkEXiSPxLErBFrRxiLnEbjYoMQzFcYpKdZ2cN4Q3xSAq
         b21n6aw6NWyntgi5cxh0LZPBIl6I3efQo3LJ3qhD3nySIl7HNtp3I5zfHMbNNrs8xg
         OCD2xnkDCdwjdTdUWrGSdDNHRrB4nvnIOlfohCpvVS40TqMAchtSmP5O4ZSN98J6g4
         jA8vAqgeDFfXQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5DE7A5C0990; Sun,  3 Apr 2022 16:35:10 -0700 (PDT)
Date:   Sun, 3 Apr 2022 16:35:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [ammarfaizi2-block:paulmck/linux-rcu/fastexp.2022.04.01a
 117/158] arch/powerpc/include/asm/book3s/64/pgtable-64k.h:60:1: error: no
 return statement in function returning non-void
Message-ID: <20220403233510.GR4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202204021454.WDwBbwVL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202204021454.WDwBbwVL-lkp@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2022 at 02:50:42PM +0800, kernel test robot wrote:
> Hi Paul,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/fastexp.2022.04.01a
> head:   d9f3e7d671416fdf5b61f094765754269b652db0
> commit: 33a6b5d291d49c64d5e5d53c9cb7032835fc3e7b [117/158] rcutorture: Allow rcutorture without RCU Tasks Trace
> config: powerpc64-randconfig-c003-20220402 (https://download.01.org/0day-ci/archive/20220402/202204021454.WDwBbwVL-lkp@intel.com/config)
> compiler: powerpc64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/ammarfaizi2/linux-block/commit/33a6b5d291d49c64d5e5d53c9cb7032835fc3e7b
>         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
>         git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/fastexp.2022.04.01a
>         git checkout 33a6b5d291d49c64d5e5d53c9cb7032835fc3e7b
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc prepare
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

I believe that these three commits on the -rcu tree's "dev" branch
fix this problem:

18fdcb727bcc ("rcutorture: Allow rcutorture without RCU Tasks Trace")
9028d6407050 ("rcutorture: Allow rcutorture without RCU Tasks")
675b486996d9 ("rcutorture: Allow rcutorture without RCU Tasks Rude")

Please let me know if you have further problems.

							Thanx, Paul

> All errors (new ones prefixed by >>):
> 
>    WARNING: unmet direct dependencies detected for TASKS_TRACE_RCU
>    Depends on RCU_EXPERT
>    Selected by
>    - BPF_SYSCALL
>    Selected by
>    - RCU_REF_SCALE_TEST && DEBUG_KERNEL
>    In file included from arch/powerpc/include/asm/book3s/64/pgtable.h:310,
>    from arch/powerpc/include/asm/book3s/64/mmu-hash.h:20,
>    from arch/powerpc/include/asm/book3s/64/mmu.h:38,
>    from arch/powerpc/include/asm/mmu.h:405,
>    from arch/powerpc/include/asm/lppaca.h:46,
>    from arch/powerpc/include/asm/paca.h:17,
>    from arch/powerpc/include/asm/current.h:13,
>    from include/linux/thread_info.h:23,
>    from include/asm-generic/preempt.h:5,
>    from ./arch/powerpc/include/generated/asm/preempt.h:1,
>    from include/linux/preempt.h:78,
>    from include/linux/spinlock.h:55,
>    from include/linux/ipc.h:5,
>    from include/uapi/linux/sem.h:5,
>    from include/linux/sem.h:5,
>    from include/linux/compat.h:14,
>    from arch/powerpc/kernel/asm-offsets.c:12:
>    arch/powerpc/include/asm/book3s/64/pgtable-64k.h: In function 'get_hugepd_cache_index':
> >> arch/powerpc/include/asm/book3s/64/pgtable-64k.h:60:1: error: no return statement in function returning non-void
>    60 | }
>    | ^
>    cc1: some warnings being treated as errors
>    Makefile arch include kernel nr_bisected scripts source usr [scripts/Makefile.build:121: arch/powerpc/kernel/asm-offsets.s] Error 1
>    Target '__build' not remade because of errors.
>    Makefile arch include kernel nr_bisected scripts source usr [Makefile:1190: prepare0] Error 2
>    Target 'prepare' not remade because of errors.
>    make: Makefile arch include kernel nr_bisected scripts source usr [Makefile:219: __sub-make] Error 2
>    make: Target 'prepare' not remade because of errors.
> 
> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for TASKS_TRACE_RCU
>    Depends on RCU_EXPERT
>    Selected by
>    - BPF_SYSCALL
>    Selected by
>    - RCU_REF_SCALE_TEST && DEBUG_KERNEL
> 
> 
> vim +60 arch/powerpc/include/asm/book3s/64/pgtable-64k.h
> 
> a9252aaefe7e721 Aneesh Kumar K.V 2016-04-29  53  
> fadd03c615922d8 Aneesh Kumar K.V 2018-06-14  54  /*
> fadd03c615922d8 Aneesh Kumar K.V 2018-06-14  55   * This should never get called
> fadd03c615922d8 Aneesh Kumar K.V 2018-06-14  56   */
> fadd03c615922d8 Aneesh Kumar K.V 2018-06-14  57  static inline int get_hugepd_cache_index(int index)
> fadd03c615922d8 Aneesh Kumar K.V 2018-06-14  58  {
> fadd03c615922d8 Aneesh Kumar K.V 2018-06-14  59  	BUG();
> fadd03c615922d8 Aneesh Kumar K.V 2018-06-14 @60  }
> fadd03c615922d8 Aneesh Kumar K.V 2018-06-14  61  
> 
> :::::: The code at line 60 was first introduced by commit
> :::::: fadd03c615922d8521a2e76d4ba2335891cb2790 powerpc/mm/hash/4k: Free hugetlb page table caches correctly.
> 
> :::::: TO: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> :::::: CC: Michael Ellerman <mpe@ellerman.id.au>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
