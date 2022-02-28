Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E91B4C74F6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 18:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238883AbiB1RtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 12:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238948AbiB1Rnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:43:33 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E709D7D03F;
        Mon, 28 Feb 2022 09:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646069725; x=1677605725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rL/LDGX5IsDnQdPbHkRMVK6CvzA1sOWyScOPv1bJ4b0=;
  b=dDmyROAHI4NL7nBBSYLrOi7fMIQLN2NRJebbCBIZKl5PX0yX/hzIpsiB
   xh1lLfM+T7oBIjkF58OC0nxi315w1mt2k6tuD6N+hgAWAxlBmK3ZHTbzG
   NvW0I2deYZHHwzsKHNZNH8hLnrquoElaVUhew+F6A+TMwhtwa4bDSUcBj
   mKOjSUZn/PpwUEO7UK4o9hJlzLl3QQ0tw1xruI2AYUDJ7Kj9HTyM5fUsM
   sd4iW7jeR33QmsswMeYGbKZL08/KB+TiowggsqnCDfLCUgUztnt7To5UQ
   6H0/E+xF5/XySC/a2i/EDq4ZSmbeAsy9x8sFo26YxHXag4hh1ghxrnTG/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="339373867"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="339373867"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 09:35:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="510174103"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Feb 2022 09:35:14 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOjvW-0007ZQ-6k; Mon, 28 Feb 2022 17:35:14 +0000
Date:   Tue, 1 Mar 2022 01:35:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Maninder Singh <maninder1.s@samsung.com>, mcgrof@kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        akpm@linux-foundation.org, wangkefeng.wang@huawei.com
Cc:     kbuild-all@lists.01.org, v.narang@samsung.com, swboyd@chromium.org,
        ojeda@kernel.or, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, avimalin@gmail.com,
        atomlin@redhat.com, Maninder Singh <maninder1.s@samsung.com>
Subject: Re: [PATCH 1/1] kallsyms: enhance %pS/s/b printing when KALLSYSMS is
 disabled
Message-ID: <202202281853.EofvQRmv-lkp@intel.com>
References: <20220228053447.1584704-1-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228053447.1584704-1-maninder1.s@samsung.com>
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

Hi Maninder,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on hnaz-mm/master]
[also build test WARNING on next-20220225]
[cannot apply to mcgrof/modules-next linus/master v5.17-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Maninder-Singh/kallsyms-enhance-pS-s-b-printing-when-KALLSYSMS-is-disabled/20220228-140105
base:   https://github.com/hnaz/linux-mm master
config: alpha-randconfig-r032-20220227 (https://download.01.org/0day-ci/archive/20220228/202202281853.EofvQRmv-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/fbad94837350bb7c5b1b0c33648f8b20eff0150a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Maninder-Singh/kallsyms-enhance-pS-s-b-printing-when-KALLSYSMS-is-disabled/20220228-140105
        git checkout fbad94837350bb7c5b1b0c33648f8b20eff0150a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   lib/vsprintf.c: In function 'sprint_module_info':
>> lib/vsprintf.c:993:13: warning: variable 'modbuildid' set but not used [-Wunused-but-set-variable]
     993 |         int modbuildid = 0;
         |             ^~~~~~~~~~
   lib/vsprintf.c: In function 'va_format':
   lib/vsprintf.c:1761:9: warning: function 'va_format' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1761 |         buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
         |         ^~~


vim +/modbuildid +993 lib/vsprintf.c

   983	
   984	#if !defined(CONFIG_KALLSYMS) && defined(CONFIG_MODULES)
   985	static int sprint_module_info(char *buf, char *end, unsigned long value,
   986				     const char *fmt)
   987	{
   988		struct module *mod;
   989		unsigned long offset = 1;
   990		unsigned long base;
   991		int ret = 0;
   992		const char *modname;
 > 993		int modbuildid = 0;
   994		int len;
   995	#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
   996		const unsigned char *buildid = NULL;
   997	#endif
   998	
   999		if (is_ksym_addr(value))
  1000			return 0;
  1001	
  1002		if (*fmt == 'B' && fmt[1] == 'b')
  1003			modbuildid = 1;
  1004		else if (*fmt == 'S' && (fmt[1] == 'b' || (fmt[1] == 'R' && fmt[2] == 'b')))
  1005			modbuildid = 1;
  1006		else if (*fmt != 's') {
  1007			/*
  1008			 * do nothing.
  1009			 */
  1010		} else
  1011			offset = 0;
  1012	
  1013		preempt_disable();
  1014		mod = __module_address(value);
  1015		if (mod) {
  1016			ret = 1;
  1017			modname = mod->name;
  1018	#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
  1019			if (modbuildid)
  1020				buildid = mod->build_id;
  1021	#endif
  1022			if (offset) {
  1023				base = (unsigned long)mod->core_layout.base;
  1024				offset = value - base;
  1025			}
  1026		}
  1027	
  1028		preempt_enable();
  1029		if (!ret)
  1030			return 0;
  1031	
  1032		/* address belongs to module */
  1033		if (offset)
  1034			len = sprintf(buf, "0x%lx+0x%lx", base, offset);
  1035		else
  1036			len = sprintf(buf, "0x%lx", value);
  1037	
  1038		len += sprintf(buf + len, " [%s", modname);
  1039	#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
  1040		if (modbuildid && buildid) {
  1041			/* build ID should match length of sprintf */
  1042			static_assert(sizeof(typeof_member(struct module, build_id)) == 20);
  1043			len += sprintf(buf + len, " %20phN", buildid);
  1044		}
  1045	#endif
  1046		len += sprintf(buf + len, "]");
  1047	
  1048		return len;
  1049	}
  1050	#else
  1051	static inline int sprint_module_info(char *buf, char *end, unsigned long value,
  1052				     const char *fmt)
  1053	{
  1054		return 0;
  1055	}
  1056	#endif
  1057	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
