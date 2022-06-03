Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09EA53CC90
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245712AbiFCPtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245698AbiFCPtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:49:05 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F0B50B04
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 08:49:03 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220603154902epoutp04af5eb7f154c49420b4db04fb22995838~1JwVjKVX_2786727867epoutp04Z
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 15:49:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220603154902epoutp04af5eb7f154c49420b4db04fb22995838~1JwVjKVX_2786727867epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654271342;
        bh=tg4qENaeXxsFQ4nawnPt0oXoXanezuoNV36RT0/GJEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZFKdKi0ocV8Ytr/dIwiFKCboW1PbJX/d3sSAAsbT3SQSWhdE9bQcYealkOnNb+g5v
         l4udod/UDOU70rKIuT4NQ1CObcaOk8l8NtmRqrwxc0qSDgIYcnUvGmfh1w8eJDwBvq
         Cyu4b1F8rjTZa9n+pIPw8a9Ho7pbQ4DbhDUYWOv8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220603154901epcas5p200441d6744ceba02d5df186768d16d5c~1JwUqA95g3002730027epcas5p2x;
        Fri,  3 Jun 2022 15:49:01 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LF6kK6FVLz4x9Pv; Fri,  3 Jun
        2022 15:48:57 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.A8.10063.96D2A926; Sat,  4 Jun 2022 00:48:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220603154857epcas5p4b4684d4400f4ff66f69ff5e288ef635c~1JwQtube91903319033epcas5p4b;
        Fri,  3 Jun 2022 15:48:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220603154857epsmtrp2723d08a094d931a7ca27a33972a1ba54~1JwQs2LBd0407504075epsmtrp2q;
        Fri,  3 Jun 2022 15:48:57 +0000 (GMT)
X-AuditID: b6c32a49-4cbff7000000274f-41-629a2d69b1a0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C4.6C.11276.86D2A926; Sat,  4 Jun 2022 00:48:56 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220603154854epsmtip1211e12a37cb846277586f560a334fa8a~1JwOpPn_F2493724937epsmtip1T;
        Fri,  3 Jun 2022 15:48:54 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, chanho61.park@samsung.com,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        Bharat Uppal <bharat.uppal@samsung.com>
