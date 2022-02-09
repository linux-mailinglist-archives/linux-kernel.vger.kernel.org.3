Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22314AF753
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237569AbiBIQ5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237550AbiBIQ5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:57:51 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73070C0613C9;
        Wed,  9 Feb 2022 08:57:54 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id E07041F44E10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644425873;
        bh=gDeJVriYJKox6JwOjdk2huzH6vrKOPc2eK3IYUX/B7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YsI2gsJwgYNIrBTMfbLCFTCFvEEIJoTTWI53JxX0v19jd6k1Z7niBc/UkPLc6fHYE
         5tXt7xk/aQb7jfnXkXNX7A/IF2davQRZ49Q7wpz7kYJKN83ukuqTr7v+wP5L6SXE/+
         EGifGGaNipaJj1UB6AvxV7NGZ/pnHvr72C7UsI1MWcDQVrzbRGBqKk+B4GLBk9TDX4
         CNfro9r5SXDEcZMzlFJYPM1mSLK6S8DDB58CiGW98q5k1AYsvBS/Lso51tChO7iVz9
         E2e1rvITB1IGFHemUUFvKawOjCmLnQjVkcCK1rU1x6cnFCGQvjRg9YgU1LDYLPGKIG
         Vzk8yWa7y33dw==
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 1/3] spi: amd: Use iopoll for busy waiting
Date:   Wed,  9 Feb 2022 13:57:31 -0300
Message-Id: <20220209165733.43134-2-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220209165733.43134-1-andrealmeid@collabora.com>
References: <20220209165733.43134-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of implementing a custom IO busy wait function, just use
readl_poll_timeout().

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 drivers/spi/spi-amd.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 4b3ac7aceaf6..899b8d90ff61 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -12,6 +12,7 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/spi/spi.h>
+#include <linux/iopoll.h>
 
 #define AMD_SPI_CTRL0_REG	0x00
 #define AMD_SPI_EXEC_CMD	BIT(16)
@@ -103,16 +104,10 @@ static inline void amd_spi_set_tx_count(struct amd_spi *amd_spi, u8 tx_count)
 
 static int amd_spi_busy_wait(struct amd_spi *amd_spi)
 {
-	int timeout = 100000;
+	u32 val;
 
-	/* poll for SPI bus to become idle */
-	while (amd_spi_readreg32(amd_spi, AMD_SPI_CTRL0_REG) & AMD_SPI_BUSY) {
-		usleep_range(10, 20);
-		if (timeout-- < 0)
-			return -ETIMEDOUT;
-	}
-
-	return 0;
+	return readl_poll_timeout(amd_spi->io_remap_addr + AMD_SPI_CTRL0_REG,
+				  val, !(val & AMD_SPI_BUSY), 20, 2000000);
 }
 
 static int amd_spi_execute_opcode(struct amd_spi *amd_spi)
-- 
2.35.0

