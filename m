Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D0F467503
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 11:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379984AbhLCKeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 05:34:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24581 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1379910AbhLCKeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 05:34:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638527445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IMavGNvu5wFmxKWM0KE0C+p4tifWbktsl3rkj44Z1jw=;
        b=BGoMmhHlhhON29Hk9/RGVuMOrLfbJQ0bynTBWI1mEAp9pRWenikSw2Y99Ig2f7aVUOOysn
        t/4SsMCSGyFIMcX+tuuFLGBlcvoDvi7KNaYRFy+ZXBZdFJatZ8hJNyNIPj2fDK3OMnnCl+
        aDmT3W7BfFyEw5AuwAPHCg6cRK32j/U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-414-WWSMjbvKNYuHWfrsR0HXog-1; Fri, 03 Dec 2021 05:30:41 -0500
X-MC-Unique: WWSMjbvKNYuHWfrsR0HXog-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4310183DD20;
        Fri,  3 Dec 2021 10:30:39 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5240B60843;
        Fri,  3 Dec 2021 10:30:35 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Kate Hsuan <hpa@redhat.com>, linux-media@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v7 09/14] platform/x86: int3472: Pass tps68470_clk_platform_data to the tps68470-regulator MFD-cell
Date:   Fri,  3 Dec 2021 11:28:52 +0100
Message-Id: <20211203102857.44539-10-hdegoede@redhat.com>
In-Reply-To: <20211203102857.44539-1-hdegoede@redhat.com>
References: <20211203102857.44539-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass tps68470_clk_platform_data to the tps68470-clk MFD-cell,
so that sensors which use the TPS68470 can find their clock.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v5:
- Add TPS68470_WIN_MFD_CELL_COUNT define

Changes in v4:
- Update the comment about the cell ordering

Changes in v2:
- Put the GPIO cell last because acpi_gpiochip_add() calls
  acpi_dev_clear_dependencies() and the clk + regulators must
  be ready when this happens.
---
 drivers/platform/x86/intel/int3472/tps68470.c | 35 +++++++++++++++----
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/tps68470.c b/drivers/platform/x86/intel/int3472/tps68470.c
index fd3bef449137..d0a3659a34ea 100644
--- a/drivers/platform/x86/intel/int3472/tps68470.c
+++ b/drivers/platform/x86/intel/int3472/tps68470.c
@@ -5,6 +5,7 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/tps68470.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/tps68470.h>
 #include <linux/regmap.h>
 
 #include "common.h"
@@ -12,17 +13,13 @@
 #define DESIGNED_FOR_CHROMEOS		1
 #define DESIGNED_FOR_WINDOWS		2
 
+#define TPS68470_WIN_MFD_CELL_COUNT	3
+
 static const struct mfd_cell tps68470_cros[] = {
 	{ .name = "tps68470-gpio" },
 	{ .name = "tps68470_pmic_opregion" },
 };
 
-static const struct mfd_cell tps68470_win[] = {
-	{ .name = "tps68470-gpio" },
-	{ .name = "tps68470-clk" },
-	{ .name = "tps68470-regulator" },
-};
-
 static const struct regmap_config tps68470_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -98,10 +95,17 @@ static int skl_int3472_tps68470_calc_type(struct acpi_device *adev)
 static int skl_int3472_tps68470_probe(struct i2c_client *client)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&client->dev);
+	struct tps68470_clk_platform_data clk_pdata = {};
+	struct mfd_cell *cells;
 	struct regmap *regmap;
 	int device_type;
 	int ret;
 
+	ret = skl_int3472_get_sensor_adev_and_name(&client->dev, NULL,
+						   &clk_pdata.consumer_dev_name);
+	if (ret)
+		return ret;
+
 	regmap = devm_regmap_init_i2c(client, &tps68470_regmap_config);
 	if (IS_ERR(regmap)) {
 		dev_err(&client->dev, "Failed to create regmap: %ld\n", PTR_ERR(regmap));
@@ -119,9 +123,26 @@ static int skl_int3472_tps68470_probe(struct i2c_client *client)
 	device_type = skl_int3472_tps68470_calc_type(adev);
 	switch (device_type) {
 	case DESIGNED_FOR_WINDOWS:
+		cells = kcalloc(TPS68470_WIN_MFD_CELL_COUNT, sizeof(*cells), GFP_KERNEL);
+		if (!cells)
+			return -ENOMEM;
+
+		/*
+		 * The order of the cells matters here! The clk must be first
+		 * because the regulator depends on it. The gpios must be last,
+		 * acpi_gpiochip_add() calls acpi_dev_clear_dependencies() and
+		 * the clk + regulators must be ready when this happens.
+		 */
+		cells[0].name = "tps68470-clk";
+		cells[0].platform_data = &clk_pdata;
+		cells[0].pdata_size = sizeof(clk_pdata);
+		cells[1].name = "tps68470-regulator";
+		cells[2].name = "tps68470-gpio";
+
 		ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
-					   tps68470_win, ARRAY_SIZE(tps68470_win),
+					   cells, TPS68470_WIN_MFD_CELL_COUNT,
 					   NULL, 0, NULL);
+		kfree(cells);
 		break;
 	case DESIGNED_FOR_CHROMEOS:
 		ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
-- 
2.33.1

