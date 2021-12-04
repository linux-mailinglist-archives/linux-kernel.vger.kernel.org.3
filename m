Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1BCD4683B6
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 10:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244915AbhLDJrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 04:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243242AbhLDJrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 04:47:20 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363CAC061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 01:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c5DnulyimpzgwSh9krAK/uN0QgyfJELF+Zbsg30xxQc=; b=XltAaRSHvjPgu0CXT7TY7pBBrs
        UHc70/7G9pcYsxcR5MoanLSsSdEexxN07h2v/Owysum6VbQcBLLlRgq9Gjit0ly6iUXvY3+rUBfCG
        sJnoTXIfPyqlqMm1chQ2NkOQhaBZ5r9gRdkgIMYWmp5+Qo3e5Y2aU4942VoCggl6CfkMDE0EEMAyL
        74qLHpLGxwHP5lX4YsejO+90wGbESNMbmjZnHfOhP9jy2Vnn2zlsUlV08RGjt9wAs/dOoJOC3Ddyg
        7Md6skYdmbkkUVbkQYx+Zxgpb5jieo6zYYBO0DXpeZS52tKU7QaWo1zd5Lf3/ndciS/5Yqwh2oYge
        eN6BXm+g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mtRaA-002Aj8-3I; Sat, 04 Dec 2021 09:43:50 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B475498106D; Sat,  4 Dec 2021 10:43:49 +0100 (CET)
Date:   Sat, 4 Dec 2021 10:43:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/uclamp: Fix rq->uclamp_max not set on first
 enqueue
Message-ID: <20211204094349.GP16608@worktop.programming.kicks-ass.net>
References: <20211202112033.1705279-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202112033.1705279-1-qais.yousef@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 11:20:33AM +0000, Qais Yousef wrote:
> Commit d81ae8aac85c ("sched/uclamp: Fix initialization of struct
> uclamp_rq") introduced a bug where uclamp_max of the rq is not reset to
> match the woken up task's uclamp_max when the rq is idle.
> 
> The code was relying on rq->uclamp_max initialized to zero, so on first
> enqueue
> 
> 	static inline void uclamp_rq_inc_id(struct rq *rq, struct task_struct *p,
> 					    enum uclamp_id clamp_id)
> 	{
> 		...
> 
> 		if (uc_se->value > READ_ONCE(uc_rq->value))
> 			WRITE_ONCE(uc_rq->value, uc_se->value);
> 	}
> 
> was actually resetting it. But since commit d81ae8aac85c changed the
> default to 1024, this no longer works. And since rq->uclamp_flags is
> also initialized to 0, neither above code path nor uclamp_idle_reset()
> update the rq->uclamp_max on first wake up from idle.
> 
> This is only visible from first wake up(s) until the first dequeue to
> idle after enabling the static key. And it only matters if the
> uclamp_max of this task is < 1024 since only then its uclamp_max will be
> effectively ignored.
> 
> Fix it by properly initializing rq->uclamp_flags = UCLAMP_FLAG_IDLE to
> ensure uclamp_idle_reset() is called which then will update the rq
> uclamp_max value as expected.
> 
> Fixes: d81ae8aac85c ("sched/uclamp: Fix initialization of struct uclamp_rq")
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> Reviewed-by: Valentin Schneider <Valentin.Schneider@arm.com>
> Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Thanks!
