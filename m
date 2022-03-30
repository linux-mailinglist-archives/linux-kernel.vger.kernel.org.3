Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240574ECCF1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 21:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350547AbiC3TJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 15:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350513AbiC3THq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 15:07:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9ACC3206D;
        Wed, 30 Mar 2022 12:05:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C2D1B81D56;
        Wed, 30 Mar 2022 19:05:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0D2C340EE;
        Wed, 30 Mar 2022 19:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648667157;
        bh=K/Hh5iZiT3Tgk4PM6Gqemuqu9GkWgUOCQ66X/KVmIBg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XznOoE8f3EmTAn1Cpr8DrpPIzGWff+sVsZjMOCNpPyi34T+KR2Frr8ybxfnXrNy60
         +VhQ/Eg5u0Qt9tTncB+cykfd0xQo23Pd6o3gTpq2gjgV4ZjZ4q2sb6GVKXJlaVqOUN
         MaKD1A/eVUzHIZyYBuqgiTCzgSAI7Q8vN/0gifKzw4WLUW3skKgTnIX3iGL5f3M97Y
         6VTFeiyTHNQf4Anw3mtnu9rabM9fguWihBQBxIhTyofYZoYw95MMewQRe8I4LPXrbf
         RCtTtVfOfcnfvljz6MW3mQxGV4o8flHEjFZTYUNSvDPcIrHM7XN9eHf+msD6JxC414
         6A3nJ/N7W9MiQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EEA585C12E4; Wed, 30 Mar 2022 12:05:56 -0700 (PDT)
Date:   Wed, 30 Mar 2022 12:05:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu-tasks: Check the atomic variable
 trc_n_readers_need_end again when wait timeout
Message-ID: <20220330190556.GL4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220330112014.2587148-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330112014.2587148-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 07:20:14PM +0800, Zqiang wrote:
> When the trc_wait waitqueue timeout, the atomic variable
> trc_n_readers_need_end need to be checked again, perhaps the
> conditions have been established at this time, avoid invalid
> stall information output.

But are you actually seeing this invalid stall information?  Either way,
please seem my comments and question below.

Please don't get me wrong, we do have similar checks for normal vanilla
RCU stall warnings, for example, this statement in print_other_cpu_stall()
in kernel/rcu/tree_stall.h:

	pr_err("INFO: Stall ended before state dump start\n");

However, the approach used there did benefit from significant real-world
experience with its absence.  ;-)

							Thanx, Paul

> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tasks.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 65d6e21a607a..b73a2b362d6b 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1544,7 +1544,7 @@ static void rcu_tasks_trace_postgp(struct rcu_tasks *rtp)
>  				trc_wait,
>  				atomic_read(&trc_n_readers_need_end) == 0,
>  				READ_ONCE(rcu_task_stall_timeout));

If I understand correctly, this patch is intended to handle a situation
where the wait_event_idle_exclusive_timeout() timed out, but where the
value of trc_n_readers_need_end decreased to zero just at this point.
If so, please see my question below.  If not, please show me the exact
sequence of events leading up to the problem.

> -		if (ret)
> +		if (ret || !atomic_read(&trc_n_readers_need_end))
>  			break;  // Count reached zero.

Couldn't the value of trc_n_readers_need_end decrease to zero right
here, still resulting in invalid stall information?

>  		// Stall warning time, so make a list of the offenders.
>  		rcu_read_lock();
> -- 
> 2.25.1
> 
