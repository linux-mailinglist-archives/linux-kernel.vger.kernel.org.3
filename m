Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1818B4B593D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 18:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357295AbiBNR7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 12:59:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357304AbiBNR7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:59:44 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97C8652C4;
        Mon, 14 Feb 2022 09:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644861576; x=1676397576;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h2nLBru7ddRK3E/s9FlkhXeaiYmRggwF6jnGtDIawQM=;
  b=Sloqki10VqDXu7WjcYfWp/ghAEDGs/sr7tcTOBgoi+zrXMpDHcyqcqL1
   PUlKE5hIs7UGernl6VnpKSJ/hWsGm1CXBCqmB6ph5PRgFopkuhytnZ6su
   PzN+TWQjFyTVsuAwQsqIT2+r4ePIQ+Xv39f93CGisgqLwK/wj09U0VyfY
   QtROqf9dSSZOz1OpuuY6eDNQh3iXioHt2Ba/Qzs8ZL3nBggmRYKBwkmwr
   10mN4QEJu5DdBThhhxmQ+NZaBC6Jz3TswNEXCkRQCLQHM3GNjmgW5hGYB
   agDNmKD/0zwEYsoEaf/15yDRnytWSqreuwU9Tvt7XoAZkjdWeOXLYKU8S
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="247744026"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="247744026"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 09:59:36 -0800
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="703210237"
Received: from ideak-desk.fi.intel.com ([10.237.68.141])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 09:59:31 -0800
Date:   Mon, 14 Feb 2022 19:59:27 +0200
From:   Imre Deak <imre.deak@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        freedreno@lists.freedesktop.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        intel-gfx@lists.freedesktop.org, linux-usb@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm: Add HPD state to
 drm_connector_oob_hotplug_event()
