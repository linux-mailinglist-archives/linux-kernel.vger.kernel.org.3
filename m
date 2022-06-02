Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2AA53C09E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 00:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239543AbiFBWGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 18:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiFBWGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 18:06:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374E3344CA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 15:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654207566; x=1685743566;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cYKWLs9NKzCRBoIb8cGOEtchcgzMJ4ulR/Qb8v0u4gE=;
  b=KE1NNBwYv3ZQXpUXjePWEYvgw2FRvDEMu3sGspgak5R8kT3i4ahzm00K
   hfENFX7Vl0WYykvTcUW3KBj++/VfiLNUgRNwBhy7iMYmKKxuQ7NKxTLcs
   BNPS/xwmBEOGTtST5z3PisLFM6d59pW8e7ONNZo8Q3Xy4G8jGzjgjL6gQ
   EiFEtO0iFQ1mDgL1TRbIeAchc9PpuQbfnRrFftQxfvtsonG8TqF4bDzKP
   sBxa+MWdnNMfvRRfqCq98gyJRUnmtdhseouSxLq42nVIPG8i3eJ1ry3Pi
   lWo1vQcOHgOD2JjRvCRXBAdVwlv/DmQtR+Cl7af0hEEqAhRX2MMKmYz/8
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="255959126"
X-IronPort-AV: E=Sophos;i="5.91,272,1647327600"; 
   d="scan'208";a="255959126"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 15:05:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,272,1647327600"; 
   d="scan'208";a="668188846"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Jun 2022 15:05:53 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwswy-0005Tr-EX;
        Thu, 02 Jun 2022 22:05:52 +0000
Date:   Fri, 3 Jun 2022 06:05:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeff Xie <xiehuan09@gmail.com>, rostedt@goodmis.org
Cc:     kbuild-all@lists.01.org, mingo@redhat.com, mhiramat@kernel.org,
        zanussi@kernel.org, linux-kernel@vger.kernel.org,
        Jeff Xie <xiehuan09@gmail.com>
Subject: Re: [PATCH v11 1/4] trace: Add trace any kernel object
Message-ID: <202206030528.0x7yQIj3-lkp@intel.com>
References: <20220602164518.286295-2-xiehuan09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602164518.286295-2-xiehuan09@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on b39181f7c6907dc66ff937b74758671fa6ba430c]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeff-Xie/trace-Introduce-objtrace-trigger-to-trace-the-kernel-object/20220603-004723
base:   b39181f7c6907dc66ff937b74758671fa6ba430c
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20220603/202206030528.0x7yQIj3-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/765253f020469f94856aedc5a3fe5444e1e8f4e8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jeff-Xie/trace-Introduce-objtrace-trigger-to-trace-the-kernel-object/20220603-004723
        git checkout 765253f020469f94856aedc5a3fe5444e1e8f4e8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:29,
                    from arch/x86/include/asm/percpu.h:27,
                    from arch/x86/include/asm/preempt.h:6,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/seq_buf.h:5,
                    from include/linux/trace_seq.h:5,
                    from kernel/trace/trace_output.h:5,
                    from kernel/trace/trace_object.c:9:
   kernel/trace/trace_object.c: In function 'event_object_trigger_parse':
>> include/linux/kern_levels.h:5:25: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'unsigned int' [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:418:25: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:489:9: note: in expansion of macro 'printk'
     489 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:11:25: note: in expansion of macro 'KERN_SOH'
      11 | #define KERN_ERR        KERN_SOH "3"    /* error conditions */
         |                         ^~~~~~~~
   include/linux/printk.h:489:16: note: in expansion of macro 'KERN_ERR'
     489 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~
   kernel/trace/trace_object.c:336:17: note: in expansion of macro 'pr_err'
     336 |                 pr_err("the size of the %s should be:%ld\n", field->name, sizeof(void *));
         |                 ^~~~~~


vim +5 include/linux/kern_levels.h

314ba3520e513a Joe Perches 2012-07-30  4  
04d2c8c83d0e3a Joe Perches 2012-07-30 @5  #define KERN_SOH	"\001"		/* ASCII Start Of Header */
04d2c8c83d0e3a Joe Perches 2012-07-30  6  #define KERN_SOH_ASCII	'\001'
04d2c8c83d0e3a Joe Perches 2012-07-30  7  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
