Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7323C4B2B94
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352070AbiBKRR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:17:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351983AbiBKRRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:17:53 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50C095;
        Fri, 11 Feb 2022 09:17:51 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4JwL0Z4L8Pz9sWB;
        Fri, 11 Feb 2022 18:17:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1644599868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cYB9jsEmktbZ+WrieEs2dnr7GDeZou2sHGFwgq6lkRI=;
        b=wkbn6c2sblqfuisyhLCWm+iVNBBVSnbg1SlLQQXiolFVSlUuUnn6EBlj1fy11K2PWEk5UF
        HR+0gk9Mkbg4gFvYBX9lDaO4NGdXq1qM8Uo9CepkHLS4OnNTn7IOVuvU2CX+Gwme5/ftK+
        8fJv858HCocr9ZNimV98BW8w0aFDD0SL8MkOvOsTSBPI5d+XfofItHDs1Om2D2YgzomyCx
        KV6A0N6QR7fPHHXZy9RLd5TzRL/yFjMt5r1Qglu+AMxLro5rizQUvUQWar6Q95z+nvBVLt
        n2KMDiGmTomYoEAyGI6YE+Fq6STtKHMalaXTVZg3yjmRNVW6vC+/wlbD+HAPKA==
From:   Marcello Sylvester Bauer <sylv@sylv.io>
To:     linux-hwmon@vger.kernel.org
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/4] pmbus (pli1209bc): Add regulator support
Date:   Fri, 11 Feb 2022 18:17:13 +0100
Message-Id: <0a657d200809dedc5fdd2095fae8c0f2fceecf1f.1644597670.git.sylv@sylv.io>
In-Reply-To: <cover.1644597670.git.sylv@sylv.io>
References: <cover.1644597670.git.sylv@sylv.io>
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
 drivers/hwmon/pmbus/Kconfig     |  8 ++++++++
 drivers/hwmon/pmbus/pli1209bc.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 831db423bea0..e64e0f2d93c9 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -319,6 +319,14 @@ config SENSORS_PLI1209BC
 	  This driver can also be built as a module. If so, the module will
 	  be called pli1209bc.
 
+config SENSORS_PLI1209BC_REGULATOR
+	bool "Regulator support for PLI1209BC"
+	depends on SENSORS_PLI1209BC && REGULATOR
+	help
+	  If you say yes here you get regulator support for Vicor PLI1209BC
+	  Digital Supervisor.
+
+
 config SENSORS_PM6764TR
 	tristate "ST PM6764TR"
 	help
diff --git a/drivers/hwmon/pmbus/pli1209bc.c b/drivers/hwmon/pmbus/pli1209bc.c
index da345eb105fd..ec479b22aa10 100644
--- a/drivers/hwmon/pmbus/pli1209bc.c
+++ b/drivers/hwmon/pmbus/pli1209bc.c
@@ -8,6 +8,7 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/pmbus.h>
+#include <linux/regulator/driver.h>
 #include "pmbus.h"
 
 /*
@@ -32,11 +33,39 @@ static int pli1209bc_read_word_data(struct i2c_client *client, int page,
 		if (data < 0)
 			return data;
 		return div_s64(data + 5LL, 10L);
+#if IS_ENABLED(CONFIG_SENSORS_PLI1209BC_REGULATOR)
+	/*
+	 * PMBUS_READ_VOUT and PMBUS_READ_TEMPERATURE_1 returns invalid data,
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
+#endif
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
@@ -64,6 +93,10 @@ static struct pmbus_driver_info pli1209bc_info = {
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

