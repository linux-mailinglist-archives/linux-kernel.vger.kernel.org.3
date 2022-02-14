Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B734B5E67
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 00:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbiBNXpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 18:45:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiBNXpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 18:45:49 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C63DD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 15:45:40 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id x193so19217996oix.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 15:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nfkpfrdZAC9ghbfxseXAYQsgB3vdZOFr69e3ZKi13c4=;
        b=kcVU4KcsIwWEakkJ4QgJhDkta9FeYTTYt2h1CHNWCqpC2RAIclfeNBea9HfXg8SYyb
         RboH0P8Zp89ol7ajti2fAJ2pEoNuqBe7UpSjGEhzz0MrcrTJEiKvMX2Z3ndR/cL89Xdq
         b5bcsENSxzX7NRsM5TUx0AXygT/DdAGeG6N9/FLXt6yDZPgVSWd8cNlEnJN0+6QZYrqQ
         yZXHa/EGMHRLNTdJnP+v9pNZGr7sY2aPTn0SWDLxnnUjb9Pj8ZucXMMeAB8JaKXuj4p/
         Qb2pbFmtWfpzshJVpq0W8G7s0UZs/Xs8eO/ESHCq0Z+a64c99E19h3GhVie8U1oHe+Zw
         XVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nfkpfrdZAC9ghbfxseXAYQsgB3vdZOFr69e3ZKi13c4=;
        b=XjQ6NrU/rZo+S8wREURVkK9wrsemnN+60H2i3XOdfTFdH7acSjDfoi3vrQwfv6GWhk
         FFNPmJMui69w7kjfexMoWaVAHnCgIQwB5eHkQNOQQXnPufxLlEsKFSndzol7xRcAmmtK
         c9WBnIegLwMgEFCM/o7vbcgBd5BxbV1KjX4r0wfTuGFAu1xrMnkgg85iKgQBXRXKwx3a
         mPOkLggBpgowp04E39aUzb2oBSL2c2UJjThz2zTyL3+UwcEVWBF/wacgnbIm89FY+d0c
         KWLddUjxucx0KgJtOcM8aVOj92JMsCejhK234y9+CEcoiuSGft6dpvpdTViOYKXoHIap
         7ayg==
X-Gm-Message-State: AOAM5306ziuJm+Me4Z699+SlElao+Ar3m/QZ2jCon60IagsEingoL4Rr
        +vm4Nuf07aLKjMr6KdgLmS3/vg==
X-Google-Smtp-Source: ABdhPJz3yU4E+ybCVsol7Wn304FwHzzIReMzm5hg9IcI2Z0QH3avCApLTbKhHMGhbYBfsICiMMbu/g==
X-Received: by 2002:aca:5e0b:0:b0:2d0:e2c:9968 with SMTP id s11-20020aca5e0b000000b002d00e2c9968mr561613oib.206.1644882339654;
        Mon, 14 Feb 2022 15:45:39 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id e192sm13623894oob.11.2022.02.14.15.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 15:45:39 -0800 (PST)
Date:   Mon, 14 Feb 2022 15:47:49 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Imre Deak <imre.deak@intel.com>
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
Message-ID: <YgrqJS6gsQJYqWQg@ripper>
References: <20220208044328.588860-1-bjorn.andersson@linaro.org>
 <20220214175927.GA594729@ideak-desk.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214175927.GA594729@ideak-desk.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14 Feb 09:59 PST 2022, Imre Deak wrote:

> On Mon, Feb 07, 2022 at 08:43:27PM -0800, Bjorn Andersson wrote:
> > In some implementations, such as the Qualcomm platforms, the display
> > driver has no way to query the current HPD state and as such it's
> > impossible to distinguish between disconnect and attention events.
> > 
> > Add a parameter to drm_connector_oob_hotplug_event() to pass the HPD
> > state.
> > 
> > Also push the test for unchanged state in the displayport altmode driver
> > into the i915 driver, to allow other drivers to act upon each update.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> > 
> > Note that the Intel driver has only been compile tested with this patch.
> > 
> >  drivers/gpu/drm/drm_connector.c          |  6 ++++--
> >  drivers/gpu/drm/i915/display/intel_dp.c  | 14 +++++++++++---
> >  drivers/gpu/drm/i915/i915_drv.h          |  3 +++
> >  drivers/usb/typec/altmodes/displayport.c |  9 ++-------
> >  include/drm/drm_connector.h              |  5 +++--
> >  5 files changed, 23 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> > index a50c82bc2b2f..ad7295597c0f 100644
> > --- a/drivers/gpu/drm/drm_connector.c
> > +++ b/drivers/gpu/drm/drm_connector.c
> > @@ -2825,6 +2825,7 @@ struct drm_connector *drm_connector_find_by_fwnode(struct fwnode_handle *fwnode)
> >  /**
> >   * drm_connector_oob_hotplug_event - Report out-of-band hotplug event to connector
> >   * @connector_fwnode: fwnode_handle to report the event on
> > + * @hpd_state: number of data lanes available
> >   *
> >   * On some hardware a hotplug event notification may come from outside the display
> >   * driver / device. An example of this is some USB Type-C setups where the hardware
> > @@ -2834,7 +2835,8 @@ struct drm_connector *drm_connector_find_by_fwnode(struct fwnode_handle *fwnode)
> >   * This function can be used to report these out-of-band events after obtaining
> >   * a drm_connector reference through calling drm_connector_find_by_fwnode().
> >   */
> > -void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode)
> > +void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode,
> > +				     bool hpd_state)
> >  {
> >  	struct drm_connector *connector;
> >  
> > @@ -2843,7 +2845,7 @@ void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode)
> >  		return;
> >  
> >  	if (connector->funcs->oob_hotplug_event)
> > -		connector->funcs->oob_hotplug_event(connector);
> > +		connector->funcs->oob_hotplug_event(connector, hpd_state);
> >  
> >  	drm_connector_put(connector);
> >  }
> > diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> > index 146b83916005..00520867d37b 100644
> > --- a/drivers/gpu/drm/i915/display/intel_dp.c
> > +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> > @@ -4816,15 +4816,23 @@ static int intel_dp_connector_atomic_check(struct drm_connector *conn,
> >  	return intel_modeset_synced_crtcs(state, conn);
> >  }
> >  
> > -static void intel_dp_oob_hotplug_event(struct drm_connector *connector)
> > +static void intel_dp_oob_hotplug_event(struct drm_connector *connector, bool hpd_state)
> >  {
> >  	struct intel_encoder *encoder = intel_attached_encoder(to_intel_connector(connector));
> >  	struct drm_i915_private *i915 = to_i915(connector->dev);
> > +	bool need_work = false;
> >  
> >  	spin_lock_irq(&i915->irq_lock);
> > -	i915->hotplug.event_bits |= BIT(encoder->hpd_pin);
> > +	if (hpd_state != i915->hotplug.oob_hotplug_state) {
> 
> hpd_state is speific to the encoder (pin) so similarly to event_bits
> oob_hotplug_state should be a bitmask as well.
> 

That makes sense, thanks for point it out!

Regards,
Bjorn
