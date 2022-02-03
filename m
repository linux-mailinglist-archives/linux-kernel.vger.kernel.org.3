Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29E04A86FA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351517AbiBCOus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241471AbiBCOuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:50:46 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA8FC06173B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 06:50:46 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d1so2317431plh.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 06:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aNrP5HMmu87g74sdJo7YqVy+2Qcae9OtdN44K0i5/Hc=;
        b=mmPxdObEGo8KvDyASVPj53AiiWFGGjekW55fQ+LQTvC2Fm3vsvgABC8ltbL6U2uMTo
         CiD8vhwjkb2DuGncdr7BMN24opkf4dzOvY9IvNC+p+SMArYG14ALpGvCNICrt6/HxH5a
         7rTw3lYEsI5a90G2b6tMplv4ynzwObD96HbZNaB6lOwNITKB1fvfSGUBWOXbh9hKxmwS
         D5LNl0Lf3lsfTDc9p7Y7sO8jsLbAFEJEb1SWvZWzjC2bva3zbWo8fP4oDe9o1cBuDgCB
         2+3pFrlNn66LKDLxYUazHCFPiwkq29oWOmP+CQshlkpjGe6ANpwKnZU5aLPA6dmwV+MV
         NrBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aNrP5HMmu87g74sdJo7YqVy+2Qcae9OtdN44K0i5/Hc=;
        b=caGEot1I8091VEV3UaLjoFnsqA+LgCxCu4DY6OXkZiAJxF0PiykvV7cwSuUTdbi0rP
         1c3Dy0hSd+TYi1anAQQXguXNcDTZc2qvfibEqzFlvOvQAINWFSOE4jVudl/Pw1PjYlXO
         X0xwx5AisbtRXWhWNUv4MrV7acpJX4EGsl3udnfzx6o3kdMrjsgFAuxKVu9ZLPTCfqi1
         c93l+tEjSDhV7tVqozyTHnvBUsELQJNtJY+hKgEgGK2nxPDE2JiEf6Px6Gmcate/zrRY
         7DTc6C2hKc3xl8ezROTOG3biqnv/Tja427+CsxgTHokmHy7U98EasPp6yfJzAOoZmnQJ
         p6Ag==
X-Gm-Message-State: AOAM531U7fi58GGWPHPgnf49KZXHxvLqNsoTS9sV1zumRy8yaVyZq1z6
        hgttPJHw1C239Ti2yTcSqrPo
X-Google-Smtp-Source: ABdhPJzKib6axrTBdUQf5O+ncbRh+sDkmMgQfI4HcwkV/zLo7YvpYI4SHepDKd1AFLVJ5MTADZ0kVg==
X-Received: by 2002:a17:902:d4c6:: with SMTP id o6mr31385330plg.83.1643899846022;
        Thu, 03 Feb 2022 06:50:46 -0800 (PST)
Received: from thinkpad ([117.217.179.179])
        by smtp.gmail.com with ESMTPSA id 38sm37432068pgm.37.2022.02.03.06.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 06:50:44 -0800 (PST)
Date:   Thu, 3 Feb 2022 20:20:36 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Alex Elder <elder@ieee.org>
Cc:     mhi@lists.linux.dev, hemantk@codeaurora.org, bbhatt@codeaurora.org,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        skananth@codeaurora.org, vpernami@codeaurora.org,
        vbadigan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/20] bus: mhi: ep: Add support for registering MHI
 endpoint controllers
Message-ID: <20220203145036.GD6298@thinkpad>
References: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
 <20211202113553.238011-6-manivannan.sadhasivam@linaro.org>
 <dc338eb3-0c11-450f-bce0-9b515a969390@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc338eb3-0c11-450f-bce0-9b515a969390@ieee.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 06:26:51PM -0600, Alex Elder wrote:
