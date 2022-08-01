Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB451586600
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 10:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiHAII2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 04:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiHAII0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:08:26 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A262559A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 01:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659341305; x=1690877305;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C06WS2r1ruyf0avxtc3Jbb0p13U3m1KBZxu/GZiqEBU=;
  b=MST4wN6cACveqUFozltgP2vr9sOFeDNdjV99uoZl3pxPHS0x5p+PSq1V
   Qw+HoSsp3PqTXu0zDDsPfOfoJ1D9YricnHTNShzereL774h26w2BtAgU6
   4AGaCeTFLEHM4qbRwoHjQnp2/SQAkmRpgXf/+5BOvneSNZVLg5oX/v8Mm
   E8wHHHt2YK7/YKuvSLAy8Fq6XIIv3BwzgaySTQ1OozlEUETJxka80Wl1A
   5jCf8LhsEzjmpBq8Ntaf9cevHSbkGTw9/tTLn22YdSatZ43UvFE6s8u5a
   PBdc6NhoNCyAo1Pbc5aq6GWR6uJ+NlKYl+lIKBaRrZlcK1mK10ztgcst1
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="375394208"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="375394208"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 01:08:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="669959794"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 01 Aug 2022 01:08:22 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIQTN-000Ex7-2x;
        Mon, 01 Aug 2022 08:08:21 +0000
Date:   Mon, 1 Aug 2022 16:07:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH v3 08/10] sched/fair: refactor
 detach/attach_entity_cfs_rq using update_load_avg()
Message-ID: <202208011647.2KU7IF9Y-lkp@intel.com>
References: <20220801042745.7794-9-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801042745.7794-9-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chengming,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on next-20220728]
[cannot apply to linus/master v5.19]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chengming-Zhou/sched-fair-task-load-tracking-optimization-and-cleanup/20220801-122957
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 8da3d9b8590bc178752d4b72938745e9a6c4c416
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220801/202208011647.2KU7IF9Y-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/336247ff1d2b402a18689fd891d79e99d8b444fc
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Chengming-Zhou/sched-fair-task-load-tracking-optimization-and-cleanup/20220801-122957
        git checkout 336247ff1d2b402a18689fd891d79e99d8b444fc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/sched/fair.c:672:5: warning: no previous prototype for 'sched_update_scaling' [-Wmissing-prototypes]
     672 | int sched_update_scaling(void)
         |     ^~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c: In function 'enqueue_entity':
>> kernel/sched/fair.c:4462:16: error: 'struct sched_entity' has no member named 'avg'
    4462 |         if (!se->avg.last_update_time)
         |                ^~


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
