Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB474734D6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242240AbhLMTUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238814AbhLMTUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:20:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA15C061574;
        Mon, 13 Dec 2021 11:20:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58BF0B812A9;
        Mon, 13 Dec 2021 19:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDA6C34602;
        Mon, 13 Dec 2021 19:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639423213;
        bh=dVOQkoPSpvtHpQHWFwN+bzQdI2n0UetrZqTKARhnvJw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KcYA8pr5SP80aeDn8a6cV0q2h+gJKeexOAmYyF0MiZTki1vM30gh7mWUuuEAdxxB+
         a8wi9WMj8vySayN+ta1q4cr0cRZbnQ6OpWGgdJQiZ/7if1Nuy6VJKMhlbosz24AZCE
         EvEzNDrtOKX0lFvYQED2eoOULa5ptXLjapfXlu8+ttZ94WaZALmKougseWNHPaQ2WI
         ZTsaPJu54nKFrWntnV036bbdxv/OhTtf+6uj1LKE3olVU1nG0tOiqTC86+8U0TJ3ds
         pptklgkj4Gd4GIaU95d1W6wo8NY9rVpejmjLKhTFA5HcuXOna1e37lEvMyqbr/BRk8
         us+cKZ3tb/Ayw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EA0E35C0B9E; Mon, 13 Dec 2021 11:20:12 -0800 (PST)
Date:   Mon, 13 Dec 2021 11:20:12 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Neeraj Upadhyay <quic_neeraju@quicinc.com>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        urezki@gmail.com, boqun.feng@gmail.com
Subject: Re: [PATCH] rcu/exp: Fix check for idle context in rcu_exp_handler
Message-ID: <20211213192012.GQ641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211213061024.24285-1-quic_neeraju@quicinc.com>
 <20211213113455.GB782195@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213113455.GB782195@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 12:34:55PM +0100, Frederic Weisbecker wrote:
> On Mon, Dec 13, 2021 at 11:40:24AM +0530, Neeraj Upadhyay wrote:
> > For PREEMPT_RCU, the rcu_exp_handler() function checks
> > whether the current CPU is in idle, by calling
> > rcu_dynticks_curr_cpu_in_eqs(). However, rcu_exp_handler()
> > is called in IPI handler context. So, it should be checking
> > the idle context using rcu_is_cpu_rrupt_from_idle(). Fix this
> > by using rcu_is_cpu_rrupt_from_idle() instead of
> > rcu_dynticks_curr_cpu_in_eqs(). Non-preempt configuration
> > already uses the correct check.
> > 
> > Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Queued for further review and testing, thank you both!

							Thanx, Paul

> > ---
> >  kernel/rcu/tree_exp.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > index 237a79989aba..1568c8ef185b 100644
> > --- a/kernel/rcu/tree_exp.h
> > +++ b/kernel/rcu/tree_exp.h
> > @@ -656,7 +656,7 @@ static void rcu_exp_handler(void *unused)
> >  	 */
> >  	if (!depth) {
> >  		if (!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)) ||
> > -		    rcu_dynticks_curr_cpu_in_eqs()) {
> > +		    rcu_is_cpu_rrupt_from_idle()) {
> >  			rcu_report_exp_rdp(rdp);
> >  		} else {
> >  			WRITE_ONCE(rdp->cpu_no_qs.b.exp, true);
> > -- 
> > 2.17.1
> > 
