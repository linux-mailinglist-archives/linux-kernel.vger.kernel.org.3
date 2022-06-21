Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95592552A6C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 07:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345119AbiFUFRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 01:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343981AbiFUFRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 01:17:14 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464C220F5D;
        Mon, 20 Jun 2022 22:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655788634; x=1687324634;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DjJMR92QYWj6k70zoT1/F5wl329J/DDEyFJrt7RMfaI=;
  b=Wpq/04DbTJ/uvQ30/mnE9QsVTfY8wKzisGXJZugyxXV2Gn0DnAA8DLxQ
   Cj9rH5S9HirU7PG081yjV6OkNghqqZL67IhUcuG3KLnKQAdeEIB4f9cXP
   o67w7YSMdBfc9NOzuPkyZ8KJa2wESEMtgk8RZups+YuVfiD8y9VfC0YkY
   U=;
Received: from ironmsg-sd-alpha.qualcomm.com ([10.53.140.30])
  by alexa-out.qualcomm.com with ESMTP; 20 Jun 2022 22:17:14 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 22:10:59 -0700
Received: from [10.50.44.13] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 20 Jun
 2022 22:10:57 -0700
Message-ID: <a40ab401-1368-b287-0e2b-daf8026bbf5a@quicinc.com>
Date:   Tue, 21 Jun 2022 10:40:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH rcu 2/3] doc: Document the rcutree.rcu_divisor kernel boot
 parameter
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>, <rcu@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <rostedt@goodmis.org>, Eric Dumazet <edumazet@google.com>
References: <20220620221733.GA3839136@paulmck-ThinkPad-P17-Gen-1>
 <20220620221757.3839212-2-paulmck@kernel.org>
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <20220620221757.3839212-2-paulmck@kernel.org>
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



On 6/21/2022 3:47 AM, Paul E. McKenney wrote:
> This commit adds kernel-parameters.txt documentation for the
> rcutree.rcu_divisor kernel boot parameter, which controls the softirq
> callback-invocation batch limit.
> 
> Cc: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---

Reviewed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>

>   Documentation/admin-guide/kernel-parameters.txt | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 2522b11e593f2..bdf431bdbfdc4 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4666,6 +4666,21 @@
>   			When RCU_NOCB_CPU is set, also adjust the
>   			priority of NOCB callback kthreads.
>   
> +	rcutree.rcu_divisor= [KNL]
> +			Set the shift-right count to use to compute
> +			the callback-invocation batch limit bl from
> +			the number of callbacks queued on this CPU.
> +			The result will be bounded below by the value of
> +			the rcutree.blimit kernel parameter.  Every bl
> +			callbacks, the softirq handler will exit in
> +			order to allow the CPU to do other work.
> +
> +			Please note that this callback-invocation batch
> +			limit applies only to non-offloaded callback
> +			invocation.  Offloaded callbacks are instead
> +			invoked in the context of an rcuoc kthread, which
> +			scheduler will preempt as it does any other task.
> +
>   	rcutree.rcu_nocb_gp_stride= [KNL]
>   			Set the number of NOCB callback kthreads in
>   			each group, which defaults to the square root
