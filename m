Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBAC4B3763
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 19:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiBLScM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 13:32:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiBLScL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 13:32:11 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EF26007B
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 10:32:07 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id l19so16168705pfu.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 10:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k1GjCBbNsUNDeB/NEvjqCXptHC69sOQf+TjIBj9Sw04=;
        b=ftiSBuk/1tSprlDBPhgh31aZa63ugUXxmTOF9wYT4/EAP/4Ukv/V9JDYbyMzkMoYKX
         6bwCgAz75tRMg07/K1dUMSD1ENiZAo/G20AP778vg2kFYzP7ciP/vO/I/fsD4FFiM2Um
         4ploK0v7S8azbkS6QK7kBw++NxGzxXJqPF1tRBSo5AbdxBypFb1A6HBpQ294w8fmLSVu
         7W+MOXuz21mLPHinCdg3KEC85oQictL1L3qsMz+NfefNDntj8zKOzMKdsKxiG4iPmtOe
         +iWypqP55fW+4EJru5KhRwe3jEOF+5HFeU+TyuZ9sgKh/wYQVhvSPnXADvXnm7LXuqD4
         N1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k1GjCBbNsUNDeB/NEvjqCXptHC69sOQf+TjIBj9Sw04=;
        b=VjTk720ug4jzBpW4E5pxD2jVYGx8F0pAfnfdq4FeFa80j3RzwCVKvSQoxY7P6ARYcu
         K/CN59rnnXoopbUTHm/Wcnm5LPevQvjbp5GhDDp8pvXeCLWKUgzB5hwmP8ujbkrYyv+l
         k4vCN7NENSuSIb+h1wBW2J3L9h6sSXoWA5K3q+G17rnoAh98keNHGAhh2xhekM47YFRD
         P+XnNWg24wJHhJ4IUCWSyPWRuMi/h1SXKCMTn8i77GKlTdXMIMlR/vVi/QVlw8oEWS+K
         Xz2wU3cmUSe9xy6a7a/D6Vw0/x/nDmZHwYPUXuelhx1UyfDJndQs4dzhfOmaZpSO36H0
         /yTA==
X-Gm-Message-State: AOAM530FeMyNeQCC0ddTIAF1uuAvxZ3qImUECtaFsfkT4ZGzo3Q7Acfz
        i1EQg9AgeuwPBhVEVQRHQf2P
X-Google-Smtp-Source: ABdhPJxxifnFdagwvJAn2Fnuz4nX6eZGGIUA4d/EQlKEjlI0MzoQN0e3OlDlWdkRWmDQ4EME5lMlNA==
X-Received: by 2002:a63:2bc8:: with SMTP id r191mr5704442pgr.347.1644690727297;
        Sat, 12 Feb 2022 10:32:07 -0800 (PST)
Received: from thinkpad ([27.111.75.57])
        by smtp.gmail.com with ESMTPSA id l14sm9412353pjf.1.2022.02.12.10.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 10:32:06 -0800 (PST)
Date:   Sun, 13 Feb 2022 00:02:00 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org
Subject: Re: [PATCH v3 09/25] bus: mhi: ep: Add support for registering MHI
 endpoint client drivers
Message-ID: <20220212183200.GB9933@thinkpad>
References: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
 <20220212182117.49438-10-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212182117.49438-10-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2022 at 11:51:01PM +0530, Manivannan Sadhasivam wrote:
> This commit adds support for registering MHI endpoint client drivers
> with the MHI endpoint stack. MHI endpoint client drivers binds to one
> or more MHI endpoint devices inorder to send and receive the upper-layer
> protocol packets like IP packets, modem control messages, and diagnostics
> messages over MHI bus.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/bus/mhi/ep/main.c | 86 +++++++++++++++++++++++++++++++++++++++
>  include/linux/mhi_ep.h    | 53 ++++++++++++++++++++++++
>  2 files changed, 139 insertions(+)
> 
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index b006011d025d..f66404181972 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -196,9 +196,89 @@ void mhi_ep_unregister_controller(struct mhi_ep_cntrl *mhi_cntrl)
>  }
>  EXPORT_SYMBOL_GPL(mhi_ep_unregister_controller);
>  
> +static int mhi_ep_driver_probe(struct device *dev)
> +{
> +	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
> +	struct mhi_ep_driver *mhi_drv = to_mhi_ep_driver(dev->driver);
> +	struct mhi_ep_chan *ul_chan = mhi_dev->ul_chan;
> +	struct mhi_ep_chan *dl_chan = mhi_dev->dl_chan;
> +
> +	/* Client drivers should have callbacks for both channels */
> +	if (!mhi_drv->ul_xfer_cb || !mhi_drv->dl_xfer_cb)
> +		return -EINVAL;
> +

Hmm, I had a change that moved this check to __mhi_ep_driver_register() but I
missed to apply it. Will do it in next iteration.

Thanks,
Mani

> +	ul_chan->xfer_cb = mhi_drv->ul_xfer_cb;
> +	dl_chan->xfer_cb = mhi_drv->dl_xfer_cb;
> +
> +	return mhi_drv->probe(mhi_dev, mhi_dev->id);
> +}
> +
> +static int mhi_ep_driver_remove(struct device *dev)
> +{
> +	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
> +	struct mhi_ep_driver *mhi_drv = to_mhi_ep_driver(dev->driver);
> +	struct mhi_result result = {};
> +	struct mhi_ep_chan *mhi_chan;
> +	int dir;
> +
> +	/* Skip if it is a controller device */
> +	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
> +		return 0;
> +
> +	/* Disconnect the channels associated with the driver */
> +	for (dir = 0; dir < 2; dir++) {
> +		mhi_chan = dir ? mhi_dev->ul_chan : mhi_dev->dl_chan;
> +
> +		if (!mhi_chan)
> +			continue;
> +
> +		mutex_lock(&mhi_chan->lock);
> +		/* Send channel disconnect status to the client driver */
> +		if (mhi_chan->xfer_cb) {
> +			result.transaction_status = -ENOTCONN;
> +			result.bytes_xferd = 0;
> +			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
> +		}
> +
> +		/* Set channel state to DISABLED */
> +		mhi_chan->state = MHI_CH_STATE_DISABLED;
> +		mhi_chan->xfer_cb = NULL;
> +		mutex_unlock(&mhi_chan->lock);
> +	}
> +
> +	/* Remove the client driver now */
> +	mhi_drv->remove(mhi_dev);
> +
> +	return 0;
> +}
> +
> +int __mhi_ep_driver_register(struct mhi_ep_driver *mhi_drv, struct module *owner)
> +{
> +	struct device_driver *driver = &mhi_drv->driver;
> +
> +	if (!mhi_drv->probe || !mhi_drv->remove)
> +		return -EINVAL;
> +
> +	driver->bus = &mhi_ep_bus_type;
> +	driver->owner = owner;
> +	driver->probe = mhi_ep_driver_probe;
> +	driver->remove = mhi_ep_driver_remove;
> +
> +	return driver_register(driver);
> +}
> +EXPORT_SYMBOL_GPL(__mhi_ep_driver_register);
> +
> +void mhi_ep_driver_unregister(struct mhi_ep_driver *mhi_drv)
> +{
> +	driver_unregister(&mhi_drv->driver);
> +}
> +EXPORT_SYMBOL_GPL(mhi_ep_driver_unregister);
> +
>  static int mhi_ep_match(struct device *dev, struct device_driver *drv)
>  {
>  	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
> +	struct mhi_ep_driver *mhi_drv = to_mhi_ep_driver(drv);
> +	const struct mhi_device_id *id;
>  
>  	/*
>  	 * If the device is a controller type then there is no client driver
> @@ -207,6 +287,12 @@ static int mhi_ep_match(struct device *dev, struct device_driver *drv)
>  	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
>  		return 0;
>  
> +	for (id = mhi_drv->id_table; id->chan[0]; id++)
> +		if (!strcmp(mhi_dev->name, id->chan)) {
> +			mhi_dev->id = id;
> +			return 1;
> +		}
> +
>  	return 0;
>  };
>  
> diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
> index 20238e9df1b3..da865f9d3646 100644
> --- a/include/linux/mhi_ep.h
> +++ b/include/linux/mhi_ep.h
> @@ -122,7 +122,60 @@ struct mhi_ep_device {
>  	enum mhi_device_type dev_type;
>  };
>  
> +/**
> + * struct mhi_ep_driver - Structure representing a MHI Endpoint client driver
> + * @id_table: Pointer to MHI Endpoint device ID table
> + * @driver: Device driver model driver
> + * @probe: CB function for client driver probe function
> + * @remove: CB function for client driver remove function
> + * @ul_xfer_cb: CB function for UL data transfer
> + * @dl_xfer_cb: CB function for DL data transfer
> + */
> +struct mhi_ep_driver {
> +	const struct mhi_device_id *id_table;
> +	struct device_driver driver;
> +	int (*probe)(struct mhi_ep_device *mhi_ep,
> +		     const struct mhi_device_id *id);
> +	void (*remove)(struct mhi_ep_device *mhi_ep);
> +	void (*ul_xfer_cb)(struct mhi_ep_device *mhi_dev,
> +			   struct mhi_result *result);
> +	void (*dl_xfer_cb)(struct mhi_ep_device *mhi_dev,
> +			   struct mhi_result *result);
> +};
> +
>  #define to_mhi_ep_device(dev) container_of(dev, struct mhi_ep_device, dev)
> +#define to_mhi_ep_driver(drv) container_of(drv, struct mhi_ep_driver, driver)
> +
> +/*
> + * module_mhi_ep_driver() - Helper macro for drivers that don't do
> + * anything special other than using default mhi_ep_driver_register() and
> + * mhi_ep_driver_unregister().  This eliminates a lot of boilerplate.
> + * Each module may only use this macro once.
> + */
> +#define module_mhi_ep_driver(mhi_drv) \
> +	module_driver(mhi_drv, mhi_ep_driver_register, \
> +		      mhi_ep_driver_unregister)
> +
> +/*
> + * Macro to avoid include chaining to get THIS_MODULE
> + */
> +#define mhi_ep_driver_register(mhi_drv) \
> +	__mhi_ep_driver_register(mhi_drv, THIS_MODULE)
> +
> +/**
> + * __mhi_ep_driver_register - Register a driver with MHI Endpoint bus
> + * @mhi_drv: Driver to be associated with the device
> + * @owner: The module owner
> + *
> + * Return: 0 if driver registrations succeeds, a negative error code otherwise.
> + */
> +int __mhi_ep_driver_register(struct mhi_ep_driver *mhi_drv, struct module *owner);
> +
> +/**
> + * mhi_ep_driver_unregister - Unregister a driver from MHI Endpoint bus
> + * @mhi_drv: Driver associated with the device
> + */
> +void mhi_ep_driver_unregister(struct mhi_ep_driver *mhi_drv);
>  
>  /**
>   * mhi_ep_register_controller - Register MHI Endpoint controller
> -- 
> 2.25.1
> 
