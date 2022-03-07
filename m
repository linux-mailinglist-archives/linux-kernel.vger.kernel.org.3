Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDC54D0569
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 18:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244481AbiCGRj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 12:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239529AbiCGRjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 12:39:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 149FA674D5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 09:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646674738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=46pEUNpPjV9h0UwihFSj1hDgq4vttxDft/K1VE8xIbs=;
        b=egK3+FIOwNWK2DkjxIZDplov5Y6rCHu8txFOsgaL2uIsfCa9j3ml7tOQpxJgEMBOZ26S2M
        XvOPlBI2Yo3I9s51tsHjII8DgiI9d1jWfkVW2E6l8n0Tl0lw+Kyj0w0NfyZU5d/qPEAEds
        dAkzR3+Y43bgiPQgb19ogNogcQmN15U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-c_DVoAzrOlaj8565tvaBXg-1; Mon, 07 Mar 2022 12:38:55 -0500
X-MC-Unique: c_DVoAzrOlaj8565tvaBXg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20EA58145F6;
        Mon,  7 Mar 2022 17:38:54 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 05C0E825F6;
        Mon,  7 Mar 2022 17:38:52 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v2 2/2] mfd: arizona-spi: Add Android board ACPI table handling
Date:   Mon,  7 Mar 2022 18:38:44 +0100
Message-Id: <20220307173844.199135-2-hdegoede@redhat.com>
In-Reply-To: <20220307173844.199135-1-hdegoede@redhat.com>
References: <20220307173844.199135-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Wrap long dev_info_once() line
---
 drivers/mfd/arizona-spi.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
index 238355542ab1..ada5664aadd1 100644
--- a/drivers/mfd/arizona-spi.c
+++ b/drivers/mfd/arizona-spi.c
@@ -81,6 +81,30 @@ static int arizona_spi_acpi_windows_probe(struct arizona *arizona)
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
+			dev_info_once(arizona->dev,
+				      "Deferring probe till GPIO lookup is registered\n");
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
@@ -102,9 +126,14 @@ static const struct arizona_micd_range arizona_micd_aosp_ranges[] = {
 
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
 
@@ -142,6 +171,10 @@ static const struct acpi_device_id arizona_acpi_match[] = {
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

