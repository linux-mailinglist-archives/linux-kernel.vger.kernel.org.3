Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEDE546469
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 12:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243603AbiFJKsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 06:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243365AbiFJKrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:47:49 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DEF2D3B0C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 03:43:54 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220610104352epoutp01c7ecc1279b6e03aea7d8ff7fb1e50acd~3PG5JQQ_S1533515335epoutp016
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 10:43:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220610104352epoutp01c7ecc1279b6e03aea7d8ff7fb1e50acd~3PG5JQQ_S1533515335epoutp016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654857832;
        bh=cvghHJ1LY48tfnyJ5DlUvAxjLLvCotzOSkYw1IEBGBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rJBVLN6PAyq40sXtUH4NYSN8K2K9kIQdjnLbrrGlQMa9uSh4UMxVCugzDZURvZeIy
         CNe+Hymoe2oNTHtjZTZ5weznUQ4jZzEvigs35HJX6sFpImBce7Vzn+Xyb9orTLP1HY
         KEPOMj/7tMuyMo9tMIUkh7jeAtz34ITfRCa7yPws=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220610104351epcas5p4454a62589a24700de0b1ed476fa53923~3PG4O9qr51272012720epcas5p4W;
        Fri, 10 Jun 2022 10:43:51 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LKHcz45VCz4x9Pw; Fri, 10 Jun
        2022 10:43:47 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        65.6A.09762.36023A26; Fri, 10 Jun 2022 19:43:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220610104346epcas5p4f59c073d15b3cd8fbc99de03d9cd1c41~3PGzrqWmO1331513315epcas5p4L;
        Fri, 10 Jun 2022 10:43:46 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220610104346epsmtrp1440a6cdb7436198f5e0c50f27add2ebd~3PGzqyQE01337313373epsmtrp1P;
        Fri, 10 Jun 2022 10:43:46 +0000 (GMT)
X-AuditID: b6c32a4b-1fdff70000002622-c2-62a320631142
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        64.4D.08924.26023A26; Fri, 10 Jun 2022 19:43:46 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220610104344epsmtip1354edaf23085ed5c78650c65375aee06~3PGxj2MBj1361413614epsmtip1R;
        Fri, 10 Jun 2022 10:43:44 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, chanho61.park@samsung.com,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        Bharat Uppal <bharat.uppal@samsung.com>
