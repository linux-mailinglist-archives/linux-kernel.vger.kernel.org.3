Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300DC4E45E0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240250AbiCVSWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbiCVSWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:22:49 -0400
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 8BF9B8A6CE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 11:21:20 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1647973280; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: From: From: References: Cc: To: To: Subject: Subject:
 MIME-Version: Date: Message-ID: Sender: Sender;
 bh=sEvq6f8Dlb0RhdG0uADYTZ1NJ0F/U8AnOMfkzmpDdFo=; b=PDPUNtqx/X+lKT34MAShAI9oNKv9i4OeZGwpJ1eougRkrV5vC/jTfetrCrySDrG9RK3SpTBK
 63SaUNDbuYAdGyMpUh1ZANwGBpVvfl/gNe9GH9juyRoCkMvhp+Cam2D18rrg7F4PN9Q7OhTy
 1oRnomhlOUIQQfqu1kN693/Gg/s=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 623a139eeaaf7770b71219f5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Mar 2022 18:21:18
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BBA88C43617; Tue, 22 Mar 2022 18:21:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Received: from [10.71.112.238] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0069DC4338F;
        Tue, 22 Mar 2022 18:21:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 0069DC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Message-ID: <eeee97bf-2987-3cfb-217e-42615d8d864b@codeaurora.org>
Date:   Tue, 22 Mar 2022 11:21:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [RFC PATCH v2 1/3] usb: dwc3: Flush pending SETUP data during
 stop active xfers
Content-Language: en-US
To:     Wesley Cheng <quic_wcheng@quicinc.com>, balbi@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_jackp@quicinc.com, Thinh.Nguyen@synopsys.com
References: <20220216000835.25400-1-quic_wcheng@quicinc.com>
 <20220216000835.25400-2-quic_wcheng@quicinc.com>
From:   Wesley Cheng <wcheng@codeaurora.org>
In-Reply-To: <20220216000835.25400-2-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

On 2/15/2022 4:08 PM, Wesley Cheng wrote:
> While running the pullup disable sequence, if there are pending SETUP
> transfers stored in the controller, then the ENDTRANSFER commands on non
> control eps will fail w/ ETIMEDOUT.  As a suggestion from SNPS, in order
> to drain potentially cached SETUP packets, SW needs to issue a
> STARTTRANSFER command.  After issuing the STARTTRANSFER, and retrying the
> ENDTRANSFER, the command should succeed.  Else, if the endpoints are not
> properly stopped, the controller halt sequence will fail as well.
> 
> One limitation is that the current logic will drop the SETUP data
> being received (ie dropping the SETUP packet), however, it should be
> acceptable in the pullup disable case, as the device is eventually
> going to disconnect from the host.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
Just wondering if you had any inputs for this particular change?  I
think on the dequeue path discussion you had some concerns with parts of
this change?  I think the difficult part for the pullup disable path is
that we have this API running w/ interrupts disabled, so the EP0 state
won't be able to advance compared to the dequeue case.

Ideally, if there is a way to ensure that we avoid reading further setup
packets, that would be nice, but from our discussions with Synopsys,
this was not possible. (controller is always armed and ready to ACK
setup tokens)

I did evaluate keeping IRQs enabled and periodically releasing/attaining
the lock between the stop active xfer calls, but that opened another can
of worms.  If you think this is the approach we should take, I can take
a look at this implementation further.

Thanks
Wesley Cheng

