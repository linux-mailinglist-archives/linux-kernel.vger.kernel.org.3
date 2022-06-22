Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847135549FB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbiFVM00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 08:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbiFVM0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 08:26:22 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C2433E22;
        Wed, 22 Jun 2022 05:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655900781; x=1687436781;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lj/u6NuRP9vI0Ref/oZDBYiPFO3FiosjbPF5RhAHuLg=;
  b=n98OVpYFlv/4HLki+NO7qp9pODBur2ILvrcUixflr3+DGdmQwwSJXRPe
   HdPeWdpbOhBzbGc9x05gc1YwTH9m4F2+c7TW3zV0YOqNfk4HxeZ25SiI4
   ZUslNLHL8HzKKJC2vNLJT1rOfdoqS7pKT5IuWTsYSuiGoQ3gsovN/5mo1
   k=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 Jun 2022 05:26:21 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 05:26:21 -0700
Received: from [10.50.44.13] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 22 Jun
 2022 05:26:18 -0700
Message-ID: <de5bac34-7369-4764-bb56-86d3f8de32fa@quicinc.com>
Date:   Wed, 22 Jun 2022 17:56:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] rcu: Add exp QS check in rcu_exp_handler() for
 no-preemptible expedited RCU
Content-Language: en-US
To:     Zqiang <qiang1.zhang@intel.com>, <paulmck@kernel.org>,
        <frederic@kernel.org>
CC:     <rcu@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220622103549.2840087-1-qiang1.zhang@intel.com>
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <20220622103549.2840087-1-qiang1.zhang@intel.com>
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



On 6/22/2022 4:05 PM, Zqiang wrote:
> In CONFIG_PREEMPT=n and CONFIG_PREEMPT_COUNT=y kernel, after a exp
> grace period begins, if detected current CPU enters idle in
> rcu_exp_handler() IPI handler, will immediately report the exp QS of the
> current cpu, at this time, maybe not being in an RCU read-side critical
> section, but need wait until rcu-softirq or sched-clock irq or sched-switch
> occurs on current CPU to check and report exp QS.
> 
> This commit add a exp QS check in rcu_exp_handler(), when not being
> in an RCU read-side critical section, report exp QS earlier.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---

I am a bit unsure on this change. For non-preempt kernel, technically 
(and by design) context switch points are considered RCU read side 
critical section end? This change, changes that behavior  between 
CONFIG_PREEMPT_COUNT=y and CONFIG_PREEMPT_COUNT=n case, for 
non-preemptive  kernels.

However, I could be missing something here, and would wait for Paul's 
review.



Thanks
Neeraj


>   kernel/rcu/tree_exp.h | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index be667583a554..34f08267410f 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -828,11 +828,14 @@ static void rcu_exp_handler(void *unused)
>   {
>   	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>   	struct rcu_node *rnp = rdp->mynode;
> +	bool preempt_bh_disabled =
> +				!!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK));
>   
>   	if (!(READ_ONCE(rnp->expmask) & rdp->grpmask) ||
>   	    __this_cpu_read(rcu_data.cpu_no_qs.b.exp))
>   		return;
> -	if (rcu_is_cpu_rrupt_from_idle()) {
> +	if (rcu_is_cpu_rrupt_from_idle() ||
> +			(IS_ENABLED(CONFIG_PREEMPT_COUNT) && !preempt_bh_disabled)) {


>   		rcu_report_exp_rdp(this_cpu_ptr(&rcu_data));
>   		return;
>   	}
