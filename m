Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53A04703FF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242936AbhLJPke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:40:34 -0500
Received: from marcansoft.com ([212.63.210.85]:34174 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242917AbhLJPk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:40:29 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 9889141E96;
        Fri, 10 Dec 2021 15:36:51 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Mark Brown <broonie@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joey Gouly <joey.gouly@arm.com>,
        Hector Martin <marcan@marcan.st>
Subject: [PATCH] spi: Fix incorrect cs_setup delay handling
Date:   Sat, 11 Dec 2021 00:36:34 +0900
Message-Id: <20211210153634.171580-1-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to wait *after* asserting CS and before the transfer, not before
asserting CS which isn't very useful.

Fixes: 25093bdeb6bc ("spi: implement SW control for CS times")
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/spi/spi.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b23e675953e1..cfb708d928b5 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -947,12 +947,9 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 	spi->controller->last_cs_enable = enable;
 	spi->controller->last_cs_mode_high = spi->mode & SPI_CS_HIGH;
 
-	if (spi->cs_gpiod || gpio_is_valid(spi->cs_gpio) ||
-	    !spi->controller->set_cs_timing) {
-		if (activate)
-			spi_delay_exec(&spi->cs_setup, NULL);
-		else
-			spi_delay_exec(&spi->cs_hold, NULL);
+	if ((spi->cs_gpiod || gpio_is_valid(spi->cs_gpio) ||
+	    !spi->controller->set_cs_timing) && !activate) {
+		spi_delay_exec(&spi->cs_hold, NULL);
 	}
 
 	if (spi->mode & SPI_CS_HIGH)
@@ -994,7 +991,9 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 
 	if (spi->cs_gpiod || gpio_is_valid(spi->cs_gpio) ||
 	    !spi->controller->set_cs_timing) {
-		if (!activate)
+		if (activate)
+			spi_delay_exec(&spi->cs_setup, NULL);
+		else
 			spi_delay_exec(&spi->cs_inactive, NULL);
 	}
 }
-- 
2.33.0

