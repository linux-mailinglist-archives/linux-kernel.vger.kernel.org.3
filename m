Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2634B9C84
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 10:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238884AbiBQJxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 04:53:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238878AbiBQJxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 04:53:40 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7CCB0EB2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 01:53:25 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id n19-20020a17090ade9300b001b9892a7bf9so8928824pjv.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 01:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lmIsIBblKAW0X/CfLZXrJaii643DzdyL4PqmGD4lPJc=;
        b=yxDmCYsLkl6a4NEL4s2RIdKDrqOpfQBwC2DORfc0svGXRIgSZXUh8iVhtaTforc2cu
         9EeNcoBxKqLcKD/9VhOhyXigiid7j6uXuLGkdC7V1/cq3HjGZeaGpMHHCnze6WXFAGth
         2YlE7DvVwNzS0M1yQ7h3Z9JN4DXw/TtRSGuXN2UxbXwArJI6D0jZpsLsEs/HLjnFmyKn
         z7c9mCZJCWUY9V/ORzJKFrCBfHBL8AyxcahvlvE8SqWnNadznOJxYafsSA9A96yc97zz
         yqZVAVp9kq/aY34iV9n/Z0Ve3py1XN7YQYLAgn5nmgga+YkcMJ27qtCMwZZM0R7nxiLB
         MTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lmIsIBblKAW0X/CfLZXrJaii643DzdyL4PqmGD4lPJc=;
        b=NdzGrLK3gXlc5PUWPsooB1xeV6e7wcfrXr2Q+B7Yu7Yi2ESv80s+5kRz8AyC0XIu7/
         LEs3sHY2G3YxOEUaRdOS4phYs/4Xy5tfJkI5vXgojqs+bEL8zE6/Lg9oEC+LPYZiSETk
         vOHK5iu9mX4Uf/osd+QaoHK444AKXSG+X9VzsGodEQjq5KcCJjq81Bt6SGzxaIo0H0Zp
         59r9xhj9LHebtYS/um4LH3qaULdMLTD7/ODKC9dXtm8GEw5roiQKucPiXDnQ709cB4sk
         eRuTOsoGoH0byMlTYBo+not/XyukWXnpopH2HE+iqknn4fL1nVxawry5LFmgn676bRu2
         6FhQ==
X-Gm-Message-State: AOAM530TjezImqBYmhnD1sxoKXif7Uo5B8DP39z9y/sRQucK7GSRK7xd
        56w46RvIkKFxFSxh5VBqHqK+
X-Google-Smtp-Source: ABdhPJxG7lKpGFzqlOJWBLCdpuGI46+qOePrLiXQ3VPvSGslAtVIr37Bl6iFtmNg/z4O0O6WLk9hMg==
X-Received: by 2002:a17:902:f605:b0:14f:5d75:4fb0 with SMTP id n5-20020a170902f60500b0014f5d754fb0mr2068752plg.101.1645091604859;
        Thu, 17 Feb 2022 01:53:24 -0800 (PST)
Received: from workstation ([117.193.211.41])
        by smtp.gmail.com with ESMTPSA id f16sm2160620pfe.52.2022.02.17.01.53.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Feb 2022 01:53:24 -0800 (PST)
Date:   Thu, 17 Feb 2022 15:23:19 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     mhi@lists.linux.dev, quic_hemantk@quicinc.com,
        quic_bbhatt@quicinc.com, quic_jhugo@quicinc.com,
        vinod.koul@linaro.org, bjorn.andersson@linaro.org,
        dmitry.baryshkov@linaro.org, quic_vbadigan@quicinc.com,
        quic_cang@quicinc.com, quic_skananth@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/25] bus: mhi: ep: Add support for registering MHI
 endpoint controllers
Message-ID: <20220217095319.GA11964@workstation>
References: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
 <20220212182117.49438-9-manivannan.sadhasivam@linaro.org>
 <4cc78936-b419-4738-b5b2-65c53be06f33@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cc78936-b419-4738-b5b2-65c53be06f33@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 02:02:41PM -0600, Alex Elder wrote:

