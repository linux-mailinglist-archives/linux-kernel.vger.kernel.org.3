Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DDD59CEB0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 04:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239666AbiHWCgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 22:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238930AbiHWCgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 22:36:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1972B59266
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 19:36:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9ED5B81979
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:36:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F54AC433C1;
        Tue, 23 Aug 2022 02:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661222210;
        bh=6wsJ41sHNLsMsXirAriX8n0KL0bqxfpTRhGqSzaOOkU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TAu1sYMHIw6+nWyAxRCuDYSTirbCavQ2ci8Cg+AdxrYT9orXPagMVpJBl3VkpXzo1
         J3EUEEvqErjwBuuuyW4EU7qFY28sifxwWyWKQt7QKmNBs4NrrE7yEXUJ2byWFB87ac
         vlezC4OljyFnRb7ywE8YBK8Lkq2XOMM1lUV+xuCzsX62vg5KkDsFr+VpwchKhUL/7f
         H+avGDqX2hdUP1rl/pNR3OVbLLoPQunz5q0wV0HDRkBhHAa6QsemL1eaGWHJY+ztrO
         +2SZp52aw7mhcH+yL6wnvnHATRVqg0DG62ePAUHC88KCCDWFDLJ+V83RJLpoUvCvQ6
         Uft3NGwR+92wA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 22E525C05A0; Mon, 22 Aug 2022 19:36:49 -0700 (PDT)
Date:   Mon, 22 Aug 2022 19:36:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <olsajiri@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [BUG v6.0-rc2] lockdep splat on ct_kernel_enter()
Message-ID: <20220823023649.GI6159@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220822164404.57952727@gandalf.local.home>
 <20220822182850.32f91017@gandalf.local.home>
 <20220822183836.6b80976f@gandalf.local.home>
 <20220822204825.3e88b1a4@rorschach.local.home>
 <20220822214024.216fa85d@rorschach.local.home>
 <20220822220134.5d91f3db@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822220134.5d91f3db@rorschach.local.home>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 10:01:34PM -0400, Steven Rostedt wrote:
> On Mon, 22 Aug 2022 21:40:24 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > And this patch (which is wrong, but will at least let my tests finish
> > testing my code) makes the warning go away.
> 
> Well that patch was against the broken commit, but this patch against
> 6.0-rc2 works for me, albeit, it's still wrong ;-)

It does sort of defeat the original purpose.  But maybe it is what is
needed in the near term?

Frederic, thoughts?

							Thanx, Paul

> -- Steve
> 
> diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
> index 77978e372377..17201159f3df 100644
> --- a/kernel/context_tracking.c
> +++ b/kernel/context_tracking.c
> @@ -330,13 +330,13 @@ EXPORT_SYMBOL_GPL(ct_idle_enter);
>   * If you add or remove a call to ct_idle_exit(), be sure to test with
>   * CONFIG_RCU_EQS_DEBUG=y.
>   */
> -void noinstr ct_idle_exit(void)
> +void ct_idle_exit(void)
>  {
>  	unsigned long flags;
>  
> -	raw_local_irq_save(flags);
> +	local_irq_save(flags);
>  	ct_kernel_enter(false, RCU_DYNTICKS_IDX - CONTEXT_IDLE);
> -	raw_local_irq_restore(flags);
> +	local_irq_restore(flags);
>  }
>  EXPORT_SYMBOL_GPL(ct_idle_exit);
>  
