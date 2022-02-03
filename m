Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EAE4A881A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 16:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352030AbiBCPzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 10:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238210AbiBCPzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:55:53 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B3BC06173B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 07:55:53 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id s61-20020a17090a69c300b001b4d0427ea2so10405820pjj.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 07:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wu8Y7mRaqbSebyjgD2jlgg5hqkr4mPByFHuiEdZaBnc=;
        b=QqopAU+3uwaUGZJmKN6LqtKG0/Jp7qwY7iUpBlCNshYYNOnv4v06MMwOobUIeymOsa
         MRhajOXV/1pY7Es65Trcw4d9xpdj5Qez8AXz6cOtAYZzyBjERluzV2RxJxbzq1YAVG7H
         +em2B5Lqao+Eyv/toOw68e03V07xQtVijBMYmgB1ebVvsLH7Vt+oBMMUsLwTKC+ct792
         OrmRCeaI4xcNKM10nco3KcH/md+5wAsdBAMEcC5HlwoCfy5UmEaWl3LHMod7RBqkFJ2N
         +b+OO9MnYME1bdzwOB94QOreHE7AuUE8zX1Vce4bxOjWDYOvrHPGNB8GyEk3XYDLnOFi
         kNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wu8Y7mRaqbSebyjgD2jlgg5hqkr4mPByFHuiEdZaBnc=;
        b=p7sTSMIHZ99v9neggJdZqtBrdf6JnsCk5ljHA+e1rHMg/MLk9r1TSkyihJmh3A1Pkw
         WKYdTI4+7d2vQ5ZsQgfQI8WnLLwJF9y5BjqId/du6m1714e0x0PG7nAwWocxrheROrAK
         /ARHjkQstoM6/B1IMrPQFoBheHBrXYxLdqhaThFs0iU3Y6Otug0B2x+v7822SD7mRvEL
         Gw6YJZ1zWSyvvLrD1p/KGHeuZJWyl+KTrgCDy5dtNLspuazZaIMyGmFfm6kQyS4uXfCg
         3WzJJzYJtJWFJZVvxxTQ7hhVWYmqlOtz+9V19j0q4IUmCqucQdO3js9OAbEiz0JcK/94
         KzFA==
X-Gm-Message-State: AOAM530bd5H6Yq8kJEh3pl8sXMTl+hk336aohee3uVjPiXffFzmVB0Sx
        PLW4KodUW20nU/HruVmmIRhw
X-Google-Smtp-Source: ABdhPJykKyoa2X35J8T5AuwYYpUK1Zz7kWQ0pdO9rpilLh4x8waZBMlrFyESkauhd9JmVHn80yAr1Q==
X-Received: by 2002:a17:90b:4b88:: with SMTP id lr8mr14539193pjb.166.1643903752347;
        Thu, 03 Feb 2022 07:55:52 -0800 (PST)
Received: from thinkpad ([117.217.179.179])
        by smtp.gmail.com with ESMTPSA id j185sm2721062pfd.85.2022.02.03.07.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 07:55:51 -0800 (PST)
Date:   Thu, 3 Feb 2022 21:25:44 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Alex Elder <elder@ieee.org>
Cc:     mhi@lists.linux.dev, hemantk@codeaurora.org, bbhatt@codeaurora.org,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        skananth@codeaurora.org, vpernami@codeaurora.org,
        vbadigan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/20] bus: mhi: ep: Add support for managing MMIO
 registers
Message-ID: <20220203155544.GG6298@thinkpad>
References: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
 <20211202113553.238011-9-manivannan.sadhasivam@linaro.org>
 <e72c4ba7-39df-ef70-89f1-b8c066184273@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e72c4ba7-39df-ef70-89f1-b8c066184273@ieee.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 06:29:00PM -0600, Alex Elder wrote:
