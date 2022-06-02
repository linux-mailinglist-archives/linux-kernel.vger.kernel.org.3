Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F082F53C15E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 01:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239874AbiFBXno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 19:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiFBXnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 19:43:42 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4729137A0F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 16:43:41 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id x65so4859246qke.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 16:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z4Jq0139k9/g7p5Rp38NcBMTSv8eGbiFcR6280ziDuo=;
        b=ykdi+kzAxY6b/IVz0LFcak5rc5cZXGfw8YyiUfUer0qcSF1TGlykBqQRzcWrHdXFvJ
         XwCIs5EsMe0/QPtrr4qvdsiSIHpIK1bEjSGWNBw/vlCXxEtfEA+WQuw8C+d88gf/I6jb
         vHSEW7B/vz4/Rb96TJisSPaTFYNXxMEN55mAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z4Jq0139k9/g7p5Rp38NcBMTSv8eGbiFcR6280ziDuo=;
        b=DYWoovA4VyJW9CNjwoRX8E44KzX8xt9Au0nMQ+O7sZx3yKWHwCEo0zczvk5lMUUp1X
         SdvX3irsat1eosXQuP01k77JWdnpj4AioNkFylBwT51jy6C1M3T7C3aRkQmqTkHVbqn3
         6BxBO1yvCt3DSP4nFN7uSZafWHeh9uGIujKPz0QNP6HSaskIicJtX4jGiTCOa89BacqV
         tkdniYDQc7phigfgRi2o5j/E4ua7avLQborx06+ucElcSnT1ZPvHU/IvXWG5fBB0Zn6q
         ma1QmNHzHcPVyp1RtgicSE2eeYZm3COPGpm71noax3SkG89PDLCUwstl5AQKo4I+XJnm
         ERQg==
X-Gm-Message-State: AOAM532kpzengKuFSR54/GzIH2Ropt57daKVFL2RIw5F/wuoYDIu1wUo
        /Erby+wMZdAxiqPw+LoAcho92Q==
X-Google-Smtp-Source: ABdhPJwhzhJcP8Se89omJ8GC8+/+1J7uAwTvUgsv/iQLTTZs8KPybXDcfYTdOWpROS9ENgDpXQiclg==
X-Received: by 2002:a37:a944:0:b0:6a6:9bea:ed96 with SMTP id s65-20020a37a944000000b006a69beaed96mr354636qke.329.1654213420368;
        Thu, 02 Jun 2022 16:43:40 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id m9-20020a05622a118900b00304b65bac49sm3849651qtk.68.2022.06.02.16.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 16:43:39 -0700 (PDT)
Date:   Thu, 2 Jun 2022 23:43:39 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/2] rcu/kvfree: Remove useless monitor_todo flag
Message-ID: <YplLK2BcTn2oM0hr@google.com>
References: <20220602080644.432156-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602080644.432156-1-urezki@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 10:06:43AM +0200, Uladzislau Rezki (Sony) wrote:
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> 
> monitor_todo is not needed as the work struct already tracks
> if work is pending. Just use that to know if work is pending
> using schedule_delayed_work() helper.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 222d59299a2a..fd16c0b46d9e 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3295,7 +3295,6 @@ struct kfree_rcu_cpu_work {
>   * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
>   * @lock: Synchronize access to this structure
>   * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
> - * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
>   * @initialized: The @rcu_work fields have been initialized
>   * @count: Number of objects for which GP not started
>   * @bkvcache:
> @@ -3320,7 +3319,6 @@ struct kfree_rcu_cpu {
>  	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
>  	raw_spinlock_t lock;
>  	struct delayed_work monitor_work;
> -	bool monitor_todo;
>  	bool initialized;
>  	int count;
>  
> @@ -3500,6 +3498,18 @@ static void kfree_rcu_work(struct work_struct *work)
>  	}
>  }
>  
> +static bool
> +need_offload_krc(struct kfree_rcu_cpu *krcp)
> +{
> +	int i;
> +
> +	for (i = 0; i < FREE_N_CHANNELS; i++)
> +		if (krcp->bkvhead[i])
> +			return true;
> +
> +	return !!krcp->head;
> +}

Thanks for modifying my original patch to do this, and thanks for giving me
the attribution for the patch. This function is a nice addition.

For the patch in its entirety:
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel



> +
>  /*
>   * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
>   */
> @@ -3556,9 +3566,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
>  	// of the channels that is still busy we should rearm the
>  	// work to repeat an attempt. Because previous batches are
>  	// still in progress.
> -	if (!krcp->bkvhead[0] && !krcp->bkvhead[1] && !krcp->head)
> -		krcp->monitor_todo = false;
> -	else
> +	if (need_offload_krc(krcp))
>  		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
>  
>  	raw_spin_unlock_irqrestore(&krcp->lock, flags);
> @@ -3746,11 +3754,8 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  	WRITE_ONCE(krcp->count, krcp->count + 1);
>  
>  	// Set timer to drain after KFREE_DRAIN_JIFFIES.
> -	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
> -	    !krcp->monitor_todo) {
> -		krcp->monitor_todo = true;
> +	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
>  		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> -	}
>  
>  unlock_return:
>  	krc_this_cpu_unlock(krcp, flags);
> @@ -3825,14 +3830,8 @@ void __init kfree_rcu_scheduler_running(void)
>  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
>  
>  		raw_spin_lock_irqsave(&krcp->lock, flags);
> -		if ((!krcp->bkvhead[0] && !krcp->bkvhead[1] && !krcp->head) ||
> -				krcp->monitor_todo) {
> -			raw_spin_unlock_irqrestore(&krcp->lock, flags);
> -			continue;
> -		}
> -		krcp->monitor_todo = true;
> -		schedule_delayed_work_on(cpu, &krcp->monitor_work,
> -					 KFREE_DRAIN_JIFFIES);
> +		if (need_offload_krc(krcp))
> +			schedule_delayed_work_on(cpu, &krcp->monitor_work, KFREE_DRAIN_JIFFIES);
>  		raw_spin_unlock_irqrestore(&krcp->lock, flags);
>  	}
>  }
> -- 
> 2.30.2
> 
