Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B968538995
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 03:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243438AbiEaBYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 21:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243349AbiEaBYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 21:24:06 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE7E94196
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 18:23:58 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220531012356epoutp0177670fb32cd29a85416a2fc1ef318901~0DBJl73w20723707237epoutp01y
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 01:23:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220531012356epoutp0177670fb32cd29a85416a2fc1ef318901~0DBJl73w20723707237epoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653960236;
        bh=QZHGho2JKSlEyIt4ZhoVZeWPhKB73n2EAzBRYPzripw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k3dassqiGazRdDroM0AN99ZTiNb5OWpwOgklrBw0Wl5wNCT97RUJwU7aajPfHiVl8
         wfQKPirI0sN/rw78Ayqg4m0j9IzLCM2V8mTf+YIRkX7clma42uhZAOXuyrKCYsdsOo
         V2H1F+LslMkrxqi2myVf4j2IJSSmI/mMN5u5jCLs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220531012351epcas5p3db0fb51226b0fa287c2468f610bc24c1~0DBFZZM5m3040830408epcas5p3p;
        Tue, 31 May 2022 01:23:51 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LBvgS2dpvz4x9QK; Tue, 31 May
        2022 01:23:48 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.5B.10063.42E65926; Tue, 31 May 2022 10:23:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220531012347epcas5p48262cae18c75bb6ed029f7cd920800b4~0DBB14DkA2668226682epcas5p4i;
        Tue, 31 May 2022 01:23:47 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220531012347epsmtrp2e9a64abf3508759450a76123798ec30d~0DBB0738X2334523345epsmtrp27;
        Tue, 31 May 2022 01:23:47 +0000 (GMT)
X-AuditID: b6c32a49-4cbff7000000274f-9b-62956e24a637
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.6F.11276.32E65926; Tue, 31 May 2022 10:23:47 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220531012344epsmtip2c93362e8a3348c22cacae47095827136~0DA_mL-cf1203612036epsmtip26;
        Tue, 31 May 2022 01:23:44 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, chanho61.park@samsung.com,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com, Bharat Uppal <bharat.uppal@samsung.com>
Subject: [PATCH 3/6] phy: samsung-ufs: add support for FSD ufs phy driver
Date:   Tue, 31 May 2022 06:52:17 +0530
Message-Id: <20220531012220.80563-4-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220531012220.80563-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmlq5K3tQkg8vbhSwezNvGZvHy51U2
        i2svL7BbTPvwk9ni8n5ti/lHzrFa9L14yGyx6fE1VouHr8ItLu+aw2YxYdU3Fovu6zvYLJYf
        /8dksWjrF3aL1r1H2C123jnB7CDgcfmKt8emVZ1sHneu7WHz2Lyk3uPj01ssHn1bVjF6/Gua
        y+7xeZOcR/uBbqYAzqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRb
        JRefAF23zBygH5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BSYFesWJucWleel6
        eaklVoYGBkamQIUJ2RkPL/xlKriuVHGzbxJ7A+Mv2S5GTg4JAROJtWt/s3QxcnEICexmlOj4
        1sIIkhAS+MQoMWU1N0TiG6PEjuVLWGE6du45wgaR2Mso8fLPVyYIp4VJYt6vj2BVbALaEnen
        bwFLiAg0M0oc7NgF5jALnGOSeLZ3A5DDwSEs4ClxdL4YSAOLgKrE6/fL2EFsXgEbidZPe5kh
        1slLrN5wAMzmFLCV6N54GmyOhMBCDonNn84zQRS5SHTcb2WHsIUlXh3fAmVLSXx+t5cNZJeE
        gIfEoj9SEOEMibfL1zNC2PYSB67MYQEpYRbQlFi/Sx8kzCzAJ9H7+wkTRCevREebEES1qkTz
        u6ssELa0xMTubmigeEg0d+1jhITDBEaJA2e3s01glJ2FMHUBI+MqRsnUguLc9NRi0wLDvNRy
        eEQl5+duYgQnTS3PHYx3H3zQO8TIxMF4iFGCg1lJhNcqYmqSEG9KYmVValF+fFFpTmrxIUZT
        YJBNZJYSTc4Hpu28knhDE0sDEzMzMxNLYzNDJXFegf+NSUIC6YklqdmpqQWpRTB9TBycUg1M
        Trd0vFTMvp/bUSH2y4rx/c7UV1faFEzygqbfcCsKKAvsV8irP6yy3m9HWOY0/kUr6tberY/k
        vhbE0WT7tjQt7OOuD87MxjW7C+8ufD1b7N/0tscy+zJ3r2vn0HmqEfVc5KjUUZ7v/GYeEZdD
        BE65PCtJq3P7xLjh7vzTezUuBGiq3ozcevcks0L4ZcPOi0Vb3gglhczQmLm4I2jX1K7dF7Xt
        n60y27C/+6Hfn3d6H59c0BNKjJUQmCd7o6xL5/rPfFvJa3KuRe2nYpkXzZhXvTTw8WrLxUsm
        C5tutf+2fq+53u3gkH+f3PbWJJh7G0vcvL9u+8YP/1vrU9s3LTauXrL4x//TJ8KT+F4JFV/8
        qcRSnJFoqMVcVJwIAGodk5MjBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsWy7bCSvK5y3tQkg6Y1phYP5m1js3j58yqb
        xbWXF9gtpn34yWxxeb+2xfwj51gt+l48ZLbY9Pgaq8XDV+EWl3fNYbOYsOobi0X39R1sFsuP
        /2OyWLT1C7tF694j7BY775xgdhDwuHzF22PTqk42jzvX9rB5bF5S7/Hx6S0Wj74tqxg9/jXN
        Zff4vEnOo/1AN1MAZxSXTUpqTmZZapG+XQJXxsMLf5kKritV3OybxN7A+Eu2i5GTQ0LARGLn
        niNsXYxcHEICuxkl/p5ezgKRkJa4vnECO4QtLLHy33MwW0igiUli1odcEJtNQFvi7vQtTCC2
        iEA7o8T97WwgNrPAHSaJVT0iXYwcHMICnhJH54uBhFkEVCVev18GNoZXwEai9dNeZojx8hKr
        NxwAszkFbCW6N55mglhlI/H4/muWCYx8CxgZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn
        525iBAe7luYOxu2rPugdYmTiYDzEKMHBrCTCaxUxNUmINyWxsiq1KD++qDQntfgQozQHi5I4
        74Wuk/FCAumJJanZqakFqUUwWSYOTqkGpnDmI+/XzwvdJbU1bvVE88Tnx69zcomfsMx9290Y
        sdIjdOH7C1msbm+0ew6pxYlnXAvPmPoguKwvUVjvZbxe+HIPx+3PmE6WTMi48D4tym1po+L0
        18oynpvSkrju3t7U4nj9w5Nrr4wb9n2a0MbymPnNtP//NgnM8DgmPqVx5gzmzWXn1LV4atnF
        PhfN/r83aFaZpJjL4Wc3j936duFo4hfOQtGraz6qKLNr79/dHDdlZ6xO4s16g0usdVY3kt7+
        E9Tveq74/8TpDpZ9K037xYvOmns4q/v+j+XwdtYx7JL3PznLkrvw2axHU679fvb9rE23YD13
        bEhastfO1GWPtu8qTzzeybCQY5NqS71WpxJLcUaioRZzUXEiAFtSiELlAgAA
