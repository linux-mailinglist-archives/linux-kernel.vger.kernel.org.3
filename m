Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83DA4B839E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbiBPJFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:05:48 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbiBPJFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:05:43 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484BC140F8;
        Wed, 16 Feb 2022 01:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645002332; x=1676538332;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qL6XVUtQhDi8JNPHMmUbZrI0/tv/ETzCR2da60ToTa4=;
  b=H2bJkXOqyf/wIXwm8/6nv5EzonTkxAPsPh1PGQrCRI4m72L6Wucvhk/L
   FFEv+OWi0Lj7tTd2B9xp/F7wkGKMsqXm3VeKtCgw/rxaYH54WzntXx01I
   FezeDlBZyIE5mpX6NaenXH4xfJWVAHgEBDJMmi7xoPdB+QUPix7wYwUNz
   bJJIK7hSsjGWVSHsknSUSymwXf5BCHj2OYufbL8S9j9zMP1n/njDpiQEh
   5UwdOtZFbqBcd95r4Q+iStoNp7AA1eVKPaKygc0karyHNyeqQWhwL11FN
   GqnZ8es5In+ZEcHB4wr83jkr73JQRgOVmeeQFZMcLIV27xXJRbkSuBAis
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="249389777"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="249389777"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 01:05:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="681420548"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 16 Feb 2022 01:05:29 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 16 Feb 2022 11:05:28 +0200
Date:   Wed, 16 Feb 2022 11:05:28 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 3/4] usb: typec: Factor out non-PD fwnode properties
Message-ID: <Ygy+WOhXNLKjZQfA@kuha.fi.intel.com>
References: <20220214050118.61015-1-samuel@sholland.org>
 <20220214050118.61015-4-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214050118.61015-4-samuel@sholland.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2022 at 11:01:16PM -0600, Samuel Holland wrote:
> Basic programmable non-PD Type-C port controllers do not need the full
> TCPM library, but they share the same devicetree binding and the same
> typec_capability structure. Factor out a helper for parsing those
> properties which map to fields in struct typec_capability, so the code
> can be shared between TCPM and basic non-TCPM drivers.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes in v3:
>  - Leave the call to fw_devlink_purge_absent_suppliers in its original
>    place in the TCPM code. It is not needed by the new driver.
>  - Remove unused variable from TCPM function.
> 
> Changes in v2:
>  - Always put the return values from typec_find_* in a signed variable
>    for error checking.
> 
>  drivers/usb/typec/class.c     | 43 +++++++++++++++++++++++++++++++++++
>  drivers/usb/typec/tcpm/tcpm.c | 24 +------------------
>  include/linux/usb/typec.h     |  3 +++
>  3 files changed, 47 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 45a6f0c807cb..ee0e520707dd 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -1894,6 +1894,49 @@ void *typec_get_drvdata(struct typec_port *port)
>  }
>  EXPORT_SYMBOL_GPL(typec_get_drvdata);
>  
> +int typec_get_fw_cap(struct typec_capability *cap,
> +		     struct fwnode_handle *fwnode)
> +{
> +	const char *cap_str;
> +	int ret;
> +
> +	cap->fwnode = fwnode;
> +
> +	ret = fwnode_property_read_string(fwnode, "power-role", &cap_str);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = typec_find_port_power_role(cap_str);
> +	if (ret < 0)
> +		return ret;
> +	cap->type = ret;
> +
> +	/* USB data support is optional */
> +	ret = fwnode_property_read_string(fwnode, "data-role", &cap_str);
> +	if (ret == 0) {
> +		ret = typec_find_port_data_role(cap_str);
> +		if (ret < 0)
> +			return ret;
> +		cap->data = ret;
> +	}
> +
> +	/* Get the preferred power role for a DRP */
> +	if (cap->type == TYPEC_PORT_DRP) {
> +		cap->prefer_role = TYPEC_NO_PREFERRED_ROLE;
> +
> +		ret = fwnode_property_read_string(fwnode, "try-power-role", &cap_str);
> +		if (ret == 0) {
> +			ret = typec_find_power_role(cap_str);
> +			if (ret < 0)
> +				return ret;
> +			cap->prefer_role = ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(typec_get_fw_cap);
> +
>  /**
>   * typec_port_register_altmode - Register USB Type-C Port Alternate Mode
>   * @port: USB Type-C Port that supports the alternate mode
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 5fce795b69c7..3bc2f4ebd1fe 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -5928,7 +5928,6 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
>  			    struct fwnode_handle *fwnode)
>  {
>  	const char *opmode_str;
> -	const char *cap_str;
>  	int ret;
>  	u32 mw, frs_current;
>  
> @@ -5944,23 +5943,10 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
>  	 */
>  	fw_devlink_purge_absent_suppliers(fwnode);
>  
> -	/* USB data support is optional */
> -	ret = fwnode_property_read_string(fwnode, "data-role", &cap_str);
> -	if (ret == 0) {
> -		ret = typec_find_port_data_role(cap_str);
> -		if (ret < 0)
> -			return ret;
> -		port->typec_caps.data = ret;
> -	}
> -
> -	ret = fwnode_property_read_string(fwnode, "power-role", &cap_str);
> +	ret = typec_get_fw_cap(&port->typec_caps, fwnode);
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = typec_find_port_power_role(cap_str);
> -	if (ret < 0)
> -		return ret;
> -	port->typec_caps.type = ret;
>  	port->port_type = port->typec_caps.type;
>  	port->pd_supported = !fwnode_property_read_bool(fwnode, "pd-disable");
>  
> @@ -5997,14 +5983,6 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
>  	if (port->port_type == TYPEC_PORT_SRC)
>  		return 0;
>  
> -	/* Get the preferred power role for DRP */
> -	ret = fwnode_property_read_string(fwnode, "try-power-role", &cap_str);
> -	if (ret < 0)
> -		return ret;
> -
> -	port->typec_caps.prefer_role = typec_find_power_role(cap_str);
> -	if (port->typec_caps.prefer_role < 0)
> -		return -EINVAL;
>  sink:
>  	port->self_powered = fwnode_property_read_bool(fwnode, "self-powered");
>  
> diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> index 7ba45a97eeae..fdf737d48b3b 100644
> --- a/include/linux/usb/typec.h
> +++ b/include/linux/usb/typec.h
> @@ -295,6 +295,9 @@ int typec_set_mode(struct typec_port *port, int mode);
>  
>  void *typec_get_drvdata(struct typec_port *port);
>  
> +int typec_get_fw_cap(struct typec_capability *cap,
> +		     struct fwnode_handle *fwnode);
> +
>  int typec_find_pwr_opmode(const char *name);
>  int typec_find_orientation(const char *name);
>  int typec_find_port_power_role(const char *name);
> -- 
> 2.33.1

thanks,

-- 
heikki
