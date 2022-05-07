Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A945351E834
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 17:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345050AbiEGPkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 11:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239114AbiEGPkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 11:40:04 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id ED2CB23BFD
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 08:36:16 -0700 (PDT)
Received: (qmail 74593 invoked by uid 1000); 7 May 2022 11:36:16 -0400
Date:   Sat, 7 May 2022 11:36:16 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        USB mailing list <linux-usb@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH 4/4] USB: gadget: Add a new bus for gadgets
Message-ID: <YnaR8LaaPTdLTiok@rowland.harvard.edu>
References: <YjeEbHL8ITkW692W@rowland.harvard.edu>
 <YmKt3kH+85kjzdbL@kroah.com>
 <YmSc29YZvxgT5fEJ@rowland.harvard.edu>
 <YmSo6fU1FlNq8cOZ@rowland.harvard.edu>
 <YmSpKpnWR8WWEk/p@rowland.harvard.edu>
 <YmSpdxaDNeC2BBOf@rowland.harvard.edu>
 <alpine.DEB.2.22.394.2205031209030.681336@ramsan.of.borg>
 <YnFCEn45XwDWM/9Y@rowland.harvard.edu>
 <CAMuHMdVDK0W0T3=+2c1E6wtwy5JTUemTGYyj3PFuVUhK++AzrA@mail.gmail.com>
 <YnFO0Qr8RY7peFCg@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnFO0Qr8RY7peFCg@rowland.harvard.edu>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 11:48:33AM -0400, Alan Stern wrote:
> On Tue, May 03, 2022 at 05:27:08PM +0200, Geert Uytterhoeven wrote:
> > Hi Alan,
> > 
> > On Tue, May 3, 2022 at 5:14 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > On Tue, May 03, 2022 at 12:14:30PM +0200, Geert Uytterhoeven wrote:
> > > > On Sat, 23 Apr 2022, Alan Stern wrote:
> > > > > This patch adds a "gadget" bus and uses it for registering gadgets and
> > > > > their drivers.  From now on, bindings will be managed by the driver
> > > > > core rather than through ad-hoc manipulations in the UDC core.
> > > > >
> > > > > As part of this change, the driver_pending_list is removed.  The UDC
> > > > > core won't need to keep track of unbound drivers for later binding,
> > > > > because the driver core handles all of that for us.
> > > > >
> > > > > However, we do need one new feature: a way to prevent gadget drivers
> > > > > from being bound to more than one gadget at a time.  The existing code
> > > > > does this automatically, but the driver core doesn't -- it's perfectly
> > > > > happy to bind a single driver to all the matching devices on the bus.
> > > > > The patch adds a new bitflag to the usb_gadget_driver structure for
> > > > > this purpose.
> > > > >
> > > > > A nice side effect of this change is a reduction in the total lines of
> > > > > code, since now the driver core will do part of the work that the UDC
> > > > > used to do.
> > > > >
> > > > > A possible future patch could add udc devices to the gadget bus, say
> > > > > as a separate device type.
> > > > >
> > > > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > > >
> > > > Thanks for your patch, which is now commit fc274c1e997314bf ("USB:
> > > > gadget: Add a new bus for gadgets") in usb-next.
> > > >
> > > > This patch cause a regression on the Renesas Salvator-XS development
> > > > board, as R-Car H3 has multiple USB gadget devices:
> > >
> > > Then these gadgets ought to have distinct names in order to avoid the
> > > conflict below:

Geert:

Can you test the patch below?  It ought to fix the problem (although it 
might end up causing other problems down the line...)

Alan Stern


Index: usb-devel/drivers/usb/gadget/udc/core.c
===================================================================
--- usb-devel.orig/drivers/usb/gadget/udc/core.c
+++ usb-devel/drivers/usb/gadget/udc/core.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/list.h>
+#include <linux/idr.h>
 #include <linux/err.h>
 #include <linux/dma-mapping.h>
 #include <linux/sched/task_stack.h>
@@ -23,6 +24,8 @@
 
 #include "trace.h"
 
+static DEFINE_IDA(gadget_id_numbers);
+
 static struct bus_type gadget_bus_type;
 
 /**
@@ -1248,7 +1251,6 @@ static void usb_udc_nop_release(struct d
 void usb_initialize_gadget(struct device *parent, struct usb_gadget *gadget,
 		void (*release)(struct device *dev))
 {
-	dev_set_name(&gadget->dev, "gadget");
 	INIT_WORK(&gadget->work, usb_gadget_state_work);
 	gadget->dev.parent = parent;
 
@@ -1304,12 +1306,21 @@ int usb_add_gadget(struct usb_gadget *ga
 	usb_gadget_set_state(gadget, USB_STATE_NOTATTACHED);
 	udc->vbus = true;
 
+	ret = ida_alloc(&gadget_id_numbers, GFP_KERNEL);
+	if (ret < 0)
+		goto err_del_udc;
+	gadget->id_number = ret;
+	dev_set_name(&gadget->dev, "gadget.%d", ret);
+
 	ret = device_add(&gadget->dev);
 	if (ret)
-		goto err_del_udc;
+		goto err_free_id;
 
 	return 0;
 
+ err_free_id:
+	ida_free(&gadget_id_numbers, gadget->id_number);
+
  err_del_udc:
 	flush_work(&gadget->work);
 	device_del(&udc->dev);
@@ -1417,6 +1428,7 @@ void usb_del_gadget(struct usb_gadget *g
 	kobject_uevent(&udc->dev.kobj, KOBJ_REMOVE);
 	flush_work(&gadget->work);
 	device_del(&gadget->dev);
+	ida_free(&gadget_id_numbers, gadget->id_number);
 	device_unregister(&udc->dev);
 }
 EXPORT_SYMBOL_GPL(usb_del_gadget);
Index: usb-devel/include/linux/usb/gadget.h
===================================================================
--- usb-devel.orig/include/linux/usb/gadget.h
+++ usb-devel/include/linux/usb/gadget.h
@@ -386,6 +386,7 @@ struct usb_gadget_ops {
  * @lpm_capable: If the gadget max_speed is FULL or HIGH, this flag
  *	indicates that it supports LPM as per the LPM ECN & errata.
  * @irq: the interrupt number for device controller.
+ * @id_number: a unique ID number for ensuring that gadget names are distinct
  *
  * Gadgets have a mostly-portable "gadget driver" implementing device
  * functions, handling all usb configurations and interfaces.  Gadget
@@ -446,6 +447,7 @@ struct usb_gadget {
 	unsigned			connected:1;
 	unsigned			lpm_capable:1;
 	int				irq;
+	int				id_number;
 };
 #define work_to_gadget(w)	(container_of((w), struct usb_gadget, work))
 
