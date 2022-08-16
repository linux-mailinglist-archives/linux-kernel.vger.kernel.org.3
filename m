Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C6F596137
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 19:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236426AbiHPRd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 13:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235735AbiHPRdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 13:33:52 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997E955093;
        Tue, 16 Aug 2022 10:33:49 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27GHXcIO053988;
        Tue, 16 Aug 2022 12:33:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1660671218;
        bh=M5GqU90BswEUJtWZIwH2kmDiLuAUJRFVf5x+UBza+Xc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VirDkhZ2xdbX5YOW/XrIU4VDmXNV34mQ9GDXbTRwkoXtn9Sl2/TWqlLDj/IT9U9Um
         2qNBqR6UIQdOQuWYx0EWIk+qNVLijoWvHT//9thZvPqFHFn9BcSX4ff2V3rqREk1cY
         lJ4ym9/kSBNA5ygz+Ia2ZE/YZOKDDoDiAGL7tER0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27GHXcWS116582
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Aug 2022 12:33:38 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 16
 Aug 2022 12:33:37 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 16 Aug 2022 12:33:37 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27GHXb77065808;
        Tue, 16 Aug 2022 12:33:37 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Linux RTC <linux-rtc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH 2/2] rtc: k3: detect SoC to determine erratum fix
Date:   Tue, 16 Aug 2022 12:33:12 -0500
Message-ID: <20220816173312.23243-2-bb@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220816173312.23243-1-bb@ti.com>
References: <20220816173312.23243-1-bb@ti.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3563; h=from:subject; bh=lssXN42Cjw05aDpIk4oGKCRHYOAs9IjNqfzxpdnzwoI=; b=owEBbQGS/pANAwAKAcD4q9PiE9cMAcsmYgBi+9TYxwDU70OpNoYgZVp/S5JwPnU6Zlci4Q9GO1I/ gXJOV42JATMEAAEKAB0WIQT86LDvkHWcjT+1Kb7A+KvT4hPXDAUCYvvU2AAKCRDA+KvT4hPXDHYWB/ 9V1lmKLVAMz5oGCReI1yp5/37D3pttxuGwvce2nbZGD5VR5RpbUBQkPtoc7l6O4MOMdUt7xdP+Kbt8 pvXV3yecKz1c/UwxkAj9l+KOhxEfRp11pfLujwDDQu2XzFNN19iXFKc5jSachrc4nvmaygW/wvVcTC q5L52qXi/DlfJKsOMWVSeXkA/0n9jlwtxLaZz8z5IwbBbFZ84F+4DR2jZFElMQg8CNrBC/DAk0rACi zQEqo7thHo7qWvOPnZDWWkHAxx8wtaugiMYBaXqH/C/SAyv6uP1l+gvJS9j4V8/1l7rNECgWDJZzep 8yuNzFbj29dm6D544jxl/v9FqFMH+d
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow new SoCs to use this device without a new compatible string,
use a soc_device_attribute list to define all SoCs affected by the TI
i2327 erratum and require help from their bootloaders to unlock this
device.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 drivers/rtc/rtc-ti-k3.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/rtc/rtc-ti-k3.c b/drivers/rtc/rtc-ti-k3.c
index fd26be7868d25..68e50c6a72f1d 100644
--- a/drivers/rtc/rtc-ti-k3.c
+++ b/drivers/rtc/rtc-ti-k3.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/sys_soc.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/rtc.h>
@@ -45,14 +46,6 @@
 #define K3RTC_MIN_OFFSET		(-277761)
 #define K3RTC_MAX_OFFSET		(277778)
 
-/**
- * struct ti_k3_rtc_soc_data - Private of compatible data for ti-k3-rtc
- * @unlock_irq_erratum:	Has erratum for unlock infinite IRQs (erratum i2327)
- */
-struct ti_k3_rtc_soc_data {
-	const bool unlock_irq_erratum;
-};
-
 static const struct regmap_config ti_k3_rtc_regmap_config = {
 	.name = "peripheral-registers",
 	.reg_bits = 32,
@@ -118,7 +111,6 @@ static const struct reg_field ti_rtc_reg_fields[] = {
  * @rtc_dev:		rtc device
  * @regmap:		rtc mmio regmap
  * @r_fields:		rtc register fields
- * @soc:		SoC compatible match data
  */
 struct ti_k3_rtc {
 	unsigned int irq;
@@ -127,7 +119,6 @@ struct ti_k3_rtc {
 	struct rtc_device *rtc_dev;
 	struct regmap *regmap;
 	struct regmap_field *r_fields[K3_RTC_MAX_FIELDS];
-	const struct ti_k3_rtc_soc_data *soc;
 };
 
 static int k3rtc_field_read(struct ti_k3_rtc *priv, enum ti_k3_rtc_fields f)
@@ -195,6 +186,17 @@ static int k3rtc_unlock_rtc(struct ti_k3_rtc *priv)
 	return ret;
 }
 
+/*
+ * This is the list of SoCs affected by TI's i2327 errata causing the RTC
+ * state-machine to break if not unlocked fast enough during boot. These
+ * SoCs must have the bootloader unlock this device very early in the
+ * boot-flow before we (Linux) can use this device.
+ */
+static const struct soc_device_attribute has_erratum_i2327[] = {
+	{ .family = "AM62X", .revision = "SR1.0" },
+	{ /* sentinel */ }
+};
+
 static int k3rtc_configure(struct device *dev)
 {
 	int ret;
@@ -208,7 +210,7 @@ static int k3rtc_configure(struct device *dev)
 	 *
 	 * In such occurrence, it is assumed that the RTC module is unusable
 	 */
-	if (priv->soc->unlock_irq_erratum) {
+	if (soc_device_match(has_erratum_i2327)) {
 		ret = k3rtc_check_unlocked(priv);
 		/* If there is an error OR if we are locked, return error */
 		if (ret) {
@@ -602,8 +604,6 @@ static int ti_k3_rtc_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->rtc_dev))
 		return PTR_ERR(priv->rtc_dev);
 
-	priv->soc = of_device_get_match_data(dev);
-
 	priv->rtc_dev->ops = &ti_k3_rtc_ops;
 	priv->rtc_dev->range_max = (1ULL << 48) - 1;	/* 48Bit seconds */
 	ti_k3_rtc_nvmem_config.priv = priv;
@@ -635,12 +635,8 @@ static int ti_k3_rtc_probe(struct platform_device *pdev)
 	return devm_rtc_nvmem_register(priv->rtc_dev, &ti_k3_rtc_nvmem_config);
 }
 
-static const struct ti_k3_rtc_soc_data ti_k3_am62_data = {
-	.unlock_irq_erratum = true,
-};
-
 static const struct of_device_id ti_k3_rtc_of_match_table[] = {
-	{.compatible = "ti,am62-rtc", .data = &ti_k3_am62_data},
+	{.compatible = "ti,am62-rtc" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, ti_k3_rtc_of_match_table);
-- 
2.17.1

