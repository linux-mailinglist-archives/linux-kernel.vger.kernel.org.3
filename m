Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720BC4C74E9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 18:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238575AbiB1Rsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 12:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239871AbiB1Rop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:44:45 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105A613F97;
        Mon, 28 Feb 2022 09:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646069839; x=1677605839;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EUN0iBxb6qJUpWGGlQLJZRyk0KG5mMjx/0wyD9IfUo0=;
  b=VFnCmoMu6b3TtjKDzKXYOwwFvvU5U8/jHghoV+cvzItxR+HXlPiAlxux
   FgUnuuoHL0UXvjyC4MN5GK17dzTgq/XIkpfoPVyIJWIxHDLZOHIBlffWu
   +NmES0AkDODUPCuWo6I8PEE90MK/1BaVHU61B+NkaV0TKm9tUEuPVs+1t
   nrmE1QLPIUArzFIDCl8nVvtQyH2oiwLqQ3fX7h/+iBTeEiVgY16jyxDKY
   HF7kcYaHDZYtyjyMCu7rIo3F/mHbbezdcXd3YamrL+9wBZff8dIY2GZi2
   mw0wOdZQyCzgjVcoCMSWLbwh1RMiivy/3wy4ISgF4apj/bAEf0hFrs7l4
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="252669861"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="252669861"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 09:37:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="492791347"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 28 Feb 2022 09:37:15 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOjxS-0007c7-GK; Mon, 28 Feb 2022 17:37:14 +0000
Date:   Tue, 1 Mar 2022 01:36:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] MIPS: Refactor early_parse_mem() to fix mem=
 parameter
Message-ID: <202202282330.uO0sH1Bk-lkp@intel.com>
References: <1646054617-16799-2-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646054617-16799-2-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
config: mips-randconfig-r025-20220228 (https://download.01.org/0day-ci/archive/20220228/202202282330.uO0sH1Bk-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/0day-ci/linux/commit/8e3bd7f4c0a4003c328ef2d816454dd50810b974
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Tiezhu-Yang/MIPS-Modify-mem-and-memmap-parameter/20220228-212554
        git checkout 8e3bd7f4c0a4003c328ef2d816454dd50810b974
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/mips/kernel/setup.c:350:42: warning: format specifies type 'long long' but the argument has type 'phys_addr_t' (aka 'unsigned int') [-Wformat]
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
   1 warning generated.


vim +350 arch/mips/kernel/setup.c

   343	
   344	static int __init early_parse_mem(char *p)
   345	{
   346		if (!p)
   347			return 1;
   348	
   349		memory_limit = memparse(p, &p) & PAGE_MASK;
 > 350		pr_notice("Memory limited to %lldMB\n", memory_limit >> 20);
   351	
   352		return 0;
   353	}
   354	early_param("mem", early_parse_mem);
   355	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
