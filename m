Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BBE5379FE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbiE3Lgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiE3Lgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:36:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822F520183
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:36:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F1CC6117F
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 11:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E1DC385B8;
        Mon, 30 May 2022 11:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653910603;
        bh=5LtQDdTkIvQa6ICSoLrYFZ54K3qngKB9lzRRMnsuNyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p5qi07HIIQiGu/LzCxw4uSlKkYuhGQmrA2S71NSAEzkRMS2hNXbxPDIFil1bxIpAC
         tul20n4qsXybFJ5Tg9BBn4sUysu++BNTk2JFVq9vd6GSHnZ2A1gEyA1YAXceJLa1xy
         JVcr45x13Oa7xhTSw1+k7VjOkKDqAXk/X8i4HIGgd0OT/QkiM+MN6H//rrnXjjqPBe
         UrKeJREAY0JOBfjw1km38BF61GffXn1TP2kIzCg0W+Aa676B8F6WSNWDp18G8EaM/E
         ZuAkmP2chCtuP20CpTPv4vQOrYpgij9RdaORboyyPNidIAYzvIO9+UldW/19QE1pi5
         TRplFK68y5bCg==
Date:   Mon, 30 May 2022 13:36:40 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     paulmck@kernel.org, rjw@rjwysocki.net, x86@kernel.org,
        linux-kernel@vger.kernel.org, jpoimboe@kernel.org
Subject: Re: [RFC][PATCH 3/9] cpuidle: Move IRQ state validation
Message-ID: <20220530113640.GC1257179@lothringen>
References: <20220519212750.656413111@infradead.org>
 <20220519213421.748352112@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519213421.748352112@infradead.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 11:27:53PM +0200, Peter Zijlstra wrote:
> Make cpuidle_enter_state() consistent with the s2idle variant and
> verify ->enter() always returns with interrupts disabled.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  drivers/cpuidle/cpuidle.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -234,7 +234,11 @@ int cpuidle_enter_state(struct cpuidle_d
>  	stop_critical_timings();
>  	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
>  		rcu_idle_enter();
> +
>  	entered_state = target_state->enter(dev, drv, index);
> +	if (WARN_ON_ONCE(!irqs_disabled()))
> +		raw_local_irq_disable();

So it means that idle functions are supposed to return with IRQs disabled
without tracing, right? I can see that at least acpi_safe_halt() is using
the non-raw local_irq_disable().

> +
>  	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
>  		rcu_idle_exit();
>  	start_critical_timings();
> @@ -246,12 +250,8 @@ int cpuidle_enter_state(struct cpuidle_d
>  	/* The cpu is no longer idle or about to enter idle. */
>  	sched_idle_set_state(NULL);
>  
> -	if (broadcast) {
> -		if (WARN_ON_ONCE(!irqs_disabled()))
> -			local_irq_disable();
> -
> +	if (broadcast)
>  		tick_broadcast_exit();
> -	}
>  
>  	if (!cpuidle_state_is_coupled(drv, index))
>  		local_irq_enable();
> 
> 