> On 12/2/21 5:35 AM, Manivannan Sadhasivam wrote:
> > This commit adds support for registering MHI endpoint controller drivers
> > with the MHI endpoint stack. MHI endpoint controller drivers manages
> > the interaction with the host machines such as x86. They are also the
> > MHI endpoint bus master in charge of managing the physical link between the
> > host and endpoint device.
> > 
> > The endpoint controller driver encloses all information about the
> > underlying physical bus like PCIe. The registration process involves
> > parsing the channel configuration and allocating an MHI EP device.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> See below.  Lots of little things, some I've said before.
> 
> > ---
> >   drivers/bus/mhi/Kconfig       |   1 +
> >   drivers/bus/mhi/Makefile      |   3 +
> >   drivers/bus/mhi/ep/Kconfig    |  10 ++
> >   drivers/bus/mhi/ep/Makefile   |   2 +
> >   drivers/bus/mhi/ep/internal.h | 158 +++++++++++++++++++++++
> >   drivers/bus/mhi/ep/main.c     | 231 ++++++++++++++++++++++++++++++++++
> >   include/linux/mhi_ep.h        | 140 +++++++++++++++++++++
> >   7 files changed, 545 insertions(+)
> >   create mode 100644 drivers/bus/mhi/ep/Kconfig
> >   create mode 100644 drivers/bus/mhi/ep/Makefile
> >   create mode 100644 drivers/bus/mhi/ep/internal.h
> >   create mode 100644 drivers/bus/mhi/ep/main.c
> >   create mode 100644 include/linux/mhi_ep.h
> > 

[...]

> > +/* MHI register definitions */
> > +#define MHIREGLEN				0x100
> 
> I really think it would be nice if these could be common between the
> host and endpoint.
> 

done

> > +#define MHIVER					0x108
> > +#define MHICFG					0x110
> > +#define CHDBOFF					0x118
> > +#define ERDBOFF					0x120
> > +#define BHIOFF					0x128
> > +#define DEBUGOFF				0x130
> > +#define MHICTRL					0x138
> > +#define MHISTATUS				0x148
> > +#define CCABAP_LOWER				0x158
> > +#define CCABAP_HIGHER				0x15c
> > +#define ECABAP_LOWER				0x160
> > +#define ECABAP_HIGHER				0x164
> > +#define CRCBAP_LOWER				0x168
> > +#define CRCBAP_HIGHER				0x16c
> > +#define CRDB_LOWER				0x170
> > +#define CRDB_HIGHER				0x174
> > +#define MHICTRLBASE_LOWER			0x180
> > +#define MHICTRLBASE_HIGHER			0x184
> > +#define MHICTRLLIMIT_LOWER			0x188
> > +#define MHICTRLLIMIT_HIGHER			0x18c
> > +#define MHIDATABASE_LOWER			0x198
> > +#define MHIDATABASE_HIGHER			0x19c
> > +#define MHIDATALIMIT_LOWER			0x1a0
> > +#define MHIDATALIMIT_HIGHER			0x1a4
> 
> It wouldn't hurt to have a one or two line comment explaining how
> these compute the offset for a given channel or event ring's
> doorbell register.
> 
> I think you could use decimal for the multiplier (8 rather than 0x8),
> but maybe you prefer not mixing that with a hex base offset.
> 
> Overall though, take a look at the macros you define like this.
> See if you can decide on whether you can settle on a consistent
> form.  Some places you use decimal, others hex.  It's not a
> big deal, but consistency always helps.
> 

Will look.

> > +#define CHDB_LOWER_n(n)				(0x400 + 0x8 * (n))
> > +#define CHDB_HIGHER_n(n)			(0x404 + 0x8 * (n))
> > +#define ERDB_LOWER_n(n)				(0x800 + 0x8 * (n))
> > +#define ERDB_HIGHER_n(n)			(0x804 + 0x8 * (n))
> > +#define BHI_INTVEC				0x220
> > +#define BHI_EXECENV				0x228
> > +#define BHI_IMGTXDB				0x218
> > +
> 
> Will the AP always be an "A7"?
> 

That's the register defined in the register manual. So I'd like to keep it for
now.

