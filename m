Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1D557966E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236592AbiGSJgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235000AbiGSJgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:36:09 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFF3BE16;
        Tue, 19 Jul 2022 02:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658223368; x=1689759368;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=isqZTqhhIU8xKBjOt0MRL/9I6sVoIUSHTkqWJC4NPc8=;
  b=oeOVOtqcEuwsCUfvqDoNMYITlPROr8+muPMUBvhaYqvuvZFVLWeSdNvx
   Y1upC9JJXFjmxlr9D2BkNAK06hqTbyQCEoDEoVpC08caqhjVkcHtb+pdb
   4KJS3nypINZSyVzKwhLO2BAC2Alcz7j7Kzk6htAWxE2dbhZNNUTJ84Ka5
   4=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 19 Jul 2022 02:36:08 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 02:36:08 -0700
Received: from [10.50.41.193] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 19 Jul
 2022 02:36:05 -0700
Message-ID: <6b42fe1f-3ef9-08af-440f-8d85b5d6e967@quicinc.com>
Date:   Tue, 19 Jul 2022 15:06:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH rcu 7/7] rcu/nocb: Avoid polling when
 my_rdp->nocb_head_rdp list is empty
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>, <rcu@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <rostedt@goodmis.org>, Zqiang <qiang1.zhang@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>
References: <20220620224455.GA3840881@paulmck-ThinkPad-P17-Gen-1>
 <20220620224503.3841196-7-paulmck@kernel.org>
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <20220620224503.3841196-7-paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/21/2022 4:15 AM, Paul E. McKenney wrote:
> From: Zqiang <qiang1.zhang@intel.com>
> 
> Currently, if the 'rcu_nocb_poll' kernel boot parameter is enabled, all
> rcuog kthreads enter polling mode.  However, if all of a given group
> of rcuo kthreads correspond to CPUs that have been de-offloaded, the
> corresponding rcuog kthread will nonetheless still wake up periodically,
> unnecessarily consuming power and perturbing workloads.  Fortunately,
> this situation is easily detected by the fact that the rcuog kthread's
> CPU's rcu_data structure's ->nocb_head_rdp list is empty.
> 
> This commit saves power and avoids unnecessarily perturbing workloads
> by putting an rcuog kthread to sleep during any time period when all of
> its rcuo kthreads' CPUs are de-offloaded.
> 
> Co-developed-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---


Reviewed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>


Thanks
Neeraj

>   kernel/rcu/tree_nocb.h | 24 +++++++++++++++++++-----
>   1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index fa8e4f82e60c0..a8f574d8850d2 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -584,6 +584,14 @@ static int nocb_gp_toggle_rdp(struct rcu_data *rdp,
>   	return ret;
>   }
>   
> +static void nocb_gp_sleep(struct rcu_data *my_rdp, int cpu)
> +{
> +	trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Sleep"));
> +	swait_event_interruptible_exclusive(my_rdp->nocb_gp_wq,
> +					!READ_ONCE(my_rdp->nocb_gp_sleep));
> +	trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("EndSleep"));
> +}
> +
>   /*
>    * No-CBs GP kthreads come here to wait for additional callbacks to show up
>    * or for grace periods to end.
> @@ -701,13 +709,19 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>   		/* Polling, so trace if first poll in the series. */
>   		if (gotcbs)
>   			trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Poll"));
> -		schedule_timeout_idle(1);
> +		if (list_empty(&my_rdp->nocb_head_rdp)) {
> +			raw_spin_lock_irqsave(&my_rdp->nocb_gp_lock, flags);
> +			if (!my_rdp->nocb_toggling_rdp)
> +				WRITE_ONCE(my_rdp->nocb_gp_sleep, true);
> +			raw_spin_unlock_irqrestore(&my_rdp->nocb_gp_lock, flags);
> +			/* Wait for any offloading rdp */
> +			nocb_gp_sleep(my_rdp, cpu);
> +		} else {
> +			schedule_timeout_idle(1);
> +		}
>   	} else if (!needwait_gp) {
>   		/* Wait for callbacks to appear. */
> -		trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Sleep"));
> -		swait_event_interruptible_exclusive(my_rdp->nocb_gp_wq,
> -				!READ_ONCE(my_rdp->nocb_gp_sleep));
> -		trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("EndSleep"));
> +		nocb_gp_sleep(my_rdp, cpu);
>   	} else {
>   		rnp = my_rdp->mynode;
>   		trace_rcu_this_gp(rnp, my_rdp, wait_gp_seq, TPS("StartWait"));
