Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505D549F330
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 06:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346260AbiA1F4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 00:56:17 -0500
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:35130
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346225AbiA1F4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 00:56:14 -0500
Received: from HP-EliteBook-840-G7.. (1-171-96-243.dynamic-ip.hinet.net [1.171.96.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 339883F12B;
        Fri, 28 Jan 2022 05:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643349372;
        bh=Tshv0TyO58WClmGnYE2ODBajptl6oxBsRhlmsTvACWk=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=YKRz2hBuOjso8OWmvwFXdZDIGtERcc82yQqQOLZeuirLlA4+CE7yRnCMEAQmBeOc1
         3uqBbtL9CIi/P4sy7BTySmwu7tC6ley09FJcSE6prjOBr8lth/fHUgj87lZ92umN2G
         8kdnlByxBC88uCwrivgxjOnSq3RzPFRQ7wtRrTCdqi0eka9iQXkjnR6GfR9bc5uYl7
         DtpvPdd2De3C2/UMcuwBEyUbO8vM04955oq7mNYRb4qq537Iz1DFJZ33cUfepdE+91
         8Of2SiICQc5D033WyEwA/kyLpVeMOYHQypn2v5evE5Hvilm5e9d52k/NwU9QYQ2iah
         JCnZo/eki+MJQ==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     dmitry.torokhov@gmail.com
Cc:     andy.shevchenko@gmail.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] Input: adxl34x: Add ACPI HID table
Date:   Fri, 28 Jan 2022 13:56:01 +0800
Message-Id: <20220128055604.2077738-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86 boards may use ACPI HID "ADS0345" for adxl34x device.

Analog replied:
"ADS034X is not a valid PNP ID. ADS0345 would be.
I'm not aware that this ID is already taken.
Feel free to submit a mainline Linux input mailing list patch."

So add an ACPI match table for that accordingly.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 - Drop ACPI_PTR()
 - Drop redundant empty line and comma
 - Add info from vendor

 drivers/input/misc/adxl34x-i2c.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/misc/adxl34x-i2c.c b/drivers/input/misc/adxl34x-i2c.c
index a3b5f88d2bd16..b9af581cde800 100644
--- a/drivers/input/misc/adxl34x-i2c.c
+++ b/drivers/input/misc/adxl34x-i2c.c
@@ -155,11 +155,18 @@ static const struct of_device_id adxl34x_of_id[] = {
 
 MODULE_DEVICE_TABLE(of, adxl34x_of_id);
 
+static const struct acpi_device_id adxl34x_acpi_match[] = {
+	{ "ADS0345" },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, adxl34x_acpi_match);
+
 static struct i2c_driver adxl34x_driver = {
 	.driver = {
 		.name = "adxl34x",
 		.pm = &adxl34x_i2c_pm,
 		.of_match_table = adxl34x_of_id,
+		.acpi_match_table = adxl34x_acpi_match,
 	},
 	.probe    = adxl34x_i2c_probe,
 	.remove   = adxl34x_i2c_remove,
-- 
2.33.1

