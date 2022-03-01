Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2B04C843A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 07:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbiCAGmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 01:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbiCAGmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 01:42:15 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA9D583B1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 22:41:34 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id z4so13614644pgh.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 22:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=InAZmAMB2EBIfdWcEEf0JofPW20Wpd8LRNGnhF7kPbs=;
        b=B7fb8aGFeDFXOEeCfZj/nNAct7zKzWJOyjVo12/VKnYysq2h4QYMFdKy983nKX/jUf
         nTMdKvKRvOyyFdDVUqWlNBqQXAjbk1bonG3hX9MmLCJw2YhZFmQPVBkZbHmGICqH9kF2
         m2H7XtV258bi6QKAP1JrtmgVIw6vE9NmA9jf4EIZTwpm+WFqzNVRmBbrpeJkQqn4eEIF
         L36RST41sx/kdGJAupB626XeBpJ/nDuGufzo9RIhpcb8094D5c9zZ5eenEw55oD97p7m
         gtgDIrfX68xfhxXkcZvv9sioK3KYvS0zaNr/htT2pLKcW4YHc5/JREVVH3+V6xymcfLs
         hVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=InAZmAMB2EBIfdWcEEf0JofPW20Wpd8LRNGnhF7kPbs=;
        b=rIBSfDAY3O2LLgyVbsI9iusKGQPuSAR0lYMx0srmWCdGJbM4CJNcmNlhl6Iwh8QBA1
         g9JY/BURT8s4sFJLz9yGIDwVTSPa96bkaOQLLBfwDhGrhGgzlm7WC0YXeVSU5iXUjxsy
         rP2lulTthDR2SbcCME9lcTs+d+NFUuyinFHr04AgZssXyHCkZNZ7IRhCDLDi6nTa0Yxq
         uaSUn+ZxHVFActgMv89RcXkJ/SZ5nX5fO1kM15zzTuTrcGWErU67NWyUjBY70OALytOa
         t+vjP4jUl9s9S2576KrWBS3WKAwV/knNdVH8OxAmu4nypvJFYg1JNdJmdUeopfFe9hlW
         AORg==
X-Gm-Message-State: AOAM530wW7DhJxnn97WgJ5m84wpwvoMnGaWDuvcroPu4MzLYbrswUF1/
        G7OrAxY5KbJPL5BZa5Y97dV8
X-Google-Smtp-Source: ABdhPJxox4MM6hAazw3C783WMUxznpatQbH85mhnrFWWVTeSbnAMeTz+NyiBsQjriKxl8C+LEGxOYQ==
X-Received: by 2002:a05:6a00:1494:b0:4f0:ece9:a01c with SMTP id v20-20020a056a00149400b004f0ece9a01cmr25416030pfu.58.1646116894276;
        Mon, 28 Feb 2022 22:41:34 -0800 (PST)
Received: from workstation ([117.207.25.80])
        by smtp.gmail.com with ESMTPSA id h3-20020a056a00170300b004f104c635e4sm16308420pfc.99.2022.02.28.22.41.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Feb 2022 22:41:33 -0800 (PST)
Date:   Tue, 1 Mar 2022 12:11:28 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     mhi@lists.linux.dev, quic_hemantk@quicinc.com,
        quic_bbhatt@quicinc.com, quic_jhugo@quicinc.com,
        vinod.koul@linaro.org, bjorn.andersson@linaro.org,
        dmitry.baryshkov@linaro.org, quic_vbadigan@quicinc.com,
        quic_cang@quicinc.com, quic_skananth@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 17/27] bus: mhi: ep: Add support for processing MHI
 endpoint interrupts
Message-ID: <20220301064128.GD12451@workstation>
References: <20220228124344.77359-1-manivannan.sadhasivam@linaro.org>
 <20220228124344.77359-18-manivannan.sadhasivam@linaro.org>
 <3c611baf-1be9-4bf2-86c9-30a3b935a86b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c611baf-1be9-4bf2-86c9-30a3b935a86b@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 10:45:15AM -0600, Alex Elder wrote:
