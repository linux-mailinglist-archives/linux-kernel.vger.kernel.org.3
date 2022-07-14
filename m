Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8858C574C04
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238806AbiGNL1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238813AbiGNL1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:27:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153FA5885E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8Ps/TljTNHGfY8PDlzoxZJIjrp8/Szhza8CwHrtIT94=; b=tPAfp9GBKXxV9jckn5pMF4an9F
        gGGVDnga/jzhqanLvhCduFP7e2Gqm/nXJSG5ltwIZrXD63IfbPGAkfN3XRgaFt/i/8oFcyrqVLcjd
        Rsq9pdpn06gtjIHUJhK5gTsP/2QedVhLK/MIW7d/NE6yB3C1olyDAgYRE/v2W1vV7X1yt/m9+NZvr
        z1vrGD7Pdj7IDYUg48dMauiol7/vaJJ7QTPmUdetiuWNZrzCUT0+e4hO5PnzEX6t1qpcyw20nINpi
        BLNKIRXhGtoEK4x7eKhAIYi6pCtGm0fC7h+xYliJkOttjP3qk8hP2t+pYGf/yAsH7gGhewYDFGtwF
        g8/GHWgQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBwzc-009K9b-BT; Thu, 14 Jul 2022 11:26:52 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8566F98016F; Thu, 14 Jul 2022 13:26:51 +0200 (CEST)
Date:   Thu, 14 Jul 2022 13:26:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Libo Chen <libo.chen@oracle.com>
Cc:     vincent.guittot@linaro.org, mgorman@suse.de,
        tim.c.chen@linux.intel.com, 21cnbao@gmail.com,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH] sched/fair: no sync wakeup from interrupt context
Message-ID: <Ys/9e52SDRp8Kpnn@worktop.programming.kicks-ass.net>
References: <20220711224704.1672831-1-libo.chen@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711224704.1672831-1-libo.chen@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 03:47:04PM -0700, Libo Chen wrote:
> Barry Song first pointed out that replacing sync wakeup with regular wakeup
> seems to reduce overeager wakeup pulling and shows noticeable performance
> improvement.[1]
> 
> This patch argues that allowing sync for wakeups from interrupt context
> is a bug 

Yes.

> The
> assumption is built into wake_affine() where it discounts the waker's presence
> from the runqueue when sync is true. The random waker from interrupts bears no
> relation to the wakee and don't usually go to sleep immediately afterwards
> unless wakeup granularity is reached. 

Exactly that.

> Signed-off-by: Libo Chen <libo.chen@oracle.com>
> ---
>  kernel/sched/fair.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 794c2cb945f8..59b210d2cdb5 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6704,7 +6704,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  static int
>  select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>  {
> -	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
> +	/* Don't set sync for wakeup from irq/soft ctx */
> +	int sync = in_task() && (wake_flags & WF_SYNC)
> +		   && !(current->flags & PF_EXITING);

That's not a coding style you'll find anywhere near this code though.
I'll fix it up.

>  	struct sched_domain *tmp, *sd = NULL;
>  	int cpu = smp_processor_id();
>  	int new_cpu = prev_cpu;
> --
> 2.31.1
> 
