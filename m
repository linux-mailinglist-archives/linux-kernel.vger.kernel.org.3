Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD5C53364C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 06:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243901AbiEYE7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 00:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiEYE7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 00:59:32 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1516D965;
        Tue, 24 May 2022 21:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653454771; x=1684990771;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GHOj2l2urcqqARNcMyQOMnEK4s0C4+ANnS4lwtoLk2s=;
  b=WSGJ+EXo3tQXKo81Fn3jRsO9eCSe1e1f5b2o0O6nTTFLnDV8uHub+CFD
   UzzShIlwWKLmn3CsONW4t8atO/ueMOWFkoavqYnNqEq+OE/90yu/PBBtm
   3jxtqFZZdNyt3dOzNyGwoEhqbBAgOA6WJjMdHrI8jysMmdfs00LkNGXxE
   g=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 24 May 2022 21:59:30 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 21:59:29 -0700
Received: from [10.216.2.173] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.47.97.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 24 May
 2022 21:59:27 -0700
Message-ID: <e531081f-4871-5292-6a31-782fa7228788@quicinc.com>
Date:   Wed, 25 May 2022 10:29:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] rcu: Add rnp->expmask output to show_rcu_gp_kthreads()
Content-Language: en-US
To:     Zqiang <qiang1.zhang@intel.com>, <paulmck@kernel.org>,
        <frederic@kernel.org>
CC:     <rcu@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220525044503.2083630-1-qiang1.zhang@intel.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20220525044503.2083630-1-qiang1.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.47.97.222)
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/25/2022 10:15 AM, Zqiang wrote:
> Currently, for expedited rcu we only check 'rnp->exp_tasks', however
> the 'rnp->exp_tasks' are not always exist for expedited grace period
> that not end. this commit add 'rnp->expmask' condition.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Thanks !! for the patch.
Commit log could require wordsmith from Paul :-)

Reviewed-by: quic_mojha@quicinc.com

-Mukesh

> ---
>   kernel/rcu/tree_stall.h | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 2464b0eccfd0..5c4df855f2ac 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -865,13 +865,15 @@ void show_rcu_gp_kthreads(void)
>   	rcu_for_each_node_breadth_first(rnp) {
>   		if (ULONG_CMP_GE(READ_ONCE(rcu_state.gp_seq), READ_ONCE(rnp->gp_seq_needed)) &&
>   		    !data_race(READ_ONCE(rnp->qsmask)) && !data_race(READ_ONCE(rnp->boost_tasks)) &&
> -		    !data_race(READ_ONCE(rnp->exp_tasks)) && !data_race(READ_ONCE(rnp->gp_tasks)))
> +		    !data_race(READ_ONCE(rnp->expmask)) && !data_race(READ_ONCE(rnp->exp_tasks)) &&
> +			!data_race(READ_ONCE(rnp->gp_tasks)))
>   			continue;
> -		pr_info("\trcu_node %d:%d ->gp_seq %ld ->gp_seq_needed %ld ->qsmask %#lx %c%c%c%c ->n_boosts %ld\n",
> +		pr_info("\trcu_node %d:%d ->gp_seq %ld ->gp_seq_needed %ld ->qsmask %#lx ->expmask %#lx %c%c%c%c ->n_boosts %ld\n",
>   			rnp->grplo, rnp->grphi,
>   			(long)data_race(READ_ONCE(rnp->gp_seq)),
>   			(long)data_race(READ_ONCE(rnp->gp_seq_needed)),
>   			data_race(READ_ONCE(rnp->qsmask)),
> +			data_race(READ_ONCE(rnp->expmask)),
>   			".b"[!!data_race(READ_ONCE(rnp->boost_kthread_task))],
>   			".B"[!!data_race(READ_ONCE(rnp->boost_tasks))],
>   			".E"[!!data_race(READ_ONCE(rnp->exp_tasks))],
