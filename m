Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B888D546481
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 12:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344241AbiFJKso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 06:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344892AbiFJKrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:47:51 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554BB2D4453
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 03:43:57 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220610104355epoutp026598c1091fd8f311c9366549b0809e39~3PG8RZhiq1293812938epoutp02D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 10:43:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220610104355epoutp026598c1091fd8f311c9366549b0809e39~3PG8RZhiq1293812938epoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654857835;
        bh=wkkRjsvyD/266EqxxIhA3u8J1xvGM7NxGs8uYuRodrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l6FehvDOGuA9wk82OX7WYVWtrxd2cya1OOgsvFBv86uONldh8Ru1JbvbjWYQGhlIJ
         V15rmN+Xque2u9GN6XytWVedh+s7kmDCYZ98EnEod2qHG/PfGraezjPkeqDNWWceH9
         FMICkpRkySNVVOYsAG4taj7Vmq7x9z2NT4Yhdu20=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220610104354epcas5p1acf9a382d7229a9de0013ff28774fa86~3PG62ihBz2050120501epcas5p15;
        Fri, 10 Jun 2022 10:43:54 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LKHd26sMVz4x9Pw; Fri, 10 Jun
        2022 10:43:50 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        13.7E.10063.66023A26; Fri, 10 Jun 2022 19:43:50 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220610104350epcas5p2a42643432e60d7ba18f2a2afcffadfaf~3PG3NMYth1105611056epcas5p2U;
        Fri, 10 Jun 2022 10:43:50 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220610104350epsmtrp14de4b88a5ce0ad43f1ad0bb0eefa3229~3PG3MZBxd1337313373epsmtrp1R;
        Fri, 10 Jun 2022 10:43:50 +0000 (GMT)
X-AuditID: b6c32a49-4cbff7000000274f-ee-62a32066ba53
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8D.B0.11276.66023A26; Fri, 10 Jun 2022 19:43:50 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220610104347epsmtip10b55cdb74a963ef3fed89a3271b59344~3PG0o4g5J1361413614epsmtip1S;
        Fri, 10 Jun 2022 10:43:47 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, chanho61.park@samsung.com,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        Bharat Uppal <bharat.uppal@samsung.com>
