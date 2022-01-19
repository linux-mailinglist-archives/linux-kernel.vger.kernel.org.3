Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B609A4935ED
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 08:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352288AbiASHzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 02:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345447AbiASHyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 02:54:19 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE446C061748;
        Tue, 18 Jan 2022 23:54:18 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id p37so1825809pfh.4;
        Tue, 18 Jan 2022 23:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tDrXwcXiPuocleeGwMZcb0Ux64jdkepdRHT9ym5PgXc=;
        b=Dd2jA8EtlZr59DCwPlPHGIomnZTLBe+3srsl5A/iBhV04X/1yR/JD+rpOxF1NYlQEG
         sd3ZErPbAZNDwkLmDM4Mm2Y1/CiHJB4ewpmdF6K0jtiv2LDt+FAy2PV2oyN5H0b5Ako+
         oUgDiUno7aZJfJ97/1ewz0gAKvSPXr7lSizoxWCUU8VXhAxLPxWR8ERJVvdD86+W0rp5
         eFhoiru7hImNmK+p5CwQwoSXOHjaKbZAosfNBFdT9fGCELzkG8WAUOWdcV1pX1ACeuZv
         4PK+wLpMiXl+BkoKQJYmQ/7cr5MvuHAuQJu60iY/VFPk4J4AJOoJylXc9Kfg8qF+z0yK
         Grcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tDrXwcXiPuocleeGwMZcb0Ux64jdkepdRHT9ym5PgXc=;
        b=clg+J7RyjmPXz9HD+CwYNIqi11tQ7SENRnFVhm1OpjQ0IbQzJ6ZnWb20IxBKHZ7/Tm
         xcxnxFvJh6APPApCoowYUzQbB33qTLlKS9S7F2ccbka7hHml9TTgg6GTP746bmsAGTKA
         /2o4/uxiuP2umVML9RJtQnlkLjSc6+C9ZEotH2ppTp85rDBz2N1zO2DzU8C9qAxLx82h
         23q9G6LjQDOqG2GgdOR8JnPei/Ovs/ylx5tK3Jt70Bc7g4y22sXU0AQP5yPrbeY/QR5r
         KMFTeG/XGWTj4W6sYXb69GYWgJJKFOsAmSgQsbV1kh4CbXfNnVOblFspOeJ/rw6o0FWx
         oa6w==
X-Gm-Message-State: AOAM530yRH74jA+XqthpdpDvbCug66RN3tL7n/0RnuTTw8X0FvnTRGVF
        q3CC1UQs0I406v21ouKStDs=
X-Google-Smtp-Source: ABdhPJw4zCcJ/pEmSHKAJ3TLZrErP/nCp7dS7s73OmABlaWSl8GlNA4GelRxfzkjixLIguF1wZKJoQ==
X-Received: by 2002:a63:7258:: with SMTP id c24mr26790437pgn.11.1642578858477;
        Tue, 18 Jan 2022 23:54:18 -0800 (PST)
Received: from localhost.localdomain (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id y1sm17380058pgs.4.2022.01.18.23.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 23:54:18 -0800 (PST)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        greg.tu@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw,
        SeanHY.Chen@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH 3/3] mmc: sdhci-pci-gli: Add a switch to enable/disable SSC for GL9750 and GL9755
Date:   Wed, 19 Jan 2022 15:54:06 +0800
Message-Id: <20220119075406.36321-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Add a vendor-specific bit at the bit26 of GL9750's register 878h and
GL9755's register 78h to decide whether to disable SSC function. If
this bit is set, the SSC function will be disabled.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-pci-gli.c | 66 ++++++++++++++++++++++++++------
 1 file changed, 54 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 9de3d91283af..b8cd7a365ec2 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -62,6 +62,7 @@
 #define   GLI_9750_MISC_RX_INV_OFF       0x0
 #define   GLI_9750_MISC_RX_INV_VALUE     GLI_9750_MISC_RX_INV_OFF
 #define   GLI_9750_MISC_TX1_DLY_VALUE    0x5
+#define   SDHCI_GLI_9750_MISC_SSC_OFF    BIT(26)
 
 #define SDHCI_GLI_9750_TUNING_CONTROL	          0x540
 #define   SDHCI_GLI_9750_TUNING_CONTROL_EN          BIT(4)
@@ -134,6 +135,9 @@
 #define PCI_GLI_9755_SerDes  0x70
 #define PCI_GLI_9755_SCP_DIS   BIT(19)
 
+#define PCI_GLI_9755_MISC	    0x78
+#define   PCI_GLI_9755_MISC_SSC_OFF    BIT(26)
+
 #define GLI_MAX_TUNING_LOOP 40
 
 /* Genesys Logic chipset */
@@ -368,6 +372,19 @@ static void gl9750_set_pll(struct sdhci_host *host, u8 dir, u16 ldiv, u8 pdiv)
 	mdelay(1);
 }
 
