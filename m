Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DBD552AFB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 08:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345277AbiFUGbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 02:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiFUGbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 02:31:35 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D9860E3;
        Mon, 20 Jun 2022 23:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655793095; x=1687329095;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8B6OBov+Dp//rrdGe97WOSHuT0EA9+jVckLT/ZqJALw=;
  b=Yti7jI5hBRbceJ9pXq6fzHoFdzwrLgG86FXFEM+pgwt6IWXTHgdBcH11
   e3gJ2ovgdZz4Y5Z2yRFjhUU62Fycm0BoKZr8RIMVjLq56v1Zos9pXnSj4
   g8E2VYQmRG01d86PJr15YQX6JFlmNrLYQgRhLm0l/fQ8oc1xI4tgKueGe
   M=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 20 Jun 2022 23:31:34 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 23:31:34 -0700
Received: from [10.50.44.13] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 20 Jun
 2022 23:31:32 -0700
Message-ID: <00f3eb47-2529-a493-ee67-c0c0219937a3@quicinc.com>
Date:   Tue, 21 Jun 2022 12:01:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH rcu 07/12] rcu: tiny: Record kvfree_call_rcu() call stack
 for KASAN
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>, <rcu@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <rostedt@goodmis.org>, Johannes Berg <johannes.berg@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>
References: <20220620222022.GA3839466@paulmck-ThinkPad-P17-Gen-1>
 <20220620222032.3839547-7-paulmck@kernel.org>
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <20220620222032.3839547-7-paulmck@kernel.org>
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
> From: Johannes Berg <johannes.berg@intel.com>
> 
> When running KASAN with Tiny RCU (e.g. under ARCH=um, where
> a working KASAN patch is now available), we don't get any
> information on the original kfree_rcu() (or similar) caller
> when a problem is reported, as Tiny RCU doesn't record this.
> 
> Add the recording, which required pulling kvfree_call_rcu()
> out of line for the KASAN case since the recording function
> (kasan_record_aux_stack_noalloc) is neither exported, nor
> can we include kasan.h into rcutiny.h.
> 
> without KASAN, the patch has no size impact (ARCH=um kernel):
>      text       data         bss         dec        hex    filename
>   6151515    4423154    33148520    43723189    29b29b5    linux
>   6151515    4423154    33148520    43723189    29b29b5    linux + patch
> 
> with KASAN, the impact on my build was minimal:
>      text       data         bss         dec        hex    filename
> 13915539    7388050    33282304    54585893    340ea25    linux
> 13911266    7392114    33282304    54585684    340e954    linux + patch
>     -4273      +4064         +-0        -209
> 
> Acked-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>   include/linux/rcutiny.h | 11 ++++++++++-
>   kernel/rcu/tiny.c       | 14 ++++++++++++++
>   2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> index 5fed476f977f6..d84e13f2c3848 100644
> --- a/include/linux/rcutiny.h
> +++ b/include/linux/rcutiny.h
> @@ -38,7 +38,7 @@ static inline void synchronize_rcu_expedited(void)
>    */
>   extern void kvfree(const void *addr);
>   
> -static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> +static inline void __kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>   {
>   	if (head) {
>   		call_rcu(head, func);
> @@ -51,6 +51,15 @@ static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>   	kvfree((void *) func);
>   }
>   
> +#ifdef CONFIG_KASAN_GENERIC
> +void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
> +#else
> +static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> +{
> +	__kvfree_call_rcu(head, func);
> +}
> +#endif
> +
>   void rcu_qs(void);
>   
>   static inline void rcu_softirq_qs(void)
> diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> index 340b3f8b090d4..58ff3721d975c 100644
> --- a/kernel/rcu/tiny.c
> +++ b/kernel/rcu/tiny.c
> @@ -217,6 +217,20 @@ bool poll_state_synchronize_rcu(unsigned long oldstate)
>   }
>   EXPORT_SYMBOL_GPL(poll_state_synchronize_rcu);
>   
> +#ifdef CONFIG_KASAN_GENERIC
> +void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> +{
> +	if (head) {
> +		void *ptr = (void *) head - (unsigned long) func;
> +
> +		kasan_record_aux_stack_noalloc(ptr);
> +	}

For the !head case; similar to Tree RCU's kvfree_call_rcu() 
implementation, we do not need to record 'ptr' (which will be 'func')?


Thanks
Neeraj

> +
> +	__kvfree_call_rcu(head, func);
> +}
> +EXPORT_SYMBOL_GPL(kvfree_call_rcu);
> +#endif
> +
>   void __init rcu_init(void)
>   {
>   	open_softirq(RCU_SOFTIRQ, rcu_process_callbacks);
