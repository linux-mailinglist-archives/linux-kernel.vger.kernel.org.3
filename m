Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D0554DFED
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 13:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376781AbiFPLWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 07:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376767AbiFPLWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 07:22:03 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0365E74B;
        Thu, 16 Jun 2022 04:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655378522; x=1686914522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wa3Kw7moqG+Xhp8cnm6XR1a7p5TXdG+ruXsnZQXyjSY=;
  b=Fcghyy8cYobYiAwsD5/LRgP6GJZT27jJxju2tmd9P6VzGsI0Ub4GApWt
   xnyp/+HXSsYw8t3vMya5OIjAqWnCxl3rBoJNeYnjLhwoO4qHYwYCdZChs
   7wZXMgYP6p48rADBgxvMX8szUYf4WLdagRMI3TqUW5fFaTRSrOl1hBgW1
   sG/kgItORRqobABR6ePKs4OP6ziZDbhG+Y5UfqDV79Irve8kkL7dYIhCO
   iUJExuBtjal1jcD0BTEWH6gelXUJNzovGT0iikfT9KZMBMmabajOpEEvL
   7cy9GzwtMuzVd2AigdyqnEDt21UvJgSTCEYrTPSqVYhlJorwK3GUyfp3f
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="280259657"
X-IronPort-AV: E=Sophos;i="5.91,305,1647327600"; 
   d="scan'208";a="280259657"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 04:22:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,305,1647327600"; 
   d="scan'208";a="762827224"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 16 Jun 2022 04:21:57 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1nZV-000OKB-2n;
        Thu, 16 Jun 2022 11:21:57 +0000
Date:   Thu, 16 Jun 2022 19:21:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     kbuild-all@lists.01.org,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH V4 09/20] rv/monitor: wip instrumentation and
 Makefile/Kconfig entries
