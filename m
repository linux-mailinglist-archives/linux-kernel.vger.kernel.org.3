Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511875AAB1B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235702AbiIBJQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbiIBJP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:15:59 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A4C52FF6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 02:15:41 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-340862314d9so12093317b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 02:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=VUkALvMrHKnyjyWDi41Fha1wyKTilDY9t9GsjRgxLT0=;
        b=QhjFnX+32ff1K5hjB0lcUM4ldewnugxsyeRbuOVbc3y3zIdhZcLf74ZpWx19OAUjmM
         BON0zmYIdhf9GPOZuAH97wQsk5NKRtiFprP4r+JqdGvlQlpSd9uSxStONJoCdeQS1odA
         8DRBnDwiIrcd1IZqCNGot3pxQ23ge0ei7TIzSUK/pRuNY+OMgZAh3yxbSN3MxgvEtyEb
         ptC0+TvXmlqxPuYy2gsDOmFDd9RffTuSQeZG4TGBZ6t8HW4VyGgvGEiqpurTTK+3f4S9
         5/Ad4YCOb6Fqdaj0/EDuLq2ovQ+Ad2hlTaiCSFxD2l/Sn9E2JnoDbNvwKLKdwlojY8Va
         6CCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=VUkALvMrHKnyjyWDi41Fha1wyKTilDY9t9GsjRgxLT0=;
        b=eCspo5LCOoUZmMsIRHr3EVjZtFoBZb/kCIwiun3rfd3Wi01iGSjxXell6ombSguHZj
         7TJml5QI3SzeQzRrkhRSj+tgVItsR8QLDjcB3BPZPQtRdJltpzU7qSzv8fbQPpbiCIut
         l0FY5BXJLIGH7nJCvhkkHMyDdSVME0ImSD1XMy2Ia+pkxyA8UKhF9TJ8ePlDHcEEDVhV
         tNg4XPN0l18R9FNLstgGs4QtoaqvjLOMLqXtNX6mDraFIA35h6/saM9u8+culc3fg+i8
         rqtQzges8hoRFWyctdeKgKwLX0RG4jV5xs6+95+E+VzcSjtoLpcQh9eiKDWcXjMg59wD
         RmJw==
X-Gm-Message-State: ACgBeo03bTmru0TFs5mBYeWkIb10321BjteSX8x6jdQmrm8ssY7LVxhC
        M9puI/0oBKjMzyB5IXMeQHTJF7WFpE8=
X-Google-Smtp-Source: AA6agR7zAtbmKjIf7BJ7iXUofebXUYXTqLB8MSCn0TlVES16u4bjPuERrVOIbRRFVRoSVZb7qT+J4np1CR8=
X-Received: from raychi.tao.corp.google.com ([2401:fa00:fc:202:a063:2ff9:f6c4:a184])
 (user=raychi job=sendgmr) by 2002:a0d:cb15:0:b0:340:ab54:cd0c with SMTP id
 n21-20020a0dcb15000000b00340ab54cd0cmr26594217ywd.142.1662110140796; Fri, 02
 Sep 2022 02:15:40 -0700 (PDT)
Date:   Fri,  2 Sep 2022 17:15:35 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220902091535.3572333-1-raychi@google.com>
Subject: [Patch v2] usb: core: stop USB enumeration if too many retries
From:   Ray Chi <raychi@google.com>
To:     gregkh@linuxfoundation.org, mathias.nyman@linux.intel.com,
        stern@rowland.harvard.edu
Cc:     albertccwang@google.com, badhri@google.com, pumahsu@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ray Chi <raychi@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a broken accessory connected to a USB host, usbcore might
keep doing enumeration retries and it will take a long time to
cause system unstable.

This patch provides a quirk to specific USB ports of the hub to
stop USB enumeration if needed.

Signed-off-by: Ray Chi <raychi@google.com>
---
Changes since v1:
 - remove usb_hub_set_port_power()
 - add a variable ignore_connect into struct port_dev
 - modify hub_port_stop_enumerate() and set ignore_connect in
   this function
 - avoid calling hub_port_connect_change() in port_event()
---
 drivers/usb/core/hub.c | 40 ++++++++++++++++++++++++++++++++++++++++
 drivers/usb/core/hub.h |  2 ++
 include/linux/usb.h    |  3 +++
 3 files changed, 45 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 2633acde7ac1..7f34ee8bb81e 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3081,6 +3081,30 @@ static int hub_port_reset(struct usb_hub *hub, int port1,
 	return status;
 }
 
