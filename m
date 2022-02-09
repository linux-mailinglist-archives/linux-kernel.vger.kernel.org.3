Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6608C4AF0A4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbiBIMEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbiBIMDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:03:15 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D765C03C18E;
        Wed,  9 Feb 2022 03:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644406882; x=1675942882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UAVflgTtkMa7VNcbZK8/nl2b5LKf0MxHQx8zZ0cgHss=;
  b=F2fHKD6BsnjBtqsNOg+Gy92E2xeXgftMg6xogc0nFgmwWUh/68sXpA2B
   9xAhKZHMoqwancYsoJmuhuInja2mFBKs+atLzaXgMAbxWTg2c+ZquXHKW
   ucC6qR1ko++j13Um1/hXgB0iGsPH/oo8ck/sdJLPh9d74Ij5pRRnjNP8t
   kVPbC7oEoHAu0ZlT4n9hXizoYwf+gjfGyEHbKMvMzYA43yKFD6QRoNY2b
   +Qky91tncPl29gPaRtiohsrKTRL8NZusw9y5GbYOgaXooSHkAJ5jy+k8i
   jLy8jB3jWcjcgtLMxNvF8giosNNuo/HUDSo9Yb9GmKXE6/4TWI4x+gzAk
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="232751969"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="232751969"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 03:41:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="678544416"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 09 Feb 2022 03:41:18 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 09 Feb 2022 13:41:18 +0200
Date:   Wed, 9 Feb 2022 13:41:18 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] usb: typec: Factor out non-PD fwnode properties
Message-ID: <YgOoXgFKaLsdYYKZ@kuha.fi.intel.com>
References: <20220202221948.5690-1-samuel@sholland.org>
 <20220202221948.5690-4-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202221948.5690-4-samuel@sholland.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 04:19:46PM -0600, Samuel Holland wrote:
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 5fce795b69c7..8b58aa6e3509 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -5935,32 +5935,10 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
>  	if (!fwnode)
>  		return -EINVAL;
>  
> -	/*
> -	 * This fwnode has a "compatible" property, but is never populated as a
> -	 * struct device. Instead we simply parse it to read the properties.
> -	 * This it breaks fw_devlink=on. To maintain backward compatibility
> -	 * with existing DT files, we work around this by deleting any
> -	 * fwnode_links to/from this fwnode.
> -	 */
> -	fw_devlink_purge_absent_suppliers(fwnode);
> -
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
> @@ -5997,14 +5975,6 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
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

It looks like after this there are no more users for that cap_str
variable. You need to remove that too.

thanks,

-- 
heikki
