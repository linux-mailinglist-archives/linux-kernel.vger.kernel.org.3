Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9824BF609
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 11:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiBVKfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 05:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbiBVKff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 05:35:35 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED18115B3EA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 02:35:09 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id om7so17979398pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 02:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6n3VRa/D2GqDHXoAIdoTyfHyQ43B5WXlaWf6FDGebB8=;
        b=StqIqmVXW/v1Ki1c0Lzfr4M7dgO1nPOW5q1kB5ViTN15zBXaOlkzohWk9Bpp8etMt0
         R1aixOuKgsLlc8uXxlHM42QtEYgdbE3L+oEeEd+dRXr4GhPqB1I8P5E13NcIycvdrmeh
         G2GZLaH0VFMlTJDIHS5AXY5FGvgeatjH7lByRuJODgrv/EUIdUFmuVJ7gU05g27sx/7Z
         xEX1XmwkETnc6S18GLLWFAPiptYNeRdgZ+enPfSYxkIp6A+jXY5bfmTNJ+B8V1cX4jG2
         yY5X7ZfTwT8eTW+TFBcn+hkBhy9nVMbVSUE0Y98LR18bE4oRp9655UGFbQUmVENPPQ4d
         x5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6n3VRa/D2GqDHXoAIdoTyfHyQ43B5WXlaWf6FDGebB8=;
        b=HBSmwwHOKtVfk+u9ukldNN9bhzcZezzOETsy2HGxvIOKcyTQjX5+2qRQlGHRGesxK+
         +d3xo2Noge7ForMp9cKNw8C6E8h8f2skuVyT2rlCsEJePtv47fnPCl769eC91etJetUw
         WxJJYmPYSshAdu1HVcKVhqCHu0YZ9Vsnc41G46Py5hVwKGc/1iC6cL0a8UyhuVgA45Y1
         NfMY4XCC535m3bRywr5rS6ORlmfzy1RbCg7uHIK0iE/qwyeuojzGb69JmuIhWGABn68Z
         OEYCBLqyURQqPoEUM0Gys7uIkEF9ZV+bOp8ZONnX5XVz3KbdYP2ekRVVQ5GiAJum8xj8
         gvrQ==
X-Gm-Message-State: AOAM533xccOF150M0qZED825985l/6HNjwlakn6PVMFcaDAVxaT87/fw
        XoUhAOe1KkmyQE+y7yp7MvcP
X-Google-Smtp-Source: ABdhPJxiYqpf88KXSvuj96Qc4L/U4W4AlGzyaOMDS/LFG0Gps5+G30kp66V8Z/IGZ81OGm2Mu3MOUg==
X-Received: by 2002:a17:902:e88d:b0:14f:446b:264b with SMTP id w13-20020a170902e88d00b0014f446b264bmr22530782plg.166.1645526109352;
        Tue, 22 Feb 2022 02:35:09 -0800 (PST)
Received: from thinkpad ([117.217.186.202])
        by smtp.gmail.com with ESMTPSA id c9sm16944241pfv.70.2022.02.22.02.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 02:35:08 -0800 (PST)
Date:   Tue, 22 Feb 2022 16:05:02 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     mhi@lists.linux.dev, quic_hemantk@quicinc.com,
        quic_bbhatt@quicinc.com, quic_jhugo@quicinc.com,
        vinod.koul@linaro.org, bjorn.andersson@linaro.org,
        dmitry.baryshkov@linaro.org, quic_vbadigan@quicinc.com,
        quic_cang@quicinc.com, quic_skananth@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 20/25] bus: mhi: ep: Add support for processing
 command ring
Message-ID: <20220222103502.GF5029@thinkpad>
References: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
 <20220212182117.49438-21-manivannan.sadhasivam@linaro.org>
 <05956282-57f4-996b-13ae-282fb40e1578@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05956282-57f4-996b-13ae-282fb40e1578@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 04:40:01PM -0600, Alex Elder wrote:
> On 2/12/22 12:21 PM, Manivannan Sadhasivam wrote:
> > Add support for processing the command ring. Command ring is used by the
> > host to issue channel specific commands to the ep device. Following
> > commands are supported:
> > 
> > 1. Start channel
> > 2. Stop channel
> > 3. Reset channel
> > 
> > Once the device receives the command doorbell interrupt from host, it
> > executes the command and generates a command completion event to the
> > host in the primary event ring.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> I'll let you consider my few comments below, but whether or not you
> address them, this looks OK to me.
> 
> Reviewed-by: Alex Elder <elder@linaro.org>
> 
> > ---
> >   drivers/bus/mhi/ep/main.c | 151 ++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 151 insertions(+)
> > 
> > diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> > index 6378ac5c7e37..4c2ee517832c 100644
> > --- a/drivers/bus/mhi/ep/main.c
> > +++ b/drivers/bus/mhi/ep/main.c
> > @@ -21,6 +21,7 @@
> >   static DEFINE_IDA(mhi_ep_cntrl_ida);
> > +static int mhi_ep_create_device(struct mhi_ep_cntrl *mhi_cntrl, u32 ch_id);
> >   static int mhi_ep_destroy_device(struct device *dev, void *data);
> >   static int mhi_ep_send_event(struct mhi_ep_cntrl *mhi_cntrl, u32 ring_idx,
> > @@ -185,6 +186,156 @@ void mhi_ep_unmap_free(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr, phys_addr_t
> >   	mhi_cntrl->free_addr(mhi_cntrl, phys - offset, virt - offset, size);
> >   }
> > +int mhi_ep_process_cmd_ring(struct mhi_ep_ring *ring, struct mhi_ep_ring_element *el)
> > +{
> > +	struct mhi_ep_cntrl *mhi_cntrl = ring->mhi_cntrl;
> > +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> > +	struct mhi_result result = {};
> > +	struct mhi_ep_chan *mhi_chan;
> > +	struct mhi_ep_ring *ch_ring;
> > +	u32 tmp, ch_id;
> > +	int ret;
> > +
> > +	ch_id = MHI_TRE_GET_CMD_CHID(el);
> > +	mhi_chan = &mhi_cntrl->mhi_chan[ch_id];
> > +	ch_ring = &mhi_cntrl->mhi_chan[ch_id].ring;
> > +
> > +	switch (MHI_TRE_GET_CMD_TYPE(el)) {
> 
> No MHI_PKT_TYPE_NOOP_CMD?
> 

Not now.

> > +	case MHI_PKT_TYPE_START_CHAN_CMD:
> > +		dev_dbg(dev, "Received START command for channel (%d)\n", ch_id);
> > +
> > +		mutex_lock(&mhi_chan->lock);
> > +		/* Initialize and configure the corresponding channel ring */
> > +		if (!ch_ring->started) {
> > +			ret = mhi_ep_ring_start(mhi_cntrl, ch_ring,
> > +				(union mhi_ep_ring_ctx *)&mhi_cntrl->ch_ctx_cache[ch_id]);
> > +			if (ret) {
> > +				dev_err(dev, "Failed to start ring for channel (%d)\n", ch_id);
> > +				ret = mhi_ep_send_cmd_comp_event(mhi_cntrl,
> > +							MHI_EV_CC_UNDEFINED_ERR);
> > +				if (ret)
> > +					dev_err(dev, "Error sending completion event (%d)\n",
> > +						MHI_EV_CC_UNDEFINED_ERR);
> 
> Print the value of ret in the above message (not UNDEFINED_ERR).
> 
> > +
> > +				goto err_unlock;
> > +			}
> > +		}
> > +
> > +		/* Enable DB for the channel */
> > +		mhi_ep_mmio_enable_chdb_a7(mhi_cntrl, ch_id);
> 
> If an error occurs later, this will be enabled.  Is that what
> you want?  Maybe wait to enable the doorbell until everything
> else succeeds.
> 

Makes sense. Will move this to the end.

> > +
> > +		/* Set channel state to RUNNING */
> > +		mhi_chan->state = MHI_CH_STATE_RUNNING;
> > +		tmp = le32_to_cpu(mhi_cntrl->ch_ctx_cache[ch_id].chcfg);
> > +		tmp &= ~CHAN_CTX_CHSTATE_MASK;
> > +		tmp |= FIELD_PREP(CHAN_CTX_CHSTATE_MASK, MHI_CH_STATE_RUNNING);
> > +		mhi_cntrl->ch_ctx_cache[ch_id].chcfg = cpu_to_le32(tmp);
> > +
> > +		ret = mhi_ep_send_cmd_comp_event(mhi_cntrl, MHI_EV_CC_SUCCESS);
> > +		if (ret) {
> > +			dev_err(dev, "Error sending command completion event (%d)\n",
> > +				MHI_EV_CC_SUCCESS);
> > +			goto err_unlock;
> > +		}
> > +
> > +		mutex_unlock(&mhi_chan->lock);
> > +
> > +		/*
> > +		 * Create MHI device only during UL channel start. Since the MHI
> > +		 * channels operate in a pair, we'll associate both UL and DL
> > +		 * channels to the same device.
> > +		 *
> > +		 * We also need to check for mhi_dev != NULL because, the host
> > +		 * will issue START_CHAN command during resume and we don't
> > +		 * destroy the device during suspend.
> > +		 */
> > +		if (!(ch_id % 2) && !mhi_chan->mhi_dev) {
> > +			ret = mhi_ep_create_device(mhi_cntrl, ch_id);
> > +			if (ret) {
> 
> If this occurs, the host will already have been told the
> request completed successfully.  Is that a problem that
> can/should be avoided?
> 

This should result in SYSERR. Will handle.

Thanks,
Mani