Subject: [PATCH v2 3/7] phy: samsung-ufs: add support for FSD ufs phy driver
Date:   Fri,  3 Jun 2022 21:17:10 +0530
Message-Id: <20220603154714.30532-4-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220603154714.30532-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdlhTXTdTd1aSQds1fYsH87axWbz8eZXN
        4trLC+wW0z78ZLa4vF/bYv6Rc6wWfS8eMltsenyN1eLyrjlsFhNWfWOx6L6+g81i+fF/TBaL
        tn5ht2jde4TdYuedE8wO/B6Xr3h7bFrVyeZx59oeNo/NS+o9Pj69xeLRt2UVo8fnTXIe7Qe6
        mQI4orJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4BO
        V1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoYGJkC
        FSZkZ8x9uZ2l4KdiRdumBSwNjGtkuxjZOSQETCT+aXUxcnIICexmlOhaVt7FyAVkf2KUmH/2
        MiuE841R4tquy8wgVSD1n3b8YYdI7GWUWNY9gQXCaWGSWLvkJhNIFZuAtsTd6VuYQBIiAs2M
        Egc7doE5zAI7mSQu/p4ONktYwEfi8dEmVhCbRUBV4sbESYwgNq+AjcSM5jdQ++QlVm84AGRz
        cHAK2EpMPc0HEZ7JIXH+qgxIWELARWLLIhaIsLDEq+Nb2CFsKYnP7/ayQZR4SCz6IwURzpB4
        u3w9I4RtL3HgyhwWkBJmAU2J9bv0QcLMAnwSvb+fMEF08kp0tAlBVKtKNL+7CrVIWmJidzcr
        hO0hca3vIDSsJjBK7Ji9kGUCo+wshKkLGBlXMUqmFhTnpqcWmxYY5qWWwyMpOT93EyM4NWp5
        7mC8++CD3iFGJg7GQ4wSHMxKIrxl82YmCfGmJFZWpRblxxeV5qQWH2I0BYbXRGYp0eR8YHLO
        K4k3NLE0MDEzMzOxNDYzVBLnFfjfmCQkkJ5YkpqdmlqQWgTTx8TBKdXAFLvE2LFJ4+N2Y7Wq
        6VWymjb3DpktY+bViT4aeMcuhWmjfRHvu9zj32Q1mPZYaaR3qGzWOaPpnZ2jJi69fqpe+QTT
        G+/vs1eUCm87rjCB4QW3geXh83/OFAdNErzg92eXo9z1POnSLWkef6tNmlPd3kkdCtBKelhQ
        cL3+aotX5qNo3tb9NTymYc1lqrW2vinPDvCynQ+JkPSbVSx38brP4d9ZKQn+LZc0Vu86uIGh
        bLbqEouENxzT1xR+czafnv/wonEl+yGpk0l8mrfu+axfXf/1nPLcDjPLaTn5qu/Lr5StUzB5
        /8LFcN+LAN7evjnZSbX9E2qVXipb7j/7XC8xcqZvVJHZzhN/9vaZn1NiKc5INNRiLipOBABw
        5Q9rFgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWy7bCSnG6G7qwkg2efLS0ezNvGZvHy51U2
        i2svL7BbTPvwk9ni8n5ti/lHzrFa9L14yGyx6fE1VovLu+awWUxY9Y3Fovv6DjaL5cf/MVks
        2vqF3aJ17xF2i513TjA78HtcvuLtsWlVJ5vHnWt72Dw2L6n3+Pj0FotH35ZVjB6fN8l5tB/o
        ZgrgiOKySUnNySxLLdK3S+DKmPtyO0vBT8WKtk0LWBoY18h2MXJySAiYSHza8Ye9i5GLQ0hg
        N6NEw+sHrBAJaYnrGyewQ9jCEiv/PYcqamKSaDvWyQKSYBPQlrg7fQsTiC0i0M4ocX87G0gR
        s8BRJonlp44xgySEBXwkHh9tApvKIqAqcWPiJEYQm1fARmJG8xtmiA3yEqs3HACyOTg4BWwl
        pp7mAwkLAZV8P3+fdQIj3wJGhlWMkqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMHhraW5
        g3H7qg96hxiZOBgPMUpwMCuJ8JbNm5kkxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0
        xJLU7NTUgtQimCwTB6dUA1Pgvpd3OtrEvhbdZJG5UVR963Dd2Sk/rz5s86rtav5/y+ybZfUx
        hwxGQdXrz9uWXH8bsktW5kC1q/qGxbJpDx/5PPlqUH5u7p1JRTxflxnHx60XKHhhapbAZfOu
        uFvoU/hVMalvQlPP6Ca4nn2j+N6LM7aijyXn2HoXkf2nnRdrrd/Hv5i/V8Zgu5mRvfjmb9pr
        TjVOuJNz75zrT4OiWrP1AXuvHTA5tu9869Virm1fry9OjmvyPi1Xupz1g82tu2GsMy29HM6c
        O5P/uucfq9oq3Vf/N2T+M7m0KeDy9CnbPDfOsxacHt4RmHH38ElNvjiXjxP2uq7ID/LyqlFz
        dNrC5/HWQM9ESemL997Xn82VWIozEg21mIuKEwGrDdaK3gIAAA==
X-CMS-MailID: 20220603154857epcas5p4b4684d4400f4ff66f69ff5e288ef635c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220603154857epcas5p4b4684d4400f4ff66f69ff5e288ef635c
References: <20220603154714.30532-1-alim.akhtar@samsung.com>
        <CGME20220603154857epcas5p4b4684d4400f4ff66f69ff5e288ef635c@epcas5p4.samsung.com>
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

Adds support for Tesla Full Self-Driving (FSD) ufs phy driver.
This SoC has different cdr lock status offset.

Signed-off-by: Bharat Uppal <bharat.uppal@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
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
index 000000000000..0503625bfcec
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
+	.cfg = fsd_ufs_phy_cfgs,
+	.isol = {
+		.offset = FSD_EMBEDDED_COMBO_PHY_CTRL,
+		.mask = FSD_EMBEDDED_COMBO_PHY_CTRL_MASK,
+		.en = FSD_EMBEDDED_COMBO_PHY_CTRL_EN,
+	},
+	.has_symbol_clk = 0,
+	.cdr_lock_status_offset = FSD_EMBEDDED_COMBO_PHY_CDR_LOCK_STATUS,
+};
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