Message-ID: <202206161937.RukeWKWk-lkp@intel.com>
References: <9c05a95927c18bebcf0eb79bef15ec59667bc08c.1655368610.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c05a95927c18bebcf0eb79bef15ec59667bc08c.1655368610.git.bristot@kernel.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rostedt-trace/for-next]
[also build test WARNING on tip/sched/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Bristot-de-Oliveira/The-Runtime-Verification-RV-interface/20220616-164837
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git for-next
config: riscv-randconfig-r004-20220616 (https://download.01.org/0day-ci/archive/20220616/202206161937.RukeWKWk-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a76032130de277ff6f39fc08277a70823fd85bf3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniel-Bristot-de-Oliveira/The-Runtime-Verification-RV-interface/20220616-164837
        git checkout a76032130de277ff6f39fc08277a70823fd85bf3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash kernel/trace/rv/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/trace/rv/monitors/wip/wip.c:8:
   kernel/trace/rv/monitors/wip/wip.c: In function 'start_wip':
   include/rv/instrumentation.h:15:17: error: implicit declaration of function 'check_trace_callback_type_preempt_disable'; did you mean 'check_trace_callback_type_irq_disable'? [-Werror=implicit-function-declaration]
      15 |                 check_trace_callback_type_##tp(rv_handler);                             \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/rv/monitors/wip/wip.c:61:9: note: in expansion of macro 'rv_attach_trace_probe'
      61 |         rv_attach_trace_probe("wip", preempt_disable, handle_preempt_disable);
         |         ^~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/printk.h:11,
                    from include/linux/kernel.h:29,
                    from include/linux/interrupt.h:6,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/rv/monitors/wip/wip.c:2:
   include/rv/instrumentation.h:16:27: error: implicit declaration of function 'register_trace_preempt_disable'; did you mean 'register_trace_prio_irq_disable'? [-Werror=implicit-function-declaration]
      16 |                 WARN_ONCE(register_trace_##tp(rv_handler, NULL),                        \
         |                           ^~~~~~~~~~~~~~~
   include/linux/once_lite.h:15:41: note: in definition of macro 'DO_ONCE_LITE_IF'
      15 |                 bool __ret_do_once = !!(condition);                     \
         |                                         ^~~~~~~~~
   include/rv/instrumentation.h:16:17: note: in expansion of macro 'WARN_ONCE'
      16 |                 WARN_ONCE(register_trace_##tp(rv_handler, NULL),                        \
         |                 ^~~~~~~~~
   kernel/trace/rv/monitors/wip/wip.c:61:9: note: in expansion of macro 'rv_attach_trace_probe'
      61 |         rv_attach_trace_probe("wip", preempt_disable, handle_preempt_disable);
         |         ^~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/trace/rv/monitors/wip/wip.c:8:
   include/rv/instrumentation.h:15:17: error: implicit declaration of function 'check_trace_callback_type_preempt_enable'; did you mean 'check_trace_callback_type_irq_enable'? [-Werror=implicit-function-declaration]
      15 |                 check_trace_callback_type_##tp(rv_handler);                             \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/rv/monitors/wip/wip.c:62:9: note: in expansion of macro 'rv_attach_trace_probe'
      62 |         rv_attach_trace_probe("wip", preempt_enable, handle_preempt_enable);
         |         ^~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/printk.h:11,
                    from include/linux/kernel.h:29,
                    from include/linux/interrupt.h:6,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/rv/monitors/wip/wip.c:2:
   include/rv/instrumentation.h:16:27: error: implicit declaration of function 'register_trace_preempt_enable'; did you mean 'register_trace_prio_irq_enable'? [-Werror=implicit-function-declaration]
      16 |                 WARN_ONCE(register_trace_##tp(rv_handler, NULL),                        \
         |                           ^~~~~~~~~~~~~~~
   include/linux/once_lite.h:15:41: note: in definition of macro 'DO_ONCE_LITE_IF'
      15 |                 bool __ret_do_once = !!(condition);                     \
         |                                         ^~~~~~~~~
   include/rv/instrumentation.h:16:17: note: in expansion of macro 'WARN_ONCE'
      16 |                 WARN_ONCE(register_trace_##tp(rv_handler, NULL),                        \
         |                 ^~~~~~~~~
   kernel/trace/rv/monitors/wip/wip.c:62:9: note: in expansion of macro 'rv_attach_trace_probe'
      62 |         rv_attach_trace_probe("wip", preempt_enable, handle_preempt_enable);
         |         ^~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/trace/rv/monitors/wip/wip.c:8:
   kernel/trace/rv/monitors/wip/wip.c: In function 'stop_wip':
   include/rv/instrumentation.h:22:17: error: implicit declaration of function 'unregister_trace_preempt_disable'; did you mean 'unregister_trace_irq_disable'? [-Werror=implicit-function-declaration]
      22 |                 unregister_trace_##tp(rv_handler, NULL);                                \
         |                 ^~~~~~~~~~~~~~~~~
   kernel/trace/rv/monitors/wip/wip.c:72:9: note: in expansion of macro 'rv_detach_trace_probe'
      72 |         rv_detach_trace_probe("wip", preempt_disable, handle_preempt_disable);
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/rv/instrumentation.h:22:17: error: implicit declaration of function 'unregister_trace_preempt_enable'; did you mean 'unregister_trace_irq_enable'? [-Werror=implicit-function-declaration]
      22 |                 unregister_trace_##tp(rv_handler, NULL);                                \
         |                 ^~~~~~~~~~~~~~~~~
   kernel/trace/rv/monitors/wip/wip.c:73:9: note: in expansion of macro 'rv_detach_trace_probe'
      73 |         rv_detach_trace_probe("wip", preempt_enable, handle_preempt_enable);
         |         ^~~~~~~~~~~~~~~~~~~~~
   kernel/trace/rv/monitors/wip/wip.c: At top level:
>> kernel/trace/rv/monitors/wip/wip.c:91:5: warning: no previous prototype for 'register_wip' [-Wmissing-prototypes]
      91 | int register_wip(void)
         |     ^~~~~~~~~~~~
>> kernel/trace/rv/monitors/wip/wip.c:97:6: warning: no previous prototype for 'unregister_wip' [-Wmissing-prototypes]
      97 | void unregister_wip(void)
         |      ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/register_wip +91 kernel/trace/rv/monitors/wip/wip.c

15679ffb99664f Daniel Bristot de Oliveira 2022-06-16   90  
15679ffb99664f Daniel Bristot de Oliveira 2022-06-16  @91  int register_wip(void)
15679ffb99664f Daniel Bristot de Oliveira 2022-06-16   92  {
15679ffb99664f Daniel Bristot de Oliveira 2022-06-16   93  	rv_register_monitor(&rv_wip);
15679ffb99664f Daniel Bristot de Oliveira 2022-06-16   94  	return 0;
15679ffb99664f Daniel Bristot de Oliveira 2022-06-16   95  }
15679ffb99664f Daniel Bristot de Oliveira 2022-06-16   96  
15679ffb99664f Daniel Bristot de Oliveira 2022-06-16  @97  void unregister_wip(void)
15679ffb99664f Daniel Bristot de Oliveira 2022-06-16   98  {
15679ffb99664f Daniel Bristot de Oliveira 2022-06-16   99  	if (rv_wip.enabled)
15679ffb99664f Daniel Bristot de Oliveira 2022-06-16  100  		stop_wip();
15679ffb99664f Daniel Bristot de Oliveira 2022-06-16  101  
15679ffb99664f Daniel Bristot de Oliveira 2022-06-16  102  	rv_unregister_monitor(&rv_wip);
15679ffb99664f Daniel Bristot de Oliveira 2022-06-16  103  }
15679ffb99664f Daniel Bristot de Oliveira 2022-06-16  104  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
