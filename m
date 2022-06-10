Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58193545D8C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 09:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243306AbiFJHch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 03:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346826AbiFJHcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:32:17 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E44BC3677
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 00:32:16 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220610073214epoutp022a445ce254f1967fcc246120140f966e~3Mfk3eDTz3245632456epoutp02b
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 07:32:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220610073214epoutp022a445ce254f1967fcc246120140f966e~3Mfk3eDTz3245632456epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654846334;
        bh=Zwh7Hr4XDNfX7kBs2C7Phc2QNJBHBWWN7lO79T0gx4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HiaA/Z8v0KX0JVXG4rhBanJXek48oC1pYYvgBoPfxvQZdDeiU3+yf9qNhgxMUJ9QG
         +0ropi2irGXzLjCwIUd+wsh9R1VM792HViUnYXo2E6ecknNnNLSs7gSUpMderROYqU
         sJoUTNbFQ9uePS5gMfQlE1nYC4ZGMKTYdXNXJAmA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220610073213epcas5p2dabab2eaedde51a924697195a4635648~3MfkTfONw2709327093epcas5p2x;
        Fri, 10 Jun 2022 07:32:13 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LKCMt3wt1z4x9Q0; Fri, 10 Jun
        2022 07:32:10 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        01.E4.09762.873F2A26; Fri, 10 Jun 2022 16:32:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220610073208epcas5p12ffaef419e29bc4bd3209df59057091b~3MffF4Tsr0494704947epcas5p1m;
        Fri, 10 Jun 2022 07:32:08 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220610073208epsmtrp2c97993953c42b98911899c22716fb481~3MffFCcvR1442314423epsmtrp2h;
        Fri, 10 Jun 2022 07:32:08 +0000 (GMT)
X-AuditID: b6c32a4b-1fdff70000002622-fc-62a2f378356d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C2.4E.08924.873F2A26; Fri, 10 Jun 2022 16:32:08 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220610073204epsmtip14406c529124ed16f4b9df378ba068200~3Mfb4foV13109631096epsmtip1W;
        Fri, 10 Jun 2022 07:32:04 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, chanho61.park@samsung.com,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        Bharat Uppal <bharat.uppal@samsung.com>
