Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D2353898F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 03:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243353AbiEaBXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 21:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243343AbiEaBXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 21:23:49 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE79940A08
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 18:23:47 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220531012345epoutp02cbe599118aefb35b3e2d59be4960e7a0~0DA-67x6J2272322723epoutp02L
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 01:23:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220531012345epoutp02cbe599118aefb35b3e2d59be4960e7a0~0DA-67x6J2272322723epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653960225;
        bh=MefAl/5CSsIqUvfBRB4GKDe7Rqk1CpPiQz9ZkrZGXIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PPleZt5TQAtsKtiZuXchv6tZdo5NFykncyLLE3qbcgiV60bvVqmo8P9uoXKOTTfmp
         TGAuPwQCYBzvtaVq54GVJFd4zF0bHaTULHsAnoiVOBVjCWkzXYixj/QNpBKFeP+mq+
         1KIYn8BEA3G/ROxMJUkwwyX9XT664I+xoaoKJUx0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220531012344epcas5p26f0aad0fa8e75fb16f6524ec14d2a028~0DA-BX9pa0088200882epcas5p2T;
        Tue, 31 May 2022 01:23:44 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LBvgK4WbLz4x9QN; Tue, 31 May
        2022 01:23:41 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.F5.09762.D1E65926; Tue, 31 May 2022 10:23:41 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220531012341epcas5p19b15b4916b210687ab6b46d6da0b2273~0DA7aWj0v1064310643epcas5p1Q;
        Tue, 31 May 2022 01:23:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220531012341epsmtrp286fa393e34f482da8f4be33283dc110c~0DA7ZJrS72336523365epsmtrp2p;
        Tue, 31 May 2022 01:23:41 +0000 (GMT)
X-AuditID: b6c32a4b-1fdff70000002622-ad-62956e1db12a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.6F.11276.C1E65926; Tue, 31 May 2022 10:23:40 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220531012338epsmtip259f4afa19e18dfb4ce36a71e6ba5fe0c~0DA49MtAU1203612036epsmtip20;
        Tue, 31 May 2022 01:23:38 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, chanho61.park@samsung.com,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com, Bharat Uppal <bharat.uppal@samsung.com>
Subject: [PATCH 2/6] phy: samsung-ufs: move cdr offset to drvdata
Date:   Tue, 31 May 2022 06:52:16 +0530
Message-Id: <20220531012220.80563-3-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220531012220.80563-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmpq5s3tQkg/9PFCwezNvGZvHy51U2
        i2svL7BbTPvwk9ni8n5ti/lHzrFa9L14yGyx6fE1VouHr8ItLu+aw2YxYdU3Fovu6zvYLJYf
        /8dksWjrF3aL1r1H2C123jnB7CDgcfmKt8emVZ1sHneu7WHz2Lyk3uPj01ssHn1bVjF6/Gua
        y+7xeZOcR/uBbqYAzqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRb
        JRefAF23zBygH5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BSYFesWJucWleel6
        eaklVoYGBkamQIUJ2Rnfny1lLXgsWfHr1hy2BsZJYl2MnBwSAiYSdx68ZO5i5OIQEtjNKDGh
        r58VwvnEKHHr91wo5xujxJ3+X8wwLV9+rGaESOxllJi78wk7hNPCJHHz0GU2kCo2AW2Ju9O3
        MIEkRASaGSUOduwCc5gFzjFJPNu7gQmkSljAUWL5+Q5GEJtFQFXixoUmsG5eARuJhtUH2SH2
        yUus3nAAbDengK1E98bTYIMkBOZySNy5coAFoshF4vvljVANwhKvjm+BsqUkPr/bCzSUA8j2
        kFj0RwoinCHxdvl6RgjbXuLAlTksICXMApoS63fpg4SZBfgken8/YYLo5JXoaBOCqFaVaH53
        FWqptMTE7m5WmOG3/otBwmECo8SvM1+YJzDKzkIYuoCRcRWjZGpBcW56arFpgXFeajk8ppLz
        czcxgtOmlvcOxkcPPugdYmTiYDzEKMHBrCTCaxUxNUmINyWxsiq1KD++qDQntfgQoykwxCYy
        S4km5wMTd15JvKGJpYGJmZmZiaWxmaGSOK/A/8YkIYH0xJLU7NTUgtQimD4mDk6pBqaCQ/mM
        svf3n9AySjeOjDjx96T1jqM1HfN2GEXPWO3feC7T4XSj0TUvvr6zEw4Z/Gx22sFjlDrvy5/A
        GRqme19rr7/O9t5mUayQ1KPeZWxbqtTX26hLJhjuEuyvd0h8fm5tzAmJBkHFd1XSv64UBTzp
        zhPYu4zH/ZataseEO3Uv7nE/CBKZd3hj0PL9k0Sv3Xzpy7ff79Cucx+S3I96fnuuO6Vir0DZ
        sQk8u2faxQr2/M2R2/c2IOHlxphA4VjZx6tkvS9293stK2S5vXES94Tsxu+LzlfLSk7v5VAx
        bb0crdVn8zn29t61GzjFJ3p51MnM9SphMvrMZvvuy0W+W/xsczdqvZVsWXqo58P1RyZKLMUZ
        iYZazEXFiQBf9qPcJAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsWy7bCSvK5M3tQkgxePrS0ezNvGZvHy51U2
        i2svL7BbTPvwk9ni8n5ti/lHzrFa9L14yGyx6fE1VouHr8ItLu+aw2YxYdU3Fovu6zvYLJYf
        /8dksWjrF3aL1r1H2C123jnB7CDgcfmKt8emVZ1sHneu7WHz2Lyk3uPj01ssHn1bVjF6/Gua
        y+7xeZOcR/uBbqYAzigum5TUnMyy1CJ9uwSujO/PlrIWPJas+HVrDlsD4ySxLkZODgkBE4kv
        P1YzdjFycQgJ7GaU+PjqExNEQlri+sYJ7BC2sMTKf8/ZIYqamCTWf1jCDJJgE9CWuDt9C1iD
        iEA7o8T97WwgNrPAHSaJVT0iILawgKPE8vMdjCA2i4CqxI0LTWA1vAI2Eg2rD0ItkJdYveEA
        2ExOAVuJ7o2nwWYKAdU8vv+aZQIj3wJGhlWMkqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmb
        GMEBr6W5g3H7qg96hxiZOBgPMUpwMCuJ8FpFTE0S4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh
        62S8kEB6YklqdmpqQWoRTJaJg1OqgWm290sG0+PSq5foPZcQXrR00ZJgD1s/1SSHGX/mPhbm
        Xtfxt1kljVX1oc0miSqrNXvWnw7YsatGPcuQW0lt2xNGx68VH/svG89QvGJ4bq9YV/Mx4ZcH
        3I4rqMlcreE/wPYw+ks2z++3s//W+T1pVgsUXNxy3Cb2fomYtoIii4J36X/j/0/Y/1w9Zrjp
        fN2lD61NtsUV7ZzfH66N0K6TsGucrtA2KarqOvupxjjbqPCnm5K6XEP3C07kdOvY+3Hf9Nem
        b5bFpR896zC1KFqr8/NVzQc13Y4thxVXFuTemxz0QqyseeeaGHPPM2JPJc9viQ7rXtg9ibFm
        Ar/fp7nBc61KGYIlUqNFVb04LA2DlFiKMxINtZiLihMBI3njxucCAAA=
