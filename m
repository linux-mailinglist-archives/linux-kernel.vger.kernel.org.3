Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFD358826B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 21:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiHBTUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 15:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiHBTTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 15:19:31 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7D852FD3;
        Tue,  2 Aug 2022 12:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659467962; x=1691003962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=dp6FpXSnj7Kdrprl3gFX+M+yxPPFELr3jMZgt5ns6iE=;
  b=fdjZiYAK8XL5I+q2uESOvs5zcelmrxKq2uH3ubxfdHroWqjmzLpdKl8j
   8OWZwKsVXM5gK/ROJrHUOeciJfcrax9sRZkGtYMH5Cf5lgkKWyrUWyKBV
   W28qXxSR1MHng3szYD3mhTJPpQeQT7BLL6vqan/SDDNSA6qypO5jonAlh
   Y=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 02 Aug 2022 12:19:22 -0700
X-QCInternal: smtphost
Received: from hu-eserrao-lv.qualcomm.com (HELO hu-devc-lv-c.qualcomm.com) ([10.47.235.164])
  by ironmsg08-lv.qualcomm.com with ESMTP; 02 Aug 2022 12:19:23 -0700
Received: by hu-devc-lv-c.qualcomm.com (Postfix, from userid 464172)
        id 7C4D5211BE; Tue,  2 Aug 2022 12:18:42 -0700 (PDT)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        quic_mrana@quicinc.com, Thinh.Nguyen@synopsys.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH 4/5] usb: gadget: f_ecm: Add suspend/resume and remote wakeup support
Date:   Tue,  2 Aug 2022 12:18:39 -0700
Message-Id: <1659467920-9095-5-git-send-email-quic_eserrao@quicinc.com>
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

When the host sends a suspend notification to the device, handle
the suspend callbacks in the function driver. Depending on the
remote wakeup capability the device can either trigger a remote
wakeup or wait for the host initiated resume to start data
transfer again.

Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
---
 drivers/usb/gadget/function/f_ecm.c   | 22 +++++++++++
 drivers/usb/gadget/function/u_ether.c | 72 +++++++++++++++++++++++++++++++++++
 drivers/usb/gadget/function/u_ether.h |  4 ++
 3 files changed, 98 insertions(+)

diff --git a/drivers/usb/gadget/function/f_ecm.c b/drivers/usb/gadget/function/f_ecm.c
index ffe2486..fb1dec3 100644
--- a/drivers/usb/gadget/function/f_ecm.c
+++ b/drivers/usb/gadget/function/f_ecm.c
@@ -889,6 +889,26 @@ static struct usb_function_instance *ecm_alloc_inst(void)
 	return &opts->func_inst;
 }
 
+static void ecm_suspend(struct usb_function *f)
+{
+	struct f_ecm *ecm = func_to_ecm(f);
+	struct usb_composite_dev *cdev = ecm->port.func.config->cdev;
+
+	DBG(cdev, "ECM Suspend\n");
+
+	gether_suspend(&ecm->port);
+}
+
+static void ecm_resume(struct usb_function *f)
+{
+	struct f_ecm *ecm = func_to_ecm(f);
+	struct usb_composite_dev *cdev = ecm->port.func.config->cdev;
+
+	DBG(cdev, "ECM Resume\n");
+
+	gether_resume(&ecm->port);
+}
+
 static void ecm_free(struct usb_function *f)
 {
 	struct f_ecm *ecm;
@@ -956,6 +976,8 @@ static struct usb_function *ecm_alloc(struct usb_function_instance *fi)
 	ecm->port.func.setup = ecm_setup;
 	ecm->port.func.disable = ecm_disable;
 	ecm->port.func.free_func = ecm_free;
+	ecm->port.func.suspend = ecm_suspend;
+	ecm->port.func.resume = ecm_resume;
 
 	return &ecm->port.func;
 }
diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 7887def..78391de 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -471,6 +471,18 @@ static inline int is_promisc(u16 cdc_filter)
 	return cdc_filter & USB_CDC_PACKET_TYPE_PROMISCUOUS;
 }
 
