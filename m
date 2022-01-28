Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27CDA49F267
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 05:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346025AbiA1EVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 23:21:08 -0500
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:54848
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346015AbiA1EVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 23:21:07 -0500
Received: from HP-EliteBook-840-G7.. (1-171-96-243.dynamic-ip.hinet.net [1.171.96.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id BFB783F051;
        Fri, 28 Jan 2022 04:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643343666;
        bh=O7UDFd+18p0T3OuGDq+A+rqg6kK6AeWCWRKy8LSYkF8=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=RtxYzINEOYgtJ4stMeISzvQFkojTvOGuWpI5614HGp2bzJWhHtFoSslQ3xH7Pij7g
         CPU75yahvtrGlA4VobFQ5fqRSa7TtlENHoJVMXzSbbCXl0WADRrXxAvd3unFSFV9F3
         xehtNkP2pbEhRDJzO1BEbzG9ZGGFdF5xsSpypl3DdYNMyTQtajDqmgpg1+qI1MxulW
         E7fznHZ4dKu0XjOs5ibmeigzb+M/ZjAI9gJO5c/aqUCcP5h1wdaMhGQfoJeYqqWu7k
         A6SEBRlJVSZmvjjuT9BvAmAkBLLdFxva61EAyJCgMTxOcgjPzIoaW/1CO54z/26zZ9
         OeafNlOib3R7w==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     andy.shevchenko@gmail.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Your Name <you@example.com>,
        Chris Lesiak <chris.lesiak@licor.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] iio: humidity: hdc100x: Add ACPI HID table
Date:   Fri, 28 Jan 2022 12:20:51 +0800
Message-Id: <20220128042054.2062060-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86 boards may use ACPI HID "TXNW1010" for the hdc100x device.

TI told us "The ACPI ID for TI is: https://uefi.org/node/1028 (TXNW),
therefore it would most likely be appropriate to use TXNW1010."

So add an ACPI match table for that accordingly.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v3:
 - Add info from vendor
 - Drop redundant line and comma.
 - Wording change.

v2:
 - Change the ID to follow ACPI Spec
 - Add __maybe_unused to avoid compiler warning
 
 drivers/iio/humidity/hdc100x.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index 9e0fce917ce4c..47f8e8ef56d68 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -417,10 +417,17 @@ static const struct of_device_id hdc100x_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, hdc100x_dt_ids);
 
+static const struct acpi_device_id hdc100x_acpi_match[] = {
+	{ "TXNW1010" },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, hdc100x_acpi_match);
+
 static struct i2c_driver hdc100x_driver = {
 	.driver = {
 		.name	= "hdc100x",
 		.of_match_table = hdc100x_dt_ids,
+		.acpi_match_table = hdc100x_acpi_match,
 	},
 	.probe = hdc100x_probe,
 	.id_table = hdc100x_id,
-- 
2.33.1