[...]

> > +#define MHI_REG_OFFSET				0x100
> > +#define BHI_REG_OFFSET				0x200
> 
> Rather than defining the REG_OFFSET values here and adding
> them to every definition below, why not have the base
> address used (e.g., in mhi_write_reg_field()) be adjusted
> by the constant amount?
> 
> I'm just looking at mhi_init_mmio() (in the existing code)
> as an example, but for example, the base address used
> comes from mhi_cntrl->regs.  Can you instead just define
> a pointer somewhere that is the base of the MHI register
> range, which is already offset by the appropriate amount?
> 

I've defined two set of APIs for MHI and BHI read/write. They will add the
respective offsets.

> > +

[...]

> > +/* Generic context */
> > +struct mhi_generic_ctx {
> > +	__u32 reserved0;
> > +	__u32 reserved1;
> > +	__u32 reserved2;
> > +
> > +	__u64 rbase __packed __aligned(4);
> > +	__u64 rlen __packed __aligned(4);
> > +	__u64 rp __packed __aligned(4);
> > +	__u64 wp __packed __aligned(4);
> > +};
> 
> I'm pretty sure this constitutes an external interface, so
> every field should have its endianness annotated.
> 
> Mentioned elsewhere, I think you can define the structure
> with those attributes rather than the multiple fields.
> 

As I said before, this was suggested by Arnd during MHI host review. He
suggested adding the alignment and packed to only members that require
them.

But I think I should change it now...

> > +
> > +enum mhi_ep_ring_type {
> > +	RING_TYPE_CMD = 0,
> > +	RING_TYPE_ER,
> > +	RING_TYPE_CH,
> > +};
> > +
> > +struct mhi_ep_ring_element {
> > +	u64 ptr;
> > +	u32 dword[2];
> > +};
> 
> Are these host resident rings?  Even if not, this is an external
> interface, so this should be defined with explicit endianness.
> The cpu_to_le64() call will be a no-op so there is no cost
> to correcting this.
> 

Ah, this should be reusing the "struct mhi_tre" defined in host. Will do.

> > +
> > +/* Ring element */
> > +union mhi_ep_ring_ctx {
> > +	struct mhi_cmd_ctxt cmd;
> > +	struct mhi_event_ctxt ev;
> > +	struct mhi_chan_ctxt ch;
> > +	struct mhi_generic_ctx generic;
> > +};
> > +
> > +struct mhi_ep_ring {
> > +	struct mhi_ep_cntrl *mhi_cntrl;
> > +	int (*ring_cb)(struct mhi_ep_ring *ring, struct mhi_ep_ring_element *el);
> > +	union mhi_ep_ring_ctx *ring_ctx;
> > +	struct mhi_ep_ring_element *ring_cache;
> > +	enum mhi_ep_ring_type type;
> > +	size_t rd_offset;
> > +	size_t wr_offset;
> > +	size_t ring_size;
> > +	u32 db_offset_h;
> > +	u32 db_offset_l;
> > +	u32 ch_id;
> > +};
> 
> Not sure about the db_offset fields, etc. here, but it's possible
> they need endianness annotations.  I'm going to stop making this
> comment; please make sure anything that's exposed to the host
> specifies that it's little endian.  (The host and endpoint should
> have a common definition of these shared structures anyway; maybe
> I'm misreading this or assuming something incorrectly.)
> 

db_offset_* just holds the register offsets so they don't require
endianness annotation. All MMIO read/write are using readl/writel APIs
and they handle the endianness conversion implicitly.

Rest of the host memory accesses are annotated properly.

> > +

[...]

