Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F82552AB5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 08:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344593AbiFUGCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 02:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbiFUGCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 02:02:34 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C12222A4;
        Mon, 20 Jun 2022 23:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655791353; x=1687327353;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VHAjmEbZc7jwKnHS8zl9mOKNxsPKF/mZNylCIMifo4c=;
  b=lg3g74JYK6kV1tSk7Ju0+lZJuYxMjHj9vJdiuCMzNBYzjt22eMOjYQeu
   8bdCUzRwV8SeNjS9UnYjIc0c5RfKhpEFX0jFkO9JC4SZdlDAAKkNmRy+D
   Q9TWdzPtbUywGiQ6+tPLEsoJi3hzJFnf+bVfrvBCiVU5hv9+9z//kdtay
   4=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Jun 2022 23:02:33 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 23:02:33 -0700
Received: from [10.50.44.13] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 20 Jun
 2022 23:02:31 -0700
Message-ID: <32ce954a-7afd-fbde-ace9-37979539b299@quicinc.com>
Date:   Tue, 21 Jun 2022 11:32:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH rcu 05/12] rcu: Forbid RCU_STRICT_GRACE_PERIOD in TINY_RCU
 kernels
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>, <rcu@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <rostedt@goodmis.org>
References: <20220620222022.GA3839466@paulmck-ThinkPad-P17-Gen-1>
 <20220620222032.3839547-5-paulmck@kernel.org>
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <20220620222032.3839547-5-paulmck@kernel.org>
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
> The RCU_STRICT_GRACE_PERIOD Kconfig option does nothing in kernels
> built with CONFIG_TINY_RCU=y, so this commit adjusts the dependencies
> to disallow this combination.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---

Reviewed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>


Thanks
Neeraj

>   kernel/rcu/Kconfig.debug | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
> index 9b64e55d4f615..4da05beb13d79 100644
> --- a/kernel/rcu/Kconfig.debug
> +++ b/kernel/rcu/Kconfig.debug
> @@ -121,7 +121,7 @@ config RCU_EQS_DEBUG
>   
>   config RCU_STRICT_GRACE_PERIOD
>   	bool "Provide debug RCU implementation with short grace periods"
> -	depends on DEBUG_KERNEL && RCU_EXPERT && NR_CPUS <= 4
> +	depends on DEBUG_KERNEL && RCU_EXPERT && NR_CPUS <= 4 && !TINY_RCU
>   	default n
>   	select PREEMPT_COUNT if PREEMPT=n
>   	help
