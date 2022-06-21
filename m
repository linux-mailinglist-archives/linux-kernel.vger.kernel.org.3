Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7ADE5532BF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 15:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351275AbiFUM7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 08:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351063AbiFUM7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:59:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2847ACC4;
        Tue, 21 Jun 2022 05:59:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C47BC61261;
        Tue, 21 Jun 2022 12:59:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3137EC3411C;
        Tue, 21 Jun 2022 12:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655816340;
        bh=xQEn11JOQYr7u+yIencQ9L5yjZcdiC9PCwn2K3lpIoY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IIslrEsQoTETPnGBsbT5w08O+ZdWpN0gTckMHgJsazIuTaZE5WoWl/o3GTe085O+M
         qzdo1rHRXhXl+vhedzfUMTl/7W/Xlg1MZplQVID6IZblXwkbBL5n2kz0nMTtEXmnOw
         nnFDfhhI2MuCqLzTL5nU1ksO7W//8wK91Qw5Zw+XoqPpjHp6qlPJmzFZcZWb/vXP5F
         d1WEjjRNqzKuEkOlPbZddkrnlJ67VZPxL1aaRmOLrTDs1YH7b+CERCk/uZ2rxAvP53
         GaI8Qt2AhMVpurPg95XUT1H0BiKELnbvYWpjQKtHoowae9+HIRTMU0yjEsa//lbKpC
         aei3TG5IN0HBA==
Date:   Tue, 21 Jun 2022 18:28:46 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Qiang Yu <quic_qianyu@quicinc.com>
Cc:     quic_hemantk@quicinc.com, loic.poulain@linaro.org,
        quic_jhugo@quicinc.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com
Subject: Re: [PATCH v2 1/1] bus: mhi: Disable IRQs instead of freeing them
 during power down
Message-ID: <20220621125846.GB17181@thinkpad>
References: <1655800689-60632-1-git-send-email-quic_qianyu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1655800689-60632-1-git-send-email-quic_qianyu@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 04:38:09PM +0800, Qiang Yu wrote:
> MHI device may go down several times while running. So we just do
> disable/enable IRQs during the mhi_{power_down/power_up} time and
> request/free them when the MHI driver gets installed and removed.
> 

This version looks better to me. I wrote a similar patch on the plane way back
to home. But atleast you can borrow the subject:

```
bus: mhi: host: Move IRQ allocation to controller registration phase
    
During runtime, the MHI endpoint may be powered up/down several times.
So instead of allocating and destroying the IRQs all the time, let's just
enable/disable IRQs during power up/down.
    
The IRQs will be allocated during mhi_register_controller() and freed
during mhi_unregister_controller(). This works well for things like PCI
hotplug also as once the PCI device gets removed, the controller will
get unregistered. And once it comes back, it will get registered back
and even if the IRQ configuration changes (MSI), that will get accounted.
```

> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
> v1->v2: Rewrite commit text. Remove a random change. Use
>         inline enables.
> 
>  drivers/bus/mhi/host/init.c | 14 ++++++++++++++
>  drivers/bus/mhi/host/pm.c   | 22 ++++++++++++++++------
>  2 files changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> index cbb86b2..daf315a 100644
> --- a/drivers/bus/mhi/host/init.c
> +++ b/drivers/bus/mhi/host/init.c
> @@ -179,6 +179,11 @@ int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
>  				   "bhi", mhi_cntrl);
>  	if (ret)
>  		return ret;
> +	/*
> +	 * IRQ marked IRQF_SHARED isn't recommended to use IRQ_NOAUTOEN,
> +	 * so disable it explicitly.

How about?

IRQs should be enabled during mhi_async_power_up(), so disable them explicitly
here. Due to the use of IRQF_SHARED flag as default while requesting IRQs, we
assume that IRQ_NOAUTOEN is not applicable.

> +	 */
> +	disable_irq(mhi_cntrl->irq[0]);
>  
>  	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
>  		if (mhi_event->offload_ev)
> @@ -200,6 +205,8 @@ int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
>  				mhi_cntrl->irq[mhi_event->irq], i);
>  			goto error_request;
>  		}
> +
> +		disable_irq(mhi_cntrl->irq[mhi_event->irq]);
>  	}
>  
>  	return 0;
> @@ -1003,8 +1010,14 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
>  
>  	mhi_create_debugfs(mhi_cntrl);
>  
> +	ret = mhi_init_irq_setup(mhi_cntrl);
> +	if (ret)
> +		goto error_setup_irq;
> +
>  	return 0;
>  
> +error_setup_irq:
> +	mhi_destroy_debugfs(mhi_cntrl);
>  err_release_dev:
>  	put_device(&mhi_dev->dev);
>  err_ida_free:
> @@ -1027,6 +1040,7 @@ void mhi_unregister_controller(struct mhi_controller *mhi_cntrl)
>  	struct mhi_chan *mhi_chan = mhi_cntrl->mhi_chan;
>  	unsigned int i;
>  
> +	mhi_deinit_free_irq(mhi_cntrl);
>  	mhi_destroy_debugfs(mhi_cntrl);
>  
>  	destroy_workqueue(mhi_cntrl->hiprio_wq);
> diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
> index dc2e8ff..eec2d1d 100644
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
> @@ -1117,9 +1118,18 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
>  		mhi_write_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_INTVEC, 0);
>  	}
>  
> -	ret = mhi_init_irq_setup(mhi_cntrl);
> -	if (ret)
> -		goto error_exit;
> +	/*
> +	 * IRQs have been reuqested during probe,

requested

Also, please align the comment in the same line even if it exceeds 80 lines. The
new convention is 100 lines.

Thanks,
Mani

> +	 * so we just need to enable them.
> +	 */
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
> @@ -1182,7 +1192,7 @@ void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
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
