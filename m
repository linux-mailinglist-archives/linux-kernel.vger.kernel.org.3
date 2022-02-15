Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287084B78E6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243966AbiBOUDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:03:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243963AbiBOUD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:03:28 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B3375C3B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:03:07 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id z7so15709196ilb.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oj3o1SYtRc53Acjr2HJb1+EtjjhZhDM9vlKMtJ4MQEo=;
        b=KxY/rSdRbQRjVNnJRnkFFYxeCiW1XpBm6G69NcejIkTLOBdP8AuPgtTuSI2XuHibhR
         pPrOvqgKuPRkLCsgyq1dhVSGpidt2Lc9xXYsjWOczsvaT5eUSi0XKYmwh8Ja3TGfqaHu
         mwXozwvKNzIU6DDaQ1Wbp2l/mxx5JHGhPJ2v/Jjzt4/hdH27xMQVwKq5jGkbalaRB/nJ
         3b/KluQgXJyiq4Hp0ic/VVONemYHdUwwWEjv6yMcA3bWdFCdJLsm1vlpBwkgqaDW4cge
         0AFtpuhpHEf/O0rrGxREukhGTV4bMxarJuV6cVqA8yQZJiz781qued+sHbZBGVjmkARt
         9GRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oj3o1SYtRc53Acjr2HJb1+EtjjhZhDM9vlKMtJ4MQEo=;
        b=mbWAXGAWuGFLLZ5S9vzKCUrVr9KJw0BdSXiS8+YBiUVQRTto/VuE+SQ/h1ofIh9+LT
         4GtfJJiJkN82gGPvxXbwaCKOvY75nOzyojsbJiDfYZ4Efvsc7HhdTXhamSi0shMVCXBe
         uOEG7TziSb5/ErYD0rPcfRc3Rdqe6WhRMZu0iQrmcYf6L/ciTKQtlZn7pQM/fOdAQhfM
         cXrmgYI7ZdFW0TR78Zzz21eYY4+pI74+CCkJfoMs8pPZb9UcT2WBZdPL2o6uA3WCeX15
         OtUcYQo1AMa7UaoFZ0mjbMn+jdOlsHHH25ipESa/ptQynxf1Ic46hX/PPwo8a0ue78Un
         z00g==
X-Gm-Message-State: AOAM533r7TX7/KKOEaizrpA1FMfPsVjzPaDiN62G+buWoURHL/U6kDX7
        3ybZlvyDvdlNOiO1lVWleEgIfA==
X-Google-Smtp-Source: ABdhPJyyvk3UM/vwLA+dbI3lK+plUHW8eWWFCEO5bi3g3R98JXn+qZIgXBR28pWdOOeQAu28mMd6sw==
X-Received: by 2002:a05:6e02:1285:: with SMTP id y5mr441978ilq.229.1644955386616;
        Tue, 15 Feb 2022 12:03:06 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id k1sm23870321iov.6.2022.02.15.12.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 12:03:06 -0800 (PST)
Message-ID: <ca021c94-67ca-477d-57bc-6eceac4c3dae@linaro.org>
Date:   Tue, 15 Feb 2022 14:03:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 11/25] bus: mhi: ep: Add support for managing MMIO
 registers
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
 <20220212182117.49438-12-manivannan.sadhasivam@linaro.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220212182117.49438-12-manivannan.sadhasivam@linaro.org>
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
> Add support for managing the Memory Mapped Input Output (MMIO) registers
> of the MHI bus. All MHI operations are carried out using the MMIO registers
> by both host and the endpoint device.
> 
> The MMIO registers reside inside the endpoint device memory (fixed
> location based on the platform) and the address is passed by the MHI EP
> controller driver during its registration.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

This is in pretty good shape, just a few comments.

					-Alex

