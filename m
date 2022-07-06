Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F8156856F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiGFKYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiGFKYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:24:01 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182A9255B0;
        Wed,  6 Jul 2022 03:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657103039; x=1688639039;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zTFv7Opvp0eEPeRg+7RzVe5uBkJpvPK7zHsXwdYPXxo=;
  b=dd0mqhmKDR4UAwLrMoYTaQDuDUd52DQG20fjjPOiR7pGIgg8AQu5yW3g
   EWduoAFbW4kAaEilxXoEcIa/un5ihARrDhnt0Dtp+C/UeUuu4tel2MioJ
   0iRWyP0Kg9ZoxMzfIK8LBHUgYpd9BLPhku2oCfgp9bzpL8kQv9usfeS/x
   B5ouk1pD7cldYXCGnrhpgoO8PplIw+0+A/KED3p7PN6HZPKJ0WFo1RsOG
   Ak5XPmFAHz1/kFxFQp43og/kqBpKEUrVeSREBt4AIDJU7/bImA+frpuuk
   GlycG6TvHUnvormKn7AK+smewwgu9iE5cwdGXwFhrXf1tZC2p4WjH7Q9T
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="281256103"
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="281256103"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 03:23:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="543339999"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 06 Jul 2022 03:23:55 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o92CI-000KR3-PE;
        Wed, 06 Jul 2022 10:23:54 +0000
Date:   Wed, 6 Jul 2022 18:23:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 08/13] USB: mtu3: tracing: Use the new __vstring() helper
Message-ID: <202207061812.KyUeiLeY-lkp@intel.com>
References: <20220705224750.354926535@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705224750.354926535@goodmis.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on rostedt-trace/for-next]
[also build test ERROR on wireless-next/main wireless/main linus/master v5.19-rc5 next-20220705]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracing-events-Add-__vstring-and-__assign_vstr-helpers/20220706-065125
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git for-next
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220706/202207061812.KyUeiLeY-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/829b320ff9db68465d88e10181df019fffb775db
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Steven-Rostedt/tracing-events-Add-__vstring-and-__assign_vstr-helpers/20220706-065125
        git checkout 829b320ff9db68465d88e10181df019fffb775db
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/trace/define_trace.h:102,
                    from drivers/usb/mtu3/mtu3_trace.h:279,
                    from drivers/usb/mtu3/mtu3_trace.c:12:
