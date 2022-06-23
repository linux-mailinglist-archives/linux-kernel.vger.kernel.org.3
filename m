Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB1655791D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiFWLyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiFWLyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:54:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889EB4D25E;
        Thu, 23 Jun 2022 04:54:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FA9260AE7;
        Thu, 23 Jun 2022 11:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E784C3411B;
        Thu, 23 Jun 2022 11:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655985291;
        bh=dHt3+07omt2XAmM8gjsWqT8aOL7xpCjkVLX4ZbDVQos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=scbhjG2rMELOXPRqmj1Di0gdxZy23/pOZEXodhH/YAhajjJQ9u60X39M3bKTDrSby
         bxbLpxoZAj3TU6wtDBibzkvUP9HX+Eoq9qObjuSZfDSYimt0EdOd99ruIW//hJA/Sm
         bSBtl45vkFpZoUVXr1peqR9r/7ja0osstosxnZbZ0Nd8mwIj9byntJOakhEyg7nYMz
         IJa0aodTXTZ3R2J3uHfAybVgE+7VQF29SfqzoW6sWfok6O8TjWXDY5YHuo2Hl+nM2L
         OBlvKc0DBSTlNvE+Zr7r0uH9dBaeOTke/oyAzdXCytOnH4wosHRrvzcwKj9keWQVrW
         vu3vdzB4WBU9g==
Date:   Thu, 23 Jun 2022 17:24:36 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Qiang Yu <quic_qianyu@quicinc.com>
Cc:     quic_hemantk@quicinc.com, loic.poulain@linaro.org,
        quic_jhugo@quicinc.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com
Subject: Re: [PATCH v4 1/1] bus: mhi: host: Move IRQ allocation to controller
 registration phase
Message-ID: <20220623115436.GA15542@thinkpad>
References: <1655952183-66792-1-git-send-email-quic_qianyu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1655952183-66792-1-git-send-email-quic_qianyu@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 10:43:03AM +0800, Qiang Yu wrote:
> During runtime, the MHI endpoint may be powered up/down several times.
> So instead of allocating and destroying the IRQs all the time, let's just
> enable/disable IRQs during power up/down.
> 
> The IRQs will be allocated during mhi_register_controller() and freed
> during mhi_unregister_controller(). This works well for things like PCI
> hotplug also as once the PCI device gets removed, the controller will
> get unregistered. And once it comes back, it will get registered back
> and even if the IRQ configuration changes (MSI), that will get accounted.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>

I thought I already gave my r-o-b. But anyway,

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

I'll wait for a review from Jeff before applying.

Thanks,
Mani

