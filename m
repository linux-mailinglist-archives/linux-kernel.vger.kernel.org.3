Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931CF5760C7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 13:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiGOLpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 07:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiGOLpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 07:45:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210D76A9EB;
        Fri, 15 Jul 2022 04:45:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1CBE622FA;
        Fri, 15 Jul 2022 11:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A5CC3411E;
        Fri, 15 Jul 2022 11:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657885514;
        bh=/+65uXj1d7wLF6R2bhq2x02kgR5AGcMhGNsdTYW80lA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2BF3POxP91QePnwQPPLykOxL4q/kB157rCWU5RjKAYkWQlGLBLvNGwSHoFXOWdnaH
         9hp8ImIfTAXCGK0L40HJuWBNq5tSZtQ5Ex5gExjQ6ECtejL1y2FDwX7EHUBWacw7bR
         3di5M8v1vvorzUhUlw1EzdhzdI341BY/msEbyhfg=
Date:   Fri, 15 Jul 2022 13:45:11 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v2 3/5] usb: dwc3: gadget: Adjust IRQ management during
 soft disconnect/connect
Message-ID: <YtFTRyTPxM4M3+7j@kroah.com>
References: <20220713003523.29309-1-quic_wcheng@quicinc.com>
 <20220713003523.29309-4-quic_wcheng@quicinc.com>
 <fbfc9328-418c-4c5e-4553-993331b20cb6@synopsys.com>
 <03434e9c-7a1c-4819-6bfe-54f56401348c@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03434e9c-7a1c-4819-6bfe-54f56401348c@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 10:41:01AM -0700, Wesley Cheng wrote:
> Hi Thinh,
> 
> On 7/14/2022 10:38 AM, Thinh Nguyen wrote:
> > On 7/12/2022, Wesley Cheng wrote:
> > > Local interrupts are currently being disabled as part of aquiring the
> > > spin lock before issuing the endxfer command.  Leave interrupts enabled, so
> > > that EP0 events can continue to be processed.  Also, ensure that there are
> > > no pending interrupts before attempting to handle any soft
> > > connect/disconnect.
> > > 
> > > Fixes: 861c010a2ee1 ("usb: dwc3: gadget: Refactor pullup()")
> > > Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> > > ---
> > >    drivers/usb/dwc3/gadget.c | 21 ++++++++++++---------
> > >    1 file changed, 12 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> > > index a455f8d4631d..ee85b773e3fe 100644
> > > --- a/drivers/usb/dwc3/gadget.c
> > > +++ b/drivers/usb/dwc3/gadget.c
> > > @@ -1674,6 +1674,7 @@ static int __dwc3_gadget_get_frame(struct dwc3 *dwc)
> > >    static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool interrupt)
> > >    {
> > >    	struct dwc3_gadget_ep_cmd_params params;
> > > +	struct dwc3 *dwc = dep->dwc;
> > >    	u32 cmd;
> > >    	int ret;
> > > @@ -1682,7 +1683,9 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
> > >    	cmd |= interrupt ? DWC3_DEPCMD_CMDIOC : 0;
> > >    	cmd |= DWC3_DEPCMD_PARAM(dep->resource_index);
> > >    	memset(&params, 0, sizeof(params));
> > > +	spin_unlock(&dwc->lock);
> > >    	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
> > > +	spin_lock(&dwc->lock);
> > >    	WARN_ON_ONCE(ret);
> > >    	dep->resource_index = 0;
> > > @@ -2029,12 +2032,11 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
> > >    	struct dwc3_ep			*dep = to_dwc3_ep(ep);
> > >    	struct dwc3			*dwc = dep->dwc;
> > > -	unsigned long			flags;
> > >    	int				ret = 0;
> > >    	trace_dwc3_ep_dequeue(req);
> > > -	spin_lock_irqsave(&dwc->lock, flags);
> > > +	spin_lock(&dwc->lock);
> > >    	list_for_each_entry(r, &dep->cancelled_list, list) {
> > >    		if (r == req)
> > > @@ -2073,7 +2075,7 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
> > >    		request, ep->name);
> > >    	ret = -EINVAL;
> > >    out:
> > > -	spin_unlock_irqrestore(&dwc->lock, flags);
> > > +	spin_unlock(&dwc->lock);
> > >    	return ret;
> > >    }
> > > @@ -2489,9 +2491,7 @@ static int __dwc3_gadget_start(struct dwc3 *dwc);
> > >    static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
> > >    {
> > > -	unsigned long flags;
> > > -
> > > -	spin_lock_irqsave(&dwc->lock, flags);
> > > +	spin_lock(&dwc->lock);
> > >    	dwc->connected = false;
> > >    	/*
> > > @@ -2506,10 +2506,10 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
> > >    		reinit_completion(&dwc->ep0_in_setup);
> > > -		spin_unlock_irqrestore(&dwc->lock, flags);
> > > +		spin_unlock(&dwc->lock);
> > >    		ret = wait_for_completion_timeout(&dwc->ep0_in_setup,
> > >    				msecs_to_jiffies(DWC3_PULL_UP_TIMEOUT));
> > > -		spin_lock_irqsave(&dwc->lock, flags);
> > > +		spin_lock(&dwc->lock);
> > >    		if (ret == 0)
> > >    			dev_warn(dwc->dev, "timed out waiting for SETUP phase\n");
> > >    	}
> > > @@ -2523,7 +2523,7 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
> > >    	 */
> > >    	dwc3_stop_active_transfers(dwc);
> > >    	__dwc3_gadget_stop(dwc);
> > > -	spin_unlock_irqrestore(&dwc->lock, flags);
> > > +	spin_unlock(&dwc->lock);
> > >    	/*
> > >    	 * Note: if the GEVNTCOUNT indicates events in the event buffer, the
> > > @@ -2569,6 +2569,8 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
> > >    		return 0;
> > >    	}
> > > +	synchronize_irq(dwc->irq_gadget);
> > > +
> > >    	if (!is_on) {
> > >    		ret = dwc3_gadget_soft_disconnect(dwc);
> > >    	} else {
> > > @@ -3729,6 +3731,7 @@ void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
> > >    	 */
> > >    	__dwc3_stop_active_transfer(dep, force, interrupt);
> > > +
> > >    }
> > >    static void dwc3_clear_stall_all_ep(struct dwc3 *dwc)
> > 
> > Hi Greg,
> > 
> > Please don't pick up this patch yet. We're still in discussion with
> > this. I have some concern with unlocking/locking when sending End
> > Transfer command. For example, this patch may cause issues with
> > DWC3_EP_END_TRANSFER_PENDING checks.
> > 
> 
> Agreed.
> 
> > Hi Wesley,
> > 
> > Did you try out my suggestion yet?
> > 
> 
> In process of testing.  Will update you in a few days, since it might take a
> day or so to reproduce.

Ok, I'll drop this whole series from my tree for now.  Please resend
when you have it working.

greg k-h
