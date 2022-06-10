Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00042545D97
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 09:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346922AbiFJHca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 03:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346813AbiFJHcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:32:16 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5751CFE07
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 00:32:14 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220610073210epoutp02d36c576997ed60482641801a9ca3370a~3MfgrHUJO3245432454epoutp02j
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 07:32:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220610073210epoutp02d36c576997ed60482641801a9ca3370a~3MfgrHUJO3245432454epoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654846330;
        bh=7ftScBk0BCdSmM0uR2dlXYW6ae4i+jx/+lvmQLkS4sc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p3WqCn3vdKhIU5DkyNsxHsDpOETTf3ylfKytEm28cQ5cthwqRe1JdqU2d01IXAGXQ
         kltHYaFmi2fl5uT13eHXwRRuVl00K1/kXOmBzcHhR3NZLcmkE5USRZ1VXuQsaSDETK
         BSEYvjQM8Q34YQAsbkusO1vXG+HdizOOheBlhn20=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220610073209epcas5p46cd8be81e70ef15838f7da8267e60a7e~3MfgCKo4m0316603166epcas5p4O;
        Fri, 10 Jun 2022 07:32:09 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LKCMn37Csz4x9QL; Fri, 10 Jun
        2022 07:32:05 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.D4.09762.373F2A26; Fri, 10 Jun 2022 16:32:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220610073203epcas5p1f3885a8b4ad82c97bce862e1457be0c1~3MfacrNFx0494704947epcas5p1W;
        Fri, 10 Jun 2022 07:32:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220610073203epsmtrp2987ef84967a31bb7fa2b9f0a27666d43~3Mfabp1E61442314423epsmtrp2X;
        Fri, 10 Jun 2022 07:32:03 +0000 (GMT)
X-AuditID: b6c32a4b-1fdff70000002622-e4-62a2f3731725
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6E.32.11276.373F2A26; Fri, 10 Jun 2022 16:32:03 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220610073201epsmtip1f61ccf0f6680d478bbd83f30e5217fb0~3MfYcDoPs3168031680epsmtip1Y;
        Fri, 10 Jun 2022 07:32:00 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, chanho61.park@samsung.com,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        Bharat Uppal <bharat.uppal@samsung.com>
