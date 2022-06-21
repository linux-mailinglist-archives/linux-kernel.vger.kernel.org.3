Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2638552B6E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346561AbiFUHDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346490AbiFUHDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:03:19 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A156C64DC;
        Tue, 21 Jun 2022 00:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655794998; x=1687330998;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Jukm3d+VxnW0QHCLY6N8dPRZFsIaWVH93a5NTyWgsdg=;
  b=GqFYnr/beDz1kWNMYZmmLb+QSSHivMsqh8QrBWSHRbnnmR66aRXOYYy9
   RU6ZJGb3xU9RA129AFmiuk08m9HGtq9YVqyGdwzuTv+u09W341gXeoXsW
   IXlC0myjdFXG3Lpd3PTi8kp3PzlOFd43/fUtMgHQbU1reohFphRxGjw6L
   c=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 21 Jun 2022 00:03:18 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 00:03:18 -0700
Received: from [10.50.44.13] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 21 Jun
 2022 00:03:15 -0700
Message-ID: <5fa27044-9515-f8fa-511c-64014479e875@quicinc.com>
Date:   Tue, 21 Jun 2022 12:33:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH rcu 08/12] rcu: Cleanup RCU urgency state for offline CPU
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>, <rcu@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <rostedt@goodmis.org>, Zqiang <qiang1.zhang@intel.com>
References: <20220620222022.GA3839466@paulmck-ThinkPad-P17-Gen-1>
 <20220620222032.3839547-8-paulmck@kernel.org>
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <20220620222032.3839547-8-paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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
> When a CPU is slow to provide a quiescent state for a given grace
> period, RCU takes steps to encourage that CPU to get with the
> quiescent-state program in a more timely fashion.  These steps
> include these flags in the rcu_data structure:
> 
> 1.	->rcu_urgent_qs, which causes the scheduling-clock interrupt to
> 	request an otherwise pointless context switch from the scheduler.
> 
> 2.	->rcu_need_heavy_qs, which causes both cond_resched() and RCU's
> 	context-switch hook to do an immediate momentary quiscent state.
> 
> 3.	->rcu_need_heavy_qs, which causes the scheduler-clock tick to

nit: s/->rcu_need_heavy_qs/->rcu_forced_tick/ ?

> 	be enabled even on nohz_full CPUs with only one runnable task.
> 
> These flags are of course cleared once the corresponding CPU has passed
> through a quiescent state.  Unless that quiescent state is the CPU
> going offline, which means that when the CPU comes back online, it will
> needlessly consume additional CPU time and incur additional latency,
> which constitutes a minor but very real performance bug.
> 
> This commit therefore adds the call to rcu_disable_urgency_upon_qs()
> that clears these flags to the CPU-hotplug offlining code path.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---


Reviewed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>




Thanks
Neeraj

>   kernel/rcu/tree.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index f4a37f2032664..5445b19b48408 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4446,6 +4446,7 @@ void rcu_report_dead(unsigned int cpu)
>   	rdp->rcu_ofl_gp_flags = READ_ONCE(rcu_state.gp_flags);
>   	if (rnp->qsmask & mask) { /* RCU waiting on outgoing CPU? */
>   		/* Report quiescent state -before- changing ->qsmaskinitnext! */
> +		rcu_disable_urgency_upon_qs(rdp);
>   		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
>   		raw_spin_lock_irqsave_rcu_node(rnp, flags);
>   	}
