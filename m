Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932BF4668FA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 18:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376274AbhLBRVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 12:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376259AbhLBRVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:21:20 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4DEC06174A;
        Thu,  2 Dec 2021 09:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=4WCyM8f8j4d1i+Nq6Vhx0kWZ55WOQmTPNCMfAjx+7fY=; b=RU
        RUEVHvZhyocL7Ix34Qe79xg1u+DbT2mJBqVppoFfIKhJhrk648SKJ6jjXOWjqrvcf1GrU6b+98/dN
        9QD3RW6GoipDPDZKBabrdfHotfA1wQdlJGDD+/OzMkZDoF+jh5CMeAJ5oqWyKPCXgnWfhZ9DGi3Tq
        xp5QjyX0LXxr49T/7jWACwViC/FriIF9Kf381SwTVxqtLU7WvzHXhwGNy9tT+Lgb2ePIuTKPH0Nsl
        0GJYvo1FPdIFx5D8iOsTpKn6Fa5Hynq/bqBbr7WpNWTZA5vBkqCdtSBEw2AEkWuOxN4xt03r5bRSG
        dp7bTIT00C50ujcL60YlLXW42HS4waiQ==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mspiU-0002Tc-L6; Thu, 02 Dec 2021 17:17:54 +0000
From:   John Keeping <john@metanate.com>
To:     linux-usb@vger.kernel.org
Cc:     John Keeping <john@metanate.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Argishti Aleksanyan <Argishti.Aleksanyan@synopsys.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc2: gadget: initialize max_speed from params
Date:   Thu,  2 Dec 2021 17:17:48 +0000
Message-Id: <20211202171748.3035874-1-john@metanate.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DWC2 may be paired with a full-speed PHY which is not capable of
high-speed operation.  Report this correctly to the gadget core by
setting max_speed from the core parameters.

Prior to commit 5324bad66f09f ("usb: dwc2: gadget: implement
udc_set_speed()") this didn't cause the hardware to be configured
incorrectly, although the speed may have been reported incorrectly.  But
after that commit params.speed is updated based on a value passed in by
the gadget core which may set it to a faster speed than is supported by
the hardware.  Initialising the max_speed parameter ensures the speed
passed to dwc2_gadget_set_speed() will be one supported by the hardware.

Fixes: 5324bad66f09f ("usb: dwc2: gadget: implement udc_set_speed()")
Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/usb/dwc2/gadget.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index b884a83b26a6e..2bc03f41c70ad 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -4974,7 +4974,18 @@ int dwc2_gadget_init(struct dwc2_hsotg *hsotg)
 		hsotg->params.g_np_tx_fifo_size);
 	dev_dbg(dev, "RXFIFO size: %d\n", hsotg->params.g_rx_fifo_size);
 
-	hsotg->gadget.max_speed = USB_SPEED_HIGH;
+	switch (hsotg->params.speed) {
+	case DWC2_SPEED_PARAM_LOW:
+		hsotg->gadget.max_speed = USB_SPEED_LOW;
+		break;
+	case DWC2_SPEED_PARAM_FULL:
+		hsotg->gadget.max_speed = USB_SPEED_FULL;
+		break;
+	default:
+		hsotg->gadget.max_speed = USB_SPEED_HIGH;
+		break;
+	}
+
 	hsotg->gadget.ops = &dwc2_hsotg_gadget_ops;
 	hsotg->gadget.name = dev_name(dev);
 	hsotg->gadget.otg_caps = &hsotg->params.otg_caps;
-- 
2.34.1

