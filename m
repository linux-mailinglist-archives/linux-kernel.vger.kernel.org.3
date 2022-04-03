Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20CE4F0AE5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 17:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356345AbiDCPsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 11:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359367AbiDCPsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 11:48:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D61326FA;
        Sun,  3 Apr 2022 08:46:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B923B80D59;
        Sun,  3 Apr 2022 15:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D6EC340ED;
        Sun,  3 Apr 2022 15:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649000787;
        bh=AjbUxfWQZJ9LYtaZniXFzkk6R9dJGhR3P9jE0QaU830=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CS+s8AcA46FV07MxUpkF1gm4zEp8aFD09GumCLkzkZZbsCM7faRoRPXNulXM9F1dB
         rJSj62/xWhZbDVZ9RxK5UsSQrQUTQla7JRatMCJnJA+TTJSiaY8XxxtfJ6pSufhY1Q
         iNO1niut5f2NPYoEdhZF61FsMY0drUJwDz0ExNRGsr3g7E1bj44lpM0njvsSrczIPY
         /ogzxg9Gt7SycUxE5/jQoAIKpDOkkBz5gN6w+8gc7avNf8dHM74yWWgVj/8JpneTRb
         idC1OnfcNHyUONGAjbIWweQ0v0+NOnY7MKxiNanIyEtmhtQWezbGH7zXWS0TTrIraB
         hlyTsP6G8lzUg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 805B25C0555; Sun,  3 Apr 2022 08:46:26 -0700 (PDT)
Date:   Sun, 3 Apr 2022 08:46:26 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Use IRQ_WORK_INIT_HARD() to initialize defer_qs_iw
 on PREEMPT_RT kernel
Message-ID: <20220403154626.GO4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220403061440.2762522-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220403061440.2762522-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2022 at 02:14:40PM +0800, Zqiang wrote:
> On non-PREEMPT_RT kernel, the init_irq_work() make the defer_qs_iw irq-work
> execute in interrupt context. however, on PREEMPT_RT kernel, the
> init_irq_work() make defer_qs_iq irq-work execute in rt-fifo irq_work
> kthreads. when system booting, and the CONFIG_RCU_STRICT_GRACE_PERIOD
> is enabled, there are a lot of defer_qs_iw irq-work to be processed
> in rt-fifo irq_work kthreads, it occupies boot CPU for long time and
> cause other kthread cannot get the boot CPU, the boot process occurs
> hang. use IRQ_WORK_INIT_HARD() to initialize defer_qs_iw irq-work, can
> ensure the defer_qs_iw irq-work always execute in interrupt context,
> whether PREEMPT_RT or non PREEMPT_RT kernel.

This is a much better justification of the need for a change, thank you!

But it looks like I need to clarify a sentence in my previous email.

Please note that you were using the debugging RCU_STRICT_GRACE_PERIOD
Kconfig option, so this is a potential problem as opposed to an immediate
bug.  Yes, we must fix bugs, but it is also very important to avoid
harming other workloads, which are after all the vast majority of the
uses of the Linux kernel.

And a major purpose of things like RCU_STRICT_GRACE_PERIOD is to give
us advanced warning of bugs so that we can fix them properly, without
hurting other workloads.

So, does this patch guarantee exactly the same performance and scalability
as before for !PREEMPT_RT systems?  If so, please add an explanation to
the commit log.

Otherwise, please adjust the code to provide this guarantee.

							Thanx, Paul

> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tree_plugin.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 3037c2536e1f..cf7bd28af8ef 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -661,7 +661,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)) {
>  				// Get scheduler to re-evaluate and call hooks.
>  				// If !IRQ_WORK, FQS scan will eventually IPI.
> -				init_irq_work(&rdp->defer_qs_iw, rcu_preempt_deferred_qs_handler);
> +				rdp->defer_qs_iw = IRQ_WORK_INIT_HARD(rcu_preempt_deferred_qs_handler);
>  				rdp->defer_qs_iw_pending = true;
>  				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
>  			}
> -- 
> 2.25.1
> 
