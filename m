Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433404E97EB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 15:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243073AbiC1NWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 09:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243115AbiC1NWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:22:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0693446161
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 06:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KX7uokQYmda6l1eRTSgrF7cPdNJEr6jjgFQwQLQA8+k=; b=Ojax3+y7b3yYboJJyvu4xZArgG
        fEx52upEWDPG3d0hlLLCgAHN/gl14zizL1xxx/CWGspd5FNzbYTxJt9jBewTF+osqJ+fePiUFphNM
        wyXm6GnCbeWSuBPRlTVFwGYaHX4TEH/Bq7eu3RtMtPb1XnI9tem4kW7nnrjTU7EE3v2GOBLEEV7TN
        LQdDN8SAWqp4HIETgAZVEZiBBYkUKTIKjLAWQuhLYqiZrG6rb5C41hTH4JmiVqBkix+UXTj7k+rRh
        vTRZdE6j6Fe0Y0BU6IZy2VwGbl///SVprBiTizl2EAlZrZB7VSZwgM1gK0aW8qwGHvahQQKD7i2Wt
        gEslHT7w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nYpIg-00Gwyz-Fe; Mon, 28 Mar 2022 13:20:50 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id DA4499861EA; Mon, 28 Mar 2022 15:20:47 +0200 (CEST)
Date:   Mon, 28 Mar 2022 15:20:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
Subject: Re: [PATCH] sched/fair: fix broken bandwidth control with nohz_full
Message-ID: <20220328132047.GD8939@worktop.programming.kicks-ass.net>
References: <20220328110751.39987-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328110751.39987-1-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 07:07:51PM +0800, Chengming Zhou wrote:
> With nohz_full enabled on cpu, the scheduler_tick() will be stopped
> when only one CFS task left on rq.
> 
> scheduler_tick()
>   task_tick_fair()
>     entity_tick()
>       update_curr()
>         account_cfs_rq_runtime(cfs_rq, delta_exec) --> stopped
> 
> So that running task can't account its runtime periodically, but
> the cfs_bandwidth hrtimer still __refill_cfs_bandwidth_runtime()
> periodically. Later in one period, the task would account very
> big delta_exec, which cause the cfs_rq to be throttled for a
> long time.
> 
> There are two solutions for the problem, the first is that we
> can check in sched_can_stop_tick() if current task's cfs_rq
> have runtime_enabled, in which case we don't stop tick. But
> it will make nohz_full almost useless in cloud environment
> that every container has the cpu bandwidth control setting.

How is NOHZ_FULL useful in that environment to begin with? If you set
bandwidth crap, the expectation is that there is overcommit, which more
or less assumes lots of scheduling, presumably VMs or somesuch crud.

So how does NOHZ_FULL make sense?
