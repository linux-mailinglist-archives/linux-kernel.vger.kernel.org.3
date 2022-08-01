Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9F7587458
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 01:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbiHAXXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 19:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiHAXXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 19:23:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75EB1705C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 16:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659396178; x=1690932178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=swOJ3l92gUlUnJcNhVxrGy3A01xB1qD4kT3y/6yANsk=;
  b=jRag4EYCa8aDOfiX752L5AsSYZud6AGT8N6DS7pwsmTulqrtwEDeXyZn
   yQc4Fhfw9viCMT4jIijILxQv1wmmkzgDMKP8lYgk0+QtLmwBbSEsFkm11
   b7xOeM/un236qjewDrD/yTKl4Uu/lB34uIS1JbiWK3u00koratIwJzMz5
   zfe922zcLWfr9pxxmAdbxiBmj/04/xac2Uqp4ynbfbQosZzGhARe6i13c
   WWdw+CJAZAXEsK/2K9A81edMLNYY8CmE312NVhT4X8uWzQiRJ62ik68VA
   Y4X6w3ySicht1o0TJD2trrYKtW4LZZkWs2HFQLtnIYNa1Q40/nWDAGG7P
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="276180668"
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="276180668"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 16:22:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="744457433"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 01 Aug 2022 16:22:55 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIekR-000FTz-05;
        Mon, 01 Aug 2022 23:22:55 +0000
Date:   Tue, 2 Aug 2022 07:22:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH v3 08/10] sched/fair: refactor
 detach/attach_entity_cfs_rq using update_load_avg()
Message-ID: <202208020758.Ff3SOjvD-lkp@intel.com>
References: <20220801042745.7794-9-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801042745.7794-9-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chengming,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on linus/master next-20220728]
[cannot apply to v5.19]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chengming-Zhou/sched-fair-task-load-tracking-optimization-and-cleanup/20220801-122957
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 8da3d9b8590bc178752d4b72938745e9a6c4c416
config: hexagon-randconfig-r012-20220731 (https://download.01.org/0day-ci/archive/20220802/202208020758.Ff3SOjvD-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/336247ff1d2b402a18689fd891d79e99d8b444fc
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Chengming-Zhou/sched-fair-task-load-tracking-optimization-and-cleanup/20220801-122957
        git checkout 336247ff1d2b402a18689fd891d79e99d8b444fc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/sched/fair.c:4462:11: error: no member named 'avg' in 'struct sched_entity'
           if (!se->avg.last_update_time)
                ~~  ^
   1 error generated.


vim +4462 kernel/sched/fair.c

  4419	
  4420	/*
  4421	 * MIGRATION
  4422	 *
  4423	 *	dequeue
  4424	 *	  update_curr()
  4425	 *	    update_min_vruntime()
  4426	 *	  vruntime -= min_vruntime
  4427	 *
  4428	 *	enqueue
  4429	 *	  update_curr()
  4430	 *	    update_min_vruntime()
  4431	 *	  vruntime += min_vruntime
  4432	 *
  4433	 * this way the vruntime transition between RQs is done when both
  4434	 * min_vruntime are up-to-date.
  4435	 *
  4436	 * WAKEUP (remote)
  4437	 *
  4438	 *	->migrate_task_rq_fair() (p->state == TASK_WAKING)
  4439	 *	  vruntime -= min_vruntime
  4440	 *
  4441	 *	enqueue
  4442	 *	  update_curr()
  4443	 *	    update_min_vruntime()
  4444	 *	  vruntime += min_vruntime
  4445	 *
  4446	 * this way we don't have the most up-to-date min_vruntime on the originating
  4447	 * CPU and an up-to-date min_vruntime on the destination CPU.
  4448	 */
  4449	
  4450	static void
  4451	enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
  4452	{
  4453		bool renorm = !(flags & ENQUEUE_WAKEUP) || (flags & ENQUEUE_MIGRATED);
  4454		bool curr = cfs_rq->curr == se;
  4455		int action = UPDATE_TG;
  4456	
  4457		/*
  4458		 * !last_update_time means we've passed through migrate_task_rq_fair()
  4459		 * or task_change_group_fair() indicating we migrated cfs_rq. IOW we're
  4460		 * enqueueing a task on a new CPU or moving task to a new cgroup.
  4461		 */
> 4462		if (!se->avg.last_update_time)
  4463			action |= DO_ATTACH;
  4464	
  4465		/*
  4466		 * If we're the current task, we must renormalise before calling
  4467		 * update_curr().
  4468		 */
  4469		if (renorm && curr)
  4470			se->vruntime += cfs_rq->min_vruntime;
  4471	
  4472		update_curr(cfs_rq);
  4473	
  4474		/*
  4475		 * Otherwise, renormalise after, such that we're placed at the current
  4476		 * moment in time, instead of some random moment in the past. Being
  4477		 * placed in the past could significantly boost this task to the
  4478		 * fairness detriment of existing tasks.
  4479		 */
  4480		if (renorm && !curr)
  4481			se->vruntime += cfs_rq->min_vruntime;
  4482	
  4483		/*
  4484		 * When enqueuing a sched_entity, we must:
  4485		 *   - Update loads to have both entity and cfs_rq synced with now.
  4486		 *   - For group_entity, update its runnable_weight to reflect the new
  4487		 *     h_nr_running of its group cfs_rq.
  4488		 *   - For group_entity, update its weight to reflect the new share of
  4489		 *     its group cfs_rq
  4490		 *   - Add its new weight to cfs_rq->load.weight
  4491		 */
  4492		update_load_avg(cfs_rq, se, action);
  4493		se_update_runnable(se);
  4494		update_cfs_group(se);
  4495		account_entity_enqueue(cfs_rq, se);
  4496	
  4497		if (flags & ENQUEUE_WAKEUP)
  4498			place_entity(cfs_rq, se, 0);
  4499	
  4500		check_schedstat_required();
  4501		update_stats_enqueue_fair(cfs_rq, se, flags);
  4502		check_spread(cfs_rq, se);
  4503		if (!curr)
  4504			__enqueue_entity(cfs_rq, se);
  4505		se->on_rq = 1;
  4506	
  4507		if (cfs_rq->nr_running == 1) {
  4508			check_enqueue_throttle(cfs_rq);
  4509			if (!throttled_hierarchy(cfs_rq))
  4510				list_add_leaf_cfs_rq(cfs_rq);
  4511		}
  4512	}
  4513	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
