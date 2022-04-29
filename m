Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0663E5144E0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356169AbiD2I4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236950AbiD2I4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:56:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE86CC44EC
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:53:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9ED421063;
        Fri, 29 Apr 2022 01:53:11 -0700 (PDT)
Received: from wubuntu (unknown [10.57.75.64])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74E753F73B;
        Fri, 29 Apr 2022 01:53:10 -0700 (PDT)
Date:   Fri, 29 Apr 2022 09:53:08 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Phil Auld <pauld@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/fair: Remove cfs_rq_tg_path()
Message-ID: <20220429085308.sxj2w6i3n2btbpyh@wubuntu>
References: <20220428144338.479094-1-qais.yousef@arm.com>
 <20220428144338.479094-3-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220428144338.479094-3-qais.yousef@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC lkml

On 04/28/22 15:43, Qais Yousef wrote:
> From: Dietmar Eggemann <dietmar.eggemann@arm.com>
> 
> cfs_rq_tg_path() is used by a tracepoint-to traceevent (tp-2-te)
> converter to format the path of a taskgroup or autogroup respectively.
> It doesn't have any in-kernel users after the removal of the
> sched_trace_cfs_rq_path() helper function.
> 
> cfs_rq_tg_path() can be coded in a tp-2-te converter.
> 
> Remove it from kernel/sched/fair.c.
> 
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> ---
>  kernel/sched/fair.c | 19 -------------------
>  1 file changed, 19 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ff1177a4a286..7487737c1275 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -313,19 +313,6 @@ const struct sched_class fair_sched_class;
>  #define for_each_sched_entity(se) \
>  		for (; se; se = se->parent)
>  
> -static inline void cfs_rq_tg_path(struct cfs_rq *cfs_rq, char *path, int len)
> -{
> -	if (!path)
> -		return;
> -
> -	if (cfs_rq && task_group_is_autogroup(cfs_rq->tg))
> -		autogroup_path(cfs_rq->tg, path, len);
> -	else if (cfs_rq && cfs_rq->tg->css.cgroup)
> -		cgroup_path(cfs_rq->tg->css.cgroup, path, len);
> -	else
> -		strlcpy(path, "(null)", len);
> -}
> -
>  static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
>  {
>  	struct rq *rq = rq_of(cfs_rq);
> @@ -493,12 +480,6 @@ static int se_is_idle(struct sched_entity *se)
>  #define for_each_sched_entity(se) \
>  		for (; se; se = NULL)
>  
> -static inline void cfs_rq_tg_path(struct cfs_rq *cfs_rq, char *path, int len)
> -{
> -	if (path)
> -		strlcpy(path, "(null)", len);
> -}
> -
>  static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
>  {
>  	return true;
> -- 
> 2.25.1
> 
