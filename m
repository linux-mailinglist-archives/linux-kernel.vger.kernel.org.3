Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E01E54F54F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381830AbiFQKXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381162AbiFQKXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:23:04 -0400
Received: from mail-oi1-x24a.google.com (mail-oi1-x24a.google.com [IPv6:2607:f8b0:4864:20::24a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8831A6389
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 03:23:01 -0700 (PDT)
Received: by mail-oi1-x24a.google.com with SMTP id f125-20020aca3883000000b0032f79da924cso2411346oia.20
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 03:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=EsH5s3CS34XE5oP6QCxM35cFRjzs1KhxS15xVOEKEwc=;
        b=L/WIU6oYbbMN3DfxNX3yLjdfcnw1q3mR78ShoqkrAZEXfC81SSPrDykP++Xpn7vLe3
         P2Pt99SCK4NjbXwYUxn61ybTyzZPcMlj3t8VLsq4MOk7WGXAcWoO0r39BbNWsnWAa/0t
         LwAHYboPIN4LGU3waIThLV7EoXZTimXkaU8MqVdIWPlDCJOc8XeV6g9Mur+tS+Hb3eRn
         Vt4/JchDMdyVUAf4LNXBjM64oP5E2cJEl/ScaaHJAWi8eT9JiNmSHAHu/mFV1VMLCL7o
         K3g4yWumIFI5n4eR1s4YegZ7xDJjW63BQ71cg7lXWxr1jx1YNxG0KVUL95WJrw8v/p4F
         9ycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=EsH5s3CS34XE5oP6QCxM35cFRjzs1KhxS15xVOEKEwc=;
        b=k+dBiEGjU0CD3lNp/RKnyCL7DFb8ZjJ7gYmHWwroquSti3m2453mYWLbdtxRbmrXaP
         SPTTncI/5l5AfdV+EuqZXC4YlYTtm+zfHew5n7Z54JYR14ZB65P+paoarhZmdobmU2Qv
         L7XPJpZQJ0VLpxL8IhkSF0iTVxJ1a+qaujf383h89X2kTagqr2c7muMfWo337GrcA5If
         PIUrTfHeiMAotLuAJk/7Pm3G/540FbhHbF3cfMza757DH4F0DPy4WnmpmAGmKKuHNPCQ
         C4pUAgeVEhgIuqxJ6QQjVivrhHbzQ1pZpl9wY0olRicZ9cUesIZAEgzwNcJosIAX74za
         KdNQ==
X-Gm-Message-State: AJIora8M2obDbp9esGw+yqyUgaSs5iamBpd5CXYtcq1ValGMbUtCSr1k
        DhYv1GqhkmISAKxNbNocjtS43GTHpFA=
X-Google-Smtp-Source: AGRyM1u11LIckyI8NDwiOPdTSBks8QN8MaZ9Swf0fkAg06uTiDoCimZ4qRnP2q+HOch+KOYi9an3pisF1vI=
X-Received: from raychi.tao.corp.google.com ([2401:fa00:fc:202:1098:7d3f:d5d9:3c96])
 (user=raychi job=sendgmr) by 2002:a05:6870:b254:b0:ec:6ca4:c89f with SMTP id
 b20-20020a056870b25400b000ec6ca4c89fmr10908444oam.272.1655461380900; Fri, 17
 Jun 2022 03:23:00 -0700 (PDT)
Date:   Fri, 17 Jun 2022 18:22:56 +0800
Message-Id: <20220617102256.3253019-1-raychi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH] USB: hub: add module parameters to usbcore for port init retries
From:   Ray Chi <raychi@google.com>
To:     corbet@lwn.net, gregkh@linuxfoundation.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, albertccwang@google.com,
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

Currently, there is a Kconfig (CONFIG_USB_FEW_INIT_RETRIES) to
reduce retries when the port initialization is failed. The retry
times are fixed and assigned in compile time. To improve the
flexibility, this patch add four module parameters:
port_reset_tries, set_address_tries, get_descriptor_tries,
and get_maxpacket0_tries, to replace the original default values.

The default value of module parameters is the same as before
to preserve the existing behavior.

Signed-off-by: Ray Chi <raychi@google.com>
---
 .../admin-guide/kernel-parameters.txt         | 16 ++++++++++
 drivers/usb/core/hub.c                        | 31 ++++++++++++++++---
 2 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 8090130b544b..c467b2778128 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6277,6 +6277,22 @@
 			USB_REQ_GET_DESCRIPTOR request in milliseconds
 			(default 5000 = 5.0 seconds).
 
+	usbcore.port_reset_tries=
+			[USB] Set the retry time of port reset for each
+			port initialization (default PORT_RESET_TRIES = 5).
+
+	usbcore.set_address_tries=
+			[USB] set the retry time of set address for each
+			port initialization (default SET_ADDRESS_TRIES = 2).
+
+	usbcore.get_descriptor_tries=
+			[USB] set the retry time of set address for each
+			port initialization (default GET_DESCRIPTOR_TRIES = 2).
+
+	usbcore.get_maxpacket0_tries=
+			[USB] set the retry time of get maxpacket0 for each
+			port initialization (default GET_MAXPACKET0_TRIES = 3).
+
 	usbcore.nousb	[USB] Disable the USB subsystem
 
 	usbcore.quirks=
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index b7f66dcd1fe0..c5c695886424 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2788,6 +2788,27 @@ static unsigned hub_is_wusb(struct usb_hub *hub)
 #define HUB_LONG_RESET_TIME	200
 #define HUB_RESET_TIMEOUT	800
 
+/* define retry time for port reset */
+static int port_reset_tries = PORT_RESET_TRIES;
+module_param(port_reset_tries, int, S_IRUGO|S_IWUSR);
+MODULE_PARM_DESC(port_reset_tries, "retry times of port reset for each port initialization");
+
+/* define retry time of set address */
+static int set_address_tries = SET_ADDRESS_TRIES;
+module_param(set_address_tries, int, S_IRUGO|S_IWUSR);
+MODULE_PARM_DESC(set_address_tries, "retry times of set address for each port initialization");
+
+/* define retry time of get descriptor */
+static int get_descriptor_tries = GET_DESCRIPTOR_TRIES;
+module_param(get_descriptor_tries, int, S_IRUGO|S_IWUSR);
+MODULE_PARM_DESC(get_descriptor_tries, "retry times of set address for each port initialization");
+
+/* define retry time of get maxpacket0 */
+static int get_maxpacket0_tries = GET_MAXPACKET0_TRIES;
+module_param(get_maxpacket0_tries, int, S_IRUGO|S_IWUSR);
+MODULE_PARM_DESC(get_maxpacket0_tries,
+		 "retry times of get maxpacket0 for each port initialization");
+
 static bool use_new_scheme(struct usb_device *udev, int retry,
 			   struct usb_port *port_dev)
 {
@@ -2965,7 +2986,7 @@ static int hub_port_reset(struct usb_hub *hub, int port1,
 	clear_bit(port1, hub->warm_reset_bits);
 
 	/* Reset the port */
-	for (i = 0; i < PORT_RESET_TRIES; i++) {
+	for (i = 0; i < port_reset_tries; i++) {
 		status = set_port_feature(hub->hdev, port1, (warm ?
 					USB_PORT_FEAT_BH_PORT_RESET :
 					USB_PORT_FEAT_RESET));
@@ -2989,7 +3010,7 @@ static int hub_port_reset(struct usb_hub *hub, int port1,
 		 * reset attempts to avoid warm reset loop.
 		 */
 		if (status == 0 || status == -ENOTCONN || status == -ENODEV ||
-		    (status == -EBUSY && i == PORT_RESET_TRIES - 1)) {
+		    (status == -EBUSY && i == port_reset_tries - 1)) {
 			usb_clear_port_feature(hub->hdev, port1,
 					USB_PORT_FEAT_C_RESET);
 
@@ -4788,7 +4809,7 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
 	 */
 	do_new_scheme = use_new_scheme(udev, retry_counter, port_dev);
 
-	for (retries = 0; retries < GET_DESCRIPTOR_TRIES; (++retries, msleep(100))) {
+	for (retries = 0; retries < get_descriptor_tries; (++retries, msleep(100))) {
 		if (do_new_scheme) {
 			struct usb_device_descriptor *buf;
 			int r = 0;
@@ -4812,7 +4833,7 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
 			 * 255 is for WUSB devices, we actually need to use
 			 * 512 (WUSB1.0[4.8.1]).
 			 */
-			for (operations = 0; operations < GET_MAXPACKET0_TRIES;
+			for (operations = 0; operations < get_maxpacket0_tries;
 					++operations) {
 				buf->bMaxPacketSize0 = 0;
 				r = usb_control_msg(udev, usb_rcvaddr0pipe(),
@@ -4873,7 +4894,7 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
 		 * authorization will assign the final address.
 		 */
 		if (udev->wusb == 0) {
-			for (operations = 0; operations < SET_ADDRESS_TRIES; ++operations) {
+			for (operations = 0; operations < set_address_tries; ++operations) {
 				retval = hub_set_address(udev, devnum);
 				if (retval >= 0)
 					break;
-- 
2.36.1.476.g0c4daa206d-goog

