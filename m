Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CEB4B781F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244000AbiBOUDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:03:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244007AbiBOUDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:03:46 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F9C75608
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:03:20 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id h11so15697946ilq.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5UVKn+bO+qKQh9WiZyLZBB2WR7yGx0YI9z0/zEDFpME=;
        b=TMueX0KMuBN87KSHHEYCy8p6UXcle0+Pysef3BEu11kUYgD8Ygxe6lEyx1Ezr8asR+
         IrLNuB1xvTodpvhgbY+oIAJ/tn95MiUPz7P5vd7w32RMPNSIqLAfqxACiC3d6NlT5/Kd
         IQoGlRKzA0LSUAnvJgdcLOG72DtjcalD3DBW7KzLQnTbuGDgRLfwmpEcnnk7Wea2v9fs
         BUb6oR1AcCI7ZRAwKZ7pwqloZSjMeo0ZTKdU3JxxssKYMvNNc2DVoJIx8dnDArwwZ7lo
         FSQ30XBUx8hhn/u9LqfBRPDjitB8vzn6+Y7x9aDHrPd4XmA2gDJKbEz3BIsvZ5obNv1y
         SskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5UVKn+bO+qKQh9WiZyLZBB2WR7yGx0YI9z0/zEDFpME=;
        b=cASTaEWZ0W/AFYhoKedlMs/qotQdDNMJn3PNcrKuvqDrUin8OLNKzRbFKG/tD6lsVA
         PGT/nNXcrZylAO+fmRbJhgsEgdSXBjWBctzRD4ChyuL+i+tascXqC7inZEUjBr/dR0v9
         NhpHswG0Wa/VqqlybAfVTWS/v0T7EvhrMKx6bM3++Uw4xs0Eqr5F71+WgSjeznLeYfNp
         m7gl+ReENvCh/6yJc9yVKh29OYsAOGDAC1HvpKcLMjHdW65aKfIeCrG/Ksl2NSlvxNn/
         m/WsXLtDUmL8OyLb7G2xtFrv7IVWTpom1nBbby2dhm0sjesfmbq1fEXDtKIAn6DiWnZf
         Q/Gw==
X-Gm-Message-State: AOAM533FitdWPwIPfBwZK8rSqn4WmSq/ikRxuoh84PpqjTEHQ1QhFGXA
        uN8CF7ftz2NovlVvb2MSyGwtpA==
X-Google-Smtp-Source: ABdhPJzlNaBBPo0iJ0CJJr6u4iMLS+7ChtII1ADB6h9iYnPtggwxFKi36SPAP5f9bCdX7rla8ndaGA==
X-Received: by 2002:a92:cd86:: with SMTP id r6mr426232ilb.238.1644955395517;
        Tue, 15 Feb 2022 12:03:15 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id f10sm19731489ilj.73.2022.02.15.12.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 12:03:14 -0800 (PST)
Message-ID: <20504c14-6df5-83d1-53e9-85c682a5a3c7@linaro.org>
Date:   Tue, 15 Feb 2022 14:03:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 12/25] bus: mhi: ep: Add support for ring management
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
 <20220212182117.49438-13-manivannan.sadhasivam@linaro.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220212182117.49438-13-manivannan.sadhasivam@linaro.org>
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
> Add support for managing the MHI ring. The MHI ring is a circular queue
> of data structures used to pass the information between host and the
> endpoint.
> 
> MHI support 3 types of rings:
> 
> 1. Transfer ring
> 2. Event ring
> 3. Command ring
> 
> All rings reside inside the host memory and the MHI EP device maps it to
> the device memory using blocks like PCIe iATU. The mapping is handled in
> the MHI EP controller driver itself.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Great explanation.  One more thing to add, is that the command
and transfer rings are directed from the host to the MHI EP device,
while the event rings are directed from the EP device toward the
host.

I notice that you've improved a few things I had notes about,
and I don't recall suggesting them.  I'm very happy about that.

I have a few more comments here, some worth thinking about
at least.

					-Alex

