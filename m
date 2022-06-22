Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DC45553D0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 20:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377441AbiFVSz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 14:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377412AbiFVSzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 14:55:04 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57E040E5F;
        Wed, 22 Jun 2022 11:54:34 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t25so29299023lfg.7;
        Wed, 22 Jun 2022 11:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4iTcaXk/tA+WMboZAw/5+ow8rxvumME0LIzym3Yc6HI=;
        b=dg3DvxL1zfeqKqkHs2XJQ4/0RziT3Uc/vHw5NiBfdatyveZYIbam9hjLjfn9h+0DTy
         9u8h9cnINtfuaYjJekp+OImkzFFheCq7brPJmPZ4oeWB+6xwlSQhXwd7IQup6V5IHceg
         FKOilHtPZ7Nco+n/LVKOnGwn9lNqPu37bPPftND/Rww7U2DlQVNWyK0CvJ7rvK02dU2q
         ig4ZggOtfgJPwdZYSrfnFQuD08s9DH5EN/82MmKBRqwpMNjoqhlWs65bZ8WTdwckUw1L
         pGJl6nvjYhUIZfVa/KF436UJ3FsaYc1uu5qNgmjfXD1SSAkbzOVeF/lg0bi+PmdOdx2f
         LXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4iTcaXk/tA+WMboZAw/5+ow8rxvumME0LIzym3Yc6HI=;
        b=To0a3rlrHANbTeVHPxa9B7KX7zAHhGFh7DY27PbRH9yBSIiTeaJytXqnDfRi5BlBf0
         bCncNe0PmZ4uEMy9A1u/+SNlU3hiXwbghg5fpx+w04map5Jg7gRFz3Olk5H1/hDop8vW
         UmMlwfSm+U8155wUrWLG6ajuAmsnbpnZtySdkRKcnpy9OLslKu6BdtL2qMvbKc/z0kLl
         OorrL2TOK1X4Fn58pbp0V0EkTw2fiOlLLAx1r1KnUgjwKBsHhU6k4nRmZUOVZvtgN0RO
         AAU91d7glNexFwBjWeqAuxwg3NKwpnDvKP90SHm1m1qAsjIi4g1kZ1EcEn9ha2onH1AT
         kdfQ==
X-Gm-Message-State: AJIora9bQd4POjEnjl2BW1SeJrAKLcBaJQojrhDf2fw8oJuOwCqE/83w
        E0QXn968/SZUAKy4BhXOLYo=
X-Google-Smtp-Source: AGRyM1upUm0OzGmQc3AYVM26yT3dHzDTq51feO4Wd7o3VMKCxmkZO+tbeA1ZnKboqUXSRa8KrrklzQ==
X-Received: by 2002:a05:6512:40b:b0:47f:8215:8bf9 with SMTP id u11-20020a056512040b00b0047f82158bf9mr2894785lfk.360.1655924072204;
        Wed, 22 Jun 2022 11:54:32 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id a15-20020a056512200f00b0047f8ec3ca4esm507499lfb.87.2022.06.22.11.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 11:54:25 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 22 Jun 2022 20:54:22 +0200
To:     Michal Hocko <mhocko@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [RFC PATCH] rcu: back off on allocation failure in
 fill_page_cache_func
Message-ID: <YrNlXkLfDpd+Ulxf@pc638.lan>
References: <20220622114711.28154-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622114711.28154-1-mhocko@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 01:47:11PM +0200, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> fill_page_cache_func allocates couple of pages to store
> kvfree_rcu_bulk_data. This is a lightweight (GFP_NORETRY) allocation
> which can fail under memory pressure. The function will, however keep
> retrying even when the previous attempt has failed.
> 
> While this is not really incorrect there is one thing to consider. This
> allocation is invoked from the WQ context and that means that if the
> memory reclaim gets stuck it can hog the worker for quite some time.
> WQ concurrency is only triggered when the worker context sleeps and that
> is not guaranteed for __GFP_NORETRY allocation attempts (see
> should_reclaim_retry).
> 
> We have seen WQ lockups
> kernel: BUG: workqueue lockup - pool cpus=93 node=1 flags=0x1 nice=0 stuck for 32s!
> [...]
> kernel: pool 74: cpus=37 node=0 flags=0x1 nice=0 hung=32s workers=2 manager: 2146
> kernel:   pwq 498: cpus=249 node=1 flags=0x1 nice=0 active=4/256 refcnt=5
> kernel:     in-flight: 1917:fill_page_cache_func
> kernel:     pending: dbs_work_handler, free_work, kfree_rcu_monitor
> 
> Originaly, we thought that several retries with direct reclaim being
> stuck is the underlying reason but we couldn't have confirmed that and
> have seen a similar lockups detected even without any heavy memory
> pressure so there is likely something else/more going on. On the other
> hand failing the allocation shouldn't have a big impact and from the
> code it is not really obvious why retrying is desirable so back off
> after the allocation failure.
> 
> Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
> 
> Hi,
> I am sending this as an RFC because I couldn't prove that the WQ
> concurency issue as a result from the allocation retry is really a
> problem. On the other hand I couldn't see a good reason to retry after a
> previous failure. While the kswapd running in the background could have
> released some memory this is a not really guaranteed and mostly a
> wishful thinking.
> 
> I do not understand the code well enough so I could be easily missing
> something. If the patch is a wrong thing to do then it would be really
> nice to add a comment why the retry is desirable and a good thing to do.
> 
> The retry loop should be bound to rcu_min_cached_objs which is quite
> small but configurable so this can get large in some setups.
> 
> Thanks
> 
>  kernel/rcu/tree.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index c25ba442044a..54a3a19c4c0b 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3508,15 +3508,16 @@ static void fill_page_cache_func(struct work_struct *work)
>  		bnode = (struct kvfree_rcu_bulk_data *)
>  			__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
>  
> -		if (bnode) {
> -			raw_spin_lock_irqsave(&krcp->lock, flags);
> -			pushed = put_cached_bnode(krcp, bnode);
> -			raw_spin_unlock_irqrestore(&krcp->lock, flags);
> +		if (!bnode)
> +			break;
>  
> -			if (!pushed) {
> -				free_page((unsigned long) bnode);
> -				break;
> -			}
> +		raw_spin_lock_irqsave(&krcp->lock, flags);
> +		pushed = put_cached_bnode(krcp, bnode);
> +		raw_spin_unlock_irqrestore(&krcp->lock, flags);
> +
> +		if (!pushed) {
> +			free_page((unsigned long) bnode);
> +			break;
>  		}
>  	}
>  
> -- 
> 2.30.2
>
OK. You would like to break the loop once an allocation does not succeed.
To me it also makes sense, i mean there is no reason to repeat it several
times that can lead to worqueue hogging.

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Thanks!

--
Uladzislau Rezki
