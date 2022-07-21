Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A724F57D14B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbiGUQSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbiGUQRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:17:25 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD10193CF
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658420202; x=1689956202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S7kXEVZcl3ja3wgoIAhHmvbfU35DxiP9A+kaFqG/waU=;
  b=mII3jebyAxUGzb/5CIFAGduWahcPT0WxoK3g94r8PWDtobkVj9lHGSu6
   Ca60KLjZ4rQ2sEnCApW1Be/lYJT1IVOVuSTp1yu+zvm9QGNNL6Y/fZUxZ
   fRfMceiDWdFeT8I4c4MsvJcHxVHRwxTOoJ0cfNDkxYNuOcYbqQRHX3cZl
   YJXoVIqlIFS9ABI7z35fD5lZYaosv0Bf1uveR1MIFCoCGTHtYEMxJ/LNV
   A3sNz1OIJvgZT5AuLJ2C8AMDUU1nGCtL31KLJL5roi3D0Wi9b4hhpbBWH
   6PI97GG93KTpiV/StQfdpxGv2sarNNs925WZltkMPx9vGxA3Y2If5xW4O
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="312809236"
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="312809236"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 09:16:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="666343805"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 21 Jul 2022 09:16:40 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oEYqt-0000Ko-1N;
        Thu, 21 Jul 2022 16:16:39 +0000
Date:   Fri, 22 Jul 2022 00:16:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: [PATCH v3 2/2] printk: console: Support console-specific
 loglevels
Message-ID: <202207220029.VYxE2uAL-lkp@intel.com>
References: <b9fa85cfed3a97ab4292daca51476e4e23da2f9a.1658339046.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9fa85cfed3a97ab4292daca51476e4e23da2f9a.1658339046.git.chris@chrisdown.name>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

I love your patch! Perhaps something to improve:

[auto build test WARNING on 9d882352bac8f2ff3753d691e2dc65fcaf738729]

