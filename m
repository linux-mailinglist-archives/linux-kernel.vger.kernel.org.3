Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC754AE49A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389004AbiBHWdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386599AbiBHU6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 15:58:11 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C6FC0612B8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 12:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644353890; x=1675889890;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U0KqN0/RMKUKOMUlz+y1xlsDDkqqQ9ypXbMSo/DGJJI=;
  b=Z/Bi6xJBqVB837C9Yhoj+LtrwEIvf4RJ2pvp0+F1jF6jpITymSvlrYmf
   rWDw3X2vYzyORTIKLbpgQJyC4rJ3Q1VccSr0vshF1/gztCXXSRzGHZB9z
   ENnm0HnHF+qUP19htD5NbMiYT2o+FXao61+IH/I6/YiR9VkMZwM3Sv5MK
   +uCqFTidC3GXwKWeY5yWXZUUrjZbdBE9UCrjbd06LNwaSxnCMResKGDcw
   w/WsMyNX1nS38yfIh06H/XUb+8MhzBiXolVd/Nem/kI6nRb0quidwfuGz
   2o5aeTlF2r8lJmsChR6bzoA4vVnnn7qaPfFXXICsRPYGGo4TANY42B96Q
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="248998885"
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="248998885"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 12:58:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="632978729"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 08 Feb 2022 12:58:07 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHXYt-0000jW-8e; Tue, 08 Feb 2022 20:58:07 +0000
Date:   Wed, 9 Feb 2022 04:57:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     JaeSang Yoo <js.yoo.5b@gmail.com>, rostedt@goodmis.org
Cc:     kbuild-all@lists.01.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, JaeSang Yoo <jsyoo5b@gmail.com>
Subject: Re: [PATCH v2] trace: param: fix tp_printk option related with
 tp_printk_stop_on_boot
Message-ID: <202202090421.PMWXYPxl-lkp@intel.com>
References: <20220208163031.885332-1-jsyoo5b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208163031.885332-1-jsyoo5b@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi JaeSang,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on rostedt-trace/for-next]
[also build test ERROR on v5.17-rc3 next-20220208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/JaeSang-Yoo/trace-param-fix-tp_printk-option-related-with-tp_printk_stop_on_boot/20220209-003316
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git for-next
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220209/202202090421.PMWXYPxl-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/2f6eb784171798586c7fde6d2f2e445ac5a344c3
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review JaeSang-Yoo/trace-param-fix-tp_printk-option-related-with-tp_printk_stop_on_boot/20220209-003316
        git checkout 2f6eb784171798586c7fde6d2f2e445ac5a344c3
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/trace/trace.c: In function 'set_tracepoint_printk':
>> kernel/trace/trace.c:256:11: error: expected ';' before 'if'
     256 |   return 0
         |           ^
         |           ;
     257 |  if ((strcmp(str, "=0") != 0 && strcmp(str, "=off") != 0))
         |  ~~        
   kernel/trace/trace.c: In function 'trace_check_vprintf':
   kernel/trace/trace.c:3824:3: warning: function 'trace_check_vprintf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    3824 |   trace_seq_vprintf(&iter->seq, iter->fmt, ap);
         |   ^~~~~~~~~~~~~~~~~
   kernel/trace/trace.c:3891:3: warning: function 'trace_check_vprintf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    3891 |   trace_seq_vprintf(&iter->seq, p, ap);
         |   ^~~~~~~~~~~~~~~~~
   At top level:
   kernel/trace/trace.c:1672:37: warning: 'tracing_max_lat_fops' defined but not used [-Wunused-const-variable=]
    1672 | static const struct file_operations tracing_max_lat_fops;
         |                                     ^~~~~~~~~~~~~~~~~~~~


vim +256 kernel/trace/trace.c

   252	
   253	static int __init set_tracepoint_printk(char *str)
   254	{
   255		if (*str == '_')
 > 256			return 0
   257		if ((strcmp(str, "=0") != 0 && strcmp(str, "=off") != 0))
   258			tracepoint_printk = 1;
   259		return 1;
   260	}
   261	__setup("tp_printk", set_tracepoint_printk);
   262	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