Subject: [PATCH v4 3/6] phy: samsung-ufs: add support for FSD ufs phy driver
Date:   Fri, 10 Jun 2022 16:11:16 +0530
Message-Id: <20220610104119.66401-4-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220610104119.66401-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdlhTSzdNYXGSwbkZRhYP5m1js3j58yqb
        xbWXF9gtpn34yWxxeb+2xfwj51gt+l48ZLbY9Pgaq8XlXXPYLCas+sZi0X19B5vF8uP/mCwW
        bf3CbtG69wi7xc47J5gd+D0uX/H22LSqk83jzrU9bB6bl9R7fHx6i8Wjb8sqRo/Pm+Q82g90
        MwVwRGXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gCd
        rqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCnQK07MLS7NS9fLSy2xMjQwMDIF
        KkzIzmg++YSlYINSxd2zf9kaGO/JdjFyckgImEic3LiapYuRi0NIYDejxPU9D6CcT4wSnTtW
        sUE43xgl2rv/sXcxcoC1/GothIjvZZR493MdM4TTwiQx53k3M8hcNgFtibvTtzCBJEQEmhkl
        DnbsAnOYBXYySVz8PR2sSljAR2Lh3xPsIDaLgKrE8ZP/WEBsXgEbiRszJrFDXCgvsXrDAbB6
        TgFbiWfrL7OCDJIQmMohse3vAxaIIheJlksPGSFsYYlXx7dANUtJvOxvg7rbQ2LRHymIcIbE
        2+XrocrtJQ5cmcMCUsIsoCmxfpc+SJhZgE+i9/cTJohOXomONiGIalWJ5ndXoZZKS0zs7maF
        sD0kjl2bAQ26CYwSa7/8YJrAKDsLYeoCRsZVjJKpBcW56anFpgWGeanl8JhKzs/dxAhOklqe
        OxjvPvigd4iRiYPxEKMEB7OSCG/A7UVJQrwpiZVVqUX58UWlOanFhxhNgUE2kVlKNDkfmKbz
        SuINTSwNTMzMzEwsjc0MlcR5Bf43JgkJpCeWpGanphakFsH0MXFwSjUwuXmsl/i5Tbgr97nj
        U+sf7q2LNAR4px/lWF+UuEquyqp4dviTY3dnJMotjfRn1bnoaGHiq9Ll+2Ri38+Js5Qaqte5
        +Lw23y40TfFJc8G5r0dvrI7OYXh51ifr8JqJSrt0J5/idVcNFdrDNEnh/p1nSS9cWdW6tlux
        fvzgdKgn6r+poqHq2+p7UdtKKkqSIndkaW3du25SeeUxnYytwdLPmp33xOnfyIj07jhaL+/w
        7/n/lJNcvg/EFOqY+XgjzdQctFnazzZnpNslzb6c7Bkwd67QohtrT9vc67tacPzzgr0XNFaa
        bpj87fcHl/UyHkG5svwf1Jk/de/6pKVvsra8rl560pIm0XR5twMXLr9SYinOSDTUYi4qTgQA
        MSAckhsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWy7bCSnG6awuIkg8N/BS0ezNvGZvHy51U2
        i2svL7BbTPvwk9ni8n5ti/lHzrFa9L14yGyx6fE1VovLu+awWUxY9Y3Fovv6DjaL5cf/MVks
        2vqF3aJ17xF2i513TjA78HtcvuLtsWlVJ5vHnWt72Dw2L6n3+Pj0FotH35ZVjB6fN8l5tB/o
        ZgrgiOKySUnNySxLLdK3S+DKaD75hKVgg1LF3bN/2RoY78l2MXJwSAiYSPxqLexi5OIQEtjN
        KLG/8TZ7FyMnUFxa4vrGCVC2sMTKf8/BbCGBJiaJ5WfKQGw2AW2Ju9O3MIHYIgLtjBL3t7OB
        DGIWOApUc+oYM0hCWMBHYuHfE2DNLAKqEsdP/mMBsXkFbCRuzJgEtUBeYvWGA2D1nAK2Es/W
        X2aFWGYjsbjjHPMERr4FjAyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGCg1tLcwfj
        9lUf9A4xMnEwHmKU4GBWEuENuL0oSYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6Ykl
        qdmpqQWpRTBZJg5OqQYm56oOoc2yp26s+nC3ki1owjLfSwdSF37ksfeR1vikvTbm3meF7wum
        7f/1Y/mH7w1Oz/OFfucwlFho8iot8mTKVvp1Wljl0MacOW8OtjkqmR3r4mWKedC0c9vtKfOa
        vc9JLsjn0LoltVFi14rYz5ecWWykz/0XrPT6tWyP391Nl6c0nwuUmnzR68DOWsasj3mr6j7r
        zl7my2fZvu8TJ+fcBSnG/zdUqThf1Pq/+Z7JLqWNrLdqwv/ER34NqTd7+39p2NQN82y8N9QW
        PHd079CJinfvfi7GMvnH35QzbTaNzkJHdmr+F/c36PWZz8T0JnXNM71j96vqF2trqCauKjn/
        VizD4umkXcV5p6LdohovK7EUZyQaajEXFScCAGuN3BTdAgAA
X-CMS-MailID: 20220610104350epcas5p2a42643432e60d7ba18f2a2afcffadfaf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220610104350epcas5p2a42643432e60d7ba18f2a2afcffadfaf
References: <20220610104119.66401-1-alim.akhtar@samsung.com>
        <CGME20220610104350epcas5p2a42643432e60d7ba18f2a2afcffadfaf@epcas5p2.samsung.com>
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
index 8cec7652b459..e4334529ffbc 100644
--- a/drivers/phy/samsung/phy-samsung-ufs.c
+++ b/drivers/phy/samsung/phy-samsung-ufs.c
@@ -358,6 +358,9 @@ static const struct of_device_id samsung_ufs_phy_match[] = {
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

