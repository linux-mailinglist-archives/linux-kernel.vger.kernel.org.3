Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FB85AFA28
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 04:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiIGCqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 22:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiIGCqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 22:46:14 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF90299B4E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 19:46:01 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id t65so1362566pgt.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 19:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=lYND3IwDTdM5PZTCKzxIjaS5ygiN1Dths8JY904/4Q8=;
        b=MrwbpluAMtD46n0GaxZ16fnyV7hwPbudWKeudny7B0bWg5AXC1VFUu7CnjZ/fgbsxh
         lAWDkNXUbPxs6NDlL3sFVcmR8AJ6jCcvjM8clIGXksJ9aDlD7bd8X4RQEqKRwLVjnTvv
         SG6/r6UxS9d/aT8BJ35wcA9s11dppIQt24UvrGu7iuuD3EpxdYU1gtcQK30FcP8QtV71
         PRMg6Wg6XcVfQjRPgeaIUyPAwWzQShPBWVKij+rJBVuoeVQWrm6rzEI/xuSfwkV8S6d6
         Tzw+foNzBACGwCqht3+s2ZdvZUEAFhb61bz7WQIg/Oz3KFAQPVodMatPiAzoyjHuqUaG
         Rwrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=lYND3IwDTdM5PZTCKzxIjaS5ygiN1Dths8JY904/4Q8=;
        b=ICehhmFW0ZOGZMwscb0WBeSX4R5EBVXY6yFzyN+Ocvlrc3mBEYVhaA5xExwYCFBDEA
         joOPpZ+TDc7T0d3h1uZfNzFbg3diLQ4AC3S9v3InVxszK8nQAOP0/U0W/znryqpMWmQw
         ifhVprYhME1Zu9O7xOUg0GdNDzgcVEZc1sm+xX47TGrup9f86H4jjaQfYfTKZIRv90HC
         w4As6oIsrr5bNSBCaC9J+j/Gu7AEvdxY8eYFrM/VQQwDMpPRuSEInl3NfCp4vepJuvp5
         ZxCQ4LAphHavNoS56STl4NxwPU5gTCT1MeEyauU3cAIT3VT7NxU8WdAQ6RKJDKsADC3F
         1LzA==
X-Gm-Message-State: ACgBeo1YpvXLzkNv9qBzcFyOMlAp8UNWSZJfTCQWIwJSNHh/gTqce4ch
        jCTuYUWvsyvUW+K7+MAOrnohvw==
X-Google-Smtp-Source: AA6agR5X3/9kJjLX7Fc93XZpSgiHvDiCnHiaKNpgho4Hvp+FTaJqNX50nXh6Ow1DNl58OZnra9MpGQ==
X-Received: by 2002:a63:dd51:0:b0:430:18d9:edf8 with SMTP id g17-20020a63dd51000000b0043018d9edf8mr1457175pgj.163.1662518760830;
        Tue, 06 Sep 2022 19:46:00 -0700 (PDT)
Received: from [10.254.68.181] ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id x17-20020a170902ec9100b001752cb111e0sm10890765plg.69.2022.09.06.19.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 19:46:00 -0700 (PDT)
Message-ID: <e95c6e55-a023-b6f7-1dce-4195dc22114a@bytedance.com>
Date:   Wed, 7 Sep 2022 10:45:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [peterz-queue:sched/psi 11/11]
 include/linux/cgroup-defs.h:432:38: error: 'NR_PSI_RESOURCES' undeclared here
 (not in a function)
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202209070242.7EuRnstk-lkp@intel.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <202209070242.7EuRnstk-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/7 02:33, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/psi
> head:   51beb408c569e516780c84a2020920432ad4c5ed
> commit: 51beb408c569e516780c84a2020920432ad4c5ed [11/11] sched/psi: Per-cgroup PSI accounting disable/re-enable interface
> config: i386-randconfig-a001
> compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=51beb408c569e516780c84a2020920432ad4c5ed
>         git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
>         git fetch --no-tags peterz-queue sched/psi
>         git checkout 51beb408c569e516780c84a2020920432ad4c5ed
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=i386 prepare
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/cgroup.h:28,
>                     from include/linux/memcontrol.h:13,
>                     from include/linux/swap.h:9,
>                     from include/linux/suspend.h:5,
>                     from arch/x86/kernel/asm-offsets.c:13:
>>> include/linux/cgroup-defs.h:432:38: error: 'NR_PSI_RESOURCES' undeclared here (not in a function)
>      432 |         struct cgroup_file psi_files[NR_PSI_RESOURCES];