+/* Stop enumerate if the port met errors and quirk is set */
+static bool hub_port_stop_enumerate(struct usb_hub *hub, int port1, int retries)
+{
+	struct usb_port *port_dev = hub->ports[port1 - 1];
+
+	if (port_dev->quirks & USB_PORT_QUIRK_STOP_ENUM) {
+		if (port_dev->ignore_connect)
+			return true;
+
+		if (retries < (PORT_INIT_TRIES - 1) / 2)
+			return false;
+
+		/*
+		 * Some USB hosts can't take a long time to keep doing enumeration
+		 * retry. After doing half of the retries, we would turn off the port
+		 * power to stop enumeration if the quirk is set.
+		 */
+		port_dev->ignore_connect = true;
+	} else
+		port_dev->ignore_connect = false;
+
+	return port_dev->ignore_connect;
+}
+
 /* Check if a port is power on */
 int usb_port_is_power_on(struct usb_hub *hub, unsigned int portstatus)
 {
@@ -4855,6 +4879,11 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
 					buf->bMaxPacketSize0;
 			kfree(buf);
 
+			if (r < 0 && (port_dev->quirks & USB_PORT_QUIRK_STOP_ENUM)) {
+				retval = r;
+				goto fail;
+			}
+
 			retval = hub_port_reset(hub, port1, udev, delay, false);
 			if (retval < 0)		/* error or disconnect */
 				goto fail;
@@ -5387,6 +5416,9 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
 		if ((status == -ENOTCONN) || (status == -ENOTSUPP))
 			break;
 
+		if (hub_port_stop_enumerate(hub, port1, i))
+			break;
+
 		/* When halfway through our retry count, power-cycle the port */
 		if (i == (PORT_INIT_TRIES - 1) / 2) {
 			dev_info(&port_dev->dev, "attempt power cycle\n");
@@ -5550,6 +5582,9 @@ static void port_event(struct usb_hub *hub, int port1)
 	if (usb_hub_port_status(hub, port1, &portstatus, &portchange) < 0)
 		return;
 
+	if (hub_port_stop_enumerate(hub, port1, 0))
+		return;
+
 	if (portchange & USB_PORT_STAT_C_CONNECTION) {
 		usb_clear_port_feature(hdev, port1, USB_PORT_FEAT_C_CONNECTION);
 		connect_change = 1;
@@ -5934,6 +5969,9 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
 		ret = hub_port_init(parent_hub, udev, port1, i);
 		if (ret >= 0 || ret == -ENOTCONN || ret == -ENODEV)
 			break;
+
+		if (hub_port_stop_enumerate(parent_hub, port1, i))
+			goto stop_enumerate;
 	}
 	mutex_unlock(hcd->address0_mutex);
 
@@ -6022,6 +6060,8 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
 	udev->bos = bos;
 	return 0;
 
+stop_enumerate:
+	mutex_unlock(hcd->address0_mutex);
 re_enumerate:
 	usb_release_bos_descriptor(udev);
 	udev->bos = bos;
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index b2925856b4cb..f0aa718f4c7f 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -90,6 +90,7 @@ struct usb_hub {
  * @is_superspeed cache super-speed status
  * @usb3_lpm_u1_permit: whether USB3 U1 LPM is permitted.
  * @usb3_lpm_u2_permit: whether USB3 U2 LPM is permitted.
+ * @ignore_connect: ignore the connection or not
  */
 struct usb_port {
 	struct usb_device *child;
@@ -103,6 +104,7 @@ struct usb_port {
 	u32 over_current_count;
 	u8 portnum;
 	u32 quirks;
+	bool ignore_connect;
 	unsigned int is_superspeed:1;
 	unsigned int usb3_lpm_u1_permit:1;
 	unsigned int usb3_lpm_u2_permit:1;
diff --git a/include/linux/usb.h b/include/linux/usb.h
index f7a9914fc97f..fc0fef58c706 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -490,6 +490,9 @@ enum usb_port_connect_type {
 /* Decrease TRSTRCY to 10ms during device enumeration. */
 #define USB_PORT_QUIRK_FAST_ENUM	BIT(1)
 
+/* Stop the enumeration for the given port if there are too many failures*/
+#define USB_PORT_QUIRK_STOP_ENUM	BIT(2)
+
 /*
  * USB 2.0 Link Power Management (LPM) parameters.
  */
-- 
2.37.2.789.g6183377224-goog

