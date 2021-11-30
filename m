Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC1E463C6B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 18:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244556AbhK3RF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 12:05:26 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:32631 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244535AbhK3RFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 12:05:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638291726; x=1669827726;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+mK++W47HMwEMFNKuyUJKDP/LccL4vEScUgf0gu9vq8=;
  b=Tt/03SzfU0Qx47zPLv391v6j3if5wNmlwpXyRBFcLsPJVzFCMGRDylSB
   yc9ya8Uq+t9mmUsUfHVl15coHzV8fhN8vrTeKOe2LmdA/zPn6+XRtIzpH
   Tu9Uk26rKjKAhet1nU1T3WXtzpOChW8u2ZKPpsyaxsT7s2S5dW8GwNs/v
   U=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 30 Nov 2021 09:02:05 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 09:02:04 -0800
Received: from [10.216.9.218] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 30 Nov
 2021 09:02:01 -0800
Message-ID: <dee700be-bad1-e497-ccfc-916b98d7d593@quicinc.com>
Date:   Tue, 30 Nov 2021 22:31:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] rcu/exp: Mark current CPU as exp-QS in IPI loop second
 pass
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>
References: <20211130162108.605092-1-frederic@kernel.org>
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <20211130162108.605092-1-frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/2021 9:51 PM, Frederic Weisbecker wrote:
> While looping through the rnp's CPUs to IPI for an expedited grace
> period, a first pass excludes the current CPU and the CPUs in dynticks
> idle mode. The workqueue will report their QS on their behalf later.
> 
> The second pass processes the IPIs and also ignores the current CPU,
> assuming it has been previously included in the group of CPUs whose
> QS are to be reported by the workqueue.
> 
> Unfortunately the current CPU may have changed between the first and
> second pass, due to the rnp lock being dropped, re-enabling preemption.
> As a result the current CPU, if different in the second pass, may be
> ignored by the expedited grace period. No IPI will be sent to it
> so it won't be requested to report an expedited quiescent state.
> 
> This ends up in an expedited grace period stall.
> 
> Fix this with including the current CPU in the second round in the group
> of CPUs to report a QS for by the workqueue.
> 
> Fixes: b9ad4d6ed18e ("rcu: Avoid self-IPI in sync_rcu_exp_select_node_cpus()")
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> ---

Reviewed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>



Thanks
Neeraj


>   kernel/rcu/tree_exp.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index a96d17206d87..237a79989aba 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -387,6 +387,7 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
>   			continue;
>   		}
>   		if (get_cpu() == cpu) {
> +			mask_ofl_test |= mask;
>   			put_cpu();
>   			continue;
>   		}
> 