> ---
>   drivers/bus/mhi/ep/Makefile   |   2 +-
>   drivers/bus/mhi/ep/internal.h |  33 +++++
>   drivers/bus/mhi/ep/main.c     |  59 +++++++-
>   drivers/bus/mhi/ep/ring.c     | 267 ++++++++++++++++++++++++++++++++++
>   include/linux/mhi_ep.h        |  11 ++
>   5 files changed, 370 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/bus/mhi/ep/ring.c
> 
> diff --git a/drivers/bus/mhi/ep/Makefile b/drivers/bus/mhi/ep/Makefile
> index a1555ae287ad..7ba0e04801eb 100644
> --- a/drivers/bus/mhi/ep/Makefile
> +++ b/drivers/bus/mhi/ep/Makefile
> @@ -1,2 +1,2 @@
>   obj-$(CONFIG_MHI_BUS_EP) += mhi_ep.o
> -mhi_ep-y := main.o mmio.o
> +mhi_ep-y := main.o mmio.o ring.o
> diff --git a/drivers/bus/mhi/ep/internal.h b/drivers/bus/mhi/ep/internal.h
> index 2c756a90774c..48d6e9667d55 100644
> --- a/drivers/bus/mhi/ep/internal.h
> +++ b/drivers/bus/mhi/ep/internal.h
> @@ -112,6 +112,18 @@ enum mhi_ep_execenv {
>   	MHI_EP_UNRESERVED
>   };
>   
> +/* Transfer Ring Element macros */
> +#define MHI_EP_TRE_PTR(ptr) (ptr)
> +#define MHI_EP_TRE_DWORD0(len) (len & MHI_MAX_MTU)

The above looks funny.  This assumes MHI_MAX_MTU is
a mask value (likely one less than a power-of-2).
That doesn't seem obvious to me; use modulo if you
must, but better, just ensure len is in range rather
than silently truncating it if it's not.

> +#define MHI_EP_TRE_DWORD1(bei, ieot, ieob, chain) ((2 << 16) | (bei << 10) \
> +	| (ieot << 9) | (ieob << 8) | chain)

You should probably use FIELD_PREP() to compute the value
here, since you're using FIELD_GET() to extract the field
values below.

> +#define MHI_EP_TRE_GET_PTR(tre) ((tre)->ptr)
> +#define MHI_EP_TRE_GET_LEN(tre) ((tre)->dword[0] & 0xffff)
> +#define MHI_EP_TRE_GET_CHAIN(tre) FIELD_GET(BIT(0), (tre)->dword[1])

#define	TRE_FLAG_CHAIN	BIT(0)

Then just call
	bei = FIELD_GET(TRE_FLAG_CHAIN, tre->dword[1]);

But I haven't looked at the code where this is used yet.

> +#define MHI_EP_TRE_GET_IEOB(tre) FIELD_GET(BIT(8), (tre)->dword[1])
> +#define MHI_EP_TRE_GET_IEOT(tre) FIELD_GET(BIT(9), (tre)->dword[1])
> +#define MHI_EP_TRE_GET_BEI(tre) FIELD_GET(BIT(10), (tre)->dword[1])
> +

These macros should be shared/shareable between the host and endpoint.
They operate on external interfaces and so should be byte swapped
(where used) when updating actual memory.  Unlike the patches from
Paul Davey early in this series, this does *not* byte swap the
values in the right hand side of these definitions, which is good.

I'm pretty sure I mentioned this before...  I don't really like these
"DWORD" macros that simply write compute register values to write
out to the TREs.  A TRE is a structure, not a set of registers.  And
a whole TRE can be written or read in a single ARM instruction in
some cases--but most likely you need to define it as a structure
for that to happen.

struct mhi_tre {
	__le64 addr;
	__le16 len_opcode
	__le16 reserved;
	__le32 flags;
};

Which reminds me, this shared memory area should probably be mapped
using memremap() rather than ioremap().  I haven't checked whether
it is...