>> drivers/usb/mtu3/./mtu3_trace.h:28:50: error: expected specifier-qualifier-list before ',' token
      28 |                 __vstring(msg, vaf->fmt, vaf->va),
         |                                                  ^
   include/trace/trace_events.h:54:17: note: in definition of macro 'DECLARE_EVENT_CLASS'
      54 |                 tstruct                                                 \
         |                 ^~~~~~~
   include/trace/trace_events.h:43:30: note: in expansion of macro 'PARAMS'
      43 |                              PARAMS(tstruct),                  \
         |                              ^~~~~~
   drivers/usb/mtu3/./mtu3_trace.h:23:1: note: in expansion of macro 'TRACE_EVENT'
      23 | TRACE_EVENT(mtu3_log,
         | ^~~~~~~~~~~
   drivers/usb/mtu3/./mtu3_trace.h:26:9: note: in expansion of macro 'TP_STRUCT__entry'
      26 |         TP_STRUCT__entry(
         |         ^~~~~~~~~~~~~~~~
   In file included from include/trace/define_trace.h:102,
                    from drivers/usb/mtu3/mtu3_trace.h:279,
                    from drivers/usb/mtu3/mtu3_trace.c:12:
>> drivers/usb/mtu3/./mtu3_trace.h:28:50: error: expected specifier-qualifier-list before ',' token
      28 |                 __vstring(msg, vaf->fmt, vaf->va),
         |                                                  ^
   include/trace/trace_events.h:117:17: note: in definition of macro 'DECLARE_EVENT_CLASS'
     117 |                 tstruct;                                                \
         |                 ^~~~~~~
   include/trace/trace_events.h:43:30: note: in expansion of macro 'PARAMS'
      43 |                              PARAMS(tstruct),                  \
         |                              ^~~~~~
   drivers/usb/mtu3/./mtu3_trace.h:23:1: note: in expansion of macro 'TRACE_EVENT'
      23 | TRACE_EVENT(mtu3_log,
         | ^~~~~~~~~~~
   drivers/usb/mtu3/./mtu3_trace.h:26:9: note: in expansion of macro 'TP_STRUCT__entry'
      26 |         TP_STRUCT__entry(
         |         ^~~~~~~~~~~~~~~~
   In file included from include/trace/define_trace.h:102,
                    from drivers/usb/mtu3/mtu3_trace.h:279,
                    from drivers/usb/mtu3/mtu3_trace.c:12:
>> drivers/usb/mtu3/./mtu3_trace.h:28:50: error: expected expression before ',' token
      28 |                 __vstring(msg, vaf->fmt, vaf->va),
         |                                                  ^
   include/trace/trace_events.h:244:9: note: in definition of macro 'DECLARE_EVENT_CLASS'
     244 |         tstruct                                                         \
         |         ^~~~~~~
   include/trace/trace_events.h:43:30: note: in expansion of macro 'PARAMS'
      43 |                              PARAMS(tstruct),                  \
         |                              ^~~~~~
   drivers/usb/mtu3/./mtu3_trace.h:23:1: note: in expansion of macro 'TRACE_EVENT'
      23 | TRACE_EVENT(mtu3_log,
         | ^~~~~~~~~~~
   drivers/usb/mtu3/./mtu3_trace.h:26:9: note: in expansion of macro 'TP_STRUCT__entry'
      26 |         TP_STRUCT__entry(
         |         ^~~~~~~~~~~~~~~~
   In file included from include/trace/define_trace.h:102,
                    from drivers/usb/mtu3/mtu3_trace.h:279,
                    from drivers/usb/mtu3/mtu3_trace.c:12:
   drivers/usb/mtu3/./mtu3_trace.h: In function 'trace_event_get_offsets_mtu3_log':
>> include/linux/stddef.h:16:33: error: 'struct trace_event_raw_mtu3_log' has no member named '__data'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:263:9: note: in definition of macro 'DECLARE_EVENT_CLASS'
     263 |         tstruct;                                                        \
         |         ^~~~~~~
   include/trace/trace_events.h:43:30: note: in expansion of macro 'PARAMS'
      43 |                              PARAMS(tstruct),                  \
         |                              ^~~~~~
   drivers/usb/mtu3/./mtu3_trace.h:23:1: note: in expansion of macro 'TRACE_EVENT'
      23 | TRACE_EVENT(mtu3_log,
         | ^~~~~~~~~~~
   drivers/usb/mtu3/./mtu3_trace.h:26:9: note: in expansion of macro 'TP_STRUCT__entry'
      26 |         TP_STRUCT__entry(
         |         ^~~~~~~~~~~~~~~~
   include/trace/stages/stage5_get_offsets.h:31:32: note: in expansion of macro 'offsetof'
      31 |                                offsetof(typeof(*entry), __data);        \
         |                                ^~~~~~~~
   include/trace/stages/stage5_get_offsets.h:36:29: note: in expansion of macro '__dynamic_array'
      36 | #define __string(item, src) __dynamic_array(char, item,                 \
         |                             ^~~~~~~~~~~~~~~
   drivers/usb/mtu3/./mtu3_trace.h:27:17: note: in expansion of macro '__string'
      27 |                 __string(name, dev_name(dev))
         |                 ^~~~~~~~
>> include/linux/stddef.h:16:33: error: 'struct trace_event_raw_mtu3_log' has no member named '__data'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:263:9: note: in definition of macro 'DECLARE_EVENT_CLASS'
     263 |         tstruct;                                                        \
         |         ^~~~~~~
   include/trace/trace_events.h:43:30: note: in expansion of macro 'PARAMS'
      43 |                              PARAMS(tstruct),                  \
         |                              ^~~~~~
   drivers/usb/mtu3/./mtu3_trace.h:23:1: note: in expansion of macro 'TRACE_EVENT'
      23 | TRACE_EVENT(mtu3_log,
         | ^~~~~~~~~~~
   drivers/usb/mtu3/./mtu3_trace.h:26:9: note: in expansion of macro 'TP_STRUCT__entry'
      26 |         TP_STRUCT__entry(
         |         ^~~~~~~~~~~~~~~~
   include/trace/stages/stage5_get_offsets.h:31:32: note: in expansion of macro 'offsetof'
      31 |                                offsetof(typeof(*entry), __data);        \
         |                                ^~~~~~~~
   include/trace/stages/stage5_get_offsets.h:43:34: note: in expansion of macro '__dynamic_array'
      43 | #define __vstring(item, fmt, ap) __dynamic_array(char, item,            \
         |                                  ^~~~~~~~~~~~~~~
   drivers/usb/mtu3/./mtu3_trace.h:28:17: note: in expansion of macro '__vstring'
      28 |                 __vstring(msg, vaf->fmt, vaf->va),
         |                 ^~~~~~~~~
>> drivers/usb/mtu3/./mtu3_trace.h:28:50: error: expected expression before ',' token
      28 |                 __vstring(msg, vaf->fmt, vaf->va),
         |                                                  ^
   include/trace/trace_events.h:263:9: note: in definition of macro 'DECLARE_EVENT_CLASS'
     263 |         tstruct;                                                        \
         |         ^~~~~~~
   include/trace/trace_events.h:43:30: note: in expansion of macro 'PARAMS'
      43 |                              PARAMS(tstruct),                  \
         |                              ^~~~~~
   drivers/usb/mtu3/./mtu3_trace.h:23:1: note: in expansion of macro 'TRACE_EVENT'
      23 | TRACE_EVENT(mtu3_log,
         | ^~~~~~~~~~~
   drivers/usb/mtu3/./mtu3_trace.h:26:9: note: in expansion of macro 'TP_STRUCT__entry'
      26 |         TP_STRUCT__entry(
         |         ^~~~~~~~~~~~~~~~
   drivers/usb/mtu3/./mtu3_trace.h:28:50: warning: left-hand operand of comma expression has no effect [-Wunused-value]
      28 |                 __vstring(msg, vaf->fmt, vaf->va),
         |                                                  ^
   include/trace/trace_events.h:263:9: note: in definition of macro 'DECLARE_EVENT_CLASS'
     263 |         tstruct;                                                        \
         |         ^~~~~~~
   include/trace/trace_events.h:43:30: note: in expansion of macro 'PARAMS'
      43 |                              PARAMS(tstruct),                  \
         |                              ^~~~~~
   drivers/usb/mtu3/./mtu3_trace.h:23:1: note: in expansion of macro 'TRACE_EVENT'
      23 | TRACE_EVENT(mtu3_log,
         | ^~~~~~~~~~~
   drivers/usb/mtu3/./mtu3_trace.h:26:9: note: in expansion of macro 'TP_STRUCT__entry'
      26 |         TP_STRUCT__entry(
         |         ^~~~~~~~~~~~~~~~
   In file included from include/trace/define_trace.h:102,
                    from drivers/usb/mtu3/mtu3_trace.h:279,
                    from drivers/usb/mtu3/mtu3_trace.c:12:
   drivers/usb/mtu3/./mtu3_trace.h: In function 'trace_event_raw_event_mtu3_log':
>> drivers/usb/mtu3/./mtu3_trace.h:28:50: error: expected expression before ',' token
      28 |                 __vstring(msg, vaf->fmt, vaf->va),
         |                                                  ^
   include/trace/trace_events.h:400:9: note: in definition of macro 'DECLARE_EVENT_CLASS'
     400 |         tstruct                                                         \
         |         ^~~~~~~
   include/trace/trace_events.h:43:30: note: in expansion of macro 'PARAMS'
      43 |                              PARAMS(tstruct),                  \
         |                              ^~~~~~
   drivers/usb/mtu3/./mtu3_trace.h:23:1: note: in expansion of macro 'TRACE_EVENT'
      23 | TRACE_EVENT(mtu3_log,
         | ^~~~~~~~~~~
   drivers/usb/mtu3/./mtu3_trace.h:26:9: note: in expansion of macro 'TP_STRUCT__entry'
      26 |         TP_STRUCT__entry(
         |         ^~~~~~~~~~~~~~~~
   drivers/usb/mtu3/./mtu3_trace.h:28:50: warning: left-hand operand of comma expression has no effect [-Wunused-value]
      28 |                 __vstring(msg, vaf->fmt, vaf->va),
         |                                                  ^
   include/trace/trace_events.h:400:9: note: in definition of macro 'DECLARE_EVENT_CLASS'
     400 |         tstruct                                                         \
         |         ^~~~~~~
   include/trace/trace_events.h:43:30: note: in expansion of macro 'PARAMS'
      43 |                              PARAMS(tstruct),                  \
         |                              ^~~~~~
   drivers/usb/mtu3/./mtu3_trace.h:23:1: note: in expansion of macro 'TRACE_EVENT'
      23 | TRACE_EVENT(mtu3_log,
         | ^~~~~~~~~~~
   drivers/usb/mtu3/./mtu3_trace.h:26:9: note: in expansion of macro 'TP_STRUCT__entry'
      26 |         TP_STRUCT__entry(
         |         ^~~~~~~~~~~~~~~~
   In file included from include/trace/define_trace.h:103,
                    from drivers/usb/mtu3/mtu3_trace.h:279,
                    from drivers/usb/mtu3/mtu3_trace.c:12:
   drivers/usb/mtu3/./mtu3_trace.h: In function 'perf_trace_mtu3_log':
>> drivers/usb/mtu3/./mtu3_trace.h:28:50: error: expected expression before ',' token
      28 |                 __vstring(msg, vaf->fmt, vaf->va),
         |                                                  ^
   include/trace/perf.h:87:9: note: in definition of macro 'DECLARE_EVENT_CLASS'
      87 |         tstruct                                                         \
         |         ^~~~~~~
   include/trace/trace_events.h:43:30: note: in expansion of macro 'PARAMS'
      43 |                              PARAMS(tstruct),                  \
         |                              ^~~~~~
   drivers/usb/mtu3/./mtu3_trace.h:23:1: note: in expansion of macro 'TRACE_EVENT'
      23 | TRACE_EVENT(mtu3_log,
         | ^~~~~~~~~~~
   drivers/usb/mtu3/./mtu3_trace.h:26:9: note: in expansion of macro 'TP_STRUCT__entry'
      26 |         TP_STRUCT__entry(
         |         ^~~~~~~~~~~~~~~~
   drivers/usb/mtu3/./mtu3_trace.h:28:50: warning: left-hand operand of comma expression has no effect [-Wunused-value]
      28 |                 __vstring(msg, vaf->fmt, vaf->va),
         |                                                  ^
   include/trace/perf.h:87:9: note: in definition of macro 'DECLARE_EVENT_CLASS'
      87 |         tstruct                                                         \
         |         ^~~~~~~
   include/trace/trace_events.h:43:30: note: in expansion of macro 'PARAMS'
      43 |                              PARAMS(tstruct),                  \
         |                              ^~~~~~
   drivers/usb/mtu3/./mtu3_trace.h:23:1: note: in expansion of macro 'TRACE_EVENT'
      23 | TRACE_EVENT(mtu3_log,
         | ^~~~~~~~~~~
   drivers/usb/mtu3/./mtu3_trace.h:26:9: note: in expansion of macro 'TP_STRUCT__entry'
      26 |         TP_STRUCT__entry(
         |         ^~~~~~~~~~~~~~~~
   include/trace/perf.h:62:13: warning: unused variable '__count' [-Wunused-variable]
      62 |         u64 __count = 1;                                                \
         |             ^~~~~~~
   include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      40 |         DECLARE_EVENT_CLASS(name,                              \
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/usb/mtu3/./mtu3_trace.h:23:1: note: in expansion of macro 'TRACE_EVENT'
      23 | TRACE_EVENT(mtu3_log,
         | ^~~~~~~~~~~


vim +28 drivers/usb/mtu3/./mtu3_trace.h

    22	
    23	TRACE_EVENT(mtu3_log,
    24		TP_PROTO(struct device *dev, struct va_format *vaf),
    25		TP_ARGS(dev, vaf),
    26		TP_STRUCT__entry(
    27			__string(name, dev_name(dev))
  > 28			__vstring(msg, vaf->fmt, vaf->va),
    29		),
    30		TP_fast_assign(
    31			__assign_str(name, dev_name(dev));
    32			__assign_vstr(msg, vaf->fmt, vaf->va);
    33		),
    34		TP_printk("%s: %s", __get_str(name), __get_str(msg))
    35	);
    36	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
