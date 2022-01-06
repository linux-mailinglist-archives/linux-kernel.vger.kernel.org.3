Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C744860BA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 07:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbiAFGyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 01:54:23 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:38696 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234688AbiAFGyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 01:54:22 -0500
X-UUID: f73e721898794e26b8c142e34d23b077-20220106
X-UUID: f73e721898794e26b8c142e34d23b077-20220106
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1059487081; Thu, 06 Jan 2022 14:54:19 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 6 Jan 2022 14:54:18 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 6 Jan
 2022 14:54:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 6 Jan 2022 14:54:17 +0800
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     <lee.jones@linaro.org>, <robh+dt@kernel.org>, <broonie@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>
Subject: [PATCH 1/4] mfd: Add support for the MediaTek MT6366 PMIC
Date:   Thu, 6 Jan 2022 14:54:04 +0800
Message-ID: <20220106065407.16036-2-johnson.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220106065407.16036-1-johnson.wang@mediatek.com>
References: <20220106065407.16036-1-johnson.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the MediaTek MT6366 PMIC. This is a
multifunction device with the following sub modules:

- Regulator
- RTC
- Codec
- Interrupt

It is interfaced to the host controller using SPI interface
by a proprietary hardware called PMIC wrapper or pwrap.
MT6366 MFD is a child device of the pwrap.

Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
---
 drivers/mfd/mt6358-irq.c             | 1 +
 include/linux/mfd/mt6358/registers.h | 7 +++++++
 include/linux/mfd/mt6397/core.h      | 1 +
 3 files changed, 9 insertions(+)

diff --git a/drivers/mfd/mt6358-irq.c b/drivers/mfd/mt6358-irq.c
index 83f3ffbdbb4c..ea5e452510eb 100644
--- a/drivers/mfd/mt6358-irq.c
+++ b/drivers/mfd/mt6358-irq.c
@@ -212,6 +212,7 @@ int mt6358_irq_init(struct mt6397_chip *chip)
 
 	switch (chip->chip_id) {
 	case MT6358_CHIP_ID:
+	case MT6366_CHIP_ID:
 		chip->irq_data = &mt6358_irqd;
 		break;
 
diff --git a/include/linux/mfd/mt6358/registers.h b/include/linux/mfd/mt6358/registers.h
index 201139b12140..3d33517f178c 100644
--- a/include/linux/mfd/mt6358/registers.h
+++ b/include/linux/mfd/mt6358/registers.h
@@ -94,6 +94,10 @@
 #define MT6358_BUCK_VCORE_CON0                0x1488
 #define MT6358_BUCK_VCORE_DBG0                0x149e
 #define MT6358_BUCK_VCORE_DBG1                0x14a0
+#define MT6358_BUCK_VCORE_SSHUB_CON0          0x14a4
+#define MT6358_BUCK_VCORE_SSHUB_CON1          0x14a6
+#define MT6358_BUCK_VCORE_SSHUB_ELR0          MT6358_BUCK_VCORE_SSHUB_CON1
+#define MT6358_BUCK_VCORE_SSHUB_DBG1          MT6358_BUCK_VCORE_DBG1
 #define MT6358_BUCK_VCORE_ELR0                0x14aa
 #define MT6358_BUCK_VGPU_CON0                 0x1508
 #define MT6358_BUCK_VGPU_DBG0                 0x151e
@@ -169,6 +173,9 @@
 #define MT6358_LDO_VSRAM_OTHERS_CON0          0x1ba6
 #define MT6358_LDO_VSRAM_OTHERS_DBG0          0x1bc0
 #define MT6358_LDO_VSRAM_OTHERS_DBG1          0x1bc2
+#define MT6358_LDO_VSRAM_OTHERS_SSHUB_CON0    0x1bc4
+#define MT6358_LDO_VSRAM_OTHERS_SSHUB_CON1    0x1bc6
+#define MT6358_LDO_VSRAM_OTHERS_SSHUB_DBG1    MT6358_LDO_VSRAM_OTHERS_DBG1
 #define MT6358_LDO_VSRAM_GPU_CON0             0x1bc8
 #define MT6358_LDO_VSRAM_GPU_DBG0             0x1be2
 #define MT6358_LDO_VSRAM_GPU_DBG1             0x1be4
diff --git a/include/linux/mfd/mt6397/core.h b/include/linux/mfd/mt6397/core.h
index 56f210eebc54..1cf78726503b 100644
--- a/include/linux/mfd/mt6397/core.h
+++ b/include/linux/mfd/mt6397/core.h
@@ -14,6 +14,7 @@ enum chip_id {
 	MT6323_CHIP_ID = 0x23,
 	MT6358_CHIP_ID = 0x58,
 	MT6359_CHIP_ID = 0x59,
+	MT6366_CHIP_ID = 0x66,
 	MT6391_CHIP_ID = 0x91,
 	MT6397_CHIP_ID = 0x97,
 };
-- 
2.18.0