>   enum mhi_ep_ring_type {
>   	RING_TYPE_CMD = 0,
>   	RING_TYPE_ER,
> @@ -131,6 +143,11 @@ union mhi_ep_ring_ctx {
>   	struct mhi_generic_ctx generic;
>   };
>   
> +struct mhi_ep_ring_item {
> +	struct list_head node;
> +	struct mhi_ep_ring *ring;
> +};
> +
>   struct mhi_ep_ring {
>   	struct mhi_ep_cntrl *mhi_cntrl;
>   	int (*ring_cb)(struct mhi_ep_ring *ring, struct mhi_ep_ring_element *el);
> @@ -143,6 +160,9 @@ struct mhi_ep_ring {
>   	u32 db_offset_h;
>   	u32 db_offset_l;
>   	u32 ch_id;
> +	u32 er_index;
> +	u32 irq_vector;
> +	bool started;
>   };
>   
>   struct mhi_ep_cmd {
> @@ -168,6 +188,19 @@ struct mhi_ep_chan {
>   	bool skip_td;
>   };
>   
> +/* MHI Ring related functions */
> +void mhi_ep_ring_init(struct mhi_ep_ring *ring, enum mhi_ep_ring_type type, u32 id);
> +void mhi_ep_ring_reset(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_ring *ring);
> +int mhi_ep_ring_start(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_ring *ring,
> +		      union mhi_ep_ring_ctx *ctx);
> +size_t mhi_ep_ring_addr2offset(struct mhi_ep_ring *ring, u64 ptr);
> +int mhi_ep_process_ring(struct mhi_ep_ring *ring);
> +int mhi_ep_ring_add_element(struct mhi_ep_ring *ring, struct mhi_ep_ring_element *element);
> +void mhi_ep_ring_inc_index(struct mhi_ep_ring *ring);
> +int mhi_ep_process_cmd_ring(struct mhi_ep_ring *ring, struct mhi_ep_ring_element *el);
> +int mhi_ep_process_tre_ring(struct mhi_ep_ring *ring, struct mhi_ep_ring_element *el);
> +int mhi_ep_update_wr_offset(struct mhi_ep_ring *ring);
> +
>   /* MMIO related functions */
>   u32 mhi_ep_mmio_read(struct mhi_ep_cntrl *mhi_cntrl, u32 offset);
>   void mhi_ep_mmio_write(struct mhi_ep_cntrl *mhi_cntrl, u32 offset, u32 val);
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index 950b5bcabe18..2c8045766292 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -18,6 +18,48 @@
>   
>   static DEFINE_IDA(mhi_ep_cntrl_ida);

The following function handles command or channel interrupt work.

> +static void mhi_ep_ring_worker(struct work_struct *work)
> +{
> +	struct mhi_ep_cntrl *mhi_cntrl = container_of(work,
> +				struct mhi_ep_cntrl, ring_work);
> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	struct mhi_ep_ring_item *itr, *tmp;
> +	struct mhi_ep_ring *ring;
> +	struct mhi_ep_chan *chan;
> +	unsigned long flags;
> +	LIST_HEAD(head);
> +	int ret;
> +
> +	/* Process the command ring first */
> +	ret = mhi_ep_process_ring(&mhi_cntrl->mhi_cmd->ring);
> +	if (ret) {

At the moment I'm not sure where this work gets scheduled.
But what if there is no command to process?  It looks
like you go update the cached pointer no matter what
to see if there's anything new.  But it seems like you
ought to be able to do this when interrupted for a
command rather than all the time.

> +		dev_err(dev, "Error processing command ring: %d\n", ret);
> +		return;
> +	}
> +
> +	spin_lock_irqsave(&mhi_cntrl->list_lock, flags);
> +	list_splice_tail_init(&mhi_cntrl->ch_db_list, &head);
> +	spin_unlock_irqrestore(&mhi_cntrl->list_lock, flags);

Here it looks like you at least only process rings that
had a doorbell interrupt.

> +	/* Process the channel rings now */
> +	list_for_each_entry_safe(itr, tmp, &head, node) {
> +		list_del(&itr->node);
> +		ring = itr->ring;
> +		chan = &mhi_cntrl->mhi_chan[ring->ch_id];
> +		mutex_lock(&chan->lock);
> +		dev_dbg(dev, "Processing the ring for channel (%d)\n", ring->ch_id);

s/%d/%u/

Look for this everywhere.  It avoids printing negative values when
the high bit is set.  (Likely not a problem here.)

> +		ret = mhi_ep_process_ring(ring);
> +		if (ret) {
> +			dev_err(dev, "Error processing ring for channel (%d): %d\n",
> +				ring->ch_id, ret);
> +			mutex_unlock(&chan->lock);

I think you should report the error but continue processing
all entries (otherwise they'll get leaked).

> +			return;
> +		}
> +		mutex_unlock(&chan->lock);
> +		kfree(itr);
> +	}
> +}
> +
>   static void mhi_ep_release_device(struct device *dev)
>   {
>   	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
> @@ -218,6 +260,17 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
>   		goto err_free_ch;
>   	}
>   
> +	INIT_WORK(&mhi_cntrl->ring_work, mhi_ep_ring_worker);
> +
> +	mhi_cntrl->ring_wq = alloc_workqueue("mhi_ep_ring_wq", 0, 0);
> +	if (!mhi_cntrl->ring_wq) {
> +		ret = -ENOMEM;
> +		goto err_free_cmd;
> +	}
> +
> +	INIT_LIST_HEAD(&mhi_cntrl->ch_db_list);
> +	spin_lock_init(&mhi_cntrl->list_lock);
> +
>   	/* Set MHI version and AMSS EE before enumeration */
>   	mhi_ep_mmio_write(mhi_cntrl, MHIVER, config->mhi_version);
>   	mhi_ep_mmio_set_env(mhi_cntrl, MHI_EP_AMSS_EE);
> @@ -226,7 +279,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
>   	mhi_cntrl->index = ida_alloc(&mhi_ep_cntrl_ida, GFP_KERNEL);
>   	if (mhi_cntrl->index < 0) {
>   		ret = mhi_cntrl->index;
> -		goto err_free_cmd;
> +		goto err_destroy_ring_wq;
>   	}
>   
>   	/* Allocate the controller device */
> @@ -254,6 +307,8 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
>   	put_device(&mhi_dev->dev);
>   err_ida_free:
>   	ida_free(&mhi_ep_cntrl_ida, mhi_cntrl->index);
> +err_destroy_ring_wq:
> +	destroy_workqueue(mhi_cntrl->ring_wq);
>   err_free_cmd:
>   	kfree(mhi_cntrl->mhi_cmd);
>   err_free_ch:
> @@ -267,6 +322,8 @@ void mhi_ep_unregister_controller(struct mhi_ep_cntrl *mhi_cntrl)
>   {
>   	struct mhi_ep_device *mhi_dev = mhi_cntrl->mhi_dev;
>   
> +	destroy_workqueue(mhi_cntrl->ring_wq);
> +
>   	kfree(mhi_cntrl->mhi_cmd);
>   	kfree(mhi_cntrl->mhi_chan);
>   
> diff --git a/drivers/bus/mhi/ep/ring.c b/drivers/bus/mhi/ep/ring.c
> new file mode 100644
> index 000000000000..3eb02c9be5eb
> --- /dev/null
> +++ b/drivers/bus/mhi/ep/ring.c
> @@ -0,0 +1,267 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2021 Linaro Ltd.
> + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> + */
> +
> +#include <linux/mhi_ep.h>
> +#include "internal.h"
> +
> +size_t mhi_ep_ring_addr2offset(struct mhi_ep_ring *ring, u64 ptr)
> +{
> +	u64 rbase;
> +
> +	rbase = le64_to_cpu(ring->ring_ctx->generic.rbase);
> +
> +	return (ptr - rbase) / sizeof(struct mhi_ep_ring_element);
> +}
> +
> +static u32 mhi_ep_ring_num_elems(struct mhi_ep_ring *ring)
> +{
> +	return le64_to_cpu(ring->ring_ctx->generic.rlen) / sizeof(struct mhi_ep_ring_element);
> +}
> +
> +void mhi_ep_ring_inc_index(struct mhi_ep_ring *ring)
> +{
> +	ring->rd_offset++;
> +	if (ring->rd_offset == ring->ring_size)
> +		ring->rd_offset = 0;

Maybe:
	ring->rd_offset = (ring->rd_offset + 1) % ring->ring_size;

> +}
> +
> +static int __mhi_ep_cache_ring(struct mhi_ep_ring *ring, size_t end)
> +{
> +	struct mhi_ep_cntrl *mhi_cntrl = ring->mhi_cntrl;
> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	size_t start, copy_size;
> +	int ret;
> +
> +	/* No need to cache event rings */
> +	if (ring->type == RING_TYPE_ER)
> +		return 0;

Does this ever happen--a request to cache an event ring?
This seems pointless if we can tell by inspection it
won't happen.

> +
> +	/* No need to cache the ring if write pointer is unmodified */
> +	if (ring->wr_offset == end)
> +		return 0;
> +
> +	start = ring->wr_offset;
> +	if (start < end) {
> +		copy_size = (end - start) * sizeof(struct mhi_ep_ring_element);
> +		ret = mhi_cntrl->read_from_host(mhi_cntrl,
> +						(le64_to_cpu(ring->ring_ctx->generic.rbase) +
> +						(start * sizeof(struct mhi_ep_ring_element))),
> +						&ring->ring_cache[start], copy_size);
> +		if (ret < 0)
> +			return ret;
> +	} else {
> +		copy_size = (ring->ring_size - start) * sizeof(struct mhi_ep_ring_element);
> +		ret = mhi_cntrl->read_from_host(mhi_cntrl,
> +						(le64_to_cpu(ring->ring_ctx->generic.rbase) +
> +						(start * sizeof(struct mhi_ep_ring_element))),
> +						&ring->ring_cache[start], copy_size);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (end) {
> +			ret = mhi_cntrl->read_from_host(mhi_cntrl,
> +							le64_to_cpu(ring->ring_ctx->generic.rbase),
> +							&ring->ring_cache[0],
> +							end * sizeof(struct mhi_ep_ring_element));
> +			if (ret < 0)
> +				return ret;
> +		}
> +	}
> +
> +	dev_dbg(dev, "Cached ring: start %zu end %zu size %zu\n", start, end, copy_size);
> +
> +	return 0;
> +}
> +
> +static int mhi_ep_cache_ring(struct mhi_ep_ring *ring, u64 wr_ptr)
> +{
> +	size_t wr_offset;
> +	int ret;
> +
> +	wr_offset = mhi_ep_ring_addr2offset(ring, wr_ptr);
> +
> +	/* Cache the host ring till write offset */
> +	ret = __mhi_ep_cache_ring(ring, wr_offset);
> +	if (ret)
> +		return ret;
> +
> +	ring->wr_offset = wr_offset;
> +
> +	return 0;
> +}
> +
> +int mhi_ep_update_wr_offset(struct mhi_ep_ring *ring)
> +{
> +	u64 wr_ptr;
> +
> +	wr_ptr = mhi_ep_mmio_get_db(ring);
> +
> +	return mhi_ep_cache_ring(ring, wr_ptr);
> +}
> +
> +static int mhi_ep_process_ring_element(struct mhi_ep_ring *ring, size_t offset)
> +{
> +	struct mhi_ep_ring_element *el;
> +
> +	/* Get the element and invoke the respective callback */
> +	el = &ring->ring_cache[offset];
> +
> +	return ring->ring_cb(ring, el);
> +}
> +
> +int mhi_ep_process_ring(struct mhi_ep_ring *ring)
> +{
> +	struct mhi_ep_cntrl *mhi_cntrl = ring->mhi_cntrl;
> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	int ret = 0;
> +
> +	/* Event rings should not be processed */
> +	if (ring->type == RING_TYPE_ER)
> +		return -EINVAL;
> +
> +	dev_dbg(dev, "Processing ring of type: %d\n", ring->type);
> +
> +	/* Update the write offset for the ring */
> +	ret = mhi_ep_update_wr_offset(ring);
> +	if (ret) {
> +		dev_err(dev, "Error updating write offset for ring\n");
> +		return ret;
> +	}
> +
> +	/* Sanity check to make sure there are elements in the ring */
> +	if (ring->rd_offset == ring->wr_offset)
> +		return 0;
> +
> +	/* Process channel ring first */
> +	if (ring->type == RING_TYPE_CH) {
> +		ret = mhi_ep_process_ring_element(ring, ring->rd_offset);
> +		if (ret)
> +			dev_err(dev, "Error processing ch ring element: %zu\n", ring->rd_offset);
> +
> +		return ret;
> +	}
> +
> +	/* Process command ring now */
> +	while (ring->rd_offset != ring->wr_offset) {
> +		ret = mhi_ep_process_ring_element(ring, ring->rd_offset);
> +		if (ret) {
> +			dev_err(dev, "Error processing cmd ring element: %zu\n", ring->rd_offset);
> +			return ret;
> +		}
> +
> +		mhi_ep_ring_inc_index(ring);
> +	}
> +
> +	return 0;
> +}
> +
> +/* TODO: Support for adding multiple ring elements to the ring */
> +int mhi_ep_ring_add_element(struct mhi_ep_ring *ring, struct mhi_ep_ring_element *el)
> +{
> +	struct mhi_ep_cntrl *mhi_cntrl = ring->mhi_cntrl;
> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	__le64 rbase = ring->ring_ctx->generic.rbase;
> +	size_t old_offset = 0;
> +	u32 num_free_elem;
> +	int ret;
> +
> +	ret = mhi_ep_update_wr_offset(ring);
> +	if (ret) {
> +		dev_err(dev, "Error updating write pointer\n");
> +		return ret;
> +	}
> +
> +	if (ring->rd_offset < ring->wr_offset)
> +		num_free_elem = (ring->wr_offset - ring->rd_offset) - 1;
> +	else
> +		num_free_elem = ((ring->ring_size - ring->rd_offset) + ring->wr_offset) - 1;
> +
> +	/* Check if there is space in ring for adding at least an element */
> +	if (!num_free_elem) {
> +		dev_err(dev, "No space left in the ring\n");
> +		return -ENOSPC;
> +	}
> +
> +	old_offset = ring->rd_offset;
> +	mhi_ep_ring_inc_index(ring);
> +
> +	dev_dbg(dev, "Adding an element to ring at offset (%zu)\n", ring->rd_offset);
> +
> +	/* Update rp in ring context */
> +	ring->ring_ctx->generic.rp = cpu_to_le64((ring->rd_offset * sizeof(*el))) + rbase;

Is it valid to add a byte swapped value to a byte swapped value?
It seems odd to me, even if the result is correct.  I think you
should add the values, then byte swap them when assigning.

> +
> +	/* Ensure that the ring pointer gets updated before writing the element to ring */
> +	smp_wmb();
> +
> +	ret = mhi_cntrl->write_to_host(mhi_cntrl, el, (le64_to_cpu(rbase) +
> +				       (old_offset * sizeof(*el))), sizeof(*el));

Unneeded extra parenthese around the third argument.

> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +void mhi_ep_ring_init(struct mhi_ep_ring *ring, enum mhi_ep_ring_type type, u32 id)
> +{
> +	ring->type = type;
> +	if (ring->type == RING_TYPE_CMD) {
> +		ring->ring_cb = mhi_ep_process_cmd_ring;
> +		ring->db_offset_h = CRDB_HIGHER;
> +		ring->db_offset_l = CRDB_LOWER;
> +	} else if (ring->type == RING_TYPE_CH) {
> +		ring->ring_cb = mhi_ep_process_tre_ring;
> +		ring->db_offset_h = CHDB_HIGHER_n(id);
> +		ring->db_offset_l = CHDB_LOWER_n(id);
> +		ring->ch_id = id;
> +	} else {
> +		ring->db_offset_h = ERDB_HIGHER_n(id);
> +		ring->db_offset_l = ERDB_LOWER_n(id);
> +	}
> +}
> +
> +int mhi_ep_ring_start(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_ring *ring,
> +			union mhi_ep_ring_ctx *ctx)
> +{
> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	int ret;
> +
> +	ring->mhi_cntrl = mhi_cntrl;
> +	ring->ring_ctx = ctx;
> +	ring->ring_size = mhi_ep_ring_num_elems(ring);
> +
> +	if (ring->type == RING_TYPE_CH)
> +		ring->er_index = le32_to_cpu(ring->ring_ctx->ch.erindex);
> +
> +	if (ring->type == RING_TYPE_ER)
> +		ring->irq_vector = le32_to_cpu(ring->ring_ctx->ev.msivec);
> +
> +	/* During ring init, both rp and wp are equal */
> +	ring->rd_offset = mhi_ep_ring_addr2offset(ring, le64_to_cpu(ring->ring_ctx->generic.rp));
> +	ring->wr_offset = mhi_ep_ring_addr2offset(ring, le64_to_cpu(ring->ring_ctx->generic.rp));
> +
> +	/* Allocate ring cache memory for holding the copy of host ring */
> +	ring->ring_cache = kcalloc(ring->ring_size, sizeof(struct mhi_ep_ring_element),
> +				   GFP_KERNEL);
> +	if (!ring->ring_cache)
> +		return -ENOMEM;
> +
> +	ret = mhi_ep_cache_ring(ring, le64_to_cpu(ring->ring_ctx->generic.wp));
> +	if (ret) {
> +		dev_err(dev, "Failed to cache ring\n");
> +		kfree(ring->ring_cache);
> +		return ret;
> +	}
> +
> +	ring->started = true;
> +
> +	return 0;
> +}
> +
> +void mhi_ep_ring_reset(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_ring *ring)
> +{
> +	ring->started = false;
> +	kfree(ring->ring_cache);

Maybe you'll never reuse this, but it seems that a reset
might mean we'll reuse the ring.  In that case it might
be useful to set the ring_cache pointer to NULL, so we
guarantee never to use the freed memory (we'll crash with
a null pointer dereference if there's a bug).

> +}
> diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
> index 3d2ab7a5ccd7..33828a6c4e63 100644
> --- a/include/linux/mhi_ep.h
> +++ b/include/linux/mhi_ep.h
> @@ -62,6 +62,11 @@ struct mhi_ep_db_info {
>    * @ch_ctx_host_pa: Physical address of host channel context data structure
>    * @ev_ctx_host_pa: Physical address of host event context data structure
>    * @cmd_ctx_host_pa: Physical address of host command context data structure
> + * @ring_wq: Dedicated workqueue for processing MHI rings
> + * @ring_work: Ring worker
> + * @ch_db_list: List of queued channel doorbells
> + * @st_transition_list: List of state transitions
> + * @list_lock: Lock for protecting state transition and channel doorbell lists
>    * @chdb: Array of channel doorbell interrupt info
>    * @raise_irq: CB function for raising IRQ to the host
>    * @alloc_addr: CB function for allocating memory in endpoint for storing host context
> @@ -93,6 +98,12 @@ struct mhi_ep_cntrl {
>   	u64 ev_ctx_host_pa;
>   	u64 cmd_ctx_host_pa;
>   
> +	struct workqueue_struct	*ring_wq;
> +	struct work_struct ring_work;
> +
> +	struct list_head ch_db_list;
> +	struct list_head st_transition_list;
> +	spinlock_t list_lock;
>   	struct mhi_ep_db_info chdb[4];
>   
>   	void (*raise_irq)(struct mhi_ep_cntrl *mhi_cntrl, u32 vector);

