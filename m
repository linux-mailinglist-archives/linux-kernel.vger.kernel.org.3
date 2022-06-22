Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC93A5542DB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 08:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbiFVGVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346528AbiFVGVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:21:36 -0400
Received: from mail-m975.mail.163.com (mail-m975.mail.163.com [123.126.97.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A5B02F380;
        Tue, 21 Jun 2022 23:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=UD322
        BUk78+thKcSE3P4/OwKjkRfw/qsc7uMSsGIU4M=; b=Jc8j3JlttaHNFZdijmVL+
        Ag1wnn5iPSIoQxuTjAWr1BE9hxM2c5v7bDZ4+EzHi/wbolAMV9FiOEFE+yK3rpcr
        vPDnwLuIvXM8UZpCNqJrPM39h25ZKe/c+xpFoURYHUDIUM8FgM/7CyRVs8NeXIYX
        J1sPh9PtcRjVznPi+dbUHo=
Received: from localhost.localdomain (unknown [112.97.63.176])
        by smtp5 (Coremail) with SMTP id HdxpCgDHWhLctLJiJI2+KQ--.3868S2;
        Wed, 22 Jun 2022 14:21:18 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Slark Xiao <slark_xiao@163.com>
Subject: [PATCH v2] USB: serial: use kmemdup instead of kmalloc + memcpy
Date:   Wed, 22 Jun 2022 14:21:13 +0800
Message-Id: <20220622062113.8762-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HdxpCgDHWhLctLJiJI2+KQ--.3868S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFyrWw15Xry8Kw17XrWxCrg_yoW5XrykpF
        4Fgayjqr18tr13Xr1DCrs8Z3W5WanFgry2k347C3yavr43twnag3WxtF90gr10yr97Jr1S
        qw4v9rW0kF1xKw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRJ5r3UUUUU=
X-Originating-IP: [112.97.63.176]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCdQYoZGBbD9PNagAAs-
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For code neat purpose, we can use kmemdup to replace
kmalloc + memcpy.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
v2: Add garmin_gps.c
---
 drivers/usb/serial/garmin_gps.c | 4 +---
 drivers/usb/serial/opticon.c    | 4 +---
 drivers/usb/serial/sierra.c     | 4 +---
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/serial/garmin_gps.c b/drivers/usb/serial/garmin_gps.c
index e5c75944ebb7..f1a8d8343623 100644
--- a/drivers/usb/serial/garmin_gps.c
+++ b/drivers/usb/serial/garmin_gps.c
@@ -988,7 +988,7 @@ static int garmin_write_bulk(struct usb_serial_port *port,
 	garmin_data_p->flags &= ~FLAGS_DROP_DATA;
 	spin_unlock_irqrestore(&garmin_data_p->lock, flags);
 
-	buffer = kmalloc(count, GFP_ATOMIC);
+	buffer = kmemdup(buf, count, GFP_ATOMIC);
 	if (!buffer)
 		return -ENOMEM;
 
@@ -998,8 +998,6 @@ static int garmin_write_bulk(struct usb_serial_port *port,
 		return -ENOMEM;
 	}
 
-	memcpy(buffer, buf, count);
-
 	usb_serial_debug_data(&port->dev, __func__, count, buffer);
 
 	usb_fill_bulk_urb(urb, serial->dev,
diff --git a/drivers/usb/serial/opticon.c b/drivers/usb/serial/opticon.c
index aed28c35caff..bca6766a63e6 100644
--- a/drivers/usb/serial/opticon.c
+++ b/drivers/usb/serial/opticon.c
@@ -208,7 +208,7 @@ static int opticon_write(struct tty_struct *tty, struct usb_serial_port *port,
 	priv->outstanding_bytes += count;
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	buffer = kmalloc(count, GFP_ATOMIC);
+	buffer = kmemdup(buf, count, GFP_ATOMIC);
 	if (!buffer)
 		goto error_no_buffer;
 
@@ -216,8 +216,6 @@ static int opticon_write(struct tty_struct *tty, struct usb_serial_port *port,
 	if (!urb)
 		goto error_no_urb;
 
-	memcpy(buffer, buf, count);
-
 	usb_serial_debug_data(&port->dev, __func__, count, buffer);
 
 	/* The connected devices do not have a bulk write endpoint,
diff --git a/drivers/usb/serial/sierra.c b/drivers/usb/serial/sierra.c
index 9d56138133a9..865d1237d611 100644
--- a/drivers/usb/serial/sierra.c
+++ b/drivers/usb/serial/sierra.c
@@ -453,7 +453,7 @@ static int sierra_write(struct tty_struct *tty, struct usb_serial_port *port,
 		goto error_simple;
 	}
 
-	buffer = kmalloc(writesize, GFP_ATOMIC);
+	buffer = kmemdup(buf, writesize, GFP_ATOMIC);
 	if (!buffer) {
 		retval = -ENOMEM;
 		goto error_no_buffer;
@@ -465,8 +465,6 @@ static int sierra_write(struct tty_struct *tty, struct usb_serial_port *port,
 		goto error_no_urb;
 	}
 
-	memcpy(buffer, buf, writesize);
-
 	usb_serial_debug_data(&port->dev, __func__, writesize, buffer);
 
 	usb_fill_bulk_urb(urb, serial->dev,
-- 
2.25.1

