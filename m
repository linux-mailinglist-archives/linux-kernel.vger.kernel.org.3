Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441BC4B7A8B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237168AbiBOWjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:39:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbiBOWjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:39:32 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F64C0848
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:39:20 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id s1so116246iob.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0NCefjHL0aciOj3WmwkeznTZGAyUpobYxe+pW9I0SwA=;
        b=IDB7dnMeQsAlBFU1buKUPfDx7DjqZllS6v+zPGZFEB+87IVtmPmpzafYXaZ1YDEA51
         JPf2z7uU/v+V2/lwEy/O6bG20rDBuveTsrvQD+yE7esuM1LWdP3aYQwh0xuD8pDoltMf
         kw9EL7VRmmp/XdjhQ2yyNLwtkbK2IqnNZMnp5Q99hMue72UN5kqB0htRrHfJ4WzNb6Tt
         A32mzDld9SAykti6ei+NN9VqTFJB0u72oE9EqE7IXVSucUgxfLY7ty4J+SbOMx5gmx1c
         v0BOG++ooM5GilB2nMTQLX0Xof5DQrJ4n4H1cAyHj+WStUfRnBuGW0zQuoVLjSfPKaKN
         CcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0NCefjHL0aciOj3WmwkeznTZGAyUpobYxe+pW9I0SwA=;
        b=rTiiplj2CEZs1B4sWTZbtDnR4jr74IY80+V4C530ap3JIJhb85lRy254XpTgclmOXO
         D6mD+fQPSHpM49j6wCvggo0uyn/pkEIykdhgBY6nXHwLVxLUGLy7s+6CrvJnPtSr3ZEB
         5kjJ02ny4CKqCjqW5F90m5p4R0wWik6rzlyLr/VFJe5sgqfYv+6YsIu9gRr2NUXAd0FI
         IemuoDmefDYxF5gkKgeU/DooUK7lTKv9sXvc5LpC8IqOzy0etCqUATwgDs7LGvbrKuCq
         kOQ+umxtsd/uJiwiAnUS28820H2uke2U+9hqYJ9mosoZMsp694Y49BGcvOrbX3j3gS4d
         QWXg==
X-Gm-Message-State: AOAM531J83H9im/4Lf1vBa3o7fnrjTjyFZZ0r8qg4on7/N4sex5jFKEx
        ynE6t1Rh06NDOcQ0cwxqaKKb1Q==
X-Google-Smtp-Source: ABdhPJzImD2raOCQWXFbglufoGJomifdzEbJDDHc/aap00EAlaI8944KnapVaW+7djwfb/8Ux6i8Vw==
X-Received: by 2002:a05:6638:2492:: with SMTP id x18mr695722jat.164.1644964758784;
        Tue, 15 Feb 2022 14:39:18 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id c12sm3210646ilo.70.2022.02.15.14.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 14:39:18 -0800 (PST)
Message-ID: <3396cc98-8640-8f5a-fad3-c7a913faaa58@linaro.org>
Date:   Tue, 15 Feb 2022 16:39:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 13/25] bus: mhi: ep: Add support for sending events to
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
 <20220212182117.49438-14-manivannan.sadhasivam@linaro.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220212182117.49438-14-manivannan.sadhasivam@linaro.org>
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
> Add support for sending the events to the host over MHI bus from the
> endpoint. Following events are supported:
> 
> 1. Transfer completion event
> 2. Command completion event
> 3. State change event
> 4. Execution Environment (EE) change event
> 
> An event is sent whenever an operation has been completed in the MHI EP
> device. Event is sent using the MHI event ring and additionally the host
> is notified using an IRQ if required.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

A few things can be simplified here.

					-Alex

