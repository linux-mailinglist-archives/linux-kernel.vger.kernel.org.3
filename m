Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A7547C6C8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241478AbhLUSmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:42:01 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36050 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241443AbhLUSl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:41:59 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id B6D7D1F42F50
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1640112117; bh=Cj5O9TiD4i4HSRN+fjhO1sKRr/R9ttPdi5PW9xYEaLY=;
        h=Date:From:To:Cc:Subject:From;
        b=Qpks0xHoub/2hdHjXqHjJNQq5L42GE3pxdVulYANco8hCdF8szEEvxnu7xNATxXsQ
         56qmKX11QMw3gl9zd+ld6/+i4hSGwEkOWtilV+G8E8RfuflE/J4xHuRE6AUmD0nR4j
         m9yAkotM01pqH3wNIV8qrUTPqiEsJxBRgX0iXjW/BbExNSjbQR5VWuuYoPnbJYFgUA
         Rmgljyg6Om943/Wri0tD2Ccx5MtOfRmMCDY105oWEcyzkZx1nDBAcY7n7yQGudTdzk
         MOrxY5KFIBmk40a0p7cmNCiVRoJBvapNLqYFe49dMdPC3rXskxd4c0JjaMqi0YNL7W
         QdzLNXn+VIUaQ==
Date:   Tue, 21 Dec 2021 23:41:51 +0500
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, kernel@collabora.com
Cc:     usama.anjum@collabora.com
Subject: [PATCH] serial: lantiq: store and compare return status correctly
Message-ID: <YcIf7+oSWWn34ND6@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq() returns signed status. It should be stored and
compared as signed value before storing to unsigned variable. Implicit
conversion from signed to unsigned and then comparison with less than
zero is wrong as unsigned value can never be less than zero.

Fixes: f087f01ca2 ("serial: lantiq: Use platform_get_irq() to get the interrupt")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 drivers/tty/serial/lantiq.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index bb059418cb82..3e324d3f0a6d 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -727,16 +727,20 @@ static int fetch_irq_lantiq(struct device *dev, struct ltq_uart_port *ltq_port)
 {
 	struct uart_port *port = &ltq_port->port;
 	struct platform_device *pdev = to_platform_device(dev);
-
-	ltq_port->tx_irq = platform_get_irq(pdev, 0);
-	if (ltq_port->tx_irq < 0)
-		return ltq_port->tx_irq;
-	ltq_port->rx_irq = platform_get_irq(pdev, 1);
-	if (ltq_port->rx_irq < 0)
-		return ltq_port->rx_irq;
-	ltq_port->err_irq = platform_get_irq(pdev, 2);
-	if (ltq_port->err_irq < 0)
-		return ltq_port->err_irq;
+	int irq;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+	ltq_port->tx_irq = irq;
+	irq = platform_get_irq(pdev, 1);
+	if (irq < 0)
+		return irq;
+	ltq_port->rx_irq = irq;
+	irq = platform_get_irq(pdev, 2);
+	if (irq < 0)
+		return irq;
+	ltq_port->err_irq = irq;
 
 	port->irq = ltq_port->tx_irq;
 
-- 
2.30.2

