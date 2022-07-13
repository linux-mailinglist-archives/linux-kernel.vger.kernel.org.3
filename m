Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61C3573F32
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 23:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbiGMVxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 17:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237287AbiGMVxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 17:53:47 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F4E1209D;
        Wed, 13 Jul 2022 14:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657749226; x=1689285226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jpAc4UmL+hbbIRayobXbAS07B1tTi/T+zKwuYIkv7LM=;
  b=Rkdtqs0KXncbvz37eiUwBKnTjAYRV3lhYhms3e5riw1spl1EKTVGLfpJ
   NgPj+f8bJUtPeFnG90a567Lsj6tOA2EcEqq0nvbgL1yh8b61MZ4MXfIf7
   a6h3lvCRV9oUgdn95bMzHZrfSEEAtU0ieopOweiDhwF9F0oSDsiIqxfOA
   c=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 Jul 2022 14:53:45 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 14:53:45 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Jul 2022 14:53:45 -0700
Received: from jackp-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Jul 2022 14:53:44 -0700
Date:   Wed, 13 Jul 2022 14:53:43 -0700
From:   Jack Pham <quic_jackp@quicinc.com>
To:     John Keeping <john@metanate.com>
CC:     Wesley Cheng <quic_wcheng@quicinc.com>, <balbi@kernel.org>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH v2 5/5] usb: dwc3: gadget: Increase DWC3 controller halt
 timeout
Message-ID: <20220713215342.GD8200@jackp-linux.qualcomm.com>
References: <20220713003523.29309-1-quic_wcheng@quicinc.com>
 <20220713003523.29309-6-quic_wcheng@quicinc.com>
 <20220713025643.GC8200@jackp-linux.qualcomm.com>
 <Ys6vReAwrYbEavob@donbot>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Ys6vReAwrYbEavob@donbot>
User-Agent: Mutt/1.9.4 (2018-02-28)
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

On Wed, Jul 13, 2022 at 12:40:53PM +0100, John Keeping wrote:
> On Tue, Jul 12, 2022 at 07:56:43PM -0700, Jack Pham wrote:
> > Hi Wesley,
> > 
> > On Tue, Jul 12, 2022 at 05:35:23PM -0700, Wesley Cheng wrote:
> > > Since EP0 transactions need to be completed before the controller halt
> > > sequence is finished, this may take some time depending on the host and the
> > > enabled functions.  Increase the controller halt timeout, so that we give
> > > the controller sufficient time to handle EP0 transfers.
> > > 
> > > Fixes: 861c010a2ee1 ("usb: dwc3: gadget: Refactor pullup()")
> > > Suggested-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> > > Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> > > ---
> > > Link:
> > >   https://lore.kernel.org/linux-usb/4988ed34-04a4-060a-ccef-f57790f76a2b@synopsys.com/
> > > 
> > >  drivers/usb/dwc3/gadget.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> > > index 41b7007358de..e32d7293c447 100644
> > > --- a/drivers/usb/dwc3/gadget.c
> > > +++ b/drivers/usb/dwc3/gadget.c
> > > @@ -2476,6 +2476,7 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
> > >  	dwc3_gadget_dctl_write_safe(dwc, reg);
> > >  
> > >  	do {
> > > +		msleep(1);
> > 
> > Be aware that this probably won't sleep for *just* 1ms.  From
> > Documentation/timers/timers-howto.rst:
> > 
> > 	msleep(1~20) may not do what the caller intends, and
> > 	will often sleep longer (~20 ms actual sleep for any
> > 	value given in the 1~20ms range). In many cases this
> > 	is not the desired behavior.
> > 
> > So with timeout==500 this loop could very well end up iterating for up
> > to 10 seconds.  Granted this shouldn't be called from any atomic context
> > but just wanted to make sure that the effective increase in timeout as
> > $SUBJECT intends is made clear here and that it's not overly generous.
> > 
> > >  		reg = dwc3_readl(dwc->regs, DWC3_DSTS);
> > >  		reg &= DWC3_DSTS_DEVCTRLHLT;
> > >  	} while (--timeout && !(!is_on ^ !reg));
> 
> Does it make sense to convert this loop to use read_poll_timeout() and
> make the timeout explicit, something like:
> 
> 	ret = read_poll_timeout(dwc3_readl, reg, !(!is_on ^ !(reg & DWC3_DSTS_DEVCTRLHLT)),
> 				100, timeout * USEC_PER_MSEC, true, dwc->regs, DWC3_DSTS);
> 
> ?

Yeah I think it would make sense.  Might even be worthwhile to revisit
similar loops being performed in dwc3_send_gadget_generic_command() and
dwc3_send_gadget_ep_cmd() which are currently spinning delay-lessly for a
fixed number of iterations.

Jack
