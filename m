Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECCA5485F8D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 05:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbiAFENQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 23:13:16 -0500
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:35978
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232228AbiAFENP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 23:13:15 -0500
Received: from localhost.localdomain (1-171-96-105.dynamic-ip.hinet.net [1.171.96.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 2CF1340004;
        Thu,  6 Jan 2022 04:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641442387;
        bh=VoTmhA7NUUNc/uB6IQmih/xqmEaFhzeTWWfbBBkxzE8=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=L0EeAUCh4cxxC4lGY96cC7jA9vng84AuWvDi7RM5X44onf8Y5/5P8Xic8c4N9Xx/q
         fD7NdtuLwfTqfLuQuuthnKb+nh4xuc0doeo4j5P7vuYIhkHMdFh1PqSoroBBbJSO3g
         feOYuNMsoDBzJzEyw7DgB1mz2FwxNAh8fHQai1SZ1etDILiYbep4DLIf/ZYjlzFbcw
         P3oFs9jh7j5162vj/04a08h38cBf0PYWdYglRNDJVsllRZ8ohACZ/Isnm668JOL/+x
         cQQjjfmPkpWn28cgPtWoDkLd/cpko2NrMxonxz0jGBkqD7sn/2i+ViSicZCFlD67al
         r5c0crFtz1QWw==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     andy.shevchenko@gmail.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Chris Lesiak <chris.lesiak@licor.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: humidity: hdc100x: Add ACPI HID table
Date:   Thu,  6 Jan 2022 12:12:56 +0800
Message-Id: <20220106041257.927664-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86 boards may use ACPI HID "TXN1010" to for hdc100x device.

So add an ACPI match table for that accordingly.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 - Change the ID to follow ACPI Spec
 - Add __maybe_unused to avoid compiler warning

 drivers/iio/humidity/hdc100x.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index 9e0fce917ce4c..c6c71ca1d2017 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -417,10 +417,18 @@ static const struct of_device_id hdc100x_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, hdc100x_dt_ids);
 
+static const struct acpi_device_id __maybe_unused hdc100x_acpi_match[] = {
+	{ "TXN1010" },
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

