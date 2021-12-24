Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4EE447EFBE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 15:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353025AbhLXO7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 09:59:19 -0500
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:37220
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352999AbhLXO7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 09:59:19 -0500
Received: from HP-EliteBook-840-G7.. (1-171-246-32.dynamic-ip.hinet.net [1.171.246.32])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 713B241933;
        Fri, 24 Dec 2021 14:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640357951;
        bh=4tETf+TR8k8tlTxIJMQAaz/Rs8+Y89BnDyFUfMAEh7Y=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=ulMIx2vxVYEnqITGTCNkYFpP/y6VvlrufJI+hv1Vhfud0HwBeTN3SjrdipkHJK6PV
         RQyGwsrva9bqxHUiruniysMoti47KOZApBSm9kFDZfcrrZitqpKvDgCdsKAE5Yiual
         K6YMem1RxqO+1LzZVU5tzLD36e8o324eB7vgi02pYraeUXkMPti2RZzQHIRKDzhdiD
         SgMqY9C85mGJC9ITeAi0OX/B3ixRyzfu/OBUw0tBNEFPbCei6OBdYuZciHm660eJO1
         cExG1HPtbWrurfR4zb3VpTsKJ5IkomzEiECrezMpj2ka+qamEbRVWP1Ct2hQHSg0PJ
         jgUik8fro6Ctg==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Chris Lesiak <chris.lesiak@licor.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: humidity: hdc100x: Add ACPI HID table
Date:   Fri, 24 Dec 2021 22:59:01 +0800
Message-Id: <20211224145903.368999-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86 boards may use ACPI HID "HDC1010" to for hdc100x device.

So add an ACPI match table for that accordingly.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/iio/humidity/hdc100x.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index 9e0fce917ce4c..ad1dfac543c52 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -417,10 +417,18 @@ static const struct of_device_id hdc100x_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, hdc100x_dt_ids);
 
+static const struct acpi_device_id hdc100x_acpi_match[] = {
+	{"HDC1010"},
+	{ },
+};
+
+MODULE_DEVICE_TABLE(acpi, hdc100x_acpi_match);
+
 static struct i2c_driver hdc100x_driver = {
 	.driver = {
 		.name	= "hdc100x",
 		.of_match_table = hdc100x_dt_ids,
+		.acpi_match_table = ACPI_PTR(hdc100x_acpi_match),
 	},
 	.probe = hdc100x_probe,
 	.id_table = hdc100x_id,
-- 
2.33.1

