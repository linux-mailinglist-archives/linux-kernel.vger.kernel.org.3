Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC8D49E4C7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242453AbiA0Oiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:38:46 -0500
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:47312
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242434AbiA0Oip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:38:45 -0500
Received: from HP-EliteBook-840-G7.. (1-171-96-243.dynamic-ip.hinet.net [1.171.96.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 0055B3F12E;
        Thu, 27 Jan 2022 14:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643294317;
        bh=UxowwXQxo8uCrhgoZW9r6sHJJUTYdeBxTU4y/n+UOSs=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=O+icSGTFIULmpaWrxo5DX5gHDl4G83Q2SCoQEnWdQ1HiRq+JISd8QEF70pYgXH74q
         A3dtSBOXpNdjtxCEMQjXbmvJ5c/OJletToRVgBDtliAtMhrhCq2gpLZ3ZuhI7SJFcO
         ODEowWwpWEvE8aFlI/zNBEXlymXCYMW/vNEKln0E+HnrtgTBVfS0BG6ARLP1mzpsk7
         FJrbioAn0l96D1l4IMBeIY2PXKABQQXRRyj1KGMUqMUlJa1kTcbi/cq0z4ZwXXVF4t
         z1cctLkEaBwzJnlG6F/2uVfK9xfqmY0KCCMp6sk0B7g0/n8jCNkw6cJG13F40E41sE
         r8LbaZWWZeCRQ==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     jic23@kernel.org, eajames@linux.ibm.com
Cc:     andy.shevchenko@gmail.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: dps310: Add ACPI HID table
Date:   Thu, 27 Jan 2022 22:38:28 +0800
Message-Id: <20220127143828.2033838-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86 boards may use ACPI HID "IFX3100" for dps310 device.

Vendor told us feel free to add the ID and contact
"Saumitra.Chafekar@infineon.com" for any further question.

So add an ACPI match table for that accordingly.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 - Drop ACPI_PTR().
 - Add info from vendor.

 drivers/iio/pressure/dps310.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 0730380ceb692..7e6fcb32212a2 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -812,9 +812,17 @@ static const struct i2c_device_id dps310_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, dps310_id);
 
+static const struct acpi_device_id dps310_acpi_match[] = {
+	{ "IFX3100" },
+	{ },
+};
+
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

