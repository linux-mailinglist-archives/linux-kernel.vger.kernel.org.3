Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C734DC31E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 10:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbiCQJnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 05:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiCQJnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 05:43:39 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED41B1D78AF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 02:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647510143; x=1679046143;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GNU29MztPMdk+ErJhCqukOOmoNwLoHRaw4Tf9nat+yE=;
  b=fxVGgj3b48m6FA3ddFF8TQN4XVMloVrJwoV35sJ5igWjTUULp2R5QHka
   uIv91J+orDf6GARZTPNcyWerrhL/CqUFLYaHwkYnUTLLxOWwhLOToBvGO
   ONNvZV8T9PSR3OvICyPOShQeU4dE1czniFFvXCQMeUF8FKu4LwiLL1N2M
   U=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 17 Mar 2022 02:42:23 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 02:42:23 -0700
Received: from [10.216.23.197] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 17 Mar
 2022 02:42:20 -0700
Message-ID: <c0845c3d-fe96-857a-df72-c5d1e35f8e7f@quicinc.com>
Date:   Thu, 17 Mar 2022 15:12:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 4/4] rcu: Name internal polling flag
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
References: <20220316144255.336021-1-frederic@kernel.org>
 <20220316144255.336021-5-frederic@kernel.org>
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <20220316144255.336021-5-frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/16/2022 8:12 PM, Frederic Weisbecker wrote:
> Give a proper self-explanatory name to the expedited grace period
> internal polling flag.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> ---
>   kernel/rcu/rcu.h      | 5 +++++
>   kernel/rcu/tree.c     | 2 +-
>   kernel/rcu/tree_exp.h | 9 +++++----
>   3 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index eccbdbdaa02e..8a62bb416ba4 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -30,6 +30,11 @@
>   #define RCU_GET_STATE_USE_NORMAL	0x2
>   #define RCU_GET_STATE_BAD_FOR_NORMAL	(RCU_GET_STATE_FROM_EXPEDITED | RCU_GET_STATE_USE_NORMAL)
>   
> +/*
> + * Low-order bit definitions for polled grace-period internals.
> + */
> +#define RCU_EXP_SEQ_POLL_DONE 0x1

 From what I understood, this flag is intended for lifecycle management
of the ->exp_seq_poll_rq; with the flag set meaning that we need to 
re-poll, which could be used for cases, where there is long gap between 
2 polls, such that the sequence wraps around. So, maybe we can name it 
as RCU_EXP_SEQ_POLL_EXPIRED? However, my understanding could be wrong here.


Thanks
Neeraj

> +
>   /*
>    * Return the counter portion of a sequence number previously returned
>    * by rcu_seq_snap() or rcu_seq_current().
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 5da381a3cbe5..b3223b365f9f 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4679,7 +4679,7 @@ static void __init rcu_init_one(void)
>   			spin_lock_init(&rnp->exp_lock);
>   			mutex_init(&rnp->boost_kthread_mutex);
>   			raw_spin_lock_init(&rnp->exp_poll_lock);
> -			rnp->exp_seq_poll_rq = 0x1;
> +			rnp->exp_seq_poll_rq = RCU_EXP_SEQ_POLL_DONE;
>   			INIT_WORK(&rnp->exp_poll_wq, sync_rcu_do_polled_gp);
>   		}
>   	}
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index c4a19c6a83cf..7ccb909d6355 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -910,14 +910,14 @@ static void sync_rcu_do_polled_gp(struct work_struct *wp)
>   	unsigned long s;
>   
>   	s = READ_ONCE(rnp->exp_seq_poll_rq);
> -	if (s & 0x1)
> +	if (s & RCU_EXP_SEQ_POLL_DONE)
>   		return;
>   	while (!sync_exp_work_done(s))
>   		__synchronize_rcu_expedited(true);
>   	raw_spin_lock_irqsave(&rnp->exp_poll_lock, flags);
>   	s = rnp->exp_seq_poll_rq;
> -	if (!(s & 0x1) && sync_exp_work_done(s))
> -		WRITE_ONCE(rnp->exp_seq_poll_rq, s | 0x1);
> +	if (!(s & RCU_EXP_SEQ_POLL_DONE) && sync_exp_work_done(s))
> +		WRITE_ONCE(rnp->exp_seq_poll_rq, s | RCU_EXP_SEQ_POLL_DONE);
>   	raw_spin_unlock_irqrestore(&rnp->exp_poll_lock, flags);
>   }
>   
> @@ -946,7 +946,8 @@ unsigned long start_poll_synchronize_rcu_expedited(void)
>   	rnp = rdp->mynode;
>   	if (rcu_init_invoked())
>   		raw_spin_lock_irqsave(&rnp->exp_poll_lock, flags);
> -	if ((rnp->exp_seq_poll_rq & 0x1) || ULONG_CMP_LT(rnp->exp_seq_poll_rq, s)) {
> +	if ((rnp->exp_seq_poll_rq & RCU_EXP_SEQ_POLL_DONE) ||
> +	    ULONG_CMP_LT(rnp->exp_seq_poll_rq, s)) {
>   		WRITE_ONCE(rnp->exp_seq_poll_rq, s);
>   		if (rcu_init_invoked())
>   			queue_work(rcu_gp_wq, &rnp->exp_poll_wq);