Subject: [PATCH v3 3/6] phy: samsung-ufs: add support for FSD ufs phy driver
Date:   Fri, 10 Jun 2022 12:59:21 +0530
Message-Id: <20220610072924.12362-4-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220610072924.12362-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnk+LIzCtJLcpLzFFi42LZdlhTS7fi86Ikg7OHNCwezNvGZvHy51U2
        i2svL7BbTPvwk9ni8n5ti/lHzrFa9L14yGyx6fE1VovLu+awWUxY9Y3Fovv6DjaL5cf/MVks
        2vqF3aJ17xF2i513TjA78HtcvuLtsWlVJ5vHnWt72Dw2L6n3+Pj0FotH35ZVjB6fN8l5tB/o
        ZgrgiMq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAE6
        XUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFKgV5yYW1yal66Xl1piZWhgYGQK
        VJiQndGz+wJbwQalin1HpjM3MN6T7WLk5JAQMJH4cGQJG4gtJLCbUeLfAecuRi4g+xOjxI3T
        z5khnM+MEtc/f2aH6Xjy8ioTRGIXo8TqDx+gnBYmicXvvzGBVLEJaEvcnb4FLCEi0MwocbBj
        F5jDLLCTSeLi7+nMIFXCAj4SFxa8AZvLIqAqsWRPI9AlHBy8AjYSkw8pQKyTl1i94QBYOaeA
        rcTZ/xvAbpIQmMohsb73HQtEkYvEmTl3oe4Tlnh1fAuULSXx+d1esJkSAh4Si/5IQYQzJN4u
        X88IYdtLHLgyhwWkhFlAU2L9Ln2QMLMAn0Tv7ydMEJ28Eh1tQhDVqhLN765CLZWWmNjdzQph
        e0g0vexlgYTDBEaJmQ1tTBMYZWchTF3AyLiKUTK1oDg3PbXYtMA4L7UcHlHJ+bmbGMEpUst7
        B+OjBx/0DjEycTAeYpTgYFYS4Q24vShJiDclsbIqtSg/vqg0J7X4EKMpMMQmMkuJJucDk3Re
        SbyhiaWBiZmZmYmlsZmhkjivwP/GJCGB9MSS1OzU1ILUIpg+Jg5OqQamw+azHL7t4r9Ys95H
        P8xT2f9W4/p5j0ui+x//U9i1ecMcyctu6YcNE5wMW01uMv1+smRiyKz1Iis1z/5p/M6/bY2F
        D7Mk81u7P8/CzVb8SsyT2WOjuzJIrKo1cslGI6W005blRr4nX4Z0Fqz83L72qwSnvMiqL0cu
        G3GK5T05kqfxkdtn/dsfDum3ZrSw9Xs53tCf7Hlj1Q612Z3nm2PDmjUn28wSe6p4Mv2Mm7Yt
        v/HcGQb3vx5MnbF9crZt/NyPx0yWf2d5b3sv/sDW13IV/VKL41mN5FIvOYanLv9xXjHFXIul
        tf3i/usbrb+zpUdU8pdJHOAvN5r7tlVA41XTja0aZy/Of6yuac4XwxemxFKckWioxVxUnAgA
        ECLDqxoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsWy7bCSnG7F50VJBs+7+S0ezNvGZvHy51U2
        i2svL7BbTPvwk9ni8n5ti/lHzrFa9L14yGyx6fE1VovLu+awWUxY9Y3Fovv6DjaL5cf/MVks
        2vqF3aJ17xF2i513TjA78HtcvuLtsWlVJ5vHnWt72Dw2L6n3+Pj0FotH35ZVjB6fN8l5tB/o
        ZgrgiOKySUnNySxLLdK3S+DK6Nl9ga1gg1LFviPTmRsY78l2MXJySAiYSDx5eZWpi5GLQ0hg
        B6PEtHvzWCAS0hLXN05gh7CFJVb+ew5mCwk0MUns38MBYrMJaEvcnb6FCcQWEWhnlLi/nQ1k
        ELPAUSaJ5aeOMYMkhAV8JC4seAPWzCKgKrFkTyNQEQcHr4CNxORDChDz5SVWbzgAVs4pYCtx
        9v8GZpASIaCS13/zJjDyLWBkWMUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERzaWlo7
        GPes+qB3iJGJg/EQowQHs5IIb8DtRUlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhP
        LEnNTk0tSC2CyTJxcEo1MHEk9stvOsjDerZm3528nVeyNl1lkP75auKnlDOanuoSeeu5blnY
        6V/T/NI3mW35EY5VDd5rrW/OFTjKFcnxcd+tr9LHJXM19m8V3Ne2ud9humPmnh0vRTR1P58I
        33d0p/wnnxeCObpGqp3iqdk3HngaVF99cSvddKLOqhtMy4UuRol3TDnasPgu+z2l3uTlTtPU
        w9f96tyffHwq45Q0iV67dS9PBxRzr3G3uqxkOs+1vXqNtdWbg3ePTLwrP2nLs6P8vYH+BTlZ
        fp657tpRaxVLHp/ZxXH8pHKt9FrH+8Uhq3KMamUsdCu7fT3S3vPJc360Ob2Y/6bUFdHQ/0+6
        7/4PdnQ+PNeU6bWJ3xFudyWW4oxEQy3mouJEAOkpgBHcAgAA
X-CMS-MailID: 20220610073208epcas5p12ffaef419e29bc4bd3209df59057091b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220610073208epcas5p12ffaef419e29bc4bd3209df59057091b
References: <20220610072924.12362-1-alim.akhtar@samsung.com>
        <CGME20220610073208epcas5p12ffaef419e29bc4bd3209df59057091b@epcas5p1.samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for Tesla Full Self-Driving (FSD) ufs phy driver.
This SoC has different cdr lock status offset.

Signed-off-by: Bharat Uppal <bharat.uppal@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Reviewed-by: Chanho Park <chanho61.park@samsung.com>
---
 drivers/phy/samsung/Makefile          |  1 +
 drivers/phy/samsung/phy-fsd-ufs.c     | 58 +++++++++++++++++++++++++++
 drivers/phy/samsung/phy-samsung-ufs.c |  3 ++
 drivers/phy/samsung/phy-samsung-ufs.h |  1 +
 4 files changed, 63 insertions(+)
 create mode 100644 drivers/phy/samsung/phy-fsd-ufs.c

diff --git a/drivers/phy/samsung/Makefile b/drivers/phy/samsung/Makefile
index 65e4cc59403f..afb34a153e34 100644
--- a/drivers/phy/samsung/Makefile
+++ b/drivers/phy/samsung/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_PHY_SAMSUNG_UFS)		+= phy-exynos-ufs.o
 phy-exynos-ufs-y			+= phy-samsung-ufs.o
 phy-exynos-ufs-y			+= phy-exynos7-ufs.o
 phy-exynos-ufs-y			+= phy-exynosautov9-ufs.o
+phy-exynos-ufs-y			+= phy-fsd-ufs.o
 obj-$(CONFIG_PHY_SAMSUNG_USB2)		+= phy-exynos-usb2.o
 phy-exynos-usb2-y			+= phy-samsung-usb2.o
 phy-exynos-usb2-$(CONFIG_PHY_EXYNOS4210_USB2)	+= phy-exynos4210-usb2.o
