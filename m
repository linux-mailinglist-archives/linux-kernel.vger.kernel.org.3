Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56593545A5B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 05:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241561AbiFJDPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 23:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiFJDPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 23:15:52 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05D630AB5B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 20:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654830950; x=1686366950;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7u6CIQ0SNKQUIgLRA7D5YyZL88ZOsYreBbiZf2aS7cU=;
  b=dlX6sbyMKjmRKMvbZl1p5s9gf19pM+/4PqrxqajAojP0jNh9PwCipDAl
   862sjqDKgeANTLEjU49wjSRIdLFBfIK0N7CmUMutPji2PK8bnvGkeItxi
   Rt4Nhuji5P7wKc9SRoC7OQQ8WZf/SpgeDzCwci3sPB9Mm4ModJlGGDq7O
   g=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 09 Jun 2022 20:15:49 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 20:15:49 -0700
Received: from [10.50.53.139] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 9 Jun 2022
 20:15:45 -0700
Message-ID: <2768ac0a-6f39-e6ba-cb57-33cb3b39de2a@quicinc.com>
Date:   Fri, 10 Jun 2022 08:45:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] rcu/tree: Add comment to describe GP done condition in
 fqs loop
Content-Language: en-US
To:     <paulmck@kernel.org>
CC:     <frederic@kernel.org>, <josh@joshtriplett.org>,
        <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
        <jiangshanlai@gmail.com>, <joel@joelfernandes.org>,
        <linux-kernel@vger.kernel.org>, <boqun.feng@gmail.com>,
        <urezki@gmail.com>
References: <20220609071340.30375-1-quic_neeraju@quicinc.com>
 <20220609202312.GW1790663@paulmck-ThinkPad-P17-Gen-1>
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <20220609202312.GW1790663@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/10/2022 1:53 AM, Paul E. McKenney wrote:
> On Thu, Jun 09, 2022 at 12:43:40PM +0530, Neeraj Upadhyay wrote:
>> Add a comment to explain why !rcu_preempt_blocked_readers_cgp() condition
>> is required on root rnp node, for GP completion check in rcu_gp_fqs_loop().
>>
>> Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> 
> Thank you, Neeraj!  As usual, I could not resist the urge to wordsmith
> as shown below.  Could you please check to see if I messed something up?

Thanks!
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit bdf3a744d3ad21336a390bfcc2e41de63f193eaf
> Author: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Date:   Thu Jun 9 12:43:40 2022 +0530
> 
>      rcu/tree: Add comment to describe GP-done condition in fqs loop
>      
>      Add a comment to explain why !rcu_preempt_blocked_readers_cgp() condition
>      is required on root rnp node, for GP completion check in rcu_gp_fqs_loop().
>      
>      Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
>      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index a93c5f4d7e092..9a941e7ee6109 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2083,7 +2083,15 @@ static noinline_for_stack void rcu_gp_fqs_loop(void)
>   		rcu_gp_torture_wait();
>   		WRITE_ONCE(rcu_state.gp_state, RCU_GP_DOING_FQS);
>   		/* Locking provides needed memory barriers. */
> -		/* If grace period done, leave loop. */
> +		/*
> +		 * Exit the loop if the root rcu_node structure indicates that the grace period
> +		 * has ended, leave the loop.  The rcu_preempt_blocked_readers_cgp(rnp) check

We can remove ", leave the loop" ?

> +		 * is required only for single-node rcu_node trees because readers blocking
> +		 * the current grace period are queued only on leaf rcu_node structures.
> +		 * For multi-node trees, checking the root node's ->qsmask suffices, because a
> +		 * given root node's ->qsmask bit is cleared only when all CPUs and tasks from

Do we need to say "a given root node's" , we have only single RCU node 
in the system, so we can just say, "because root node's ->qsmask bit is 
cleared..." ?

> +		 * the corresponding leaf node have passed through their quiescent state.

Change "the corresponding leaf node" to "their corresponding leaf nodes" 
or "the corresponding leaf nodes"?


Thanks
Neeraj

> +		 */
>   		if (!READ_ONCE(rnp->qsmask) &&
>   		    !rcu_preempt_blocked_readers_cgp(rnp))
>   			break;
