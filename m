Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3470C4B7AA3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244623AbiBOWkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:40:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244607AbiBOWkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:40:15 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18511C1166
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:40:04 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id n5so114995ilk.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=t4lTJ0vfiVT6jQlKd5UQJQGFfo2RLMGBxnLS4/5xVcg=;
        b=wFa6XjAQbUnJ7jldJB6L8jdhrcmxbKRRyvl9cjBufyXKcDrfIPhvc5BJ8F7F7vn5eA
         MHfnsEBuIDkBs3hsnKA3nuKjhtpnbNUijco+FtnVCafrdLBZmoDdh/Zt7LaFlifLJlav
         cD0xc1N8NOT4GfNmZBOwmk3gjQKxymTPwL+e3+mrxYMyYisguvs8CwHzXRUQAhLPPmpr
         mEqp2IRXeul/9GzaDMlpC0XeT7gHdRhoB+e1AIhkpGg/EjQ2xVQvnzVd1P03hR5xGJna
         HL8Z4j5ln3ZTN6XQ45DyNxVqSxj8kjyZymeYnpxt4hdMaKclWpMxa8DF+4ZE9Zm+IoXv
         U+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t4lTJ0vfiVT6jQlKd5UQJQGFfo2RLMGBxnLS4/5xVcg=;
        b=l3WXzha38ceq2zkJ6J4HZFxZytnIjEdNO69BbqB4KDhegIa3AJ05qTs47PQnOLmcVe
         IyqXr8WkhWB2/5HSo4EhdwPLON883lD62skNaTvgLavCahybrAOs8z1T8HiTRmQkzoFM
         Rnmsvm3k5CSNd6ydpZyKfO8jiRor3ovlGnfKq6NdZ6/a9dbOc0yRYVQ0I3eIuK2wtl31
         BELTkBwYx+gTEjIBzjF/Vb2681KB5HBEGV3TXoye/Q7P6bgn/5m8JM1QplHN04OiGbdO
         WZIRHNqbq5Jk4P/Y04UO1AbrFZPTpQpV7bycvSIBwmg+UdJN+WxrvmZDeaTVXKfcQK8G
         3q+A==
X-Gm-Message-State: AOAM531eP0swasSEOkEC08Ui/ni9K7tRSU2vSkJgkyqM7my68kaC6ln5
        /QmJbYqZSfRyGCNH/7837VqMWw==
X-Google-Smtp-Source: ABdhPJz5RDtsRBLzyXTcjiAzFEhNPUVJuGfR8sl51+gafhwwAU17+MC0Xe3xGd0XB23dv667R2jo2g==
X-Received: by 2002:a05:6e02:1a86:: with SMTP id k6mr780402ilv.273.1644964803423;
        Tue, 15 Feb 2022 14:40:03 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id z23sm23310039iol.11.2022.02.15.14.40.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 14:40:02 -0800 (PST)
Message-ID: <05956282-57f4-996b-13ae-282fb40e1578@linaro.org>
Date:   Tue, 15 Feb 2022 16:40:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 20/25] bus: mhi: ep: Add support for processing command
 ring
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
 <20220212182117.49438-21-manivannan.sadhasivam@linaro.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220212182117.49438-21-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/22 12:21 PM, Manivannan Sadhasivam wrote:
> Add support for processing the command ring. Command ring is used by the
> host to issue channel specific commands to the ep device. Following
> commands are supported:
> 
> 1. Start channel
> 2. Stop channel
> 3. Reset channel
> 
> Once the device receives the command doorbell interrupt from host, it
> executes the command and generates a command completion event to the
> host in the primary event ring.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

