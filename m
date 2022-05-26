Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CD5534D88
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 12:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242459AbiEZKsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 06:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240100AbiEZKsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 06:48:03 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D10CEB89
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653562082; x=1685098082;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Eo6i17qWBXwuIUxR11i2ZPGFPQNpnF1+GSctIJdLGkw=;
  b=SCq5l3hYFWn3hCsO1I1xJLN0rZWp8pZ71ctK5HqKB0OzLUAU1CMpxlyS
   A0uacEKtiKYatJm76kLI2J2CQNQOxZFgEJJ/yu9evAeg+J0Jqj6B6dty+
   G4yaA9omwsDc2fNskRCeZgOzhJLYmrxSzAkaBSRX2odSPfLL5yOYjjTBY
   DQ8lnfkRt8dCAZzNEm4ziBKbI3e8upExLPZQdQMfw+QwFmMkSzdELdrsH
   B0sR+otwh7Y+jFPye+l/prPQo8XURe6QZbP2p5R1ybFMeezgu9GhTs3xO
   z+WY8LZcJowQfzGFn2inSqauLJN2uBWZh33pXU6YhJBPZcAmxif7XERx3
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="274117551"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="274117551"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 03:48:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="677412143"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 26 May 2022 03:47:58 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuB25-0003nM-Kw;
        Thu, 26 May 2022 10:47:57 +0000
Date:   Thu, 26 May 2022 18:46:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, odin@uged.al
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH v2 2/2] sched/fair: optimize and simplify rq
 leaf_cfs_rq_list
Message-ID: <202205261834.2QOwksAg-lkp@intel.com>
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
[also build test ERROR on tip/master linus/master v5.18 next-20220526]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Chengming-Zhou/sched-fair-optimize-and-simplify-rq-leaf_cfs_rq_list/20220526-151850
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 991d8d8142cad94f9c5c05db25e67fa83d6f772a
config: arm-randconfig-r014-20220524 (https://download.01.org/0day-ci/archive/20220526/202205261834.2QOwksAg-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 3d546191ad9d7d2ad2c7928204b9de51deafa675)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/cb2b1810aeb3f8f290a932f3e625ab9df1110054
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Chengming-Zhou/sched-fair-optimize-and-simplify-rq-leaf_cfs_rq_list/20220526-151850
        git checkout cb2b1810aeb3f8f290a932f3e625ab9df1110054
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/sched/fair.c:645:5: warning: no previous prototype for function 'sched_update_scaling' [-Wmissing-prototypes]
   int sched_update_scaling(void)
       ^
   kernel/sched/fair.c:645:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int sched_update_scaling(void)
   ^
   static 
>> kernel/sched/fair.c:4343:8: error: call to undeclared function 'throttled_hierarchy'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   if (!throttled_hierarchy(cfs_rq))
                        ^
   kernel/sched/fair.c:5484:19: error: static declaration of 'throttled_hierarchy' follows non-static declaration
   static inline int throttled_hierarchy(struct cfs_rq *cfs_rq)
                     ^
   kernel/sched/fair.c:4343:8: note: previous implicit declaration is here
                   if (!throttled_hierarchy(cfs_rq))
                        ^
   kernel/sched/fair.c:5495:6: warning: no previous prototype for function 'init_cfs_bandwidth' [-Wmissing-prototypes]
   void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
        ^
   kernel/sched/fair.c:5495:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
   ^
   static 
   kernel/sched/fair.c:11654:6: warning: no previous prototype for function 'free_fair_sched_group' [-Wmissing-prototypes]
   void free_fair_sched_group(struct task_group *tg) { }
        ^
   kernel/sched/fair.c:11654:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void free_fair_sched_group(struct task_group *tg) { }
   ^
   static 
   kernel/sched/fair.c:11656:5: warning: no previous prototype for function 'alloc_fair_sched_group' [-Wmissing-prototypes]
   int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
       ^
   kernel/sched/fair.c:11656:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
   ^
   static 
   kernel/sched/fair.c:11661:6: warning: no previous prototype for function 'online_fair_sched_group' [-Wmissing-prototypes]
   void online_fair_sched_group(struct task_group *tg) { }
        ^
   kernel/sched/fair.c:11661:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void online_fair_sched_group(struct task_group *tg) { }
   ^
   static 
   kernel/sched/fair.c:11663:6: warning: no previous prototype for function 'unregister_fair_sched_group' [-Wmissing-prototypes]
   void unregister_fair_sched_group(struct task_group *tg) { }
        ^
   kernel/sched/fair.c:11663:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void unregister_fair_sched_group(struct task_group *tg) { }
   ^
   static 
   6 warnings and 2 errors generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DRM_GEM_SHMEM_HELPER
   Depends on HAS_IOMEM && DRM && MMU
   Selected by
   - DRM_SSD130X && HAS_IOMEM && DRM


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
