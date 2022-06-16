Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A858754E260
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377254AbiFPNsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbiFPNsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:48:07 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FEB3DDC9;
        Thu, 16 Jun 2022 06:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655387286; x=1686923286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vGUkbkYnPTkRCUU0zk0sdqOdfKr4cQ3wFU8xRSXZG90=;
  b=bNt9oJpnOTpv/RXljBjGt+ZKNIDYYErJZvNGyQ6HejA8qQHGx09f4lGk
   DUAZ2rjM7qhT7Y4EdiORdG7dCrDfiTldlUVZ4aaUbtzcCn8N8KL2lwhP3
   U5GH333kX9cl50V5gSf4L8YjnN+rQCz4tydz9mT4ZZAsFCgsK7xYdrPgH
   uZ2yu9RHhIHgtgkCXJT4caCZjQXNG16mXrJ+ptpxTdE0OqWb2LgTPkMXO
   P7CgpEIbr/vLz4DgkdxaZ2OnxF4QhYhQqrZbryDZCtQa49hPSwB2nY5qY
   cEL4D1mfDgAarN4tGzK+8EtFyUE/QJwuCJYMHN4qqf/QtRxB9KFQadD21
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="304695134"
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="304695134"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 06:48:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="675030959"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jun 2022 06:48:01 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1pqr-000OQV-0g;
        Thu, 16 Jun 2022 13:48:01 +0000
Date:   Thu, 16 Jun 2022 21:47:13 +0800
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
Subject: Re: [PATCH V4 11/20] rv/monitor: wwnr instrumentation and
 Makefile/Kconfig entries
