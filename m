Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121D949F0FD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 03:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345376AbiA1CcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 21:32:01 -0500
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:42454
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345372AbiA1Cb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 21:31:59 -0500
Received: from HP-EliteBook-840-G7.. (1-171-96-243.dynamic-ip.hinet.net [1.171.96.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id B58A83F121;
        Fri, 28 Jan 2022 02:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643337112;
        bh=ak3Oxt3iNycYESnHxDsQ+83AZkvGg5OENtlmyREpgZE=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Y80Am/6CtgyJFjyuT8vipVoUifvtOnJVsFoxOF7Ull0v+zU0wcoRslU0RTZ7nw/Hq
         /w5cy/kYLIXOtuCrlear3ZrcoeXQoDoaXWKw9KmdYGOw2H35k6YUgd0h/FO+DT8/2e
         clG+4YXcTu9hQpmmPPLYaWkbE//dkL1+R7i6AXf6uEEkk1mlpWuOMF4/TyHAgd7e5n
         p37QQBMDdW4D1yeICweFzz46y5Xjv8QqFSopE+JKH8pXJZsjffoJTDzAgWj58LAKEj
         YiQyUcnkjmSCsvOm2a77X6eg/MkyuPqNnxMTX+c5pvTH/saD6sz3bmrZ2yyGVwUB6c
         QGd9M2N3t+KTg==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     jic23@kernel.org, eajames@linux.ibm.com
Cc:     andy.shevchenko@gmail.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] iio: dps310: Add ACPI HID table
Date:   Fri, 28 Jan 2022 10:31:44 +0800
Message-Id: <20220128023144.2050615-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86 boards may use ACPI HID "IFX3100" for the dps310 device.

Vendor told us feel free to add the ID and contact
"Saumitra.Chafekar@infineon.com" for further questions.

So add an ACPI match table for that accordingly.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v3:
 - Drop redundant line and comma.
 - Wording change.

v2:
 - Drop ACPI_PTR().
 - Add info from vendor.

 drivers/iio/pressure/dps310.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 0730380ceb692..36fb7ae0d0a9d 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -812,9 +812,16 @@ static const struct i2c_device_id dps310_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, dps310_id);
 
+static const struct acpi_device_id dps310_acpi_match[] = {
+	{ "IFX3100" },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, dps310_acpi_match);
+
 static struct i2c_driver dps310_driver = {
 	.driver = {
 		.name = DPS310_DEV_NAME,
+		.acpi_match_table = dps310_acpi_match,
 	},
 	.probe = dps310_probe,
 	.id_table = dps310_id,
-- 
2.33.1

