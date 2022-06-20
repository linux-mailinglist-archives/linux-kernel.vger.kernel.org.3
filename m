Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F973551677
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241091AbiFTK77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240411AbiFTK76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:59:58 -0400
Received: from mail-m975.mail.163.com (mail-m975.mail.163.com [123.126.97.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52722273F;
        Mon, 20 Jun 2022 03:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=s/DqW
        3JifVc3jI4z9atXF9bTKKNtQPalK25TvRQSEOc=; b=GfO7bK1ypzGSVHbX3BE/u
        FAB6h4hC8I7D+4oAxmCiNTpHZY2VAEFKeu5Jww2m001zbjfzPrWSnqXyONcCrV0b
        OHKH9mj0HfCqYfvC11XTBT0Ibp8XPBxp2PWoT/SmnIM/BF06dGkwv1U/5kZAw8+e
        70cl/2NafDJMnxnbcvVPp4=
Received: from localhost.localdomain (unknown [112.97.57.116])
        by smtp5 (Coremail) with SMTP id HdxpCgAHAi4cU7BiaJhjKA--.6065S2;
        Mon, 20 Jun 2022 18:59:42 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] USB: serial: use kmemdup instead of kmalloc + memcpy
Date:   Mon, 20 Jun 2022 18:59:39 +0800
Message-Id: <20220620105939.5128-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HdxpCgAHAi4cU7BiaJhjKA--.6065S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFyUKrW8WF45Zw4kWrWxZwb_yoW8CryDpF
        4Yg3yqqr10qr1fXr1DCws8Za45WanrKFy2k347C3yavr13tw1Sg3WIqFWYqr1UCF97Jw1a
        qw4v9rWvkr47tw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRHlkhUUUUU=
X-Originating-IP: [112.97.57.116]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbivx4mZFWB0C2ffQAAso
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
 drivers/usb/serial/opticon.c | 4 +---
 drivers/usb/serial/sierra.c  | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

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

