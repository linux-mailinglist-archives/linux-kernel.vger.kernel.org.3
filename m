Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FC84C4115
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 10:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238948AbiBYJRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 04:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237233AbiBYJRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 04:17:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59A863E4;
        Fri, 25 Feb 2022 01:16:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83496B82C91;
        Fri, 25 Feb 2022 09:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0730C340E7;
        Fri, 25 Feb 2022 09:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645780602;
        bh=8WxNMDgaDUho9As8RN3127St03EDjni/oYyOZGf/IRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1FY7UO4eCMCf/emTwM0S4YnXe7GCW02t4n8Op490yjbCpfZYY078xLuNXVlqLC1ua
         a8tloH+atnymhub1XLbgiCuFVIOBII2Ma+5N8+6ZNEi8jXnbOxsVww+K3tmSTO4SEn
         xiaQSfRtQzv3VL8ZL8lyVumGvSHSNYHFQ4b5AYGU=
Date:   Fri, 25 Feb 2022 10:16:39 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Henry Lin <henryl@nvidia.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] xhci: fix runtime PM imbalance in USB2 resume
Message-ID: <Yhied+G/K8MndRfk@kroah.com>
References: <20220225055311.92447-1-henryl@nvidia.com>
 <20220225071506.22012-1-henryl@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225071506.22012-1-henryl@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 03:15:06PM +0800, Henry Lin wrote:
> USB2 resume starts with usb_hcd_start_port_resume() in port status
> change handling for RESUME link state. usb_hcd_end_port_resume() call is
> needed to keep runtime PM balance.
> 
> Fixes: a231ec41e6f6 ("xhci: refactor U0 link state handling in get_port_status")
> Signed-off-by: Henry Lin <henryl@nvidia.com>
> ---
>  drivers/usb/host/xhci-hub.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
> index df3522dab31b..4a8b07b8ee01 100644
> --- a/drivers/usb/host/xhci-hub.c
> +++ b/drivers/usb/host/xhci-hub.c
> @@ -1090,6 +1090,8 @@ static void xhci_get_usb2_port_status(struct xhci_port *port, u32 *status,
>  		if (link_state == XDEV_U0) {
>  			bus_state->resume_done[portnum] = 0;
>  			clear_bit(portnum, &bus_state->resuming_ports);
> +			usb_hcd_end_port_resume(&port->rhub->hcd->self,
> +						portnum);
>  			if (bus_state->suspended_ports & (1 << portnum)) {
>  				bus_state->suspended_ports &= ~(1 << portnum);
>  				bus_state->port_c_suspend |= 1 << portnum;
> -- 
> 2.17.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
