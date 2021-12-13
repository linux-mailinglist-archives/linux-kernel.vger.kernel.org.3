Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC30472B8B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236148AbhLMLfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:35:02 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44104 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbhLMLfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:35:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00CE7B81071;
        Mon, 13 Dec 2021 11:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23454C34604;
        Mon, 13 Dec 2021 11:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639395298;
        bh=tF7vAmUoMebaQ7l7tabIPUqZ3TeZCV4ZMKEWEWCvULk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g98NkDGLqnVqMw388Ak7V1i2xSv3di3+ZOct6RmffIsB2KRnWawnzRwU8slApd0Cl
         JxWOJxn/PnpRI0dcXyeYa5cnqMsz/r5YoDQz8C0RHuVHQCMP9clcoTarkIRqVdm2Y/
         x23LYlQb6nPO4Qkvs8zO2E2PeSHpJOH9iuBpOCq7potNaXGAuggJZ64Pk6dRibkKaW
         jORqgByvfeIP4Pw3aq8GTFmlw0Qp+zzrdOJhZ1R65j+K0VjCdiZrMUGPY8/d9l6gdU
         PZMq6Am5JuHK8yIhqZYTBa77g2nC4UFcLiNWqY3EFFjItTEEaUWhkFDXOruH6DOI3I
         McDAcAoeJDl0w==
Date:   Mon, 13 Dec 2021 12:34:55 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, urezki@gmail.com,
        boqun.feng@gmail.com
Subject: Re: [PATCH] rcu/exp: Fix check for idle context in rcu_exp_handler
Message-ID: <20211213113455.GB782195@lothringen>
References: <20211213061024.24285-1-quic_neeraju@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213061024.24285-1-quic_neeraju@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 11:40:24AM +0530, Neeraj Upadhyay wrote:
> For PREEMPT_RCU, the rcu_exp_handler() function checks
> whether the current CPU is in idle, by calling
> rcu_dynticks_curr_cpu_in_eqs(). However, rcu_exp_handler()
> is called in IPI handler context. So, it should be checking
> the idle context using rcu_is_cpu_rrupt_from_idle(). Fix this
> by using rcu_is_cpu_rrupt_from_idle() instead of
> rcu_dynticks_curr_cpu_in_eqs(). Non-preempt configuration
> already uses the correct check.
> 
> Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>


> ---
>  kernel/rcu/tree_exp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 237a79989aba..1568c8ef185b 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -656,7 +656,7 @@ static void rcu_exp_handler(void *unused)
>  	 */
>  	if (!depth) {
>  		if (!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)) ||
> -		    rcu_dynticks_curr_cpu_in_eqs()) {
> +		    rcu_is_cpu_rrupt_from_idle()) {
>  			rcu_report_exp_rdp(rdp);
>  		} else {
>  			WRITE_ONCE(rdp->cpu_no_qs.b.exp, true);
> -- 
> 2.17.1
> 
