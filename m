Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265A2534D47
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 12:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344972AbiEZKZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 06:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiEZKZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 06:25:14 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BABC5DAF
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:25:12 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id x12so982932pgj.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hUOCFKr7TmETzu22lQxFC5YOJPeEbnLDEG7LtmDv5uQ=;
        b=f2f7RYZxTT3qxOUlzMPNouDag23+FgR7n38qiV5l4+V1DB58nssj1o5a5dv9gtQZyX
         QxGzFxVJXpVnzNWqE0tAs5ZCAz147xBzLstRpeJ6zxnATdBD4rNkm4rFshyzx166+GKG
         qL2QB0DVFlU7+Rwo6b484h3OzZMyWTL43C1k5C3Oasx+y9j827zS9Vkw/NBP3zZGAKL3
         WipK61D47Zsrt/sBxH+hLttqgc+3CpQPU7RYdIkrjitUyM74+oicui8i7IFae5mEYPVD
         Mf9Nuoet0E6EKsTW25PasfP4Q9xOsrbgp1sVUpPSdPq08SEs4WN69h6oeKT7nuwpgNHJ
         O/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hUOCFKr7TmETzu22lQxFC5YOJPeEbnLDEG7LtmDv5uQ=;
        b=oEKLjf2LxaWE77E63qm4To4wBLfq2MYTkdeP7SwHgC0BpOsMFRbtmqc7XncD2D7iT1
         mAngILL3i1qMdS9dJgiQ/JA3kGxmwJqDJcHCRPkgNsZaAbtgu4YPSoYsgepQjUjIbPGb
         rRgbiA9avp5lMYNgPXCaIBciCBS6Y2NPC2AUS9BaVvMTgBbGL919uJ0JHWEISzGES3Ss
         ZahW3a4+LOfw/8HRUt1JTOsik30j7958toiBVaq0lcmT6rTSTGAjySJ5oUmiNJwOJEwe
         +rG7LqQHRfAreodcPSJXLooj43pFe4pS8WQoDV2wPPT8r83H7tdQ1kqT4oe7XEIZrSEz
         PRBA==
X-Gm-Message-State: AOAM5335TJHA1PkwpiBL8VCmAEINOGKXZOevKv++botrRzwE1jk6fA7c
        mmF9tb+e9LVWtD2T7t26nKmtgg==
X-Google-Smtp-Source: ABdhPJxkoYXQzUD45eVjGcPPiyeHv4XOrVBI86JQHeCmEZJVvFHxkxb/pTFY2bN3bnmq+FzdM29JoQ==
X-Received: by 2002:a65:5a43:0:b0:3f2:779e:8bf2 with SMTP id z3-20020a655a43000000b003f2779e8bf2mr32720783pgs.584.1653560712246;
        Thu, 26 May 2022 03:25:12 -0700 (PDT)
Received: from [10.254.196.7] ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id a23-20020a62bd17000000b0050dc7628163sm1071768pff.61.2022.05.26.03.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 03:25:11 -0700 (PDT)
Message-ID: <843a2292-b62d-a2cf-e87c-e01d920721ef@bytedance.com>
Date:   Thu, 26 May 2022 18:25:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [External] Re: [PATCH v2 2/2] sched/fair: optimize and simplify
 rq leaf_cfs_rq_list
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, odin@uged.al
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
References: <20220526071354.6426-3-zhouchengming@bytedance.com>
 <202205261617.YUT1ixQ8-lkp@intel.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <202205261617.YUT1ixQ8-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/26 16:53, kernel test robot wrote:
> Hi Chengming,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on tip/sched/core]
> [also build test ERROR on tip/master linus/master v5.18 next-20220525]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Chengming-Zhou/sched-fair-optimize-and-simplify-rq-leaf_cfs_rq_list/20220526-151850
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 991d8d8142cad94f9c5c05db25e67fa83d6f772a
> config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20220526/202205261617.YUT1ixQ8-lkp@intel.com/config)
> compiler: powerpc-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/cb2b1810aeb3f8f290a932f3e625ab9df1110054
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Chengming-Zhou/sched-fair-optimize-and-simplify-rq-leaf_cfs_rq_list/20220526-151850
>         git checkout cb2b1810aeb3f8f290a932f3e625ab9df1110054
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash kernel/sched/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>

Thanks, will fix !CONFIG_FAIR_GROUP_SCHED build next version.

