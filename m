Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031C14B7AA5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243973AbiBOWlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:41:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244640AbiBOWko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:40:44 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48122C249B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:40:31 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id x13so241537iop.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Gn3EIklOnIG2tkcpFpUKroOkFa8PWu0ikEpLWQKkSxA=;
        b=MS8D4rvahPgLiydnJDPOq0ZvTiIFx587xA0Y5Cs6xoBVrb1JcEtTJu3L1MZ2uirVnv
         7gqbYQA4jQ0+96ZkeiQHVcd/s9nL5UoXilCyi9sGytY97J60DwH55NjZEV64DO653Jn4
         0qkWhQKWsC4ux3PUj5SK8nE+3xOzkgmSsC8DyGlw1/a3my3DHz3b4WfcjTIQpLcFHDx+
         +zub+L35PMLwfzdVZD5lEU8kh5oD2khSCjqDdHkKRGrPQigUTf4Z5DzYjsEJKjjrqEeQ
         1WX2nmFZ262ZCopwtHr0PBl+zTolIGxJO7GpXMD/2zvqLAAAq9VLFKvovK3hv+dDxCRx
         X41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Gn3EIklOnIG2tkcpFpUKroOkFa8PWu0ikEpLWQKkSxA=;
        b=ZJAksgFEopylTxY6Q9ZwUJ5jxSwwGcDlmy1rnx+4v9idxPBbpNHH5NIqQi9qyqDdKb
         3abqkZEaVMXnTat2zREqs6SXlMZ480ohDV+N/2Nc8aJIHqeCuJ7XXZOiXE040+C0jGLw
         ycZvSCRBgGKWQzLHcYkYJG+rWxCdr1ihuVJufUYvMo9wnAGIFQw+FxCPhZX8JelLgVE1
         NpgZcENRhoUBL61OMb5W818xh+mLyzVO8bRUt86rL70ogaB5n5qAhQQKSj1Z54MUWYOH
         EM9plv7KvYLXE3QK7zJIsTw3af6DMe3p19BBLPEx3X4kt1oh3y+nS7Mo2VdUyBr3a9hK
         /2QA==
X-Gm-Message-State: AOAM533qEqIT9E7UuRMECBca0Ax8Sra0SQ68EVtxTfxf+kvcbZWZb/Ca
        cB7Qbux8i6qt7fm4bKO0wVWPSw==
X-Google-Smtp-Source: ABdhPJzexSR3WzZVJEbJjdXcTfGZuHlWw9A8dLI6/quoJY6Fja96InlxvKwSBegbn7O3t7L44uRSLQ==
X-Received: by 2002:a02:954f:: with SMTP id y73mr694414jah.252.1644964830569;
        Tue, 15 Feb 2022 14:40:30 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id l2sm5996859ilv.66.2022.02.15.14.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 14:40:30 -0800 (PST)
Message-ID: <766e6568-0b80-c745-dd8f-7f401fb0422d@linaro.org>
Date:   Tue, 15 Feb 2022 16:40:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 23/25] bus: mhi: ep: Add support for queueing SKBs to
 the host
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
 <20220212182117.49438-24-manivannan.sadhasivam@linaro.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220212182117.49438-24-manivannan.sadhasivam@linaro.org>
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
> Add support for queueing SKBs to the host over the transfer ring of the
> relevant channel. The mhi_ep_queue_skb() API will be used by the client
> networking drivers to queue the SKBs to the host over MHI bus.
> 
> The host will add ring elements to the transfer ring periodically for
> the device and the device will write SKBs to the ring elements. If a
> single SKB doesn't fit in a ring element (TRE), it will be placed in
> multiple ring elements and the overflow event will be sent for all ring
> elements except the last one. For the last ring element, the EOT event
> will be sent indicating the packet boundary.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

I'm a little confused by this, so maybe you can provide
a better explanation somehow.

					-Alex

> ---
>   drivers/bus/mhi/ep/main.c | 102 ++++++++++++++++++++++++++++++++++++++
>   include/linux/mhi_ep.h    |  13 +++++
>   2 files changed, 115 insertions(+)
> 
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index baf383a4857b..e4186b012257 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -488,6 +488,108 @@ int mhi_ep_process_tre_ring(struct mhi_ep_ring *ring, struct mhi_ep_ring_element
>   	return 0;
>   }
>   
> +int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, enum dma_data_direction dir,
> +		     struct sk_buff *skb, size_t len, enum mhi_flags mflags)

Why are both skb and len supplied?  Will an skb be supplied
without wanting to send all of it?  Must len be less than
skb->len?  I'm a little confused about the interface.

Also, the data direction is *out*, right?  You'll never
be queueing a "receive" SKB?

