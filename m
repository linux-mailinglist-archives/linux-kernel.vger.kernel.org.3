Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2C0491D30
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 04:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352309AbiARD0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 22:26:45 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:18672 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355094AbiARDLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 22:11:00 -0500
Received: from droid06.amlogic.com (10.18.11.248) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Tue, 18 Jan 2022
 11:09:55 +0800
From:   Yu Tu <yu.tu@amlogic.com>
To:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yu Tu <yu.tu@amlogic.com>
Subject: [PATCH V6 2/5] tty: serial: meson: Use devm_ioremap_resource to get register mapped memory
Date:   Tue, 18 Jan 2022 11:09:08 +0800
Message-ID: <20220118030911.12815-3-yu.tu@amlogic.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220118030911.12815-1-yu.tu@amlogic.com>
References: <20220118030911.12815-1-yu.tu@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.18.11.248]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace devm_request_mem_region and devm_ioremap with
devm_ioremap_resource to make the code cleaner.

Signed-off-by: Yu Tu <yu.tu@amlogic.com>
---
 drivers/tty/serial/meson_uart.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 6b80e41b4cc1..7570958d010c 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -720,15 +720,7 @@ static int meson_uart_probe(struct platform_device *pdev)
 	if (!port)
 		return -ENOMEM;
 
-	if (!devm_request_mem_region(&pdev->dev, res_mem->start,
-				     resource_size(res_mem),
-				     dev_name(&pdev->dev))) {
-		dev_err(&pdev->dev, "Memory region busy\n");
-		return -EBUSY;
-	}
-
-	port->membase = devm_ioremap(&pdev->dev, res_mem->start,
-				     resource_size(res_mem));
+	port->membase = devm_ioremap_resource(&pdev->dev, res_mem);
 	if (IS_ERR(port->membase))
 		return PTR_ERR(port->membase);
 
-- 
2.33.1

