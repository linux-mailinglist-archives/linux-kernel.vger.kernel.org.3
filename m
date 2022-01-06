Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30EA5485D2A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 01:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343796AbiAFA3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 19:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343736AbiAFA3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 19:29:03 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC93C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 16:29:03 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id l17so731341qtk.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 16:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=x+c+nB71HU1/FSoixaZntFKj7lnNe4rQLk5DQjPdfdc=;
        b=bKx8q7nraU8tjLQOt4lt7n7KAYu9GdnyIDHrrbCrUoy+MhW3lD0vpOe8swYrGjKRuZ
         Wi71hOV2NTXBGBrDCt/vyODBYzOpnxvW1Zeb1CrzQJNgxDc/pQrL65vKT2j2w5Itoga1
         bDwOMKQ8t7dSzaj6O7XeEa8JHusjeWz/bZA7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=x+c+nB71HU1/FSoixaZntFKj7lnNe4rQLk5DQjPdfdc=;
        b=KAXuWMLkxnb175PQVae3L0du3pNGCCcpWRAQLbmNdQ1oIU89+DDp5xIAyUadmQf/ts
         hF4mV0SJn4VGgIfRXjmoegamzvUc557ZRDLL7rQaRh8CWMB5eG7tPQKiChcL0NhnEMWB
         y6MZgTYOQEO2786Fp3XeGQy+9oTEMz09idyf40Eke0eRMTR4kRUFAbecmw2iRsTbWBhG
         pFDs4hOl08MIZUhjkWA/mUSKDeOkRp9Bvo08DpOgSzVsxrb09V8iW5Ifsv5o1DpRSs+9
         zdecdeYcFEVU12fLxhbW6YybEywPilDbT3xQP/RI4YH5AeOUYP7iXmCuJosAK5vkFllo
         gcWA==
X-Gm-Message-State: AOAM533UDMZSZ7wXXJI/1u8GytVf+Of37NsX34N7/p00MefDGuiktOAQ
        BgfpcUzzm/yDVIr9icBLPY1LTg==
X-Google-Smtp-Source: ABdhPJyoOcRjPUCIzBM4cSvnxW9XZTpRVoJXdVBSE/SxVFk39xVlGzhp29ooIAOvDsTOwEuWg/OkGA==
X-Received: by 2002:a05:622a:144e:: with SMTP id v14mr988166qtx.319.1641428942541;
        Wed, 05 Jan 2022 16:29:02 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id q21sm319772qkl.52.2022.01.05.16.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 16:29:02 -0800 (PST)
Message-ID: <e72c4ba7-39df-ef70-89f1-b8c066184273@ieee.org>
Date:   Wed, 5 Jan 2022 18:29:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
From:   Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 08/20] bus: mhi: ep: Add support for managing MMIO
 registers
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mhi@lists.linux.dev
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        skananth@codeaurora.org, vpernami@codeaurora.org,
        vbadigan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
 <20211202113553.238011-9-manivannan.sadhasivam@linaro.org>
Content-Language: en-US
In-Reply-To: <20211202113553.238011-9-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/21 5:35 AM, Manivannan Sadhasivam wrote:
> Add support for managing the Memory Mapped Input Output (MMIO) registers
> of the MHI bus. All MHI operations are carried out using the MMIO registers
> by both host and the endpoint device.
> 
> The MMIO registers reside inside the endpoint device memory (fixed
> location based on the platform) and the address is passed by the MHI EP
> controller driver during its registration.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/bus/mhi/ep/Makefile   |   2 +-
>   drivers/bus/mhi/ep/internal.h |  36 ++++
>   drivers/bus/mhi/ep/main.c     |   6 +-
>   drivers/bus/mhi/ep/mmio.c     | 303 ++++++++++++++++++++++++++++++++++
>   include/linux/mhi_ep.h        |  18 ++
>   5 files changed, 363 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/bus/mhi/ep/mmio.c
> 
> diff --git a/drivers/bus/mhi/ep/Makefile b/drivers/bus/mhi/ep/Makefile
> index 64e29252b608..a1555ae287ad 100644
> --- a/drivers/bus/mhi/ep/Makefile
> +++ b/drivers/bus/mhi/ep/Makefile
> @@ -1,2 +1,2 @@
>   obj-$(CONFIG_MHI_BUS_EP) += mhi_ep.o
> -mhi_ep-y := main.o
> +mhi_ep-y := main.o mmio.o
> diff --git a/drivers/bus/mhi/ep/internal.h b/drivers/bus/mhi/ep/internal.h
> index 7b164daf4332..39eeb5f384e2 100644
> --- a/drivers/bus/mhi/ep/internal.h
> +++ b/drivers/bus/mhi/ep/internal.h
> @@ -91,6 +91,12 @@ struct mhi_generic_ctx {
>   	__u64 wp __packed __aligned(4);
>   };
>   

Maybe add a comment defining SBL as "secondary boot loader" and AMSS
as "advanced modem subsystem".

