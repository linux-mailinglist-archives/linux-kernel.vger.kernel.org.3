Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F33852470A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351039AbiELHdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiELHdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:33:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA76036E1E;
        Thu, 12 May 2022 00:33:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18DE561EAC;
        Thu, 12 May 2022 07:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF99C385B8;
        Thu, 12 May 2022 07:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652340785;
        bh=ddtYkLWi+bM8tkL0qc0h+qJ4uhi+fLy4+YkKK0LtHbg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wV27bUBQBIbBOYhuWHfMGmWDf7fuQPVKdZ14av7tNkdFYnl/u2lO8ebA0WaB2htok
         RVGNf9JnIoMk73NIyBGm/6aWdJWmVPV8Le+xz/YmhGh3W+OLz5yrdEIamtGtpnEQLN
         n+BkrZw/qyYzJok9jcempbZproDgzQU9LJ827Wi8=
Date:   Thu, 12 May 2022 09:33:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Albert Wang <albertccwang@google.com>
Cc:     balbi@kernel.org, quic_jackp@quicinc.com, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: dwc3: gadget: Move null pinter check after
 window closed
Message-ID: <Yny4LgeQ+r6w0vhJ@kroah.com>
References: <20220512043739.1234857-1-albertccwang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512043739.1234857-1-albertccwang@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 12:37:39PM +0800, Albert Wang wrote:
> After inspecting further, we do see the locking is implicit, with the
> main gotcha being the unlock/re-lock. That creates a window for a race
> to happen. This change moves the NULL check to be adjacent to where
> to it's used and after the window is "closed".
> 
> Fixes: 26288448120b ("usb: dwc3: gadget: Fix null pointer exception")
> 
> Signed-off-by: Albert Wang <albertccwang@google.com>
> ---
>  drivers/usb/dwc3/gadget.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 19477f4bbf54..fda58951cf27 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -3366,14 +3366,19 @@ static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
>  	struct dwc3		*dwc = dep->dwc;
>  	bool			no_started_trb = true;
>  
> -	if (!dep->endpoint.desc)
> -		return no_started_trb;
> -
> +	/*
> +	 * This function eventually leads to dwc3_giveback() which unlocks
> +	 * the dwc->lock and relocks afterwards. This actually creates a
> +	 * a window for a race to happen.
> +	 */
>  	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);
>  
>  	if (dep->flags & DWC3_EP_END_TRANSFER_PENDING)
>  		goto out;
>  
> +	if (!dep->endpoint.desc)
> +		return no_started_trb;
> +
>  	if (usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
>  		list_empty(&dep->started_list) &&
>  		(list_empty(&dep->pending_list) || status == -EXDEV))
> -- 
> 2.36.0.550.gb090851708-goog
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