> +{
> +	struct mhi_ep_chan *mhi_chan = (dir == DMA_FROM_DEVICE) ? mhi_dev->dl_chan :
> +								mhi_dev->ul_chan;
> +	struct mhi_ep_cntrl *mhi_cntrl = mhi_dev->mhi_cntrl;
> +	struct device *dev = &mhi_chan->mhi_dev->dev;
> +	struct mhi_ep_ring_element *el;
> +	struct mhi_ep_ring *ring;
> +	size_t bytes_to_write;
> +	enum mhi_ev_ccs code;
> +	void *read_from_loc;
> +	u32 buf_remaining;
> +	u64 write_to_loc;
> +	u32 tre_len;
> +	int ret = 0;
> +
> +	if (dir == DMA_TO_DEVICE)
> +		return -EINVAL;

Can't you just preclude this from happening, or
know it won't happen by inspection?

> +
> +	buf_remaining = len;
> +	ring = &mhi_cntrl->mhi_chan[mhi_chan->chan].ring;
> +
> +	mutex_lock(&mhi_chan->lock);
> +
> +	do {
> +		/* Don't process the transfer ring if the channel is not in RUNNING state */
> +		if (mhi_chan->state != MHI_CH_STATE_RUNNING) {
> +			dev_err(dev, "Channel not available\n");
> +			ret = -ENODEV;
> +			goto err_exit;
> +		}
> +

It would be nice if the caller could know whether there
was enough room *before* you start transferring things.
It's probably a lot of work to get to that point though.

> +		if (mhi_ep_queue_is_empty(mhi_dev, dir)) {
> +			dev_err(dev, "TRE not available!\n");
> +			ret = -EINVAL;
> +			goto err_exit;
> +		}
> +
> +		el = &ring->ring_cache[ring->rd_offset];
> +		tre_len = MHI_EP_TRE_GET_LEN(el);
> +		if (skb->len > tre_len) {
> +			dev_err(dev, "Buffer size (%d) is too large for TRE (%d)!\n",
> +				skb->len, tre_len);

This means the receive buffer must be big enough to hold
any incoming SKB.  This is *without* checking for the
CHAIN flag in the TRE, so what you describe in the
patch description seems not to be true.  I.e., multiple
TREs in a TRD will *not* be consumed if the SKB data
requires more than what's left in the current TRE.

But you have some other code below, so it's likely I'm
just misunderstanding this.

> +			ret = -ENOMEM;
> +			goto err_exit;
> +		}
> +
> +		bytes_to_write = min(buf_remaining, tre_len);
> +		read_from_loc = skb->data;
> +		write_to_loc = MHI_EP_TRE_GET_PTR(el);
> +
> +		ret = mhi_cntrl->write_to_host(mhi_cntrl, read_from_loc, write_to_loc,
> +					       bytes_to_write);
> +		if (ret < 0)
> +			goto err_exit;
> +
> +		buf_remaining -= bytes_to_write;
> +		/*
> +		 * For all TREs queued by the host for DL channel, only the EOT flag will be set.
> +		 * If the packet doesn't fit into a single TRE, send the OVERFLOW event to
> +		 * the host so that the host can adjust the packet boundary to next TREs. Else send
> +		 * the EOT event to the host indicating the packet boundary.
> +		 */
> +		if (buf_remaining)
> +			code = MHI_EV_CC_OVERFLOW;
> +		else
> +			code = MHI_EV_CC_EOT;
> +
> +		ret = mhi_ep_send_completion_event(mhi_cntrl, ring, bytes_to_write, code);
> +		if (ret) {
> +			dev_err(dev, "Error sending completion event\n");
> +			goto err_exit;
> +		}
> +
> +		mhi_ep_ring_inc_index(ring);
> +	} while (buf_remaining);
> +
> +	/*
> +	 * During high network traffic, sometimes the DL doorbell interrupt from the host is missed
> +	 * by the endpoint. So manually check for the write pointer update here so that we don't run
> +	 * out of buffer due to missing interrupts.
> +	 */
> +	if (ring->rd_offset + 1 == ring->wr_offset) {
> +		ret = mhi_ep_update_wr_offset(ring);
> +		if (ret) {
> +			dev_err(dev, "Error updating write pointer\n");
> +			goto err_exit;
> +		}
> +	}
> +
> +	mutex_unlock(&mhi_chan->lock);
> +
> +	return 0;
> +
> +err_exit:
> +	mutex_unlock(&mhi_chan->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(mhi_ep_queue_skb);
> +
>   static int mhi_ep_cache_host_cfg(struct mhi_ep_cntrl *mhi_cntrl)
>   {
>   	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
> index aaf4b6942037..75cfbf0c6fb0 100644
> --- a/include/linux/mhi_ep.h
> +++ b/include/linux/mhi_ep.h
> @@ -277,4 +277,17 @@ void mhi_ep_power_down(struct mhi_ep_cntrl *mhi_cntrl);
>    */
>   bool mhi_ep_queue_is_empty(struct mhi_ep_device *mhi_dev, enum dma_data_direction dir);
>   
> +/**
> + * mhi_ep_queue_skb - Send SKBs to host over MHI Endpoint
> + * @mhi_dev: Device associated with the channels
> + * @dir: DMA direction for the channel
> + * @skb: Buffer for holding SKBs
> + * @len: Buffer length
> + * @mflags: MHI Endpoint transfer flags used for the transfer
> + *
> + * Return: 0 if the SKBs has been sent successfully, a negative error code otherwise.
> + */
> +int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, enum dma_data_direction dir,
> +		     struct sk_buff *skb, size_t len, enum mhi_flags mflags);
> +
>   #endif

