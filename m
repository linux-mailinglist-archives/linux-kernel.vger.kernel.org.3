Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE5947B542
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 22:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhLTVf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 16:35:26 -0500
Received: from netrider.rowland.org ([192.131.102.5]:39697 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S231244AbhLTVfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 16:35:24 -0500
Received: (qmail 921658 invoked by uid 1000); 20 Dec 2021 16:35:23 -0500
Date:   Mon, 20 Dec 2021 16:35:23 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yinbo Zhu <zhuyinbo@loongson.cn>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Patchwork Bot <patchwork-bot@kernel.org>
Subject: Re: [PATCH v4] usb: ohci: add check for host controller functional
 states
Message-ID: <YcD3G7TkguB1Lsi7@rowland.harvard.edu>
References: <1633957378-39631-1-git-send-email-zhuyinbo@loongson.cn>
 <YcCoUb7UBUErfvkm@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcCoUb7UBUErfvkm@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 04:59:13PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Oct 11, 2021 at 09:02:58PM +0800, Yinbo Zhu wrote:
> > The usb states of ohci controller include UsbOperational, UsbReset,
> > UsbSuspend and UsbResume. Among them, only the UsbOperational state
> > supports launching the start of frame for host controller according
> > the ohci protocol spec, but in S3 and S4 (suspend to memory/suspend
> > to disk) press test procedure, it may happen that the start of
> > frame was launched in other usb states and cause ohci works failed,
> > that the phenomenon was hc will allways reproduce the SoF interrupt
> > and consider that hc doesn't deal with the ed/td/done list in non-
> > UsbOperational, and this patch was to add check for host controller
> > functional states and if it is not UsbOperational state that need
> > set INTR_SF in intrdisable register to ensure SOF Token generation
> > was been disabled so that it can fix ohci SoF abnormally interrupt.
> 
> I do not understand this change.  What commit is this fixing?  What
> devices today do not work with the code as-is?
> 
> > 
> > Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> > ---
> > Change in v4:
> > 		Rework the commit log information.
> > 		Remove the extra unnecessary blank line. 
> > 
> > 
> >  drivers/usb/host/ohci-hcd.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
> > index 1f5e693..4fd59fa 100644
> > --- a/drivers/usb/host/ohci-hcd.c
> > +++ b/drivers/usb/host/ohci-hcd.c
> > @@ -879,7 +879,7 @@ static irqreturn_t ohci_irq (struct usb_hcd *hcd)
> >  {
> >  	struct ohci_hcd		*ohci = hcd_to_ohci (hcd);
> >  	struct ohci_regs __iomem *regs = ohci->regs;
> > -	int			ints;
> > +	int			ints, ctl;
> 
> New line for a new variable please.
> 
> >  
> >  	/* Read interrupt status (and flush pending writes).  We ignore the
> >  	 * optimization of checking the LSB of hcca->done_head; it doesn't
> > @@ -969,9 +969,14 @@ static irqreturn_t ohci_irq (struct usb_hcd *hcd)
> >  	 * when there's still unlinking to be done (next frame).
> >  	 */
> >  	ohci_work(ohci);
> > -	if ((ints & OHCI_INTR_SF) != 0 && !ohci->ed_rm_list
> > -			&& ohci->rh_state == OHCI_RH_RUNNING)
> > +
> > +	ctl = ohci_readl(ohci, &regs->control);
> > +	if (((ints & OHCI_INTR_SF) != 0 && !ohci->ed_rm_list
> > +			&& ohci->rh_state == OHCI_RH_RUNNING) ||
> > +			((ctl & OHCI_CTRL_HCFS) != OHCI_USB_OPER)) {
> >  		ohci_writel (ohci, OHCI_INTR_SF, &regs->intrdisable);
> > +		(void)ohci_readl(ohci, &regs->intrdisable);
> 
> No need for (void).

Greg:

I didn't reply to v4 of this patch because the OP never responded to my 
request regarding v3.  See

https://lore.kernel.org/linux-usb/20211011161732.GA822456@rowland.harvard.edu/

Alan Stern
