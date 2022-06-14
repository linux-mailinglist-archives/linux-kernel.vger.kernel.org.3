Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E09454B9FC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 21:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358052AbiFNTCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 15:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358000AbiFNTBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 15:01:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916AB5F7A;
        Tue, 14 Jun 2022 12:00:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D5DC6178C;
        Tue, 14 Jun 2022 19:00:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620DCC3411D;
        Tue, 14 Jun 2022 19:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655233245;
        bh=TVpir3wYwVDEOeeGCSkukFbIAbJBc7c16wYyw99VVb4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rdhFTLt/oOtIZ4bKThaeg42+QJ/WdtA1T/5QZ1YTiwPh74tz2Tr9k8vUSDjjGqe9e
         dfYJFXJZAkj0XfA6aUJHMKuH66yMRa+Vk30lUnxA1v2NuofoK9KvMMGiZs0+R8uJOU
         IyXi6cQa1viPiwYTtnW9IivTYnbR2cAW2gLHgO6H1eLt8e8I7+xKYGTytlKssJ8Pfg
         kSdzdijE2HIaU9PpU72/kmEjg/Aw1B4pnpRstT1c389dOo0V4AGJvqY6PsWFLbq5e2
         rebZG/6I2tb5M3k1j5W1bDq2mRqrOmO/wSbgOsCBdER3PqqxYCy9CbhgzFIJvER50G
         IAzj+fTJQnOAw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F27FD5C0BCC; Tue, 14 Jun 2022 12:00:44 -0700 (PDT)
Date:   Tue, 14 Jun 2022 12:00:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH-rcu] rcu-tasks: Use delayed_work to delay
 rcu_tasks_verify_self_tests()
Message-ID: <20220614190044.GW1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220614120620.1202389-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614120620.1202389-1-longman@redhat.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 08:06:20AM -0400, Waiman Long wrote:
> Commit 2585014188d5 ("rcu-tasks: Be more patient for RCU Tasks
> boot-time testing") fixes false positive rcu_tasks verification check
> failure by repeating the test once every second until timeout using
> schedule_timeout_uninterruptible().
> 
> Since rcu_tasks_verify_selft_tests() is called from do_initcalls()
> as a late_initcall, this has the undesirable side effect of perhaps
> delaying other late_initcall's queued after it by a second or more.
> Fix this by using delayed_work to repeat the verification check instead.
> 
> Fixes: 2585014188d5 ("rcu-tasks: Be more patient for RCU Tasks boot-time testing")
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/tasks.h | 35 ++++++++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index fcbd0ec33c86..e151cd5ae2bc 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1832,6 +1832,11 @@ static void rcu_tasks_initiate_self_tests(void)
>  #endif
>  }
>  
> +/*
> + * Return:  0 - test passed
> + *	    1 - test failed, but have not timed out yet
> + *	   -1 - test failed and timed out
> + */
>  static int rcu_tasks_verify_self_tests(void)
>  {
>  	int ret = 0;
> @@ -1847,16 +1852,40 @@ static int rcu_tasks_verify_self_tests(void)
>  				ret = -1;
>  				break;
>  			}
> -			schedule_timeout_uninterruptible(1);
> +			ret = 1;
> +			break;
>  		}
>  	}
>  
> -	if (ret)
> +	if (ret < 0)
>  		WARN_ON(1);
>  
>  	return ret;
>  }
> -late_initcall(rcu_tasks_verify_self_tests);
> +
> +/*
> + * Repeat the rcu_tasks_verify_self_tests() call once every second until the
> + * test passes or has timed out.
> + */
> +static struct delayed_work rcu_tasks_verify_work;
> +static void rcu_tasks_verify_work_fn(struct work_struct *work __maybe_unused)
> +{
> +	int ret = rcu_tasks_verify_self_tests();
> +
> +	if (ret <= 0)
> +		return;
> +
> +	/* Test fails but not timed out yet, reschedule another check */
> +	schedule_delayed_work(&rcu_tasks_verify_work, HZ);
> +}
> +
> +static int rcu_tasks_verify_schedule_work(void)
> +{
> +	INIT_DELAYED_WORK(&rcu_tasks_verify_work, rcu_tasks_verify_work_fn);
> +	rcu_tasks_verify_work_fn(NULL);
> +	return 0;
> +}
> +late_initcall(rcu_tasks_verify_schedule_work);
>  #else /* #ifdef CONFIG_PROVE_RCU */
>  static void rcu_tasks_initiate_self_tests(void) { }
>  #endif /* #else #ifdef CONFIG_PROVE_RCU */
> -- 
> 2.31.1
> 
