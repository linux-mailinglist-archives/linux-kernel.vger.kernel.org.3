Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238E3587BB4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 13:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbiHBLkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 07:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236506AbiHBLkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 07:40:20 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230A72676;
        Tue,  2 Aug 2022 04:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659440418; x=1690976418;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YpUtE1Gh283+1zH/RtwpbH/r5au2IVBLc5uPyBfB2ZA=;
  b=nPc7GzHoaoGhNsJxthttxFiXkhknMfN8DFN+/Ai/J3wOLG/l0IvqOfry
   piFiotBOPAAotBp07eF4Ps1uMlu3VROZ7aaGB60TIsaZNcH49dTiMVhOU
   WhtRrlEyFZN/lNeLxpTP2hejXBKzYUA4W9CvZX3L3CD2z96GE6YTm0DVN
   c=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 02 Aug 2022 04:40:17 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 04:40:16 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 2 Aug 2022 04:39:49 -0700
Received: from [10.216.56.39] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 2 Aug 2022
 04:39:46 -0700
Message-ID: <1f284b9c-257b-a127-55c0-e6cc8c07a9eb@quicinc.com>
Date:   Tue, 2 Aug 2022 17:07:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 4/5] firmware: qcom: scm: Add wait-queue helper
 functions
Content-Language: en-US
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     David Heidelberg <david@ixit.cz>,
        Robert Marko <robimarko@gmail.com>,
        Elliot Berman <quic_eberman@quicinc.com>
References: <1658529438-9234-1-git-send-email-quic_gurus@quicinc.com>
 <1658529438-9234-5-git-send-email-quic_gurus@quicinc.com>
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <1658529438-9234-5-git-send-email-quic_gurus@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/23/2022 4:07 AM, Guru Das Srinagesh wrote:
> When the firmware (FW) supports multiple requests per VM, and the VM
> also supports it via the `allow-multi-call` device tree flag, the
> floodgates are thrown open for them to all reach the firmware at the
> same time.
> 
> Since the firmware currently being used has limited resources, it guards
> them with a resource lock and puts requests on a wait-queue internally
> and signals to HLOS that it is doing so. It does this by returning two
> new return values in addition to success or error: SCM_WAITQ_SLEEP and
> SCM_WAITQ_WAKE.
> 
>    1) SCM_WAITQ_SLEEP:
> 
>    	When an SCM call receives this return value instead of success
>    	or error, FW has placed this call on a wait-queue and
>    	has signalled HLOS to put it to non-interruptible sleep. (The
> 	mechanism to wake it back up will be described in detail in the
> 	next patch for the sake of simplicity.)
> 
> 	Along with this return value, FW also passes to HLOS `wq_ctx` -
> 	a unique number (UID) identifying the wait-queue that it has put
> 	the call on, internally. This is to help HLOS with its own
> 	bookkeeping to wake this sleeping call later.
> 
> 	Additionally, FW also passes to HLOS `smc_call_ctx` - a UID
> 	identifying the SCM call thus being put to sleep. This is also
> 	for HLOS' bookkeeping to wake this call up later.
> 
> 	These two additional values are passed via the a1 and a2
> 	registers.
> 
> 	N.B.: The "ctx" in the above UID names = "context".
> 
>    2) SCM_WAITQ_WAKE:
> 
>    	When an SCM call receives this return value instead of success
>    	or error, FW wishes to signal HLOS to wake up a (different)
>    	previously sleeping call.
> 
>    	FW tells HLOS which call to wake up via the additional return
>    	values `wq_ctx`, `smc_call_ctx` and `flags`. The first two have
>    	already been explained above.
> 
>    	`flags` can be either WAKE_ONE or WAKE_ALL. Meaning, wake either
>    	one, or all, of the SCM calls that HLOS is associating with the
>    	given `wq_ctx`.
> 
> A sleeping SCM call can be woken up by either an interrupt that FW
> raises, or via a SCM_WAITQ_WAKE return value for a new SCM call.

Do you know why the FW was not designed to always use an interrupt?
That would have made the handling of this in kernel a lot less complicated.
  