Subject: [PATCH v4 2/6] phy: samsung-ufs: move cdr offset to drvdata
Date:   Fri, 10 Jun 2022 16:11:15 +0530
Message-Id: <20220610104119.66401-3-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220610104119.66401-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplk+LIzCtJLcpLzFFi42LZdlhTXTdZYXGSwbZOOYsH87axWbz8eZXN
        4trLC+wW0z78ZLa4vF/bYv6Rc6wWfS8eMltsenyN1eLyrjlsFhNWfWOx6L6+g81i+fF/TBaL
        tn5ht2jde4TdYuedE8wO/B6Xr3h7bFrVyeZx59oeNo/NS+o9Pj69xeLRt2UVo8fnTXIe7Qe6
        mQI4orJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4BO
        V1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoYGJkC
        FSZkZyz/cJS1YJJsRfu+tAbGiZJdjBwcEgImEos3h3UxcnEICexmlFg66wYThPOJUeL2ug3s
        EM5nRonjH+awdTFygnV8eHqXDSKxi1Hi3PKDYAkhgRYmiV3PJUBsNgFtibvTt4CNEhFoZpQ4
        2LELzGEW2MkkcfH3dGaQ5cICLhKffpSBNLAIqEq833GHBcTmFbCR+LljCTPENnmJ1RsOgNmc
        ArYSz9ZfZgWZIyEwlUNi1dq/7BBFLhIr709igbCFJV4d3wIVl5J42d/GDvGoh8SiP1IQ4QyJ
        t8vXM0LY9hIHrsxhASlhFtCUWL9LHyTMLMAn0fv7CRNEJ69ER5sQRLWqRPO7q1CLpCUmdnez
        QtgeEl0HVzFCwmQCo8SNVSdZJjDKzkKYuoCRcRWjZGpBcW56arFpgXFeajk8mpLzczcxgtOj
        lvcOxkcPPugdYmTiYDzEKMHBrCTCG3B7UZIQb0piZVVqUX58UWlOavEhRlNgkE1klhJNzgcm
        6LySeEMTSwMTMzMzE0tjM0MlcV6B/41JQgLpiSWp2ampBalFMH1MHJxSDUx71inZl72esjc4
        zKNgYdiJlX9KlBOu5JXtZHz+Nudpflxr6f7PF9Ke7tU01aqc7SPf9MEmKs/zrQdjcu+x3Q+P
        OwZ4nclpiznEmtlvGB2X1T5tdTFf66Uyi5fr/z0QXy+59E6zidEvbXe+s217dH7O0rl54vmF
        xREPTM+2VCVpdbftXHt5ZvQ+vnvaJ+XXmPdtY1r17kP8sWWOF9qXnbBp658ocufYWYXpX5gN
        5rZfytPgc/TQEN9Uffjlz1ithLXZ6bU9bJJKz+JzN04KOVf/9dLL/kVhkd0Mczf8m7W/hMMw
        cDv/4r7CGM2j/no3nKvyjTmKV0z+kWaau36SX9rzlRFWS2puSa59elLJz1eJpTgj0VCLuag4
        EQBHgGhXGAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWy7bCSnG6SwuIkgz3vpS0ezNvGZvHy51U2
        i2svL7BbTPvwk9ni8n5ti/lHzrFa9L14yGyx6fE1VovLu+awWUxY9Y3Fovv6DjaL5cf/MVks
        2vqF3aJ17xF2i513TjA78HtcvuLtsWlVJ5vHnWt72Dw2L6n3+Pj0FotH35ZVjB6fN8l5tB/o
        ZgrgiOKySUnNySxLLdK3S+DKWP7hKGvBJNmK9n1pDYwTJbsYOTkkBEwkPjy9y9bFyMUhJLCD
        UeLA1VnsEAlpiesbJ0DZwhIr/z1nhyhqYpL4s/4tM0iCTUBb4u70LUwgtohAO6PE/e1gk5gF
        jjJJLD91DKiIg0NYwEXi048ykBoWAVWJ9zvusIDYvAI2Ej93LGGGWCAvsXrDATCbU8BW4tn6
        y6wgthBQzeKOc8wTGPkWMDKsYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIDm4trR2M
        e1Z90DvEyMTBeIhRgoNZSYQ34PaiJCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeW
        pGanphakFsFkmTg4pRqYFq2ec8frddrULzprRNRZVHR+CgZtY1v3SV9ll96Sjdz6+6/+dDRW
        zHOqbbohHukYuon/x/9zhu6dhQbihgrfRKNvvtzDu0Ppy7rm41mXZOcYzZvlHbznqOk0qfPe
        01u8zRwiTzhytSV+TXgV2TKj3cTqUTuXjF/NDZP7T06Wq4hUmc6x+uCwX9gnWZE5y8Dov0OJ
        Yedtz023+XQMLr/ZNaMvY3bqjnVn9Oc3fhC92/PdV3NjcHri4RW2bp7iTx4+OJwjdLR2i2XI
        zxWv0qOv3DEsP6X25nKaxdQ7F06U7b/pOO/WhFUXWNTY26bNZzNMyE151f1jpZnigQ+qWYnB
        JSum1Mp/Wt+/M/NctYyREktxRqKhFnNRcSIA1Jeqrd0CAAA=
X-CMS-MailID: 20220610104346epcas5p4f59c073d15b3cd8fbc99de03d9cd1c41
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220610104346epcas5p4f59c073d15b3cd8fbc99de03d9cd1c41
References: <20220610104119.66401-1-alim.akhtar@samsung.com>
        <CGME20220610104346epcas5p4f59c073d15b3cd8fbc99de03d9cd1c41@epcas5p4.samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move CDR lock offset to drv data so that it can be extended for other SoCs
which are having CDR lock at different register offset.

Signed-off-by: Bharat Uppal <bharat.uppal@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Reviewed-by: Chanho Park <chanho61.park@samsung.com>
---
 drivers/phy/samsung/phy-exynos7-ufs.c      | 3 +++
 drivers/phy/samsung/phy-exynosautov9-ufs.c | 2 ++
 drivers/phy/samsung/phy-samsung-ufs.c      | 4 +++-
 drivers/phy/samsung/phy-samsung-ufs.h      | 2 +-
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos7-ufs.c b/drivers/phy/samsung/phy-exynos7-ufs.c
index d1e9d0ae5c1d..72854336f59d 100644
--- a/drivers/phy/samsung/phy-exynos7-ufs.c
+++ b/drivers/phy/samsung/phy-exynos7-ufs.c
@@ -11,6 +11,8 @@
 #define EXYNOS7_EMBEDDED_COMBO_PHY_CTRL_MASK	0x1
 #define EXYNOS7_EMBEDDED_COMBO_PHY_CTRL_EN	BIT(0)
 
