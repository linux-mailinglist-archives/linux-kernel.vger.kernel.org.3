Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7B84D5297
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237777AbiCJTvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 14:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243919AbiCJTvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 14:51:46 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1839199D50;
        Thu, 10 Mar 2022 11:50:42 -0800 (PST)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22AG7Y8q002856;
        Thu, 10 Mar 2022 19:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pps0720;
 bh=WNl8gOBPS5RW9W1D89pwCicP2bWE/AEsGXH11Ae+sd4=;
 b=mbS1xtl1vfcKFvU0HW2L2oxX+nBYq4gbQE2HDMy8XGgNqf75XOWnB0B3UB8iQM6DQlIq
 hgRVvpL0v5PwxNd9eATBv63Nz8d1ieMfc5c7a23NQ6/13D6A75VR44U+jSHXSlk4fGSa
 H7p7rGPExBhKss36S70mXJMYtf6zQ8bYtt+Ct2QJ4XG+sBtnxiJGsz/PxyLfyu7oFVPA
 3EgtZofAk231hgYtgpOF21W4yO6PDrizDajm4+hWclhqkrPEmjAQ/Ty2GHgmMr7oNO3w
 TKpoJ16cWUzWsfqYzgNemakqgWt8lXpLVLMvUrX1Dg0iHDUHzgXEDV6BUJR5q7eBZnij Ww== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3eqmjv9scp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 19:50:29 +0000
Received: from hpe.com (unknown [15.115.65.69])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 1778477;
        Thu, 10 Mar 2022 19:50:28 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com
Cc:     Nick Hawkins <nick.hawkins@hpe.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH v3 03/10] drivers: wdt: Introduce HPE GXP SoC Watchdog
Date:   Thu, 10 Mar 2022 13:52:22 -0600
Message-Id: <20220310195229.109477-3-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220310195229.109477-1-nick.hawkins@hpe.com>
References: <20220310195229.109477-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: th4EnEbt097Ta7_k6XNTF7CxpBknNNGr
X-Proofpoint-ORIG-GUID: th4EnEbt097Ta7_k6XNTF7CxpBknNNGr
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_09,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 spamscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203100100
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Adding support for the HPE GXP Watchdog. It is new to the linux
community and this along with several other patches is the first
support for it. The GXP asic contains a full compliment of
timers one of which is the watchdog timer. The watchdog timer
is 16 bit and has 10ms resolution.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 drivers/watchdog/Kconfig   |   8 ++
 drivers/watchdog/Makefile  |   1 +
 drivers/watchdog/gxp-wdt.c | 191 +++++++++++++++++++++++++++++++++++++
 3 files changed, 200 insertions(+)
 create mode 100644 drivers/watchdog/gxp-wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index c8fa79da23b3..cb210d2978d2 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1820,6 +1820,14 @@ config RALINK_WDT
 	help
 	  Hardware driver for the Ralink SoC Watchdog Timer.
 
+config GXP_WATCHDOG
+	tristate "HPE GXP watchdog support"
+	depends on ARCH_HPE_GXP
+	select WATCHDOG_CORE
+	help
+	  Say Y here to include support for the watchdog timer
+	  in HPE GXP SoCs.
+
 config MT7621_WDT
 	tristate "Mediatek SoC watchdog"
 	select WATCHDOG_CORE
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index f7da867e8782..e2acf3a0d0fc 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -92,6 +92,7 @@ obj-$(CONFIG_RTD119X_WATCHDOG) += rtd119x_wdt.o
 obj-$(CONFIG_SPRD_WATCHDOG) += sprd_wdt.o
 obj-$(CONFIG_PM8916_WATCHDOG) += pm8916_wdt.o
 obj-$(CONFIG_ARM_SMC_WATCHDOG) += arm_smc_wdt.o
+obj-$(CONFIG_GXP_WATCHDOG) += gxp-wdt.o
 obj-$(CONFIG_VISCONTI_WATCHDOG) += visconti_wdt.o
 obj-$(CONFIG_MSC313E_WATCHDOG) += msc313e_wdt.o
 obj-$(CONFIG_APPLE_WATCHDOG) += apple_wdt.o
