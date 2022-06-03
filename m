Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D6F53CC92
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245699AbiFCPtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245685AbiFCPtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:49:01 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F40850B06
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 08:48:59 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220603154857epoutp03270e089bc211bd514a8a3b97a51849d9~1JwRmb0-N2830028300epoutp03F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 15:48:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220603154857epoutp03270e089bc211bd514a8a3b97a51849d9~1JwRmb0-N2830028300epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654271338;
        bh=pn1GhTFojudQMKDp0Rp6pEZP2kIfXWwD1f6+9T//LXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hb0B0I61WHQgWbHNodWCnzJXolFEuGU8EIvPY7QD5VrSmekNT+bPtgMR8/A0uttKu
         ZjHs7YoKWAswL4qDyNh+5KPggV9+Wa24G2Je/xes/keUtSu47aWwTOVQYvPQJB8K8Q
         5qCkMX6ZtOujFYwW28oczZuJ7XJ+2T4Wt6FfrXQE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220603154857epcas5p2b9664496683e30573cd04df6c4e5fe6a~1JwRJN6gz1442914429epcas5p2Q;
        Fri,  3 Jun 2022 15:48:57 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LF6kG1xYyz4x9Pv; Fri,  3 Jun
        2022 15:48:54 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        81.28.09762.66D2A926; Sat,  4 Jun 2022 00:48:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220603154853epcas5p1f072d462edae5584d1cce601189ab85b~1JwNm2mbb2967129671epcas5p1o;
        Fri,  3 Jun 2022 15:48:53 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220603154853epsmtrp258bb2ef493633b0cfd8aff8440d8b53d~1JwNmAMLb0407504075epsmtrp2p;
        Fri,  3 Jun 2022 15:48:53 +0000 (GMT)
X-AuditID: b6c32a4b-1fdff70000002622-8c-629a2d66910f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.27.08924.56D2A926; Sat,  4 Jun 2022 00:48:53 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220603154851epsmtip1d5b51af2e8b987497cf066b8988b05a7~1JwLeEeBK2493724937epsmtip1S;
        Fri,  3 Jun 2022 15:48:51 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, chanho61.park@samsung.com,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        Bharat Uppal <bharat.uppal@samsung.com>
