Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02149552AB0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 08:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345518AbiFUGAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 02:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345509AbiFUGAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 02:00:45 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB4F22290;
        Mon, 20 Jun 2022 23:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655791245; x=1687327245;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aZpK0M6SHXLLGZP0lunOQ+0S8bc7+yt9mRIFzLutF/U=;
  b=oie9d63vhD0kEWXAajFg+Xoxd7/C43WtR9mUm8Ww6gsb42iW/5tAEAVI
   JZOOM2EnqIRt4KMcbO6eZW0nFGl35uOy7Mm38cjTQ2L09a3TJCeQmTNkS
   WG42OBozwDUmK8AlkKYDs+IPQVxnaovtj/DGyi1/k0F2/geyZMzQUoXQT
   k=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 20 Jun 2022 23:00:44 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 23:00:45 -0700
Received: from [10.50.44.13] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 20 Jun
 2022 23:00:42 -0700
Message-ID: <789b9966-f899-3882-768d-e996e43ec6da@quicinc.com>
Date:   Tue, 21 Jun 2022 11:30:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH rcu 04/12] rcu: Immediately boost preempted readers for
 strict grace periods
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>, <rcu@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <rostedt@goodmis.org>, Zqiang <qiang1.zhang@intel.com>
References: <20220620222022.GA3839466@paulmck-ThinkPad-P17-Gen-1>
 <20220620222032.3839547-4-paulmck@kernel.org>
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <20220620222032.3839547-4-paulmck@kernel.org>
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



On 6/21/2022 3:50 AM, Paul E. McKenney wrote:
> From: Zqiang <qiang1.zhang@intel.com>
> 
> The intent of the CONFIG_RCU_STRICT_GRACE_PERIOD Konfig option is to
> cause normal grace periods to complete quickly in order to better catch
> errors resulting from improperly leaking pointers from RCU read-side
> critical sections.  However, kernels built with this option enabled still
> wait for some hundreds of milliseconds before boosting RCU readers that
> have been preempted within their current critical section.  The value
> of this delay is set by the CONFIG_RCU_BOOST_DELAY Kconfig option,
> which defaults to 500 milliseconds.
> 
> This commit therefore causes kernels build with strict grace periods
> to ignore CONFIG_RCU_BOOST_DELAY.  This causes rcu_initiate_boost()
> to start boosting immediately after all CPUs on a given leaf rcu_node
> structure have passed through their quiescent states.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---

Reviewed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>


Thanks
Neeraj

>   kernel/rcu/tree_plugin.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 440d9e02a26e0..53d05eb804121 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -1140,7 +1140,8 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
>   	    (rnp->gp_tasks != NULL &&
>   	     rnp->boost_tasks == NULL &&
>   	     rnp->qsmask == 0 &&
> -	     (!time_after(rnp->boost_time, jiffies) || rcu_state.cbovld))) {
> +	     (!time_after(rnp->boost_time, jiffies) || rcu_state.cbovld ||
> +	      IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD)))) {
>   		if (rnp->exp_tasks == NULL)
>   			WRITE_ONCE(rnp->boost_tasks, rnp->gp_tasks);
>   		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
