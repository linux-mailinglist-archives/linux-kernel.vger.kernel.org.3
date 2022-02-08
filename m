Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6614ADA27
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358831AbiBHNkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243023AbiBHNke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 08:40:34 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13AEC03FED0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 05:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644327633; x=1675863633;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q4G/SZPJo4bllBcLYXaoB9cwYQmtRawt9cIr4MkpgHo=;
  b=gGGv/KWinz9aUxQcKmOIzK22oVCITGuce2AfUdYu/tIT60gKziz9JXKz
   Cmpn/y9s519RR59K8KokEUvLFbg43On0rRIc+4UyIgLGJDdczNk6kdexE
   99rAWCeI7Fp7hQexO4KOcJo2O5YBq73+L4t3lLepvY+UMRJ1wwxw7M3Om
   Y=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 08 Feb 2022 05:40:32 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 05:40:32 -0800
Received: from [10.216.32.197] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.47.97.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 8 Feb 2022
 05:40:29 -0800
Message-ID: <4b8ae129-45f9-33f9-673e-b134b4c36324@quicinc.com>
Date:   Tue, 8 Feb 2022 19:10:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] softirq: Remove raise_softirq from
 tasklet_action_common()
Content-Language: en-US
To:     <linux-kernel@vger.kernel.org>
CC:     <peterz@infradead.org>, <tglx@linutronix.de>, <paulmck@kernel.org>,
        <will@kernel.org>, <dave@stgolabs.net>, <frederic@kernel.org>
References: <1644066805-17212-1-git-send-email-quic_mojha@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <1644066805-17212-1-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.47.97.222)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Sorry for the reminder so quickly as we are hitting this issue more 
frequently.
Please suggest if whether below patch will have any side-effect.

-Mukesh

On 2/5/2022 6:43 PM, Mukesh Ojha wrote:
> Think about a scenario when all other cores are in suspend
> and one core is only running ksoftirqd and it is because
> some client has invoked tasklet_hi_schedule() only once
> during that phase.
>
> tasklet_action_common() handles that softirq and marks the
> same softirq as pending again. And due to that core keeps
> running the softirq handler [1] forever and it is not able to
> go to suspend.
>
> We can get rid of raising softirq from tasklet handler.
>
> [1]
> <idle>-0    [003]   13058.769081:  softirq_entry   vec=0  action=HI_SOFTIRQ
> <idle>-0     [003]  13058.769085: softirq_raise:        vec=0 [action=HI_SOFTIRQ]
> <idle>-0    [003]   13058.769087:  softirq_exit   vec=0  action=HI_SOFTIRQ
> <idle>-0    [003]   13058.769091:  softirq_entry   vec=0  action=HI_SOFTIRQ
> <idle>-0     [003]  13058.769094: softirq_raise:        vec=0 [action=HI_SOFTIRQ]
> <idle>-0    [003]   13058.769097:  softirq_exit   vec=0  action=HI_SOFTIRQ
> <idle>-0    [003]   13058.769100:  softirq_entry   vec=0  action=HI_SOFTIRQ
> <idle>-0     [003]  13058.769103: softirq_raise:        vec=0 [action=HI_SOFTIRQ]
> <idle>-0    [003]   13058.769106:  softirq_exit   vec=0  action=HI_SOFTIRQ
> <idle>-0    [003]   13058.769109:  softirq_entry   vec=0  action=HI_SOFTIRQ
> <idle>-0    [003]   13059.058923:  softirq_entry   vec=0  action=HI_SOFTIRQ
> ...
> ..
> ..
> ..
>
> <idle>-0    [003]   13059.058951:  softirq_entry   vec=0  action=HI_SOFTIRQ
> <idle>-0     [003]  13059.058954: softirq_raise:        vec=0 [action=HI_SOFTIRQ]
> <idle>-0    [003]   13059.058957:  softirq_exit   vec=0  action=HI_SOFTIRQ
> <idle>-0    [003]   13059.058960:  softirq_entry   vec=0  action=HI_SOFTIRQ
> <idle>-0     [003]  13059.058963: softirq_raise:        vec=0 [action=HI_SOFTIRQ]
> <idle>-0    [003]   13059.058966:  softirq_exit   vec=0  action=HI_SOFTIRQ
> <idle>-0    [003]   13059.058969:  softirq_entry   vec=0  action=HI_SOFTIRQ
> <idle>-0     [003]  13059.058972: softirq_raise:        vec=0 [action=HI_SOFTIRQ]
> <idle>-0    [003]   13059.058975:  softirq_exit   vec=0  action=HI_SOFTIRQ
> <idle>-0    [003]   13059.058978:  softirq_entry   vec=0  action=HI_SOFTIRQ
> <idle>-0     [003]  13059.058981: softirq_raise:        vec=0 [action=HI_SOFTIRQ]
> <idle>-0    [003]   13059.058984:  softirq_exit   vec=0  action=HI_SOFTIRQ
> <idle>-0    [003]   13059.058987:  softirq_entry   vec=0  action=HI_SOFTIRQ
> <idle>-0     [003]  13059.058990: softirq_raise:        vec=0 [action=HI_SOFTIRQ]
> <idle>-0    [003]   13059.058993:  softirq_exit   vec=0  action=HI_SOFTIRQ
> <idle>-0    [003]   13059.058996:  softirq_entry   vec=0  action=HI_SOFTIRQ
> <idle>-0     [003]  13059.059000: softirq_raise:        vec=0 [action=HI_SOFTIRQ]
> <idle>-0    [003]   13059.059002:  softirq_exit   vec=0  action=HI_SOFTIRQ
>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>   kernel/softirq.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 41f4709..d3e6fb9 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -795,7 +795,6 @@ static void tasklet_action_common(struct softirq_action *a,
>   		t->next = NULL;
>   		*tl_head->tail = t;
>   		tl_head->tail = &t->next;
> -		__raise_softirq_irqoff(softirq_nr);
>   		local_irq_enable();
>   	}
>   }
