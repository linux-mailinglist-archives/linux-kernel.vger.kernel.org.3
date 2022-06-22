Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C4C556EF1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 01:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377128AbiFVXSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 19:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345283AbiFVXSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 19:18:05 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F4028723
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 16:18:04 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 89so27544888qvc.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 16:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Lv2YHbzczEnD79dGcE3EqQq0j0lYfO0G5UeuRdLMomc=;
        b=LKwLtr9tC1PCUSXdzoCFckZrE8VzaSY4CDmlz9azEjSyQxkZM2GS0CUHp1Mu+wqEtL
         fThxINyXaVHVtWWxa9XjIf08YL+egNsTKnmI6MD8bBKhiInBE6e8KUfmYJvF6Rsv/+4h
         DR66OOmipWp5iVrlRYu1SFNE1oMLeDf0G8scQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lv2YHbzczEnD79dGcE3EqQq0j0lYfO0G5UeuRdLMomc=;
        b=Ih/HfO8S68CPB5C4J5neS8FJn2FTrobv0Hvojgjm1IHhOtoxoI3YpvaPOrGMgw5MBZ
         yJFNtDZDfbqePOM+GO3OWADV/PWPzAkM0pFn6B0j4SepMnmgxsmuSI0stssxDBXXMnC2
         lEsZOb/daK1Z1J6P0R622ejjWwK2e/IDDyTR3T4kixJqRE/V8TvYKX/rMrYp/IHcBXOm
         MnP/3PUx1KUGQJvtJJUW2u/X1w8iJKp6fUYcGohwjRuradZMD3CCeov4fqZ5Ft6N4Bjw
         nONIjqO/zrZy5qVWD6Roh+lUoBs7nUgHoNmgdriOdNXhFpwGXCqKT2OxvgzdyYDB8tM5
         +eMg==
X-Gm-Message-State: AJIora8JMAiHz/yvACVgwni//YjnA9f98t2CDDDfCzowIdz7WHtlJKLn
        C9r7xddfWqTr1DkMtv6G+j3rDMN5VDxRtw==
X-Google-Smtp-Source: AGRyM1t6A+bwk6XS0jPFAY5czbG4n/cXc+iiNVLIfaJo1O+D+ctCSvdqMkpVzsUOo0p14n1sEB9p6g==
X-Received: by 2002:a05:6214:20cf:b0:470:5256:c667 with SMTP id 15-20020a05621420cf00b004705256c667mr9542537qve.43.1655939883117;
        Wed, 22 Jun 2022 16:18:03 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id e12-20020ac84e4c000000b00307cebe3e07sm13474875qtw.79.2022.06.22.16.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 16:18:02 -0700 (PDT)
Date:   Wed, 22 Jun 2022 23:18:02 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org
Subject: Re: [PATCH v2 1/8] rcu: Introduce call_rcu_lazy() API implementation
Message-ID: <YrOjKnMHo4/NNDwy@google.com>
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622225102.2112026-3-joel@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 10:50:55PM +0000, Joel Fernandes (Google) wrote:
[..]
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 2ccf5845957d..fec4fad6654b 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -267,8 +267,9 @@ struct rcu_data {
>  /* Values for nocb_defer_wakeup field in struct rcu_data. */
>  #define RCU_NOCB_WAKE_NOT	0
>  #define RCU_NOCB_WAKE_BYPASS	1
> -#define RCU_NOCB_WAKE		2
> -#define RCU_NOCB_WAKE_FORCE	3
> +#define RCU_NOCB_WAKE_LAZY	2
> +#define RCU_NOCB_WAKE		3
> +#define RCU_NOCB_WAKE_FORCE	4
>  
>  #define RCU_JIFFIES_TILL_FORCE_QS (1 + (HZ > 250) + (HZ > 500))
>  					/* For jiffies_till_first_fqs and */
> @@ -436,9 +437,10 @@ static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
>  static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
>  static void rcu_init_one_nocb(struct rcu_node *rnp);
>  static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> -				  unsigned long j);
> +				  unsigned long j, bool lazy);
>  static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> -				bool *was_alldone, unsigned long flags);
> +				bool *was_alldone, unsigned long flags,
> +				bool lazy);
>  static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_empty,
>  				 unsigned long flags);
>  static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp, int level);
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index e369efe94fda..b9244f22e102 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -256,6 +256,8 @@ static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
>  	return __wake_nocb_gp(rdp_gp, rdp, force, flags);
>  }
>  
> +#define LAZY_FLUSH_JIFFIES (10 * HZ)
> +
>  /*
>   * Arrange to wake the GP kthread for this NOCB group at some future
>   * time when it is safe to do so.
> @@ -272,7 +274,10 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
>  	 * Bypass wakeup overrides previous deferments. In case
>  	 * of callback storm, no need to wake up too early.
>  	 */
> -	if (waketype == RCU_NOCB_WAKE_BYPASS) {
> +	if (waketype == RCU_NOCB_WAKE_LAZY) {
> +		mod_timer(&rdp_gp->nocb_timer, jiffies + LAZY_FLUSH_JIFFIES);
> +		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
> +	} else if (waketype == RCU_NOCB_WAKE_BYPASS) {
>  		mod_timer(&rdp_gp->nocb_timer, jiffies + 2);
>  		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
>  	} else {
> @@ -296,7 +301,7 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
>   * Note that this function always returns true if rhp is NULL.
>   */
>  static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> -				     unsigned long j)
> +				     unsigned long j, bool lazy)
>  {
>  	struct rcu_cblist rcl;
>  
> @@ -310,7 +315,13 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>  	/* Note: ->cblist.len already accounts for ->nocb_bypass contents. */
>  	if (rhp)
>  		rcu_segcblist_inc_len(&rdp->cblist); /* Must precede enqueue. */
> -	rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
> +
> +	trace_printk("call_rcu_lazy callbacks = %ld\n", READ_ONCE(rdp->nocb_bypass.lazy_len));

Before anyone yells at me, that trace_printk() has been politely asked to take
a walk :-). It got mad at me, but on the next iteration, it wont be there.

thanks,

 - Joel

 