> On 2/28/22 6:43 AM, Manivannan Sadhasivam wrote:
> > Add support for processing MHI endpoint interrupts such as control
> > interrupt, command interrupt and channel interrupt from the host.
> > 
> > The interrupts will be generated in the endpoint device whenever host
> > writes to the corresponding doorbell registers. The doorbell logic
> > is handled inside the hardware internally.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> One suggestion for future work, but otherwise this looks good.
> 
> Reviewed-by: Alex Elder <elder@linaro.org>
> 
> > ---
> >   drivers/bus/mhi/ep/main.c | 123 +++++++++++++++++++++++++++++++++++++-
> >   include/linux/mhi_ep.h    |   4 ++
> >   2 files changed, 125 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> > index 7a29543586d0..ce690b1aeace 100644
> > --- a/drivers/bus/mhi/ep/main.c
> > +++ b/drivers/bus/mhi/ep/main.c
> > @@ -143,6 +143,112 @@ static void mhi_ep_state_worker(struct work_struct *work)
> >   	}
> >   }
> > +static void mhi_ep_queue_channel_db(struct mhi_ep_cntrl *mhi_cntrl, unsigned long ch_int,
> > +				    u32 ch_idx)
> > +{
> > +	struct mhi_ep_ring_item *item;
> > +	struct mhi_ep_ring *ring;
> > +	bool work = !!ch_int;
> > +	LIST_HEAD(head);
> > +	u32 i;
> > +
> > +	/* First add the ring items to a local list */
> > +	for_each_set_bit(i, &ch_int, 32) {
> > +		/* Channel index varies for each register: 0, 32, 64, 96 */
> > +		u32 ch_id = ch_idx + i;
> > +
> > +		ring = &mhi_cntrl->mhi_chan[ch_id].ring;
> > +		item = kzalloc(sizeof(*item), GFP_ATOMIC);
> 
> It looks like this will be used a lot, so I suggest you
> consider creating a slab cache of ring items to allocate
> from.  I haven't suggested that elsewhere, but it's
> possible there are other frequently-allocated structures
> that would warrant that.
> 

Sure.

Thanks,
Mani

> > +		if (!item)
> > +			return;
> > +
> > +		item->ring = ring;
> > +		list_add_tail(&item->node, &head);
> > +	}
> > +
> > +	/* Now, splice the local list into ch_db_list and queue the work item */
> > +	if (work) {
> > +		spin_lock(&mhi_cntrl->list_lock);
> > +		list_splice_tail_init(&head, &mhi_cntrl->ch_db_list);
> > +		spin_unlock(&mhi_cntrl->list_lock);
> > +	}
> > +}
> > +
> > +/*
> > + * Channel interrupt statuses are contained in 4 registers each of 32bit length.
> > + * For checking all interrupts, we need to loop through each registers and then
> > + * check for bits set.
> > + */
> > +static void mhi_ep_check_channel_interrupt(struct mhi_ep_cntrl *mhi_cntrl)
> > +{
> > +	u32 ch_int, ch_idx, i;
> > +
> > +	/* Bail out if there is no channel doorbell interrupt */
> > +	if (!mhi_ep_mmio_read_chdb_status_interrupts(mhi_cntrl))
> > +		return;
> > +
> > +	for (i = 0; i < MHI_MASK_ROWS_CH_EV_DB; i++) {
> > +		ch_idx = i * MHI_MASK_CH_EV_LEN;
> > +
> > +		/* Only process channel interrupt if the mask is enabled */
> > +		ch_int = mhi_cntrl->chdb[i].status & mhi_cntrl->chdb[i].mask;
> > +		if (ch_int) {
> > +			mhi_ep_queue_channel_db(mhi_cntrl, ch_int, ch_idx);
> > +			mhi_ep_mmio_write(mhi_cntrl, MHI_CHDB_INT_CLEAR_n(i),
> > +							mhi_cntrl->chdb[i].status);
> > +		}
> > +	}
> > +}
> > +
> > +static void mhi_ep_process_ctrl_interrupt(struct mhi_ep_cntrl *mhi_cntrl,
> > +					 enum mhi_state state)
> > +{
> > +	struct mhi_ep_state_transition *item;
> > +
> > +	item = kzalloc(sizeof(*item), GFP_ATOMIC);
> > +	if (!item)
> > +		return;
> > +
> > +	item->state = state;
> > +	spin_lock(&mhi_cntrl->list_lock);
> > +	list_add_tail(&item->node, &mhi_cntrl->st_transition_list);
> > +	spin_unlock(&mhi_cntrl->list_lock);
> > +
> > +	queue_work(mhi_cntrl->wq, &mhi_cntrl->state_work);
> > +}
> > +
> > +/*
> > + * Interrupt handler that services interrupts raised by the host writing to
> > + * MHICTRL and Command ring doorbell (CRDB) registers for state change and
> > + * channel interrupts.
> > + */
> > +static irqreturn_t mhi_ep_irq(int irq, void *data)
> > +{
> > +	struct mhi_ep_cntrl *mhi_cntrl = data;
> > +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> > +	enum mhi_state state;
> > +	u32 int_value;
> > +
> > +	/* Acknowledge the ctrl interrupt */
> > +	int_value = mhi_ep_mmio_read(mhi_cntrl, MHI_CTRL_INT_STATUS);
> > +	mhi_ep_mmio_write(mhi_cntrl, MHI_CTRL_INT_CLEAR, int_value);
> > +
> > +	/* Check for ctrl interrupt */
> > +	if (FIELD_GET(MHI_CTRL_INT_STATUS_MSK, int_value)) {
> > +		dev_dbg(dev, "Processing ctrl interrupt\n");
> > +		mhi_ep_process_ctrl_interrupt(mhi_cntrl, state);
> > +	}
> > +
> > +	/* Check for command doorbell interrupt */
> > +	if (FIELD_GET(MHI_CTRL_INT_STATUS_CRDB_MSK, int_value))
> > +		dev_dbg(dev, "Processing command doorbell interrupt\n");
> > +
> > +	/* Check for channel interrupts */
> > +	mhi_ep_check_channel_interrupt(mhi_cntrl);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> >   static void mhi_ep_release_device(struct device *dev)
> >   {
> >   	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
> > @@ -339,7 +445,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
> >   	struct mhi_ep_device *mhi_dev;
> >   	int ret;
> > -	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev || !mhi_cntrl->mmio)
> > +	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev || !mhi_cntrl->mmio || !mhi_cntrl->irq)
> >   		return -EINVAL;
> >   	ret = mhi_ep_chan_init(mhi_cntrl, config);
> > @@ -361,6 +467,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
> >   	}
> >   	INIT_LIST_HEAD(&mhi_cntrl->st_transition_list);
> > +	INIT_LIST_HEAD(&mhi_cntrl->ch_db_list);
> >   	spin_lock_init(&mhi_cntrl->state_lock);
> >   	spin_lock_init(&mhi_cntrl->list_lock);
> >   	mutex_init(&mhi_cntrl->event_lock);
> > @@ -376,12 +483,20 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
> >   		goto err_destroy_wq;
> >   	}
> > +	irq_set_status_flags(mhi_cntrl->irq, IRQ_NOAUTOEN);
> > +	ret = request_irq(mhi_cntrl->irq, mhi_ep_irq, IRQF_TRIGGER_HIGH,
> > +			  "doorbell_irq", mhi_cntrl);
> > +	if (ret) {
> > +		dev_err(mhi_cntrl->cntrl_dev, "Failed to request Doorbell IRQ\n");
> > +		goto err_ida_free;
> > +	}
> > +
> >   	/* Allocate the controller device */
> >   	mhi_dev = mhi_ep_alloc_device(mhi_cntrl, MHI_DEVICE_CONTROLLER);
> >   	if (IS_ERR(mhi_dev)) {
> >   		dev_err(mhi_cntrl->cntrl_dev, "Failed to allocate controller device\n");
> >   		ret = PTR_ERR(mhi_dev);
> > -		goto err_ida_free;
> > +		goto err_free_irq;
> >   	}
> >   	dev_set_name(&mhi_dev->dev, "mhi_ep%u", mhi_cntrl->index);
> > @@ -398,6 +513,8 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
> >   err_put_dev:
> >   	put_device(&mhi_dev->dev);
> > +err_free_irq:
> > +	free_irq(mhi_cntrl->irq, mhi_cntrl);
> >   err_ida_free:
> >   	ida_free(&mhi_ep_cntrl_ida, mhi_cntrl->index);
> >   err_destroy_wq:
> > @@ -417,6 +534,8 @@ void mhi_ep_unregister_controller(struct mhi_ep_cntrl *mhi_cntrl)
> >   	destroy_workqueue(mhi_cntrl->wq);
> > +	free_irq(mhi_cntrl->irq, mhi_cntrl);
> > +
> >   	kfree(mhi_cntrl->mhi_cmd);
> >   	kfree(mhi_cntrl->mhi_chan);
> > diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
> > index dc27a5de7d3c..43aa9b133db4 100644
> > --- a/include/linux/mhi_ep.h
> > +++ b/include/linux/mhi_ep.h
> > @@ -70,6 +70,7 @@ struct mhi_ep_db_info {
> >    * @list_lock: Lock for protecting state transition and channel doorbell lists
> >    * @state_lock: Lock for protecting state transitions
> >    * @st_transition_list: List of state transitions
> > + * @ch_db_list: List of queued channel doorbells
> >    * @wq: Dedicated workqueue for handling rings and state changes
> >    * @state_work: State transition worker
> >    * @raise_irq: CB function for raising IRQ to the host
> > @@ -87,6 +88,7 @@ struct mhi_ep_db_info {
> >    * @chdb_offset: Channel doorbell offset set by the host
> >    * @erdb_offset: Event ring doorbell offset set by the host
> >    * @index: MHI Endpoint controller index
> > + * @irq: IRQ used by the endpoint controller
> >    */
> >   struct mhi_ep_cntrl {
> >   	struct device *cntrl_dev;
> > @@ -111,6 +113,7 @@ struct mhi_ep_cntrl {
> >   	spinlock_t state_lock;
> >   	struct list_head st_transition_list;
> > +	struct list_head ch_db_list;
> >   	struct workqueue_struct *wq;
> >   	struct work_struct state_work;
> > @@ -137,6 +140,7 @@ struct mhi_ep_cntrl {
> >   	u32 chdb_offset;
> >   	u32 erdb_offset;
> >   	u32 index;
> > +	int irq;
> >   };
> >   /**
> 