X-CMS-MailID: 20220531012341epcas5p19b15b4916b210687ab6b46d6da0b2273
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220531012341epcas5p19b15b4916b210687ab6b46d6da0b2273
References: <20220531012220.80563-1-alim.akhtar@samsung.com>
        <CGME20220531012341epcas5p19b15b4916b210687ab6b46d6da0b2273@epcas5p1.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move CDR lock offset to drv data so that it can
be extended for other SoCs which are having CDR
lock at different register offset.

Cc: linux-fsd@tesla.com
Signed-off-by: Bharat Uppal <bharat.uppal@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/phy/samsung/phy-exynos7-ufs.c      | 3 +++
 drivers/phy/samsung/phy-exynosautov9-ufs.c | 2 ++
 drivers/phy/samsung/phy-samsung-ufs.c      | 3 ++-
 drivers/phy/samsung/phy-samsung-ufs.h      | 2 +-
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos7-ufs.c b/drivers/phy/samsung/phy-exynos7-ufs.c
index 7c9008e163db..d1a37273cb1f 100644
--- a/drivers/phy/samsung/phy-exynos7-ufs.c
+++ b/drivers/phy/samsung/phy-exynos7-ufs.c
@@ -11,6 +11,8 @@
 #define EXYNOS7_EMBEDDED_COMBO_PHY_CTRL_MASK	0x1
 #define EXYNOS7_EMBEDDED_COMBO_PHY_CTRL_EN	BIT(0)
 
+#define PHY_CDR_LOCK_STATUS    0x5e
+
 /* Calibration for phy initialization */
 static const struct samsung_ufs_phy_cfg exynos7_pre_init_cfg[] = {
 	PHY_COMN_REG_CFG(0x00f, 0xfa, PWR_MODE_ANY),
@@ -74,4 +76,5 @@ const struct samsung_ufs_phy_drvdata exynos7_ufs_phy = {
 		.en = EXYNOS7_EMBEDDED_COMBO_PHY_CTRL_EN,
 	},
 	.has_symbol_clk = 1,
+	.cdr_lock_status_offset = PHY_CDR_LOCK_STATUS,
 };
diff --git a/drivers/phy/samsung/phy-exynosautov9-ufs.c b/drivers/phy/samsung/phy-exynosautov9-ufs.c
index 36398a15c2db..1572b985c70d 100644
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
index 602ddef259eb..8e5ae228daa7 100644
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
index 91a0e9f94f98..965c79bbc278 100644
--- a/drivers/phy/samsung/phy-samsung-ufs.h
+++ b/drivers/phy/samsung/phy-samsung-ufs.h
@@ -40,7 +40,6 @@
 
 /* UFS PHY registers */
 #define PHY_PLL_LOCK_STATUS	0x1e
-#define PHY_CDR_LOCK_STATUS	0x5e
 
 #define PHY_PLL_LOCK_BIT	BIT(5)
 #define PHY_CDR_LOCK_BIT	BIT(4)
@@ -109,6 +108,7 @@ struct samsung_ufs_phy_drvdata {
 		u32 en;
 	} isol;
 	bool has_symbol_clk;
+	u32 cdr_lock_status_offset;
 };
 
 struct samsung_ufs_phy {
-- 
2.25.1

