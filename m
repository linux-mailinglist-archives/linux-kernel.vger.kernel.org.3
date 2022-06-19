Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E495509D4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 12:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbiFSKs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 06:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiFSKs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 06:48:57 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F6EF584;
        Sun, 19 Jun 2022 03:48:54 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LQqJ60pxszDrFS;
        Sun, 19 Jun 2022 18:48:22 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 19 Jun 2022 18:48:52 +0800
Received: from huawei.com (10.67.175.34) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 19 Jun
 2022 18:48:52 +0800
From:   Ren Zhijie <renzhijie2@huawei.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <reniuschengl@gmail.com>, <jasonlai.genesyslogic@gmail.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ren Zhijie <renzhijie2@huawei.com>
Subject: [PATCH -next] mmc: sdhci-pci-gli: Fix build error unused-function
Date:   Sun, 19 Jun 2022 18:47:12 +0800
Message-ID: <20220619104712.125364-1-renzhijie2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.175.34]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_PM is not set.

make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-, will be failed, like this:

drivers/mmc/host/sdhci-pci-gli.c:834:13: error: ‘gl9763e_set_low_power_negotiation’ defined but not used [-Werror=unused-function]
 static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slot, bool enable)
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[3]: *** [drivers/mmc/host/sdhci-pci-gli.o] Error 1

To fix building warning, wrap all related code with CONFIG_PM.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 78fe993ae714("mmc: host: Improve I/O read/write performance for GL9763E")
Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
---
 drivers/mmc/host/sdhci-pci-gli.c | 50 ++++++++++++++++----------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index a76506adc206..4d509f656188 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -831,31 +831,6 @@ static void sdhci_gl9763e_dumpregs(struct mmc_host *mmc)
 	sdhci_dumpregs(mmc_priv(mmc));
 }
 
-static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slot, bool enable)
-{
-	struct pci_dev *pdev = slot->chip->pdev;
-	u32 value;
-
-	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
-	value &= ~GLI_9763E_VHS_REV;
-	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_W);
-	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
-
-	pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG, &value);
-
-	if (enable)
-		value &= ~GLI_9763E_CFG_LPSN_DIS;
-	else
-		value |= GLI_9763E_CFG_LPSN_DIS;
-
-	pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG, value);
-
-	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
-	value &= ~GLI_9763E_VHS_REV;
-	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
-	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
-}
-
 static void sdhci_gl9763e_cqe_pre_enable(struct mmc_host *mmc)
 {
 	struct cqhci_host *cq_host = mmc->cqe_private;
@@ -991,6 +966,31 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
 }
 
 #ifdef CONFIG_PM
+static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slot, bool enable)
+{
+	struct pci_dev *pdev = slot->chip->pdev;
+	u32 value;
+
+	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
+	value &= ~GLI_9763E_VHS_REV;
+	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_W);
+	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG, &value);
+
+	if (enable)
+		value &= ~GLI_9763E_CFG_LPSN_DIS;
+	else
+		value |= GLI_9763E_CFG_LPSN_DIS;
+
+	pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG, value);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
+	value &= ~GLI_9763E_VHS_REV;
+	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
+	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
+}
+
 static int gl9763e_runtime_suspend(struct sdhci_pci_chip *chip)
 {
 	struct sdhci_pci_slot *slot = chip->slots[0];
-- 
2.17.1

