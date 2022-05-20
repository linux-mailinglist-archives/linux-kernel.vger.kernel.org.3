Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6717052F4B6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 23:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353532AbiETVAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 17:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237815AbiETVAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 17:00:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79995197F6D
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:00:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DAE8B82E16
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 21:00:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69F6C385A9;
        Fri, 20 May 2022 21:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653080408;
        bh=81ww+r09God8kJf63NVLEEAm8wLtuCrrWf1LX6ShwaM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AtqoVG6jOY3NwniA4c0cylMumSdQ/hFRkfoyTE7usXblm8lIA7eRhhz9wBSNRm8Iu
         uRbjGgoOyPLbTqiJLnGr+L6kZUWvZTFpSyvUG3cQ7Hb19nxQZk0GC8xFKcNfxVDMpd
         mUM2UAs8XSpkfUkYN76sxSn5590L1VU0tpVHmcrdvmagx+Mhqwro/wF9sM5/zX7eZG
         /T6eE/8vux1LPYuVE+n56feh1ymEc977XTf8IqBhHbgHF6mQXsVxAjI5XVd7Pk+1gw
         b8l9zLtvwWyIJUFQzmQqHEYCCTBPrRC9tm6yiNU/BPAM6Lafhi5tOgaZvDBEXfFUEw
         AZ2k6aZgL/XZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5102E5C05F8; Fri, 20 May 2022 14:00:08 -0700 (PDT)
Date:   Fri, 20 May 2022 14:00:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     frederic@kernel.org, rjw@rjwysocki.net, x86@kernel.org,
        linux-kernel@vger.kernel.org, jpoimboe@kernel.org
Subject: Re: [RFC][PATCH 5/9] rcu: Fix rcu_idle_exit()
Message-ID: <20220520210008.GM1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220519212750.656413111@infradead.org>
 <20220519213421.869214636@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519213421.869214636@infradead.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 11:27:55PM +0200, Peter Zijlstra wrote:
> Current rcu_idle_exit() is terminally broken because it uses
> local_irq_{save,restore}(), which are traced which uses RCU.
> 
> However, now that all the callers are sure to have IRQs disabled, we
> can remove these calls.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

This looks good to me.  If there are any callers with IRQs still
enabled, the lockdep_assert_irqs_disabled() should catch them.
And yes, after looking at the definition, I agree that it is just
fine to invoke lockdep_assert_irqs_disabled() from noinstr code.
The underlying __WARN_printf() might need an RCU_NONIDLE() or
equivalent, but if so that is a separate issue.

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/tree.c |    9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -659,7 +659,7 @@ static noinstr void rcu_eqs_enter(bool u
>   * If you add or remove a call to rcu_idle_enter(), be sure to test with
>   * CONFIG_RCU_EQS_DEBUG=y.
>   */
> -void rcu_idle_enter(void)
> +void noinstr rcu_idle_enter(void)
>  {
>  	lockdep_assert_irqs_disabled();
>  	rcu_eqs_enter(false);
> @@ -896,13 +896,10 @@ static void noinstr rcu_eqs_exit(bool us
>   * If you add or remove a call to rcu_idle_exit(), be sure to test with
>   * CONFIG_RCU_EQS_DEBUG=y.
>   */
> -void rcu_idle_exit(void)
> +void noinstr rcu_idle_exit(void)
>  {
> -	unsigned long flags;
> -
> -	local_irq_save(flags);
> +	lockdep_assert_irqs_disabled();
>  	rcu_eqs_exit(false);
> -	local_irq_restore(flags);
>  }
>  EXPORT_SYMBOL_GPL(rcu_idle_exit);
>  
> 
> 