> +enum mhi_ep_execenv {
> +	MHI_EP_SBL_EE = 1,
> +	MHI_EP_AMSS_EE = 2,
> +	MHI_EP_UNRESERVED
> +};
> +
>   enum mhi_ep_ring_state {
>   	RING_STATE_UINT = 0,
>   	RING_STATE_IDLE,
> @@ -155,4 +161,34 @@ struct mhi_ep_chan {
>   	bool skip_td;
>   };
>   
> +/* MMIO related functions */

I would *really* rather have the mmio_read functions *return* the read
value, rather than having the address of the location to store it passed
as argument.  Your MMIO calls never fail, so there's no need to return
anything else.  Returning the value also makes it more obvious that the
*result* is getting assigned (rather than sort of implying it by passing
in the address of the result).  And there's no possibility of someone
passing a bad pointer that way either.

> +void mhi_ep_mmio_read(struct mhi_ep_cntrl *mhi_cntrl, u32 offset, u32 *regval);

In other words:

u32 mhi_ep_mmio_read(struct mhi_ep_ctrl *mhi_ctrl, u32 offset);

> +void mhi_ep_mmio_write(struct mhi_ep_cntrl *mhi_cntrl, u32 offset, u32 val);
> +void mhi_ep_mmio_masked_write(struct mhi_ep_cntrl *mhi_cntrl, u32 offset,
> +			      u32 mask, u32 shift, u32 val);
> +int mhi_ep_mmio_masked_read(struct mhi_ep_cntrl *dev, u32 offset,
> +			    u32 mask, u32 shift, u32 *regval);
> +void mhi_ep_mmio_enable_ctrl_interrupt(struct mhi_ep_cntrl *mhi_cntrl);
> +void mhi_ep_mmio_disable_ctrl_interrupt(struct mhi_ep_cntrl *mhi_cntrl);
> +void mhi_ep_mmio_enable_cmdb_interrupt(struct mhi_ep_cntrl *mhi_cntrl);
> +void mhi_ep_mmio_disable_cmdb_interrupt(struct mhi_ep_cntrl *mhi_cntrl);
> +void mhi_ep_mmio_enable_chdb_a7(struct mhi_ep_cntrl *mhi_cntrl, u32 chdb_id);
> +void mhi_ep_mmio_disable_chdb_a7(struct mhi_ep_cntrl *mhi_cntrl, u32 chdb_id);
> +void mhi_ep_mmio_enable_chdb_interrupts(struct mhi_ep_cntrl *mhi_cntrl);
> +void mhi_ep_mmio_read_chdb_status_interrupts(struct mhi_ep_cntrl *mhi_cntrl);
> +void mhi_ep_mmio_mask_interrupts(struct mhi_ep_cntrl *mhi_cntrl);
> +void mhi_ep_mmio_get_chc_base(struct mhi_ep_cntrl *mhi_cntrl);
> +void mhi_ep_mmio_get_erc_base(struct mhi_ep_cntrl *mhi_cntrl);
> +void mhi_ep_mmio_get_crc_base(struct mhi_ep_cntrl *mhi_cntrl);
> +void mhi_ep_mmio_get_ch_db(struct mhi_ep_ring *ring, u64 *wr_offset);
> +void mhi_ep_mmio_get_er_db(struct mhi_ep_ring *ring, u64 *wr_offset);
> +void mhi_ep_mmio_get_cmd_db(struct mhi_ep_ring *ring, u64 *wr_offset);
> +void mhi_ep_mmio_set_env(struct mhi_ep_cntrl *mhi_cntrl, u32 value);
> +void mhi_ep_mmio_clear_reset(struct mhi_ep_cntrl *mhi_cntrl);
> +void mhi_ep_mmio_reset(struct mhi_ep_cntrl *mhi_cntrl);
> +void mhi_ep_mmio_get_mhi_state(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state *state,
> +			       bool *mhi_reset);
> +void mhi_ep_mmio_init(struct mhi_ep_cntrl *mhi_cntrl);
> +void mhi_ep_mmio_update_ner(struct mhi_ep_cntrl *mhi_cntrl);
> +
>   #endif
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index f0b5f49db95a..fddf75dfb9c7 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -209,7 +209,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
>   	struct mhi_ep_device *mhi_dev;
>   	int ret;
>   
> -	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev)
> +	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev || !mhi_cntrl->mmio)
>   		return -EINVAL;
>   
>   	ret = parse_ch_cfg(mhi_cntrl, config);
> @@ -222,6 +222,10 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
>   		goto err_free_ch;
>   	}
>   
> +	/* Set MHI version and AMSS EE before enumeration */
> +	mhi_ep_mmio_write(mhi_cntrl, MHIVER, config->mhi_version);
> +	mhi_ep_mmio_set_env(mhi_cntrl, MHI_EP_AMSS_EE);
> +
>   	/* Set controller index */
>   	mhi_cntrl->index = ida_alloc(&mhi_ep_cntrl_ida, GFP_KERNEL);
>   	if (mhi_cntrl->index < 0) {
> diff --git a/drivers/bus/mhi/ep/mmio.c b/drivers/bus/mhi/ep/mmio.c
> new file mode 100644
> index 000000000000..157ef1240f6f
> --- /dev/null
> +++ b/drivers/bus/mhi/ep/mmio.c
> @@ -0,0 +1,303 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2021 Linaro Ltd.
> + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/io.h>
> +#include <linux/mhi_ep.h>
> +
> +#include "internal.h"
> +
> +void mhi_ep_mmio_read(struct mhi_ep_cntrl *mhi_cntrl, u32 offset, u32 *regval)
> +{
> +	*regval = readl(mhi_cntrl->mmio + offset);

	return readl(...);

> +}
> +
> +void mhi_ep_mmio_write(struct mhi_ep_cntrl *mhi_cntrl, u32 offset, u32 val)
> +{
> +	writel(val, mhi_cntrl->mmio + offset);
> +}
> +
> +void mhi_ep_mmio_masked_write(struct mhi_ep_cntrl *mhi_cntrl, u32 offset, u32 mask,
> +			       u32 shift, u32 val)

There is no need for a shift argument here.  I would like to say
"use the bitfield functions" but at the moment they require the
mask to be constant.  You could still do that, by having all
these be defined as static inline functions in a header though.
Maybe you can use FIELD_GET() though, I don't know.

Anyway, try to get rid of these shifts; they shouldn't be
necessary.

> +{
> +	u32 regval;
> +
> +	mhi_ep_mmio_read(mhi_cntrl, offset, &regval);
> +	regval &= ~mask;
> +	regval |= ((val << shift) & mask);
> +	mhi_ep_mmio_write(mhi_cntrl, offset, regval);
> +}
> +
> +int mhi_ep_mmio_masked_read(struct mhi_ep_cntrl *dev, u32 offset,
> +			     u32 mask, u32 shift, u32 *regval)
> +{
> +	mhi_ep_mmio_read(dev, offset, regval);
> +	*regval &= mask;
> +	*regval >>= shift;
> +
> +	return 0;

There is no point in returning 0 from this function.

> +}
> +
> +void mhi_ep_mmio_get_mhi_state(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state *state,
> +				bool *mhi_reset)
> +{
> +	u32 regval;
> +
> +	mhi_ep_mmio_read(mhi_cntrl, MHICTRL, &regval);
> +	*state = FIELD_GET(MHICTRL_MHISTATE_MASK, regval);
> +	*mhi_reset = !!FIELD_GET(MHICTRL_RESET_MASK, regval);
> +}
> +
> +static void mhi_ep_mmio_mask_set_chdb_int_a7(struct mhi_ep_cntrl *mhi_cntrl,
> +						u32 chdb_id, bool enable)
> +{
> +	u32 chid_mask, chid_idx, chid_shft, val = 0;
> +
> +	chid_shft = chdb_id % 32;
> +	chid_mask = BIT(chid_shft);
> +	chid_idx = chdb_id / 32;
> +
> +	if (chid_idx >= MHI_MASK_ROWS_CH_EV_DB)
> +		return;

The above should maybe issue a warning?

> +
> +	if (enable)
> +		val = 1;
> +
> +	mhi_ep_mmio_masked_write(mhi_cntrl, MHI_CHDB_INT_MASK_A7_n(chid_idx),
> +				  chid_mask, chid_shft, val);
> +	mhi_ep_mmio_read(mhi_cntrl, MHI_CHDB_INT_MASK_A7_n(chid_idx),
> +			  &mhi_cntrl->chdb[chid_idx].mask);

Why do you read after writing?  Is this to be sure the write completes
over PCIe or something?  Even then I don't think that would be needed
because the memory is on "this side" of PCIe (right?).

> +}
> +
> +void mhi_ep_mmio_enable_chdb_a7(struct mhi_ep_cntrl *mhi_cntrl, u32 chdb_id)
> +{
> +	mhi_ep_mmio_mask_set_chdb_int_a7(mhi_cntrl, chdb_id, true);
> +}
> +
> +void mhi_ep_mmio_disable_chdb_a7(struct mhi_ep_cntrl *mhi_cntrl, u32 chdb_id)
> +{
> +	mhi_ep_mmio_mask_set_chdb_int_a7(mhi_cntrl, chdb_id, false);
> +}
> +
> +static void mhi_ep_mmio_set_chdb_interrupts(struct mhi_ep_cntrl *mhi_cntrl, bool enable)
> +{
> +	u32 val = 0, i = 0;

No need for assigning 0 to i.

					-Alex

> +
> +	if (enable)
> +		val = MHI_CHDB_INT_MASK_A7_n_EN_ALL;
> +
> +	for (i = 0; i < MHI_MASK_ROWS_CH_EV_DB; i++) {
> +		mhi_ep_mmio_write(mhi_cntrl, MHI_CHDB_INT_MASK_A7_n(i), val);
> +		mhi_cntrl->chdb[i].mask = val;
> +	}
> +}
> +

. . .
