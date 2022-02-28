Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40D54C74EC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 18:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238810AbiB1RtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 12:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239943AbiB1Roy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:44:54 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D719819C28;
        Mon, 28 Feb 2022 09:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646069843; x=1677605843;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vXTL8dLX7viXJuGg2oI1j6Lgyk1Ewv5xNOTP7Tgfu/4=;
  b=e/anaTD22EDSuAss1/vBptNRBVh5a3EEDbjG0AXHstvKH875ksBTxDr4
   XsfOn+Oqa/OeYq1q5xFa54dXY3KCEtRwVpYhhZnvUcjJRR0s0zNfoBpdz
   +kBqs65V50fg0MkXbNNXt4M3HDLH4vXdvPKr0N6KdzD8dzG2aRMsF4q6+
   7ujipAL9JTvp1SHmyKD3fSy3qSqt6moszwlsnr3m3U748eakdKuR2N4wi
   2+lz9BZo8KSUGp5Db2Y6XqNY2h5m2/zgvI5oG5zFuGvOnZpiMG/b9PFK5
   v6dpqiovC3VLWHOZrCse12upwScABh63gRgR6AHtY0OCSLLid9U1Z9J1y
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="232912009"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="232912009"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 09:37:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="708726454"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 28 Feb 2022 09:37:15 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOjxS-0007cT-Lj; Mon, 28 Feb 2022 17:37:14 +0000
Date:   Tue, 1 Mar 2022 01:36:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] MIPS: Refactor early_parse_memmap() to fix
 memmap= parameter
Message-ID: <202203010025.PU3GDSWx-lkp@intel.com>
References: <1646054617-16799-4-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646054617-16799-4-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tiezhu,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on hnaz-mm/master]
[also build test WARNING on linus/master v5.17-rc6 next-20220225]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Tiezhu-Yang/MIPS-Modify-mem-and-memmap-parameter/20220228-212554
base:   https://github.com/hnaz/linux-mm master
config: mips-randconfig-r025-20220228 (https://download.01.org/0day-ci/archive/20220301/202203010025.PU3GDSWx-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/0day-ci/linux/commit/ab143b3c599254c414419565480fc01acb23452a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Tiezhu-Yang/MIPS-Modify-mem-and-memmap-parameter/20220228-212554
        git checkout ab143b3c599254c414419565480fc01acb23452a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/mips/kernel/setup.c:351:42: warning: format specifies type 'long long' but the argument has type 'phys_addr_t' (aka 'unsigned int') [-Wformat]
           pr_notice("Memory limited to %lldMB\n", memory_limit >> 20);
                                        ~~~~       ^~~~~~~~~~~~~~~~~~
                                        %u
   include/linux/printk.h:509:36: note: expanded from macro 'pr_notice'
           printk(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
                                     ~~~     ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   arch/mips/kernel/setup.c:380:6: warning: format specifies type 'long long' but the argument has type 'phys_addr_t' (aka 'unsigned int') [-Wformat]
                             memory_base >> 20, (memory_base + memory_limit) >> 20);
                             ^~~~~~~~~~~~~~~~~
   include/linux/printk.h:509:36: note: expanded from macro 'pr_notice'
           printk(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
                                     ~~~     ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
>> arch/mips/kernel/setup.c:380:25: warning: format specifies type 'long long' but the argument has type 'unsigned int' [-Wformat]
                             memory_base >> 20, (memory_base + memory_limit) >> 20);
                                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:509:36: note: expanded from macro 'pr_notice'
           printk(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
                                     ~~~     ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   arch/mips/kernel/setup.c:399:5: warning: format specifies type 'long long' but the argument has type 'phys_addr_t' (aka 'unsigned int') [-Wformat]
                     memory_base >> 20, (memory_base + memory_limit) >> 20);
                     ^~~~~~~~~~~~~~~~~
   include/linux/printk.h:509:36: note: expanded from macro 'pr_notice'
           printk(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
                                     ~~~     ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   arch/mips/kernel/setup.c:399:24: warning: format specifies type 'long long' but the argument has type 'unsigned int' [-Wformat]
                     memory_base >> 20, (memory_base + memory_limit) >> 20);
                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:509:36: note: expanded from macro 'pr_notice'
           printk(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
                                     ~~~     ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   5 warnings generated.


vim +380 arch/mips/kernel/setup.c

   356	
   357	static int __init early_parse_memmap(char *p)
   358	{
   359		char *oldp;
   360	
   361		if (!p)
   362			return -EINVAL;
   363	
   364		if (!strncmp(p, "exactmap", 8)) {
   365			pr_err("\"memmap=exactmap\" invalid on MIPS\n");
   366			return 0;
   367		}
   368	
   369		oldp = p;
   370		memory_limit = memparse(p, &p) & PAGE_MASK;
   371		if (p == oldp)
   372			return -EINVAL;
   373	
   374		if (*p == '@') {
   375			memory_base = memparse(p + 1, &p) & PAGE_MASK;
   376		} else if (*p == '$') {
   377			memory_base = memparse(p+1, &p) & PAGE_MASK;
   378			memblock_reserve(memory_base, memory_limit);
   379			pr_notice("Memory reserved to %lldMB-%lldMB\n",
 > 380				  memory_base >> 20, (memory_base + memory_limit) >> 20);
   381			memory_base = 0;
   382			memory_limit = 0;
   383			return 0;
   384		} else if (*p == '#') {
   385			pr_err("\"memmap=nn#ss\" invalid on MIPS\n");
   386			memory_limit = 0;
   387			return -EINVAL;
   388		} else if (*p == '!') {
   389			pr_err("\"memmap=nn!ss\" invalid on MIPS\n");
   390			memory_limit = 0;
   391			return -EINVAL;
   392		} else {
   393			pr_err("Unrecognized memmap syntax: %s\n", p);
   394			memory_limit = 0;
   395			return -EINVAL;
   396		}
   397	
   398		pr_notice("Memory limited to %lldMB-%lldMB\n",
   399			  memory_base >> 20, (memory_base + memory_limit) >> 20);
   400	
   401		return *p == '\0' ? 0 : -EINVAL;
   402	}
   403	early_param("memmap", early_parse_memmap);
   404	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