+static bool gl9750_ssc_enable(struct sdhci_host *host)
+{
+	u32 misc;
+	u8 off;
+
+	gl9750_wt_on(host);
+	misc = sdhci_readl(host, SDHCI_GLI_9750_MISC);
+	off = FIELD_GET(SDHCI_GLI_9750_MISC_SSC_OFF, misc);
+	gl9750_wt_off(host);
+
+	return !off;
+}
+
 static void gl9750_set_ssc(struct sdhci_host *host, u8 enable, u8 step, u16 ppm)
 {
 	u32 pll;
@@ -389,22 +406,28 @@ static void gl9750_set_ssc(struct sdhci_host *host, u8 enable, u8 step, u16 ppm)
 
 static void gl9750_set_ssc_pll_205mhz(struct sdhci_host *host)
 {
-	/* set pll to 205MHz and enable ssc */
-	gl9750_set_ssc(host, 0x1, 0xF, 0x5A1D);
+	bool enable = gl9750_ssc_enable(host);
+
+	/* set pll to 205MHz and ssc */
+	gl9750_set_ssc(host, enable, 0xF, 0x5A1D);
 	gl9750_set_pll(host, 0x1, 0x246, 0x0);
 }
 
 static void gl9750_set_ssc_pll_100mhz(struct sdhci_host *host)
 {
-	/* set pll to 100MHz and enable ssc */
-	gl9750_set_ssc(host, 0x1, 0xE, 0x51EC);
+	bool enable = gl9750_ssc_enable(host);
+
+	/* set pll to 100MHz and ssc */
+	gl9750_set_ssc(host, enable, 0xE, 0x51EC);
 	gl9750_set_pll(host, 0x1, 0x244, 0x1);
 }
 
 static void gl9750_set_ssc_pll_50mhz(struct sdhci_host *host)
 {
-	/* set pll to 50MHz and enable ssc */
-	gl9750_set_ssc(host, 0x1, 0xE, 0x51EC);
+	bool enable = gl9750_ssc_enable(host);
+
+	/* set pll to 50MHz and ssc */
+	gl9750_set_ssc(host, enable, 0xE, 0x51EC);
 	gl9750_set_pll(host, 0x1, 0x244, 0x3);
 }
 
@@ -529,6 +552,19 @@ static void gl9755_set_pll(struct pci_dev *pdev, u8 dir, u16 ldiv, u8 pdiv)
 	mdelay(1);
 }
 
+static bool gl9755_ssc_enable(struct pci_dev *pdev)
+{
+	u32 misc;
+	u8 off;
+
+	gl9755_wt_on(pdev);
+	pci_read_config_dword(pdev, PCI_GLI_9755_MISC, &misc);
+	off = FIELD_GET(PCI_GLI_9755_MISC_SSC_OFF, misc);
+	gl9755_wt_off(pdev);
+
+	return !off;
+}
+
 static void gl9755_set_ssc(struct pci_dev *pdev, u8 enable, u8 step, u16 ppm)
 {
 	u32 pll;
@@ -550,22 +586,28 @@ static void gl9755_set_ssc(struct pci_dev *pdev, u8 enable, u8 step, u16 ppm)
 
 static void gl9755_set_ssc_pll_205mhz(struct pci_dev *pdev)
 {
-	/* set pll to 205MHz and enable ssc */
-	gl9755_set_ssc(pdev, 0x1, 0xF, 0x5A1D);
+	bool enable = gl9755_ssc_enable(pdev);
+
+	/* set pll to 205MHz and ssc */
+	gl9755_set_ssc(pdev, enable, 0xF, 0x5A1D);
 	gl9755_set_pll(pdev, 0x1, 0x246, 0x0);
 }
 
 static void gl9755_set_ssc_pll_100mhz(struct pci_dev *pdev)
 {
-	/* set pll to 100MHz and enable ssc */
-	gl9755_set_ssc(pdev, 0x1, 0xE, 0x51EC);
+	bool enable = gl9755_ssc_enable(pdev);
+
+	/* set pll to 100MHz and ssc */
+	gl9755_set_ssc(pdev, enable, 0xE, 0x51EC);
 	gl9755_set_pll(pdev, 0x1, 0x244, 0x1);
 }
 
 static void gl9755_set_ssc_pll_50mhz(struct pci_dev *pdev)
 {
-	/* set pll to 50MHz and enable ssc */
-	gl9755_set_ssc(pdev, 0x1, 0xE, 0x51EC);
+	bool enable = gl9755_ssc_enable(pdev);
+
+	/* set pll to 50MHz and ssc */
+	gl9755_set_ssc(pdev, enable, 0xE, 0x51EC);
 	gl9755_set_pll(pdev, 0x1, 0x244, 0x3);
 }
 
-- 
2.34.1

