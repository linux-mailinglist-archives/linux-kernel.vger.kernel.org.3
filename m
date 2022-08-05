Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC00F58A4A2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 04:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbiHECLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 22:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiHECLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 22:11:42 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFBB22B09
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 19:11:40 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id h21-20020a17090aa89500b001f31a61b91dso6964759pjq.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 19:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZBv8b9c4g8sQpi4JwtXwCRRIJobNpf05vkQmlOBt0GU=;
        b=acYVXqXDWpkd968kXD5iMyGCoeU0bJ4NJUR8G0z4Ggi/3BEulgm/TqvZrMiOOMLCrb
         EPrj7fFJYpysy05X4guBNReacl3ZVmYKcPIPYKOhCKQFiLSxbv3Jv3WWP1xHdKYHStub
         3oLmRlhn4atjD8e1GK+O9UZ/6Ld+xlN1JTUbo9fL7IiQFKaTyP3+wo+1ikma8IR4lUqe
         Qg3qN8Pa1xXHudttjZJq2kxOYTDc9hs1ine+uBLZSUnF5zioxxmM3jVHydQ/dUbtHlTx
         hL+ROnYwbIW75Ljc08PSPlXnOrUFlu6u3YyOCpaZu98g3HP0YPhuXQMgHW7oyhGO41cq
         M8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZBv8b9c4g8sQpi4JwtXwCRRIJobNpf05vkQmlOBt0GU=;
        b=Nko64U3/T2qZzjhG1PssoI59goKCXAY9lYrzLJm/4Rpj8tKNaFgLceox1pun88cLIR
         gp3QkwaM38O8UuB1XZ8/NfPVcqpQnvfLIMnpUBMDzhMCtlr5vDGk9mU+1mYsxpIM1f6J
         28cmGzNBWytnWOAXeNpmWaQGd6kuSARelZSi8zUumaftdtqXBNm3lbQANGm5EDB44rbg
         u2D8YHFvJJLLGx4oKFTl78r390PWldh1y30kNZyjPMj+lorbUvzWfslHP7HzjTUaiy4a
         IPV9bHH021aQvilKIAekbYQqjO98gbfaolDWBRxiTjK6jisX/sGyFQ7s9XC7nBiil1sF
         4NdA==
X-Gm-Message-State: ACgBeo3Rn8uwIgKimNwkMPjIY6wjs29llW9H1fL0Ob+KvojX+3AI/TJ9
        DjbcuIyIlYpLVDgfjBU7GG+PZw==
X-Google-Smtp-Source: AA6agR5oePxSxfRP06omoCeia/pi9r0NJJQCc09OVZvwYEO4zSCa+NzkJdZGza1vEZIw9ppheQE5YA==
X-Received: by 2002:a17:902:f785:b0:16a:4f3b:a20c with SMTP id q5-20020a170902f78500b0016a4f3ba20cmr4570711pln.118.1659665500210;
        Thu, 04 Aug 2022 19:11:40 -0700 (PDT)
Received: from [10.4.84.52] ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902680700b0016dbaf3ff2esm1683875plk.22.2022.08.04.19.11.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 19:11:39 -0700 (PDT)
Message-ID: <6ba013c5-e500-7e75-dc9e-5d1c016530c8@bytedance.com>
Date:   Fri, 5 Aug 2022 10:11:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.0
Subject: Re: [PATCH v3 08/10] sched/fair: refactor detach/attach_entity_cfs_rq
 using update_load_avg()
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com
References: <20220801042745.7794-9-zhouchengming@bytedance.com>
 <202208011647.2KU7IF9Y-lkp@intel.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <202208011647.2KU7IF9Y-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/1 16:07, kernel test robot wrote:
> Hi Chengming,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on tip/sched/core]
> [also build test ERROR on next-20220728]
> [cannot apply to linus/master v5.19]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Chengming-Zhou/sched-fair-task-load-tracking-optimization-and-cleanup/20220801-122957
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 8da3d9b8590bc178752d4b72938745e9a6c4c416
> config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220801/202208011647.2KU7IF9Y-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/intel-lab-lkp/linux/commit/336247ff1d2b402a18689fd891d79e99d8b444fc
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Chengming-Zhou/sched-fair-task-load-tracking-optimization-and-cleanup/20220801-122957
>         git checkout 336247ff1d2b402a18689fd891d79e99d8b444fc
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    kernel/sched/fair.c:672:5: warning: no previous prototype for 'sched_update_scaling' [-Wmissing-prototypes]
>      672 | int sched_update_scaling(void)
>          |     ^~~~~~~~~~~~~~~~~~~~
>    kernel/sched/fair.c: In function 'enqueue_entity':
>>> kernel/sched/fair.c:4462:16: error: 'struct sched_entity' has no member named 'avg'
>     4462 |         if (!se->avg.last_update_time)
>          |                ^~
> 

