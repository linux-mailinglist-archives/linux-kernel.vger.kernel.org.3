Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BE14D0568
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 18:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244471AbiCGRjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 12:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241582AbiCGRjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 12:39:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D93F1673FB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 09:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646674737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TosqIFiPnV7cwciklztt4aZnSk/XwT0HTNB1Am1ZiPQ=;
        b=b9rtNeFq0dceXr/0q+AS+rr15f9DUfAsGZsTrATmT+9plEnTPmqG0HZHlAc+ThSinptWQ4
        P6CkgOT3Ywe+leo7ARf9n++LcdB3DDrBNSGLqui0LcUnfvaq3szqT4BdXi4tndyoI4jUV8
        fbmxvZHTFbIQp7IvippPo8TjE4PkVBo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-66-Ms13mSFFMn2z7cAHgEd3NA-1; Mon, 07 Mar 2022 12:38:53 -0500
X-MC-Unique: Ms13mSFFMn2z7cAHgEd3NA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1D5C800D55;
        Mon,  7 Mar 2022 17:38:52 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 91804825F6;
        Mon,  7 Mar 2022 17:38:51 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v2 1/2] mfd: arizona-spi: Split Windows ACPI init code into its own function
Date:   Mon,  7 Mar 2022 18:38:43 +0100
Message-Id: <20220307173844.199135-1-hdegoede@redhat.com>
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

The ACPI fwnode describing the codec differs depending on the factory OS,
and the current arizona_spi_acpi_probe() function is tailored for use
with the Windows board ACPI tables.

Split out the Windows board ACPI tables specific bits into a new
arizona_spi_acpi_windows_probe() function in preparation for also
adding support for the Android board ACPI tables.

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mfd/arizona-spi.c | 52 ++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
index 9fe06dda3782..238355542ab1 100644
--- a/drivers/mfd/arizona-spi.c
+++ b/drivers/mfd/arizona-spi.c
@@ -43,31 +43,13 @@ static const struct gpiod_lookup arizona_soc_gpios[] = {
 	{ "arizona", 4, "wlf,micd-pol", 0, GPIO_ACTIVE_LOW },
 };
 
-/*
- * The AOSP 3.5 mm Headset: Accessory Specification gives the following values:
- * Function A Play/Pause:           0 ohm
- * Function D Voice assistant:    135 ohm
- * Function B Volume Up           240 ohm
- * Function C Volume Down         470 ohm
- * Minimum Mic DC resistance     1000 ohm
- * Minimum Ear speaker impedance   16 ohm
- * Note the first max value below must be less then the min. speaker impedance,
- * to allow CTIA/OMTP detection to work. The other max values are the closest
- * value from extcon-arizona.c:arizona_micd_levels halfway 2 button resistances.
- */
-static const struct arizona_micd_range arizona_micd_aosp_ranges[] = {
-	{ .max =  11, .key = KEY_PLAYPAUSE },
-	{ .max = 186, .key = KEY_VOICECOMMAND },
-	{ .max = 348, .key = KEY_VOLUMEUP },
-	{ .max = 752, .key = KEY_VOLUMEDOWN },
-};
-
 static void arizona_spi_acpi_remove_lookup(void *lookup)
 {
 	gpiod_remove_lookup_table(lookup);
 }
 
-static int arizona_spi_acpi_probe(struct arizona *arizona)
+/* For ACPI tables from boards which ship with Windows as factory OS */
+static int arizona_spi_acpi_windows_probe(struct arizona *arizona)
 {
 	struct gpiod_lookup_table *lookup;
 	acpi_status status;
@@ -96,6 +78,36 @@ static int arizona_spi_acpi_probe(struct arizona *arizona)
 	if (ACPI_FAILURE(status))
 		dev_warn(arizona->dev, "Failed to enable 32KHz clk ACPI error %d\n", status);
 
+	return 0;
+}
+
+/*
+ * The AOSP 3.5 mm Headset: Accessory Specification gives the following values:
+ * Function A Play/Pause:           0 ohm
+ * Function D Voice assistant:    135 ohm
+ * Function B Volume Up           240 ohm
+ * Function C Volume Down         470 ohm
+ * Minimum Mic DC resistance     1000 ohm
+ * Minimum Ear speaker impedance   16 ohm
+ * Note the first max value below must be less then the min. speaker impedance,
+ * to allow CTIA/OMTP detection to work. The other max values are the closest
+ * value from extcon-arizona.c:arizona_micd_levels halfway 2 button resistances.
+ */
+static const struct arizona_micd_range arizona_micd_aosp_ranges[] = {
+	{ .max =  11, .key = KEY_PLAYPAUSE },
+	{ .max = 186, .key = KEY_VOICECOMMAND },
+	{ .max = 348, .key = KEY_VOLUMEUP },
+	{ .max = 752, .key = KEY_VOLUMEDOWN },
+};
+
+static int arizona_spi_acpi_probe(struct arizona *arizona)
+{
+	int ret;
+
+	ret = arizona_spi_acpi_windows_probe(arizona);
+	if (ret)
+		return ret;
+
 	/*
 	 * Some DSDTs wrongly declare the IRQ trigger-type as IRQF_TRIGGER_FALLING
 	 * The IRQ line will stay low when a new IRQ event happens between reading
-- 
2.35.1

