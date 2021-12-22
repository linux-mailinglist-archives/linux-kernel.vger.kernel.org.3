Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A5647D70E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344830AbhLVSmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:42:04 -0500
Received: from mga06.intel.com ([134.134.136.31]:15810 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233997AbhLVSmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:42:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640198523; x=1671734523;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tzIF3/lUCjxHNH9giWumAG4yOwl++0r7w96AeDoP4C0=;
  b=cNbFGU69AAaCK+Gz6qvr6CnnUFuJruZ4vjenZtEo8KlUwKjO0znowJlj
   9d6U0v1dzghh0cee5IskpR1BPtqNwQHUhtqz6pQFqwmp+4a3QLsyMGvfs
   /Of7sYmC1bXvIqfOebVW2Wf7nXYglw17NWGNAmGnuqd7V3I8ClZjR01q/
   k+2Yu9wUk2zApvAzG9n24VxV42MM9S8T95539PTqxlMo6LwMwjJN9WUwG
   r4l2mASjIaHsvshN+xxA+9bEsvr3VJvMiNo6TY5GtfjY0TJjnQfz6D9+/
   BO4XG3k4iWzhoJVN25cVtqUvetNUaZ3ukFcxpQ8VkRRESTMyPxPb2Vnaa
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="301454660"
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="301454660"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 10:42:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="484849634"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 22 Dec 2021 10:41:59 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n06Yo-0000qu-O4; Wed, 22 Dec 2021 18:41:58 +0000
Date:   Thu, 23 Dec 2021 02:41:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "zhaoxiu.zeng" <zhaoxiu.zeng@gmail.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     kbuild-all@lists.01.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] schedule: SCHED_RR: Give a fresh time-slice to the task
 after after it suspends or relinquishes
Message-ID: <202112230234.B6uAyy2x-lkp@intel.com>
References: <20211222091526.8511-1-zhaoxiu.zeng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222091526.8511-1-zhaoxiu.zeng@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "zhaoxiu.zeng",

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on v5.16-rc6 next-20211222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/zhaoxiu-zeng/schedule-SCHED_RR-Give-a-fresh-time-slice-to-the-task-after-after-it-suspends-or-relinquishes/20211222-171838
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 82762d2af31a60081162890983a83499c9c7dd74
config: i386-randconfig-s001-20211222 (https://download.01.org/0day-ci/archive/20211223/202112230234.B6uAyy2x-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/7e5fd85c65d2efc13de4adaa5ebc522894f3d60c
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review zhaoxiu-zeng/schedule-SCHED_RR-Give-a-fresh-time-slice-to-the-task-after-after-it-suspends-or-relinquishes/20211222-171838
        git checkout 7e5fd85c65d2efc13de4adaa5ebc522894f3d60c
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   kernel/sched/rt.c:924:70: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/rt.c:924:70: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/rt.c:924:70: sparse:    struct task_struct *
   kernel/sched/rt.c:1010:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:1010:38: sparse:     expected struct task_struct *curr
   kernel/sched/rt.c:1010:38: sparse:     got struct task_struct [noderef] __rcu *curr
>> kernel/sched/rt.c:1560:35: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:1560:35: sparse:     expected struct task_struct *p
   kernel/sched/rt.c:1560:35: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c: note: in included file:
   kernel/sched/sched.h:2032:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2032:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2032:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2032:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2032:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2032:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2032:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2032:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2032:25: sparse:    struct task_struct *

vim +1560 kernel/sched/rt.c

  1557	
  1558	static void yield_task_rt(struct rq *rq)
  1559	{
> 1560		struct task_struct *p = rq->curr;
  1561	
  1562		if (p->policy == SCHED_RR)
  1563			p->rt.time_slice = sched_rr_timeslice;
  1564	
  1565		requeue_task_rt(rq, p, 0);
  1566	}
  1567	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
