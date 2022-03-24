Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798384E6071
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 09:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348993AbiCXIhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 04:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348966AbiCXIhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:37:53 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56C29BBA8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648110981; x=1679646981;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bnfZUWLIjm8t9Ixn8cJIDpc7URz+/YF2WueALdlqm1U=;
  b=k1SSlupWT9yAIK78CDBdoLaCdzyVqNNWtpgDdMf9N6Axu4VS0OEJqvcK
   QEikKmIFNEsRCCpdcpzwfeL3D+VjJtuod9g3ifWMOyOZ6gnVQvDlTCoij
   Y8juApivGicG2dwTcu0aMFk9ytzWl6qDzoc0nG7O1mbELWdU/eVm0kRf+
   W3SuQU63hQ1FpT6J7jGiey8kIe3eqrA6bm6Y2qazDgrRN9hnInR/w4w+1
   vXbIyw9okpQ41uQ5qQPl76c6boRuwuoK1zs3SslzbJXIsp52DhmZZ/UJo
   j6VIvSN7CqBiSjiAHgl+GQhCoPEYUMYtY8MtBpzNPZScY93smEbJmu50c
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="238261295"
X-IronPort-AV: E=Sophos;i="5.90,206,1643702400"; 
   d="scan'208";a="238261295"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 01:36:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,206,1643702400"; 
   d="scan'208";a="516089850"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 24 Mar 2022 01:36:17 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXIx6-000KsI-9F; Thu, 24 Mar 2022 08:36:16 +0000
Date:   Thu, 24 Mar 2022 16:35:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Mark Rutland <mark.rutland@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] arm64: implement stack_trace_save_shadow
Message-ID: <202203241622.fKuBI2l5-lkp@intel.com>
References: <0bb72ea8fa88ef9ae3508c23d993952a0ae6f0f9.1648049113.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bb72ea8fa88ef9ae3508c23d993952a0ae6f0f9.1648049113.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I love your patch! Perhaps something to improve:

[auto build test WARNING on next-20220323]
[cannot apply to arm64/for-next/core hnaz-mm/master linus/master v5.17 v5.17-rc8 v5.17-rc7 v5.17]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/andrey-konovalov-linux-dev/kasan-arm64-scs-stacktrace-collect-stack-traces-from-Shadow-Call-Stack/20220323-233436
base:    b61581ae229d8eb9f21f8753be3f4011f7692384
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20220324/202203241622.fKuBI2l5-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/322e934f3c0bb04b4afb32207ba142153f1dd84e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review andrey-konovalov-linux-dev/kasan-arm64-scs-stacktrace-collect-stack-traces-from-Shadow-Call-Stack/20220323-233436
        git checkout 322e934f3c0bb04b4afb32207ba142153f1dd84e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/arm64/kernel/stacktrace.c: In function 'arch_stack_walk_shadow':
   arch/arm64/kernel/stacktrace.c:289:20: error: implicit declaration of function 'task_scs'; did you mean 'task_lock'? [-Werror=implicit-function-declaration]
     289 |         scs_base = task_scs(current);
         |                    ^~~~~~~~
         |                    task_lock
>> arch/arm64/kernel/stacktrace.c:289:18: warning: assignment to 'long unsigned int *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     289 |         scs_base = task_scs(current);
         |                  ^
   cc1: some warnings being treated as errors


vim +289 arch/arm64/kernel/stacktrace.c

   260	
   261	noinline notrace int arch_stack_walk_shadow(unsigned long *store,
   262						    unsigned int size,
   263						    unsigned int skipnr)
   264	{
   265		unsigned long *scs_top, *scs_base, *scs_next;
   266		unsigned int len = 0, part;
   267	
   268		preempt_disable();
   269	
   270		/* Get the SCS pointer. */
   271		asm volatile("mov %0, x18" : "=&r" (scs_top));
   272	
   273		/* The top SCS slot is empty. */
   274		scs_top -= 1;
   275	
   276		/* Handle SDEI and hardirq frames. */
   277		for (part = 0; part < ARRAY_SIZE(scs_parts); part++) {
   278			scs_next = *this_cpu_ptr(scs_parts[part].saved);
   279			if (scs_next) {
   280				scs_base = *this_cpu_ptr(scs_parts[part].base);
   281				if (walk_shadow_stack_part(scs_top, scs_base, store,
   282							   size, &skipnr, &len))
   283					goto out;
   284				scs_top = scs_next;
   285			}
   286		}
   287	
   288		/* Handle task and softirq frames. */
 > 289		scs_base = task_scs(current);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