Thanks for the test report!

It seems because sched_entity has no member avg on !CONFIG_SMP,
I think we'd better drop this patch for now since it's just code
refactor, not real improvement.

> 
> vim +4462 kernel/sched/fair.c
> 
>   4419	
>   4420	/*
>   4421	 * MIGRATION
>   4422	 *
>   4423	 *	dequeue
>   4424	 *	  update_curr()
>   4425	 *	    update_min_vruntime()
>   4426	 *	  vruntime -= min_vruntime
>   4427	 *
>   4428	 *	enqueue
>   4429	 *	  update_curr()
>   4430	 *	    update_min_vruntime()
>   4431	 *	  vruntime += min_vruntime
>   4432	 *
>   4433	 * this way the vruntime transition between RQs is done when both
>   4434	 * min_vruntime are up-to-date.
>   4435	 *
>   4436	 * WAKEUP (remote)
>   4437	 *
>   4438	 *	->migrate_task_rq_fair() (p->state == TASK_WAKING)
>   4439	 *	  vruntime -= min_vruntime
>   4440	 *
>   4441	 *	enqueue
>   4442	 *	  update_curr()
>   4443	 *	    update_min_vruntime()
>   4444	 *	  vruntime += min_vruntime
>   4445	 *
>   4446	 * this way we don't have the most up-to-date min_vruntime on the originating
>   4447	 * CPU and an up-to-date min_vruntime on the destination CPU.
>   4448	 */
>   4449	
>   4450	static void
>   4451	enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>   4452	{
>   4453		bool renorm = !(flags & ENQUEUE_WAKEUP) || (flags & ENQUEUE_MIGRATED);
>   4454		bool curr = cfs_rq->curr == se;
>   4455		int action = UPDATE_TG;
>   4456	
>   4457		/*
>   4458		 * !last_update_time means we've passed through migrate_task_rq_fair()
>   4459		 * or task_change_group_fair() indicating we migrated cfs_rq. IOW we're
>   4460		 * enqueueing a task on a new CPU or moving task to a new cgroup.
>   4461		 */
>> 4462		if (!se->avg.last_update_time)
>   4463			action |= DO_ATTACH;
>   4464	
>   4465		/*
>   4466		 * If we're the current task, we must renormalise before calling
>   4467		 * update_curr().
>   4468		 */
>   4469		if (renorm && curr)
>   4470			se->vruntime += cfs_rq->min_vruntime;
>   4471	
>   4472		update_curr(cfs_rq);
>   4473	
>   4474		/*
>   4475		 * Otherwise, renormalise after, such that we're placed at the current
>   4476		 * moment in time, instead of some random moment in the past. Being
>   4477		 * placed in the past could significantly boost this task to the
>   4478		 * fairness detriment of existing tasks.
>   4479		 */
>   4480		if (renorm && !curr)
>   4481			se->vruntime += cfs_rq->min_vruntime;
>   4482	
>   4483		/*
>   4484		 * When enqueuing a sched_entity, we must:
>   4485		 *   - Update loads to have both entity and cfs_rq synced with now.
>   4486		 *   - For group_entity, update its runnable_weight to reflect the new
>   4487		 *     h_nr_running of its group cfs_rq.
>   4488		 *   - For group_entity, update its weight to reflect the new share of
>   4489		 *     its group cfs_rq
>   4490		 *   - Add its new weight to cfs_rq->load.weight
>   4491		 */
>   4492		update_load_avg(cfs_rq, se, action);
>   4493		se_update_runnable(se);
>   4494		update_cfs_group(se);
>   4495		account_entity_enqueue(cfs_rq, se);
>   4496	
>   4497		if (flags & ENQUEUE_WAKEUP)
>   4498			place_entity(cfs_rq, se, 0);
>   4499	
>   4500		check_schedstat_required();
>   4501		update_stats_enqueue_fair(cfs_rq, se, flags);
>   4502		check_spread(cfs_rq, se);
>   4503		if (!curr)
>   4504			__enqueue_entity(cfs_rq, se);
>   4505		se->on_rq = 1;
>   4506	
>   4507		if (cfs_rq->nr_running == 1) {
>   4508			check_enqueue_throttle(cfs_rq);
>   4509			if (!throttled_hierarchy(cfs_rq))
>   4510				list_add_leaf_cfs_rq(cfs_rq);
>   4511		}
>   4512	}
>   4513	
> 
