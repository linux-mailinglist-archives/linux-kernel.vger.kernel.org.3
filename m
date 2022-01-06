Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7874D485FFA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 05:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbiAFEoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 23:44:04 -0500
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:37256
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233603AbiAFEoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 23:44:02 -0500
Received: from localhost.localdomain (1-171-96-105.dynamic-ip.hinet.net [1.171.96.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id A496040CED;
        Thu,  6 Jan 2022 04:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641444241;
        bh=v1m8fDLVLBd2SowK4trAWWm+oRBVv5lqjh+ZEx1aNLc=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=RmpyxZtdWp1Wq/n1LbDNekvDiKsjET00jJuRuOLzUAvvTsaKfhoyup+DrdVP0n+o7
         Q0zawm92fdvfnkgDfgaQrYxQpEI2GzWNQuM/KgMHTFXAheu2qPwdxxR2RP7YbWIdHD
         5oEtEz47ruK91m1YmkBQKAFvF6TKGFdp95TPO5KrtAy+PW8xp8rDgXPXyEJpPG57Fk
         WqP4uJb285kCGEnrz1+NmcbuTxrKopAVt+Lmu7Ozfms1GcnnEMvk2NcytgKu7wrXlo
         SwbAqERWAE0Zz1mVH/c0FeFGVaZ9l90K+s49SumCq6RSmGjDwq/MGUE8HahPFJWY4y
         ZwA7bcYcUj4Gw==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     jic23@kernel.org, eajames@linux.ibm.com
Cc:     andy.shevchenko@gmail.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: dps310: Add ACPI HID table
Date:   Thu,  6 Jan 2022 12:43:50 +0800
Message-Id: <20220106044350.930087-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86 boards may use ACPI HID "IFX3100" to for dps310 device.

So add an ACPI match table for that accordingly.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/iio/pressure/dps310.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 0730380ceb692..ad5920b107e63 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -812,9 +812,17 @@ static const struct i2c_device_id dps310_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, dps310_id);
 
+static const struct acpi_device_id __maybe_unused dps310_acpi_match[] = {
+	{ "IFX3100" },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(acpi, dps310_acpi_match);
+
 static struct i2c_driver dps310_driver = {
 	.driver = {
 		.name = DPS310_DEV_NAME,
+		.acpi_match_table = ACPI_PTR(dps310_acpi_match),
 	},
 	.probe = dps310_probe,
 	.id_table = dps310_id,
-- 
2.33.1

