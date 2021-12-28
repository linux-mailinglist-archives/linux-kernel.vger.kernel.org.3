Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC3A480B5F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 17:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbhL1QjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 11:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbhL1QjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 11:39:04 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4919C06173E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 08:39:03 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id s73so30823605oie.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 08:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZIpboUz/xGiGm0M2bXxED5rkbHQBbAAf8QHnqv08958=;
        b=AFobbcTiuaEItSulj0GbplCZ6nJLKEzZbS81I/vjDL5fHMv8umDxbEl+tLsi3MxQBY
         46vmWs1PJkhy9r0z2ovi/LIaVLnG53l16NTAaut38zEBwHhpnVj2rEPyLbJfveeGg0Bj
         DSwuFfeEPNUP1qlM6JObzKhKwW+qoQoOUVXoRCBCvgiOgBiCLGhEOnebkh8jrpyBPcOM
         rFW3mMUh/v4bjiRSYbMb+K9WImT2Va7UIXo4yc0PDwufsUYc34QhbvMVpNajXfg1QOiC
         1Gq7DSneEuXJk7uff1K3YoVpM3Atz6KsNLgUYKNHy7yDQ0tN0VeZHhjUpSFIH/9TQYGw
         6eGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZIpboUz/xGiGm0M2bXxED5rkbHQBbAAf8QHnqv08958=;
        b=3YiFudYRuq7qXnzxBroa+XUxANhymvV/qsrLXaaseY3DBfLapEH9VonVv04lZi7ljo
         GtvF4gt3ottN0VsiiPlUvBPbuXpeEzotZdoLcdf9z7p9I8uhXn+zBH7DMqiEfJBaj7nb
         0pmuscv0QuqDsaQXIY14NTz9S6dPTZ6eRVyOoSKfM7XG9oHVnD13GsdUEzznHs+uWgol
         X3Ts2MMNGEDI2z0tGFg37G6daAXw7TylaEVyrgE/fg7+HB0oMQdBX+/duQQ0VEPpNWYC
         MfDk3FpXdxBVuUyEvBTC/inpxvfrbarkXt1QkMbWeYADMuAxrErBOfRgUJy/5WSCGSwp
         0OMQ==
X-Gm-Message-State: AOAM531cuAXj53vHxNp0WgF3Ab+HzYalC3y5RPBN9E0I0dJ5XY14zckO
        Qh5BSZ1/aCtzMN/VMyn+FuVx3g==
X-Google-Smtp-Source: ABdhPJzOODy4nmc8nUHSmsbMH/o2ue92pmv2LHEXCJDGBzRWhqAPOozIKUl/ymCjnUMkyifprhlvtA==
X-Received: by 2002:a05:6808:682:: with SMTP id k2mr18106337oig.63.1640709541365;
        Tue, 28 Dec 2021 08:39:01 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id o11sm3993423oiv.10.2021.12.28.08.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 08:39:00 -0800 (PST)
Date:   Tue, 28 Dec 2021 08:40:01 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 6/8] typec: mux: Allow multiple mux_devs per mux
Message-ID: <Ycs94b+Uh42KQKui@ripper>
References: <20211228052116.1748443-1-bjorn.andersson@linaro.org>
 <20211228052116.1748443-7-bjorn.andersson@linaro.org>
 <42ef1ff8-1c60-c601-3e97-7b9ffb3cab07@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42ef1ff8-1c60-c601-3e97-7b9ffb3cab07@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28 Dec 08:04 PST 2021, Dmitry Baryshkov wrote:

> On 28/12/2021 08:21, Bjorn Andersson wrote:
> > In the Qualcomm platforms the USB/DP PHY handles muxing and orientation
> > switching of the SuperSpeed lines, but the SBU lines needs to be
> > connected and switched by external (to the SoC) hardware.
> > 
> > It's therefor necessary to be able to have the TypeC controller operate
> > multiple TypeC muxes and switches. Use the newly introduced indirection
> > object to handle this, to avoid having to taint the TypeC controllers
> > with knowledge about the downstream hardware configuration.
> > 
> > The max number of devs per indirection is set to 3, based on the number
> > of ports defined in the usb-c-connector binding.
> 
> If we had the 'count' ability, we wouldn't have to put limits here.
> The limit 3 is a bit artificial if you consider the redriver chips.
> 

I don't know if it's worth making it more dynamic at this point in time.
I definitely don't think it's worth taking two passes here, because
typec_switch_match will allocate objects that needs to be freed after
the "count" pass. I.e.  taking two passes is expensive (and ugly).

Also in it's current state we're wasting 16 bytes per USB connector at
worst and in the case of us having QMP muxing SuperSpeed signals and an
external redriver we have 2.


Given that we're just dealing with pointers the waste isn't that big,
but we could put say 8 (16?) entries on the stack and then dynamically
allocate the typec_switch and typec_mux arrays based on the actual
number of items returned.