> ---
>   drivers/bus/mhi/ep/Makefile   |   2 +-
>   drivers/bus/mhi/ep/internal.h |  37 +++++
>   drivers/bus/mhi/ep/main.c     |   6 +-
>   drivers/bus/mhi/ep/mmio.c     | 274 ++++++++++++++++++++++++++++++++++
>   include/linux/mhi_ep.h        |  18 +++
>   5 files changed, 335 insertions(+), 2 deletions(-)
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
> index e313a2546664..2c756a90774c 100644
> --- a/drivers/bus/mhi/ep/internal.h
> +++ b/drivers/bus/mhi/ep/internal.h
> @@ -101,6 +101,17 @@ struct mhi_generic_ctx {
>   	__u64 wp __packed __aligned(4);
>   };
>   
> +/**
> + * enum mhi_ep_execenv - MHI Endpoint Execution Environment
> + * @MHI_EP_SBL_EE: Secondary Bootloader
> + * @MHI_EP_AMSS_EE: Advanced Mode Subscriber Software
> + */
> +enum mhi_ep_execenv {
> +	MHI_EP_SBL_EE = 1,
> +	MHI_EP_AMSS_EE = 2,
> +	MHI_EP_UNRESERVED

UNRESERVED?  What does that mean?

> +};
> +
>   enum mhi_ep_ring_type {
>   	RING_TYPE_CMD = 0,
>   	RING_TYPE_ER,
> @@ -157,4 +168,30 @@ struct mhi_ep_chan {
>   	bool skip_td;
>   };
>   
> +/* MMIO related functions */
> +u32 mhi_ep_mmio_read(struct mhi_ep_cntrl *mhi_cntrl, u32 offset);
> +void mhi_ep_mmio_write(struct mhi_ep_cntrl *mhi_cntrl, u32 offset, u32 val);
> +void mhi_ep_mmio_masked_write(struct mhi_ep_cntrl *mhi_cntrl, u32 offset, u32 mask, u32 val);
> +u32 mhi_ep_mmio_masked_read(struct mhi_ep_cntrl *dev, u32 offset, u32 mask);
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
> +u64 mhi_ep_mmio_get_db(struct mhi_ep_ring *ring);
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
> index fcaacf9ddbd1..950b5bcabe18 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -205,7 +205,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
>   	struct mhi_ep_device *mhi_dev;
>   	int ret;
>   
> -	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev)
> +	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev || !mhi_cntrl->mmio)
>   		return -EINVAL;
>   
>   	ret = parse_ch_cfg(mhi_cntrl, config);
> @@ -218,6 +218,10 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
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
> index 000000000000..58e887beb050
> --- /dev/null
> +++ b/drivers/bus/mhi/ep/mmio.c
> @@ -0,0 +1,274 @@
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
> +u32 mhi_ep_mmio_read(struct mhi_ep_cntrl *mhi_cntrl, u32 offset)
> +{
> +	return readl(mhi_cntrl->mmio + offset);
> +}
> +
> +void mhi_ep_mmio_write(struct mhi_ep_cntrl *mhi_cntrl, u32 offset, u32 val)
> +{
> +	writel(val, mhi_cntrl->mmio + offset);
> +}
> +
> +void mhi_ep_mmio_masked_write(struct mhi_ep_cntrl *mhi_cntrl, u32 offset, u32 mask, u32 val)
> +{
> +	u32 regval;
> +
> +	regval = mhi_ep_mmio_read(mhi_cntrl, offset);
> +	regval &= ~mask;
> +	regval |= ((val << __ffs(mask)) & mask);

One extra set of parentheses here is not needed.  Assignment
is very low precedence in C.

> +	mhi_ep_mmio_write(mhi_cntrl, offset, regval);
> +}
> +
> +u32 mhi_ep_mmio_masked_read(struct mhi_ep_cntrl *dev, u32 offset, u32 mask)
> +{
> +	u32 regval;
> +
> +	regval = mhi_ep_mmio_read(dev, offset);
> +	regval &= mask;
> +	regval >>= __ffs(mask);
> +
> +	return regval;
> +}
> +
> +void mhi_ep_mmio_get_mhi_state(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state *state,
> +				bool *mhi_reset)
> +{
> +	u32 regval;
> +
> +	regval = mhi_ep_mmio_read(mhi_cntrl, MHICTRL);
> +	*state = FIELD_GET(MHICTRL_MHISTATE_MASK, regval);
> +	*mhi_reset = !!FIELD_GET(MHICTRL_RESET_MASK, regval);
> +}
> +

What does "a7" mean to you.  Is it the host, or the SDX AP?
Will "a7" always be the proper name for that CPU?  (Maybe
it will be.)

> +static void mhi_ep_mmio_mask_set_chdb_int_a7(struct mhi_ep_cntrl *mhi_cntrl,
> +						u32 chdb_id, bool enable)

I think "ch_id" would be a better name for the "chdb_id" argument.
If you agree, update other functions so it's consistent.

> +{
> +	u32 chid_mask, chid_idx, chid_shift, val = 0;
> +
> +	chid_shift = chdb_id % 32;
> +	chid_mask = BIT(chid_shift);
> +	chid_idx = chdb_id / 32;

I think "chdb_idx" would be a better name for this.

> +
> +	WARN_ON(chid_idx >= MHI_MASK_ROWS_CH_EV_DB);

Can we tell by inspection that this will never be out
of range?  If not, can we just test it once, early, so
there's no need to ever check later on?

> +
> +	if (enable)
> +		val = 1;

	val = enable ? 1 : 0;

> +	mhi_ep_mmio_masked_write(mhi_cntrl, MHI_CHDB_INT_MASK_A7_n(chid_idx),
> +				  chid_mask, val);
> +
> +	/* Update the local copy of the channel mask */
> +	mhi_cntrl->chdb[chid_idx].mask &= ~chid_mask;
> +	mhi_cntrl->chdb[chid_idx].mask |= val << chid_shift;
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
> +	u32 val = 0, i;
> +
> +	if (enable)
> +		val = MHI_CHDB_INT_MASK_A7_n_EN_ALL;

	val = enable ? MHI_CHDB_INT_MASK_A7_n_EN_ALL : 0;
> +
> +	for (i = 0; i < MHI_MASK_ROWS_CH_EV_DB; i++) {
> +		mhi_ep_mmio_write(mhi_cntrl, MHI_CHDB_INT_MASK_A7_n(i), val);
> +		mhi_cntrl->chdb[i].mask = val;
> +	}
> +}
> +

No more comments on the rest of this file.

. . .

> diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
> index da865f9d3646..3d2ab7a5ccd7 100644
> --- a/include/linux/mhi_ep.h
> +++ b/include/linux/mhi_ep.h

This looks good too.

. . .