Message-ID: <202206162130.0xtEgymS-lkp@intel.com>
References: <944694879f67c0e635815ac57154be477a1b9108.1655368610.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <944694879f67c0e635815ac57154be477a1b9108.1655368610.git.bristot@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220616/202206162130.0xtEgymS-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/31dad6685057c10f6301fbc4018b6586fce0757e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniel-Bristot-de-Oliveira/The-Runtime-Verification-RV-interface/20220616-164837
        git checkout 31dad6685057c10f6301fbc4018b6586fce0757e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/trace/rv/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/trace/rv/monitors/wwnr/wwnr.c:8:
   kernel/trace/rv/monitors/wwnr/wwnr.c: In function 'start_wwnr':
   kernel/trace/rv/monitors/wwnr/wwnr.c:62:53: error: passing argument 1 of 'check_trace_callback_type_sched_switch' from incompatible pointer type [-Werror=incompatible-pointer-types]
      62 |         rv_attach_trace_probe("wwnr", sched_switch, handle_switch);
         |                                                     ^~~~~~~~~~~~~
         |                                                     |
         |                                                     void (*)(void *, bool,  struct task_struct *, struct task_struct *, unsigned int) {aka void (*)(void *, _Bool,  struct task_struct *, struct task_struct *, unsigned int)}
   include/rv/instrumentation.h:15:48: note: in definition of macro 'rv_attach_trace_probe'
      15 |                 check_trace_callback_type_##tp(rv_handler);                             \
         |                                                ^~~~~~~~~~
   In file included from kernel/trace/rv/monitors/wwnr/wwnr.c:3:
   include/linux/tracepoint.h:279:49: note: expected 'void (*)(void *, bool,  unsigned int,  struct task_struct *, struct task_struct *)' {aka 'void (*)(void *, _Bool,  unsigned int,  struct task_struct *, struct task_struct *)'} but argument is of type 'void (*)(void *, bool,  struct task_struct *, struct task_struct *, unsigned int)' {aka 'void (*)(void *, _Bool,  struct task_struct *, struct task_struct *, unsigned int)'}
     279 |         check_trace_callback_type_##name(void (*cb)(data_proto))        \
         |                                          ~~~~~~~^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:419:9: note: in expansion of macro '__DECLARE_TRACE'
     419 |         __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),              \
         |         ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:553:9: note: in expansion of macro 'DECLARE_TRACE'
     553 |         DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |         ^~~~~~~~~~~~~
   include/trace/events/sched.h:222:1: note: in expansion of macro 'TRACE_EVENT'
     222 | TRACE_EVENT(sched_switch,
         | ^~~~~~~~~~~
   In file included from include/linux/printk.h:11,
                    from include/linux/kernel.h:29,
                    from include/linux/interrupt.h:6,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/rv/monitors/wwnr/wwnr.c:2:
   kernel/trace/rv/monitors/wwnr/wwnr.c:62:53: error: passing argument 1 of 'register_trace_sched_switch' from incompatible pointer type [-Werror=incompatible-pointer-types]
      62 |         rv_attach_trace_probe("wwnr", sched_switch, handle_switch);
         |                                                     ^~~~~~~~~~~~~
         |                                                     |
         |                                                     void (*)(void *, bool,  struct task_struct *, struct task_struct *, unsigned int) {aka void (*)(void *, _Bool,  struct task_struct *, struct task_struct *, unsigned int)}
   include/linux/once_lite.h:15:41: note: in definition of macro 'DO_ONCE_LITE_IF'
      15 |                 bool __ret_do_once = !!(condition);                     \
         |                                         ^~~~~~~~~
   include/rv/instrumentation.h:16:17: note: in expansion of macro 'WARN_ONCE'
      16 |                 WARN_ONCE(register_trace_##tp(rv_handler, NULL),                        \
         |                 ^~~~~~~~~
   kernel/trace/rv/monitors/wwnr/wwnr.c:62:9: note: in expansion of macro 'rv_attach_trace_probe'
      62 |         rv_attach_trace_probe("wwnr", sched_switch, handle_switch);
         |         ^~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/trace/rv/monitors/wwnr/wwnr.c:3:
   include/linux/tracepoint.h:260:38: note: expected 'void (*)(void *, bool,  unsigned int,  struct task_struct *, struct task_struct *)' {aka 'void (*)(void *, _Bool,  unsigned int,  struct task_struct *, struct task_struct *)'} but argument is of type 'void (*)(void *, bool,  struct task_struct *, struct task_struct *, unsigned int)' {aka 'void (*)(void *, _Bool,  struct task_struct *, struct task_struct *, unsigned int)'}
     260 |         register_trace_##name(void (*probe)(data_proto), void *data)    \
         |                               ~~~~~~~^~~~~~~~~~~~~~~~~~
   include/linux/tracepoint.h:419:9: note: in expansion of macro '__DECLARE_TRACE'
     419 |         __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),              \
         |         ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:553:9: note: in expansion of macro 'DECLARE_TRACE'
     553 |         DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |         ^~~~~~~~~~~~~
   include/trace/events/sched.h:222:1: note: in expansion of macro 'TRACE_EVENT'
     222 | TRACE_EVENT(sched_switch,
         | ^~~~~~~~~~~
   In file included from kernel/trace/rv/monitors/wwnr/wwnr.c:8:
   kernel/trace/rv/monitors/wwnr/wwnr.c: In function 'stop_wwnr':
   kernel/trace/rv/monitors/wwnr/wwnr.c:72:53: error: passing argument 1 of 'unregister_trace_sched_switch' from incompatible pointer type [-Werror=incompatible-pointer-types]
      72 |         rv_detach_trace_probe("wwnr", sched_switch, handle_switch);
         |                                                     ^~~~~~~~~~~~~
         |                                                     |
         |                                                     void (*)(void *, bool,  struct task_struct *, struct task_struct *, unsigned int) {aka void (*)(void *, _Bool,  struct task_struct *, struct task_struct *, unsigned int)}
   include/rv/instrumentation.h:22:39: note: in definition of macro 'rv_detach_trace_probe'
      22 |                 unregister_trace_##tp(rv_handler, NULL);                                \
         |                                       ^~~~~~~~~~
   In file included from kernel/trace/rv/monitors/wwnr/wwnr.c:3:
   include/linux/tracepoint.h:273:40: note: expected 'void (*)(void *, bool,  unsigned int,  struct task_struct *, struct task_struct *)' {aka 'void (*)(void *, _Bool,  unsigned int,  struct task_struct *, struct task_struct *)'} but argument is of type 'void (*)(void *, bool,  struct task_struct *, struct task_struct *, unsigned int)' {aka 'void (*)(void *, _Bool,  struct task_struct *, struct task_struct *, unsigned int)'}
     273 |         unregister_trace_##name(void (*probe)(data_proto), void *data)  \
         |                                 ~~~~~~~^~~~~~~~~~~~~~~~~~
   include/linux/tracepoint.h:419:9: note: in expansion of macro '__DECLARE_TRACE'
     419 |         __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),              \
         |         ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:553:9: note: in expansion of macro 'DECLARE_TRACE'
     553 |         DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |         ^~~~~~~~~~~~~
   include/trace/events/sched.h:222:1: note: in expansion of macro 'TRACE_EVENT'
     222 | TRACE_EVENT(sched_switch,
         | ^~~~~~~~~~~
   kernel/trace/rv/monitors/wwnr/wwnr.c: At top level:
>> kernel/trace/rv/monitors/wwnr/wwnr.c:90:5: warning: no previous prototype for 'register_wwnr' [-Wmissing-prototypes]
      90 | int register_wwnr(void)
         |     ^~~~~~~~~~~~~
>> kernel/trace/rv/monitors/wwnr/wwnr.c:96:6: warning: no previous prototype for 'unregister_wwnr' [-Wmissing-prototypes]
      96 | void unregister_wwnr(void)
         |      ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/register_wwnr +90 kernel/trace/rv/monitors/wwnr/wwnr.c

13d11b21732323 Daniel Bristot de Oliveira 2022-06-16   89  
13d11b21732323 Daniel Bristot de Oliveira 2022-06-16  @90  int register_wwnr(void)
13d11b21732323 Daniel Bristot de Oliveira 2022-06-16   91  {
13d11b21732323 Daniel Bristot de Oliveira 2022-06-16   92  	rv_register_monitor(&rv_wwnr);
13d11b21732323 Daniel Bristot de Oliveira 2022-06-16   93  	return 0;
13d11b21732323 Daniel Bristot de Oliveira 2022-06-16   94  }
13d11b21732323 Daniel Bristot de Oliveira 2022-06-16   95  
13d11b21732323 Daniel Bristot de Oliveira 2022-06-16  @96  void unregister_wwnr(void)
13d11b21732323 Daniel Bristot de Oliveira 2022-06-16   97  {
13d11b21732323 Daniel Bristot de Oliveira 2022-06-16   98  	if (rv_wwnr.enabled)
13d11b21732323 Daniel Bristot de Oliveira 2022-06-16   99  		stop_wwnr();
13d11b21732323 Daniel Bristot de Oliveira 2022-06-16  100  
13d11b21732323 Daniel Bristot de Oliveira 2022-06-16  101  	rv_unregister_monitor(&rv_wwnr);
13d11b21732323 Daniel Bristot de Oliveira 2022-06-16  102  }
13d11b21732323 Daniel Bristot de Oliveira 2022-06-16  103  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
