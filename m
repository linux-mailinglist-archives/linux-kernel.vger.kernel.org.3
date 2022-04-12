Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91FF4FE16C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354840AbiDLM71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355056AbiDLM5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:57:46 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBB9583A1;
        Tue, 12 Apr 2022 05:31:14 -0700 (PDT)
Received: from relay3-d.mail.gandi.net (unknown [217.70.183.195])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 215C4CF6E6;
        Tue, 12 Apr 2022 12:22:22 +0000 (UTC)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 530E560004;
        Tue, 12 Apr 2022 12:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649766138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yYar+EZz5N7PiDMFj3b3J7ixymPwvX8499KWau8exU8=;
        b=oapvIhjdGOscEhJufDW+Ov8FKM7b/3KQLJsXzxW+JBdJvZcIHz/Rn3A971azmySNHmlXlR
        dTsdpG6XZzEejvt/fD/kB0Wh3n2ILRWv3CuI2akVA8g4+UwWe791zApK6fjZLVz/OAL5cB
        r08yE0Y+enDC4q9My7eugN138dxjBSnubQEk0AociCTBUv4spDaNSoFySBk+y4ukjP6HCJ
        a1qNz5GHmyYFDKCa0F3Imktw4t8/f6ROb34QPSVF+7XZT1ruJynINb7kL7MElrxBVSk18T
        cKvXOUZSwB8G0w1eHijwoRGFoxrZE2X/aPJEXG7aK++8bnPkNJq8swuDu2gRsw==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH] spi: core: Only check bits_per_word validity when explicitly provided
Date:   Tue, 12 Apr 2022 14:22:07 +0200
Message-Id: <20220412122207.130181-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On SPI device probe, the core will call spi_setup in spi_add_device
before the corresponding driver was probed. When this happens, the
bits_per_word member of the device is not yet set by the driver,
resulting in the default being set to 8 bits-per-word.

However some controllers do not support 8 bits-per-word at all, which
results in a failure when checking the bits-per-word validity.

In order to support these devices, skip the bits-per-word validity
check when it is not explicitly provided by drivers.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/spi/spi.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 2e6d6bbeb784..563a56ce34a0 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3518,13 +3518,18 @@ int spi_setup(struct spi_device *spi)
 		return -EINVAL;
 	}
 
-	if (!spi->bits_per_word)
+	if (!spi->bits_per_word) {
 		spi->bits_per_word = 8;
-
-	status = __spi_validate_bits_per_word(spi->controller,
-					      spi->bits_per_word);
-	if (status)
-		return status;
+	} else {
+		/*
+		 * Some controllers may not support the default 8 bits-per-word
+		 * so only perform the check when this is explicitly provided.
+		 */
+		status = __spi_validate_bits_per_word(spi->controller,
+						      spi->bits_per_word);
+		if (status)
+			return status;
+	}
 
 	if (spi->controller->max_speed_hz &&
 	    (!spi->max_speed_hz ||
-- 
2.35.1

