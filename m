Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B504B1F81
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 08:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347788AbiBKHnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 02:43:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243198AbiBKHnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 02:43:40 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76AF250;
        Thu, 10 Feb 2022 23:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644565420; x=1676101420;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DSnJteDARUlrsjbSpn5agFSV825dv8HSaJ68vz1hIpc=;
  b=H/kHE4NQ5ikn8hoUayiwE1jok+YDuiRe2eheyDvZcR4yN+/zmVjV/C1W
   aabWB1wGOnY7aSlbcpt7431TJ5ewYUMYO1BCayTi5N+qdzc2igKF2OV5z
   FRQMdN+30VsGAAwz+TF/I+JqaD7pbuoyhcxGcYE1BeSMxsrfl19w/Z1OB
   U=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 10 Feb 2022 23:43:39 -0800
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 23:43:39 -0800
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 10 Feb 2022 23:43:35 -0800
Date:   Fri, 11 Feb 2022 13:13:31 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Jung Daehwan <dh10.jung@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ugoswami@quicinc.com>
Subject: Re: usb: host: Reduce xhci_handshake timeout in xhci_reset
Message-ID: <20220211074331.GA12625@hu-pkondeti-hyd.qualcomm.com>
References: <CGME20210622113915epcas2p284c61291fc9d83487f6dfebb65fd4e9b@epcas2p2.samsung.com>
 <1624361096-41282-1-git-send-email-dh10.jung@samsung.com>
 <YNJAZDwuFmEoTJHe@kroah.com>
 <20210628022548.GA69289@ubuntu>
 <YNlxzj7KXG43Uyrp@kroah.com>
 <20210628065553.GA83203@ubuntu>
 <496c9d86-70d7-1050-5bbb-9f841e4b464a@intel.com>
 <20220211064630.GA20567@hu-pkondeti-hyd.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220211064630.GA20567@hu-pkondeti-hyd.qualcomm.com>
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

Sorry for the spam. I have added an incorrect email address in my previous
email.

On Fri, Feb 11, 2022 at 12:16:30PM +0530, Pavan Kondeti wrote:
> On Mon, Jun 28, 2021 at 10:49:00AM +0300, Mathias Nyman wrote:
> > On 28.6.2021 9.55, Jung Daehwan wrote:
> > > On Mon, Jun 28, 2021 at 08:53:02AM +0200, Greg Kroah-Hartman wrote:
> > >> On Mon, Jun 28, 2021 at 11:25:48AM +0900, Jung Daehwan wrote:
> > >>> On Tue, Jun 22, 2021 at 09:56:20PM +0200, Greg Kroah-Hartman wrote:
> > >>>> On Tue, Jun 22, 2021 at 08:24:56PM +0900, Daehwan Jung wrote:
> > >>>>> It seems 10 secs timeout is too long in general case. A core would wait for
> > >>>>> 10 secs without doing other task and it can be happended on every device.
> > >>>>
> > >>>> Only if the handshake does not come back sooner, right?
> > >>>
> > >>> Yes, right.
> > >>>
> > >>>> What is causing your device to timeout here?
> > >>>
> > >>> Host Controller doesn't respond handshake. I don't know why and I ask HW team
> > >>> to debug it.
> > >>
> > >> Please work to fix your hardware, that feels like the root of the
> > >> problem here.  If you require the timeout for xhci_reset() to happen,
> > >> then how do you know that the hardware really did reset properly in the
> > >> reduced amount of time you just provided?
> > >>
> > > 
> > > I continue fixing this issue with hardware engineer, but currently just
> > > host controller can crash whole system and that's why I want to fix it.
> > > How about adding some error logs in this situation for recognizing this issue?
> > > We can add error log in xhci_stop as xhci_reset can returns error like below.
> > > 
> > > static void xhci_stop(struct usb_hcd *hcd)
> > > {
> > >         u32 temp;
> > >         struct xhci_hcd *xhci = hcd_to_xhci(hcd);
> > > +       int ret;
> > > 
> > >         mutex_lock(&xhci->mutex);
> > > 
> > > @@ -733,6 +734,9 @@ static void xhci_stop(struct usb_hcd *hcd)
> > >         xhci->cmd_ring_state = CMD_RING_STATE_STOPPED;
> > >         xhci_halt(xhci);
> > >         xhci_reset(xhci);
> > > +       if (ret)
> > > +               xhci_err(xhci, "%s: Error while reset xhci Host controller - ret = %d\n"
> > > +                       , __func__, ret);
> > >         spin_unlock_irq(&xhci->lock);
> > > 
> > 
> > We can check the xhci_reset() return value here and print a message, makes sense.
> > 
> > The original reason for the 10 second timeout was because a host actually took 9 seconds:
> > 
> > commit 22ceac191211cf6688b1bf6ecd93c8b6bf80ed9b
> > 
> >     xhci: Increase reset timeout for Renesas 720201 host.
> >     
> >     The NEC/Renesas 720201 xHCI host controller does not complete its reset
> >     within 250 milliseconds.  In fact, it takes about 9 seconds to reset the
> >     host controller, and 1 second for the host to be ready for doorbell
> >     rings.  Extend the reset and CNR polling timeout to 10 seconds each.
> > 
> Agreed.
> 
> We also run into the similar issue (very very rarely reproduced) on
> our platforms like SM8450. The issue happens when host mode is de-activated
> (type-c cable disconnected). Since xhci_reset() is called with interrupts
> disabled, a timeout of 10 seconds is fatal to the system.
> 
> Thanks,
> Pavan