Subject: [PATCH v3 2/6] phy: samsung-ufs: move cdr offset to drvdata
Date:   Fri, 10 Jun 2022 12:59:20 +0530
Message-Id: <20220610072924.12362-3-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220610072924.12362-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdlhTU7f486Ikg6m7DSwezNvGZvHy51U2
        i2svL7BbTPvwk9ni8n5ti/lHzrFa9L14yGyx6fE1VovLu+awWUxY9Y3Fovv6DjaL5cf/MVks
        2vqF3aJ17xF2i513TjA78HtcvuLtsWlVJ5vHnWt72Dw2L6n3+Pj0FotH35ZVjB6fN8l5tB/o
        ZgrgiMq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAE6
        XUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFKgV5yYW1yal66Xl1piZWhgYGQK
        VJiQnfFj5lLWghdSFfsnvWduYJwu3sXIySEhYCKx+8Jf1i5GLg4hgd2MEr+mP4ByPjFKfD5/
        gw3C+cYo8WTHayaYlsc9c9ghEnsZJbadngjV0sIksX/lBTaQKjYBbYm707cwgSREBJoZJQ52
        7AJzmAV2Mklc/D2dGaRKWMBF4tqyrWA2i4CqRPvuNrBuXgEbifYfF5kh9slLrN5wAMzmFLCV
        OPt/AzPIIAmBqRwSy9b9ZIQocpE4uWErlC0s8er4FnYIW0ri87u9QEM5gGwPiUV/pCDCGRJv
        l6+HKreXOHBlDgtICbOApsT6XfogYWYBPone30+YIDp5JTrahCCqVSWa311lgbClJSZ2d7PC
        DF/xuggSDhMYJX4fWso4gVF2FsLQBYyMqxglUwuKc9NTi00LjPNSy+ExlZyfu4kRnCS1vHcw
        PnrwQe8QIxMH4yFGCQ5mJRHegNuLkoR4UxIrq1KL8uOLSnNSiw8xmgJDbCKzlGhyPjBN55XE
        G5pYGpiYmZmZWBqbGSqJ8wr8b0wSEkhPLEnNTk0tSC2C6WPi4JRqYLop/LlcpPhixpPTrtu1
        ooT3Z2e7209mKIxtmhT8SOE5212PR9d/+bdXLTu9zTj5/j7r+tVHbReKnbw3c5WExtKKGXOl
        Ps2feOrOJYWt1muU6+PdRD7b8Rzl0fN35qnI6127pqHh4rQTYj3bojUO8fXwX5bOd3mas1xp
        gWU1U+E5aRXVQ+c/NgjlWDzpcWuONhBcw274//O9ec4rK34nbBNU3SfawMf25ntGZ9CKmsgv
        W396PxZMM8zUSS8y/rr35tabDYp6viJ3W49muh6/8Ij5oZiEhkHI5g3bUl+Hi6lWiSy49661
        8wwr7xc5U41T8euzv22wn2TM9+p57p4ZvGcNUizWaERMkdHbtpnPXomlOCPRUIu5qDgRAGrC
        oxQbBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWy7bCSnG7x50VJBqfP81s8mLeNzeLlz6ts
        FtdeXmC3mPbhJ7PF5f3aFvOPnGO16HvxkNli0+NrrBaXd81hs5iw6huLRff1HWwWy4//Y7JY
        tPULu0Xr3iPsFjvvnGB24Pe4fMXbY9OqTjaPO9f2sHlsXlLv8fHpLRaPvi2rGD0+b5LzaD/Q
        zRTAEcVlk5Kak1mWWqRvl8CV8WPmUtaCF1IV+ye9Z25gnC7excjJISFgIvG4Zw57FyMXh5DA
        bkaJP4d/s0MkpCWub5wAZQtLrPz3HKqoiUliy/VXjCAJNgFtibvTtzCB2CIC7YwS97ezgRQx
        Cxxlklh+6hgzSEJYwEXi2rKtYDaLgKpE++42NhCbV8BGov3HRWaIDfISqzccALM5BWwlzv7f
        AGRzAG2zkXj9N28CI98CRoZVjJKpBcW56bnFhgWGeanlesWJucWleel6yfm5mxjB4a2luYNx
        +6oPeocYmTgYDzFKcDArifAG3F6UJMSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS
        1OzU1ILUIpgsEwenVAPTwag5Ju4P7566XvmrcWZDg7ZkXjinW+OEioDXJwpcj0dmeTevmeSi
        t9fPtJf/0ZuGiFNrqyY+D2k7pWostYRlcefM+PdTvi9nus68ZtG1+4HmMrkcv95ZLm/v2abp
        WHZQ8bOEQHEHk6Hm7o6pTgF3dBnOsVsqLF+llHZSpTdaZOGi2eJitRt5r++fILHQ95vAzJaK
        f2q86/f65y3bH+D14du89lArndBuhYirP5U3KK5wSZp37LnV0j+5EmLfAq5e1bs1vWaV0n8L
        cfW+iLQZhbF79kfKi+Qs5KzmyBZUryu8y5y7cv0ZWdGnhb/sA450Z/OumqMarvXlR+Dec0m/
        2QN3nP3HVfz23J097y2UWIozEg21mIuKEwEcISMG3gIAAA==
X-CMS-MailID: 20220610073203epcas5p1f3885a8b4ad82c97bce862e1457be0c1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220610073203epcas5p1f3885a8b4ad82c97bce862e1457be0c1
References: <20220610072924.12362-1-alim.akhtar@samsung.com>
        <CGME20220610073203epcas5p1f3885a8b4ad82c97bce862e1457be0c1@epcas5p1.samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 drivers/phy/samsung/phy-samsung-ufs.c      | 3 ++-
 drivers/phy/samsung/phy-samsung-ufs.h      | 2 +-
 4 files changed, 8 insertions(+), 2 deletions(-)

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
index 206a79c69a6c..7218acd2b113 100644
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