Sorry, looks like there are two problems here:

1. NR_PSI_RESOURCES is undeclared when !CONFIG_PSI

   Should I send the below diff as a separate patch?

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index ab1f9b463df9..6e4372735068 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -195,6 +195,8 @@ struct psi_group {

 #else /* CONFIG_PSI */

+#define NR_PSI_RESOURCES       0
+
 struct psi_group { };

 #endif /* CONFIG_PSI */

2. This patchset depends on Tejun's commit e2691f6b44ed ("cgroup: Implement cgroup_file_show()") in linux-next

   Maybe peterz-queue should include that first? I don't know what's the normal way to handle.


Thanks.


>          |                                      ^~~~~~~~~~~~~~~~
>    make[2]: *** [scripts/Makefile.build:117: arch/x86/kernel/asm-offsets.s] Error 1
>    make[2]: Target '__build' not remade because of errors.
>    make[1]: *** [Makefile:1205: prepare0] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [Makefile:222: __sub-make] Error 2
>    make: Target 'prepare' not remade because of errors.
> 
> 
> vim +/NR_PSI_RESOURCES +432 include/linux/cgroup-defs.h
> 
>    377	
>    378	struct cgroup {
>    379		/* self css with NULL ->ss, points back to this cgroup */
>    380		struct cgroup_subsys_state self;
>    381	
>    382		unsigned long flags;		/* "unsigned long" so bitops work */
>    383	
>    384		/*
>    385		 * The depth this cgroup is at.  The root is at depth zero and each
>    386		 * step down the hierarchy increments the level.  This along with
>    387		 * ancestor_ids[] can determine whether a given cgroup is a
>    388		 * descendant of another without traversing the hierarchy.
>    389		 */
>    390		int level;
>    391	
>    392		/* Maximum allowed descent tree depth */
>    393		int max_depth;
>    394	
>    395		/*
>    396		 * Keep track of total numbers of visible and dying descent cgroups.
>    397		 * Dying cgroups are cgroups which were deleted by a user,
>    398		 * but are still existing because someone else is holding a reference.
>    399		 * max_descendants is a maximum allowed number of descent cgroups.
>    400		 *
>    401		 * nr_descendants and nr_dying_descendants are protected
>    402		 * by cgroup_mutex and css_set_lock. It's fine to read them holding
>    403		 * any of cgroup_mutex and css_set_lock; for writing both locks
>    404		 * should be held.
>    405		 */
>    406		int nr_descendants;
>    407		int nr_dying_descendants;
>    408		int max_descendants;
>    409	
>    410		/*
>    411		 * Each non-empty css_set associated with this cgroup contributes
>    412		 * one to nr_populated_csets.  The counter is zero iff this cgroup
>    413		 * doesn't have any tasks.
>    414		 *
>    415		 * All children which have non-zero nr_populated_csets and/or
>    416		 * nr_populated_children of their own contribute one to either
>    417		 * nr_populated_domain_children or nr_populated_threaded_children
>    418		 * depending on their type.  Each counter is zero iff all cgroups
>    419		 * of the type in the subtree proper don't have any tasks.
>    420		 */
>    421		int nr_populated_csets;
>    422		int nr_populated_domain_children;
>    423		int nr_populated_threaded_children;
>    424	
>    425		int nr_threaded_children;	/* # of live threaded child cgroups */
>    426	
>    427		struct kernfs_node *kn;		/* cgroup kernfs entry */
>    428		struct cgroup_file procs_file;	/* handle for "cgroup.procs" */
>    429		struct cgroup_file events_file;	/* handle for "cgroup.events" */
>    430	
>    431		/* handles for "{cpu,memory,io,irq}.pressure" */
>  > 432		struct cgroup_file psi_files[NR_PSI_RESOURCES];
>    433	
>    434		/*
>    435		 * The bitmask of subsystems enabled on the child cgroups.
>    436		 * ->subtree_control is the one configured through
>    437		 * "cgroup.subtree_control" while ->subtree_ss_mask is the effective
>    438		 * one which may have more subsystems enabled.  Controller knobs
>    439		 * are made available iff it's enabled in ->subtree_control.
>    440		 */
>    441		u16 subtree_control;
>    442		u16 subtree_ss_mask;
>    443		u16 old_subtree_control;
>    444		u16 old_subtree_ss_mask;
>    445	
>    446		/* Private pointers for each registered subsystem */
>    447		struct cgroup_subsys_state __rcu *subsys[CGROUP_SUBSYS_COUNT];
>    448	
>    449		struct cgroup_root *root;
>    450	
>    451		/*
>    452		 * List of cgrp_cset_links pointing at css_sets with tasks in this
>    453		 * cgroup.  Protected by css_set_lock.
>    454		 */
>    455		struct list_head cset_links;
>    456	
>    457		/*
>    458		 * On the default hierarchy, a css_set for a cgroup with some
>    459		 * susbsys disabled will point to css's which are associated with
>    460		 * the closest ancestor which has the subsys enabled.  The
>    461		 * following lists all css_sets which point to this cgroup's css
>    462		 * for the given subsystem.
>    463		 */
>    464		struct list_head e_csets[CGROUP_SUBSYS_COUNT];
>    465	
>    466		/*
>    467		 * If !threaded, self.  If threaded, it points to the nearest
>    468		 * domain ancestor.  Inside a threaded subtree, cgroups are exempt
>    469		 * from process granularity and no-internal-task constraint.
>    470		 * Domain level resource consumptions which aren't tied to a
>    471		 * specific task are charged to the dom_cgrp.
>    472		 */
>    473		struct cgroup *dom_cgrp;
>    474		struct cgroup *old_dom_cgrp;		/* used while enabling threaded */
>    475	
>    476		/* per-cpu recursive resource statistics */
>    477		struct cgroup_rstat_cpu __percpu *rstat_cpu;
>    478		struct list_head rstat_css_list;
>    479	
>    480		/* cgroup basic resource statistics */
>    481		struct cgroup_base_stat last_bstat;
>    482		struct cgroup_base_stat bstat;
>    483		struct prev_cputime prev_cputime;	/* for printing out cputime */
>    484	
>    485		/*
>    486		 * list of pidlists, up to two for each namespace (one for procs, one
>    487		 * for tasks); created on demand.
>    488		 */
>    489		struct list_head pidlists;
>    490		struct mutex pidlist_mutex;
>    491	
>    492		/* used to wait for offlining of csses */
>    493		wait_queue_head_t offline_waitq;
>    494	
>    495		/* used to schedule release agent */
>    496		struct work_struct release_agent_work;
>    497	
>    498		/* used to track pressure stalls */
>    499		struct psi_group *psi;
>    500	
>    501		/* used to store eBPF programs */
>    502		struct cgroup_bpf bpf;
>    503	
>    504		/* If there is block congestion on this cgroup. */
>    505		atomic_t congestion_count;
>    506	
>    507		/* Used to store internal freezer state */
>    508		struct cgroup_freezer_state freezer;
>    509	
>    510		/* ids of the ancestors at each level including self */
>    511		u64 ancestor_ids[];
>    512	};
>    513	
> 
