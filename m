Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6E74CA146
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 10:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240697AbiCBJup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 04:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240653AbiCBJuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:50:35 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB94B91EC;
        Wed,  2 Mar 2022 01:49:52 -0800 (PST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4K7q8t43xWz9sZY;
        Wed,  2 Mar 2022 10:49:50 +0100 (CET)
From:   Marcello Sylvester Bauer <sylv@sylv.io>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1646214588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HOOrs5FZNy1pwse55EQtJG6udmnl0Zac5kiBxIC+paM=;
        b=zZenACr6Xh7+TxZm0J42aixBIRYq/thgiA6G/RAjX5oGxQVr2JSSIUotvbromRhPSC3sT1
        d/nF/CDTOGSilbBpQK8W3R96YNMv7FfAx/qnqKmMDn2e9daUPTJHfMjAWrWcXMjZLcDgKq
        O4jrDluoqug2qj7AhhLmbe0g/YtYoZ+glrv/DEhb+YZgdcDdmRfNkJ8KT42twz8vbEOgHQ
        CdWt4hjK1iJP8QouLeOtnZPzHw9lhFukaaouYF0ZD4WRWJnIySkU7JZaInlIjFjEPirFvw
        7tWKhamauyVrn6xFnTu2+80S3H43yrCr4o5HCBbUACR0P1TIEeOGp3MR1eoGxQ==
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        linux-doc@vger.kernel.org
Subject: [PATCH v4 2/3] hwmon (xdpe12284): Add support for xdpe11280
Date:   Wed,  2 Mar 2022 10:49:20 +0100
Message-Id: <fa6a4b636a05ecb337d132824efca2545188a2a2.1646214248.git.sylv@sylv.io>
In-Reply-To: <cover.1646214248.git.sylv@sylv.io>
References: <cover.1646214248.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for another Infineon Multi-phase controller chip. The
xdpe11280 uses linear instead of vid data format for VOUT. Detect
VOUT_MODE format during identification and skip the xdpe122 related
adaptions in case it is linear.

Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
---
 Documentation/hwmon/xdpe12284.rst | 12 ++++++++----
 drivers/hwmon/pmbus/xdpe12284.c   | 21 ++++++++++++++++++---
 2 files changed, 26 insertions(+), 7 deletions(-)

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
index b07da06a40c9..b979c88d2e87 100644
--- a/drivers/hwmon/pmbus/xdpe12284.c
+++ b/drivers/hwmon/pmbus/xdpe12284.c
@@ -76,7 +76,22 @@ static int xdpe122_identify(struct i2c_client *client,
 			    struct pmbus_driver_info *info)
 {
 	u8 vout_params;
-	int i, ret;
+	int i, ret, vout_mode;
+
+	vout_mode = pmbus_read_byte_data(client, 0, PMBUS_VOUT_MODE);
+	if (vout_mode >= 0 && vout_mode != 0xff) {
+		switch (vout_mode >> 5) {
+		case 0:
+			info->format[PSC_VOLTAGE_OUT] = linear;
+			return 0;
+		case 1:
+			info->format[PSC_VOLTAGE_OUT] = vid;
+			info->read_word_data = xdpe122_read_word_data;
+			break;
+		default:
+			return -ENODEV;
+		}
+	}
 
 	for (i = 0; i < XDPE122_PAGE_NUM; i++) {
 		/* Read the register with VOUT scaling value.*/
@@ -110,7 +125,6 @@ static int xdpe122_identify(struct i2c_client *client,
 static struct pmbus_driver_info xdpe122_info = {
 	.pages = XDPE122_PAGE_NUM,
 	.format[PSC_VOLTAGE_IN] = linear,
-	.format[PSC_VOLTAGE_OUT] = vid,
 	.format[PSC_TEMPERATURE] = linear,
 	.format[PSC_CURRENT_IN] = linear,
 	.format[PSC_CURRENT_OUT] = linear,
@@ -124,7 +138,6 @@ static struct pmbus_driver_info xdpe122_info = {
 		PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP |
 		PMBUS_HAVE_POUT | PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT,
 	.identify = xdpe122_identify,
-	.read_word_data = xdpe122_read_word_data,
 };
 
 static int xdpe122_probe(struct i2c_client *client)
@@ -140,6 +153,7 @@ static int xdpe122_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id xdpe122_id[] = {
+	{"xdpe11280", 0},
 	{"xdpe12254", 0},
 	{"xdpe12284", 0},
 	{}
@@ -148,6 +162,7 @@ static const struct i2c_device_id xdpe122_id[] = {
 MODULE_DEVICE_TABLE(i2c, xdpe122_id);
 
 static const struct of_device_id __maybe_unused xdpe122_of_match[] = {
+	{.compatible = "infineon,xdpe11280"},
 	{.compatible = "infineon,xdpe12254"},
 	{.compatible = "infineon,xdpe12284"},
 	{}
-- 
2.35.1

