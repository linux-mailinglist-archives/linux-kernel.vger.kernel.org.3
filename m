Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5B650D983
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 08:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236351AbiDYGfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 02:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiDYGev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 02:34:51 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DC027CD5;
        Sun, 24 Apr 2022 23:31:47 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23P6VbE0041474;
        Mon, 25 Apr 2022 01:31:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650868297;
        bh=t+mKKNiarEzKIrLp8IKq2mW7X5cAoVBjIMp28c4TNg4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=S20ZSGqr31ywYsBHW5eNARonAVU11rce+CuPW5bKWxQDneDBYf7MNes9ZNsv0qfSA
         UN+y8Z3ObxTSaE1WSFKGl7s5s9wIukK3tWSNDYaFZSmgAcZ+fSDSVy83SZ2GwkAhyD
         p5SHygmWvSZU7RK29Mhg4fO1TOFUtyN1nxZw3dfM=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23P6Vb5N102356
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Apr 2022 01:31:37 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 25
 Apr 2022 01:31:36 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 25 Apr 2022 01:31:36 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23P6VNNP079479;
        Mon, 25 Apr 2022 01:31:34 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] drivers: mmc: sdhci_am654: Add the quirk to set TESTCD bit
Date:   Mon, 25 Apr 2022 12:01:20 +0530
Message-ID: <20220425063120.10135-3-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220425063120.10135-1-a-govindraju@ti.com>
References: <20220425063120.10135-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vignesh Raghavendra <vigneshr@ti.com>

The ARASAN MMC controller on Keystone 3 class of devices need the SDCD
line to be connected for proper functioning. Similar to the issue pointed
out in sdhci-of-arasan.c driver, commit 3794c542641f ("mmc:
sdhci-of-arasan: Set controller to test mode when no CD bit").

In cases where this can't be connected, add a quirk to force the
controller into test mode and set the TESTCD bit. Use the flag
"ti,fails-without-test-cd", to implement this above quirk when required.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index e54fe24d47e7..e7ced1496a07 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -147,6 +147,9 @@ struct sdhci_am654_data {
 	int drv_strength;
 	int strb_sel;
 	u32 flags;
+	u32 quirks;
+
+#define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
 };
 
 struct sdhci_am654_driver_data {
@@ -369,6 +372,21 @@ static void sdhci_am654_write_b(struct sdhci_host *host, u8 val, int reg)
 	}
 }
 
+static void sdhci_am654_reset(struct sdhci_host *host, u8 mask)
+{
+	u8 ctrl;
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
+
+	sdhci_reset(host, mask);
+
+	if (sdhci_am654->quirks & SDHCI_AM654_QUIRK_FORCE_CDTEST) {
+		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
+		ctrl |= SDHCI_CTRL_CDTEST_INS | SDHCI_CTRL_CDTEST_EN;
+		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+	}
+}
+
 static int sdhci_am654_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
@@ -500,7 +518,7 @@ static struct sdhci_ops sdhci_j721e_4bit_ops = {
 	.set_clock = sdhci_j721e_4bit_set_clock,
 	.write_b = sdhci_am654_write_b,
 	.irq = sdhci_am654_cqhci_irq,
-	.reset = sdhci_reset,
+	.reset = sdhci_am654_reset,
 };
 
 static const struct sdhci_pltfm_data sdhci_j721e_4bit_pdata = {
@@ -719,6 +737,9 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
 	device_property_read_u32(dev, "ti,clkbuf-sel",
 				 &sdhci_am654->clkbuf_sel);
 
+	if (device_property_read_bool(dev, "ti,fails-without-test-cd"))
+		sdhci_am654->quirks |= SDHCI_AM654_QUIRK_FORCE_CDTEST;
+
 	sdhci_get_of_property(pdev);
 
 	return 0;
-- 
2.17.1

