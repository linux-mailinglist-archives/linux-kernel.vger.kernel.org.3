Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E715735C0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 13:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbiGMLqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 07:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235725AbiGMLq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:46:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BA010273C;
        Wed, 13 Jul 2022 04:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BYYELStWS2hN6y0lTADUOUo9y3x8GZgQvz5BQe8u10g=; b=eGZTXGFuiXmNipSFTnNbXYluEh
        1LFJOQTJIEzwRokS/1RLy+u2v5hbNyVhM844nZB1XkIEiTuPnUMXDD87S0d5hy+ok/KuYzVcoqdRp
        h0VGOmgymZd2sM0LxJj0T168PXgRz4nSBzBAET+klvgQNwrMFDTdP4A/G9sIBH60eIaHJn0W1Jegt
        rV6/JRIPfwEEKhhKY98nQIagYlQHor+z7DzT9GFnIkJXf4NJg6a6//06ejEGiv8RaZszCP1Y3f3Dm
        4UnOfFAM+uaJ5+fN4A4+m2Eqgbr0rB3DQx74NhCr7ZHtchzMuk9mnhp6Soao7V/fJoxD7iKMBlDbW
        LOR54l8w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBaoo-0088q2-9R; Wed, 13 Jul 2022 11:46:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 84AF3300110;
        Wed, 13 Jul 2022 13:46:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 45DBD20D74F04; Wed, 13 Jul 2022 13:46:11 +0200 (CEST)
Date:   Wed, 13 Jul 2022 13:46:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH] sched/deadline: Fix BUG_ON condition for deboosted tasks
Message-ID: <Ys6wgxiZbdjxyh8C@hirez.programming.kicks-ass.net>
References: <20220713075014.411739-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713075014.411739-1-juri.lelli@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 09:50:14AM +0200, Juri Lelli wrote:
> Tasks the are being deboosted from SCHED_DEADLINE might enter
> enqueue_task_dl() one last time and hit an erroneous BUG_ON condition:
> since they are not boosted anymore, the if (is_dl_boosted()) branch is
> not taken, but the else if (!dl_prio) is and inside this one we
> BUG_ON(!is_dl_boosted), which is of course false (BUG_ON triggered)
> otherwise we had entered the if branch above. Long story short, the
> current condition doesn't make sense and always leads to triggering of a
> BUG.
> 
> Fix this by only checking enqueue flags, properly: ENQUEUE_REPLENISH has
> to be present, but additional flags are not a problem.
> 
> Fixes: 2279f540ea7d ("sched/deadline: Fix priority inheritance with multiple scheduling classes")
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---
>  kernel/sched/deadline.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 5867e186c39a..0447d46f4718 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1703,7 +1703,7 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
>  		 * the throttle.
>  		 */
>  		p->dl.dl_throttled = 0;
> -		BUG_ON(!is_dl_boosted(&p->dl) || flags != ENQUEUE_REPLENISH);
> +		BUG_ON(!(flags & ENQUEUE_REPLENISH));

While there, can we perhaps make it less fatal? 
