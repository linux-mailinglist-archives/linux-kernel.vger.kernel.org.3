Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7204577DA3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 10:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiGRIi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 04:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbiGRIix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 04:38:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA607646F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 01:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658133529; x=1689669529;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t50ce0iWf8MPb00qQ82+a/pLMlvOdP1IbSRFXP5DI5A=;
  b=gcUoCFVX4iAahOGSS3bchP4VdxEGDKmznR1REZCiQ2YHt5resWBaQudw
   HnRobYBaakTkHKXr6nxeq8fA9nYqJ2oSps4/Ap4TKdJV/B+N8FfEL8BOj
   S/gd1TK6Yg81+1hckem3aBq6YbYNuOcOwm3+zuNS/9zP7rKMl5jV+5Kct
   9dtXAO7h5chZbIgBg7eMMxLOIO0nv9UFe13+fyowU/Bxn9Xhr4BkkvmUf
   X6OAV41o2f7kFk8Eo/ShH7nB35ReaYKxpIx62RXi1WzX9iESy4VPfogVF
   orJh7TS2EK6ZAQoMkTnx/en6UKrlA1yGABFuDiZfUs1GvwstF/Kg1BVwg
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="284924723"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="284924723"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 01:38:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="739385810"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 18 Jul 2022 01:38:47 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 18 Jul 2022 11:38:46 +0300
Date:   Mon, 18 Jul 2022 11:38:46 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        bleung@chromium.org, Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 2/2] platform/chrome: cros_ec_typec: Register port
 altmodes
Message-ID: <YtUcFvp2udsAbPgQ@kuha.fi.intel.com>
References: <20220712210318.2671292-1-pmalani@chromium.org>
 <20220712210318.2671292-2-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712210318.2671292-2-pmalani@chromium.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 09:03:18PM +0000, Prashant Malani wrote:
