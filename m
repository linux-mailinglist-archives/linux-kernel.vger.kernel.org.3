Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7CD4B7A96
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244594AbiBOWkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:40:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244585AbiBOWkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:40:04 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89054C116D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:39:53 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id q8so254529iod.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uOo/gjkfEzxwUurWqeVL1564VM9kX9R8Jfa8ym3FUog=;
        b=nT4IOcC3iLZJQ99r7geci7N8epcvWavcFA4PUOX16EHSoyIBjsXxP6r+rqnnLq5Ysf
         IA6VM9Z8jE3eSFczW2INtd4X0Hle6SKA8tQ+dNWhOdW8Cd6HMfa4mHxpIsQyOQ9w7GB9
         rk6ox/HJX57sBBBLl6S6Szen+oBXrhlP2p+weIGE66wbBRGlmPFb4Kx0zT3aCZh/fPqj
         P6rnS50X0pVUnWzHqX8fuUtX4BImTMGch31qD7tI/jylPqFSjeLdpXYtkkoFrgcVMMJ7
         t8aSzGdkLcgEEeGBKkB1gJ3cR+ni0MVtOlLlegTa+X1x3kVCLjPK5XYXVG/KYbL0UA5f
         xlAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uOo/gjkfEzxwUurWqeVL1564VM9kX9R8Jfa8ym3FUog=;
        b=DW+jSgY/fgRcQVVHX2GM0cglxJXugjfGe8WQwn3hcKpT5ekoVC6OPl+g6BKWlxOgsX
         nNzOy6jUN0qPPfXY5wJtJHq/NOwWw8XgnZHFczry5gB7ySjC4YhqRqzJPzdt0ckniD7o
         RRlJ6saopDhByTkZlrZQBUV/T+J0c1qyHmjenhPLtHPjtJAkGIw0fcE8n0yvTx4BPq6e
         ryDDHibYvXCIGxuw9jSifRauahOMnVtgJZ5onogziDWcxsqqMJptaNkq0YfyqMGVtEVt
         HkkhxjAQCct09fdbYsYwtpVkUJWG0Yu1P+RoveybKZmqMFxxodTp1caYh5MQ8xo/ccFA
         NAUQ==
X-Gm-Message-State: AOAM5302n+1MjIVX2AyC/jWlXTsY5JFvBA01wqgjDgrXRddKychDUnFR
        2LI/k6E4sKtLu/sQmJMlNTxtfQ==
X-Google-Smtp-Source: ABdhPJx2td2UAc4kj1d+BgDgXVw7+n62F0Sq5RWYC8UTHVl5qeLrf89WcDMNmJJUHu34oX0mu+5bTA==
X-Received: by 2002:a05:6638:329a:: with SMTP id f26mr693260jav.28.1644964791399;
        Tue, 15 Feb 2022 14:39:51 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id x11sm23234205iow.8.2022.02.15.14.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 14:39:50 -0800 (PST)
Message-ID: <2941d38d-dd8f-6a70-8949-5b9e1e42d336@linaro.org>
Date:   Tue, 15 Feb 2022 16:39:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 18/25] bus: mhi: ep: Add support for handling MHI_RESET
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
 <20220212182117.49438-19-manivannan.sadhasivam@linaro.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220212182117.49438-19-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/22 12:21 PM, Manivannan Sadhasivam wrote:
> Add support for handling MHI_RESET in MHI endpoint stack. MHI_RESET will
> be issued by the host during shutdown and during error scenario so that
> it can recover the endpoint device without restarting the whole device.
> 
> MHI_RESET handling involves resetting the internal MHI registers, data
> structures, state machines, resetting all channels/rings and setting
> MHICTRL.RESET bit to 0. Additionally the device will also move to READY
> state if the reset was due to SYS_ERR.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