X-CMS-MailID: 20220531012347epcas5p48262cae18c75bb6ed029f7cd920800b4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220531012347epcas5p48262cae18c75bb6ed029f7cd920800b4
References: <20220531012220.80563-1-alim.akhtar@samsung.com>
        <CGME20220531012347epcas5p48262cae18c75bb6ed029f7cd920800b4@epcas5p4.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for Tesla FSD ufs phy driver. This SoC has
different cdr lock status offset.

Cc: linux-fsd@tesla.com
Signed-off-by: Bharat Uppal <bharat.uppal@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/phy/samsung/Makefile          |  1 +
 drivers/phy/samsung/phy-fsd-ufs.c     | 63 +++++++++++++++++++++++++++
 drivers/phy/samsung/phy-samsung-ufs.c |  3 ++
 drivers/phy/samsung/phy-samsung-ufs.h |  1 +
 4 files changed, 68 insertions(+)
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
index 000000000000..a03656006093
--- /dev/null
+++ b/drivers/phy/samsung/phy-fsd-ufs.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * UFS PHY driver data for FSD SoC
+ *
+ * Copyright (C) 2022 Samsung Electronics Co., Ltd.
+ *
+ */
+#ifndef _PHY_FSD_UFS_H_
+#define _PHY_FSD_UFS_H_
+
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
+	.cfg = fsd_ufs_phy_cfgs,
+	.isol = {
+		.offset = FSD_EMBEDDED_COMBO_PHY_CTRL,
+		.mask = FSD_EMBEDDED_COMBO_PHY_CTRL_MASK,
+		.en = FSD_EMBEDDED_COMBO_PHY_CTRL_EN,
+	},
+	.has_symbol_clk = 0,
+	.cdr_lock_status_offset = FSD_EMBEDDED_COMBO_PHY_CDR_LOCK_STATUS,
+};
+
+#endif /* _PHY_FSD_UFS_H_ */
diff --git a/drivers/phy/samsung/phy-samsung-ufs.c b/drivers/phy/samsung/phy-samsung-ufs.c
index 8e5ae228daa7..935c5c7a6d1e 100644
--- a/drivers/phy/samsung/phy-samsung-ufs.c
+++ b/drivers/phy/samsung/phy-samsung-ufs.c
@@ -351,6 +351,9 @@ static const struct of_device_id samsung_ufs_phy_match[] = {
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
index 965c79bbc278..74b40ef8e1d8 100644
--- a/drivers/phy/samsung/phy-samsung-ufs.h
+++ b/drivers/phy/samsung/phy-samsung-ufs.h
@@ -142,5 +142,6 @@ static inline void samsung_ufs_phy_ctrl_isol(
 
 extern const struct samsung_ufs_phy_drvdata exynos7_ufs_phy;
 extern const struct samsung_ufs_phy_drvdata exynosautov9_ufs_phy;
+extern const struct samsung_ufs_phy_drvdata fsd_ufs_phy;
 
 #endif /* _PHY_SAMSUNG_UFS_ */
-- 
2.25.1

