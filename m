Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA1F58A0EC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 20:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbiHDSzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 14:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiHDSzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 14:55:36 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C3C65A2;
        Thu,  4 Aug 2022 11:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659639335; x=1691175335;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vTjXRsL4lAnfzqth+z2XycE86BJ3XSQ3FJU78c46BNU=;
  b=Mb6Uom0PeUWSmRlY9CGzmj+0X2WD7MZhsWsdiOexQeKvk20aFjfoDsvI
   /zZqGi4MuD8Wt+AggIUZn9GRi1pZTr11UVWrhHHx0/0czibQNglDPRflx
   sGB4+2HO+1QP62LSvID/Gm57sY7h51Wi8GBARpvCyPnFBMaR7WmWAEVxG
   OINGlE6IGbtudnp4LV/ap+PtQUS/jWGibDyzg81invPpanUGII5/RPr5T
   9c6JEwIP+otOTttRlS/bGpj+/CYli9Cj6cJqhcGCbEjzUN9IodzJMNmOE
   jrUDJHbhWqq3YTmJHHTs0PCVEuWt22T2MQIZAkBJTH7Gl65P3vstdTnhu
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="288779234"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="288779234"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 11:55:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="671382107"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 04 Aug 2022 11:55:31 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJg0J-000Ijv-0J;
        Thu, 04 Aug 2022 18:55:31 +0000
Date:   Fri, 5 Aug 2022 02:55:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yang Jihong <yangjihong1@huawei.com>, rostedt@goodmis.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     kbuild-all@lists.01.org, yangjihong1@huawei.com
Subject: Re: [PATCH] perf/core: Fix syzkaller reported issue "Internal error
 in read_pmevcntrn"
Message-ID: <202208050241.9fLxoaz4-lkp@intel.com>
References: <20220804105918.113833-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804105918.113833-1-yangjihong1@huawei.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/perf/core]
[also build test WARNING on linus/master v5.19 next-20220803]
[cannot apply to acme/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yang-Jihong/perf-core-Fix-syzkaller-reported-issue-Internal-error-in-read_pmevcntrn/20220804-190347
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 326ecc15c61c349cd49d1700ff9e3e31c6fd1cd5
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220805/202208050241.9fLxoaz4-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/9c758a8d3d13d1ac89f651850b79d91b23b41b02
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yang-Jihong/perf-core-Fix-syzkaller-reported-issue-Internal-error-in-read_pmevcntrn/20220804-190347
        git checkout 9c758a8d3d13d1ac89f651850b79d91b23b41b02
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/events/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/spinlock.h:54,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from kernel/events/core.c:11:
   kernel/events/core.c: In function 'perf_output_read_group':
   kernel/events/core.c:6942:27: error: 'flags' undeclared (first use in this function)
    6942 |         local_irq_restore(flags);
         |                           ^~~~~
   include/linux/typecheck.h:11:16: note: in definition of macro 'typecheck'
      11 |         typeof(x) __dummy2; \
         |                ^
   include/linux/irqflags.h:228:22: note: in expansion of macro 'raw_irqs_disabled_flags'
     228 |                 if (!raw_irqs_disabled_flags(flags))    \
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/events/core.c:6942:9: note: in expansion of macro 'local_irq_restore'
    6942 |         local_irq_restore(flags);
         |         ^~~~~~~~~~~~~~~~~
   kernel/events/core.c:6942:27: note: each undeclared identifier is reported only once for each function it appears in
    6942 |         local_irq_restore(flags);
         |                           ^~~~~
   include/linux/typecheck.h:11:16: note: in definition of macro 'typecheck'
      11 |         typeof(x) __dummy2; \
         |                ^
   include/linux/irqflags.h:228:22: note: in expansion of macro 'raw_irqs_disabled_flags'
     228 |                 if (!raw_irqs_disabled_flags(flags))    \
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/events/core.c:6942:9: note: in expansion of macro 'local_irq_restore'
    6942 |         local_irq_restore(flags);
         |         ^~~~~~~~~~~~~~~~~
>> include/linux/typecheck.h:12:25: warning: comparison of distinct pointer types lacks a cast
      12 |         (void)(&__dummy == &__dummy2); \
         |                         ^~
   include/linux/irqflags.h:193:17: note: in expansion of macro 'typecheck'
     193 |                 typecheck(unsigned long, flags);        \
         |                 ^~~~~~~~~
   include/linux/irqflags.h:228:22: note: in expansion of macro 'raw_irqs_disabled_flags'
     228 |                 if (!raw_irqs_disabled_flags(flags))    \
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/events/core.c:6942:9: note: in expansion of macro 'local_irq_restore'
    6942 |         local_irq_restore(flags);
         |         ^~~~~~~~~~~~~~~~~
>> include/linux/typecheck.h:12:25: warning: comparison of distinct pointer types lacks a cast
      12 |         (void)(&__dummy == &__dummy2); \
         |                         ^~
   include/linux/irqflags.h:182:17: note: in expansion of macro 'typecheck'
     182 |                 typecheck(unsigned long, flags);        \
         |                 ^~~~~~~~~
   include/linux/irqflags.h:230:17: note: in expansion of macro 'raw_local_irq_restore'
     230 |                 raw_local_irq_restore(flags);           \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   kernel/events/core.c:6942:9: note: in expansion of macro 'local_irq_restore'
    6942 |         local_irq_restore(flags);
         |         ^~~~~~~~~~~~~~~~~


vim +12 include/linux/typecheck.h

e0deaff470900a4c Andrew Morton 2008-07-25   4  
e0deaff470900a4c Andrew Morton 2008-07-25   5  /*
e0deaff470900a4c Andrew Morton 2008-07-25   6   * Check at compile time that something is of a particular type.
e0deaff470900a4c Andrew Morton 2008-07-25   7   * Always evaluates to 1 so you may use it easily in comparisons.
e0deaff470900a4c Andrew Morton 2008-07-25   8   */
e0deaff470900a4c Andrew Morton 2008-07-25   9  #define typecheck(type,x) \
e0deaff470900a4c Andrew Morton 2008-07-25  10  ({	type __dummy; \
e0deaff470900a4c Andrew Morton 2008-07-25  11  	typeof(x) __dummy2; \
e0deaff470900a4c Andrew Morton 2008-07-25 @12  	(void)(&__dummy == &__dummy2); \
e0deaff470900a4c Andrew Morton 2008-07-25  13  	1; \
e0deaff470900a4c Andrew Morton 2008-07-25  14  })
e0deaff470900a4c Andrew Morton 2008-07-25  15  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