I might be getting tired out...  But this looks good to me!

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/bus/mhi/ep/main.c | 53 +++++++++++++++++++++++++++++++++++++++
>   include/linux/mhi_ep.h    |  2 ++
>   2 files changed, 55 insertions(+)
> 
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index 14cb08de4263..ddedd0fb19aa 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -471,6 +471,7 @@ static irqreturn_t mhi_ep_irq(int irq, void *data)
>   	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>   	enum mhi_state state;
>   	u32 int_value;
> +	bool mhi_reset;
>   
>   	/* Acknowledge the interrupts */
>   	int_value = mhi_ep_mmio_read(mhi_cntrl, MHI_CTRL_INT_STATUS_A7);
> @@ -479,6 +480,14 @@ static irqreturn_t mhi_ep_irq(int irq, void *data)
>   	/* Check for ctrl interrupt */
>   	if (FIELD_GET(MHI_CTRL_INT_STATUS_A7_MSK, int_value)) {
>   		dev_dbg(dev, "Processing ctrl interrupt\n");
> +		mhi_ep_mmio_get_mhi_state(mhi_cntrl, &state, &mhi_reset);
> +		if (mhi_reset) {
> +			dev_info(dev, "Host triggered MHI reset!\n");
> +			disable_irq_nosync(mhi_cntrl->irq);
> +			schedule_work(&mhi_cntrl->reset_work);
> +			return IRQ_HANDLED;
> +		}
> +
>   		mhi_ep_process_ctrl_interrupt(mhi_cntrl, state);
>   	}
>   
> @@ -559,6 +568,49 @@ static void mhi_ep_abort_transfer(struct mhi_ep_cntrl *mhi_cntrl)
>   	mhi_cntrl->is_enabled = false;
>   }
>   
> +static void mhi_ep_reset_worker(struct work_struct *work)
> +{
> +	struct mhi_ep_cntrl *mhi_cntrl = container_of(work, struct mhi_ep_cntrl, reset_work);
> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	enum mhi_state cur_state;
> +	int ret;
> +
> +	mhi_ep_abort_transfer(mhi_cntrl);
> +
> +	spin_lock_bh(&mhi_cntrl->state_lock);
> +	/* Reset MMIO to signal host that the MHI_RESET is completed in endpoint */
> +	mhi_ep_mmio_reset(mhi_cntrl);
> +	cur_state = mhi_cntrl->mhi_state;
> +	spin_unlock_bh(&mhi_cntrl->state_lock);
> +
> +	/*
> +	 * Only proceed further if the reset is due to SYS_ERR. The host will
> +	 * issue reset during shutdown also and we don't need to do re-init in
> +	 * that case.
> +	 */
> +	if (cur_state == MHI_STATE_SYS_ERR) {
> +		mhi_ep_mmio_init(mhi_cntrl);
> +
> +		/* Set AMSS EE before signaling ready state */
> +		mhi_ep_mmio_set_env(mhi_cntrl, MHI_EP_AMSS_EE);
> +
> +		/* All set, notify the host that we are ready */
> +		ret = mhi_ep_set_ready_state(mhi_cntrl);
> +		if (ret)
> +			return;
> +
> +		dev_dbg(dev, "READY state notification sent to the host\n");
> +
> +		ret = mhi_ep_enable(mhi_cntrl);
> +		if (ret) {
> +			dev_err(dev, "Failed to enable MHI endpoint: %d\n", ret);
> +			return;
> +		}
> +
> +		enable_irq(mhi_cntrl->irq);
> +	}
> +}
> +
>   int mhi_ep_power_up(struct mhi_ep_cntrl *mhi_cntrl)
>   {
>   	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> @@ -827,6 +879,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
>   
>   	INIT_WORK(&mhi_cntrl->ring_work, mhi_ep_ring_worker);
>   	INIT_WORK(&mhi_cntrl->state_work, mhi_ep_state_worker);
> +	INIT_WORK(&mhi_cntrl->reset_work, mhi_ep_reset_worker);
>   
>   	mhi_cntrl->ring_wq = alloc_workqueue("mhi_ep_ring_wq", 0, 0);
>   	if (!mhi_cntrl->ring_wq) {
> diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
> index 4f86e7986c93..276d29fef465 100644
> --- a/include/linux/mhi_ep.h
> +++ b/include/linux/mhi_ep.h
> @@ -75,6 +75,7 @@ struct mhi_ep_db_info {
>    * @ring_wq: Dedicated workqueue for processing MHI rings
>    * @state_work: State transition worker
>    * @ring_work: Ring worker
> + * @reset_work: Worker for MHI Endpoint reset
>    * @ch_db_list: List of queued channel doorbells
>    * @st_transition_list: List of state transitions
>    * @list_lock: Lock for protecting state transition and channel doorbell lists
> @@ -126,6 +127,7 @@ struct mhi_ep_cntrl {
>   	struct workqueue_struct	*ring_wq;
>   	struct work_struct state_work;
>   	struct work_struct ring_work;
> +	struct work_struct reset_work;
>   
>   	struct list_head ch_db_list;
>   	struct list_head st_transition_list;

