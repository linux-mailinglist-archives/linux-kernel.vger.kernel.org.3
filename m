Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D61534C3C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 11:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346806AbiEZJFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 05:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346821AbiEZJFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 05:05:49 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325A3C6E47
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 02:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653555945; x=1685091945;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kEsf6LMdSMOflapG+PvkyXqMVBIJuUPjv9Fs8ZiXKgs=;
  b=PX+YBLbeQTmdNvnAyKWLrW5G1QomfD9wVTIJO0wY5glUuPgRRbfIOXnl
   6h8qbnfqE8yPZL9TlW98YEqcGciu4+5IMVlRljs9HzcgZNgMs6dXB06rv
   awZMX5MQ7lM5eRRYpkn4G1GgqYftPW2cmT5mB+5MR6s6u59VziT2DWMT8
   S7WqgYIIvDSJ7ZdBP63XS15uGvUCUYbqKeVCfUzFqsb6lxH7XomhGccAr
   +YuH0Yrlyl9/g83z5xaJwA8r5B/p2rB2NpyB1r8m7E2N5q9Ms5S11LQbQ
   8lPe1sdk8AAa7a6WnM9Gb8DFi7CISJpjQt5TvmBpDkxPJzQYTU/y1mrsG
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="254590697"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="254590697"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 02:05:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="901923413"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 26 May 2022 02:05:41 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nu9R6-0003jY-DW;
        Thu, 26 May 2022 09:05:40 +0000
Date:   Thu, 26 May 2022 16:53:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, odin@uged.al
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH v2 2/2] sched/fair: optimize and simplify rq
 leaf_cfs_rq_list
Message-ID: <202205261617.YUT1ixQ8-lkp@intel.com>
References: <20220526071354.6426-3-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526071354.6426-3-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
[also build test ERROR on tip/master linus/master v5.18 next-20220525]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Chengming-Zhou/sched-fair-optimize-and-simplify-rq-leaf_cfs_rq_list/20220526-151850
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 991d8d8142cad94f9c5c05db25e67fa83d6f772a
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20220526/202205261617.YUT1ixQ8-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/cb2b1810aeb3f8f290a932f3e625ab9df1110054
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Chengming-Zhou/sched-fair-optimize-and-simplify-rq-leaf_cfs_rq_list/20220526-151850
        git checkout cb2b1810aeb3f8f290a932f3e625ab9df1110054
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/sched/fair.c:645:5: warning: no previous prototype for 'sched_update_scaling' [-Wmissing-prototypes]
     645 | int sched_update_scaling(void)
         |     ^~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c: In function 'enqueue_entity':
>> kernel/sched/fair.c:4343:22: error: implicit declaration of function 'throttled_hierarchy' [-Werror=implicit-function-declaration]
    4343 |                 if (!throttled_hierarchy(cfs_rq))
         |                      ^~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c: At top level:
>> kernel/sched/fair.c:5484:19: error: static declaration of 'throttled_hierarchy' follows non-static declaration
    5484 | static inline int throttled_hierarchy(struct cfs_rq *cfs_rq)
         |                   ^~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:4343:22: note: previous implicit declaration of 'throttled_hierarchy' with type 'int()'
    4343 |                 if (!throttled_hierarchy(cfs_rq))
         |                      ^~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:5495:6: warning: no previous prototype for 'init_cfs_bandwidth' [-Wmissing-prototypes]
    5495 | void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
         |      ^~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:11654:6: warning: no previous prototype for 'free_fair_sched_group' [-Wmissing-prototypes]
   11654 | void free_fair_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:11656:5: warning: no previous prototype for 'alloc_fair_sched_group' [-Wmissing-prototypes]
   11656 | int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
         |     ^~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:11661:6: warning: no previous prototype for 'online_fair_sched_group' [-Wmissing-prototypes]
   11661 | void online_fair_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:11663:6: warning: no previous prototype for 'unregister_fair_sched_group' [-Wmissing-prototypes]
   11663 | void unregister_fair_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/throttled_hierarchy +4343 kernel/sched/fair.c

  4263	
  4264	/*
  4265	 * MIGRATION
  4266	 *
  4267	 *	dequeue
  4268	 *	  update_curr()
  4269	 *	    update_min_vruntime()
  4270	 *	  vruntime -= min_vruntime
  4271	 *
  4272	 *	enqueue
  4273	 *	  update_curr()
  4274	 *	    update_min_vruntime()
  4275	 *	  vruntime += min_vruntime
  4276	 *
  4277	 * this way the vruntime transition between RQs is done when both
  4278	 * min_vruntime are up-to-date.
  4279	 *
  4280	 * WAKEUP (remote)
  4281	 *
  4282	 *	->migrate_task_rq_fair() (p->state == TASK_WAKING)
  4283	 *	  vruntime -= min_vruntime
  4284	 *
  4285	 *	enqueue
  4286	 *	  update_curr()
  4287	 *	    update_min_vruntime()
  4288	 *	  vruntime += min_vruntime
  4289	 *
  4290	 * this way we don't have the most up-to-date min_vruntime on the originating
  4291	 * CPU and an up-to-date min_vruntime on the destination CPU.
  4292	 */
  4293	
  4294	static void
  4295	enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
  4296	{
  4297		bool renorm = !(flags & ENQUEUE_WAKEUP) || (flags & ENQUEUE_MIGRATED);
  4298		bool curr = cfs_rq->curr == se;
  4299	
  4300		/*
  4301		 * If we're the current task, we must renormalise before calling
  4302		 * update_curr().
  4303		 */
  4304		if (renorm && curr)
  4305			se->vruntime += cfs_rq->min_vruntime;
  4306	
  4307		update_curr(cfs_rq);
  4308	
  4309		/*
  4310		 * Otherwise, renormalise after, such that we're placed at the current
  4311		 * moment in time, instead of some random moment in the past. Being
  4312		 * placed in the past could significantly boost this task to the
  4313		 * fairness detriment of existing tasks.
  4314		 */
  4315		if (renorm && !curr)
  4316			se->vruntime += cfs_rq->min_vruntime;
  4317	
  4318		/*
  4319		 * When enqueuing a sched_entity, we must:
  4320		 *   - Update loads to have both entity and cfs_rq synced with now.
  4321		 *   - Add its load to cfs_rq->runnable_avg
  4322		 *   - For group_entity, update its weight to reflect the new share of
  4323		 *     its group cfs_rq
  4324		 *   - Add its new weight to cfs_rq->load.weight
  4325		 */
  4326		update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH);
  4327		se_update_runnable(se);
  4328		update_cfs_group(se);
  4329		account_entity_enqueue(cfs_rq, se);
  4330	
  4331		if (flags & ENQUEUE_WAKEUP)
  4332			place_entity(cfs_rq, se, 0);
  4333	
  4334		check_schedstat_required();
  4335		update_stats_enqueue_fair(cfs_rq, se, flags);
  4336		check_spread(cfs_rq, se);
  4337		if (!curr)
  4338			__enqueue_entity(cfs_rq, se);
  4339		se->on_rq = 1;
  4340	
  4341		if (cfs_rq->nr_running == 1) {
  4342			check_enqueue_throttle(cfs_rq);
> 4343			if (!throttled_hierarchy(cfs_rq))
  4344				list_add_leaf_cfs_rq(cfs_rq);
  4345		}
  4346	}
  4347	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
