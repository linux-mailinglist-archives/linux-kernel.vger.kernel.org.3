Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0B34B8928
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 14:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbiBPNR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 08:17:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbiBPNRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 08:17:21 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C07B89301;
        Wed, 16 Feb 2022 05:17:07 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id DD9701F42AA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645017425;
        bh=p7+CS0xCcmyUFzMep4+88lkmuoBPrmA31v2eC0MyXcM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j3n/gC2pXyNBlrjKdS5OOEgH47AgeEJv5A0eypxPTdvhazZT8kRf4dUIy9GenscqK
         zW70QqkS9AW+uF9x5StOVWiDl9oAWVhmSJu6nz134CEMReYdL5AE84ZT0qm2OZ4Km8
         +3MIt++1eJGoV7/eLDhuva/KUIdwZUm05hcB5N1h7UFYNUYg8TBOpVKOxS7l6v/Oi+
         uLs1a8t48nmCgBYK+JJEDr+avH60OrqZpWJqOnu/L1sF46T7fd2johPKEWk2fCecsB
         36lDe77ruCiG9mWKtm+1HETNKsSTzVovr/fjxpWnRcAGg+KKjHj+hMGjPJFqEZV7n8
         wrCeul1u+V1Ow==
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v3 1/3] spi: amd: Use iopoll for busy waiting
Date:   Wed, 16 Feb 2022 10:16:36 -0300
Message-Id: <20220216131638.65472-2-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220216131638.65472-1-andrealmeid@collabora.com>
References: <20220216131638.65472-1-andrealmeid@collabora.com>
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
2.35.1

