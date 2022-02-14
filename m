Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F734B5067
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353396AbiBNMlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:41:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353282AbiBNMld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:41:33 -0500
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07324B845;
        Mon, 14 Feb 2022 04:41:26 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:105:465:1:4:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Jy3kD3x82z9sVt;
        Mon, 14 Feb 2022 13:41:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1644842482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CzSU0IMv/2LxOfRakHZ3PQs+bsJ9KsSlO3ZV65EGguA=;
        b=TpdiJtIvRqkfoWk/elagO0n6xJ9dgplPX0H8VaRL3qaVAUKGvE5p2nj6GLqbw/BJHoz+8q
        zlRcr4dNWcjE7GgOFManyOrvkhOo50YphptYSYmo4UANmK7Itd/pP8XRdkNgVgkXYIWimp
        VPeSEAX68a1s92tlv8d1awNBl0ubxt2rfi+DKvt8M9mrbnENT0Bc3WkHEUDlp2jpwCE/Yj
        NZfFRB+cf10mkQWtTdUdpGv3JxrIGiumjpXPKwGOYaGxnGnlsU/WXYTv8SrKWYpQHJ6K1k
        8VnjIp7WKPsu8CmHmwDoyTh3Jc1Q3zV7mVBvcW+xtpms4TE02o31WmeSxljOQA==
From:   Marcello Sylvester Bauer <sylv@sylv.io>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
Subject: [PATCH v2 4/4] pmbus (pli1209bc): Add regulator support
Date:   Mon, 14 Feb 2022 13:40:35 +0100
Message-Id: <fc5b0ba1f7d41e88ef066c3ff23aaf882c19c543.1644834803.git.sylv@sylv.io>
In-Reply-To: <cover.1644834803.git.sylv@sylv.io>
References: <cover.1644834803.git.sylv@sylv.io>
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

Add regulator support for PLI1209BC Digital Supervisor.

Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
---
 drivers/hwmon/pmbus/Kconfig     |  7 +++++++
 drivers/hwmon/pmbus/pli1209bc.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 831db423bea0..8b8f0d8733b2 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -319,6 +319,13 @@ config SENSORS_PLI1209BC
 	  This driver can also be built as a module. If so, the module will
 	  be called pli1209bc.
 
+config SENSORS_PLI1209BC_REGULATOR
+	bool "Regulator support for PLI1209BC"
+	depends on SENSORS_PLI1209BC && REGULATOR
+	help
+	  If you say yes here you get regulator support for Vicor PLI1209BC
+	  Digital Supervisor.
+
 config SENSORS_PM6764TR
 	tristate "ST PM6764TR"
 	help
diff --git a/drivers/hwmon/pmbus/pli1209bc.c b/drivers/hwmon/pmbus/pli1209bc.c
index 8a9af2ccc46f..7212d73f6e04 100644
--- a/drivers/hwmon/pmbus/pli1209bc.c
+++ b/drivers/hwmon/pmbus/pli1209bc.c
@@ -8,6 +8,7 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/pmbus.h>
+#include <linux/regulator/driver.h>
 #include "pmbus.h"
 
 /*
@@ -32,11 +33,37 @@ static int pli1209bc_read_word_data(struct i2c_client *client, int page,
 		if (data < 0)
 			return data;
 		return data * 10;
+	/*
+	 * PMBUS_READ_VOUT and PMBUS_READ_TEMPERATURE_1 return invalid data
+	 * when the BCM is turned off. Since it is not possible to return
+	 * ENODATA error, return zero instead.
+	 */
+	case PMBUS_READ_VOUT:
+	case PMBUS_READ_TEMPERATURE_1:
+		data = pmbus_read_word_data(client, page, phase,
+					    PMBUS_STATUS_WORD);
+		if (data < 0)
+			return data;
+		if (data & PB_STATUS_POWER_GOOD_N)
+			return 0L;
+		return pmbus_read_word_data(client, page, phase, reg);
 	default:
 		return -ENODATA;
 	}
 }
 
+#if IS_ENABLED(CONFIG_SENSORS_PLI1209BC_REGULATOR)
+static const struct regulator_desc pli1209bc_reg_desc = {
+	.name = "vout2",
+	.id = 1,
+	.of_match = of_match_ptr("vout2"),
+	.regulators_node = of_match_ptr("regulators"),
+	.ops = &pmbus_regulator_ops,
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+};
+#endif
+
 static struct pmbus_driver_info pli1209bc_info = {
 	.pages = 2,
 	.format[PSC_VOLTAGE_IN] = direct,
@@ -74,6 +101,10 @@ static struct pmbus_driver_info pli1209bc_info = {
 	    | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP
 	    | PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_INPUT,
 	.read_word_data = pli1209bc_read_word_data,
+#if IS_ENABLED(CONFIG_SENSORS_PLI1209BC_REGULATOR)
+	.num_regulators = 1,
+	.reg_desc = &pli1209bc_reg_desc,
+#endif
 };
 
 static int pli1209bc_probe(struct i2c_client *client)
-- 
2.34.1

