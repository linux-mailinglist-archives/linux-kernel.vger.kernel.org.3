Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DB3588265
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 21:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbiHBTS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 15:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiHBTSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 15:18:46 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4D013D15;
        Tue,  2 Aug 2022 12:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659467924; x=1691003924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=CEiM39jmsZQ3Q7QvJYvHTnmSseG/w2PJb9/iJQV5ItM=;
  b=G1ooD7130QDJFtdZYQq/aPlorsLy4QiBCYbVdDQ6R/OTO7KgFIbrn3Kc
   nCWfw1xy6UY+nEXNQYqGPFS3+oERqkQPGDds3oJvRfciMNg4AfCWhF2x4
   abjSuDBlgk5NUhDT/gYdqhTVm6RMKQIKfCfTZbAZEfMYjFp8kLwCSLxDT
   k=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 02 Aug 2022 12:18:42 -0700
X-QCInternal: smtphost
Received: from hu-eserrao-lv.qualcomm.com (HELO hu-devc-lv-c.qualcomm.com) ([10.47.235.164])
  by ironmsg09-lv.qualcomm.com with ESMTP; 02 Aug 2022 12:18:42 -0700
Received: by hu-devc-lv-c.qualcomm.com (Postfix, from userid 464172)
        id 75857211B4; Tue,  2 Aug 2022 12:18:42 -0700 (PDT)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        quic_mrana@quicinc.com, Thinh.Nguyen@synopsys.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH 2/5] usb: gadget: Add function wakeup support
Date:   Tue,  2 Aug 2022 12:18:37 -0700
Message-Id: <1659467920-9095-3-git-send-email-quic_eserrao@quicinc.com>
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

An interface which is in function suspend state has to send a function
wakeup notification to the host in case it needs to initate any data
transfer. One notable difference between this and the existing remote
wakeup mechanism is that this can be called per-interface, and a UDC
would need to know the particular interface number to convey in its
Device Notification transaction packet.  Hence, we need to introduce
a new callback in the gadget_ops structure that UDC device drivers
can implement.  Similarly add a convenience function in the composite
driver which function drivers can call. Add support to handle such
requests in the composite layer and invoke the gadget op.

Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
---
 drivers/usb/gadget/composite.c | 32 ++++++++++++++++++++++++++++++++
 drivers/usb/gadget/udc/core.c  |  9 +++++++++
 include/linux/usb/composite.h  |  1 +
 include/linux/usb/gadget.h     |  2 ++
 4 files changed, 44 insertions(+)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 403563c..6bdce23 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -490,6 +490,38 @@ int usb_interface_id(struct usb_configuration *config,
 }
 EXPORT_SYMBOL_GPL(usb_interface_id);
 
+int usb_func_wakeup(struct usb_function *func)
+{
+	int ret, id;
+	unsigned long flags;
+
+	if (!func || !func->config || !func->config->cdev ||
+	    !func->config->cdev->gadget)
+		return -EINVAL;
+
+	DBG(func->config->cdev, "%s function wakeup\n", func->name);
+
+	spin_lock_irqsave(&func->config->cdev->lock, flags);
+
+	for (id = 0; id < MAX_CONFIG_INTERFACES; id++)
+		if (func->config->interface[id] == func)
+			break;
+
+	if (id == MAX_CONFIG_INTERFACES) {
+		ERROR(func->config->cdev, "Invalid function id:%d\n", id);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	ret = usb_gadget_func_wakeup(func->config->cdev->gadget, id);
+
+err:
+	spin_unlock_irqrestore(&func->config->cdev->lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(usb_func_wakeup);
+
 static u8 encode_bMaxPower(enum usb_device_speed speed,
 		struct usb_configuration *c)
 {
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 7886497..fe5c504 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -816,6 +816,15 @@ int usb_gadget_activate(struct usb_gadget *gadget)
 }
 EXPORT_SYMBOL_GPL(usb_gadget_activate);
 
+int usb_gadget_func_wakeup(struct usb_gadget *gadget, int interface_id)
+{
+	if (gadget->speed < USB_SPEED_SUPER || !gadget->ops->func_wakeup)
+		return -EOPNOTSUPP;
+
+	return gadget->ops->func_wakeup(gadget, interface_id);
+}
+EXPORT_SYMBOL_GPL(usb_gadget_func_wakeup);
+
 /* ------------------------------------------------------------------------- */
 
 #ifdef	CONFIG_HAS_DMA
diff --git a/include/linux/usb/composite.h b/include/linux/usb/composite.h
index 9d27622..31b35d7 100644
--- a/include/linux/usb/composite.h
+++ b/include/linux/usb/composite.h
@@ -254,6 +254,7 @@ int config_ep_by_speed_and_alt(struct usb_gadget *g, struct usb_function *f,
 
 int config_ep_by_speed(struct usb_gadget *g, struct usb_function *f,
 			struct usb_ep *_ep);
+int usb_func_wakeup(struct usb_function *func);
 
 #define	MAX_CONFIG_INTERFACES		16	/* arbitrary; max 255 */
 
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 3ad58b7..76f9de4 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -311,6 +311,7 @@ struct usb_udc;
 struct usb_gadget_ops {
 	int	(*get_frame)(struct usb_gadget *);
 	int	(*wakeup)(struct usb_gadget *);
+	int	(*func_wakeup)(struct usb_gadget *gadget, int interface_id);
 	int	(*set_selfpowered) (struct usb_gadget *, int is_selfpowered);
 	int	(*vbus_session) (struct usb_gadget *, int is_active);
 	int	(*vbus_draw) (struct usb_gadget *, unsigned mA);
@@ -612,6 +613,7 @@ int usb_gadget_disconnect(struct usb_gadget *gadget);
 int usb_gadget_deactivate(struct usb_gadget *gadget);
 int usb_gadget_activate(struct usb_gadget *gadget);
 int usb_gadget_check_config(struct usb_gadget *gadget);
+int usb_gadget_func_wakeup(struct usb_gadget *gadget, int interface_id);
 #else
 static inline int usb_gadget_frame_number(struct usb_gadget *gadget)
 { return 0; }
-- 
2.7.4

