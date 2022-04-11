Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BC34FC166
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348241AbiDKPu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346426AbiDKPuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:50:24 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8F01095;
        Mon, 11 Apr 2022 08:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649692090; x=1681228090;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+TyBus24Umus7ZMTk+S6IRyj/G2u6EnizamRZLaTPng=;
  b=REf4iXb9HbrDxddQTjuPKNLwch9T9sOtwiU/dD2XFk7MgK8szi8kMidK
   4Htn/oPe9p3cTKmFmY9s359PRudNyCbKJFb2XLIQlmlfpw2cFctoHzeLC
   j2MXRmFuDqZk2TCBCePjIp7gBe5UpjPbrxcG9qjwvZwPC6bNaoqKTUl+A
   I=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 11 Apr 2022 08:48:09 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 08:48:09 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 11 Apr 2022 08:48:09 -0700
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 11 Apr 2022 08:48:07 -0700
Date:   Mon, 11 Apr 2022 21:18:03 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: EP clear halt leading to incorrect submission
 of delayed_status
Message-ID: <20220411154803.GA26372@hu-pkondeti-hyd.qualcomm.com>
References: <20220407015336.19455-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220407015336.19455-1-quic_wcheng@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wesley,

On Wed, Apr 06, 2022 at 06:53:36PM -0700, Wesley Cheng wrote:
> The usb_ep_clear_halt() API can be called from the function driver, and
> translates to dwc3_gadget_ep_set_halt().  This routine is shared with when
> the host issues a clear feature ENDPOINT_HALT, and is differentiated by the
> protocol argument.  If the following sequence occurs, there can be a
> situation where the delayed_status flag is improperly cleared for the wrong
> SETUP transaction:
> 
> 1. Vendor specific control transfer returns USB_GADGET_DELAYED_STATUS.
> 2. DWC3 gadget sets dwc->delayed_status to '1'.
> 3. Another function driver issues a usb_ep_clear_halt() call.
> 4. DWC3 gadget issues dwc3_stop_active_transfer() and sets
>    DWC3_EP_PENDING_CLEAR_STALL.
> 5. EP command complete interrupt triggers for the end transfer, and
>    dwc3_ep0_send_delayed_status() is allowed to run, as delayed_status
>    is '1' due to step#1.
> 6. STATUS phase is sent, and delayed_status is cleared.
> 7. Vendor specific control transfer is finished being handled, and issues
>    usb_composite_setup_continue().  This results in queuing of a data
>    phase.
> 
> Cache the protocol flag so that DWC3 gadget is aware of when the clear halt
> is due to a SETUP request from the host versus when it is sourced from a
> function driver.  This allows for the EP command complete interrupt to know
> if it needs to issue a delayed status phase.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  drivers/usb/dwc3/core.h   | 1 +
>  drivers/usb/dwc3/ep0.c    | 1 +
>  drivers/usb/dwc3/gadget.c | 3 ++-
>  3 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 5c9d467195a6..55f98485c54c 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -1272,6 +1272,7 @@ struct dwc3 {
>  	unsigned		connected:1;
>  	unsigned		softconnect:1;
>  	unsigned		delayed_status:1;
> +	unsigned		clear_stall_protocol:1;
>  	unsigned		ep0_bounced:1;
>  	unsigned		ep0_expect_in:1;
>  	unsigned		has_hibernation:1;
> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
> index 1064be5518f6..aa8476da222d 100644
> --- a/drivers/usb/dwc3/ep0.c
> +++ b/drivers/usb/dwc3/ep0.c
> @@ -1080,6 +1080,7 @@ void dwc3_ep0_send_delayed_status(struct dwc3 *dwc)
>  	unsigned int direction = !dwc->ep0_expect_in;
>  
>  	dwc->delayed_status = false;
> +	dwc->clear_stall_protocol = 0;
>  
>  	if (dwc->ep0state != EP0_STATUS_PHASE)
>  		return;
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index ab725d2262d6..c427ddae016f 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -2152,6 +2152,7 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
>  		if (dep->flags & DWC3_EP_END_TRANSFER_PENDING ||
>  		    (dep->flags & DWC3_EP_DELAY_STOP)) {
>  			dep->flags |= DWC3_EP_PENDING_CLEAR_STALL;
> +			dwc->clear_stall_protocol = protocol;
>  			return 0;
>  		}
>  
> @@ -3483,7 +3484,7 @@ static void dwc3_gadget_endpoint_command_complete(struct dwc3_ep *dep,
>  		}
>  
>  		dep->flags &= ~(DWC3_EP_STALL | DWC3_EP_WEDGE);
> -		if (dwc->delayed_status)
> +		if (dwc->clear_stall_protocol)
>  			dwc3_ep0_send_delayed_status(dwc);
>  	}
>  

Is it safe to maintain clear_stall_protocol per dwc3 instance? What if
CLEAR_FEATURE(halt_endpoint) and usb_ep_clear_halt() are interleaved and
We come here as part of usb_ep_clear_halt()'s endpoint command complete.
We may simply send the delayed status corresponding to the protocol clear
stall.

We can still maintain a global flag if we cache endpoint number in it so
that we can cross check against the endpoint for which completion received.

Thanks,
Pavan