Regards,
Bjorn

> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >   drivers/usb/typec/mux.c | 124 +++++++++++++++++++++++++++++++---------
> >   1 file changed, 98 insertions(+), 26 deletions(-)
> > 
> > diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
> > index d0b42c297aca..adf3681cf22d 100644
> > --- a/drivers/usb/typec/mux.c
> > +++ b/drivers/usb/typec/mux.c
> > @@ -17,8 +17,11 @@
> >   #include "class.h"
> >   #include "mux.h"
> > +#define TYPEC_MUX_MAX_DEVS	3
> > +
> >   struct typec_switch {
> > -	struct typec_switch_dev *sw_dev;
> > +	struct typec_switch_dev *sw_devs[TYPEC_MUX_MAX_DEVS];
> > +	unsigned int num_sw_devs;
> >   };
> >   static int switch_fwnode_match(struct device *dev, const void *fwnode)
> > @@ -67,25 +70,48 @@ static void *typec_switch_match(struct fwnode_handle *fwnode, const char *id,
> >    */
> >   struct typec_switch *fwnode_typec_switch_get(struct fwnode_handle *fwnode)
> >   {
> > -	struct typec_switch_dev *sw_dev;
> > +	struct typec_switch_dev *sw_devs[TYPEC_MUX_MAX_DEVS];
> >   	struct typec_switch *sw;
> > +	int count;
> > +	int err;
> > +	int i;
> >   	sw = kzalloc(sizeof(*sw), GFP_KERNEL);
> >   	if (!sw)
> >   		return ERR_PTR(-ENOMEM);
> > -	sw_dev = fwnode_connection_find_match(fwnode, "orientation-switch", NULL,
> > -					      typec_switch_match);
> > -	if (IS_ERR_OR_NULL(sw_dev)) {
> > +	count = fwnode_connection_find_matches(fwnode, "orientation-switch", NULL,
> > +					       typec_switch_match,
> > +					       (void **)sw_devs,
> > +					       ARRAY_SIZE(sw_devs));
> > +	if (count <= 0) {
> >   		kfree(sw);
> > -		return ERR_CAST(sw_dev);
> > +		return NULL;
> >   	}
> > -	WARN_ON(!try_module_get(sw_dev->dev.parent->driver->owner));
> > +	for (i = 0; i < count; i++) {
> > +		if (IS_ERR(sw_devs[i])) {
> > +			err = PTR_ERR(sw_devs[i]);
> > +			goto put_sw_devs;
> > +		}
> > +	}
> > +
> > +	for (i = 0; i < count; i++) {
> > +		WARN_ON(!try_module_get(sw_devs[i]->dev.parent->driver->owner));
> > +		sw->sw_devs[i] = sw_devs[i];
> > +	}
> > -	sw->sw_dev = sw_dev;
> > +	sw->num_sw_devs = count;
> >   	return sw;
> > +
> > +put_sw_devs:
> > +	for (i = 0; i < count; i++) {
> > +		if (!IS_ERR(sw_devs[i]))
> > +			put_device(&sw_devs[i]->dev);
> > +	}
> > +
> > +	return ERR_PTR(err);
> >   }
> >   EXPORT_SYMBOL_GPL(fwnode_typec_switch_get);
> > @@ -98,14 +124,17 @@ EXPORT_SYMBOL_GPL(fwnode_typec_switch_get);
> >   void typec_switch_put(struct typec_switch *sw)
> >   {
> >   	struct typec_switch_dev *sw_dev;
> > +	unsigned int i;
> >   	if (IS_ERR_OR_NULL(sw))
> >   		return;
> > -	sw_dev = sw->sw_dev;
> > +	for (i = 0; i < sw->num_sw_devs; i++) {
> > +		sw_dev = sw->sw_devs[i];
> > -	module_put(sw_dev->dev.parent->driver->owner);
> > -	put_device(&sw_dev->dev);
> > +		module_put(sw_dev->dev.parent->driver->owner);
> > +		put_device(&sw_dev->dev);
> > +	}
> >   	kfree(sw);
> >   }
> >   EXPORT_SYMBOL_GPL(typec_switch_put);
> > @@ -170,13 +199,21 @@ int typec_switch_set(struct typec_switch *sw,
> >   		     enum typec_orientation orientation)
> >   {
> >   	struct typec_switch_dev *sw_dev;
> > +	unsigned int i;
> > +	int ret;
> >   	if (IS_ERR_OR_NULL(sw))
> >   		return 0;
> > -	sw_dev = sw->sw_dev;
> > +	for (i = 0; i < sw->num_sw_devs; i++) {
> > +		sw_dev = sw->sw_devs[i];
> > +
> > +		ret = sw_dev->set(sw_dev, orientation);
> > +		if (ret)
> > +			return ret;
> > +	}
> > -	return sw_dev->set(sw_dev, orientation);
> > +	return 0;
> >   }
> >   EXPORT_SYMBOL_GPL(typec_switch_set);
> > @@ -208,7 +245,8 @@ EXPORT_SYMBOL_GPL(typec_switch_get_drvdata);
> >   /* ------------------------------------------------------------------------- */
> >   struct typec_mux {
> > -	struct typec_mux_dev *mux_dev;
> > +	struct typec_mux_dev *mux_devs[TYPEC_MUX_MAX_DEVS];
> > +	unsigned int num_mux_devs;
> >   };
> >   static int mux_fwnode_match(struct device *dev, const void *fwnode)
> > @@ -291,25 +329,48 @@ static void *typec_mux_match(struct fwnode_handle *fwnode, const char *id,
> >   struct typec_mux *fwnode_typec_mux_get(struct fwnode_handle *fwnode,
> >   				       const struct typec_altmode_desc *desc)
> >   {
> > -	struct typec_mux_dev *mux_dev;
> > +	struct typec_mux_dev *mux_devs[TYPEC_MUX_MAX_DEVS];
> >   	struct typec_mux *mux;
> > +	int count;
> > +	int err;
> > +	int i;
> >   	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
> >   	if (!mux)
> >   		return ERR_PTR(-ENOMEM);
> > -	mux_dev = fwnode_connection_find_match(fwnode, "mode-switch", (void *)desc,
> > -					       typec_mux_match);
> > -	if (IS_ERR_OR_NULL(mux_dev)) {
> > +	count = fwnode_connection_find_matches(fwnode, "mode-switch",
> > +					       (void *)desc, typec_mux_match,
> > +					       (void **)mux_devs,
> > +					       ARRAY_SIZE(mux_devs));
> > +	if (count <= 0) {
> >   		kfree(mux);
> > -		return ERR_CAST(mux_dev);
> > +		return NULL;
> >   	}
> > -	WARN_ON(!try_module_get(mux_dev->dev.parent->driver->owner));
> > +	for (i = 0; i < count; i++) {
> > +		if (IS_ERR(mux_devs[i])) {
> > +			err = PTR_ERR(mux_devs[i]);
> > +			goto put_mux_devs;
> > +		}
> > +	}
> > +
> > +	for (i = 0; i < count; i++) {
> > +		WARN_ON(!try_module_get(mux_devs[i]->dev.parent->driver->owner));
> > +		mux->mux_devs[i] = mux_devs[i];
> > +	}
> > -	mux->mux_dev = mux_dev;
> > +	mux->num_mux_devs = count;
> >   	return mux;
> > +
> > +put_mux_devs:
> > +	for (i = 0; i < count; i++) {
> > +		if (!IS_ERR(mux_devs[i]))
> > +			put_device(&mux_devs[i]->dev);
> > +	}
> > +
> > +	return ERR_PTR(err);
> >   }
> >   EXPORT_SYMBOL_GPL(fwnode_typec_mux_get);
> > @@ -322,13 +383,16 @@ EXPORT_SYMBOL_GPL(fwnode_typec_mux_get);
> >   void typec_mux_put(struct typec_mux *mux)
> >   {
> >   	struct typec_mux_dev *mux_dev;
> > +	unsigned int i;
> >   	if (IS_ERR_OR_NULL(mux))
> >   		return;
> > -	mux_dev = mux->mux_dev;
> > -	module_put(mux_dev->dev.parent->driver->owner);
> > -	put_device(&mux_dev->dev);
> > +	for (i = 0; i < mux->num_mux_devs; i++) {
> > +		mux_dev = mux->mux_devs[i];
> > +		module_put(mux_dev->dev.parent->driver->owner);
> > +		put_device(&mux_dev->dev);
> > +	}
> >   	kfree(mux);
> >   }
> >   EXPORT_SYMBOL_GPL(typec_mux_put);
> > @@ -336,13 +400,21 @@ EXPORT_SYMBOL_GPL(typec_mux_put);
> >   int typec_mux_set(struct typec_mux *mux, struct typec_mux_state *state)
> >   {
> >   	struct typec_mux_dev *mux_dev;
> > +	unsigned int i;
> > +	int ret;
> >   	if (IS_ERR_OR_NULL(mux))
> >   		return 0;
> > -	mux_dev = mux->mux_dev;
> > +	for (i = 0; i < mux->num_mux_devs; i++) {
> > +		mux_dev = mux->mux_devs[i];
> > +
> > +		ret = mux_dev->set(mux_dev, state);
> > +		if (ret)
> > +			return ret;
> > +	}
> > -	return mux_dev->set(mux_dev, state);
> > +	return 0;
> >   }
> >   EXPORT_SYMBOL_GPL(typec_mux_set);
> 
> 
> -- 
> With best wishes
> Dmitry
