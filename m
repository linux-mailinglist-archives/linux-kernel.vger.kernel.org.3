Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6685258A2E0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 23:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237219AbiHDVto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 17:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbiHDVtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 17:49:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AC615FE4;
        Thu,  4 Aug 2022 14:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659649779; x=1691185779;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8U6FcQ8c0l3GTCtMzyyAZP0wpNsLJN1YtQRIuis9FOk=;
  b=ckYdtKGp9SuEZqb3vse89byfwmM+tHJYZ5MzPUeG1HzkAYb+VM9l6Vyf
   o6h1rbwpDHRQVtjWYOtVmJH6O81It/Y+jVFlmgOUfBaKH+XNf2h9lK6wH
   86ByAhp31wV+T2p7Ou+zuv37+ZmaiqrTBrVYC8km5NeavLO5f7KCkBTsY
   ihCzsfdWw4KVEGxLjf9Zn4cg1lroyak2RUz+LQVr9Br4QB7eQhd5/eWds
   UNmuTMqgCRN0IDEpa6nPeg5KvjUlDuTwCvx/X/ow81emYMcQtp06Sd1N/
   92TSNchP/zKUPlExX+MlGFveKiTINZCapShjjizwiQbmPEBwhNPhdRV2e
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="287615131"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="287615131"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 14:49:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="930985232"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 04 Aug 2022 14:49:36 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJiil-000Ish-3A;
        Thu, 04 Aug 2022 21:49:35 +0000
Date:   Fri, 5 Aug 2022 05:48:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yang Jihong <yangjihong1@huawei.com>, rostedt@goodmis.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     kbuild-all@lists.01.org, yangjihong1@huawei.com
Subject: Re: [PATCH] perf/core: Fix syzkaller reported issue "Internal error
 in read_pmevcntrn"
Message-ID: <202208050525.mCzcYS6u-lkp@intel.com>
References: <20220804105918.113833-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804105918.113833-1-yangjihong1@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/perf/core]
[also build test ERROR on linus/master v5.19 next-20220804]
[cannot apply to acme/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yang-Jihong/perf-core-Fix-syzkaller-reported-issue-Internal-error-in-read_pmevcntrn/20220804-190347
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 326ecc15c61c349cd49d1700ff9e3e31c6fd1cd5
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220805/202208050525.mCzcYS6u-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/9c758a8d3d13d1ac89f651850b79d91b23b41b02
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yang-Jihong/perf-core-Fix-syzkaller-reported-issue-Internal-error-in-read_pmevcntrn/20220804-190347
        git checkout 9c758a8d3d13d1ac89f651850b79d91b23b41b02
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/spinlock.h:54,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from kernel/events/core.c:11:
   kernel/events/core.c: In function 'perf_output_read_group':
>> kernel/events/core.c:6942:27: error: 'flags' undeclared (first use in this function)
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
   include/linux/typecheck.h:12:25: warning: comparison of distinct pointer types lacks a cast
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
   include/linux/typecheck.h:12:25: warning: comparison of distinct pointer types lacks a cast
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


vim +/flags +6942 kernel/events/core.c

  6896	
  6897	static void perf_output_read_group(struct perf_output_handle *handle,
  6898				    struct perf_event *event,
  6899				    u64 enabled, u64 running)
  6900	{
  6901		struct perf_event *leader = event->group_leader, *sub;
  6902		u64 read_format = event->attr.read_format;
  6903		u64 values[6];
  6904		int n = 0;
  6905	
  6906		values[n++] = 1 + leader->nr_siblings;
  6907	
  6908		if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
  6909			values[n++] = enabled;
  6910	
  6911		if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
  6912			values[n++] = running;
  6913	
  6914		if ((leader != event) &&
  6915		    (leader->state == PERF_EVENT_STATE_ACTIVE))
  6916			leader->pmu->read(leader);
  6917	
  6918		values[n++] = perf_event_count(leader);
  6919		if (read_format & PERF_FORMAT_ID)
  6920			values[n++] = primary_event_id(leader);
  6921		if (read_format & PERF_FORMAT_LOST)
  6922			values[n++] = atomic64_read(&leader->lost_samples);
  6923	
  6924		__output_copy(handle, values, n * sizeof(u64));
  6925	
  6926		for_each_sibling_event(sub, leader) {
  6927			n = 0;
  6928	
  6929			if ((sub != event) &&
  6930			    (sub->state == PERF_EVENT_STATE_ACTIVE))
  6931				sub->pmu->read(sub);
  6932	
  6933			values[n++] = perf_event_count(sub);
  6934			if (read_format & PERF_FORMAT_ID)
  6935				values[n++] = primary_event_id(sub);
  6936			if (read_format & PERF_FORMAT_LOST)
  6937				values[n++] = atomic64_read(&sub->lost_samples);
  6938	
  6939			__output_copy(handle, values, n * sizeof(u64));
  6940		}
  6941	
> 6942		local_irq_restore(flags);
  6943	}
  6944	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
