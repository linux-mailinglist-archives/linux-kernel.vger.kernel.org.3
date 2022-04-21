Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A549E509D24
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388108AbiDUKKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354947AbiDUKKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:10:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86474286D7;
        Thu, 21 Apr 2022 03:07:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3BA22B8233A;
        Thu, 21 Apr 2022 10:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784B0C385A1;
        Thu, 21 Apr 2022 10:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650535659;
        bh=4uQ8r3mXhXLd76TxIbpDEIMJezspVHkacQKu5lK2eg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zgUsSRLpb/S0iggDZD/Wh6rIYeGUazairYpYXKd50h7p7R11HU2s5O9Kz7M33veOi
         MJUfbz0nA0NRARHhGOvOrQMUM9vBp2OwR9jChZULqGqYgQDWQhixrJmslQ7O2JHrst
         6OGsW11hBs/vMtqmn91MmlXvJinN8e2/H0hX/bBY=
Date:   Thu, 21 Apr 2022 12:07:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zixuan Fu <r33s3n6@gmail.com>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: Re: [PATCH] drivers: usb: host: fix NULL pointer dereferences
 triggered by unhandled errors in xhci_create_rhub_port_array()
Message-ID: <YmEs6BqcyM7fgLXg@kroah.com>
References: <20220421094236.1052170-1-r33s3n6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421094236.1052170-1-r33s3n6@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 05:42:36PM +0800, Zixuan Fu wrote:
> In xhci_create_rhub_port_array(), when rhub->num_ports is zero, 
> rhub->ports would not be set; when kcalloc_node() fails, rhub->ports
> would be set to NULL. In these two cases, xhci_create_rhub_port_array()
> just returns void, and thus its callers are unaware of the error.
> 
> Then rhub->ports is dereferenced in xhci_usb3_hub_descriptor() or 
> xhci_usb2_hub_descriptor().
> 
> To fix the bug, xhci_setup_port_arrays() should return an integer to 
> indicate a possible error, and its callers should handle the error.
> 
> Here is the log when this bug occurred in our fault-injection testing:
> 
> [   24.001309] BUG: kernel NULL pointer dereference, address: 0000000000000000
> ...
> [   24.003992] RIP: 0010:xhci_hub_control+0x3f5/0x60d0 [xhci_hcd]
> ...
> [   24.009803] Call Trace:
> [   24.010014]  <TASK>
> [   24.011310]  usb_hcd_submit_urb+0x1233/0x1fd0
> [   24.017071]  usb_start_wait_urb+0x115/0x310
> [   24.017641]  usb_control_msg+0x28a/0x450
> [   24.019046]  hub_probe+0xb16/0x2320
> [   24.019757]  usb_probe_interface+0x4f1/0x930
> [   24.019765]  really_probe+0x33d/0x970
> [   24.019768]  __driver_probe_device+0x157/0x210
> [   24.019772]  driver_probe_device+0x4f/0x340
> [   24.019775]  __device_attach_driver+0x2ee/0x3a0
> ...
> 
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Zixuan Fu <r33s3n6@gmail.com>
> ---
>  drivers/usb/host/xhci-mem.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> index bbb27ee2c6a3..024515346c39 100644
> --- a/drivers/usb/host/xhci-mem.c
> +++ b/drivers/usb/host/xhci-mem.c
> @@ -2235,7 +2235,7 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
>  	/* FIXME: Should we disable ports not in the Extended Capabilities? */
>  }
>  
> -static void xhci_create_rhub_port_array(struct xhci_hcd *xhci,
> +static int xhci_create_rhub_port_array(struct xhci_hcd *xhci,
>  					struct xhci_hub *rhub, gfp_t flags)
>  {
>  	int port_index = 0;
> @@ -2243,11 +2243,11 @@ static void xhci_create_rhub_port_array(struct xhci_hcd *xhci,
>  	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
>  
>  	if (!rhub->num_ports)
> -		return;
> +		return -EINVAL;
>  	rhub->ports = kcalloc_node(rhub->num_ports, sizeof(*rhub->ports),
>  			flags, dev_to_node(dev));
>  	if (!rhub->ports)
> -		return;
> +		return -ENOMEM;
>  
>  	for (i = 0; i < HCS_MAX_PORTS(xhci->hcs_params1); i++) {
>  		if (xhci->hw_ports[i].rhub != rhub ||
> @@ -2259,6 +2259,7 @@ static void xhci_create_rhub_port_array(struct xhci_hcd *xhci,
>  		if (port_index == rhub->num_ports)
>  			break;
>  	}
> +	return 0;
>  }
>  
>  /*
> @@ -2277,6 +2278,7 @@ static int xhci_setup_port_arrays(struct xhci_hcd *xhci, gfp_t flags)
>  	int cap_count = 0;
>  	u32 cap_start;
>  	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
> +	int ret;
>  
>  	num_ports = HCS_MAX_PORTS(xhci->hcs_params1);
>  	xhci->hw_ports = kcalloc_node(num_ports, sizeof(*xhci->hw_ports),
> @@ -2367,8 +2369,13 @@ static int xhci_setup_port_arrays(struct xhci_hcd *xhci, gfp_t flags)
>  	 * Not sure how the USB core will handle a hub with no ports...
>  	 */
>  
> -	xhci_create_rhub_port_array(xhci, &xhci->usb2_rhub, flags);
> -	xhci_create_rhub_port_array(xhci, &xhci->usb3_rhub, flags);
> +	ret = xhci_create_rhub_port_array(xhci, &xhci->usb2_rhub, flags);
> +	if (ret)
> +		return ret;
> +
> +	ret = xhci_create_rhub_port_array(xhci, &xhci->usb3_rhub, flags);
> +	if (ret)
> +		return ret;

What about the memory allocated by the first call to
xhci_create_rhub_port_array()?  Is that now lost?  Same for everything
else allocated before these calls, how is that cleaned up properly?

thanks,

greg k-h
