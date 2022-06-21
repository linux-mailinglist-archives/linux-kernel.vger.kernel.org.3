Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB355552AA7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 07:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344309AbiFUF5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 01:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiFUF5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 01:57:35 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CD021E32;
        Mon, 20 Jun 2022 22:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655791054; x=1687327054;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1Mu9pvcG02On+wryY80J4mTvEJBOVi53rQeanbzZapA=;
  b=T40St4OJvv+/BXeuhFAkYTfmlfZALZnaDMejGpyGio7K4xwFsiNOupAy
   Nz+tCOZiypIHQN80D+aEYnpsq9YDb0dc6wSfQF5FLBQi/+tMirzEf9zC4
   AT/LIsr8Dv9Ktmjajhsicr+P9jPNEDXOyMwu4IM+wf7RSH6+qTC279YVV
   c=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Jun 2022 22:57:33 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 22:57:33 -0700
Received: from [10.50.44.13] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 20 Jun
 2022 22:57:31 -0700
Message-ID: <0b503f77-1269-7fef-7c70-0e572f7e5907@quicinc.com>
Date:   Tue, 21 Jun 2022 11:27:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH rcu 03/12] rcu: Add rnp->cbovldmask check in
 rcutree_migrate_callbacks()
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>, <rcu@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <rostedt@goodmis.org>, Zqiang <qiang1.zhang@intel.com>
References: <20220620222022.GA3839466@paulmck-ThinkPad-P17-Gen-1>
 <20220620222032.3839547-3-paulmck@kernel.org>
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <20220620222032.3839547-3-paulmck@kernel.org>
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
> Currently, the rcu_node structure's ->cbovlmask field is set in call_rcu()
> when a given CPU is suffering from callback overload.  But if that CPU
> goes offline, the outgoing CPU's callbacks is migrated to the running
> CPU, which is likely to overload the running CPU.  However, that CPU's
> bit in its leaf rcu_node structure's ->cbovlmask field remains zero.
> 
> Initially, this is OK because the outgoing CPU's bit remains set.
> However, that bit will be cleared at the next end of a grace period,
> at which time it is quite possible that the running CPU will still
> be overloaded.  If the running CPU invokes call_rcu(), then overload
> will be checked for and the bit will be set.  Except that there is no
> guarantee that the running CPU will invoke call_rcu(), in which case the
> next grace period will fail to take the running CPU's overload condition
> into account.  Plus, because the bit is not set, the end of the grace
> period won't check for overload on this CPU.
> 
> This commit therefore adds a call to check_cb_ovld_locked() in
> check_cb_ovld_locked() to set the running CPU's ->cbovlmask bit

Nit: s/check_cb_ovld_locked/rcutree_migrate_callbacks/

> appropriately.
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
> index c19d5926886fb..f4a37f2032664 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4491,6 +4491,7 @@ void rcutree_migrate_callbacks(int cpu)
>   	needwake = needwake || rcu_advance_cbs(my_rnp, my_rdp);
>   	rcu_segcblist_disable(&rdp->cblist);
>   	WARN_ON_ONCE(rcu_segcblist_empty(&my_rdp->cblist) != !rcu_segcblist_n_cbs(&my_rdp->cblist));
> +	check_cb_ovld_locked(my_rdp, my_rnp);
>   	if (rcu_rdp_is_offloaded(my_rdp)) {
>   		raw_spin_unlock_rcu_node(my_rnp); /* irqs remain disabled. */
>   		__call_rcu_nocb_wake(my_rdp, true, flags);
