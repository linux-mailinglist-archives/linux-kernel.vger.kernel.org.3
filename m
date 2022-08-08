Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D1358CC49
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbiHHQmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbiHHQme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:42:34 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D86C1115A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 09:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659976953; x=1691512953;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=avnfgzlfEoQCmF7FBMt8PwIoOSWbRaTT4jZrOJgNx6U=;
  b=FSaXx4MQ7XGyVTuU05ZQLjZIfnjazHTNo9FKUVwEycuxc0VUXOc7vNQe
   XfFwR1d8OiWdEKVrFLZGSGgNRZMW2VvmBqvkXDn98Y2KrjqUBtj/ALNxX
   SO2/HpZUJnJBrwsIudIn4BdUlzPHpkwP500vrOZgCKFP1mM4BcS/CWv34
   ybb9MTzIMY/NneW3HTYg+fCyCfunb5YR0OXFIozAk56TlvE81/RPVtLcs
   zW9Y5F5Z/jNB/PDcMLCwQvqucwu3sTp1jwVFDqRVQOc/TlUsKOX9bwRvb
   6xFxwZmSllLZJr5bBl8PAglywJIamZ+5NUQ8nHquYyG+YGoAOgkuuxaqy
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="290646179"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="290646179"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 09:42:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="637373638"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 08 Aug 2022 09:42:30 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oL5pl-000MQX-1O;
        Mon, 08 Aug 2022 16:42:29 +0000
Date:   Tue, 9 Aug 2022 00:42:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH v4 7/9] sched/fair: allow changing cgroup of new forked
 task
Message-ID: <202208090027.Lo1M3CoX-lkp@intel.com>
References: <20220808125745.22566-8-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808125745.22566-8-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chengming,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on linus/master next-20220808]
[cannot apply to v5.19]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chengming-Zhou/sched-fair-task-load-tracking-optimization-and-cleanup/20220808-210012
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 8648f92a66a323ed01903d2cbb248cdbe2f312d9
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220809/202208090027.Lo1M3CoX-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/05baf61c579ea60e2b6447a012edcc5bf5f43835
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Chengming-Zhou/sched-fair-task-load-tracking-optimization-and-cleanup/20220808-210012
        git checkout 05baf61c579ea60e2b6447a012edcc5bf5f43835
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/sched/fair.c:672:5: warning: no previous prototype for 'sched_update_scaling' [-Wmissing-prototypes]
     672 | int sched_update_scaling(void)
         |     ^~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c: In function 'task_change_group_fair':
>> kernel/sched/fair.c:11676:27: error: 'se' undeclared (first use in this function); did you mean 'sem'?
   11676 |         if (!p->on_rq && !se->sum_exec_runtime)
         |                           ^~
         |                           sem
   kernel/sched/fair.c:11676:27: note: each undeclared identifier is reported only once for each function it appears in


vim +11676 kernel/sched/fair.c

 11668	
 11669	#ifdef CONFIG_FAIR_GROUP_SCHED
 11670	static void task_change_group_fair(struct task_struct *p)
 11671	{
 11672		/*
 11673		 * We couldn't detach or attach a forked task which
 11674		 * hasn't been woken up by wake_up_new_task().
 11675		 */
 11676		if (!p->on_rq && !se->sum_exec_runtime)
 11677			return;
 11678	
 11679		detach_task_cfs_rq(p);
 11680	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
