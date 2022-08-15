Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96815592DB2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 13:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbiHOLCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 07:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbiHOLB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 07:01:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439DC1EECA
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 04:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ei2FvasjgB5kP2gfpWbvcl5jq2x6Q7eSsKNEWZWS06o=; b=dtVpFnUk8ILyJp5vtlgmo69D+v
        5HdvhT/V0wsbWX628c+QQ+8E8jXlgSBqj4YRpMypo1tZ6ZiN/9OyUSeDYV6X3uQrJqo9wENuGaDzv
        Ph8Tp32r1S6PtRFbgOEscx5at0Zqq2er//GK2p6m1F/ScP61xHJ8z9d+QegLVEBIuytqhSxgkK82i
        sJEOCJ1QA5q8xsFcmsMg6aWSzfc8vO5H5WHXAjNHSC0RSB8bLXBaDfKKWUfMkliVEsbciFXDlDznW
        nRrz6Y7FfLU43AH5egNJeBP/tfN/KjFPmL2Ig4SC8TzPurMdSMezNQUVRbmGQO6BPhloo7bOTjjEj
        nVFY3+bQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNXqp-005eZI-RU; Mon, 15 Aug 2022 11:01:43 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1A866980153; Mon, 15 Aug 2022 13:01:42 +0200 (CEST)
Date:   Mon, 15 Aug 2022 13:01:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Libo Chen <libo.chen@oracle.com>
Cc:     mingo@redhat.com, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] sched/fair: Fix inaccurate tally of ttwu_move_affine
Message-ID: <YvonlUOgMbla6dSh@worktop.programming.kicks-ass.net>
References: <20220810223313.386614-1-libo.chen@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810223313.386614-1-libo.chen@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 03:33:13PM -0700, Libo Chen wrote:
> There are scenarios where non-affine wakeups are incorrectly counted as
> affine wakeups by schedstats.
> 
> When wake_affine_idle() returns prev_cpu which doesn't equal to
> nr_cpumask_bits, it will slip through the check: target == nr_cpumask_bits
> in wake_affine() and be counted as if target == this_cpu in schedstats.
> 
> Replace target == nr_cpumask_bits with target != this_cpu to make sure
> affine wakeups are accurately tallied.
> 
> Fixes: 806486c377e33 (sched/fair: Do not migrate if the prev_cpu is idle)
> Suggested-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Signed-off-by: Libo Chen <libo.chen@oracle.com>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index da388657d5ac..b179da4f8105 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6114,7 +6114,7 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
>  		target = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
>  
>  	schedstat_inc(p->stats.nr_wakeups_affine_attempts);
> -	if (target == nr_cpumask_bits)
> +	if (target != this_cpu)
>  		return prev_cpu;
>  
>  	schedstat_inc(sd->ttwu_move_affine);

This not only changes the accounting but also the placement, no?
