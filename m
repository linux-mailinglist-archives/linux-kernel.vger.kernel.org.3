Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CF7524311
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 05:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245041AbiELDL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 23:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244914AbiELDLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 23:11:25 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C8A44778
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 20:11:23 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id w3so3757737qkb.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 20:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P6ehWJEf13dXCWUNyAtXTt5LMjnwf2ZoDqpLgP+X6e4=;
        b=Su0kjM/z3pCEIvgPJ1yTDaW81Acmj8ikFdlOhVqLcxTUxbs9CEwA6V+H9ywe8LWP+o
         BsjEcgf1XAqrT+9AieoVdDEUTFg3SOi5rkcsQ9RCcPwgfPwysmKYRssm5QaxMy6rDssH
         Gij1oZiCIjjinen3ubNdpDunbwjHgoVr61Geo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P6ehWJEf13dXCWUNyAtXTt5LMjnwf2ZoDqpLgP+X6e4=;
        b=aIFksTqiII2NKv8Xx+PpH8GWLoFDtIq5Fn51nWccTBYqMLDJXyoC9IwqhsveSBYxa2
         q3I3JT0aUrg+IkIIlfsEZz8uL3QNKFIv1VX91MxN9beyixW4f8/0TBvUnIW1mwBfIwBk
         qM+eKIWQh0TAwfTcV9lQtcujymbuxjpf1IyxrPxnJWjB5iR5n7EWeOYSHhPKzCS/gzED
         qhfsWKWStV7d+OUA4AKyxOCTOLP/wd0mRappXDr7zYF0Tdu2icR5167vVeBkDt7/xhp0
         Tnr+wGPfI/DKa9PHDf/vKhSbOcERY1bPdyL0AT+RGJw1wT2xuPs6NZcH529+40bMUoE7
         U3+g==
X-Gm-Message-State: AOAM531VDhmzDcg9bP9fI6Oh0uW1B7hUVwGAvEPZl2itDNcFXOwPofqF
        mjhe36cqnyZy/A9d+sE/TNEMDg==
X-Google-Smtp-Source: ABdhPJxmHpG/bjAR0HyxytSmkrshNsBhASem7wvGF1c2opYlwZP1VKB4EDn9W/RpylGyolb4iUW2ow==
X-Received: by 2002:a05:620a:25d2:b0:699:bd31:aafb with SMTP id y18-20020a05620a25d200b00699bd31aafbmr21418202qko.531.1652325080115;
        Wed, 11 May 2022 20:11:20 -0700 (PDT)
Received: from localhost (29.46.245.35.bc.googleusercontent.com. [35.245.46.29])
        by smtp.gmail.com with ESMTPSA id 10-20020a05620a078a00b0069fc167df92sm2231355qka.82.2022.05.11.20.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 20:11:19 -0700 (PDT)
Date:   Thu, 12 May 2022 03:11:19 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 1/1] rcu/nocb: Add an option to ON/OFF an offloading
 from RT context
Message-ID: <Ynx61yH8RFkaXG6M@google.com>
References: <20220511085703.101596-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511085703.101596-1-urezki@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 10:57:03AM +0200, Uladzislau Rezki (Sony) wrote:
> Introduce a RCU_NOCB_CPU_CB_BOOST kernel option. So a user can
> decide if an offloading has to be done in a high-prio context or
> not. Please note an option depends on RCU_NOCB_CPU and RCU_BOOST
> parameters. For CONFIG_PREEMPT_RT kernel both RCU_BOOST and the
> RCU_NOCB_CPU_CB_BOOST are active by default.
> 
> This patch splits the CONFIG_RCU_BOOST config into two peaces:
> a) boosting preempted RCU readers and the kthreads which are
>    directly responsible for driving expedited grace periods
>    forward;
> b) boosting offloading-kthreads in a way that their scheduling
>    class are changed from SCHED_NORMAL to SCHED_FIFO.
> 
> The main reason of such split is, for example on Android there
> are some workloads which require fast expedited grace period to
> be done whereas offloading in RT context can lead to starvation
> and hogging a CPU for a long time what is not acceptable for
> latency sensitive environment. For instance:
> 
> <snip>
> <...>-60 [006] d..1 2979.028717: rcu_batch_start: rcu_preempt CBs=34619 bl=270
> <snip>
> 
> invoking 34 619 callbacks will take time thus making other CFS
> tasks waiting in run-queue to be starved due to such behaviour.
> 
> v1 -> v2:
> - fix the comment about the rcuc/rcub/rcuop;
> - check the kthread_prio against zero value;
> - by default the RCU_NOCB_CPU_CB_BOOST is ON for PREEMPT_RT.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> ---
>  kernel/rcu/Kconfig     | 14 ++++++++++++++
>  kernel/rcu/tree.c      |  6 +++++-
>  kernel/rcu/tree_nocb.h |  3 ++-
>  3 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index 27aab870ae4c..a4ed7b5e2b75 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -275,6 +275,20 @@ config RCU_NOCB_CPU_DEFAULT_ALL
>  	  Say Y here if you want offload all CPUs by default on boot.
>  	  Say N here if you are unsure.
>  
> +config RCU_NOCB_CPU_CB_BOOST
> +	bool "Offload RCU callback from real-time kthread"
> +	depends on RCU_NOCB_CPU && RCU_BOOST
> +	default y if PREEMPT_RT
> +	help
> +	  Use this option to offload callbacks from the SCHED_FIFO context
> +	  to make the process faster. As a side effect of this approach is
> +	  a latency especially for the SCHED_OTHER tasks which will not be
> +	  able to preempt an offloading kthread. That latency depends on a
> +	  number of callbacks to be invoked.
> +
> +	  Say Y here if you want to set RT priority for offloading kthreads.
> +	  Say N here if you are unsure.
> +
>  config TASKS_TRACE_RCU_READ_MB
>  	bool "Tasks Trace RCU readers use memory barriers in user and idle"
>  	depends on RCU_EXPERT && TASKS_TRACE_RCU
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 9dc4c4e82db6..1c3852b1e0c8 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -154,7 +154,11 @@ static void sync_sched_exp_online_cleanup(int cpu);
>  static void check_cb_ovld_locked(struct rcu_data *rdp, struct rcu_node *rnp);
>  static bool rcu_rdp_is_offloaded(struct rcu_data *rdp);
>  
> -/* rcuc/rcub/rcuop kthread realtime priority */
> +/*
> + * rcuc/rcub/rcuop kthread realtime priority. The "rcuop"
> + * real-time priority(enabling/disabling) is controlled by
> + * the extra CONFIG_RCU_NOCB_CPU_CB_BOOST configuration.
> + */
>  static int kthread_prio = IS_ENABLED(CONFIG_RCU_BOOST) ? 1 : 0;
>  module_param(kthread_prio, int, 0444);
>  
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 60cc92cc6655..fa8e4f82e60c 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1315,8 +1315,9 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
>  	if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo CB kthread, OOM is now expected behavior\n", __func__))
>  		goto end;
>  
> -	if (kthread_prio)
> +	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU_CB_BOOST) && kthread_prio)
>  		sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
> +
>  	WRITE_ONCE(rdp->nocb_cb_kthread, t);
>  	WRITE_ONCE(rdp->nocb_gp_kthread, rdp_gp->nocb_gp_kthread);
>  	return;
> -- 
> 2.30.2
> 
