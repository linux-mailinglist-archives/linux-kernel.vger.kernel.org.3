Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087D746769C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 12:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351996AbhLCLkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 06:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352060AbhLCLkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:40:01 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DD7C06173E;
        Fri,  3 Dec 2021 03:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=wrITMsMrz81bDyoY65BKf7E82FBRMEYRt2oU9qm4hZA=; b=Wk1pr
        +KxKsgfhCcuu9nu1CA90lTl3bj/VAtm5Jrtz8o4qJnHBD2W8WaKJ++JnCa8La0fSxyFS3S4B8gF82
        8ReUphPu+lb3G3Yn9Ld9SfbtEESeEDP0+gl6gnRYPk/y6QK5gtX/MuZCivqhDbL6abDC9e9G4HvJI
        m8qJjtRJaXS42nybeVF7wl9tshXAB4FBnCOBIoGLocOa88bknhRAf06PFYPT/8EcXS6Eykd9ZHzf0
        mnDTJHKmFa6sax+hCAlMVhYrzNG0vrCuOzfHhFyltUTyQCzJlFJPpylh4xniIQjg+lns/clm65sH6
        fYA73wghv2S9x7dya38BWjrBSf8gw==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mt6rj-0002VS-Gs; Fri, 03 Dec 2021 11:36:35 +0000
Date:   Fri, 3 Dec 2021 11:36:34 +0000
From:   John Keeping <john@metanate.com>
To:     Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Argishti Aleksanyan <argishti.aleksanyan@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc2: gadget: initialize max_speed from params
Message-ID: <YaoBQvSeY0RhFgRP@donbot>
References: <20211202171748.3035874-1-john@metanate.com>
 <a2ce248f-79d9-f9a3-f184-e033409fe2b8@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2ce248f-79d9-f9a3-f184-e033409fe2b8@synopsys.com>
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minas,

On Fri, Dec 03, 2021 at 05:49:36AM +0000, Minas Harutyunyan wrote:
> On 12/2/2021 9:17 PM, John Keeping wrote:
> > DWC2 may be paired with a full-speed PHY which is not capable of
> > high-speed operation.  Report this correctly to the gadget core by
> > setting max_speed from the core parameters.
> > 
> > Prior to commit 5324bad66f09f ("usb: dwc2: gadget: implement
> > udc_set_speed()") this didn't cause the hardware to be configured
> > incorrectly, although the speed may have been reported incorrectly.  But
> > after that commit params.speed is updated based on a value passed in by
> > the gadget core which may set it to a faster speed than is supported by
> > the hardware.  Initialising the max_speed parameter ensures the speed
> > passed to dwc2_gadget_set_speed() will be one supported by the hardware.
> > 
> > Fixes: 5324bad66f09f ("usb: dwc2: gadget: implement udc_set_speed()")
> > Signed-off-by: John Keeping <john@metanate.com>
> > ---
> >   drivers/usb/dwc2/gadget.c | 13 ++++++++++++-
> >   1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
> > index b884a83b26a6e..2bc03f41c70ad 100644
> > --- a/drivers/usb/dwc2/gadget.c
> > +++ b/drivers/usb/dwc2/gadget.c
> > @@ -4974,7 +4974,18 @@ int dwc2_gadget_init(struct dwc2_hsotg *hsotg)
> >   		hsotg->params.g_np_tx_fifo_size);
> >   	dev_dbg(dev, "RXFIFO size: %d\n", hsotg->params.g_rx_fifo_size);
> >   
> > -	hsotg->gadget.max_speed = USB_SPEED_HIGH;
> > +	switch (hsotg->params.speed) {
> > +	case DWC2_SPEED_PARAM_LOW:
> > +		hsotg->gadget.max_speed = USB_SPEED_LOW;
> > +		break;
> > +	case DWC2_SPEED_PARAM_FULL:
> > +		hsotg->gadget.max_speed = USB_SPEED_FULL;
> > +		break;
> > +	default:
> > +		hsotg->gadget.max_speed = USB_SPEED_HIGH;
> > +		break;
> > +	}
> > +
> >   	hsotg->gadget.ops = &dwc2_hsotg_gadget_ops;
> >   	hsotg->gadget.name = dev_name(dev);
> >   	hsotg->gadget.otg_caps = &hsotg->params.otg_caps;
> > 
> 
> Just setting gadget's max_speed doesn't resolve described issue. After 
> setting gadget's max_speed in your patch, it doesn't used in driver at 
> all. Per me, you need also fix dwc2_gadget_set_speed() function by 
> checking requested speed with max_speed: if requested speed higher than 
> max_speed then set speed to max_speed.

Setting the max_speed here restricts what the gadget core will pass in
to the .udc_set_speed hook, see usb_gadget_udc_set_speed():

	s = min(speed, udc->gadget->max_speed);
	udc->gadget->ops->udc_set_speed(udc->gadget, s);

We can't add a check in dwc2_gadget_set_speed() because the original
capability may have been lost, for example if a high-speed capable
device is configured for full-speed operation then hsotg->params.speed
is set to full-speed and there's nothing that says the device is capable
of high-speed when setting the speed back again.

I believe this patch is sufficient because of the guarantees by the
gadget core that we will never be called with a speed that is faster
than we support.


Regards,
John
