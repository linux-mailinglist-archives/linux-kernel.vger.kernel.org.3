Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F6F561514
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbiF3I1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiF3I1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:27:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDE9102;
        Thu, 30 Jun 2022 01:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656577632; x=1688113632;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qi9li/NCV765ItXQMioKvs0Czkex9a7+A1S0LgmtYeY=;
  b=OnUxFdSh68jlzHUMuxr/eV9mcd0Y5QGcazevQslFlWMhRGz4l5imyq0n
   aHEgou5CL8XDv7ktRLpg4Sqh7lCknXfcg77pYoTqvJURkmSxyfJAKUAWR
   tODc+4a8H7G72v7H7KcuJpbXHQUVBnVyB+aXnB8R/evA4fZisBwVZfe8f
   CgMtAuQC+0k2UoObRlvXhEC2adjzb2b09EkeK9OMDOeOTOLQNmOH73ego
   zPd3iz+UYAvaupZ3xF9+1tD0u0GBa8nrZjiLI+lw4KNADoXoeukM/YzNr
   5nUhNDKINTouFvKip6JhR8BQ2rVUfXM0vAY3wFmHeye1dhE9w9D4ewiyH
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="262083040"
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="262083040"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 01:27:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="733545706"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 30 Jun 2022 01:27:08 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 30 Jun 2022 11:27:07 +0300
Date:   Thu, 30 Jun 2022 11:27:07 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        chrome-platform@lists.linux.dev, bleung@chromium.org,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 2/9] usb: typec: Add retimer handle to port
Message-ID: <Yr1eW1gHR7LGP70Y@kuha.fi.intel.com>
References: <20220629233314.3540377-1-pmalani@chromium.org>
 <20220629233314.3540377-3-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629233314.3540377-3-pmalani@chromium.org>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 29, 2022 at 11:32:20PM +0000, Prashant Malani wrote:
> Similar to mux and orientation switch, add a handle for registered
> retimer to the port, so that it has handles to the various switches
> connected to it.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>  drivers/usb/typec/class.c | 8 ++++++++
>  drivers/usb/typec/class.h | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 2fa0b3718d23..2bc5fbdb25dd 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -12,6 +12,7 @@
>  #include <linux/slab.h>
>  #include <linux/usb/pd_vdo.h>
>  #include <linux/usb/typec_mux.h>
> +#include <linux/usb/typec_retimer.h>
>  
>  #include "bus.h"
>  #include "class.h"
> @@ -2249,6 +2250,13 @@ struct typec_port *typec_register_port(struct device *parent,
>  		return ERR_PTR(ret);
>  	}
>  
> +	port->retimer = typec_retimer_get(&port->dev);
> +	if (IS_ERR(port->retimer)) {
> +		ret = PTR_ERR(port->retimer);
> +		put_device(&port->dev);
> +		return ERR_PTR(ret);
> +	}
> +
>  	ret = device_add(&port->dev);
>  	if (ret) {
>  		dev_err(parent, "failed to register port (%d)\n", ret);

I think you need to release the reference with typec_retimer_put() in
typec_release().

I guess we can look handle this later, but there can actually be two
onboard retimers for each connector.

thanks,

> diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
> index 1bb1da124109..97520406929e 100644
> --- a/drivers/usb/typec/class.h
> +++ b/drivers/usb/typec/class.h
> @@ -55,6 +55,7 @@ struct typec_port {
>  	enum typec_orientation		orientation;
>  	struct typec_switch		*sw;
>  	struct typec_mux		*mux;
> +	struct typec_retimer		*retimer;
>  
>  	const struct typec_capability	*cap;
>  	const struct typec_operations   *ops;

-- 
heikki
