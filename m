Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475085721D6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 19:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbiGLRhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 13:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiGLRhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 13:37:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5FEC4440;
        Tue, 12 Jul 2022 10:37:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55F2DB81B07;
        Tue, 12 Jul 2022 17:37:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF30AC3411C;
        Tue, 12 Jul 2022 17:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657647430;
        bh=LRWZAR5Uvb+52sz0yd/em2VWKtd15SMVCf9+V7pHL5M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=C5YGwce5ABrT3ad2CNSpd624+4/8x968FVqGA/KG4Z9XvmWTqJxyNHN8Fn4qhS4Gt
         I4AcgOlXB+LNIZMFNe9ewJAC0k6pPgeqJmCjVtRn+GY7EdflJSFPR3yQ37xUnZz+Az
         wHXhQ4Xhxsywq3Q8ANYCeEwaGZqSYTQy4BHB2MAZHXaxrAEjOOSTiDctnlFbYULDV9
         t+r6/7fwW/N+Ep4nnFoqDcq3MpptXpfSe+SSAp39BMmXcM52fobnP3IqcDfV6WD0FI
         zCSMBGPin26MLPOy82S0Zc9Zv6CljFT5HxCjvuY+wPp7iim0k+feJjD7bmdXME4Eiw
         uzBrTUONH+r7w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 847DE5C08C7; Tue, 12 Jul 2022 10:37:09 -0700 (PDT)
Date:   Tue, 12 Jul 2022 10:37:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rcu-tasks: Make synchronize_rcu_tasks_generic()
 no-ops on early booting
Message-ID: <20220712173709.GX1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220712082606.3662616-1-qiang1.zhang@intel.com>
 <20220712082606.3662616-3-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712082606.3662616-3-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 04:26:06PM +0800, Zqiang wrote:
> When the rcu_scheduler_active variable is RCU_SCHEDULER_INACTIVE and not
> yet converted to RCU_SCHEDULER_INIT, there is only idle task, any legal
> call synchronize_rcu_tasks_generic() is a quiescent state. this commit
> make synchronize_rcu_tasks_generic() no-ops when the rcu_scheduler_active
> variable is RCU_SCHEDULER_INACTIVE.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---

It looks like this would be a good way to provide early boot access
to synchronize_rcu_tasks(), synchronize_rcu_tasks_rude(), and
synchronize_rcu_tasks_trace().

But do we really need early boot access to these functions?  As in has
the below WARN_ON() actually triggered?

And if it has triggered, and in a context that means that these functions
really are needed during early boot, how should the testing strategy
change to test these at the relevant portions of the boot sequence?

From what I know, hitting these during early boot would indicate that
something was removing a trace during early boot, and I know of no way
to make that happen.  Hence my skepticism.  ;-)

But *if* this was really needed, this looks to be a reasonable way to
implement it.

							Thanx, Paul

>  kernel/rcu/tasks.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 469bf2a3b505..0237e765c28e 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -560,8 +560,9 @@ static int __noreturn rcu_tasks_kthread(void *arg)
>  static void synchronize_rcu_tasks_generic(struct rcu_tasks *rtp)
>  {
>  	/* Complain if the scheduler has not started.  */
> -	WARN_ONCE(rcu_scheduler_active == RCU_SCHEDULER_INACTIVE,
> -			 "synchronize_rcu_tasks called too soon");
> +	if (WARN_ONCE(rcu_scheduler_active == RCU_SCHEDULER_INACTIVE,
> +			 "synchronize_rcu_tasks called too soon"))
> +		return;
>  
>  	// If the grace-period kthread is running, use it.
>  	if (READ_ONCE(rtp->kthread_ptr)) {
> -- 
> 2.25.1
> 
