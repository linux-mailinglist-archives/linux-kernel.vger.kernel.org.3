Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A3C523A54
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344757AbiEKQa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344739AbiEKQa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:30:27 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FFD239791;
        Wed, 11 May 2022 09:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652286626; x=1683822626;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3BYud7KzGxtozDFkxX5v92J711Txm5XkUlRweztzyfc=;
  b=SLU9W3e6VFL7d03O0vzbHILjGmj/ayeP2cVs0WpuArrRTB68ce2hsq+Y
   GADFaloqzcV/WLUjqWl/t7Fqh9lgflI/x3fP+rgrlaHEOL48kAUpSwPCJ
   KFaB+L/t/svI10K8jJWHV3UmTSF/xAuWTKDUdBPmR+Ar05zkKZc2MwgZb
   I=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 11 May 2022 09:30:25 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 09:30:24 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 09:30:24 -0700
Received: from jackp-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 09:30:24 -0700
Date:   Wed, 11 May 2022 09:30:19 -0700
From:   Jack Pham <quic_jackp@quicinc.com>
To:     Albert Wang <albertccwang@google.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     <balbi@kernel.org>, <badhri@google.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: gadget: Fix null pointer dereference
Message-ID: <20220511162957.GA5637@jackp-linux.qualcomm.com>
References: <20220504072802.83487-1-albertccwang@google.com>
 <YnKPI4O7JloBqi0F@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YnKPI4O7JloBqi0F@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 04:35:15PM +0200, Greg KH wrote:
> On Wed, May 04, 2022 at 03:28:02PM +0800, Albert Wang wrote:
> > There are still race conditions to hit the null pointer deference
> > with my previous commit. So I re-write the code to dereference the
> > pointer right after checking it is not null.
> 
> What race conditions?
> 
> And just moving it is not going to solve a race condition, you need a
> lock.

Hmm dwc->lock should already be held when entering this function.

 dwc3_thread_interrupt()
   spin_lock(&dwc->lock);
   -> dwc3_process_event_buf()
     -> dwc3_process_event_entry()
       -> dwc3_endpoint_interrupt()
         -> dwc3_gadget_endpoint_transfer_complete()
           -> dwc3_gadget_endpoint_trbs_complete() [this function]

> > Fixes: 26288448120b ("usb: dwc3: gadget: Fix null pointer exception")
> > 
> > Signed-off-by: Albert Wang <albertccwang@google.com>
> > ---
> >  drivers/usb/dwc3/gadget.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> > index 19477f4bbf54..f2792968afd9 100644
> > --- a/drivers/usb/dwc3/gadget.c
> > +++ b/drivers/usb/dwc3/gadget.c
> > @@ -3366,15 +3366,14 @@ static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
> >  	struct dwc3		*dwc = dep->dwc;
> >  	bool			no_started_trb = true;
> >  
> > -	if (!dep->endpoint.desc)
> > -		return no_started_trb;
> > -
> >  	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);

Ok I see, this function eventually leads to dwc3_giveback() getting
called, which unlocks dwc->lock before calling each requests' callbacks
and reacquires it afterwards.

This gives an opportunity for usb_ep_disable() to come in and clear
the descriptor.

You should add an inline comment to make that clear that's what's
happening here.

> >  	if (dep->flags & DWC3_EP_END_TRANSFER_PENDING)
> >  		goto out;
> >  
> > -	if (usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
> > +	if (!dep->endpoint.desc)
> > +		return no_started_trb;
> > +	else if (usb_endpoint_xfer_isoc(dep->endpoint.desc) &&

Drop the 'else', it isn't needed due to the return in the preceding
check.

> There is no locking here, so why would this change do anything but
> reduce the window?

After inspecting further, we do see locking is implicit, with the main
gotcha being the unlock/re-lock that happens behind the scenes, which
actually creates a window for the race to happen.  This change moves the
NULL check to be adjacent to where it's used, and more importantly after
the window is "closed" (since we now have the lock again).

Additional comments and more descriptive commit text should help make
this more clear.

Thanks,
Jack
