Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90564D2D08
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 11:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiCIKWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 05:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiCIKWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 05:22:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4F116FDE8;
        Wed,  9 Mar 2022 02:21:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F43FB81FF7;
        Wed,  9 Mar 2022 10:21:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C42C340E8;
        Wed,  9 Mar 2022 10:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646821306;
        bh=Wm6tZYodnJhLaX2LYxO6sDtIEcS/tDhVWe8DN5ggHFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nlz1py1GRsjS+umP2V+rm1oqiosy9OL4/vbrcwaaIQoq/8G9FeyK54V8yKPjafEaM
         2S2+p0gTTETq4b61VteUcVjgkb/VZQWeRG/jRn7AFdv4wdLEsu8zX/mAQeDt7caAN1
         iUaaHxqIl6xjtMMBhP91Yp3lMEctbv+0aYP0vk5k=
Date:   Wed, 9 Mar 2022 11:21:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_jackp@quicinc.com,
        Thinh.Nguyen@synopsys.com
Subject: Re: [PATCH] usb: dwc3: gadget: Wait for ep0 xfers to complete during
 dequeue
Message-ID: <Yih/tapu/JMRgBqT@kroah.com>
References: <20220309004148.12061-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309004148.12061-1-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 04:41:48PM -0800, Wesley Cheng wrote:
> From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> 
> If the request being dequeued is currently active, then the current
> logic is to issue a stop transfer command, and allow the command
> completion to cleanup the cancelled list.  The DWC3 controller will
> run into an end transfer command timeout if there is an ongoing EP0
> transaction.  If this is the case, wait for the EP0 completion event
> before proceeding to retry the endxfer command again.
> 
> Co-developed-by: Wesley Cheng <quic_wcheng@quicinc.com>
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>


You sent this twice?  What is the differences between the patches?

And as you sent it, your signed-off-by needs to be at the end, as per
the kernel documentation.

> ---
>  Patch discussion below:
>    https://lore.kernel.org/linux-usb/1644836933-141376-1-git-send-email-dh10.jung@samsung.com/T/#t

So this is a v2?


> 
>  drivers/usb/dwc3/core.h   |  2 +-
>  drivers/usb/dwc3/ep0.c    | 14 ++++++++++++++
>  drivers/usb/dwc3/gadget.c | 13 ++++++++-----
>  drivers/usb/dwc3/gadget.h |  1 +
>  4 files changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index eb9c1efced05..f557f5f36a7f 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -736,7 +736,7 @@ struct dwc3_ep {
>  #define DWC3_EP_FIRST_STREAM_PRIMED	BIT(10)
>  #define DWC3_EP_PENDING_CLEAR_STALL	BIT(11)
>  #define DWC3_EP_TXFIFO_RESIZED		BIT(12)
> -
> +#define DWC3_EP_DELAY_STOP             BIT(13)

Why did you loose the blank line?

>  	/* This last one is specific to EP0 */
>  #define DWC3_EP0_DIR_IN			BIT(31)
>  
> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
> index 658739410992..1064be5518f6 100644
> --- a/drivers/usb/dwc3/ep0.c
> +++ b/drivers/usb/dwc3/ep0.c
> @@ -271,6 +271,7 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
>  {
>  	struct dwc3_ep			*dep;
>  	int				ret;
> +	int                             i;
>  
>  	complete(&dwc->ep0_in_setup);
>  
> @@ -279,6 +280,19 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
>  			DWC3_TRBCTL_CONTROL_SETUP, false);
>  	ret = dwc3_ep0_start_trans(dep);
>  	WARN_ON(ret < 0);
> +	for (i = 2; i < DWC3_ENDPOINTS_NUM; i++) {
> +		struct dwc3_ep *dwc3_ep;
> +
> +		dwc3_ep = dwc->eps[i];
> +		if (!dwc3_ep)
> +			continue;
> +
> +		if (!(dwc3_ep->flags & DWC3_EP_DELAY_STOP))
> +			continue;
> +
> +		dwc3_ep->flags &= ~DWC3_EP_DELAY_STOP;
> +		dwc3_stop_active_transfer(dwc3_ep, true, true);
> +	}
>  }
>  
>  static struct dwc3_ep *dwc3_wIndex_to_dep(struct dwc3 *dwc, __le16 wIndex_le)
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index a0c883f19a41..ccef508b1296 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -654,9 +654,6 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
>  	return dwc3_send_gadget_ep_cmd(dep, DWC3_DEPCMD_SETEPCONFIG, &params);
>  }
>  
> -static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
> -		bool interrupt);
> -
>  /**
>   * dwc3_gadget_calc_tx_fifo_size - calculates the txfifo size value
>   * @dwc: pointer to the DWC3 context
> @@ -1899,6 +1896,7 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
>  	 */
>  	if ((dep->flags & DWC3_EP_END_TRANSFER_PENDING) ||
>  	    (dep->flags & DWC3_EP_WEDGE) ||
> +	    (dep->flags & DWC3_EP_DELAY_STOP) ||
>  	    (dep->flags & DWC3_EP_STALL)) {
>  		dep->flags |= DWC3_EP_DELAY_START;
>  		return 0;
> @@ -2033,6 +2031,9 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
>  		if (r == req) {
>  			struct dwc3_request *t;
>  
> +			if (dwc->ep0state != EP0_SETUP_PHASE && !dwc->delayed_status)
> +				dep->flags |= DWC3_EP_DELAY_STOP;
> +
>  			/* wait until it is processed */
>  			dwc3_stop_active_transfer(dep, true, true);
>  
> @@ -2116,7 +2117,8 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
>  		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
>  			dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STATUS_STALLED);
>  
> -		if (dep->flags & DWC3_EP_END_TRANSFER_PENDING) {
> +		if (dep->flags & DWC3_EP_END_TRANSFER_PENDING ||
> +		    (dep->flags & DWC3_EP_DELAY_STOP)) {
>  			dep->flags |= DWC3_EP_PENDING_CLEAR_STALL;
>  			return 0;
>  		}
> @@ -3596,7 +3598,7 @@ static void dwc3_reset_gadget(struct dwc3 *dwc)
>  	}
>  }
>  
> -static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
> +void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
>  	bool interrupt)

This is a horrid api (2 booleans?)  But you aren't adding it so I guess
we can live with it :(

thanks,

greg k-h