url:    https://github.com/intel-lab-lkp/linux/commits/Chris-Down/printk-console-Per-console-loglevels/20220721-015315
base:   9d882352bac8f2ff3753d691e2dc65fcaf738729
config: riscv-randconfig-s053-20220718 (https://download.01.org/0day-ci/archive/20220722/202207220029.VYxE2uAL-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/fac1dc8424bd6e1ae37f6e180f96ed7e4f44e2fc
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Chris-Down/printk-console-Per-console-loglevels/20220721-015315
        git checkout fac1dc8424bd6e1ae37f6e180f96ed7e4f44e2fc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash kernel/printk/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> kernel/printk/sysctl.c:31:47: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void * @@     got void [noderef] __user *buffer @@
   kernel/printk/sysctl.c:31:47: sparse:     expected void *
   kernel/printk/sysctl.c:31:47: sparse:     got void [noderef] __user *buffer
   kernel/printk/sysctl.c:50:52: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void * @@     got void [noderef] __user *buffer @@
   kernel/printk/sysctl.c:50:52: sparse:     expected void *
   kernel/printk/sysctl.c:50:52: sparse:     got void [noderef] __user *buffer
   kernel/printk/sysctl.c:54:45: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void * @@     got void [noderef] __user *buffer @@
   kernel/printk/sysctl.c:54:45: sparse:     expected void *
   kernel/printk/sysctl.c:54:45: sparse:     got void [noderef] __user *buffer
>> kernel/printk/sysctl.c:75:35: sparse: sparse: incorrect type in initializer (incompatible argument 3 (different address spaces)) @@     expected int ( [usertype] *proc_handler )( ... ) @@     got int ( * )( ... ) @@
   kernel/printk/sysctl.c:75:35: sparse:     expected int ( [usertype] *proc_handler )( ... )
   kernel/printk/sysctl.c:75:35: sparse:     got int ( * )( ... )
   kernel/printk/sysctl.c:130:35: sparse: sparse: incorrect type in initializer (incompatible argument 3 (different address spaces)) @@     expected int ( [usertype] *proc_handler )( ... ) @@     got int ( * )( ... ) @@
   kernel/printk/sysctl.c:130:35: sparse:     expected int ( [usertype] *proc_handler )( ... )
   kernel/printk/sysctl.c:130:35: sparse:     got int ( * )( ... )

vim +31 kernel/printk/sysctl.c

    26	
    27	static int printk_sysctl_deprecated(struct ctl_table *table, int write,
    28					    void __user *buffer, size_t *lenp,
    29					    loff_t *ppos)
    30	{
  > 31		int res = proc_dointvec(table, write, buffer, lenp, ppos);
    32	
    33		if (write)
    34			pr_warn_once(
    35				"printk: The kernel.printk sysctl is deprecated. Consider using kernel.console_loglevel or kernel.default_message_loglevel instead.\n"
    36			);
    37	
    38		return res;
    39	}
    40	
    41	static int printk_console_loglevel(struct ctl_table *table, int write,
    42					   void __user *buffer, size_t *lenp,
    43					   loff_t *ppos)
    44	{
    45	
    46		struct ctl_table ltable = *table;
    47		int ret, value;
    48	
    49		if (!write)
    50			return proc_dointvec(table, write, buffer, lenp, ppos);
    51	
    52		ltable.data = &value;
    53	
    54		ret = proc_dointvec(&ltable, write, buffer, lenp, ppos);
    55		if (ret)
    56			return ret;
    57	
    58		if (value < min_loglevel || value > max_loglevel)
    59			return -ERANGE;
    60	
    61		if (value < minimum_console_loglevel)
    62			return -EINVAL;
    63	
    64		console_loglevel = value;
    65	
    66		return 0;
    67	}
    68	
    69	static struct ctl_table printk_sysctls[] = {
    70		{
    71			.procname	= "printk",
    72			.data		= &console_loglevel,
    73			.maxlen		= 4*sizeof(int),
    74			.mode		= 0644,
  > 75			.proc_handler	= printk_sysctl_deprecated,
    76		},
    77		{
    78			.procname	= "printk_ratelimit",
    79			.data		= &printk_ratelimit_state.interval,
    80			.maxlen		= sizeof(int),
    81			.mode		= 0644,
    82			.proc_handler	= proc_dointvec_jiffies,
    83		},
    84		{
    85			.procname	= "printk_ratelimit_burst",
    86			.data		= &printk_ratelimit_state.burst,
    87			.maxlen		= sizeof(int),
    88			.mode		= 0644,
    89			.proc_handler	= proc_dointvec,
    90		},
    91		{
    92			.procname	= "printk_delay",
    93			.data		= &printk_delay_msec,
    94			.maxlen		= sizeof(int),
    95			.mode		= 0644,
    96			.proc_handler	= proc_dointvec_minmax,
    97			.extra1		= SYSCTL_ZERO,
    98			.extra2		= (void *)&ten_thousand,
    99		},
   100		{
   101			.procname	= "printk_devkmsg",
   102			.data		= devkmsg_log_str,
   103			.maxlen		= DEVKMSG_STR_MAX_SIZE,
   104			.mode		= 0644,
   105			.proc_handler	= devkmsg_sysctl_set_loglvl,
   106		},
   107		{
   108			.procname	= "dmesg_restrict",
   109			.data		= &dmesg_restrict,
   110			.maxlen		= sizeof(int),
   111			.mode		= 0644,
   112			.proc_handler	= proc_dointvec_minmax_sysadmin,
   113			.extra1		= SYSCTL_ZERO,
   114			.extra2		= SYSCTL_ONE,
   115		},
   116		{
   117			.procname	= "kptr_restrict",
   118			.data		= &kptr_restrict,
   119			.maxlen		= sizeof(int),
   120			.mode		= 0644,
   121			.proc_handler	= proc_dointvec_minmax_sysadmin,
   122			.extra1		= SYSCTL_ZERO,
   123			.extra2		= SYSCTL_TWO,
   124		},
   125		{
   126			.procname	= "console_loglevel",
   127			.data		= &console_loglevel,
   128			.maxlen		= sizeof(int),
   129			.mode		= 0644,
   130			.proc_handler	= printk_console_loglevel,
   131		},
   132		{
   133			.procname	= "default_message_loglevel",
   134			.data		= &default_message_loglevel,
   135			.maxlen		= sizeof(int),
   136			.mode		= 0644,
   137			.proc_handler	= proc_dointvec_minmax,
   138			.extra1		= &min_loglevel,
   139			.extra2		= &max_loglevel,
   140		},
   141		{}
   142	};
   143	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
