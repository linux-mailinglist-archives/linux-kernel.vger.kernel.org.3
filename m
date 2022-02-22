Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F434BFB00
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 15:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbiBVOjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 09:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbiBVOi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 09:38:58 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A994E4DF6E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 06:38:32 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id v4so18705595pjh.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 06:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GdNESGAYnggKJpJiijh4S9vzX+uCdLNrQ6NluL3JdoA=;
        b=IEon9R3z+ocvwbvLWf0JV8sifD88RrbTiR6iamfDR8lButPGg9lzCX5nlgsN2kFu/p
         PRhcLkBR04Z6nAyOHwecnCGkiXOQxovkuow5vY/JPwdoJAt1wU9jF5B6xiTlGAD7Y1f5
         BRZZyEIZN+ckJVqkQtsQL9sJKOGa4xC61omEHyyAZeQW+FFhYNbqMHmdu2VXwUpIZv/a
         FV7iQe6sSFsdq/UT5f8cyPfYyT1SI787HV+SSeCtoznlk7GXhkfFe+6f9sUoJKgp5lcT
         1SNvnJSPFPmrgjhCpD/klGlveW/Ml8dlujlCrwAi1R88pfBG6O5rdR54xzFPrKB4prBC
         Mgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GdNESGAYnggKJpJiijh4S9vzX+uCdLNrQ6NluL3JdoA=;
        b=Uy+P0y/plh9Ih4K0Fmhb3TmW8aw5JEdN7weuA9utEG6WNMDLuUtDthhBFsDL8V7bUM
         qdj4M3QysFrcPyp0EkJtwQojRhf5TcRV8zEyi7tmDEkyVxfB13JMyTAl7IdOJPfcbbs5
         4kLbGG5KoAKaA4+Q0clgyogL+iRAf7uUBdMG2Ruh+mBaWxClmlISsHacuxmBOQffmyAl
         clR570BA/0XfXl76D0VsSlTe4LW7dYAGy6xRkon8rLVMrqBThnhR3cb9249R8g/nSrqH
         j6VB3yC0+KxLjxY4zZEoherVohKv/rlDOWd/VQ6jrvMIYeOkNIB+zQUSafZE5chbzA+u
         OLJA==
X-Gm-Message-State: AOAM533moeliPho95K2zjo3yw+BX8Wu61wbQREsjaPTmU2Blq82PIFqi
        kGKK3Ls/ujCpSQLhNLvn091p
X-Google-Smtp-Source: ABdhPJxVL1yJ+jHsMKViEQIZWuX+YqfYVcdCnfbo+s68aK+kiS6owg/rfxJ+w7tDrAPpKNoLpZ8/PA==
X-Received: by 2002:a17:903:2451:b0:14f:b91:fe3c with SMTP id l17-20020a170903245100b0014f0b91fe3cmr24146090pls.120.1645540712069;
        Tue, 22 Feb 2022 06:38:32 -0800 (PST)
Received: from thinkpad ([117.217.186.202])
        by smtp.gmail.com with ESMTPSA id l8sm21942913pgt.77.2022.02.22.06.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 06:38:31 -0800 (PST)
Date:   Tue, 22 Feb 2022 20:08:25 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     mhi@lists.linux.dev, quic_hemantk@quicinc.com,
        quic_bbhatt@quicinc.com, quic_jhugo@quicinc.com,
        vinod.koul@linaro.org, bjorn.andersson@linaro.org,
        dmitry.baryshkov@linaro.org, quic_vbadigan@quicinc.com,
        quic_cang@quicinc.com, quic_skananth@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 23/25] bus: mhi: ep: Add support for queueing SKBs to
 the host
Message-ID: <20220222143825.GH5029@thinkpad>
References: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
 <20220212182117.49438-24-manivannan.sadhasivam@linaro.org>
 <766e6568-0b80-c745-dd8f-7f401fb0422d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <766e6568-0b80-c745-dd8f-7f401fb0422d@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 04:40:29PM -0600, Alex Elder wrote:
> On 2/12/22 12:21 PM, Manivannan Sadhasivam wrote:
> > Add support for queueing SKBs to the host over the transfer ring of the
> > relevant channel. The mhi_ep_queue_skb() API will be used by the client
> > networking drivers to queue the SKBs to the host over MHI bus.
> > 
> > The host will add ring elements to the transfer ring periodically for
> > the device and the device will write SKBs to the ring elements. If a
> > single SKB doesn't fit in a ring element (TRE), it will be placed in
> > multiple ring elements and the overflow event will be sent for all ring
> > elements except the last one. For the last ring element, the EOT event
> > will be sent indicating the packet boundary.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> I'm a little confused by this, so maybe you can provide
> a better explanation somehow.
> 
> 					-Alex
> 
> > ---
> >   drivers/bus/mhi/ep/main.c | 102 ++++++++++++++++++++++++++++++++++++++
> >   include/linux/mhi_ep.h    |  13 +++++
> >   2 files changed, 115 insertions(+)
> > 
> > diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> > index baf383a4857b..e4186b012257 100644
> > --- a/drivers/bus/mhi/ep/main.c
> > +++ b/drivers/bus/mhi/ep/main.c
> > @@ -488,6 +488,108 @@ int mhi_ep_process_tre_ring(struct mhi_ep_ring *ring, struct mhi_ep_ring_element
> >   	return 0;
> >   }
> > +int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, enum dma_data_direction dir,
> > +		     struct sk_buff *skb, size_t len, enum mhi_flags mflags)
> 
> Why are both skb and len supplied?  Will an skb be supplied
> without wanting to send all of it?  Must len be less than
> skb->len?  I'm a little confused about the interface.
> 
> Also, the data direction is *out*, right?  You'll never
> be queueing a "receive" SKB?
> 

This was done to be compatible with the MHI host API where the host can queue
SKBs in both directions. But I think I should stop doing this.

> > +{
> > +	struct mhi_ep_chan *mhi_chan = (dir == DMA_FROM_DEVICE) ? mhi_dev->dl_chan :
> > +								mhi_dev->ul_chan;
> > +	struct mhi_ep_cntrl *mhi_cntrl = mhi_dev->mhi_cntrl;
> > +	struct device *dev = &mhi_chan->mhi_dev->dev;
> > +	struct mhi_ep_ring_element *el;
> > +	struct mhi_ep_ring *ring;
> > +	size_t bytes_to_write;
> > +	enum mhi_ev_ccs code;
> > +	void *read_from_loc;
> > +	u32 buf_remaining;
> > +	u64 write_to_loc;
> > +	u32 tre_len;
> > +	int ret = 0;
> > +
> > +	if (dir == DMA_TO_DEVICE)
> > +		return -EINVAL;
> 
> Can't you just preclude this from happening, or
> know it won't happen by inspection?
> 
> > +
> > +	buf_remaining = len;
> > +	ring = &mhi_cntrl->mhi_chan[mhi_chan->chan].ring;
> > +
> > +	mutex_lock(&mhi_chan->lock);
> > +
> > +	do {
> > +		/* Don't process the transfer ring if the channel is not in RUNNING state */
> > +		if (mhi_chan->state != MHI_CH_STATE_RUNNING) {
> > +			dev_err(dev, "Channel not available\n");
> > +			ret = -ENODEV;
> > +			goto err_exit;
> > +		}
> > +
> 
> It would be nice if the caller could know whether there
> was enough room *before* you start transferring things.
> It's probably a lot of work to get to that point though.
> 

No, the caller will do this check but the check is included here so that we
don't run out of buffers when the packet needs to be splitted.

> > +		if (mhi_ep_queue_is_empty(mhi_dev, dir)) {
> > +			dev_err(dev, "TRE not available!\n");
> > +			ret = -EINVAL;
> > +			goto err_exit;
> > +		}
> > +
> > +		el = &ring->ring_cache[ring->rd_offset];
> > +		tre_len = MHI_EP_TRE_GET_LEN(el);
> > +		if (skb->len > tre_len) {
> > +			dev_err(dev, "Buffer size (%d) is too large for TRE (%d)!\n",
> > +				skb->len, tre_len);
> 
> This means the receive buffer must be big enough to hold
> any incoming SKB.  This is *without* checking for the
> CHAIN flag in the TRE, so what you describe in the
> patch description seems not to be true.  I.e., multiple
> TREs in a TRD will *not* be consumed if the SKB data
> requires more than what's left in the current TRE.
> 

I think I removed this check for v3 but somehow the change got lost :/

But anyway, there is no need to check for CHAIN flag while writing to host.
CHAIN flag is only used or even make sense when host writes data to device, so
that it knows the packet boundary and could use the CHAIN flag to tell the
device where the boundary lies.

But when the device writes to host, it already has the pre-queued elements from
host that has no idea where the packet boundary lies. So the host would've set
only EOT on all TREs and expects the device to send OVERFLOW event for TREs that
don't have the complete packet. Then finally, when device sends EOT event, the
host will detect the boundary.

Thanks,
Mani
