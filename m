Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A8C4C1471
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 14:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241026AbiBWNnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 08:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241014AbiBWNnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 08:43:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E6667E08F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 05:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645623757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nrEfsZuwsjWuVlBFFkYGaMRJ/6UsClz6L7Lhouykops=;
        b=G/BIYgyu5ukx4xW4gAiGbPXXeljmmdiV/9R1Gqbp5UdZBMbDN1NODw50mWNy11AGpZ10Ov
        53/XnpcqZMIuvpvPYs0vTdfOSbge1kTZOv3SiV2RAbvj+xMrbjiXxOg7flGqhbFNtEIhgT
        jvU1NUUr5DSdl6guS8Vc0c8OdxNosr4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-371-zQcL41JvN3-yxFLJOnTLbw-1; Wed, 23 Feb 2022 08:42:34 -0500
X-MC-Unique: zQcL41JvN3-yxFLJOnTLbw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AD47804B8A;
        Wed, 23 Feb 2022 13:42:33 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.195.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1804427BC4;
        Wed, 23 Feb 2022 13:42:31 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mfd: arizona-spi: Add Android board ACPI table handling
Date:   Wed, 23 Feb 2022 14:42:22 +0100
Message-Id: <20220223134222.730886-2-hdegoede@redhat.com>
In-Reply-To: <20220223134222.730886-1-hdegoede@redhat.com>
References: <20220223134222.730886-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86/ACPI boards with an arizona WM5102 codec ship with either Windows or
Android as factory installed OS.

The ACPI fwnode for the codec on Android boards misses 2 things compared
to the Windows boards (this is hardcoded in the Android board kernels):

1. There is no CLKE ACPI method to enabe the 32 KHz clock the codec needs
   for jack-detection.

2. The GPIOs used by the codec are not listed in the fwnode for the codec.

The ACPI tables on x86/ACPI boards shipped with Android being incomplete
happens a lot. The special drivers/platform/x86/x86-android-tablets.c
module contains DMI based per model handling to compensate for this.

This module will enable the 32KHz clock through the pinctrl framework
to fix 1. and it will also register a gpio-lookup table for all GPIOs
needed by the codec + machine driver, including the GPIOs coming from
the codec itself.

Add an arizona_spi_acpi_android_probe() function which waits for the
x86-android-tablets to have set things up before continue with probing
the arizona WM5102 codec.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mfd/arizona-spi.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
index 238355542ab1..2c686e71db21 100644
--- a/drivers/mfd/arizona-spi.c
+++ b/drivers/mfd/arizona-spi.c
@@ -81,6 +81,29 @@ static int arizona_spi_acpi_windows_probe(struct arizona *arizona)
 	return 0;
 }
 
+/* For ACPI tables from boards which ship with Android as factory OS */
+static int arizona_spi_acpi_android_probe(struct arizona *arizona)
+{
+	int ret;
+
+	/*
+	 * Get the reset GPIO, treating -ENOENT as -EPROBE_DEFER to wait for
+	 * the x86-android-tablets module to register the board specific GPIO
+	 * lookup table.
+	 */
+	arizona->pdata.reset = devm_gpiod_get(arizona->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(arizona->pdata.reset)) {
+		ret = PTR_ERR(arizona->pdata.reset);
+		if (ret == -ENOENT) {
+			dev_info_once(arizona->dev, "Deferring probe till GPIO lookup is registered\n");
+			ret = -EPROBE_DEFER;
+		}
+		return dev_err_probe(arizona->dev, ret, "getting reset GPIO\n");
+	}
+
+	return 0;
+}
+
 /*
  * The AOSP 3.5 mm Headset: Accessory Specification gives the following values:
  * Function A Play/Pause:           0 ohm
@@ -102,9 +125,14 @@ static const struct arizona_micd_range arizona_micd_aosp_ranges[] = {
 
 static int arizona_spi_acpi_probe(struct arizona *arizona)
 {
+	struct acpi_device *adev = ACPI_COMPANION(arizona->dev);
 	int ret;
 
-	ret = arizona_spi_acpi_windows_probe(arizona);
+	if (acpi_dev_hid_uid_match(adev, "10WM5102", NULL))
+		ret = arizona_spi_acpi_android_probe(arizona);
+	else
+		ret = arizona_spi_acpi_windows_probe(arizona);
+
 	if (ret)
 		return ret;
 
@@ -142,6 +170,10 @@ static const struct acpi_device_id arizona_acpi_match[] = {
 		.id = "WM510205",
 		.driver_data = WM5102,
 	},
+	{
+		.id = "10WM5102",
+		.driver_data = WM5102,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, arizona_acpi_match);
-- 
2.35.1

