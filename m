Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EE257D7F1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 03:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiGVBQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 21:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiGVBQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 21:16:14 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C115130F52;
        Thu, 21 Jul 2022 18:16:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 18983CE2739;
        Fri, 22 Jul 2022 01:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43801C3411E;
        Fri, 22 Jul 2022 01:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658452570;
        bh=EQxRHzOTUNEP2DZ6WPAZX6tA2wJK/QDVgEKiCgPe/Fo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TrjnKoX9R0RkxczhcxvzYkdmj+LOIYfGoo/6rAjbn0BYA5OEZTa0X4Qa7Po17Mjg+
         JNpty7YEarg0SJLTnnDcyhVKU0in1Tz8XlbWnC+5At8Lwb4rXReag3vLd2rkWiZ/bT
         MqdTMYULpsmG8og4oz9/kqEp1YY1MOl5DectNcE+RTCCaRCrvhnfXmRWcV7/uM9HtG
         wCZhkWiox/i0s7cnEnESfs6iEFw4aEII3T/0kesGlTdKw/9nqQvbtAep8NWchQw2Tv
         bRi08p22nLr62GSTSqqwyzcWXhBkYwQnXEKDZ7zLVckYomg5IN2ZxwqQ+9hDOBhgp8
         NzYMb2MN3I0OQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C45F45C03A4; Thu, 21 Jul 2022 18:16:09 -0700 (PDT)
Date:   Thu, 21 Jul 2022 18:16:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Only check tasks blocked on leaf rcu_nodes for
 PREEMPT_RCU
Message-ID: <20220722011609.GD1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220722005213.3511188-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722005213.3511188-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 08:52:13AM +0800, Zqiang wrote:
> In PREEMPT_RCU kernel, for multi-node rcu tree, if the RCU read
> critical section is preempted, the current task are only queued
> leaf rcu_node blkd list, for single-node rcu tree, the root node
> is also leaf node.
> 
> This commit add rcu_is_leaf_node() to filter out checks for non-leaf
> rcu_node.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

First, thank you for digging into this!

> ---
>  kernel/rcu/tree_plugin.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index b2219577fbe2..a9df11ec65af 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -693,6 +693,8 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
>  
>  	RCU_LOCKDEP_WARN(preemptible(), "rcu_preempt_check_blocked_tasks() invoked with preemption enabled!!!\n");
>  	raw_lockdep_assert_held_rcu_node(rnp);
> +	if (!rcu_is_leaf_node(rnp))
> +		goto end;
>  	if (WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp)))
>  		dump_blkd_tasks(rnp, 10);
>  	if (rcu_preempt_has_tasks(rnp) &&

So you are adding a simple check for all rcu_node structures
that removes two simple checks for non-leaf rcu_node structures.

Assuming that the costs of all these checks is roughly the same (but
please feel free to actually measure them on real hardware), what what
fraction of the rcu_node structures must be non-leaf for this change to
be a win?  Then for what configurations using default fanouts is this
fraction exceeded?

The default fanout is 16 from non-leaf to leaf and 64 from non-leaf
to non-leaf (32 for non-leaf to non-leaf on 32-bit systems).

Hey, you wanted some algebra practice anyway.  ;-)

> @@ -703,6 +705,7 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
>  		trace_rcu_unlock_preempted_task(TPS("rcu_preempt-GPS"),
>  						rnp->gp_seq, t->pid);
>  	}
> +end:
>  	WARN_ON_ONCE(rnp->qsmask);
>  }
>  
> @@ -1178,7 +1181,8 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
>   */
>  static void rcu_preempt_boost_start_gp(struct rcu_node *rnp)
>  {
> -	rnp->boost_time = jiffies + RCU_BOOST_DELAY_JIFFIES;
> +	if (rcu_is_leaf_node(rnp))
> +		rnp->boost_time = jiffies + RCU_BOOST_DELAY_JIFFIES;

And here you are adding a check on all nodes to eliminate an addition
and a store on non-leaf nodes.  Same questions as above, with the same
invitation to actually measure the costs of these operations.

						Thanx, Paul

>  }
>  
>  /*
> -- 
> 2.25.1
> 