diff --git a/drivers/watchdog/gxp-wdt.c b/drivers/watchdog/gxp-wdt.c
new file mode 100644
index 000000000000..d2b489cb4774
--- /dev/null
+++ b/drivers/watchdog/gxp-wdt.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2022 Hewlett-Packard Enterprise Development Company, L.P.
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/types.h>
+#include <linux/watchdog.h>
+
+#define MASK_WDGCS_ENABLE	0x01
+#define MASK_WDGCS_RELOAD	0x04
+#define MASK_WDGCS_NMIEN	0x08
+#define MASK_WDGCS_WARN		0x80
+
+#define WDT_MAX_TIMEOUT_MS	655000
+#define WDT_DEFAULT_TIMEOUT	30
+#define SECS_TO_WDOG_TICKS(x) ((x) * 100)
+#define WDOG_TICKS_TO_SECS(x) ((x) / 100)
+
+struct gxp_wdt {
+	void __iomem	*counter;
+	void __iomem	*control;
+	struct watchdog_device	wdd;
+};
+
+static void gxp_wdt_enable_reload(struct gxp_wdt *drvdata)
+{
+	uint8_t val;
+
+	val = readb(drvdata->control);
+	val |= (MASK_WDGCS_ENABLE | MASK_WDGCS_RELOAD);
+	writeb(val, drvdata->control);
+}
+
+static int gxp_wdt_start(struct watchdog_device *wdd)
+{
+	struct gxp_wdt *drvdata = watchdog_get_drvdata(wdd);
+
+	writew((SECS_TO_WDOG_TICKS(wdd->timeout)), drvdata->counter);
+	gxp_wdt_enable_reload(drvdata);
+	return 0;
+}
+
+static int gxp_wdt_stop(struct watchdog_device *wdd)
+{
+	struct gxp_wdt *drvdata = watchdog_get_drvdata(wdd);
+	uint8_t val;
+
+	val = readb_relaxed(drvdata->control);
+	val &= ~MASK_WDGCS_ENABLE;
+	writeb(val, drvdata->control);
+	return 0;
+}
+
+static int gxp_wdt_set_timeout(struct watchdog_device *wdd,
+			       unsigned int timeout)
+{
+	struct gxp_wdt *drvdata = watchdog_get_drvdata(wdd);
+	uint32_t actual;
+
+	wdd->timeout = timeout;
+	actual = min(timeout, wdd->max_hw_heartbeat_ms / 1000);
+	writew((SECS_TO_WDOG_TICKS(actual)), drvdata->counter);
+
+	return 0;
+}
+
+static unsigned int gxp_wdt_get_timeleft(struct watchdog_device *wdd)
+{
+	struct gxp_wdt *drvdata = watchdog_get_drvdata(wdd);
+	uint32_t val = readw(drvdata->counter);
+
+	return WDOG_TICKS_TO_SECS(val);
+}
+
+static int gxp_wdt_ping(struct watchdog_device *wdd)
+{
+	struct gxp_wdt *drvdata = watchdog_get_drvdata(wdd);
+
+	gxp_wdt_enable_reload(drvdata);
+	return 0;
+}
+
+static int gxp_restart(struct watchdog_device *wdd, unsigned long action,
+		       void *data)
+{
+	struct gxp_wdt *drvdata = watchdog_get_drvdata(wdd);
+
+	writew(10, drvdata->counter);
+	gxp_wdt_enable_reload(drvdata);
+	mdelay(100);
+	return 0;
+}
+
+static const struct watchdog_ops gxp_wdt_ops = {
+	.owner =	THIS_MODULE,
+	.start =	gxp_wdt_start,
+	.stop =		gxp_wdt_stop,
+	.ping = gxp_wdt_ping,
+	.set_timeout	= gxp_wdt_set_timeout,
+	.get_timeleft =	gxp_wdt_get_timeleft,
+	.restart =	gxp_restart,
+};
+
+static const struct watchdog_info gxp_wdt_info = {
+	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
+	.identity = "HPE GXP Watchdog timer",
+};
+
+static int gxp_wdt_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+	struct gxp_wdt *drvdata;
+	int err;
+	uint8_t val;
+
+	drvdata = devm_kzalloc(dev, sizeof(struct gxp_wdt), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, drvdata);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	drvdata->counter = devm_ioremap_resource(dev, res);
+	if (IS_ERR(drvdata->counter))
+		return PTR_ERR(drvdata->counter);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	drvdata->control = devm_ioremap_resource(dev, res);
+	if (IS_ERR(drvdata->control))
+		return PTR_ERR(drvdata->control);
+
+	drvdata->wdd.info = &gxp_wdt_info;
+	drvdata->wdd.ops = &gxp_wdt_ops;
+	drvdata->wdd.max_hw_heartbeat_ms = WDT_MAX_TIMEOUT_MS;
+	drvdata->wdd.parent = &pdev->dev;
+
+	watchdog_set_drvdata(&drvdata->wdd, drvdata);
+	watchdog_init_timeout(&drvdata->wdd, WDT_DEFAULT_TIMEOUT, dev);
+	watchdog_set_nowayout(&drvdata->wdd, WATCHDOG_NOWAYOUT);
+
+	val = readb(drvdata->control);
+	if (val & MASK_WDGCS_ENABLE)
+		set_bit(WDOG_HW_RUNNING, &drvdata->wdd.status);
+
+	watchdog_set_restart_priority(&drvdata->wdd, 128);
+
+	watchdog_stop_on_reboot(&drvdata->wdd);
+	err = devm_watchdog_register_device(dev, &drvdata->wdd);
+	if (err) {
+		dev_err(dev, "Failed to register watchdog device");
+		return err;
+	}
+
+	dev_info(dev, "HPE GXP watchdog timer");
+	return 0;
+}
+
+static int gxp_wdt_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static const struct of_device_id gxp_wdt_of_match[] = {
+	{ .compatible = "hpe,gxp-wdt", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, gxp_wdt_of_match);
+
+static struct platform_driver gxp_wdt_driver = {
+	.probe		= gxp_wdt_probe,
+	.remove		= gxp_wdt_remove,
+	.driver = {
+		.name =		"gxp-wdt",
+		.of_match_table = gxp_wdt_of_match,
+	},
+};
+module_platform_driver(gxp_wdt_driver);
+
+MODULE_AUTHOR("Nick Hawkins <nick.hawkins@hpe.com>");
+MODULE_AUTHOR("Jean-Marie Verdun <verdun@hpe.com>");
+MODULE_DESCRIPTION("Driver for GXP watchdog timer");
-- 
2.17.1