> On 12/2/21 5:35 AM, Manivannan Sadhasivam wrote:
> > Add support for managing the Memory Mapped Input Output (MMIO) registers
> > of the MHI bus. All MHI operations are carried out using the MMIO registers
> > by both host and the endpoint device.
> > 
> > The MMIO registers reside inside the endpoint device memory (fixed
> > location based on the platform) and the address is passed by the MHI EP
> > controller driver during its registration.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >   drivers/bus/mhi/ep/Makefile   |   2 +-
> >   drivers/bus/mhi/ep/internal.h |  36 ++++
> >   drivers/bus/mhi/ep/main.c     |   6 +-
> >   drivers/bus/mhi/ep/mmio.c     | 303 ++++++++++++++++++++++++++++++++++
> >   include/linux/mhi_ep.h        |  18 ++
> >   5 files changed, 363 insertions(+), 2 deletions(-)
> >   create mode 100644 drivers/bus/mhi/ep/mmio.c
> > 
> > diff --git a/drivers/bus/mhi/ep/Makefile b/drivers/bus/mhi/ep/Makefile
> > index 64e29252b608..a1555ae287ad 100644
> > --- a/drivers/bus/mhi/ep/Makefile
> > +++ b/drivers/bus/mhi/ep/Makefile
> > @@ -1,2 +1,2 @@
> >   obj-$(CONFIG_MHI_BUS_EP) += mhi_ep.o
> > -mhi_ep-y := main.o
> > +mhi_ep-y := main.o mmio.o
> > diff --git a/drivers/bus/mhi/ep/internal.h b/drivers/bus/mhi/ep/internal.h
> > index 7b164daf4332..39eeb5f384e2 100644
> > --- a/drivers/bus/mhi/ep/internal.h
> > +++ b/drivers/bus/mhi/ep/internal.h
> > @@ -91,6 +91,12 @@ struct mhi_generic_ctx {
> >   	__u64 wp __packed __aligned(4);
> >   };
> 
> Maybe add a comment defining SBL as "secondary boot loader" and AMSS
> as "advanced modem subsystem".
> 

Sure, will add kernel doc. But from modem terms, AMSS refers to
"Advanced Mode Subscriber Software".

