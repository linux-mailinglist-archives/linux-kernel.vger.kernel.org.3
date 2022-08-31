Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00615A794A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiHaIpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiHaIph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:45:37 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56690A2A90
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 01:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661935536; x=1693471536;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=52mxpUUNQaLZvBzTGaxL1x5UXKfcnz4QIE6O7Q2Oy1E=;
  b=hXkawCArJEgT7X3zvTWHSxwHHKJtHqLYcpT3JKjnAw2flPBiRPGk3/Yl
   e5quEQI/MOkx7pmpo6KtOpP/6OGVhU41amMs/yLx4cxrLrAs/WuN7qBIj
   XaMRVK2gbX+VO78QKyxoCMnLpme1ej8KXtuUDMoL2d83OwCZh8J6TnfpI
   bnWA3WLAaDyUtEzSA8lkcQ3zLdtYThVA4Bg7Z0BRyWe3Sk7iCuBCjqs5n
   JB85+zVteILIGRStbQG/oj4aQS9+LVeQgDj/7A6darheiU/vVzY8eiAoM
   GdhVxp2c2vtWNkSx60DJEYOaKjc0gqwLbXLMSKKCnX3WI/kuBAOfUwA/o
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="275152698"
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="275152698"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 01:45:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="754358827"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 31 Aug 2022 01:45:33 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 31 Aug 2022 11:45:32 +0300
Date:   Wed, 31 Aug 2022 11:45:32 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        bleung@chromium.org, Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Register partner PDOs
Message-ID: <Yw8frAv2pMfjmE0U@kuha.fi.intel.com>
References: <20220830202018.1884851-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830202018.1884851-1-pmalani@chromium.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 08:20:18PM +0000, Prashant Malani wrote:
> The ChromeOS EC exports partner source/sink cap PDOs (Power Data
> Objects) to the application processor (AP). Use this information
> to register USB PD (Power Delivery) capabilities with the
> USB Type-C Power Delivery device class.
> 
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

This looks good to me. One nitpick below. With that fixed, FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Will you later register also the port PDOs?

> ---
>  drivers/platform/chrome/cros_ec_typec.c | 56 +++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 00208ffbe2e7..f84bf9659a0f 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -73,6 +73,11 @@ struct cros_typec_port {
>  	struct ec_response_typec_discovery *disc_data;
>  	struct list_head partner_mode_list;
>  	struct list_head plug_mode_list;
> +
> +	/* PDO-related structs */
> +	struct usb_power_delivery *partner_pd;
> +	struct usb_power_delivery_capabilities *partner_src_caps;
> +	struct usb_power_delivery_capabilities *partner_sink_caps;
>  };
>  
>  /* Platform-specific data for the Chrome OS EC Type C controller. */
> @@ -253,6 +258,14 @@ static void cros_typec_remove_partner(struct cros_typec_data *typec,
>  
>  	cros_typec_unregister_altmodes(typec, port_num, true);
>  
> +	typec_partner_set_usb_power_delivery(port->partner, NULL);
> +	usb_power_delivery_unregister_capabilities(port->partner_sink_caps);
> +	port->partner_sink_caps = NULL;
> +	usb_power_delivery_unregister_capabilities(port->partner_src_caps);
> +	port->partner_src_caps = NULL;
> +	usb_power_delivery_unregister(port->partner_pd);
> +	port->partner_pd = NULL;
> +
>  	cros_typec_usb_disconnect_state(port);
>  	port->mux_flags = USB_PD_MUX_NONE;
>  
> @@ -939,6 +952,46 @@ static int cros_typec_send_clear_event(struct cros_typec_data *typec, int port_n
>  			   sizeof(req), NULL, 0);
>  }
>  
> +static void cros_typec_register_partner_pdos(struct cros_typec_data *typec,
> +					     struct ec_response_typec_status *resp, int port_num)
> +{
> +	struct usb_power_delivery_capabilities_desc caps_desc = {};
> +	struct usb_power_delivery_desc desc = {
> +		.revision = (le16_to_cpu(resp->sop_revision) & 0xff00) >> 4,
> +	};
> +	struct cros_typec_port *port = typec->ports[port_num];
> +
> +	if (!port->partner || port->partner_pd)
> +		return;
> +
> +	/* If no caps are available, don't bother creating a device. */
> +	if (!resp->source_cap_count && !resp->sink_cap_count)
> +		return;
> +
> +	port->partner_pd = usb_power_delivery_register(NULL, &desc);
> +	if (IS_ERR(port->partner_pd)) {
> +		dev_warn(typec->dev, "Failed to register partner PD device, port: %d\n", port_num);
> +		return;
> +	}
> +
> +	typec_partner_set_usb_power_delivery(port->partner, port->partner_pd);
> +
> +	memcpy(caps_desc.pdo, resp->source_cap_pdos, sizeof(u32) * resp->source_cap_count);
> +	caps_desc.role = TYPEC_SOURCE;
> +	port->partner_src_caps = usb_power_delivery_register_capabilities(port->partner_pd,
> +									  &caps_desc);
> +	if (IS_ERR(port->partner_src_caps))
> +		dev_warn(typec->dev, "Failed to register source caps, port: %d\n", port_num);
> +
> +	memset(&caps_desc, 0, sizeof(caps_desc));
> +	memcpy(caps_desc.pdo, resp->sink_cap_pdos, sizeof(u32) * resp->sink_cap_count);
> +	caps_desc.role = TYPEC_SINK;
> +	port->partner_sink_caps = usb_power_delivery_register_capabilities(port->partner_pd,
> +									   &caps_desc);
> +	if (IS_ERR(port->partner_sink_caps))
> +		dev_warn(typec->dev, "Failed to register sink caps, port: %d\n", port_num);
> +}
> +
>  static void cros_typec_handle_status(struct cros_typec_data *typec, int port_num)
>  {
>  	struct ec_response_typec_status resp;
> @@ -986,6 +1039,8 @@ static void cros_typec_handle_status(struct cros_typec_data *typec, int port_num
>  		}
>  		if (resp.sop_connected)
>  			typec_set_pwr_opmode(typec->ports[port_num]->port, TYPEC_PWR_MODE_PD);
> +
> +		cros_typec_register_partner_pdos(typec, &resp, port_num);
>  	}
>  
>  	if (resp.events & PD_STATUS_EVENT_SOP_PRIME_DISC_DONE &&
> @@ -1006,6 +1061,7 @@ static void cros_typec_handle_status(struct cros_typec_data *typec, int port_num
>  					 "Failed SOP Disc event clear, port: %d\n", port_num);
>  		}
>  	}
> +
>  }

I'm guessing that extra newline was just a typo.

thanks,

-- 
heikki
