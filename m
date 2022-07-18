Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FAB578629
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 17:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbiGRPVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 11:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbiGRPVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 11:21:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02DD24F19;
        Mon, 18 Jul 2022 08:21:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B21EB81648;
        Mon, 18 Jul 2022 15:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD6FC341C0;
        Mon, 18 Jul 2022 15:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658157693;
        bh=I/TBfThf+GVBYyftAkmpjprcJnF2VvnJnQVBOLBfJ10=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lA/7IRBZr7io4jctntTUqJROC4dYgBh5BxVx4jcNtGnVdM11O4X7CsC450a1re6oe
         5HcnxNne/Z+uLZV3TkA4bXPdyZvzldmDBjP5SaIeGKRIqLAsDBCcXrBjU7BQQ4HbBD
         k0nlRC6D8rDt8MSuda/pZ6bysmnDDc4Tt9AD6S+P/Wx1msxVKQ2LedvfG5O1Xrihsx
         9mBwp3+DvAvEHZqy3nTbug44S2RTnz+g5dh3A6DR7Js4C3uk4wI9CQ2MOfN4uPEKdg
         JSPwj0wSaev+cAkiikzwUekLkb9ySmhtPT7uXl4RXhjfmhlJ/zz47l1fCLJOJMq9k4
         CHTehAd3VdZTg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 844E55C0833; Mon, 18 Jul 2022 08:21:32 -0700 (PDT)
Date:   Mon, 18 Jul 2022 08:21:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcu-tasks: Make RCU Tasks Trace checking for
 userspace execution
Message-ID: <20220718152132.GE1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220718001610.263700-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718001610.263700-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 08:16:10AM +0800, Zqiang wrote:
> For RCU tasks trace, the userspace execution is also a valid quiescent
> state, if the task is in userspace, the ->trc_reader_nesting should be
> zero and if the ->trc_reader_special.b.need_qs is not set, set the
> tasks ->trc_reader_special.b.need_qs is TRC_NEED_QS_CHECKED, this cause
> grace-period kthread remove it from holdout list if it remains here.
> 
> This commit add rcu_tasks_trace_qs() to rcu_flavor_sched_clock_irq()
> when the kernel built with no PREEMPT_RCU.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

The looks plausible to me, but can you tell me how this avoids the
following sequence of events?

o	CPU 0 takes a scheduling-clock interrupt.  Just before this
	point CPU 0 was running in user context, thus as you say
	should not be in an RCU Tasks quiescent state.

o	CPU 0 enters an RCU Tasks Trace read-side critical section.

o	CPU 1 starts a new RCU Tasks Trace grace period.

o	CPU 0 reaches the newly added rcu_note_voluntary_context_switch().

	Except that the quiescent state implied by userspace execution
	was before the new grace period, and thus does not apply to it.

(Yes, I know, if this is a bug in this patch, the bug already exists
due to the call in rcu_flavor_sched_clock_irq() for !PREEMPT kernels,
but if this change is safe, it should be possible to explain why.)

							Thanx, Paul

> ---
>  v1->v2:
>  Fix build error due to undeclared rcu_tasks_trace_qs(), note in no-PREEMPT_RCU
>  kernel, the RCU Tasks is replaced by RCU, so rcu_note_voluntary_context_switch()
>  only include rcu_tasks_trace_qs().
> 
>  kernel/rcu/tree_plugin.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 4152816dd29f..5fb0b2dd24fd 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -976,7 +976,7 @@ static void rcu_flavor_sched_clock_irq(int user)
>  		 * neither access nor modify, at least not while the
>  		 * corresponding CPU is online.
>  		 */
> -
> +		rcu_note_voluntary_context_switch(current);
>  		rcu_qs();
>  	}
>  }
> -- 
> 2.25.1
> 