> The handshake mechanism that HLOS uses to talk to FW about wait-queue
> operations involves three new SMC calls. These are:
> 
>    1) get_wq_ctx():
> 
>      	Arguments: 	None
>      	Returns:	wq_ctx, flags, more_pending
> 
>      	Get the wait-queue context, and wake up either one or all of the
>      	sleeping SCM calls associated with that wait-queue.
> 
>      	Additionally, repeat this if there are more wait-queues that are
>      	ready to have their requests woken up (`more_pending`).
> 
>    2) wq_resume(smc_call_ctx):
> 
>    	Arguments:	smc_call_ctx
> 
>    	HLOS needs to issue this in response to receiving an
>    	IRQ, passing to FW the same smc_call_ctx that FW
>    	receives from HLOS via the get_wq_ctx() call.
> 
>    3) wq_wake_ack(smc_call_ctx):
> 
>    	Arguments:	smc_call_ctx
> 
>    	HLOS needs to issue this in response to receiving an
>    	SCM_WAITQ_WAKE, passing to FW the same smc_call_ctx that FW
>    	passed to HLOS via the SMC_WAITQ_WAKE call.
> 
> (Reminder that the full handshake mechanism will be detailed in the
> subsequent patch.)
> 
> Also add the interrupt handler that wakes up a sleeping SCM call.
> 
> Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
> ---
[]..

> +struct completion *qcom_scm_lookup_wq(struct qcom_scm *scm, u32 wq_ctx)
> +{
> +	struct completion *wq = NULL;
> +	u32 wq_ctx_idr = wq_ctx;
> +	unsigned long flags;
> +	int err;
> +
> +	spin_lock_irqsave(&scm->waitq.idr_lock, flags);
> +	wq = idr_find(&scm->waitq.idr, wq_ctx);
> +	if (wq)
> +		goto out;
> +
> +	wq = devm_kzalloc(scm->dev, sizeof(*wq), GFP_ATOMIC);
> +	if (!wq) {
> +		wq = ERR_PTR(-ENOMEM);
> +		goto out;
> +	}
> +
> +	init_completion(wq);
> +
> +	err = idr_alloc_u32(&scm->waitq.idr, wq, &wq_ctx_idr,
> +			    U32_MAX, GFP_ATOMIC);
> +	if (err < 0) {
> +		devm_kfree(scm->dev, wq);
> +		wq = ERR_PTR(err);
> +	}
> +
> +out:
> +	spin_unlock_irqrestore(&scm->waitq.idr_lock, flags);
> +	return wq;
> +}
> +
> +void scm_waitq_flag_handler(struct completion *wq, u32 flags)
> +{
> +	switch (flags) {
> +	case QCOM_SMC_WAITQ_FLAG_WAKE_ONE:
> +		complete(wq);
> +		break;
> +	case QCOM_SMC_WAITQ_FLAG_WAKE_ALL:
> +		complete_all(wq);
> +		break;
> +	default:
> +		pr_err("invalid flags: %u\n", flags);
> +	}
> +}
> +
> +static void scm_irq_work(struct work_struct *work)
> +{
> +	int ret;
> +	u32 wq_ctx, flags, more_pending = 0;
> +	struct completion *wq_to_wake;
> +	struct qcom_scm_waitq *w = container_of(work, struct qcom_scm_waitq, scm_irq_work);
> +	struct qcom_scm *scm = container_of(w, struct qcom_scm, waitq);
> +
> +	do {
> +		ret = scm_get_wq_ctx(&wq_ctx, &flags, &more_pending);
> +		if (ret) {
> +			pr_err("GET_WQ_CTX SMC call failed: %d\n", ret);
> +			return;
> +		}
> +
> +		wq_to_wake = qcom_scm_lookup_wq(scm, wq_ctx);
> +		if (IS_ERR_OR_NULL(wq_to_wake)) {
> +			pr_err("No waitqueue found for wq_ctx %d: %ld\n",
> +					wq_ctx, PTR_ERR(wq_to_wake));
> +			return;

What happens if at this point 'more_pending' was true? will the FW raise
another interrupt?

> +		}
> +
> +		scm_waitq_flag_handler(wq_to_wake, flags);
> +	} while (more_pending);
> +}

