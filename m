Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD0D4B6216
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 05:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbiBOEaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 23:30:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiBOEaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 23:30:16 -0500
X-Greylist: delayed 578 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 20:30:05 PST
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309BF1EC75;
        Mon, 14 Feb 2022 20:30:05 -0800 (PST)
Received: from HP-EliteBook-840-G7.. (36-229-230-216.dynamic-ip.hinet.net [36.229.230.216])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 772903FD31;
        Tue, 15 Feb 2022 04:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644898821;
        bh=lB41lf9TNfhSYVpxAjUTvqN1ehxl7mfDBhak18dB/Wc=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=EQ8mYpOF87s7mXaOkRfoxwrGwhyTNOSIjKZZomfa8VBQ1aMNXzWSSxxL75lV9uxw9
         oiu8PtTRQ6adXRL+SA0Mlf+WEcvTa2EMEhK/TIh1UrZ3lRzd2NiVtVT+g8fGn6jXBe
         AEVx/62NJVgpbWh5LOx42kkWgISLplTsEmKivnLLnucxybcs26ayr41FH+btZqxU65
         aXCgDTSTK+hkGvC13M8qg3rUfVsIGqL16hJoJ+uZWAAAXwA7hbckDxAJWGCDIj29Ce
         gdYNtSJ78I5EkqaVI6HP4Vqya6OviX280ZyR5GOOBB82nqreUmRnNkVZSoC948ndQv
         /kLOQ1QbCc2Fg==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org
Cc:     andy.shevchenko@gmail.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] iio: accel: adxl345: Add ACPI HID table
Date:   Tue, 15 Feb 2022 12:20:11 +0800
Message-Id: <20220215042011.2266897-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86 boards may use ACPI HID "ADS0345" for adxl345 device.

Analog replied:
"ADS034X is not a valid PNP ID. ADS0345 would be.
I'm not aware that this ID is already taken.
Feel free to submit a mainline Linux input mailing list patch."

So add an ACPI match table for that accordingly.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v3:
 - Convert the driver from input to iio.

v2:
 - Drop ACPI_PTR()
 - Drop redundant empty line and comma
 - Add info from vendor

 drivers/iio/accel/adxl345_i2c.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
index a431cba216e69..1d57050c775de 100644
--- a/drivers/iio/accel/adxl345_i2c.c
+++ b/drivers/iio/accel/adxl345_i2c.c
@@ -41,6 +41,7 @@ static int adxl345_i2c_probe(struct i2c_client *client,
 static const struct i2c_device_id adxl345_i2c_id[] = {
 	{ "adxl345", ADXL345 },
 	{ "adxl375", ADXL375 },
+	{ "ADS0345:00", ADXL345 },
 	{ }
 };
 
@@ -54,10 +55,17 @@ static const struct of_device_id adxl345_of_match[] = {
 
 MODULE_DEVICE_TABLE(of, adxl345_of_match);
 
+static const struct acpi_device_id adxl345_acpi_match[] = {
+	{ "ADS0345" },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, adxl345_acpi_match);
+
 static struct i2c_driver adxl345_i2c_driver = {
 	.driver = {
 		.name	= "adxl345_i2c",
 		.of_match_table = adxl345_of_match,
+		.acpi_match_table = adxl345_acpi_match,
 	},
 	.probe		= adxl345_i2c_probe,
 	.id_table	= adxl345_i2c_id,
-- 
2.34.1

