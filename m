Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629294BA37E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242094AbiBQOth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:49:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242086AbiBQOtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:49:32 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F1220576C;
        Thu, 17 Feb 2022 06:49:17 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21HDFUgu030673;
        Thu, 17 Feb 2022 15:48:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=vJYKJrfoZTOxidHtgmggToIXf7luT4gK50tpphfihR8=;
 b=MVIuaMSlk+h1JIRlIGwQ/g3wHqNP3eZtFFyqQnxguYKVpJQ2bMszSyDwdPtpdmuDjsl5
 /beXi/qmfOp1pti1uSERSLm6P/0awiANcFztdGNBuXqBymWGJfz71hQxzy0aCMOQ0FuU
 H13CuEfrsar5zckXQBFNWvNbyKieYpXdmrvvlaJZA0/K4k4CIGq85VB6tcE7Bbez6vRc
 r9Dytxf8PxDPKjJ32Yy0AyJO7xau8PCIDajgxLhhRsFuUbS986EiOc7xZ2SioZmasiOO
 XHB216d8OXpliFcVbuhwT2yghTYN78I0qi0EbyM188X7nh9d4u5ZcTEZrD9jfyUC1Gap GA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e9k06a45x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 15:48:55 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CC5D610002A;
        Thu, 17 Feb 2022 15:48:54 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C28CC2278A1;
        Thu, 17 Feb 2022 15:48:54 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 17 Feb 2022 15:48:54
 +0100
From:   Christophe Kerello <christophe.kerello@foss.st.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <robh+dt@kernel.org>, <srinivas.kandagatla@linaro.org>,
        <p.yadav@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <chenshumin86@sina.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>
Subject: [PATCH v3 2/4] mtd: rawnand: stm32_fmc2: Add NAND Write Protect support
Date:   Thu, 17 Feb 2022 15:47:53 +0100
Message-ID: <20220217144755.270679-3-christophe.kerello@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217144755.270679-1-christophe.kerello@foss.st.com>
References: <20220217144755.270679-1-christophe.kerello@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-17_05,2022-02-17_01,2021-12-02_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the support of the WP# signal. WP will be disabled in
probe/resume callbacks and will be enabled in remove/suspend callbacks.

Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
---
 drivers/mtd/nand/raw/stm32_fmc2_nand.c | 40 +++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index 97b4e02e43e4..87c1c7dd97eb 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -9,6 +9,7 @@
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/errno.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/mfd/syscon.h>
@@ -231,6 +232,7 @@ struct stm32_fmc2_timings {
 
 struct stm32_fmc2_nand {
 	struct nand_chip chip;
+	struct gpio_desc *wp_gpio;
 	struct stm32_fmc2_timings timings;
 	int ncs;
 	int cs_used[FMC2_MAX_CE];
@@ -1747,6 +1749,18 @@ static const struct nand_controller_ops stm32_fmc2_nfc_controller_ops = {
 	.setup_interface = stm32_fmc2_nfc_setup_interface,
 };
 
+static void stm32_fmc2_nfc_wp_enable(struct stm32_fmc2_nand *nand)
+{
+	if (nand->wp_gpio)
+		gpiod_set_value(nand->wp_gpio, 1);
+}
+
+static void stm32_fmc2_nfc_wp_disable(struct stm32_fmc2_nand *nand)
+{
+	if (nand->wp_gpio)
+		gpiod_set_value(nand->wp_gpio, 0);
+}
+
 static int stm32_fmc2_nfc_parse_child(struct stm32_fmc2_nfc *nfc,
 				      struct device_node *dn)
 {
@@ -1785,6 +1799,18 @@ static int stm32_fmc2_nfc_parse_child(struct stm32_fmc2_nfc *nfc,
 		nand->cs_used[i] = cs;
 	}
 
+	nand->wp_gpio = devm_gpiod_get_from_of_node(nfc->dev, dn,
+						    "wp-gpios", 0,
+						    GPIOD_OUT_HIGH, "wp");
+	if (IS_ERR(nand->wp_gpio)) {
+		ret = PTR_ERR(nand->wp_gpio);
+		if (ret != -ENOENT)
+			return dev_err_probe(nfc->dev, ret,
+					     "failed to request WP GPIO\n");
+
+		nand->wp_gpio = NULL;
+	}
+
 	nand_set_flash_node(&nand->chip, dn);
 
 	return 0;
@@ -1956,10 +1982,12 @@ static int stm32_fmc2_nfc_probe(struct platform_device *pdev)
 	chip->options |= NAND_BUSWIDTH_AUTO | NAND_NO_SUBPAGE_WRITE |
 			 NAND_USES_DMA;
 
+	stm32_fmc2_nfc_wp_disable(nand);
+
 	/* Scan to find existence of the device */
 	ret = nand_scan(chip, nand->ncs);
 	if (ret)
-		goto err_release_dma;
+		goto err_wp_enable;
 
 	ret = mtd_device_register(mtd, NULL, 0);
 	if (ret)
@@ -1972,6 +2000,9 @@ static int stm32_fmc2_nfc_probe(struct platform_device *pdev)
 err_nand_cleanup:
 	nand_cleanup(chip);
 
+err_wp_enable:
+	stm32_fmc2_nfc_wp_enable(nand);
+
 err_release_dma:
 	if (nfc->dma_ecc_ch)
 		dma_release_channel(nfc->dma_ecc_ch);
@@ -2012,15 +2043,20 @@ static int stm32_fmc2_nfc_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(nfc->clk);
 
+	stm32_fmc2_nfc_wp_enable(nand);
+
 	return 0;
 }
 
 static int __maybe_unused stm32_fmc2_nfc_suspend(struct device *dev)
 {
 	struct stm32_fmc2_nfc *nfc = dev_get_drvdata(dev);
+	struct stm32_fmc2_nand *nand = &nfc->nand;
 
 	clk_disable_unprepare(nfc->clk);
 
+	stm32_fmc2_nfc_wp_enable(nand);
+
 	pinctrl_pm_select_sleep_state(dev);
 
 	return 0;
@@ -2042,6 +2078,8 @@ static int __maybe_unused stm32_fmc2_nfc_resume(struct device *dev)
 
 	stm32_fmc2_nfc_init(nfc);
 
+	stm32_fmc2_nfc_wp_disable(nand);
+
 	for (chip_cs = 0; chip_cs < FMC2_MAX_CE; chip_cs++) {
 		if (!(nfc->cs_assigned & BIT(chip_cs)))
 			continue;
-- 
2.25.1

