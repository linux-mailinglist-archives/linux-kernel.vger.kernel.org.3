Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6724AB91F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242945AbiBGKz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240091AbiBGKtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 05:49:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E063C043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 02:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zFFfeACZv+Zz/Z1pAOvHul7A7nmnAr1YmT299E07rqo=; b=qaHAIEhcQUKF0ItqKyJo6puHQ3
        VMYiiC1DLx2H4xdjksPDGcndvBmobNu0wdngb8ZtQB7h5QT9VN+9pcdjK6TOS2tvhC4TRLhaa/rkw
        Wq3DEPY105JCBbLYafyumLyAG39czuljCAyn49KgyB2Nwhb7+gENr7NSAvc7k9s+rNWFG2zX/Rz5U
        aTWPJn/WJCfEv98o84IOHJnHbdY7HYAM9IwdsbSKBNEnmXES3n6qNRCEn5YCAvt+bmFOGqTARDxN4
        UU8ks08k9Bxxvn5JaD/ohJasSzIGSIzemM5feW5E0hpjhirTsXj9BeH/r7730n/s177DKW5BLa5fh
        /MZ8IfKA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nH1Zf-000KcB-0y; Mon, 07 Feb 2022 10:48:47 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B8545986235; Mon,  7 Feb 2022 11:48:45 +0100 (CET)
Date:   Mon, 7 Feb 2022 11:48:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     YT Chang <yt.chang@mediatek.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH 1/1] sched: Add update_rq_clock() in sched_rt_rq_enqueue()
Message-ID: <20220207104845.GD23216@worktop.programming.kicks-ass.net>
References: <20211224012239.4694-1-yt.chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211224012239.4694-1-yt.chang@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 09:22:39AM +0800, YT Chang wrote:
> Add update_rq_clock() in sched_rt_rq_enqueue() to
> prevent the warning "rq->clock_update_flags < RQCF_ACT_SKIP"
> when call rq_clock() in cpufreq_update_util().
> 
> sched_rt_rq_enqueue ->
>    enqueue_top_rt_rq ->
>       cpufreq_update_util ->
>          rq_clock ->
>             assert_clock_updated
> 
> Signed-off-by: YT Chang <yt.chang@mediatek.com>
> Change-Id: I4fba5a561b7064aafa991d7f1a34431607779cb4

Change-Id does not belong in kernel patches..

> ---
>  kernel/sched/rt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index b48baaba2fc2..faf1a68c0723 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -539,6 +539,7 @@ static void sched_rt_rq_enqueue(struct rt_rq *rt_rq)
>  
>  	int cpu = cpu_of(rq);
>  
> +	update_rq_clock(rq);

This isn't right I think; there's at least one caller of this function
that already did that. A double clock update is also wrong. Each path
should have just one.

>  	rt_se = rt_rq->tg->rt_se[cpu];
>  
>  	if (rt_rq->rt_nr_running) {
> -- 
> 2.18.0
> 
