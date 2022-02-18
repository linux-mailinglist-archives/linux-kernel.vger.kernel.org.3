Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4204BB711
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 11:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbiBRKlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 05:41:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiBRKlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 05:41:16 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050CE1F1750;
        Fri, 18 Feb 2022 02:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645180860; x=1676716860;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kw8s8Fnk90rdDbUnGNwVXOc0fqJlLbDuPmGpy4FvXWU=;
  b=eNG5SGnWCGHOLspU96X7NreYMe/7RdFqHjW2X3HBawThtOtkGCE20lbg
   8fYe9XlhB4LAKDqfP/cpZRkTWhkZwBYNVtv3Ea15EV1nSNpInoWxw92Lg
   wHDkFVFK42Djf+Hy9kA49cWe7gtf/mB4Lr8z4SScS7TicEzxFVJixBZ74
   8Bf2xOTb7q1JvfErNjcW33mW2NLZahXlhe9gjoT5W4Iv8XKTElGvAOtp0
   KcuCeF0lYzRvQOF9ygSzouBpZwrzO2/pI9forUsmJj+aWeDU3sdtbIxJo
   mtRKHtJAnvKa2cPD+DXns4FVc7PE/hEGWVnWHLuAZB5k3OH8POQfOUVos
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="251302243"
X-IronPort-AV: E=Sophos;i="5.88,378,1635231600"; 
   d="scan'208";a="251302243"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 02:40:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,378,1635231600"; 
   d="scan'208";a="682454333"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 18 Feb 2022 02:40:49 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 18 Feb 2022 12:40:48 +0200
Date:   Fri, 18 Feb 2022 12:40:48 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2 4/6] typec: mux: Allow multiple mux_devs per mux
Message-ID: <Yg93sMPmpfS/9+ns@kuha.fi.intel.com>
References: <20220208031944.3444-1-bjorn.andersson@linaro.org>
 <20220208031944.3444-5-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208031944.3444-5-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 07:19:42PM -0800, Bjorn Andersson wrote:
> In the Qualcomm platforms the USB/DP PHY handles muxing and orientation
> switching of the SuperSpeed lines, but the SBU lines needs to be
> connected and switched by external (to the SoC) hardware.
> 
> It's therefor necessary to be able to have the TypeC controller operate
> multiple TypeC muxes and switches. Use the newly introduced indirection
> object to handle this, to avoid having to taint the TypeC controllers
> with knowledge about the downstream hardware configuration.
> 
> The max number of devs per indirection is set to 3, which account for
> being able to mux/switch the USB HS, SS and SBU lines, as per defined
> defined in the usb-c-connector binding. This number could be grown if
> need arrises at a later point in time.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes since v1:
> - Improved the motivation for the 3 in the commit message.
> - kfree sw and mux in error paths
> 
>  drivers/usb/typec/mux.c | 128 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 102 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
> index d0b42c297aca..cf2347dd1663 100644
> --- a/drivers/usb/typec/mux.c
> +++ b/drivers/usb/typec/mux.c
> @@ -17,8 +17,11 @@
>  #include "class.h"
>  #include "mux.h"
>  
> +#define TYPEC_MUX_MAX_DEVS	3
> +
>  struct typec_switch {
> -	struct typec_switch_dev *sw_dev;
> +	struct typec_switch_dev *sw_devs[TYPEC_MUX_MAX_DEVS];
> +	unsigned int num_sw_devs;
>  };
>  
>  static int switch_fwnode_match(struct device *dev, const void *fwnode)
> @@ -67,25 +70,50 @@ static void *typec_switch_match(struct fwnode_handle *fwnode, const char *id,
>   */
>  struct typec_switch *fwnode_typec_switch_get(struct fwnode_handle *fwnode)
>  {
> -	struct typec_switch_dev *sw_dev;
> +	struct typec_switch_dev *sw_devs[TYPEC_MUX_MAX_DEVS];
>  	struct typec_switch *sw;
> +	int count;
> +	int err;
> +	int i;
>  
>  	sw = kzalloc(sizeof(*sw), GFP_KERNEL);
>  	if (!sw)
>  		return ERR_PTR(-ENOMEM);
>  
> -	sw_dev = fwnode_connection_find_match(fwnode, "orientation-switch", NULL,
> -					      typec_switch_match);
> -	if (IS_ERR_OR_NULL(sw_dev)) {
> +	count = fwnode_connection_find_matches(fwnode, "orientation-switch", NULL,
> +					       typec_switch_match,
> +					       (void **)sw_devs,
> +					       ARRAY_SIZE(sw_devs));
> +	if (count <= 0) {
>  		kfree(sw);
> -		return ERR_CAST(sw_dev);
> +		return NULL;
>  	}
>  
> -	WARN_ON(!try_module_get(sw_dev->dev.parent->driver->owner));
> +	for (i = 0; i < count; i++) {
> +		if (IS_ERR(sw_devs[i])) {
> +			err = PTR_ERR(sw_devs[i]);
> +			goto put_sw_devs;
> +		}
> +	}
>  
> -	sw->sw_dev = sw_dev;
> +	for (i = 0; i < count; i++) {
> +		WARN_ON(!try_module_get(sw_devs[i]->dev.parent->driver->owner));
> +		sw->sw_devs[i] = sw_devs[i];
> +	}
> +
> +	sw->num_sw_devs = count;
>  
>  	return sw;
> +
> +put_sw_devs:
> +	for (i = 0; i < count; i++) {
> +		if (!IS_ERR(sw_devs[i]))
> +			put_device(&sw_devs[i]->dev);
> +	}
> +
> +	kfree(sw);
> +
> +	return ERR_PTR(err);
>  }
>  EXPORT_SYMBOL_GPL(fwnode_typec_switch_get);
>  
> @@ -98,14 +126,17 @@ EXPORT_SYMBOL_GPL(fwnode_typec_switch_get);
>  void typec_switch_put(struct typec_switch *sw)
>  {
>  	struct typec_switch_dev *sw_dev;
> +	unsigned int i;
>  
>  	if (IS_ERR_OR_NULL(sw))
>  		return;
>  
> -	sw_dev = sw->sw_dev;
> +	for (i = 0; i < sw->num_sw_devs; i++) {
> +		sw_dev = sw->sw_devs[i];
>  
> -	module_put(sw_dev->dev.parent->driver->owner);
> -	put_device(&sw_dev->dev);
> +		module_put(sw_dev->dev.parent->driver->owner);
> +		put_device(&sw_dev->dev);
> +	}
>  	kfree(sw);
>  }
>  EXPORT_SYMBOL_GPL(typec_switch_put);
> @@ -170,13 +201,21 @@ int typec_switch_set(struct typec_switch *sw,
>  		     enum typec_orientation orientation)
>  {
>  	struct typec_switch_dev *sw_dev;
> +	unsigned int i;
> +	int ret;
>  
>  	if (IS_ERR_OR_NULL(sw))
>  		return 0;
>  
> -	sw_dev = sw->sw_dev;
> +	for (i = 0; i < sw->num_sw_devs; i++) {
> +		sw_dev = sw->sw_devs[i];
> +
> +		ret = sw_dev->set(sw_dev, orientation);
> +		if (ret)
> +			return ret;
> +	}
>  
> -	return sw_dev->set(sw_dev, orientation);
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(typec_switch_set);
>  
> @@ -208,7 +247,8 @@ EXPORT_SYMBOL_GPL(typec_switch_get_drvdata);
>  /* ------------------------------------------------------------------------- */
>  
>  struct typec_mux {
> -	struct typec_mux_dev *mux_dev;
> +	struct typec_mux_dev *mux_devs[TYPEC_MUX_MAX_DEVS];
> +	unsigned int num_mux_devs;
>  };
>  
>  static int mux_fwnode_match(struct device *dev, const void *fwnode)
> @@ -291,25 +331,50 @@ static void *typec_mux_match(struct fwnode_handle *fwnode, const char *id,
>  struct typec_mux *fwnode_typec_mux_get(struct fwnode_handle *fwnode,
>  				       const struct typec_altmode_desc *desc)
>  {
> -	struct typec_mux_dev *mux_dev;
> +	struct typec_mux_dev *mux_devs[TYPEC_MUX_MAX_DEVS];
>  	struct typec_mux *mux;
> +	int count;
> +	int err;
> +	int i;
>  
>  	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
>  	if (!mux)
>  		return ERR_PTR(-ENOMEM);
>  
> -	mux_dev = fwnode_connection_find_match(fwnode, "mode-switch", (void *)desc,
> -					       typec_mux_match);
> -	if (IS_ERR_OR_NULL(mux_dev)) {
> +	count = fwnode_connection_find_matches(fwnode, "mode-switch",
> +					       (void *)desc, typec_mux_match,
> +					       (void **)mux_devs,
> +					       ARRAY_SIZE(mux_devs));
> +	if (count <= 0) {
>  		kfree(mux);
> -		return ERR_CAST(mux_dev);
> +		return NULL;
>  	}
>  
> -	WARN_ON(!try_module_get(mux_dev->dev.parent->driver->owner));
> +	for (i = 0; i < count; i++) {
> +		if (IS_ERR(mux_devs[i])) {
> +			err = PTR_ERR(mux_devs[i]);
> +			goto put_mux_devs;
> +		}
> +	}
> +
> +	for (i = 0; i < count; i++) {
> +		WARN_ON(!try_module_get(mux_devs[i]->dev.parent->driver->owner));
> +		mux->mux_devs[i] = mux_devs[i];
> +	}
>  
> -	mux->mux_dev = mux_dev;
> +	mux->num_mux_devs = count;
>  
>  	return mux;
> +
> +put_mux_devs:
> +	for (i = 0; i < count; i++) {
> +		if (!IS_ERR(mux_devs[i]))
> +			put_device(&mux_devs[i]->dev);
> +	}
> +
> +	kfree(mux);
> +
> +	return ERR_PTR(err);
>  }
>  EXPORT_SYMBOL_GPL(fwnode_typec_mux_get);
>  
> @@ -322,13 +387,16 @@ EXPORT_SYMBOL_GPL(fwnode_typec_mux_get);
>  void typec_mux_put(struct typec_mux *mux)
>  {
>  	struct typec_mux_dev *mux_dev;
> +	unsigned int i;
>  
>  	if (IS_ERR_OR_NULL(mux))
>  		return;
>  
> -	mux_dev = mux->mux_dev;
> -	module_put(mux_dev->dev.parent->driver->owner);
> -	put_device(&mux_dev->dev);
> +	for (i = 0; i < mux->num_mux_devs; i++) {
> +		mux_dev = mux->mux_devs[i];
> +		module_put(mux_dev->dev.parent->driver->owner);
> +		put_device(&mux_dev->dev);
> +	}
>  	kfree(mux);
>  }
>  EXPORT_SYMBOL_GPL(typec_mux_put);
> @@ -336,13 +404,21 @@ EXPORT_SYMBOL_GPL(typec_mux_put);
>  int typec_mux_set(struct typec_mux *mux, struct typec_mux_state *state)
>  {
>  	struct typec_mux_dev *mux_dev;
> +	unsigned int i;
> +	int ret;
>  
>  	if (IS_ERR_OR_NULL(mux))
>  		return 0;
>  
> -	mux_dev = mux->mux_dev;
> +	for (i = 0; i < mux->num_mux_devs; i++) {
> +		mux_dev = mux->mux_devs[i];
> +
> +		ret = mux_dev->set(mux_dev, state);
> +		if (ret)
> +			return ret;
> +	}
>  
> -	return mux_dev->set(mux_dev, state);
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(typec_mux_set);
>  
> -- 
> 2.33.1

-- 
heikki