I'll let you consider my few comments below, but whether or not you
address them, this looks OK to me.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/bus/mhi/ep/main.c | 151 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 151 insertions(+)
> 
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index 6378ac5c7e37..4c2ee517832c 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -21,6 +21,7 @@
>   
>   static DEFINE_IDA(mhi_ep_cntrl_ida);
>   
> +static int mhi_ep_create_device(struct mhi_ep_cntrl *mhi_cntrl, u32 ch_id);
>   static int mhi_ep_destroy_device(struct device *dev, void *data);
>   
>   static int mhi_ep_send_event(struct mhi_ep_cntrl *mhi_cntrl, u32 ring_idx,
> @@ -185,6 +186,156 @@ void mhi_ep_unmap_free(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr, phys_addr_t
>   	mhi_cntrl->free_addr(mhi_cntrl, phys - offset, virt - offset, size);
>   }
>   
> +int mhi_ep_process_cmd_ring(struct mhi_ep_ring *ring, struct mhi_ep_ring_element *el)
> +{
> +	struct mhi_ep_cntrl *mhi_cntrl = ring->mhi_cntrl;
> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	struct mhi_result result = {};
> +	struct mhi_ep_chan *mhi_chan;
> +	struct mhi_ep_ring *ch_ring;
> +	u32 tmp, ch_id;
> +	int ret;
> +
> +	ch_id = MHI_TRE_GET_CMD_CHID(el);
> +	mhi_chan = &mhi_cntrl->mhi_chan[ch_id];
> +	ch_ring = &mhi_cntrl->mhi_chan[ch_id].ring;
> +
> +	switch (MHI_TRE_GET_CMD_TYPE(el)) {

No MHI_PKT_TYPE_NOOP_CMD?

> +	case MHI_PKT_TYPE_START_CHAN_CMD:
> +		dev_dbg(dev, "Received START command for channel (%d)\n", ch_id);
> +
> +		mutex_lock(&mhi_chan->lock);
> +		/* Initialize and configure the corresponding channel ring */
> +		if (!ch_ring->started) {
> +			ret = mhi_ep_ring_start(mhi_cntrl, ch_ring,
> +				(union mhi_ep_ring_ctx *)&mhi_cntrl->ch_ctx_cache[ch_id]);
> +			if (ret) {
> +				dev_err(dev, "Failed to start ring for channel (%d)\n", ch_id);
> +				ret = mhi_ep_send_cmd_comp_event(mhi_cntrl,
> +							MHI_EV_CC_UNDEFINED_ERR);
> +				if (ret)
> +					dev_err(dev, "Error sending completion event (%d)\n",
> +						MHI_EV_CC_UNDEFINED_ERR);

Print the value of ret in the above message (not UNDEFINED_ERR).

> +
> +				goto err_unlock;
> +			}
> +		}
> +
> +		/* Enable DB for the channel */
> +		mhi_ep_mmio_enable_chdb_a7(mhi_cntrl, ch_id);

If an error occurs later, this will be enabled.  Is that what
you want?  Maybe wait to enable the doorbell until everything
else succeeds.

> +
> +		/* Set channel state to RUNNING */
> +		mhi_chan->state = MHI_CH_STATE_RUNNING;
> +		tmp = le32_to_cpu(mhi_cntrl->ch_ctx_cache[ch_id].chcfg);
> +		tmp &= ~CHAN_CTX_CHSTATE_MASK;
> +		tmp |= FIELD_PREP(CHAN_CTX_CHSTATE_MASK, MHI_CH_STATE_RUNNING);
> +		mhi_cntrl->ch_ctx_cache[ch_id].chcfg = cpu_to_le32(tmp);
> +
> +		ret = mhi_ep_send_cmd_comp_event(mhi_cntrl, MHI_EV_CC_SUCCESS);
> +		if (ret) {
> +			dev_err(dev, "Error sending command completion event (%d)\n",
> +				MHI_EV_CC_SUCCESS);
> +			goto err_unlock;
> +		}
> +
> +		mutex_unlock(&mhi_chan->lock);
> +
> +		/*
> +		 * Create MHI device only during UL channel start. Since the MHI
> +		 * channels operate in a pair, we'll associate both UL and DL
> +		 * channels to the same device.
> +		 *
> +		 * We also need to check for mhi_dev != NULL because, the host
> +		 * will issue START_CHAN command during resume and we don't
> +		 * destroy the device during suspend.
> +		 */
> +		if (!(ch_id % 2) && !mhi_chan->mhi_dev) {
> +			ret = mhi_ep_create_device(mhi_cntrl, ch_id);
> +			if (ret) {

If this occurs, the host will already have been told the
request completed successfully.  Is that a problem that
can/should be avoided?

> +				dev_err(dev, "Error creating device for channel (%d)\n", ch_id);
> +				return ret;
> +			}
> +		}
> +
> +		break;
> +	case MHI_PKT_TYPE_STOP_CHAN_CMD:
> +		dev_dbg(dev, "Received STOP command for channel (%d)\n", ch_id);
> +		if (!ch_ring->started) {
> +			dev_err(dev, "Channel (%d) not opened\n", ch_id);
> +			return -ENODEV;
> +		}
> +
> +		mutex_lock(&mhi_chan->lock);
> +		/* Disable DB for the channel */
> +		mhi_ep_mmio_disable_chdb_a7(mhi_cntrl, ch_id);
> +
> +		/* Send channel disconnect status to client drivers */
> +		result.transaction_status = -ENOTCONN;
> +		result.bytes_xferd = 0;
> +		mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
> +
> +		/* Set channel state to STOP */
> +		mhi_chan->state = MHI_CH_STATE_STOP;
> +		tmp = le32_to_cpu(mhi_cntrl->ch_ctx_cache[ch_id].chcfg);
> +		tmp &= ~CHAN_CTX_CHSTATE_MASK;
> +		tmp |= FIELD_PREP(CHAN_CTX_CHSTATE_MASK, MHI_CH_STATE_STOP);
> +		mhi_cntrl->ch_ctx_cache[ch_id].chcfg = cpu_to_le32(tmp);
> +
> +		ret = mhi_ep_send_cmd_comp_event(mhi_cntrl, MHI_EV_CC_SUCCESS);
> +		if (ret) {
> +			dev_err(dev, "Error sending command completion event (%d)\n",
> +				MHI_EV_CC_SUCCESS);
> +			goto err_unlock;
> +		}
> +
> +		mutex_unlock(&mhi_chan->lock);
> +		break;
> +	case MHI_PKT_TYPE_RESET_CHAN_CMD:
> +		dev_dbg(dev, "Received STOP command for channel (%d)\n", ch_id);
> +		if (!ch_ring->started) {
> +			dev_err(dev, "Channel (%d) not opened\n", ch_id);
> +			return -ENODEV;
> +		}
> +
> +		mutex_lock(&mhi_chan->lock);
> +		/* Stop and reset the transfer ring */
> +		mhi_ep_ring_reset(mhi_cntrl, ch_ring);
> +
> +		/* Send channel disconnect status to client driver */
> +		result.transaction_status = -ENOTCONN;
> +		result.bytes_xferd = 0;
> +		mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
> +
> +		/* Set channel state to DISABLED */
> +		mhi_chan->state = MHI_CH_STATE_DISABLED;
> +		tmp = le32_to_cpu(mhi_cntrl->ch_ctx_cache[ch_id].chcfg);
> +		tmp &= ~CHAN_CTX_CHSTATE_MASK;
> +		tmp |= FIELD_PREP(CHAN_CTX_CHSTATE_MASK, MHI_CH_STATE_DISABLED);
> +		mhi_cntrl->ch_ctx_cache[ch_id].chcfg = cpu_to_le32(tmp);
> +
> +		ret = mhi_ep_send_cmd_comp_event(mhi_cntrl, MHI_EV_CC_SUCCESS);
> +		if (ret) {
> +			dev_err(dev, "Error sending command completion event (%d)\n",
> +				MHI_EV_CC_SUCCESS);
> +			goto err_unlock;
> +		}
> +
> +		mutex_unlock(&mhi_chan->lock);
> +		break;
> +	default:
> +		dev_err(dev, "Invalid command received: %d for channel (%d)\n",
> +			MHI_TRE_GET_CMD_TYPE(el), ch_id);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +
> +err_unlock:
> +	mutex_unlock(&mhi_chan->lock);
> +
> +	return ret;
> +}
> +
>   static int mhi_ep_cache_host_cfg(struct mhi_ep_cntrl *mhi_cntrl)
>   {
>   	struct device *dev = &mhi_cntrl->mhi_dev->dev;