>  drivers/usb/dwc3/core.h   |  7 +++++++
>  drivers/usb/dwc3/ep0.c    | 20 +++++++++++--------
>  drivers/usb/dwc3/gadget.c | 42 ++++++++++++++++++++++++++++++++++-----
>  3 files changed, 56 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index eb9c1efced05..a411682e7f44 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -1551,6 +1551,8 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
>  int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned int cmd,
>  		u32 param);
>  void dwc3_gadget_clear_tx_fifos(struct dwc3 *dwc);
> +void dwc3_ep0_stall_and_restart(struct dwc3 *dwc);
> +void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep);
>  #else
>  static inline int dwc3_gadget_init(struct dwc3 *dwc)
>  { return 0; }
> @@ -1572,6 +1574,11 @@ static inline int dwc3_send_gadget_generic_command(struct dwc3 *dwc,
>  { return 0; }
>  static inline void dwc3_gadget_clear_tx_fifos(struct dwc3 *dwc)
>  { }
> +static inline void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
> +{ }
> +static inline void dwc3_ep0_end_control_data(struct dwc3 *dwc,
> +					     struct dwc3_ep *dep)
> +{ }
>  #endif
>  
>  #if IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
> index 658739410992..a2cc94c25dcf 100644
> --- a/drivers/usb/dwc3/ep0.c
> +++ b/drivers/usb/dwc3/ep0.c
> @@ -197,7 +197,7 @@ int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
>  	int				ret;
>  
>  	spin_lock_irqsave(&dwc->lock, flags);
> -	if (!dep->endpoint.desc || !dwc->pullups_connected) {
> +	if (!dep->endpoint.desc || !dwc->pullups_connected || !dwc->connected) {
>  		dev_err(dwc->dev, "%s: can't queue to disabled endpoint\n",
>  				dep->name);
>  		ret = -ESHUTDOWN;
> @@ -218,19 +218,21 @@ int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
>  	return ret;
>  }
>  
> -static void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
> +void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
>  {
>  	struct dwc3_ep		*dep;
>  
>  	/* reinitialize physical ep1 */
>  	dep = dwc->eps[1];
>  	dep->flags = DWC3_EP_ENABLED;
> +	dep->trb_enqueue = 0;
>  
>  	/* stall is always issued on EP0 */
>  	dep = dwc->eps[0];
>  	__dwc3_gadget_ep_set_halt(dep, 1, false);
>  	dep->flags = DWC3_EP_ENABLED;
>  	dwc->delayed_status = false;
> +	dep->trb_enqueue = 0;
>  
>  	if (!list_empty(&dep->pending_list)) {
>  		struct dwc3_request	*req;
> @@ -240,7 +242,9 @@ static void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
>  	}
>  
>  	dwc->ep0state = EP0_SETUP_PHASE;
> -	dwc3_ep0_out_start(dwc);
> +	complete(&dwc->ep0_in_setup);
> +	if (dwc->softconnect)
> +		dwc3_ep0_out_start(dwc);
>  }
>  
>  int __dwc3_gadget_ep0_set_halt(struct usb_ep *ep, int value)
> @@ -272,8 +276,6 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
>  	struct dwc3_ep			*dep;
>  	int				ret;
>  
> -	complete(&dwc->ep0_in_setup);
> -
>  	dep = dwc->eps[0];
>  	dwc3_ep0_prepare_one_trb(dep, dwc->ep0_trb_addr, 8,
>  			DWC3_TRBCTL_CONTROL_SETUP, false);
> @@ -922,7 +924,9 @@ static void dwc3_ep0_complete_status(struct dwc3 *dwc,
>  		dwc->setup_packet_pending = true;
>  
>  	dwc->ep0state = EP0_SETUP_PHASE;
> -	dwc3_ep0_out_start(dwc);
> +	complete(&dwc->ep0_in_setup);
> +	if (dwc->softconnect)
> +		dwc3_ep0_out_start(dwc);
>  }
>  
>  static void dwc3_ep0_xfer_complete(struct dwc3 *dwc,
> @@ -1073,7 +1077,7 @@ void dwc3_ep0_send_delayed_status(struct dwc3 *dwc)
>  	__dwc3_ep0_do_control_status(dwc, dwc->eps[direction]);
>  }
>  
> -static void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep)
> +void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep)
>  {
>  	struct dwc3_gadget_ep_cmd_params params;
>  	u32			cmd;
> @@ -1083,7 +1087,7 @@ static void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep)
>  		return;
>  
>  	cmd = DWC3_DEPCMD_ENDTRANSFER;
> -	cmd |= DWC3_DEPCMD_CMDIOC;
> +	cmd |= dwc->connected ? DWC3_DEPCMD_CMDIOC : DWC3_DEPCMD_HIPRI_FORCERM;
>  	cmd |= DWC3_DEPCMD_PARAM(dep->resource_index);
>  	memset(&params, 0, sizeof(params));
>  	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 183b90923f51..f6801199440c 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -885,12 +885,13 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
>  		reg |= DWC3_DALEPENA_EP(dep->number);
>  		dwc3_writel(dwc->regs, DWC3_DALEPENA, reg);
>  
> -		if (usb_endpoint_xfer_control(desc))
> -			goto out;
> -
>  		/* Initialize the TRB ring */
>  		dep->trb_dequeue = 0;
>  		dep->trb_enqueue = 0;
> +
> +		if (usb_endpoint_xfer_control(desc))
> +			goto out;
> +
>  		memset(dep->trb_pool, 0,
>  		       sizeof(struct dwc3_trb) * DWC3_TRB_NUM);
>  
> @@ -2476,7 +2477,8 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>  	 * Per databook, when we want to stop the gadget, if a control transfer
>  	 * is still in process, complete it and get the core into setup phase.
>  	 */
> -	if (!is_on && dwc->ep0state != EP0_SETUP_PHASE) {
> +	if ((!is_on && (dwc->ep0state != EP0_SETUP_PHASE ||
> +	     dwc->ep0_next_event != DWC3_EP0_COMPLETE))) {
>  		reinit_completion(&dwc->ep0_in_setup);
>  
>  		ret = wait_for_completion_timeout(&dwc->ep0_in_setup,
> @@ -2519,6 +2521,17 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>  		u32 count;
>  
>  		dwc->connected = false;
> +
> +		/*
> +		 * Ensure no pending data/setup stages, and disable ep0 to
> +		 * block further EP0 transactions before stopping pending
> +		 * transfers.
> +		 */
> +		dwc3_ep0_end_control_data(dwc, dwc->eps[1]);
> +		dwc3_ep0_stall_and_restart(dwc);
> +		__dwc3_gadget_ep_disable(dwc->eps[0]);
> +		__dwc3_gadget_ep_disable(dwc->eps[1]);
> +
>  		/*
>  		 * In the Synopsis DesignWare Cores USB3 Databook Rev. 3.30a
>  		 * Section 4.1.8 Table 4-7, it states that for a device-initiated
> @@ -3600,8 +3613,10 @@ static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
>  	bool interrupt)
>  {
>  	struct dwc3_gadget_ep_cmd_params params;
> +	struct dwc3 *dwc = dep->dwc;
>  	u32 cmd;
>  	int ret;
> +	int retries = 1;
>  
>  	if (!(dep->flags & DWC3_EP_TRANSFER_STARTED) ||
>  	    (dep->flags & DWC3_EP_END_TRANSFER_PENDING))
> @@ -3633,7 +3648,7 @@ static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
>  	 *
>  	 * This mode is NOT available on the DWC_usb31 IP.
>  	 */
> -
> +retry:
>  	cmd = DWC3_DEPCMD_ENDTRANSFER;
>  	cmd |= force ? DWC3_DEPCMD_HIPRI_FORCERM : 0;
>  	cmd |= interrupt ? DWC3_DEPCMD_CMDIOC : 0;
> @@ -3641,6 +3656,23 @@ static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
>  	memset(&params, 0, sizeof(params));
>  	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
>  	WARN_ON_ONCE(ret);
> +	if (ret == -ETIMEDOUT) {
> +		if (!dwc->connected) {
> +			/*
> +			 * While the controller is in an active setup/control
> +			 * transfer, the HW is unable to service other eps
> +			 * potentially leading to an endxfer command timeout.
> +			 * It was recommended to ensure that there are no
> +			 * pending/cached setup packets stored in internal
> +			 * memory.  Only way to achieve this is to issue another
> +			 * start transfer, and retry.
> +			 */
> +			if (retries--) {
> +				dwc3_ep0_out_start(dwc);
> +				goto retry;
> +			}
> +		}
> +	}
>  	dep->resource_index = 0;
>  
>  	if (!interrupt)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
