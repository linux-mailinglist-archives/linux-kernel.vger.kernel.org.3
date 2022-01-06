Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A798486054
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 06:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbiAFFi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 00:38:26 -0500
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:57654
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229585AbiAFFiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 00:38:25 -0500
Received: from localhost.localdomain (1-171-96-105.dynamic-ip.hinet.net [1.171.96.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 35CC84180B;
        Thu,  6 Jan 2022 05:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641447502;
        bh=VFPnjyGA8KT3/d3k6C88vvQofrPmfZPMjkzS1LX4Z+M=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=HZ2bPcM5rzTQdkjq5th1YkExFj8JYtIE6EkcAIjZiQU+PYLhn1fQ97q+m55h6fss8
         X/HRHNDbq9lz9lyn4HT+aN0vHPpOSKzCVQFo3Sv+8msxDr1Cyx+aMG/hG7AX++z4N1
         KEBuojRpt68babypbpjbb9ksl24pYQIJ3Ply++OUey4fU9YUPLfwee8qRmJJYm8WyV
         Df0o1qPoMgvY5vN2IYPVG049IktIwkYhqywg4Zp95bHFYySjxNqSQkgqp2tiMo2hA8
         d3QPKxl5/nWE4rnIEFzCWANhk45+9AYA7bHtSWQ3O03b0fxvO3HJ1rpIESrPk9G2nA
         tomexindCv4Ug==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     dmitry.torokhov@gmail.com
Cc:     andy.shevchenko@gmail.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: adxl34x: Add ACPI HID table
Date:   Thu,  6 Jan 2022 13:38:09 +0800
Message-Id: <20220106053810.934797-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86 boards may use ACPI HID "ADS0345" to for adxl34x device.

So add an ACPI match table for that accordingly.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/input/misc/adxl34x-i2c.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/misc/adxl34x-i2c.c b/drivers/input/misc/adxl34x-i2c.c
index a3b5f88d2bd16..a0b61598204db 100644
--- a/drivers/input/misc/adxl34x-i2c.c
+++ b/drivers/input/misc/adxl34x-i2c.c
@@ -155,11 +155,19 @@ static const struct of_device_id adxl34x_of_id[] = {
 
 MODULE_DEVICE_TABLE(of, adxl34x_of_id);
 
+static const struct acpi_device_id __maybe_unused adxl34x_acpi_match[] = {
+	{ "ADS0345" },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(acpi, adxl34x_acpi_match);
+
 static struct i2c_driver adxl34x_driver = {
 	.driver = {
 		.name = "adxl34x",
 		.pm = &adxl34x_i2c_pm,
 		.of_match_table = adxl34x_of_id,
+		.acpi_match_table = ACPI_PTR(adxl34x_acpi_match),
 	},
 	.probe    = adxl34x_i2c_probe,
 	.remove   = adxl34x_i2c_remove,
-- 
2.33.1