Message-ID: <20220214175927.GA594729@ideak-desk.fi.intel.com>
References: <20220208044328.588860-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208044328.588860-1-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 08:43:27PM -0800, Bjorn Andersson wrote:
> In some implementations, such as the Qualcomm platforms, the display
> driver has no way to query the current HPD state and as such it's
> impossible to distinguish between disconnect and attention events.
> 
> Add a parameter to drm_connector_oob_hotplug_event() to pass the HPD
> state.
> 
> Also push the test for unchanged state in the displayport altmode driver
> into the i915 driver, to allow other drivers to act upon each update.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Note that the Intel driver has only been compile tested with this patch.
> 
>  drivers/gpu/drm/drm_connector.c          |  6 ++++--
>  drivers/gpu/drm/i915/display/intel_dp.c  | 14 +++++++++++---
>  drivers/gpu/drm/i915/i915_drv.h          |  3 +++
>  drivers/usb/typec/altmodes/displayport.c |  9 ++-------
>  include/drm/drm_connector.h              |  5 +++--
>  5 files changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index a50c82bc2b2f..ad7295597c0f 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -2825,6 +2825,7 @@ struct drm_connector *drm_connector_find_by_fwnode(struct fwnode_handle *fwnode)
>  /**
>   * drm_connector_oob_hotplug_event - Report out-of-band hotplug event to connector
>   * @connector_fwnode: fwnode_handle to report the event on
> + * @hpd_state: number of data lanes available
>   *
>   * On some hardware a hotplug event notification may come from outside the display
>   * driver / device. An example of this is some USB Type-C setups where the hardware
> @@ -2834,7 +2835,8 @@ struct drm_connector *drm_connector_find_by_fwnode(struct fwnode_handle *fwnode)
>   * This function can be used to report these out-of-band events after obtaining
>   * a drm_connector reference through calling drm_connector_find_by_fwnode().
>   */
> -void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode)
> +void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode,
> +				     bool hpd_state)
>  {
>  	struct drm_connector *connector;
>  
> @@ -2843,7 +2845,7 @@ void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode)
>  		return;
>  
>  	if (connector->funcs->oob_hotplug_event)
> -		connector->funcs->oob_hotplug_event(connector);
> +		connector->funcs->oob_hotplug_event(connector, hpd_state);
>  
>  	drm_connector_put(connector);
>  }
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index 146b83916005..00520867d37b 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -4816,15 +4816,23 @@ static int intel_dp_connector_atomic_check(struct drm_connector *conn,
>  	return intel_modeset_synced_crtcs(state, conn);
>  }
>  
> -static void intel_dp_oob_hotplug_event(struct drm_connector *connector)
> +static void intel_dp_oob_hotplug_event(struct drm_connector *connector, bool hpd_state)
>  {
>  	struct intel_encoder *encoder = intel_attached_encoder(to_intel_connector(connector));
>  	struct drm_i915_private *i915 = to_i915(connector->dev);
> +	bool need_work = false;
>  
>  	spin_lock_irq(&i915->irq_lock);
> -	i915->hotplug.event_bits |= BIT(encoder->hpd_pin);
> +	if (hpd_state != i915->hotplug.oob_hotplug_state) {

hpd_state is speific to the encoder (pin) so similarly to event_bits
oob_hotplug_state should be a bitmask as well.

> +		i915->hotplug.event_bits |= BIT(encoder->hpd_pin);
> +
> +		i915->hotplug.oob_hotplug_state = hpd_state;
> +		need_work = true;
> +	}
>  	spin_unlock_irq(&i915->irq_lock);
> -	queue_delayed_work(system_wq, &i915->hotplug.hotplug_work, 0);
> +
> +	if (need_work)
> +		queue_delayed_work(system_wq, &i915->hotplug.hotplug_work, 0);
>  }
>  
>  static const struct drm_connector_funcs intel_dp_connector_funcs = {
> diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
> index 8c1706fd81f9..543ebf1cfcf4 100644
> --- a/drivers/gpu/drm/i915/i915_drv.h
> +++ b/drivers/gpu/drm/i915/i915_drv.h
> @@ -149,6 +149,9 @@ struct i915_hotplug {
>  	/* Whether or not to count short HPD IRQs in HPD storms */
>  	u8 hpd_short_storm_enabled;
>  
> +	/* Last state reported by oob_hotplug_event */
> +	bool oob_hotplug_state;
> +
>  	/*
>  	 * if we get a HPD irq from DP and a HPD irq from non-DP
>  	 * the non-DP HPD could block the workqueue on a mode config
> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
> index c1d8c23baa39..a4596be4d34a 100644
> --- a/drivers/usb/typec/altmodes/displayport.c
> +++ b/drivers/usb/typec/altmodes/displayport.c
> @@ -59,7 +59,6 @@ struct dp_altmode {
>  	struct typec_displayport_data data;
>  
>  	enum dp_state state;
> -	bool hpd;
>  
>  	struct mutex lock; /* device lock */
>  	struct work_struct work;
> @@ -143,10 +142,7 @@ static int dp_altmode_status_update(struct dp_altmode *dp)
>  		if (!ret)
>  			dp->state = DP_STATE_CONFIGURE;
>  	} else {
> -		if (dp->hpd != hpd) {
> -			drm_connector_oob_hotplug_event(dp->connector_fwnode);
> -			dp->hpd = hpd;
> -		}
> +		drm_connector_oob_hotplug_event(dp->connector_fwnode, hpd);
>  	}
>  
>  	return ret;
> @@ -573,8 +569,7 @@ void dp_altmode_remove(struct typec_altmode *alt)
>  	cancel_work_sync(&dp->work);
>  
>  	if (dp->connector_fwnode) {
> -		if (dp->hpd)
> -			drm_connector_oob_hotplug_event(dp->connector_fwnode);
> +		drm_connector_oob_hotplug_event(dp->connector_fwnode, false);
>  
>  		fwnode_handle_put(dp->connector_fwnode);
>  	}
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 64cf5f88c05b..7c90b8eb2ace 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -1141,7 +1141,7 @@ struct drm_connector_funcs {
>  	 * This will get called when a hotplug-event for a drm-connector
>  	 * has been received from a source outside the display driver / device.
>  	 */
> -	void (*oob_hotplug_event)(struct drm_connector *connector);
> +	void (*oob_hotplug_event)(struct drm_connector *connector, bool hpd_state);
>  };
>  
>  /**
> @@ -1742,7 +1742,8 @@ drm_connector_is_unregistered(struct drm_connector *connector)
>  		DRM_CONNECTOR_UNREGISTERED;
>  }
>  
> -void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode);
> +void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode,
> +				     bool hpd_state);
>  const char *drm_get_connector_type_name(unsigned int connector_type);
>  const char *drm_get_connector_status_name(enum drm_connector_status status);
>  const char *drm_get_subpixel_order_name(enum subpixel_order order);
> -- 
> 2.33.1
> 
