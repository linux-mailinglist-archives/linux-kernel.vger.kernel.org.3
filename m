Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6194650EE9C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 04:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241716AbiDZCRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 22:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236331AbiDZCRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 22:17:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E800038D87
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 19:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650939247; x=1682475247;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HqpMRo4L6VMsg8LWdLOWrFWM3HNVEBTSp8gYlitdB0s=;
  b=VoCEQUOd/WXUzajgaTo+l3aQD7ahfbQ6hkGPskLhrUrtTkFISmjN4wmV
   0qrPXSHh7uNIbEV07IYAYe+5GxHtE14OxTPDXyGrbo6Oh1nbbnH+TDfBo
   xDl5fTSB4REbKFCedSZoIFJ5l02fLAoN5Y1HRtP+xM9QhNDrlzjU6rLJN
   n16iD6roERgwhV/y8m++cRV/XeRb0Dy9zoCbTcliWApNPmCPzmxnpv7V5
   LK4frW29pjvQMeDJV3hKDoTlLC2BEmW69ptdc6tfflenmd961VAUXoPe6
   XkztVJcSGRdTF3B82ICwE2VNSmnQoR8+Ah5P9BKWOhto9jfUXROgk9BGQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="328363787"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="328363787"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 19:14:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="616779914"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 25 Apr 2022 19:14:05 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njAiK-00039C-CW;
        Tue, 26 Apr 2022 02:14:04 +0000
Date:   Tue, 26 Apr 2022 10:13:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vincent Donnefort <vincent.donnefort@arm.com>,
        peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, qperret@google.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: Re: [PATCH v5 2/7] sched/fair: Decay task PELT values during wakeup
 migration
Message-ID: <202204260942.XMp7WXYD-lkp@intel.com>
References: <20220425151612.3322972-3-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425151612.3322972-3-vincent.donnefort@arm.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on rafael-pm/linux-next rafael-pm/thermal v5.18-rc4 next-20220422]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Donnefort/feec-energy-margin-removal/20220425-231901
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git a658353167bf2ea6052cee071dbcc13e0f229dc9
config: arc-randconfig-r043-20220425 (https://download.01.org/0day-ci/archive/20220426/202204260942.XMp7WXYD-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/fb13cca8f6e7998f6e526a9b35f33c85d7570ab2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Vincent-Donnefort/feec-energy-margin-removal/20220425-231901
        git checkout fb13cca8f6e7998f6e526a9b35f33c85d7570ab2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/sched/fair.c: In function 'dequeue_entity':
>> kernel/sched/fair.c:4476:17: error: implicit declaration of function 'update_idle_cfs_rq_clock_pelt'; did you mean 'update_idle_rq_clock_pelt'? [-Werror=implicit-function-declaration]
    4476 |                 update_idle_cfs_rq_clock_pelt(cfs_rq);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                 update_idle_rq_clock_pelt
   cc1: some warnings being treated as errors


vim +4476 kernel/sched/fair.c

  4423	
  4424	static void
  4425	dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
  4426	{
  4427		/*
  4428		 * Update run-time statistics of the 'current'.
  4429		 */
  4430		update_curr(cfs_rq);
  4431	
  4432		/*
  4433		 * When dequeuing a sched_entity, we must:
  4434		 *   - Update loads to have both entity and cfs_rq synced with now.
  4435		 *   - Subtract its load from the cfs_rq->runnable_avg.
  4436		 *   - Subtract its previous weight from cfs_rq->load.weight.
  4437		 *   - For group entity, update its weight to reflect the new share
  4438		 *     of its group cfs_rq.
  4439		 */
  4440		update_load_avg(cfs_rq, se, UPDATE_TG);
  4441		se_update_runnable(se);
  4442	
  4443		update_stats_dequeue_fair(cfs_rq, se, flags);
  4444	
  4445		clear_buddies(cfs_rq, se);
  4446	
  4447		if (se != cfs_rq->curr)
  4448			__dequeue_entity(cfs_rq, se);
  4449		se->on_rq = 0;
  4450		account_entity_dequeue(cfs_rq, se);
  4451	
  4452		/*
  4453		 * Normalize after update_curr(); which will also have moved
  4454		 * min_vruntime if @se is the one holding it back. But before doing
  4455		 * update_min_vruntime() again, which will discount @se's position and
  4456		 * can move min_vruntime forward still more.
  4457		 */
  4458		if (!(flags & DEQUEUE_SLEEP))
  4459			se->vruntime -= cfs_rq->min_vruntime;
  4460	
  4461		/* return excess runtime on last dequeue */
  4462		return_cfs_rq_runtime(cfs_rq);
  4463	
  4464		update_cfs_group(se);
  4465	
  4466		/*
  4467		 * Now advance min_vruntime if @se was the entity holding it back,
  4468		 * except when: DEQUEUE_SAVE && !DEQUEUE_MOVE, in this case we'll be
  4469		 * put back on, and if we advance min_vruntime, we'll be placed back
  4470		 * further than we started -- ie. we'll be penalized.
  4471		 */
  4472		if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) != DEQUEUE_SAVE)
  4473			update_min_vruntime(cfs_rq);
  4474	
  4475		if (cfs_rq->nr_running == 0)
> 4476			update_idle_cfs_rq_clock_pelt(cfs_rq);
  4477	}
  4478	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