Subject: [PATCH v2 2/7] phy: samsung-ufs: move cdr offset to drvdata
Date:   Fri,  3 Jun 2022 21:17:09 +0530
Message-Id: <20220603154714.30532-3-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220603154714.30532-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdlhTSzdNd1aSwd453BYP5m1js3j58yqb
        xbWXF9gtpn34yWxxeb+2xfwj51gt+l48ZLbY9Pgaq8XlXXPYLCas+sZi0X19B5vF8uP/mCwW
        bf3CbtG69wi7xc47J5gd+D0uX/H22LSqk83jzrU9bB6bl9R7fHx6i8Wjb8sqRo/Pm+Q82g90
        MwVwRGXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gCd
        rqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCnQK07MLS7NS9fLSy2xMjQwMDIF
        KkzIzlh2eCl7wRfJisbtk1gaGFeJdTFyckgImEhsmbmKpYuRi0NIYDejxLYpD1ghnE+MEmuf
        74RyPjNKPLg2kx2m5fCPPqiWXYwSLyauY4dwWpgkHq7/CVbFJqAtcXf6FiaQhIhAM6PEwY5d
        YA6zwE4miYu/pzODVAkLuEis6L3FCGKzCKhKPN19nBXE5hWwkZhzfSvUPnmJ1RsOANVzcHAK
        2EpMPc0HMkdCYCaHxKcp95ggalwk9i28wgphC0u8Or4FqldK4vO7vWwgvRICHhKL/khBhDMk
        3i5fzwhh20scuDKHBaSEWUBTYv0ufZAwswCfRO/vJ0wQnbwSHW1CENWqEs3vrrJA2NISE7u7
        oZZ6SFw9fAEaKBMYJWbd3M02gVF2FsLUBYyMqxglUwuKc9NTi00LjPNSy+ExlZyfu4kRnCS1
        vHcwPnrwQe8QIxMH4yFGCQ5mJRHesnkzk4R4UxIrq1KL8uOLSnNSiw8xmgJDbCKzlGhyPjBN
        55XEG5pYGpiYmZmZWBqbGSqJ8wr8b0wSEkhPLEnNTk0tSC2C6WPi4JRqYFIp/HY5J35qh7Cf
        +LFdZ5q35oYXz1H+Hjp1ym2jjMqfbQ84X8yK/+Gpclo8uLzK7H7wrooU1YdPzgVUBb5z2bFg
        053m6AWv15cYtcdVHZhtHvksyEp7yQ7pGSISRVU/Xz5ijVXMUbSW+O+939L/2OKpiRK3E92k
        pr37tHvLNu9pJQd3vRDPOu6y7/rk+Dur4qfsXjmR65jrmVXOSpnnmo0tAvzmHTAIf8z+z35j
        0a5FQb4Lb+1bGFJ4/u+8pAX6Z6yiX6xjE9QQclj0+Xjf1prThtETZEuj6197TtxV+P4mQwzv
        Bn6bVgOVtV+1/yTf9s21/peYunSzR7lc/7bkSTlKVUpTZv3dbzvnyu6foeuUWIozEg21mIuK
        EwGUt3SRGwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWy7bCSnG6q7qwkg7kfFSwezNvGZvHy51U2
        i2svL7BbTPvwk9ni8n5ti/lHzrFa9L14yGyx6fE1VovLu+awWUxY9Y3Fovv6DjaL5cf/MVks
        2vqF3aJ17xF2i513TjA78HtcvuLtsWlVJ5vHnWt72Dw2L6n3+Pj0FotH35ZVjB6fN8l5tB/o
        ZgrgiOKySUnNySxLLdK3S+DKWHZ4KXvBF8mKxu2TWBoYV4l1MXJySAiYSBz+0cfSxcjFISSw
        g1Hi1LEFzBAJaYnrGyewQ9jCEiv/PQezhQSamCS+X/YDsdkEtCXuTt/CBGKLCLQzStzfzgYy
        iFngKJPE8lPHwAYJC7hIrOi9xQhiswioSjzdfZwVxOYVsJGYc30r1AJ5idUbDgDVc3BwCthK
        TD3NB7HLRuL7+fusExj5FjAyrGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECA5uLa0d
        jHtWfdA7xMjEwXiIUYKDWUmEt2zezCQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQn
        lqRmp6YWpBbBZJk4OKUamDziFpQvYq3Tnjh7QVHxlZPVL0p44qfO/1kb55I7VXHqs7NFiabd
        asczW+/7Po6yPlf+YdHphPXRrLM5enb6b77DffC65an8vaW7l+5d55bMaFmw6/z/UsVpactn
        z31yWub8d5mbX140fGTbx+Z3R39X4ZGQGTndM/frTwrrihP2qQjy+OJv5aqTfugNVxR/zT0l
        ZcdzP25vO3Nox3zBVonJ0xccubmo2PzYjcKk7EcLFj3YUGK1Mv2YzcNJNw4dY3H61p5/yXbO
        TrG1uxMenJm7auKjEt7oBxyZq1+kyWvUPO1umxT2KCp6NuOVpRMkw5kMC2enql14Uj9tu2Pr
        NNVvXhOZ/jKsXL20sTbljo+wEktxRqKhFnNRcSIA1YyGh90CAAA=
X-CMS-MailID: 20220603154853epcas5p1f072d462edae5584d1cce601189ab85b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220603154853epcas5p1f072d462edae5584d1cce601189ab85b
References: <20220603154714.30532-1-alim.akhtar@samsung.com>
        <CGME20220603154853epcas5p1f072d462edae5584d1cce601189ab85b@epcas5p1.samsung.com>
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

Move CDR lock offset to drv data so that it can be extended for other SoCs
which are having CDR lock at different register offset.

Signed-off-by: Bharat Uppal <bharat.uppal@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/phy/samsung/phy-exynos7-ufs.c      | 3 +++
 drivers/phy/samsung/phy-exynosautov9-ufs.c | 2 ++
 drivers/phy/samsung/phy-samsung-ufs.c      | 3 ++-
 drivers/phy/samsung/phy-samsung-ufs.h      | 2 +-
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos7-ufs.c b/drivers/phy/samsung/phy-exynos7-ufs.c
index 7c9008e163db..dca21fb6e2a6 100644
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