> > +#define MHI_CTRL_INT_STATUS_A7			0x4
> > +#define MHI_CTRL_INT_STATUS_A7_MSK		BIT(0)
> > +#define MHI_CTRL_INT_STATUS_CRDB_MSK		BIT(1)
> > +#define MHI_CHDB_INT_STATUS_A7_n(n)		(0x28 + 0x4 * (n))
> > +#define MHI_ERDB_INT_STATUS_A7_n(n)		(0x38 + 0x4 * (n))
> > +
> > +#define MHI_CTRL_INT_CLEAR_A7			0x4c
> > +#define MHI_CTRL_INT_MMIO_WR_CLEAR		BIT(2)
> > +#define MHI_CTRL_INT_CRDB_CLEAR			BIT(1)
> > +#define MHI_CTRL_INT_CRDB_MHICTRL_CLEAR		BIT(0)
> > +
> > +#define MHI_CHDB_INT_CLEAR_A7_n(n)		(0x70 + 0x4 * (n))
> > +#define MHI_CHDB_INT_CLEAR_A7_n_CLEAR_ALL	GENMASK(31, 0)
> > +#define MHI_ERDB_INT_CLEAR_A7_n(n)		(0x80 + 0x4 * (n))
> > +#define MHI_ERDB_INT_CLEAR_A7_n_CLEAR_ALL	GENMASK(31, 0)
> > +
> 
> The term "MASK" here might be confusing.  Does a bit set in
> this mask register indicate an interrupt is enabled, or
> disabled (masked)?  A comment (here or where used) could
> clear it up without renaming the symbol.
> 

I agree that it is confusing but that's how the platform defines it. Will add a
comment though.

> > +#define MHI_CTRL_INT_MASK_A7			0x94
> > +#define MHI_CTRL_INT_MASK_A7_MASK_MASK		GENMASK(1, 0)
> > +#define MHI_CTRL_MHICTRL_MASK			BIT(0)
> > +#define MHI_CTRL_MHICTRL_SHFT			0
> > +#define MHI_CTRL_CRDB_MASK			BIT(1)
> > +#define MHI_CTRL_CRDB_SHFT			1
> 
> Use SHIFT or SHFT (not both), consistently.  (But get rid of
> this shift definition, and others like it...)
> 

Done

> > +#define MHI_CHDB_INT_MASK_A7_n(n)		(0xb8 + 0x4 * (n))
> > +#define MHI_CHDB_INT_MASK_A7_n_EN_ALL		GENMASK(31, 0)
> > +#define MHI_ERDB_INT_MASK_A7_n(n)		(0xc8 + 0x4 * (n))
> > +#define MHI_ERDB_INT_MASK_A7_n_EN_ALL		GENMASK(31, 0)
> > +
> > +#define NR_OF_CMD_RINGS				1
> 
> Is there ever any reason to believe there will be more than one
> command ring for a given MHI instance?  I kept seeing loops over
> NR_OF_CMD_RINGS, and it just seemed silly.
> 

It was added for future compatibility and the spec doesn't mention that there is
only one command ring.

> > +#define MHI_MASK_ROWS_CH_EV_DB			4
> > +#define MHI_MASK_CH_EV_LEN			32
> > +
> > +/* Generic context */
> 
> Maybe define the entire structure as packed and aligned.
> 

Justified in previous patch.

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
> Are these structures defined separately for host and endpoint?
> (I've lost track...  If they are, it would be better to define
> them in common.)
> 

Channel, Event and command contexts are common and they are already defined in
common.h. This one is specific to endpoint.

> > +
> > +enum mhi_ep_ring_state {
> > +	RING_STATE_UINT = 0,
> 
> I think "UINT" is a *terrible* abbreviation to represent
> "uninitialized".
> 
> > +	RING_STATE_IDLE,
> 
> Since there are only two states, uninitialized or idle, maybe
> you can get rid of this enum definition and just define the
> ring state with "bool initialized".
> 

okay

> > +};
> > +
> > +enum mhi_ep_ring_type {
> 
> Is the value 0 significant to hardware?  If not, there's no need
> to define the numeric value on this first symbol.
> 
> > +	RING_TYPE_CMD = 0,
> > +	RING_TYPE_ER,
> > +	RING_TYPE_CH,
> 
> I don't think you ever use RING_TYPE_INVALID, so it does
> not need to be defined.
> 

ack

> > +	RING_TYPE_INVALID,
> > +};
> > +
> 
> I prefer a more meaningful structure definition than this (as
> mentioned in I think the first patch).
> 
> > +struct mhi_ep_ring_element {
> > +	u64 ptr;
> > +	u32 dword[2];
> > +};
> > +
> > +/* Transfer ring element type */
> 
> Not transfer ring, just ring.  Command, transfer, and event
> ring descriptors are different things.
> 

