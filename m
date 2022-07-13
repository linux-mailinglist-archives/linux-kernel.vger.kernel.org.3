Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC501573F02
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 23:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237415AbiGMVbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 17:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiGMVba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 17:31:30 -0400
Received: from outgoing-stata.csail.mit.edu (outgoing-stata.csail.mit.edu [128.30.2.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA0222B2C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:31:29 -0700 (PDT)
Received: from c-24-17-218-140.hsd1.wa.comcast.net ([24.17.218.140] helo=srivatsab-a02.vmware.com)
        by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <srivatsa@csail.mit.edu>)
        id 1oBjwx-000X0z-Mp; Wed, 13 Jul 2022 17:31:15 -0400
To:     Juri Lelli <juri.lelli@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sharan Turlapati <sturlapati@vmware.com>, bordoloih@vmware.com,
        ankitja@vmware.com, Keerthana K <keerthanak@vmware.com>,
        Anish Swaminathan <anishs@vmware.com>,
        Srivatsa Bhat <srivatsab@vmware.com>
References: <20220713075014.411739-1-juri.lelli@redhat.com>
From:   "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: [PATCH] sched/deadline: Fix BUG_ON condition for deboosted tasks
Message-ID: <806a86d3-5204-145e-af46-023bf0142aa8@csail.mit.edu>
Date:   Wed, 13 Jul 2022 14:31:12 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220713075014.411739-1-juri.lelli@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Juri,

On 7/13/22 12:50 AM, Juri Lelli wrote:
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

It looks like this problem goes further back than the above commit
(which was merged in v5.10).

Even the oldest LTS kernel (4.9) has code like this:

if (... && p->dl.dl_boosted && ...)) {
	/* code */

} else if (!dl_prio(p->normal_prio)) {

	BUG_ON(!p->dl.dl_boosted || flags != ENQUEUE_REPLENISH);
	return;
} 

And we have observed crashes in the 4.19 kernel series too (CC'ed
Ankit Jain and Him Kalyan who have reproduced this issue).

I believe commit 64be6f1f5f71 ("sched/deadline: Don't replenish from a
!SCHED_DEADLINE entity") introduced the problem, which dates back to
v3.18.

Would you mind updating the Fixes: tag and adding a CC: stable tag as
well, when you respin the patch, please?

Thank you!

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
>  		return;
>  	}
>  
> 

Regards,
Srivatsa
VMware Photon OS