> 
> All errors (new ones prefixed by >>):
> 
>    kernel/sched/fair.c:645:5: warning: no previous prototype for 'sched_update_scaling' [-Wmissing-prototypes]
>      645 | int sched_update_scaling(void)
>          |     ^~~~~~~~~~~~~~~~~~~~
>    kernel/sched/fair.c: In function 'enqueue_entity':
>>> kernel/sched/fair.c:4343:22: error: implicit declaration of function 'throttled_hierarchy' [-Werror=implicit-function-declaration]
>     4343 |                 if (!throttled_hierarchy(cfs_rq))
>          |                      ^~~~~~~~~~~~~~~~~~~
>    kernel/sched/fair.c: At top level:
>>> kernel/sched/fair.c:5484:19: error: static declaration of 'throttled_hierarchy' follows non-static declaration
>     5484 | static inline int throttled_hierarchy(struct cfs_rq *cfs_rq)
>          |                   ^~~~~~~~~~~~~~~~~~~
>    kernel/sched/fair.c:4343:22: note: previous implicit declaration of 'throttled_hierarchy' with type 'int()'
>     4343 |                 if (!throttled_hierarchy(cfs_rq))
>          |                      ^~~~~~~~~~~~~~~~~~~
>    kernel/sched/fair.c:5495:6: warning: no previous prototype for 'init_cfs_bandwidth' [-Wmissing-prototypes]
>     5495 | void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
>          |      ^~~~~~~~~~~~~~~~~~
>    kernel/sched/fair.c:11654:6: warning: no previous prototype for 'free_fair_sched_group' [-Wmissing-prototypes]
>    11654 | void free_fair_sched_group(struct task_group *tg) { }
>          |      ^~~~~~~~~~~~~~~~~~~~~
>    kernel/sched/fair.c:11656:5: warning: no previous prototype for 'alloc_fair_sched_group' [-Wmissing-prototypes]
>    11656 | int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
>          |     ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/sched/fair.c:11661:6: warning: no previous prototype for 'online_fair_sched_group' [-Wmissing-prototypes]
>    11661 | void online_fair_sched_group(struct task_group *tg) { }
>          |      ^~~~~~~~~~~~~~~~~~~~~~~
>    kernel/sched/fair.c:11663:6: warning: no previous prototype for 'unregister_fair_sched_group' [-Wmissing-prototypes]
>    11663 | void unregister_fair_sched_group(struct task_group *tg) { }
>          |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> 
> 
> vim +/throttled_hierarchy +4343 kernel/sched/fair.c
> 
>   4263	
>   4264	/*
>   4265	 * MIGRATION
>   4266	 *
>   4267	 *	dequeue
>   4268	 *	  update_curr()
>   4269	 *	    update_min_vruntime()
>   4270	 *	  vruntime -= min_vruntime
>   4271	 *
>   4272	 *	enqueue
>   4273	 *	  update_curr()
>   4274	 *	    update_min_vruntime()
>   4275	 *	  vruntime += min_vruntime
>   4276	 *
>   4277	 * this way the vruntime transition between RQs is done when both
>   4278	 * min_vruntime are up-to-date.
>   4279	 *
>   4280	 * WAKEUP (remote)
>   4281	 *
>   4282	 *	->migrate_task_rq_fair() (p->state == TASK_WAKING)
>   4283	 *	  vruntime -= min_vruntime
>   4284	 *
>   4285	 *	enqueue
>   4286	 *	  update_curr()
>   4287	 *	    update_min_vruntime()
>   4288	 *	  vruntime += min_vruntime
>   4289	 *
>   4290	 * this way we don't have the most up-to-date min_vruntime on the originating
>   4291	 * CPU and an up-to-date min_vruntime on the destination CPU.
>   4292	 */
>   4293	
>   4294	static void
>   4295	enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>   4296	{
>   4297		bool renorm = !(flags & ENQUEUE_WAKEUP) || (flags & ENQUEUE_MIGRATED);
>   4298		bool curr = cfs_rq->curr == se;
>   4299	
>   4300		/*
>   4301		 * If we're the current task, we must renormalise before calling
>   4302		 * update_curr().
>   4303		 */
>   4304		if (renorm && curr)
>   4305			se->vruntime += cfs_rq->min_vruntime;
>   4306	
>   4307		update_curr(cfs_rq);
>   4308	
>   4309		/*
>   4310		 * Otherwise, renormalise after, such that we're placed at the current
>   4311		 * moment in time, instead of some random moment in the past. Being
>   4312		 * placed in the past could significantly boost this task to the
>   4313		 * fairness detriment of existing tasks.
>   4314		 */
>   4315		if (renorm && !curr)
>   4316			se->vruntime += cfs_rq->min_vruntime;
>   4317	
>   4318		/*
>   4319		 * When enqueuing a sched_entity, we must:
>   4320		 *   - Update loads to have both entity and cfs_rq synced with now.
>   4321		 *   - Add its load to cfs_rq->runnable_avg
>   4322		 *   - For group_entity, update its weight to reflect the new share of
>   4323		 *     its group cfs_rq
>   4324		 *   - Add its new weight to cfs_rq->load.weight
>   4325		 */
>   4326		update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH);
>   4327		se_update_runnable(se);
>   4328		update_cfs_group(se);
>   4329		account_entity_enqueue(cfs_rq, se);
>   4330	
>   4331		if (flags & ENQUEUE_WAKEUP)
>   4332			place_entity(cfs_rq, se, 0);
>   4333	
>   4334		check_schedstat_required();
>   4335		update_stats_enqueue_fair(cfs_rq, se, flags);
>   4336		check_spread(cfs_rq, se);
>   4337		if (!curr)
>   4338			__enqueue_entity(cfs_rq, se);
>   4339		se->on_rq = 1;
>   4340	
>   4341		if (cfs_rq->nr_running == 1) {
>   4342			check_enqueue_throttle(cfs_rq);
>> 4343			if (!throttled_hierarchy(cfs_rq))
>   4344				list_add_leaf_cfs_rq(cfs_rq);
>   4345		}
>   4346	}
>   4347	
> 
