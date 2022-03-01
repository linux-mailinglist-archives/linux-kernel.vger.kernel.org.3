Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D534C927B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 19:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236800AbiCASC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 13:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236785AbiCASCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:02:23 -0500
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC123F336;
        Tue,  1 Mar 2022 10:01:41 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [80.241.60.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4K7Q6q4LcMz9sTM;
        Tue,  1 Mar 2022 19:01:39 +0100 (CET)
From:   Marcello Sylvester Bauer <sylv@sylv.io>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1646157697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gd09qvc3Z6SaSzk9E+3whnDKKoWn8INGP5nwCpQZBzc=;
        b=bbXmRNKtow7THbBZJ9jfYyKdAauLCgEs2w2wPE8J5bo047Totoh42oZvmq7DwdXIZ/KRMu
        w6YRKnkr8kuOrA4bVJXxBL3An4fcNJ36iHsZcXTv9gS/2VJdeXPxD1cSkFQz4reF6aKuCu
        rW19d4klWcXG8MQx8QLXq91XxEDPKR/5Rrq6Rglfln5wKK+SdlmMSX3GJbIcVdYSJ+Dc5Q
        FO7fjt4iULPBLZoFRE3UOop5jtFP4Uvp8+KZ7H/ky1IKS3yIuhl4oAl7SNY6WZg5mE0PSm
        HK2knAiDOrsNgujMtWOitL9oe6OxxpXpOyud/WCE47iI9fmLZDHJwBNX8HmLMQ==
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        linux-doc@vger.kernel.org
Subject: [PATCH v3 2/3] hwmon (xdpe12284): Add support for xdpe11280
Date:   Tue,  1 Mar 2022 19:01:12 +0100
Message-Id: <c9c0bcd8106c370243ba061dc4298d58b4e2f64b.1646157237.git.sylv@sylv.io>
In-Reply-To: <cover.1646157237.git.sylv@sylv.io>
References: <cover.1646157237.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for another Infineon Multi-phase controller chip. The
xdpe11280 uses linear instead of vid data format for VOUT. Detect
VOUT_MODE format during probing and set the xdpe122 related pointers
in case it uses vid.

Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
---
 Documentation/hwmon/xdpe12284.rst | 12 ++++++++----
 drivers/hwmon/pmbus/xdpe12284.c   | 22 +++++++++++++++++++---
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/Documentation/hwmon/xdpe12284.rst b/Documentation/hwmon/xdpe12284.rst
index 67d1f87808e5..a224dc74ad35 100644
--- a/Documentation/hwmon/xdpe12284.rst
+++ b/Documentation/hwmon/xdpe12284.rst
@@ -5,6 +5,10 @@ Kernel driver xdpe122
 
 Supported chips:
 
+  * Infineon XDPE11280
+
+    Prefix: 'xdpe11280'
+
   * Infineon XDPE12254
 
     Prefix: 'xdpe12254'
@@ -20,10 +24,10 @@ Authors:
 Description
 -----------
 
-This driver implements support for Infineon Multi-phase XDPE122 family
-dual loop voltage regulators.
-The family includes XDPE12284 and XDPE12254 devices.
-The devices from this family complaint with:
+This driver implements support for Infineon Multi-phase XDPE112 and XDPE122
+family dual loop voltage regulators.
+These families include XDPE11280, XDPE12284 and XDPE12254 devices.
+The devices from this family compliant with:
 
 - Intel VR13 and VR13HC rev 1.3, IMVP8 rev 1.2 and IMPVP9 rev 1.3 DC-DC
   converter specification.
diff --git a/drivers/hwmon/pmbus/xdpe12284.c b/drivers/hwmon/pmbus/xdpe12284.c
index b07da06a40c9..3413aba9d5be 100644
--- a/drivers/hwmon/pmbus/xdpe12284.c
+++ b/drivers/hwmon/pmbus/xdpe12284.c
@@ -110,7 +110,6 @@ static int xdpe122_identify(struct i2c_client *client,
 static struct pmbus_driver_info xdpe122_info = {
 	.pages = XDPE122_PAGE_NUM,
 	.format[PSC_VOLTAGE_IN] = linear,
-	.format[PSC_VOLTAGE_OUT] = vid,
 	.format[PSC_TEMPERATURE] = linear,
 	.format[PSC_CURRENT_IN] = linear,
 	.format[PSC_CURRENT_OUT] = linear,
@@ -123,23 +122,39 @@ static struct pmbus_driver_info xdpe122_info = {
 		PMBUS_HAVE_IIN | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
 		PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP |
 		PMBUS_HAVE_POUT | PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT,
-	.identify = xdpe122_identify,
-	.read_word_data = xdpe122_read_word_data,
 };
 
 static int xdpe122_probe(struct i2c_client *client)
 {
 	struct pmbus_driver_info *info;
+	int vout_mode;
 
 	info = devm_kmemdup(&client->dev, &xdpe122_info, sizeof(*info),
 			    GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
+	vout_mode = pmbus_read_byte_data(client, 0, PMBUS_VOUT_MODE);
+	if (vout_mode >= 0 && vout_mode != 0xff) {
+		switch (vout_mode >> 5) {
+		case 0:
+			info->format[PSC_VOLTAGE_OUT] = linear;
+			break;
+		case 1:
+			info->format[PSC_VOLTAGE_OUT] = vid;
+			info->identify = xdpe122_identify;
+			info->read_word_data = xdpe122_read_word_data;
+			break;
+		default:
+			return -ENODEV;
+		}
+	}
+
 	return pmbus_do_probe(client, info);
 }
 
 static const struct i2c_device_id xdpe122_id[] = {
+	{"xdpe11280", 0},
 	{"xdpe12254", 0},
 	{"xdpe12284", 0},
 	{}
@@ -148,6 +163,7 @@ static const struct i2c_device_id xdpe122_id[] = {
 MODULE_DEVICE_TABLE(i2c, xdpe122_id);
 
 static const struct of_device_id __maybe_unused xdpe122_of_match[] = {
+	{.compatible = "infineon,xdpe11280"},
 	{.compatible = "infineon,xdpe12254"},
 	{.compatible = "infineon,xdpe12284"},
 	{}
-- 
2.35.1