> ---
>   drivers/bus/mhi/common.h      |  15 ++++
>   drivers/bus/mhi/ep/internal.h |   8 ++-
>   drivers/bus/mhi/ep/main.c     | 126 ++++++++++++++++++++++++++++++++++
>   include/linux/mhi_ep.h        |   8 +++
>   4 files changed, 155 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
> index 728c82928d8d..26d94ed52b34 100644
> --- a/drivers/bus/mhi/common.h
> +++ b/drivers/bus/mhi/common.h
> @@ -176,6 +176,21 @@
>   #define MHI_TRE_GET_EV_LINKSPEED(tre)			((MHI_TRE_GET_DWORD(tre, 1) >> 24) & 0xFF)
>   #define MHI_TRE_GET_EV_LINKWIDTH(tre)			(MHI_TRE_GET_DWORD(tre, 0) & 0xFF)
>   
> +/* State change event */
> +#define MHI_SC_EV_PTR					0
> +#define MHI_SC_EV_DWORD0(state)				cpu_to_le32(state << 24)
> +#define MHI_SC_EV_DWORD1(type)				cpu_to_le32(type << 16)
> +
> +/* EE event */
> +#define MHI_EE_EV_PTR					0
> +#define MHI_EE_EV_DWORD0(ee)				cpu_to_le32(ee << 24)
> +#define MHI_EE_EV_DWORD1(type)				cpu_to_le32(type << 16)
> +
> +/* Command Completion event */
> +#define MHI_CC_EV_PTR(ptr)				cpu_to_le64(ptr)
> +#define MHI_CC_EV_DWORD0(code)				cpu_to_le32(code << 24)
> +#define MHI_CC_EV_DWORD1(type)				cpu_to_le32(type << 16)
> +
>   /* Transfer descriptor macros */
>   #define MHI_TRE_DATA_PTR(ptr)				cpu_to_le64(ptr)
>   #define MHI_TRE_DATA_DWORD0(len)			cpu_to_le32(len & MHI_MAX_MTU)
> diff --git a/drivers/bus/mhi/ep/internal.h b/drivers/bus/mhi/ep/internal.h
> index 48d6e9667d55..fd63f79c6aec 100644
> --- a/drivers/bus/mhi/ep/internal.h
> +++ b/drivers/bus/mhi/ep/internal.h
> @@ -131,8 +131,8 @@ enum mhi_ep_ring_type {
>   };
>   
>   struct mhi_ep_ring_element {
> -	u64 ptr;
> -	u32 dword[2];
> +	__le64 ptr;
> +	__le32 dword[2];

Yay!

>   };
>   
>   /* Ring element */
> @@ -227,4 +227,8 @@ void mhi_ep_mmio_get_mhi_state(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state *s
>   void mhi_ep_mmio_init(struct mhi_ep_cntrl *mhi_cntrl);
>   void mhi_ep_mmio_update_ner(struct mhi_ep_cntrl *mhi_cntrl);
>   
> +/* MHI EP core functions */
> +int mhi_ep_send_state_change_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state state);
> +int mhi_ep_send_ee_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_ep_execenv exec_env);
> +
>   #endif
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index 2c8045766292..61f066c6286b 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -18,6 +18,131 @@
>   
>   static DEFINE_IDA(mhi_ep_cntrl_ida);
>   
> +static int mhi_ep_send_event(struct mhi_ep_cntrl *mhi_cntrl, u32 ring_idx,
> +			     struct mhi_ep_ring_element *el)
> +{
> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	union mhi_ep_ring_ctx *ctx;
> +	struct mhi_ep_ring *ring;
> +	int ret;
> +
> +	mutex_lock(&mhi_cntrl->event_lock);
> +	ring = &mhi_cntrl->mhi_event[ring_idx].ring;
> +	ctx = (union mhi_ep_ring_ctx *)&mhi_cntrl->ev_ctx_cache[ring_idx];
> +	if (!ring->started) {
> +		ret = mhi_ep_ring_start(mhi_cntrl, ring, ctx);
> +		if (ret) {
> +			dev_err(dev, "Error starting event ring (%d)\n", ring_idx);
> +			goto err_unlock;
> +		}
> +	}
> +
> +	/* Add element to the event ring */
> +	ret = mhi_ep_ring_add_element(ring, el);
> +	if (ret) {
> +		dev_err(dev, "Error adding element to event ring (%d)\n", ring_idx);
> +		goto err_unlock;
> +	}
> +
> +	/* Ensure that the ring pointer gets updated in host memory before triggering IRQ */
> +	smp_wmb();

I think the barrier might already be provided by the mutex_unlock().

> +
> +	mutex_unlock(&mhi_cntrl->event_lock);
> +
> +	/*
> +	 * Raise IRQ to host only if the BEI flag is not set in TRE. Host might
> +	 * set this flag for interrupt moderation as per MHI protocol.
> +	 */

I don't think the BEI flag is meaningful in an event ring element.
You'd want to determine if it was present in the *transfer* ring
element for which this event is signaling the completion.

> +	if (!MHI_EP_TRE_GET_BEI(el))
> +		mhi_cntrl->raise_irq(mhi_cntrl, ring->irq_vector);
> +
> +	return 0;
> +
> +err_unlock:
> +	mutex_unlock(&mhi_cntrl->event_lock);
> +
> +	return ret;
> +}
> +
> +static int mhi_ep_send_completion_event(struct mhi_ep_cntrl *mhi_cntrl,
> +					struct mhi_ep_ring *ring, u32 len,
> +					enum mhi_ev_ccs code)
> +{
> +	struct mhi_ep_ring_element event = {};
> +	__le32 tmp;
> +
> +	event.ptr = le64_to_cpu(ring->ring_ctx->generic.rbase) +
> +			ring->rd_offset * sizeof(struct mhi_ep_ring_element);

I'm not sure at the moment where this will be called.  But
it might be easier to pass in the transfer channel pointer
rather than compute its address here.

> +
> +	tmp = event.dword[0];

You already know event.dword[0] is zero.  No need to read
its value here (or that of dword[1] below).

> +	tmp |= MHI_TRE_EV_DWORD0(code, len);
> +	event.dword[0] = tmp;
> +
> +	tmp = event.dword[1];
> +	tmp |= MHI_TRE_EV_DWORD1(ring->ch_id, MHI_PKT_TYPE_TX_EVENT);
> +	event.dword[1] = tmp;
> +
> +	return mhi_ep_send_event(mhi_cntrl, ring->er_index, &event);
> +}
> +
> +int mhi_ep_send_state_change_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state state)
> +{
> +	struct mhi_ep_ring_element event = {};
> +	__le32 tmp;
> +
> +	tmp = event.dword[0];

No need to read a known zero value.  (Fix this througout.)

> +	tmp |= MHI_SC_EV_DWORD0(state);
> +	event.dword[0] = tmp;
> +
> +	tmp = event.dword[1];
> +	tmp |= MHI_SC_EV_DWORD1(MHI_PKT_TYPE_STATE_CHANGE_EVENT);
> +	event.dword[1] = tmp;
> +
> +	return mhi_ep_send_event(mhi_cntrl, 0, &event);
> +}
> +
> +int mhi_ep_send_ee_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_ep_execenv exec_env)
> +{
> +	struct mhi_ep_ring_element event = {};
> +	__le32 tmp;
> +
> +	tmp = event.dword[0];
> +	tmp |= MHI_EE_EV_DWORD0(exec_env);
> +	event.dword[0] = tmp;
> +
> +	tmp = event.dword[1];
> +	tmp |= MHI_SC_EV_DWORD1(MHI_PKT_TYPE_EE_EVENT);
> +	event.dword[1] = tmp;
> +
> +	return mhi_ep_send_event(mhi_cntrl, 0, &event);
> +}
> +
> +static int mhi_ep_send_cmd_comp_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_ev_ccs code)
> +{
> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	struct mhi_ep_ring_element event = {};
> +	__le32 tmp;
> +
> +	if (code > MHI_EV_CC_BAD_TRE) {

I think you can probably guarantee this won't ever happen

> +		dev_err(dev, "Invalid command completion code (%d)\n", code);
> +		return -EINVAL;
> +	}
> +
> +	event.ptr = le64_to_cpu(mhi_cntrl->cmd_ctx_cache->rbase)
> +			+ (mhi_cntrl->mhi_cmd->ring.rd_offset *
> +			(sizeof(struct mhi_ep_ring_element)));

No need for the parentheses around the sizeof() call.  Here too
it might be easier and clearer to pass in the command ring element
this event is signaling the completion of.

> +
> +	tmp = event.dword[0];
> +	tmp |= MHI_CC_EV_DWORD0(code);
> +	event.dword[0] = tmp;
> +
> +	tmp = event.dword[1];
> +	tmp |= MHI_CC_EV_DWORD1(MHI_PKT_TYPE_CMD_COMPLETION_EVENT);
> +	event.dword[1] = tmp;
> +
> +	return mhi_ep_send_event(mhi_cntrl, 0, &event);
> +}
> +
>   static void mhi_ep_ring_worker(struct work_struct *work)
>   {
>   	struct mhi_ep_cntrl *mhi_cntrl = container_of(work,
> @@ -270,6 +395,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
>   
>   	INIT_LIST_HEAD(&mhi_cntrl->ch_db_list);
>   	spin_lock_init(&mhi_cntrl->list_lock);
> +	mutex_init(&mhi_cntrl->event_lock);
>   
>   	/* Set MHI version and AMSS EE before enumeration */
>   	mhi_ep_mmio_write(mhi_cntrl, MHIVER, config->mhi_version);
> diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
> index 33828a6c4e63..062133a68118 100644
> --- a/include/linux/mhi_ep.h
> +++ b/include/linux/mhi_ep.h
> @@ -59,6 +59,9 @@ struct mhi_ep_db_info {
>    * @mhi_event: Points to the event ring configurations table
>    * @mhi_cmd: Points to the command ring configurations table
>    * @sm: MHI Endpoint state machine
> + * @ch_ctx_cache: Cache of host channel context data structure
> + * @ev_ctx_cache: Cache of host event context data structure
> + * @cmd_ctx_cache: Cache of host command context data structure
>    * @ch_ctx_host_pa: Physical address of host channel context data structure
>    * @ev_ctx_host_pa: Physical address of host event context data structure
>    * @cmd_ctx_host_pa: Physical address of host command context data structure
> @@ -67,6 +70,7 @@ struct mhi_ep_db_info {
>    * @ch_db_list: List of queued channel doorbells
>    * @st_transition_list: List of state transitions
>    * @list_lock: Lock for protecting state transition and channel doorbell lists
> + * @event_lock: Lock for protecting event rings
>    * @chdb: Array of channel doorbell interrupt info
>    * @raise_irq: CB function for raising IRQ to the host
>    * @alloc_addr: CB function for allocating memory in endpoint for storing host context
> @@ -94,6 +98,9 @@ struct mhi_ep_cntrl {
>   	struct mhi_ep_cmd *mhi_cmd;
>   	struct mhi_ep_sm *sm;
>   
> +	struct mhi_chan_ctxt *ch_ctx_cache;
> +	struct mhi_event_ctxt *ev_ctx_cache;
> +	struct mhi_cmd_ctxt *cmd_ctx_cache;
>   	u64 ch_ctx_host_pa;
>   	u64 ev_ctx_host_pa;
>   	u64 cmd_ctx_host_pa;
> @@ -104,6 +111,7 @@ struct mhi_ep_cntrl {
>   	struct list_head ch_db_list;
>   	struct list_head st_transition_list;
>   	spinlock_t list_lock;
> +	struct mutex event_lock;
>   	struct mhi_ep_db_info chdb[4];
>   
>   	void (*raise_irq)(struct mhi_ep_cntrl *mhi_cntrl, u32 vector);