+static int ether_wakeup_host(struct gether *port)
+{
+	int ret = -EOPNOTSUPP;
+	struct usb_function *func = &port->func;
+	struct usb_gadget *gadget = func->config->cdev->gadget;
+
+	if (gadget->speed < USB_SPEED_SUPER)
+		ret = usb_gadget_wakeup(gadget);
+
+	return ret;
+}
+
 static netdev_tx_t eth_start_xmit(struct sk_buff *skb,
 					struct net_device *net)
 {
@@ -490,6 +502,25 @@ static netdev_tx_t eth_start_xmit(struct sk_buff *skb,
 		in = NULL;
 		cdc_filter = 0;
 	}
+
+	if (dev->port_usb->is_suspend) {
+		DBG(dev, "Port suspended. Triggering wakeup\n");
+		retval = ether_wakeup_host(dev->port_usb);
+		if (retval) {
+			/*
+			 * Either the remote wakeup is not yet complete or
+			 * wakeup is not supported. In either case we cannot
+			 * send data and hence inform the upper layer to stop
+			 * sending data. The queue is re-started in resume
+			 * callback once the remote wakeup is successful or when
+			 * host initiated resume happens.
+			 */
+			netif_stop_queue(net);
+			spin_unlock_irqrestore(&dev->lock, flags);
+			return NETDEV_TX_BUSY;
+		}
+	}
+
 	spin_unlock_irqrestore(&dev->lock, flags);
 
 	if (!in) {
@@ -1050,6 +1081,46 @@ int gether_set_ifname(struct net_device *net, const char *name, int len)
 }
 EXPORT_SYMBOL_GPL(gether_set_ifname);
 
+void gether_suspend(struct gether *link)
+{
+	struct eth_dev *dev = link->ioport;
+	unsigned long flags;
+
+	if (!dev)
+		return;
+
+	if (atomic_read(&dev->tx_qlen)) {
+		/*
+		 * There is a transfer in progress. So we trigger a remote
+		 * wakeup to inform the host.
+		 */
+		ether_wakeup_host(dev->port_usb);
+		return;
+	}
+	spin_lock_irqsave(&dev->lock, flags);
+	link->is_suspend = true;
+	spin_unlock_irqrestore(&dev->lock, flags);
+}
+EXPORT_SYMBOL_GPL(gether_suspend);
+
+void gether_resume(struct gether *link)
+{
+	struct eth_dev *dev = link->ioport;
+	unsigned long flags;
+
+	if (!dev)
+		return;
+
+	spin_lock_irqsave(&dev->lock, flags);
+
+	if (netif_queue_stopped(dev->net))
+		netif_start_queue(dev->net);
+
+	link->is_suspend = false;
+	spin_unlock_irqrestore(&dev->lock, flags);
+}
+EXPORT_SYMBOL_GPL(gether_resume);
+
 /*
  * gether_cleanup - remove Ethernet-over-USB device
  * Context: may sleep
@@ -1212,6 +1283,7 @@ void gether_disconnect(struct gether *link)
 
 	spin_lock(&dev->lock);
 	dev->port_usb = NULL;
+	link->is_suspend = false;
 	spin_unlock(&dev->lock);
 }
 EXPORT_SYMBOL_GPL(gether_disconnect);
diff --git a/drivers/usb/gadget/function/u_ether.h b/drivers/usb/gadget/function/u_ether.h
index 4014454..851ee10 100644
--- a/drivers/usb/gadget/function/u_ether.h
+++ b/drivers/usb/gadget/function/u_ether.h
@@ -79,6 +79,7 @@ struct gether {
 	/* called on network open/close */
 	void				(*open)(struct gether *);
 	void				(*close)(struct gether *);
+	bool				is_suspend;
 };
 
 #define	DEFAULT_FILTER	(USB_CDC_PACKET_TYPE_BROADCAST \
@@ -258,6 +259,9 @@ int gether_set_ifname(struct net_device *net, const char *name, int len);
 
 void gether_cleanup(struct eth_dev *dev);
 
+void gether_suspend(struct gether *link);
+void gether_resume(struct gether *link);
+
 /* connect/disconnect is handled by individual functions */
 struct net_device *gether_connect(struct gether *);
 void gether_disconnect(struct gether *);
-- 
2.7.4

