Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E39490C29
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240940AbiAQQKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:10:15 -0500
Received: from netrider.rowland.org ([192.131.102.5]:51253 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S240864AbiAQQKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:10:03 -0500
Received: (qmail 40593 invoked by uid 1000); 17 Jan 2022 11:10:02 -0500
Date:   Mon, 17 Jan 2022 11:10:02 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     gregkh@linuxfoundation.org, mathias.nyman@linux.intel.com,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Bixuan Cui <cuibixuan@huawei.com>,
        Rajat Jain <rajatja@google.com>, Andrew Lunn <andrew@lunn.ch>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb: core: Bail out when port is stuck in reset loop
Message-ID: <YeWU2ido11JzbDe6@rowland.harvard.edu>
References: <20211230052811.650191-1-kai.heng.feng@canonical.com>
 <CAAd53p6ev+yQT+jf32UrTMWQXwDPYtmZSrW0zCQnKuUaBbtXUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p6ev+yQT+jf32UrTMWQXwDPYtmZSrW0zCQnKuUaBbtXUg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 11:00:05AM +0800, Kai-Heng Feng wrote:
> On Thu, Dec 30, 2021 at 1:28 PM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > Unplugging USB device may cause an incorrect warm reset loop and the
> > port can no longer be used:
> > [  143.039019] xhci_hcd 0000:00:14.0: Port change event, 2-3, id 19, portsc: 0x4202c0
> > [  143.039025] xhci_hcd 0000:00:14.0: handle_port_status: starting usb2 port polling.
> > [  143.039051] hub 2-0:1.0: state 7 ports 10 chg 0000 evt 0008
> > [  143.039058] xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x4202c0, return 0x4102c0
> > [  143.039092] xhci_hcd 0000:00:14.0: clear port3 connect change, portsc: 0x4002c0
> > [  143.039096] usb usb2-port3: link state change
> > [  143.039099] xhci_hcd 0000:00:14.0: clear port3 link state change, portsc: 0x2c0
> > [  143.039101] usb usb2-port3: do warm reset
> > [  143.096736] xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x2b0, return 0x2b0
> > [  143.096751] usb usb2-port3: not warm reset yet, waiting 50ms
> > [  143.131500] xhci_hcd 0000:00:14.0: Can't queue urb, port error, link inactive
> > [  143.138260] xhci_hcd 0000:00:14.0: Port change event, 2-3, id 19, portsc: 0x2802a0
> > [  143.138263] xhci_hcd 0000:00:14.0: handle_port_status: starting usb2 port polling.
> > [  143.160756] xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x2802a0, return 0x3002a0
> > [  143.160798] usb usb2-port3: not warm reset yet, waiting 200ms
> >
> > The port status is PP=1, CCS=0, PED=0, PLS=Inactive, which is Error
> > state per "USB3 Root Hub Port State Machine". It's reasonable to perform
> > warm reset several times, but if the port is still not enabled after
> > many attempts, consider it's gone and treat it as disconnected.
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> A gentle ping...
> 
> > ---
> >  drivers/usb/core/hub.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index 00070a8a65079..f618d86d526d1 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -2979,7 +2979,8 @@ static int hub_port_reset(struct usb_hub *hub, int port1,
> >                 }
> >
> >                 /* Check for disconnect or reset */
> > -               if (status == 0 || status == -ENOTCONN || status == -ENODEV) {
> > +               if (status == 0 || status == -ENOTCONN || status == -ENODEV ||
> > +                   (status == -EBUSY && i == PORT_RESET_TRIES - 1)) {

How about modifying the comment so that people will know what this 
extra test is trying to do?  The original comment no longer gives an 
accurate description of the test.

Alan Stern

> >                         usb_clear_port_feature(hub->hdev, port1,
> >                                         USB_PORT_FEAT_C_RESET);
> >
> > --
> > 2.33.1
> >