diff --git a/drivers/phy/samsung/phy-fsd-ufs.c b/drivers/phy/samsung/phy-fsd-ufs.c
new file mode 100644
index 000000000000..c78b6c16027d
--- /dev/null
+++ b/drivers/phy/samsung/phy-fsd-ufs.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * UFS PHY driver data for FSD SoC
+ *
+ * Copyright (C) 2022 Samsung Electronics Co., Ltd.
+ *
+ */
+#include "phy-samsung-ufs.h"
+
+#define FSD_EMBEDDED_COMBO_PHY_CTRL	0x724
+#define FSD_EMBEDDED_COMBO_PHY_CTRL_MASK	0x1
+#define FSD_EMBEDDED_COMBO_PHY_CTRL_EN	BIT(0)
+#define FSD_EMBEDDED_COMBO_PHY_CDR_LOCK_STATUS	0x6e
+
+static const struct samsung_ufs_phy_cfg fsd_pre_init_cfg[] = {
+	PHY_COMN_REG_CFG(0x00f, 0xfa, PWR_MODE_ANY),
+	PHY_COMN_REG_CFG(0x010, 0x82, PWR_MODE_ANY),
+	PHY_COMN_REG_CFG(0x011, 0x1e, PWR_MODE_ANY),
+	PHY_COMN_REG_CFG(0x017, 0x94, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG(0x035, 0x58, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG(0x036, 0x32, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG(0x037, 0x40, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG(0x03b, 0x83, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG(0x042, 0x88, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG(0x043, 0xa6, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG(0x048, 0x74, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG(0x04c, 0x5b, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG(0x04d, 0x83, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG(0x05c, 0x14, PWR_MODE_ANY),
+	END_UFS_PHY_CFG
+};
+
+/* Calibration for HS mode series A/B */
+static const struct samsung_ufs_phy_cfg fsd_pre_pwr_hs_cfg[] = {
+	END_UFS_PHY_CFG
+};
+
+/* Calibration for HS mode series A/B atfer PMC */
+static const struct samsung_ufs_phy_cfg fsd_post_pwr_hs_cfg[] = {
+	END_UFS_PHY_CFG
+};
+
+static const struct samsung_ufs_phy_cfg *fsd_ufs_phy_cfgs[CFG_TAG_MAX] = {
+	[CFG_PRE_INIT]		= fsd_pre_init_cfg,
+	[CFG_PRE_PWR_HS]	= fsd_pre_pwr_hs_cfg,
+	[CFG_POST_PWR_HS]	= fsd_post_pwr_hs_cfg,
+};
+
+const struct samsung_ufs_phy_drvdata fsd_ufs_phy = {
+	.cfgs = fsd_ufs_phy_cfgs,
+	.isol = {
+		.offset = FSD_EMBEDDED_COMBO_PHY_CTRL,
+		.mask = FSD_EMBEDDED_COMBO_PHY_CTRL_MASK,
+		.en = FSD_EMBEDDED_COMBO_PHY_CTRL_EN,
+	},
+	.has_symbol_clk = 0,
+	.cdr_lock_status_offset = FSD_EMBEDDED_COMBO_PHY_CDR_LOCK_STATUS,
+};
diff --git a/drivers/phy/samsung/phy-samsung-ufs.c b/drivers/phy/samsung/phy-samsung-ufs.c
index 7218acd2b113..565945d6b5b3 100644
--- a/drivers/phy/samsung/phy-samsung-ufs.c
+++ b/drivers/phy/samsung/phy-samsung-ufs.c
@@ -357,6 +357,9 @@ static const struct of_device_id samsung_ufs_phy_match[] = {
 	}, {
 		.compatible = "samsung,exynosautov9-ufs-phy",
 		.data = &exynosautov9_ufs_phy,
+	}, {
+		.compatible = "tesla,fsd-ufs-phy",
+		.data = &fsd_ufs_phy,
 	},
 	{},
 };
diff --git a/drivers/phy/samsung/phy-samsung-ufs.h b/drivers/phy/samsung/phy-samsung-ufs.h
index 913542ebff7a..6320ac852f29 100644
--- a/drivers/phy/samsung/phy-samsung-ufs.h
+++ b/drivers/phy/samsung/phy-samsung-ufs.h
@@ -145,5 +145,6 @@ static inline void samsung_ufs_phy_ctrl_isol(
 
 extern const struct samsung_ufs_phy_drvdata exynos7_ufs_phy;
 extern const struct samsung_ufs_phy_drvdata exynosautov9_ufs_phy;
+extern const struct samsung_ufs_phy_drvdata fsd_ufs_phy;
 
 #endif /* _PHY_SAMSUNG_UFS_ */
-- 
2.25.1