> > +enum mhi_ep_execenv {
> > +	MHI_EP_SBL_EE = 1,
> > +	MHI_EP_AMSS_EE = 2,
> > +	MHI_EP_UNRESERVED
> > +};
> > +
> >   enum mhi_ep_ring_state {
> >   	RING_STATE_UINT = 0,
> >   	RING_STATE_IDLE,
> > @@ -155,4 +161,34 @@ struct mhi_ep_chan {
> >   	bool skip_td;
> >   };
> > +/* MMIO related functions */
> 
> I would *really* rather have the mmio_read functions *return* the read
> value, rather than having the address of the location to store it passed
> as argument.  Your MMIO calls never fail, so there's no need to return
> anything else.  Returning the value also makes it more obvious that the
> *result* is getting assigned (rather than sort of implying it by passing
> in the address of the result).  And there's no possibility of someone
> passing a bad pointer that way either.
> 
> > +void mhi_ep_mmio_read(struct mhi_ep_cntrl *mhi_cntrl, u32 offset, u32 *regval);
> 
> In other words:
> 
> u32 mhi_ep_mmio_read(struct mhi_ep_ctrl *mhi_ctrl, u32 offset);
> 
> > +void mhi_ep_mmio_write(struct mhi_ep_cntrl *mhi_cntrl, u32 offset, u32 val);
> > +void mhi_ep_mmio_masked_write(struct mhi_ep_cntrl *mhi_cntrl, u32 offset,
> > +			      u32 mask, u32 shift, u32 val);
> > +int mhi_ep_mmio_masked_read(struct mhi_ep_cntrl *dev, u32 offset,
> > +			    u32 mask, u32 shift, u32 *regval);
> > +void mhi_ep_mmio_enable_ctrl_interrupt(struct mhi_ep_cntrl *mhi_cntrl);
> > +void mhi_ep_mmio_disable_ctrl_interrupt(struct mhi_ep_cntrl *mhi_cntrl);
> > +void mhi_ep_mmio_enable_cmdb_interrupt(struct mhi_ep_cntrl *mhi_cntrl);
> > +void mhi_ep_mmio_disable_cmdb_interrupt(struct mhi_ep_cntrl *mhi_cntrl);
> > +void mhi_ep_mmio_enable_chdb_a7(struct mhi_ep_cntrl *mhi_cntrl, u32 chdb_id);
> > +void mhi_ep_mmio_disable_chdb_a7(struct mhi_ep_cntrl *mhi_cntrl, u32 chdb_id);
> > +void mhi_ep_mmio_enable_chdb_interrupts(struct mhi_ep_cntrl *mhi_cntrl);
> > +void mhi_ep_mmio_read_chdb_status_interrupts(struct mhi_ep_cntrl *mhi_cntrl);
> > +void mhi_ep_mmio_mask_interrupts(struct mhi_ep_cntrl *mhi_cntrl);
> > +void mhi_ep_mmio_get_chc_base(struct mhi_ep_cntrl *mhi_cntrl);
> > +void mhi_ep_mmio_get_erc_base(struct mhi_ep_cntrl *mhi_cntrl);
> > +void mhi_ep_mmio_get_crc_base(struct mhi_ep_cntrl *mhi_cntrl);
> > +void mhi_ep_mmio_get_ch_db(struct mhi_ep_ring *ring, u64 *wr_offset);
> > +void mhi_ep_mmio_get_er_db(struct mhi_ep_ring *ring, u64 *wr_offset);
> > +void mhi_ep_mmio_get_cmd_db(struct mhi_ep_ring *ring, u64 *wr_offset);
> > +void mhi_ep_mmio_set_env(struct mhi_ep_cntrl *mhi_cntrl, u32 value);
> > +void mhi_ep_mmio_clear_reset(struct mhi_ep_cntrl *mhi_cntrl);
> > +void mhi_ep_mmio_reset(struct mhi_ep_cntrl *mhi_cntrl);
> > +void mhi_ep_mmio_get_mhi_state(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state *state,
> > +			       bool *mhi_reset);
> > +void mhi_ep_mmio_init(struct mhi_ep_cntrl *mhi_cntrl);
> > +void mhi_ep_mmio_update_ner(struct mhi_ep_cntrl *mhi_cntrl);
> > +
> >   #endif
> > diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> > index f0b5f49db95a..fddf75dfb9c7 100644
> > --- a/drivers/bus/mhi/ep/main.c
> > +++ b/drivers/bus/mhi/ep/main.c
> > @@ -209,7 +209,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
> >   	struct mhi_ep_device *mhi_dev;
> >   	int ret;
> > -	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev)
> > +	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev || !mhi_cntrl->mmio)
> >   		return -EINVAL;
> >   	ret = parse_ch_cfg(mhi_cntrl, config);
> > @@ -222,6 +222,10 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
> >   		goto err_free_ch;
> >   	}
> > +	/* Set MHI version and AMSS EE before enumeration */
> > +	mhi_ep_mmio_write(mhi_cntrl, MHIVER, config->mhi_version);
> > +	mhi_ep_mmio_set_env(mhi_cntrl, MHI_EP_AMSS_EE);
> > +
> >   	/* Set controller index */
> >   	mhi_cntrl->index = ida_alloc(&mhi_ep_cntrl_ida, GFP_KERNEL);
> >   	if (mhi_cntrl->index < 0) {
> > diff --git a/drivers/bus/mhi/ep/mmio.c b/drivers/bus/mhi/ep/mmio.c
> > new file mode 100644
> > index 000000000000..157ef1240f6f
> > --- /dev/null
> > +++ b/drivers/bus/mhi/ep/mmio.c
> > @@ -0,0 +1,303 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2021 Linaro Ltd.
> > + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/io.h>
> > +#include <linux/mhi_ep.h>
> > +
> > +#include "internal.h"
> > +
> > +void mhi_ep_mmio_read(struct mhi_ep_cntrl *mhi_cntrl, u32 offset, u32 *regval)
> > +{
> > +	*regval = readl(mhi_cntrl->mmio + offset);
> 
> 	return readl(...);
> 

done

> > +}
> > +
> > +void mhi_ep_mmio_write(struct mhi_ep_cntrl *mhi_cntrl, u32 offset, u32 val)
> > +{
> > +	writel(val, mhi_cntrl->mmio + offset);
> > +}
> > +
> > +void mhi_ep_mmio_masked_write(struct mhi_ep_cntrl *mhi_cntrl, u32 offset, u32 mask,
> > +			       u32 shift, u32 val)
> 
> There is no need for a shift argument here.  I would like to say
> "use the bitfield functions" but at the moment they require the
> mask to be constant.  You could still do that, by having all
> these be defined as static inline functions in a header though.
> Maybe you can use FIELD_GET() though, I don't know.
> 

I've used __ffs to determine the shift.

> Anyway, try to get rid of these shifts; they shouldn't be
> necessary.
> 
> > +{
> > +	u32 regval;
> > +
> > +	mhi_ep_mmio_read(mhi_cntrl, offset, &regval);
> > +	regval &= ~mask;
> > +	regval |= ((val << shift) & mask);
> > +	mhi_ep_mmio_write(mhi_cntrl, offset, regval);
> > +}
> > +
> > +int mhi_ep_mmio_masked_read(struct mhi_ep_cntrl *dev, u32 offset,
> > +			     u32 mask, u32 shift, u32 *regval)
> > +{
> > +	mhi_ep_mmio_read(dev, offset, regval);
> > +	*regval &= mask;
> > +	*regval >>= shift;
> > +
> > +	return 0;
> 
> There is no point in returning 0 from this function.
> 
> > +}
> > +
> > +void mhi_ep_mmio_get_mhi_state(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state *state,
> > +				bool *mhi_reset)
> > +{
> > +	u32 regval;
> > +
> > +	mhi_ep_mmio_read(mhi_cntrl, MHICTRL, &regval);
> > +	*state = FIELD_GET(MHICTRL_MHISTATE_MASK, regval);
> > +	*mhi_reset = !!FIELD_GET(MHICTRL_RESET_MASK, regval);
> > +}
> > +
> > +static void mhi_ep_mmio_mask_set_chdb_int_a7(struct mhi_ep_cntrl *mhi_cntrl,
> > +						u32 chdb_id, bool enable)
> > +{
> > +	u32 chid_mask, chid_idx, chid_shft, val = 0;
> > +
> > +	chid_shft = chdb_id % 32;
> > +	chid_mask = BIT(chid_shft);
> > +	chid_idx = chdb_id / 32;
> > +
> > +	if (chid_idx >= MHI_MASK_ROWS_CH_EV_DB)
> > +		return;
> 
> The above should maybe issue a warning?
> 

ack

> > +
> > +	if (enable)
> > +		val = 1;
> > +
> > +	mhi_ep_mmio_masked_write(mhi_cntrl, MHI_CHDB_INT_MASK_A7_n(chid_idx),
> > +				  chid_mask, chid_shft, val);
> > +	mhi_ep_mmio_read(mhi_cntrl, MHI_CHDB_INT_MASK_A7_n(chid_idx),
> > +			  &mhi_cntrl->chdb[chid_idx].mask);
> 
> Why do you read after writing?  Is this to be sure the write completes
> over PCIe or something?  Even then I don't think that would be needed
> because the memory is on "this side" of PCIe (right?).
> 

This is done to update the mask. We could also do the bit managment stuff here
instead of reading from the register (I guess that'll be faster).

Thanks,
Mani

> > +}
> > +
> > +void mhi_ep_mmio_enable_chdb_a7(struct mhi_ep_cntrl *mhi_cntrl, u32 chdb_id)
> > +{
> > +	mhi_ep_mmio_mask_set_chdb_int_a7(mhi_cntrl, chdb_id, true);
> > +}
> > +
> > +void mhi_ep_mmio_disable_chdb_a7(struct mhi_ep_cntrl *mhi_cntrl, u32 chdb_id)
> > +{
> > +	mhi_ep_mmio_mask_set_chdb_int_a7(mhi_cntrl, chdb_id, false);
> > +}
> > +
> > +static void mhi_ep_mmio_set_chdb_interrupts(struct mhi_ep_cntrl *mhi_cntrl, bool enable)
> > +{
> > +	u32 val = 0, i = 0;
> 
> No need for assigning 0 to i.
> 
> 					-Alex
> 
> > +
> > +	if (enable)
> > +		val = MHI_CHDB_INT_MASK_A7_n_EN_ALL;
> > +
> > +	for (i = 0; i < MHI_MASK_ROWS_CH_EV_DB; i++) {
> > +		mhi_ep_mmio_write(mhi_cntrl, MHI_CHDB_INT_MASK_A7_n(i), val);
> > +		mhi_cntrl->chdb[i].mask = val;
> > +	}
> > +}
> > +
> 
> . . .