ack

> > +union mhi_ep_ring_ctx {
> > +	struct mhi_cmd_ctxt cmd;
> > +	struct mhi_event_ctxt ev;
> > +	struct mhi_chan_ctxt ch;
> > +	struct mhi_generic_ctx generic;
> > +};
> > +

[...]

> > +static void mhi_ep_release_device(struct device *dev)
> > +{
> > +	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
> > +
> > +	/*
> > +	 * We need to set the mhi_chan->mhi_dev to NULL here since the MHI
> > +	 * devices for the channels will only get created if the mhi_dev
> > +	 * associated with it is NULL.
> 
> Maybe say where in the code what the comment above says happens.
> 

okay

> > +	 */
> > +	if (mhi_dev->ul_chan)
> > +		mhi_dev->ul_chan->mhi_dev = NULL;
> > +
> > +	if (mhi_dev->dl_chan)
> > +		mhi_dev->dl_chan->mhi_dev = NULL;
> > +
> > +	kfree(mhi_dev);
> > +}
> > +
> > +static struct mhi_ep_device *mhi_ep_alloc_device(struct mhi_ep_cntrl *mhi_cntrl)
> > +{
> > +	struct mhi_ep_device *mhi_dev;
> > +	struct device *dev;
> > +
> > +	mhi_dev = kzalloc(sizeof(*mhi_dev), GFP_KERNEL);
> > +	if (!mhi_dev)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	dev = &mhi_dev->dev;
> > +	device_initialize(dev);
> > +	dev->bus = &mhi_ep_bus_type;
> > +	dev->release = mhi_ep_release_device;
> > +
> 
> I think you should pass the MHI device type as argument here, and
> set it within this function.  Then use it in the test below, rather
> than assuming the mhi_dev pointer will be NULL for the controller
> only.  Maybe you should set the mhi_dev pointer here as well.
> 

Makes sense.

I was trying to align with host MHI stack that does the same way.
But I'll change it in ep and will do the same on host later.

> > +	if (mhi_cntrl->mhi_dev) {
> > +		/* for MHI client devices, parent is the MHI controller device */
> > +		dev->parent = &mhi_cntrl->mhi_dev->dev;
> > +	} else {
> > +		/* for MHI controller device, parent is the bus device (e.g. PCI EPF) */
> > +		dev->parent = mhi_cntrl->cntrl_dev;
> > +	}
> > +
> > +	mhi_dev->mhi_cntrl = mhi_cntrl;
> > +
> > +	return mhi_dev;
> > +}
> > +
> > +static int parse_ch_cfg(struct mhi_ep_cntrl *mhi_cntrl,
> > +			const struct mhi_ep_cntrl_config *config)
> > +{
> > +	const struct mhi_ep_channel_config *ch_cfg;
> > +	struct device *dev = mhi_cntrl->cntrl_dev;
> > +	u32 chan, i;
> > +	int ret = -EINVAL;
> > +
> > +	mhi_cntrl->max_chan = config->max_channels;
> > +
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
> > +
> > +		ch_cfg = &config->ch_cfg[i];
> > +
> > +		chan = ch_cfg->num;
> > +		if (chan >= mhi_cntrl->max_chan) {
> > +			dev_err(dev, "Channel %d not available\n", chan);
> > +			goto error_chan_cfg;
> > +		}
> > +
> > +		mhi_chan = &mhi_cntrl->mhi_chan[chan];
> > +		mhi_chan->name = ch_cfg->name;
> > +		mhi_chan->chan = chan;
> > +		mhi_chan->dir = ch_cfg->dir;
> > +		mutex_init(&mhi_chan->lock);
> 
> Move the error check below earlier, before assigning other values.
> 

ack

> > +		/* Bi-directional and direction less channels are not supported */
> > +		if (mhi_chan->dir == DMA_BIDIRECTIONAL || mhi_chan->dir == DMA_NONE) {
> > +			dev_err(dev, "Invalid channel configuration\n");
> > +			goto error_chan_cfg;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +
> > +error_chan_cfg:
> > +	kfree(mhi_cntrl->mhi_chan);
> > +
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
> 
> Perhaps you could use a convention like "ep_dev" (and later, "ep_drv")
> to represent an mhi_ep_device, different from "mhi_dev" representing
> an mhi_device.
> 

This is done to align with the host MHI stack, so that it'll be easy to spot
the MHI device pointer.

> > +	int ret;
> > +
> > +	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev)
> > +		return -EINVAL;
> > +
> > +	ret = parse_ch_cfg(mhi_cntrl, config);
> > +	if (ret)
> > +		return ret;
> > +
> 
> NR_OF_CMD_RINGS is 1, and I think always will be, right?  This and
> elsewhere could be simplified if we just accept that.
> 

For now yes, but it could be changed in future.

> > +	mhi_cntrl->mhi_cmd = kcalloc(NR_OF_CMD_RINGS, sizeof(*mhi_cntrl->mhi_cmd), GFP_KERNEL);
> > +	if (!mhi_cntrl->mhi_cmd) {
> > +		ret = -ENOMEM;
> > +		goto err_free_ch;
> > +	}
> > +
> > +	/* Set controller index */
> > +	mhi_cntrl->index = ida_alloc(&mhi_ep_cntrl_ida, GFP_KERNEL);
> > +	if (mhi_cntrl->index < 0) {
> > +		ret = mhi_cntrl->index;
> > +		goto err_free_cmd;
> > +	}
> > +
> > +	/* Allocate the controller device */
> > +	mhi_dev = mhi_ep_alloc_device(mhi_cntrl);
> > +	if (IS_ERR(mhi_dev)) {
> > +		dev_err(mhi_cntrl->cntrl_dev, "Failed to allocate controller device\n");
> > +		ret = PTR_ERR(mhi_dev);
> > +		goto err_ida_free;
> > +	}
> > +
> > +	mhi_dev->dev_type = MHI_DEVICE_CONTROLLER;
> > +	dev_set_name(&mhi_dev->dev, "mhi_ep%d", mhi_cntrl->index);
> > +	mhi_dev->name = dev_name(&mhi_dev->dev);
> > +
> > +	ret = device_add(&mhi_dev->dev);
> > +	if (ret)
> > +		goto err_release_dev;
> 
> goto err_put_device?
> 

okay

> > +
> > +	mhi_cntrl->mhi_dev = mhi_dev;
> > +
> > +	dev_dbg(&mhi_dev->dev, "MHI EP Controller registered\n");
> > +
> > +	return 0;
> > +
> > +err_release_dev:
> > +	put_device(&mhi_dev->dev);
> > +err_ida_free:
> > +	ida_free(&mhi_ep_cntrl_ida, mhi_cntrl->index);
> > +err_free_cmd:
> > +	kfree(mhi_cntrl->mhi_cmd);
> > +err_free_ch:
> > +	kfree(mhi_cntrl->mhi_chan);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(mhi_ep_register_controller);
> > +

[...]

> > +struct mhi_ep_device {
> > +	struct device dev;
> > +	struct mhi_ep_cntrl *mhi_cntrl;
> > +	const struct mhi_device_id *id;
> > +	const char *name;
> > +	struct mhi_ep_chan *ul_chan;
> > +	struct mhi_ep_chan *dl_chan;
> 
> Could the dev_type just be:    bool controller?
> 

Again, this is done the same way as host. Will change it later if needed.

> > +	enum mhi_device_type dev_type;
> > +	int ul_chan_id;
> 
> Can't you ust use ul_chan->chan and dl_chan->chan?
> 
> In any case, I think the channel ids should be u32.
> 

This is not used for now as well. I'll just remove it.

Thanks,
Mani