+#define EXYNOS7_EMBEDDED_COMBO_PHY_CDR_LOCK_STATUS	0x5e
+
 /* Calibration for phy initialization */
 static const struct samsung_ufs_phy_cfg exynos7_pre_init_cfg[] = {
 	PHY_COMN_REG_CFG(0x00f, 0xfa, PWR_MODE_ANY),
@@ -74,4 +76,5 @@ const struct samsung_ufs_phy_drvdata exynos7_ufs_phy = {
 		.en = EXYNOS7_EMBEDDED_COMBO_PHY_CTRL_EN,
 	},
 	.has_symbol_clk = 1,
+	.cdr_lock_status_offset = EXYNOS7_EMBEDDED_COMBO_PHY_CDR_LOCK_STATUS,
 };
diff --git a/drivers/phy/samsung/phy-exynosautov9-ufs.c b/drivers/phy/samsung/phy-exynosautov9-ufs.c
index fa4d2983eec6..2b256070d657 100644
--- a/drivers/phy/samsung/phy-exynosautov9-ufs.c
+++ b/drivers/phy/samsung/phy-exynosautov9-ufs.c
@@ -10,6 +10,7 @@
 #define EXYNOSAUTOV9_EMBEDDED_COMBO_PHY_CTRL		0x728
 #define EXYNOSAUTOV9_EMBEDDED_COMBO_PHY_CTRL_MASK	0x1
 #define EXYNOSAUTOV9_EMBEDDED_COMBO_PHY_CTRL_EN		BIT(0)
+#define EXYNOSAUTOV9_EMBEDDED_COMBO_PHY_CDR_LOCK_STATUS	0x5e
 
 #define PHY_TRSV_REG_CFG_AUTOV9(o, v, d) \
 	PHY_TRSV_REG_CFG_OFFSET(o, v, d, 0x50)
@@ -64,4 +65,5 @@ const struct samsung_ufs_phy_drvdata exynosautov9_ufs_phy = {
 		.en = EXYNOSAUTOV9_EMBEDDED_COMBO_PHY_CTRL_EN,
 	},
 	.has_symbol_clk = 0,
+	.cdr_lock_status_offset = EXYNOSAUTOV9_EMBEDDED_COMBO_PHY_CDR_LOCK_STATUS,
 };
diff --git a/drivers/phy/samsung/phy-samsung-ufs.c b/drivers/phy/samsung/phy-samsung-ufs.c
index 206a79c69a6c..8cec7652b459 100644
--- a/drivers/phy/samsung/phy-samsung-ufs.c
+++ b/drivers/phy/samsung/phy-samsung-ufs.c
@@ -63,7 +63,8 @@ static int samsung_ufs_phy_wait_for_lock_acq(struct phy *phy)
 	}
 
 	err = readl_poll_timeout(
-			ufs_phy->reg_pma + PHY_APB_ADDR(PHY_CDR_LOCK_STATUS),
+			ufs_phy->reg_pma +
+			PHY_APB_ADDR(ufs_phy->drvdata->cdr_lock_status_offset),
 			val, (val & PHY_CDR_LOCK_BIT), sleep_us, timeout_us);
 	if (err)
 		dev_err(ufs_phy->dev,
@@ -327,6 +328,7 @@ static int samsung_ufs_phy_probe(struct platform_device *pdev)
 
 	drvdata = match->data;
 	phy->dev = dev;
+	phy->drvdata = drvdata;
 	phy->cfgs = drvdata->cfgs;
 	phy->has_symbol_clk = drvdata->has_symbol_clk;
 	memcpy(&phy->isol, &drvdata->isol, sizeof(phy->isol));
diff --git a/drivers/phy/samsung/phy-samsung-ufs.h b/drivers/phy/samsung/phy-samsung-ufs.h
index 854b53bdf347..913542ebff7a 100644
--- a/drivers/phy/samsung/phy-samsung-ufs.h
+++ b/drivers/phy/samsung/phy-samsung-ufs.h
@@ -40,7 +40,6 @@
 
 /* UFS PHY registers */
 #define PHY_PLL_LOCK_STATUS	0x1e
-#define PHY_CDR_LOCK_STATUS	0x5e
 
 #define PHY_PLL_LOCK_BIT	BIT(5)
 #define PHY_CDR_LOCK_BIT	BIT(4)
@@ -111,6 +110,7 @@ struct samsung_ufs_phy_drvdata {
 	const struct samsung_ufs_phy_cfg **cfgs;
 	struct samsung_ufs_phy_pmu_isol isol;
 	bool has_symbol_clk;
+	u32 cdr_lock_status_offset;
 };
 
 struct samsung_ufs_phy {
-- 
2.25.1