> > +	/*
> > +	 * Allocate max_channels supported by the MHI endpoint and populate
> > +	 * only the defined channels
> > +	 */
> > +	mhi_cntrl->mhi_chan = kcalloc(mhi_cntrl->max_chan, sizeof(*mhi_cntrl->mhi_chan),
> > +				      GFP_KERNEL);
> > +	if (!mhi_cntrl->mhi_chan)
> > +		return -ENOMEM;
> > +
> > +	for (i = 0; i < config->num_channels; i++) {
> > +		struct mhi_ep_chan *mhi_chan;
> 
> This entire block could be encapsulated in mhi_channel_add()
> or something,

Wrapping up in a function is useful if the same code is used in
different places. But I don't think it adds any value here.

> 
> > +		ch_cfg = &config->ch_cfg[i];
> 
> Move the above assignment down a few lines, to just before
> where it's used.
> 

No, ch_cfg is used just below this.

> > +
> > +		chan = ch_cfg->num;
> > +		if (chan >= mhi_cntrl->max_chan) {
> > +			dev_err(dev, "Channel %d not available\n", chan);
> 
> Maybe report the maximum channel so it's obvious why it's
> not available.
> 
> > +			goto error_chan_cfg;
> > +		}
> > +
> > +		/* Bi-directional and direction less channels are not supported */
> > +		if (ch_cfg->dir == DMA_BIDIRECTIONAL || ch_cfg->dir == DMA_NONE) {
> > +			dev_err(dev, "Invalid channel configuration\n");
> 
> Maybe be more specific in your message about what's wrong here.
> 
> > +			goto error_chan_cfg;
> > +		}
> > +
> > +		mhi_chan = &mhi_cntrl->mhi_chan[chan];
> > +		mhi_chan->name = ch_cfg->name;
> > +		mhi_chan->chan = chan;
> > +		mhi_chan->dir = ch_cfg->dir;
> > +		mutex_init(&mhi_chan->lock);
> > +	}
> > +
> > +	return 0;
> > +
> > +error_chan_cfg:
> > +	kfree(mhi_cntrl->mhi_chan);
> 
> I'm not sure what the caller does, but maybe null this
> after it's freed, or don't assign mhi_cntrll->mhi_chan
> until the initialization is successful.
> 

This is not required here as there will be no access to the pointer
after failing.

> 
> > +	return ret;
> > +}
> > +
> > +/*
> > + * Allocate channel and command rings here. Event rings will be allocated
> > + * in mhi_ep_power_up() as the config comes from the host.
> > + */
> > +int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
> > +				const struct mhi_ep_cntrl_config *config)
> > +{
> > +	struct mhi_ep_device *mhi_dev;
> > +	int ret;
> > +
> > +	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev)
> > +		return -EINVAL;
> > +
> > +	ret = parse_ch_cfg(mhi_cntrl, config);
> > +	if (ret)
> > +		return ret;
> > +
> > +	mhi_cntrl->mhi_cmd = kcalloc(NR_OF_CMD_RINGS, sizeof(*mhi_cntrl->mhi_cmd), GFP_KERNEL);
> 
> I said before I thought it was silly to even define NR_OF_CMD_RINGS.
> Does the MHI specification actually allow more than one command
> ring for a given MHI controller?  Ever?
> 

MHI spec doesn't limit the number of command rings. Eventhough I don't
envision adding more command rings in the future, I'm going to keep this
macro for now as the MHI host does the same.

[...]

> > diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
> > new file mode 100644
> > index 000000000000..20238e9df1b3
> > --- /dev/null
> > +++ b/include/linux/mhi_ep.h

[...]

> > +struct mhi_ep_device {
> > +	struct device dev;
> > +	struct mhi_ep_cntrl *mhi_cntrl;
> > +	const struct mhi_device_id *id;
> > +	const char *name;
> > +	struct mhi_ep_chan *ul_chan;
> > +	struct mhi_ep_chan *dl_chan;
> > +	enum mhi_device_type dev_type;
> 
> There are two device types, controller and transfer.  Unless
> there is ever going to be anything more than that, I think
> the distinction is better represented as a Boolean, such as:
> 
> 	bool controller;

Again, this is how it is done in MHI host also. Since I'm going to
maintain both stacks, it makes it easier for me if similarities are
maintained. But I'll keep this suggestion and the one above for later.

Thanks,
Mani
