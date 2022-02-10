Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069CE4B077A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 08:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236612AbiBJHru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 02:47:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236546AbiBJHrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 02:47:42 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86721D84;
        Wed,  9 Feb 2022 23:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644479258; x=1676015258;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=WtkjwIj4gFtahOwz2HPoZk6drGvPjwShM1x8+Tc6kNk=;
  b=lTAIuelpum8ukn0Rya0+4+YtmRUP1W50z2CmW8EG8DPl6s/O+hSxSaE3
   /rx7ocA9wgHymCDRfAeq6cpIOwK2p15rnt1k7ztMU6sMT852Ssu5rRy67
   g9fJrlcEqpf7WUi3X0qyRRF7+GuZ6e7DMZs2D11H3lMc+Udac+N5i1WAw
   cca0k6icm+HhgebDQJt0l8h78LiFRjZNcloPUYiXSIsbJDtt+GEuyRPj7
   l2ZWBVbvtaDEPlxfSoqUceYU87kOJDfjGfazcMJd3P3UC4QAZHFuWImoF
   qfDCUzT772dVDN2u/RZqRzVaAUBjWs3rz3EaMPvEpLd6oBsJR46FYrbK/
   A==;
IronPort-SDR: ELjPecTArxrWUc9qAkuMQsqAamCnPyVaZpZCXbBy7Td9vGhEErlfVYbLnZm5VCdAUyJRhASz/s
 qW7uRj090AC2Xu/+linXKoD7jqmJt3d5wzjVAkx6TqTk8CsGNgmKqAIeGkfq8mufZ0C8jyLFtN
 SFUQbPu50KjHOikiOwyW1n0UAe2GwekN1PELAcvcdVS3o7REV7s2ecyeJBCgtg3ibbigb7OcnY
 Fw1sKCHQPW4Q5AsFuyVRMv1+VhzcD5jy8rbzqKCIowXDsBBqOYd87TY9jx7Zqee6JX/LbvudxQ
 SLZpk4gtObZwAEd/jq5ZEvCW
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="85274972"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Feb 2022 00:47:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 10 Feb 2022 00:47:37 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 10 Feb 2022 00:47:33 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <lee.jones@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, <Kavyasree.Kotagiri@microchip.com>,
        <Manohar.Puri@microchip.com>
Subject: [PATCH 2/2] mfd: atmel-flexcom: Add support for lan966 flexcom shared configurations
Date:   Thu, 10 Feb 2022 13:15:46 +0530
Message-ID: <20220210074546.30669-3-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220210074546.30669-1-kavyasree.kotagiri@microchip.com>
References: <20220210074546.30669-1-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each flexcom of LAN966 SoC has 2 chip selects. For each chip
select of each flexcom there is a configuration register
FLEXCOM_SHARED[0-4]:SS_MASK[0-1]. The width of configuration
register is 21 because there are 21 shared pins on each of
which the chip select can be mapped. Each bit of the register
represents a different FLEXCOM_SHARED pin.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
---
 drivers/mfd/atmel-flexcom.c | 49 +++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/mfd/atmel-flexcom.c b/drivers/mfd/atmel-flexcom.c
index 559eb4d352b6..b8fc476e411d 100644
--- a/drivers/mfd/atmel-flexcom.c
+++ b/drivers/mfd/atmel-flexcom.c
@@ -27,6 +27,12 @@
 #define FLEX_MR_OPMODE_MASK	(0x3 << FLEX_MR_OPMODE_OFFSET)
 #define FLEX_MR_OPMODE(opmode)	(((opmode) << FLEX_MR_OPMODE_OFFSET) &	\
 				 FLEX_MR_OPMODE_MASK)
+#ifdef CONFIG_SOC_LAN966
+/* LAN966 register offsets */
+#define FLEX_SHRD_SS_MASK_0 0x0
+#define FLEX_SHRD_SS_MASK_1 0x4
+#define FLEX_SHRD_MASK      0x1FFFFF
+#endif
 
 struct atmel_flexcom {
 	void __iomem *base;
@@ -39,6 +45,10 @@ static int atmel_flexcom_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct resource *res;
 	struct atmel_flexcom *ddata;
+#ifdef CONFIG_SOC_LAN966
+	u32 lan966x_ss_pin, lan966x_cs, val;
+	void __iomem *shared_base;
+#endif
 	int err;
 
 	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
@@ -76,6 +86,45 @@ static int atmel_flexcom_probe(struct platform_device *pdev)
 	 */
 	writel(FLEX_MR_OPMODE(ddata->opmode), ddata->base + FLEX_MR);
 
+#ifdef CONFIG_SOC_LAN966
+	/*
+	 * Flexcom Shared Register Configurations:
+	 * In order to map chip select index X of Flexcom Y to FLEXCOM_SHARED Z,
+	 * write 0 to bit index Z of FLEXCOM_SHARED[Y]:SS_MASK[X].
+	 */
+	if (of_property_read_bool(np, "lan966x-flx-shared-cfg")) {
+		/* Shared pin */
+		err = of_property_read_u32(np, "lan966x-ss-pin", &lan966x_ss_pin);
+		if (err)
+			return err;
+
+		if (lan966x_ss_pin > 20)
+			return -EINVAL;
+
+		/* chip-select */
+		err = of_property_read_u32(np, "lan966x-cs", &lan966x_cs);
+		if (err)
+			return err;
+
+		if (lan966x_cs > 1)
+			return -EINVAL;
+
+		shared_base = devm_ioremap_resource(&pdev->dev,
+				platform_get_resource(pdev, IORESOURCE_MEM, 1));
+		if (IS_ERR(shared_base)) {
+			dev_dbg(&pdev->dev, "No Flexcom shared register config\n");
+			return PTR_ERR(shared_base);
+		}
+
+		val = ~(1 << lan966x_ss_pin) & FLEX_SHRD_MASK;
+
+		if (lan966x_cs == 0)
+			writel(val, shared_base + FLEX_SHRD_SS_MASK_0);
+		else
+			writel(val, shared_base + FLEX_SHRD_SS_MASK_1);
+	}
+#endif
+
 	clk_disable_unprepare(ddata->clk);
 
 	return devm_of_platform_populate(&pdev->dev);
-- 
2.17.1

