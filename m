Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF2C588267
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 21:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbiHBTSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 15:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiHBTSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 15:18:44 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8775612D28;
        Tue,  2 Aug 2022 12:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659467923; x=1691003923;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=sBG+z2TYW905hIHdQlM191qs+E/BURDyZkyYXkH+wL4=;
  b=FzI0fwbbSVGYH+HLJjT+xzAtyj9A4r+gxxA2JGi+iX+SLhH0liaI8uOM
   MH3RmN+ntdPtipAVxK7aFGyw/Lrn6OnXDgQ3ma9tafccwpMpotYXMrRGH
   cSI5+hlaRjzdXvRnh4dMgAhzDYt3YsnjWVHI40FFYs+pxxae6lON/p8Fm
   g=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 02 Aug 2022 12:18:43 -0700
X-QCInternal: smtphost
Received: from hu-eserrao-lv.qualcomm.com (HELO hu-devc-lv-c.qualcomm.com) ([10.47.235.164])
  by ironmsg08-lv.qualcomm.com with ESMTP; 02 Aug 2022 12:18:43 -0700
Received: by hu-devc-lv-c.qualcomm.com (Postfix, from userid 464172)
        id 7F08A211BF; Tue,  2 Aug 2022 12:18:42 -0700 (PDT)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        quic_mrana@quicinc.com, Thinh.Nguyen@synopsys.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH 5/5] usb: gadget: f_ecm: Add function suspend and wakeup support
Date:   Tue,  2 Aug 2022 12:18:40 -0700
Message-Id: <1659467920-9095-6-git-send-email-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1659467920-9095-1-git-send-email-quic_eserrao@quicinc.com>
References: <1659467920-9095-1-git-send-email-quic_eserrao@quicinc.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB host sends function suspend setup packet to an interface when there
is no active communication involved. Handle such requests from host so
that the interface goes to function suspend state. For the device to
resume data transfer it can either send a function wakeup notification or
wait for the host initated function resume depending on the function
wakeup capability of the device. Add support to trigger function wakeup.

Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
---
 drivers/usb/gadget/function/f_ecm.c   | 49 +++++++++++++++++++++++++++++++++--
 drivers/usb/gadget/function/u_ether.c | 32 ++++++++++++++++++++---
 drivers/usb/gadget/function/u_ether.h |  6 +++--
 3 files changed, 80 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/function/f_ecm.c b/drivers/usb/gadget/function/f_ecm.c
