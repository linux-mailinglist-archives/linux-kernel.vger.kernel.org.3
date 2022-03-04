Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1A24CD3B5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 12:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbiCDLnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 06:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbiCDLna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 06:43:30 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F16F20182
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 03:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646394162; x=1677930162;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fdwF+4ZbfJpwUteRInoR5l0bTmtmYzrkW4ngetVz9rU=;
  b=NeIgTeDPcNy3R1a+SH35Z4n7hsgKPM9uL7mL+lqcT6TGiRU8sRY4gcTt
   hSv38/M2fZXXNae5aHQwX1eMU85wx7f5h5MKo5NthZuQvwHpjtjOCg2YH
   PxDA4eUmmrtHKpMtDLBDit+n1RETJUCCaeNTLxMcQnZDHa6e6n1N5b3t1
   8=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 04 Mar 2022 03:42:40 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 03:42:40 -0800
Received: from [10.216.42.173] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Fri, 4 Mar 2022
 03:42:39 -0800
Message-ID: <81f69dd4-6ca9-760c-bec5-5cb27afbe788@quicinc.com>
Date:   Fri, 4 Mar 2022 17:12:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] rcu: Only boost rcu reader tasks with lower priority than
 boost kthreads
Content-Language: en-US
To:     Zqiang <qiang1.zhang@intel.com>, <paulmck@kernel.org>,
        <frederic@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20220304092631.4123188-1-qiang1.zhang@intel.com>
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <20220304092631.4123188-1-qiang1.zhang@intel.com>
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



On 3/4/2022 2:56 PM, Zqiang wrote:
> When RCU_BOOST is enabled, the boost kthreads will boosting readers
> who are blocking a given grace period, if the current reader tasks
> have a higher priority than boost kthreads(the boost kthreads priority
> not always 1, if the kthread_prio is set), boosting is useless, skip
> current task and select next task to boosting, reduce the time for a
> given grace period.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>   kernel/rcu/tree_plugin.h | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index c3d212bc5338..d35b6da66bbd 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -12,6 +12,7 @@
>    */
>   
>   #include "../locking/rtmutex_common.h"
> +#include <linux/sched/deadline.h>
>   
>   static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
>   {
> @@ -1065,13 +1066,20 @@ static int rcu_boost(struct rcu_node *rnp)
>   	 * section.
>   	 */
>   	t = container_of(tb, struct task_struct, rcu_node_entry);
> +	if (!rnp->exp_tasks && (dl_task(t) || t->prio <= current->prio)) {
> +		tb = rcu_next_node_entry(t, rnp);
> +		WRITE_ONCE(rnp->boost_tasks, tb);
> +		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> +		goto end;
> +	}
> +
>   	rt_mutex_init_proxy_locked(&rnp->boost_mtx.rtmutex, t);
>   	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>   	/* Lock only for side effect: boosts task t's priority. */
>   	rt_mutex_lock(&rnp->boost_mtx);
>   	rt_mutex_unlock(&rnp->boost_mtx);  /* Then keep lockdep happy. */
>   	rnp->n_boosts++;
> -
> +end:

Nit: maybe rename the label to "skip_boost:" ?

Code looks fine; however, out of curiosity; given that the higher 
priority tasks, in general, would exit their read side critical section
quickly and boost the next blocking reader on exiting their read side 
section; do you see noticeable reduction in grace period timings with 
the change for certain type of workloads?


Thanks
Neeraj

>   	return READ_ONCE(rnp->exp_tasks) != NULL ||
>   	       READ_ONCE(rnp->boost_tasks) != NULL;
>   }
