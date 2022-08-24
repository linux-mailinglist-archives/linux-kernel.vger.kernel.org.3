Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC1959F3A8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 08:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbiHXGj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 02:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiHXGjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 02:39:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAF8356C7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 23:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uXTSO5/PnMY+3J3e+x980a6jL8C0/pf0hWEPBMsTGUk=; b=A5syL/XLkfKVSBHlCH7wY3h9Jc
        rYbCaqfqO7mIv4hg6PJwxm+0QFvzeSUnrsTCQrJnIumePCRveuip763Tml5eBKbHXL0KSoTDtIcFH
        370fQcKo0yUykq/mysmSYVSN0bDpplR8EuqHEGKWvde/zKcEzpmJwMNTLREU+OKdC2/ZzlVj2bsUb
        zcertdWBPUJAg/0moIU+DoTQWg7jTbcDp1ZsZUTAeLWg3di+0Al6O0hyaVq5n7jWA+nBUKJB2BI6f
        wuYXsEK91opFPfbft5onDoRcOiIDCFoat4uvAhKrHA3ED/6oQPm7EwaoS2Wz3AYDUHI6okqa7OSID
        OWUPML7A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQk2L-00G4wj-Pz; Wed, 24 Aug 2022 06:38:50 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9DEFD980403; Wed, 24 Aug 2022 08:38:48 +0200 (CEST)
Date:   Wed, 24 Aug 2022 08:38:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Shang XiaoJing <shangxiaojing@huawei.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] sched: Add update_current_exec_runtime helper
Message-ID: <YwXHeHQnvRFxS1ct@worktop.programming.kicks-ass.net>
References: <20220824065326.10583-1-shangxiaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824065326.10583-1-shangxiaojing@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 02:53:26PM +0800, Shang XiaoJing wrote:

In general I like, however:

> diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
> index d04073a93eb4..027068779126 100644
> --- a/kernel/sched/stop_task.c
> +++ b/kernel/sched/stop_task.c
> @@ -80,11 +80,7 @@ static void put_prev_task_stop(struct rq *rq, struct task_struct *prev)
>  	schedstat_set(curr->stats.exec_max,
>  		      max(curr->stats.exec_max, delta_exec));
>  
> -	curr->se.sum_exec_runtime += delta_exec;
> -	account_group_exec_runtime(curr, delta_exec);
> -
> -	curr->se.exec_start = rq_clock_task(rq);
> -	cgroup_account_cputime(curr, delta_exec);
> +	update_current_exec_runtime(curr, rq_clock_task(rq), delta_exec);
>  }

This already has a rq_clock_task() invocation; please fix it to call it
once -- pre-existing issue, but if we're cleaning up we should clean up,
right :-)
