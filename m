Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F5A4C7505
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 18:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238699AbiB1Rt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 12:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238876AbiB1RnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:43:25 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D476599EDA;
        Mon, 28 Feb 2022 09:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646069717; x=1677605717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aMYtjEOpxF59nZtGs1ODxKpgRksNDTdLFEt+1j+s4FA=;
  b=WP45q+JfRG3lHLZwqzBJhCGWGR9H4bbjdXq039X3LBcgrAaxtxUb/mDz
   szYmWH13mnne7r55OSbXV4sDPiXuWeqVLKQ/G1x1MAIwSGVOlAjcG1LB5
   fFHfzycEG3pAgTHe/qpdnIVtp8q5Ic1eWIUbKNLr1Z4QP+mVkTNcqdpIf
   aZMolZTNY15ejHS/PkSu+f53L1Mkd5SnT1DSnc4iS5Y3T8QmnzqEDK5bm
   FNUilBM5nDNO9K7URxzvS7jCpPiszBbKzncyt1fnydveh+Lk3tiC3TszX
   VDlSDlqyHbfHD6IiAv2x7coNy/1w6BvpONJnnv3r7s6yjoyVkTSCxruRl
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="339373860"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="339373860"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 09:35:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="685411831"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2022 09:35:14 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOjvW-0007ZN-6I; Mon, 28 Feb 2022 17:35:14 +0000
Date:   Tue, 1 Mar 2022 01:34:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] MIPS: Refactor early_parse_mem() to fix mem=
 parameter
Message-ID: <202202281751.WKuGplhT-lkp@intel.com>
References: <1646029866-6692-2-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646029866-6692-2-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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

url:    https://github.com/0day-ci/linux/commits/Tiezhu-Yang/MIPS-Modify-mem-and-memmap-parameter/20220228-143251
base:   https://github.com/hnaz/linux-mm master
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220228/202202281751.WKuGplhT-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/ed304f835ff384c8fe9b788e13d3ec4d93878416
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Tiezhu-Yang/MIPS-Modify-mem-and-memmap-parameter/20220228-143251
        git checkout ed304f835ff384c8fe9b788e13d3ec4d93878416
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:22,
                    from arch/mips/include/asm/bug.h:42,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:6,
                    from include/linux/memblock.h:12,
                    from arch/mips/kernel/setup.c:17:
   arch/mips/kernel/setup.c: In function 'early_parse_mem':
>> include/linux/kern_levels.h:5:25: warning: format '%lld' expects argument of type 'long long int', but argument 2 has type 'phys_addr_t' {aka 'unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:418:25: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:509:9: note: in expansion of macro 'printk'
     509 |         printk(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:13:25: note: in expansion of macro 'KERN_SOH'
      13 | #define KERN_NOTICE     KERN_SOH "5"    /* normal but significant condition */
         |                         ^~~~~~~~
   include/linux/printk.h:509:16: note: in expansion of macro 'KERN_NOTICE'
     509 |         printk(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~~~~
   arch/mips/kernel/setup.c:350:9: note: in expansion of macro 'pr_notice'
     350 |         pr_notice("Memory limited to %lldMB\n", memory_limit >> 20);
         |         ^~~~~~~~~


vim +5 include/linux/kern_levels.h

314ba3520e513a Joe Perches 2012-07-30  4  
04d2c8c83d0e3a Joe Perches 2012-07-30 @5  #define KERN_SOH	"\001"		/* ASCII Start Of Header */
04d2c8c83d0e3a Joe Perches 2012-07-30  6  #define KERN_SOH_ASCII	'\001'
04d2c8c83d0e3a Joe Perches 2012-07-30  7  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
