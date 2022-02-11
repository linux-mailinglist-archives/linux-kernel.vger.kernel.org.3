Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8724B213B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 10:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348119AbiBKJNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 04:13:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiBKJNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 04:13:09 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEB41026;
        Fri, 11 Feb 2022 01:13:08 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Jw79X5X6NzdZY0;
        Fri, 11 Feb 2022 17:09:52 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Feb 2022 17:13:06 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 11 Feb
 2022 17:13:06 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH] crypto: hisilicon/sec - add the register configuration for HW V3
Date:   Fri, 11 Feb 2022 17:07:58 +0800
Message-ID: <20220211090758.55352-1-yekai13@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added the register configuration of the SVA mode for HW V3.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec_main.c | 51 +++++++++++++++++++-----
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 89d4cc767d36..0b9906ff69e3 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -90,6 +90,10 @@
 					SEC_USER1_WB_DATA_SSV)
 #define SEC_USER1_SMMU_SVA		(SEC_USER1_SMMU_NORMAL | SEC_USER1_SVA_SET)
 #define SEC_USER1_SMMU_MASK		(~SEC_USER1_SVA_SET)
+#define SEC_INTERFACE_USER_CTRL0_REG_V3	0x302220
+#define SEC_INTERFACE_USER_CTRL1_REG_V3	0x302224
+#define SEC_USER1_SMMU_NORMAL_V3	(BIT(23) | BIT(17) | BIT(11) | BIT(5))
+#define SEC_USER1_SMMU_MASK_V3		0xFF79E79E
 #define SEC_CORE_INT_STATUS_M_ECC	BIT(2)
 
 #define SEC_PREFETCH_CFG		0x301130
@@ -335,6 +339,41 @@ static void sec_set_endian(struct hisi_qm *qm)
 	writel_relaxed(reg, qm->io_base + SEC_CONTROL_REG);
 }
 
+static void sec_engine_sva_config(struct hisi_qm *qm)
+{
+	u32 reg;
+
+	if (qm->ver > QM_HW_V2) {
+		reg = readl_relaxed(qm->io_base +
+				SEC_INTERFACE_USER_CTRL0_REG_V3);
+		reg |= SEC_USER0_SMMU_NORMAL;
+		writel_relaxed(reg, qm->io_base +
+				SEC_INTERFACE_USER_CTRL0_REG_V3);
+
+		reg = readl_relaxed(qm->io_base +
+				SEC_INTERFACE_USER_CTRL1_REG_V3);
+		reg &= SEC_USER1_SMMU_MASK_V3;
+		reg |= SEC_USER1_SMMU_NORMAL_V3;
+		writel_relaxed(reg, qm->io_base +
+				SEC_INTERFACE_USER_CTRL1_REG_V3);
+	} else {
+		reg = readl_relaxed(qm->io_base +
+				SEC_INTERFACE_USER_CTRL0_REG);
+		reg |= SEC_USER0_SMMU_NORMAL;
+		writel_relaxed(reg, qm->io_base +
+				SEC_INTERFACE_USER_CTRL0_REG);
+		reg = readl_relaxed(qm->io_base +
+				SEC_INTERFACE_USER_CTRL1_REG);
+		reg &= SEC_USER1_SMMU_MASK;
+		if (qm->use_sva)
+			reg |= SEC_USER1_SMMU_SVA;
+		else
+			reg |= SEC_USER1_SMMU_NORMAL;
+		writel_relaxed(reg, qm->io_base +
+				SEC_INTERFACE_USER_CTRL1_REG);
+	}
+}
+
 static void sec_open_sva_prefetch(struct hisi_qm *qm)
 {
 	u32 val;
@@ -426,17 +465,7 @@ static int sec_engine_init(struct hisi_qm *qm)
 	reg |= (0x1 << SEC_TRNG_EN_SHIFT);
 	writel_relaxed(reg, qm->io_base + SEC_CONTROL_REG);
 
-	reg = readl_relaxed(qm->io_base + SEC_INTERFACE_USER_CTRL0_REG);
-	reg |= SEC_USER0_SMMU_NORMAL;
-	writel_relaxed(reg, qm->io_base + SEC_INTERFACE_USER_CTRL0_REG);
-
-	reg = readl_relaxed(qm->io_base + SEC_INTERFACE_USER_CTRL1_REG);
-	reg &= SEC_USER1_SMMU_MASK;
-	if (qm->use_sva && qm->ver == QM_HW_V2)
-		reg |= SEC_USER1_SMMU_SVA;
-	else
-		reg |= SEC_USER1_SMMU_NORMAL;
-	writel_relaxed(reg, qm->io_base + SEC_INTERFACE_USER_CTRL1_REG);
+	sec_engine_sva_config(qm);
 
 	writel(SEC_SINGLE_PORT_MAX_TRANS,
 	       qm->io_base + AM_CFG_SINGLE_PORT_MAX_TRANS);
-- 
2.33.0

