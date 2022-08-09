Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E87258DBB5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 18:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243144AbiHIQPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 12:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244345AbiHIQO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 12:14:56 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9629520185
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 09:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660061695; x=1691597695;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Db+20hz4Jvt9aAulGa5NPWLwUz6HQDnkG0RPi62lamg=;
  b=Yn6+YVPcKuzN5A8z3vdKUi019s4DwK/xL86LNXIj8D6WnYX3GK0/c8t7
   TBMP/g2otvU/z9ECUNnYnuNHHTJm7/pr+hubo7gDH0UJvtmkr4JC4QZKw
   gfc07v+VcofoqM73oyZ7fQ2Hw/oP6w1DpK7Mtc11VYBA00kOFLmoYoXzY
   oicRkzhHBCcUxBKBFU/xwZBDt8PUwyKp8KcWQst9LHxZ3bPBVJBC5iXL+
   E0vQHamwhaEdg24xSVmsGrfmtAQnQWpSJOiro+9JJGB7iN3diJZwn0Ujl
   3o6k5/9hICb7jJxNVCbE6i8PjrbwA82DGbGCjlx0YIN+wtVdw1k7jT9YE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="291660511"
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="291660511"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 09:14:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="637772441"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 09 Aug 2022 09:14:52 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLRsZ-000N3i-1V;
        Tue, 09 Aug 2022 16:14:51 +0000
Date:   Wed, 10 Aug 2022 00:14:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     zhangsong <zhangsong34@huawei.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     kbuild-all@lists.01.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, zhangsong <zhangsong34@huawei.com>
Subject: Re: [PATCH] sched/fair: Introduce priority load balance to reduce
 interference from IDLE tasks
Message-ID: <202208100012.psioE872-lkp@intel.com>
References: <20220809132945.3710583-1-zhangsong34@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809132945.3710583-1-zhangsong34@huawei.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi zhangsong,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on linus/master v5.19 next-20220809]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/zhangsong/sched-fair-Introduce-priority-load-balance-to-reduce-interference-from-IDLE-tasks/20220809-213204
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 8648f92a66a323ed01903d2cbb248cdbe2f312d9
config: um-x86_64_defconfig (https://download.01.org/0day-ci/archive/20220810/202208100012.psioE872-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/20ac252fc4280e5b1a45070d722c7edc0695088b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review zhangsong/sched-fair-Introduce-priority-load-balance-to-reduce-interference-from-IDLE-tasks/20220809-213204
        git checkout 20ac252fc4280e5b1a45070d722c7edc0695088b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/sched/fair.c:672:5: warning: no previous prototype for 'sched_update_scaling' [-Wmissing-prototypes]
     672 | int sched_update_scaling(void)
         |     ^~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c: In function 'adjust_rq_cfs_tasks':
>> kernel/sched/fair.c:3045:48: error: 'struct rq' has no member named 'cfs_idle_tasks'
    3045 |                 (*list_op)(&se->group_node, &rq->cfs_idle_tasks);
         |                                                ^~
>> kernel/sched/fair.c:3047:48: error: 'struct rq' has no member named 'cfs_tasks'
    3047 |                 (*list_op)(&se->group_node, &rq->cfs_tasks);
         |                                                ^~
   At top level:
   kernel/sched/fair.c:3038:1: warning: 'adjust_rq_cfs_tasks' defined but not used [-Wunused-function]
    3038 | adjust_rq_cfs_tasks(void (*list_op)(struct list_head *, struct list_head *),
         | ^~~~~~~~~~~~~~~~~~~


vim +3045 kernel/sched/fair.c

  3036	
  3037	static void
  3038	adjust_rq_cfs_tasks(void (*list_op)(struct list_head *, struct list_head *),
  3039		struct rq *rq,
  3040		struct sched_entity *se)
  3041	{
  3042		struct cfs_rq *cfs_rq = cfs_rq_of(se);
  3043	
  3044		if (task_has_idle_policy(task_of(se)) || tg_is_idle(cfs_rq->tg))
> 3045			(*list_op)(&se->group_node, &rq->cfs_idle_tasks);
  3046		else
> 3047			(*list_op)(&se->group_node, &rq->cfs_tasks);
  3048	}
  3049	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