index fb1dec3..8bb7e3c 100644
--- a/drivers/usb/gadget/function/f_ecm.c
+++ b/drivers/usb/gadget/function/f_ecm.c
@@ -54,6 +54,8 @@ struct f_ecm {
 	u8				notify_state;
 	atomic_t			notify_count;
 	bool				is_open;
+	bool				func_wakeup_allowed;
+	bool				func_is_suspended;
 
 	/* FIXME is_open needs some irq-ish locking
 	 * ... possibly the same as port.ioport
@@ -631,6 +633,8 @@ static void ecm_disable(struct usb_function *f)
 		ecm->port.out_ep->desc = NULL;
 	}
 
+	ecm->func_wakeup_allowed = false;
+	ecm->func_is_suspended = false;
 	usb_ep_disable(ecm->notify);
 	ecm->notify->desc = NULL;
 }
@@ -894,9 +898,14 @@ static void ecm_suspend(struct usb_function *f)
 	struct f_ecm *ecm = func_to_ecm(f);
 	struct usb_composite_dev *cdev = ecm->port.func.config->cdev;
 
+	if (ecm->func_is_suspended) {
+		DBG(cdev, "Function already suspended\n");
+		return;
+	}
+
 	DBG(cdev, "ECM Suspend\n");
 
-	gether_suspend(&ecm->port);
+	gether_suspend(&ecm->port, ecm->func_wakeup_allowed);
 }
 
 static void ecm_resume(struct usb_function *f)
@@ -906,7 +915,41 @@ static void ecm_resume(struct usb_function *f)
 
 	DBG(cdev, "ECM Resume\n");
 
-	gether_resume(&ecm->port);
+	gether_resume(&ecm->port, ecm->func_is_suspended);
+}
+
+static int ecm_get_status(struct usb_function *f)
+{
+	struct f_ecm *ecm = func_to_ecm(f);
+
+	return (ecm->func_wakeup_allowed ? USB_INTRF_STAT_FUNC_RW : 0) |
+		USB_INTRF_STAT_FUNC_RW_CAP;
+}
+
+static int ecm_func_suspend(struct usb_function *f, u8 options)
+{
+	bool func_wakeup_allowed;
+	struct f_ecm *ecm = func_to_ecm(f);
+	struct usb_composite_dev *cdev = ecm->port.func.config->cdev;
+
+	DBG(cdev, "func susp %u cmd\n", options);
+
+	func_wakeup_allowed = !!(options & (USB_INTRF_FUNC_SUSPEND_RW >> 8));
+	if (options & (USB_INTRF_FUNC_SUSPEND_LP >> 8)) {
+		ecm->func_wakeup_allowed = func_wakeup_allowed;
+		if (!ecm->func_is_suspended) {
+			ecm_suspend(f);
+			ecm->func_is_suspended = true;
+		}
+	} else {
+		if (ecm->func_is_suspended) {
+			ecm->func_is_suspended = false;
+			ecm_resume(f);
+		}
+		ecm->func_wakeup_allowed = func_wakeup_allowed;
+	}
+
+	return 0;
 }
 
 static void ecm_free(struct usb_function *f)
@@ -977,6 +1020,8 @@ static struct usb_function *ecm_alloc(struct usb_function_instance *fi)
 	ecm->port.func.disable = ecm_disable;
 	ecm->port.func.free_func = ecm_free;
 	ecm->port.func.suspend = ecm_suspend;
+	ecm->port.func.get_status = ecm_get_status;
+	ecm->port.func.func_suspend = ecm_func_suspend;
 	ecm->port.func.resume = ecm_resume;
 
 	return &ecm->port.func;
diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 78391de..f3e1c9b 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -477,8 +477,17 @@ static int ether_wakeup_host(struct gether *port)
 	struct usb_function *func = &port->func;
 	struct usb_gadget *gadget = func->config->cdev->gadget;
 
-	if (gadget->speed < USB_SPEED_SUPER)
+	if (gadget->speed >= USB_SPEED_SUPER) {
+		if (!port->func_wakeup_allowed) {
+			DBG(port->ioport, "Function wakeup not allowed\n");
+			return -EOPNOTSUPP;
+		}
+		ret = usb_func_wakeup(func);
+		if (ret)
+			port->is_wakeup_pending = true;
+	} else {
 		ret = usb_gadget_wakeup(gadget);
+	}
 
 	return ret;
 }
@@ -1081,7 +1090,7 @@ int gether_set_ifname(struct net_device *net, const char *name, int len)
 }
 EXPORT_SYMBOL_GPL(gether_set_ifname);
 
-void gether_suspend(struct gether *link)
+void gether_suspend(struct gether *link, bool wakeup_allowed)
 {
 	struct eth_dev *dev = link->ioport;
 	unsigned long flags;
@@ -1099,13 +1108,15 @@ void gether_suspend(struct gether *link)
 	}
 	spin_lock_irqsave(&dev->lock, flags);
 	link->is_suspend = true;
+	link->func_wakeup_allowed = wakeup_allowed;
 	spin_unlock_irqrestore(&dev->lock, flags);
 }
 EXPORT_SYMBOL_GPL(gether_suspend);
 
-void gether_resume(struct gether *link)
+void gether_resume(struct gether *link, bool func_suspend)
 {
 	struct eth_dev *dev = link->ioport;
+	struct usb_function *func = &link->func;
 	unsigned long flags;
 
 	if (!dev)
@@ -1113,6 +1124,19 @@ void gether_resume(struct gether *link)
 
 	spin_lock_irqsave(&dev->lock, flags);
 
+	/*
+	 * If the function is in USB3 Function Suspend state, resume is
+	 * canceled. In this case resume is done by a Function Resume request.
+	 */
+	if (func_suspend) {
+		if (link->is_wakeup_pending) {
+			usb_func_wakeup(func);
+			link->is_wakeup_pending = false;
+		}
+		spin_unlock_irqrestore(&dev->lock, flags);
+		return;
+	}
+
 	if (netif_queue_stopped(dev->net))
 		netif_start_queue(dev->net);
 
@@ -1284,6 +1308,8 @@ void gether_disconnect(struct gether *link)
 	spin_lock(&dev->lock);
 	dev->port_usb = NULL;
 	link->is_suspend = false;
+	link->is_wakeup_pending = false;
+	link->func_wakeup_allowed = false;
 	spin_unlock(&dev->lock);
 }
 EXPORT_SYMBOL_GPL(gether_disconnect);
diff --git a/drivers/usb/gadget/function/u_ether.h b/drivers/usb/gadget/function/u_ether.h
index 851ee10..4a6aa646 100644
--- a/drivers/usb/gadget/function/u_ether.h
+++ b/drivers/usb/gadget/function/u_ether.h
@@ -80,6 +80,8 @@ struct gether {
 	void				(*open)(struct gether *);
 	void				(*close)(struct gether *);
 	bool				is_suspend;
+	bool				is_wakeup_pending;
+	bool				func_wakeup_allowed;
 };
 
 #define	DEFAULT_FILTER	(USB_CDC_PACKET_TYPE_BROADCAST \
@@ -259,8 +261,8 @@ int gether_set_ifname(struct net_device *net, const char *name, int len);
 
 void gether_cleanup(struct eth_dev *dev);
 
-void gether_suspend(struct gether *link);
-void gether_resume(struct gether *link);
+void gether_suspend(struct gether *link, bool wakeup_allowed);
+void gether_resume(struct gether *link, bool func_suspend);
 
 /* connect/disconnect is handled by individual functions */
 struct net_device *gether_connect(struct gether *);
-- 
2.7.4

