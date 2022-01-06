Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6D4486403
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 12:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238696AbiAFL5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 06:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238675AbiAFL5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 06:57:46 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC6CC061245;
        Thu,  6 Jan 2022 03:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=OQyuT4pT54pQ4S9p9yyplQ8JURCOyNDdWpEzq3+9i4M=; b=X7
        9MMWYZEuKW/SM409E9lESHIJSdjbs7ghY+YRm7xiwo0CKaJhxZFVRxyKwJjn590gA93mGE6jFO/O8
        s0z8zZTcVtdDNwXB8WGBb3vsgK05ihIkFlrkkDoCbQxlNJJvuwu+a421r23eZJarM53kBc9A+YrbM
        xYdahsCByQQ0JoU2FBdIk0MM+SZGt3xhv3YnQc/SNrsCRqeL3ePSkTH1YqRMegnIT4ZF2qUSftof4
        wu18los1mjblFlCESDAHf2vhwIoVnhbvHBZ1dXmz+oId5i0PZlW1z+8vxFp69Wd7ClWSkdryx1tcV
        Pj3VykRXHZneEnzjB1bgqvmNxOccgQpA==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1n5ROl-0004gI-7v; Thu, 06 Jan 2022 11:57:39 +0000
From:   John Keeping <john@metanate.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     John Keeping <john@metanate.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Argishti Aleksanyan <Argishti.Aleksanyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: dwc2: gadget: initialize max_speed from params
Date:   Thu,  6 Jan 2022 11:57:31 +0000
Message-Id: <20220106115731.1473909-1-john@metanate.com>
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
Acked-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Signed-off-by: John Keeping <john@metanate.com>
---
v2:
- Add Minas' ack
---
 drivers/usb/dwc2/gadget.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index b884a83b26a6..2bc03f41c70a 100644
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