> Instead of using manually managed altmode structs, register the port's
> altmodes with the Type-C framework. This facilitates matching them to
> partner altmodes later.
> 
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/platform/chrome/cros_ec_typec.c | 51 +++++++++++++++++++------
>  1 file changed, 40 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index b9848e80f372..e67cccb9ac78 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -25,6 +25,8 @@
>  
>  #define DRV_NAME "cros-ec-typec"
>  
> +#define DP_PORT_VDO	(BIT(DP_PIN_ASSIGN_C) | BIT(DP_PIN_ASSIGN_D) | DP_CAP_DFP_D)
> +
>  /* Supported alt modes. */
>  enum {
>  	CROS_EC_ALTMODE_DP = 0,
> @@ -60,7 +62,7 @@ struct cros_typec_port {
>  	uint8_t mux_flags;
>  	uint8_t role;
>  
> -	struct typec_altmode port_altmode[CROS_EC_ALTMODE_MAX];
> +	struct typec_altmode *port_altmode[CROS_EC_ALTMODE_MAX];
>  
>  	/* Flag indicating that PD partner discovery data parsing is completed. */
>  	bool sop_disc_done;
> @@ -253,6 +255,14 @@ static void cros_typec_remove_cable(struct cros_typec_data *typec,
>  	port->sop_prime_disc_done = false;
>  }
>  
> +static void cros_typec_unregister_port_altmodes(struct cros_typec_port *port)
> +{
> +	int i;
> +
> +	for (i = 0; i < CROS_EC_ALTMODE_MAX; i++)
> +		typec_unregister_altmode(port->port_altmode[i]);
> +}
> +
>  static void cros_unregister_ports(struct cros_typec_data *typec)
>  {
>  	int i;
> @@ -267,34 +277,49 @@ static void cros_unregister_ports(struct cros_typec_data *typec)
>  		usb_role_switch_put(typec->ports[i]->role_sw);
>  		typec_switch_put(typec->ports[i]->ori_sw);
>  		typec_mux_put(typec->ports[i]->mux);
> +		cros_typec_unregister_port_altmodes(typec->ports[i]);
>  		typec_unregister_port(typec->ports[i]->port);
>  	}
>  }
>  
>  /*
> - * Fake the alt mode structs until we actually start registering Type C port
> - * and partner alt modes.
> + * Register port alt modes with known values till we start retrieving
> + * port capabilities from the EC.
>   */
> -static void cros_typec_register_port_altmodes(struct cros_typec_data *typec,
> +static int cros_typec_register_port_altmodes(struct cros_typec_data *typec,
>  					      int port_num)
>  {
>  	struct cros_typec_port *port = typec->ports[port_num];
> +	struct typec_altmode_desc desc;
> +	struct typec_altmode *amode;
>  
>  	/* All PD capable CrOS devices are assumed to support DP altmode. */
> -	port->port_altmode[CROS_EC_ALTMODE_DP].svid = USB_TYPEC_DP_SID;
> -	port->port_altmode[CROS_EC_ALTMODE_DP].mode = USB_TYPEC_DP_MODE;
> +	desc.svid = USB_TYPEC_DP_SID,
> +	desc.mode = USB_TYPEC_DP_MODE,
> +	desc.vdo = DP_PORT_VDO,
> +	amode = typec_port_register_altmode(port->port, &desc);
> +	if (IS_ERR(amode))
> +		return PTR_ERR(amode);
> +	port->port_altmode[CROS_EC_ALTMODE_DP] = amode;
>  
>  	/*
>  	 * Register TBT compatibility alt mode. The EC will not enter the mode
>  	 * if it doesn't support it, so it's safe to register it unconditionally
>  	 * here for now.
>  	 */
> -	port->port_altmode[CROS_EC_ALTMODE_TBT].svid = USB_TYPEC_TBT_SID;
> -	port->port_altmode[CROS_EC_ALTMODE_TBT].mode = TYPEC_ANY_MODE;
> +	memset(&desc, 0, sizeof(desc));
> +	desc.svid = USB_TYPEC_TBT_SID,
> +	desc.mode = TYPEC_ANY_MODE,
> +	amode = typec_port_register_altmode(port->port, &desc);
> +	if (IS_ERR(amode))
> +		return PTR_ERR(amode);
> +	port->port_altmode[CROS_EC_ALTMODE_TBT] = amode;
>  
>  	port->state.alt = NULL;
>  	port->state.mode = TYPEC_STATE_USB;
>  	port->state.data = NULL;
> +
> +	return 0;
>  }
>  
>  static int cros_typec_init_ports(struct cros_typec_data *typec)
> @@ -361,7 +386,11 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
>  			dev_dbg(dev, "No switch control for port %d\n",
>  				port_num);
>  
> -		cros_typec_register_port_altmodes(typec, port_num);
> +		ret = cros_typec_register_port_altmodes(typec, port_num);
> +		if (ret) {
> +			dev_err(dev, "Failed to register port altmodes\n");
> +			goto unregister_ports;
> +		}
>  
>  		cros_port->disc_data = devm_kzalloc(dev, EC_PROTO2_MAX_RESPONSE_SIZE, GFP_KERNEL);
>  		if (!cros_port->disc_data) {
> @@ -430,7 +459,7 @@ static int cros_typec_enable_tbt(struct cros_typec_data *typec,
>  		data.enter_vdo |= TBT_ENTER_MODE_ACTIVE_CABLE;
>  
>  	if (!port->state.alt) {
> -		port->state.alt = &port->port_altmode[CROS_EC_ALTMODE_TBT];
> +		port->state.alt = port->port_altmode[CROS_EC_ALTMODE_TBT];
>  		ret = cros_typec_usb_safe_state(port);
>  		if (ret)
>  			return ret;
> @@ -472,7 +501,7 @@ static int cros_typec_enable_dp(struct cros_typec_data *typec,
>  	/* Configuration VDO. */
>  	dp_data.conf = DP_CONF_SET_PIN_ASSIGN(pd_ctrl->dp_mode);
>  	if (!port->state.alt) {
> -		port->state.alt = &port->port_altmode[CROS_EC_ALTMODE_DP];
> +		port->state.alt = port->port_altmode[CROS_EC_ALTMODE_DP];
>  		ret = cros_typec_usb_safe_state(port);
>  		if (ret)
>  			return ret;
> -- 
> 2.37.0.144.g8ac04bfd2-goog

-- 
heikki
