Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B39552F7D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 12:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiFUKNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 06:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349264AbiFUKNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 06:13:36 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CF1286D6;
        Tue, 21 Jun 2022 03:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655806416; x=1687342416;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GuUZYGJCCDafvKSE0MKW/woRSLQp5QhRHAaV0w9BCYk=;
  b=pOAyqK8FRo4NFzBJupF5QkMivX9vGkRVg4ymXLWsZoylc87CmogGoJ/h
   LO/IX1GRFwnjASWKMW7XZXpcrisCgRnTTPI7BHKQJgo5STr8+7IBZpgZE
   sW22/VxOsmIO7tqNq9qn3qb2qbuRMZKy+y1jB30dqU5ilSs38/93hlmPY
   I=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 21 Jun 2022 03:13:35 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 03:13:35 -0700
Received: from [10.50.44.13] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 21 Jun
 2022 03:13:32 -0700
Message-ID: <248317a0-2ef4-c619-15b5-84e2b62aab5e@quicinc.com>
Date:   Tue, 21 Jun 2022 15:43:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH rcu 12/12] srcu: Block less aggressively for expedited
 grace periods
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>, <rcu@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <rostedt@goodmis.org>, Zhangfei Gao <zhangfei.gao@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20220620222022.GA3839466@paulmck-ThinkPad-P17-Gen-1>
 <20220620222032.3839547-12-paulmck@kernel.org>
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <20220620222032.3839547-12-paulmck@kernel.org>
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
> Commit 282d8998e997 ("srcu: Prevent expedited GPs and blocking readers
> from consuming CPU") fixed a problem where a long-running expedited SRCU
> grace period could block kernel live patching.  It did so by giving up
> on expediting once a given SRCU expedited grace period grew too old.
> 
> Unfortunately, this added excessive delays to boots of embedded systems
> running on qemu that use the ARM IORT RMR feature.  This commit therefore
> makes the transition away from expediting less aggressive, increasing
> the per-grace-period phase number of non-sleeping polls of readers from
> one to three and increasing the required grace-period age from one jiffy
> (actually from zero to one jiffies) to two jiffies (actually from one
> to two jiffies).
> 
> Fixes: 282d8998e997 ("srcu: Prevent expedited GPs and blocking readers from consuming CPU")
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Reported-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Reported-by: chenxiang (M)" <chenxiang66@hisilicon.com>
> Cc: Shameerali Kolothum Thodi  <shameerali.kolothum.thodi@huawei.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Link: https://lore.kernel.org/all/20615615-0013-5adc-584f-2b1d5c03ebfc@linaro.org/
> ---


Reviewed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>


Thanks
Neeraj

>   kernel/rcu/srcutree.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 50ba70f019dea..0db7873f4e95b 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -513,7 +513,7 @@ static bool srcu_readers_active(struct srcu_struct *ssp)
>   
>   #define SRCU_INTERVAL		1	// Base delay if no expedited GPs pending.
>   #define SRCU_MAX_INTERVAL	10	// Maximum incremental delay from slow readers.
> -#define SRCU_MAX_NODELAY_PHASE	1	// Maximum per-GP-phase consecutive no-delay instances.
> +#define SRCU_MAX_NODELAY_PHASE	3	// Maximum per-GP-phase consecutive no-delay instances.
>   #define SRCU_MAX_NODELAY	100	// Maximum consecutive no-delay instances.
>   
>   /*
> @@ -522,16 +522,22 @@ static bool srcu_readers_active(struct srcu_struct *ssp)
>    */
>   static unsigned long srcu_get_delay(struct srcu_struct *ssp)
>   {
> +	unsigned long gpstart;
> +	unsigned long j;
>   	unsigned long jbase = SRCU_INTERVAL;
>   
>   	if (ULONG_CMP_LT(READ_ONCE(ssp->srcu_gp_seq), READ_ONCE(ssp->srcu_gp_seq_needed_exp)))
>   		jbase = 0;
> -	if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)))
> -		jbase += jiffies - READ_ONCE(ssp->srcu_gp_start);
> -	if (!jbase) {
> -		WRITE_ONCE(ssp->srcu_n_exp_nodelay, READ_ONCE(ssp->srcu_n_exp_nodelay) + 1);
> -		if (READ_ONCE(ssp->srcu_n_exp_nodelay) > SRCU_MAX_NODELAY_PHASE)
> -			jbase = 1;
> +	if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq))) {
> +		j = jiffies - 1;
> +		gpstart = READ_ONCE(ssp->srcu_gp_start);
> +		if (time_after(j, gpstart))
> +			jbase += j - gpstart;
> +		if (!jbase) {
> +			WRITE_ONCE(ssp->srcu_n_exp_nodelay, READ_ONCE(ssp->srcu_n_exp_nodelay) + 1);
> +			if (READ_ONCE(ssp->srcu_n_exp_nodelay) > SRCU_MAX_NODELAY_PHASE)
> +				jbase = 1;
> +		}
>   	}
>   	return jbase > SRCU_MAX_INTERVAL ? SRCU_MAX_INTERVAL : jbase;
>   }