> ---
> v3->v4: move mhi_init_irq_setup() above mhi_alloc_device()
> v2->v3: change commit text and comments.
> v1->v2: Rewrite commit text. Remove a random change. Use
>         inline enables.
> 
>  drivers/bus/mhi/host/init.c | 17 ++++++++++++++++-
>  drivers/bus/mhi/host/pm.c   | 19 +++++++++++++------
>  2 files changed, 29 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> index cbb86b2..a1d37da 100644
> --- a/drivers/bus/mhi/host/init.c
> +++ b/drivers/bus/mhi/host/init.c
> @@ -179,6 +179,12 @@ int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
>  				   "bhi", mhi_cntrl);
>  	if (ret)
>  		return ret;
> +	/*
> +	 * IRQs should be enabled during mhi_async_power_up(), so disable them explicitly here.
> +	 * Due to the use of IRQF_SHARED flag as default while requesting IRQs, we assume that
> +	 * IRQ_NOAUTOEN is not applicable.
> +	 */
> +	disable_irq(mhi_cntrl->irq[0]);
>  
>  	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
>  		if (mhi_event->offload_ev)
> @@ -200,6 +206,8 @@ int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
>  				mhi_cntrl->irq[mhi_event->irq], i);
>  			goto error_request;
>  		}
> +
> +		disable_irq(mhi_cntrl->irq[mhi_event->irq]);
>  	}
>  
>  	return 0;
> @@ -979,12 +987,16 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
>  		goto err_destroy_wq;
>  	}
>  
> +	ret = mhi_init_irq_setup(mhi_cntrl);
> +	if (ret)
> +		goto err_ida_free;
> +
>  	/* Register controller with MHI bus */
>  	mhi_dev = mhi_alloc_device(mhi_cntrl);
>  	if (IS_ERR(mhi_dev)) {
>  		dev_err(mhi_cntrl->cntrl_dev, "Failed to allocate MHI device\n");
>  		ret = PTR_ERR(mhi_dev);
> -		goto err_ida_free;
> +		goto error_setup_irq;
>  	}
>  
>  	mhi_dev->dev_type = MHI_DEVICE_CONTROLLER;
> @@ -1007,6 +1019,8 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
>  
>  err_release_dev:
>  	put_device(&mhi_dev->dev);
> +error_setup_irq:
> +	mhi_deinit_free_irq(mhi_cntrl);
>  err_ida_free:
>  	ida_free(&mhi_controller_ida, mhi_cntrl->index);
>  err_destroy_wq:
> @@ -1027,6 +1041,7 @@ void mhi_unregister_controller(struct mhi_controller *mhi_cntrl)
>  	struct mhi_chan *mhi_chan = mhi_cntrl->mhi_chan;
>  	unsigned int i;
>  
> +	mhi_deinit_free_irq(mhi_cntrl);
>  	mhi_destroy_debugfs(mhi_cntrl);
>  
>  	destroy_workqueue(mhi_cntrl->hiprio_wq);
> diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
> index dc2e8ff..4a42186 100644
> --- a/drivers/bus/mhi/host/pm.c
> +++ b/drivers/bus/mhi/host/pm.c
> @@ -500,7 +500,7 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
>  	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
>  		if (mhi_event->offload_ev)
>  			continue;
> -		free_irq(mhi_cntrl->irq[mhi_event->irq], mhi_event);
> +		disable_irq(mhi_cntrl->irq[mhi_event->irq]);
>  		tasklet_kill(&mhi_event->task);
>  	}
>  
> @@ -1060,12 +1060,13 @@ static void mhi_deassert_dev_wake(struct mhi_controller *mhi_cntrl,
>  
>  int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
>  {
> +	struct mhi_event *mhi_event = mhi_cntrl->mhi_event;
>  	enum mhi_state state;
>  	enum mhi_ee_type current_ee;
>  	enum dev_st_transition next_state;
>  	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>  	u32 interval_us = 25000; /* poll register field every 25 milliseconds */
> -	int ret;
> +	int ret, i;
>  
>  	dev_info(dev, "Requested to power ON\n");
>  
> @@ -1117,9 +1118,15 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
>  		mhi_write_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_INTVEC, 0);
>  	}
>  
> -	ret = mhi_init_irq_setup(mhi_cntrl);
> -	if (ret)
> -		goto error_exit;
> +	/* IRQs have been requested during probe, so we just need to enable them. */
> +	enable_irq(mhi_cntrl->irq[0]);
> +
> +	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
> +		if (mhi_event->offload_ev)
> +			continue;
> +
> +		enable_irq(mhi_cntrl->irq[mhi_event->irq]);
> +	}
>  
>  	/* Transition to next state */
>  	next_state = MHI_IN_PBL(current_ee) ?
> @@ -1182,7 +1189,7 @@ void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
>  	/* Wait for shutdown to complete */
>  	flush_work(&mhi_cntrl->st_worker);
>  
> -	free_irq(mhi_cntrl->irq[0], mhi_cntrl);
> +	disable_irq(mhi_cntrl->irq[0]);
>  }
>  EXPORT_SYMBOL_GPL(mhi_power_down);
>  
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
> 

-- 
மணிவண்ணன் சதாசிவம்
