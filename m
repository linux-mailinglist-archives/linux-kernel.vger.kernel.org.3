Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF4B4B770D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243934AbiBOUDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:03:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243952AbiBOUDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:03:06 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AF475613
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:02:52 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id n5so15703753ilk.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=28fMAA8YBQnTM5LrPfcPDxsg8FMevgZ1rIvKm9n0kJ4=;
        b=U2+Wq9jG04gcQoJbSRJZcosaWhXh1MasE2kf06WefEaVarM07DOfka/raJ+9uPEvKr
         C6k5GlQabSfw6lGqjgauA3ArNz/KhxLSyV6pB+OXCdop8Ucx7WQiW1lJljZrulVIjZAq
         eQJsZc1dAge3U9yoF8uXjCILZNEFxRDzI5YFDc+uPMfrLQsBGzqxwmZXReEtS86iD1CX
         ucFGP7x8BhNUWmzhcylC8k/vJI+DBaearZaQ9tORD6O6lx9Hn0x86uGwzRpXWldl+LC4
         lwy8/7dGrgLUPrnbPF0eWdl2EyRKkfLFBCNEd4mQCeq8Hl0iu1fVfrXK3QxvCAAZZRG+
         L8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=28fMAA8YBQnTM5LrPfcPDxsg8FMevgZ1rIvKm9n0kJ4=;
        b=MsGlwgVmpXlqfgYB+aoeMhiRwKy6IzB2eMnUBbcu4+MaSSyOo6npco+zPzVbGr4ZEn
         x1RnYbAnNWAcMgRbW9q/fRtijS2H/MWZ9hkj4Oeu815L0JNJrKTx9DJGI8KTKpTxxFgw
         /E81lLFBP3Qq80Yuf+gKgF7vUUola+PZqnAdnl1My5QPs3xgz6/kAC4xM0hUd1KUcIhG
         abGtAEV+rQF1yrph2p82zZqt32fNh75leJ3UzJXQke1wvN9NkkuYrFKiio6E5MnYOgh0
         ZgA8RVdtGrN472171+2ZbNHxwSzAwcLdEaU5qbaIJmmzwax0gDBSs1cKC5u2YFpV/Icc
         uI+A==
X-Gm-Message-State: AOAM532bDWn1/JLzgJY7Bv1UU0lfJTi2F9RLB1vnzGgK08BxnRmT9MoC
        MvzYjs7aabV9VhrDtaEmz1BSjQ==
X-Google-Smtp-Source: ABdhPJwdIgbvKcG0rsGzBBUAXM8hUyul07Wdf2wUEA0WqgJ3G4/XiCFkWsWRWY6p3JVaPsBClZICpg==
X-Received: by 2002:a92:2c11:: with SMTP id t17mr445333ile.68.1644955372017;
        Tue, 15 Feb 2022 12:02:52 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id g7sm13035438ild.40.2022.02.15.12.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 12:02:51 -0800 (PST)
Message-ID: <94abdf83-5749-14b1-7a57-ceceb1b27167@linaro.org>
Date:   Tue, 15 Feb 2022 14:02:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 09/25] bus: mhi: ep: Add support for registering MHI
 endpoint client drivers
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
 <20220212182117.49438-10-manivannan.sadhasivam@linaro.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220212182117.49438-10-manivannan.sadhasivam@linaro.org>
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
> This commit adds support for registering MHI endpoint client drivers
> with the MHI endpoint stack. MHI endpoint client drivers binds to one

s/binds/bind/

> or more MHI endpoint devices inorder to send and receive the upper-layer
> protocol packets like IP packets, modem control messages, and diagnostics
> messages over MHI bus.

I have a few more comments here but generally this looks good.

					-Alex

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/bus/mhi/ep/main.c | 86 +++++++++++++++++++++++++++++++++++++++
>   include/linux/mhi_ep.h    | 53 ++++++++++++++++++++++++
>   2 files changed, 139 insertions(+)
> 
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index b006011d025d..f66404181972 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -196,9 +196,89 @@ void mhi_ep_unregister_controller(struct mhi_ep_cntrl *mhi_cntrl)
>   }
>   EXPORT_SYMBOL_GPL(mhi_ep_unregister_controller);
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

It would be my preference to encapsulate the body of the
following loop into a called function, then call that once
for the UL channel and once for the DL channel.

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

It appears the result is ignored here.  If so, can we
define the xfer_cb() function so that a NULL pointer may
be supplied by the caller in cases like this?

> +		}
> +
> +		/* Set channel state to DISABLED */

That comment is a little tautological.  Just omit it.

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
>   static int mhi_ep_match(struct device *dev, struct device_driver *drv)
>   {
>   	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
> +	struct mhi_ep_driver *mhi_drv = to_mhi_ep_driver(drv);
> +	const struct mhi_device_id *id;
>   
>   	/*
>   	 * If the device is a controller type then there is no client driver
> @@ -207,6 +287,12 @@ static int mhi_ep_match(struct device *dev, struct device_driver *drv)
>   	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
>   		return 0;
>   
> +	for (id = mhi_drv->id_table; id->chan[0]; id++)
> +		if (!strcmp(mhi_dev->name, id->chan)) {
> +			mhi_dev->id = id;
> +			return 1;
> +		}
> +
>   	return 0;
>   };
>   
> diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
> index 20238e9df1b3..da865f9d3646 100644
> --- a/include/linux/mhi_ep.h
> +++ b/include/linux/mhi_ep.h
> @@ -122,7 +122,60 @@ struct mhi_ep_device {
>   	enum mhi_device_type dev_type;
>   };
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

I get confused by the "ul" versus "dl" naming scheme here.
Is "ul" from the perspective of the host, meaning upload
is from the host toward the WWAN network (and therefore
toward the SDX AP), and download is from the WWAN toward
the host?  Somewhere this should be stated clearly in
comments; maybe I just missed it.

> +	void (*ul_xfer_cb)(struct mhi_ep_device *mhi_dev,
> +			   struct mhi_result *result);
> +	void (*dl_xfer_cb)(struct mhi_ep_device *mhi_dev,
> +			   struct mhi_result *result);
> +};
> +
>   #define to_mhi_ep_device(dev) container_of(dev, struct mhi_ep_device, dev)
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
>   /**
>    * mhi_ep_register_controller - Register MHI Endpoint controller

