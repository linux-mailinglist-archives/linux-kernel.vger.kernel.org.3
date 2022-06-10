Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B16C545CD8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 09:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243735AbiFJHIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 03:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346369AbiFJHI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:08:27 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E70539B9A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 00:08:20 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220610070815epoutp0108e2c2e926721df2c5e05a5cf6d8c036~3MKpDHVlJ1646916469epoutp01D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 07:08:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220610070815epoutp0108e2c2e926721df2c5e05a5cf6d8c036~3MKpDHVlJ1646916469epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654844895;
        bh=hE7iC05RZWf8cGsOVWjbFzqwioyOOV6K8wR0RQ5vlLI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=n2tGyuUyPmb0ZPXvJ2HXq7TApW0eaHqTjMGwBBNO2inoxrRoQ0Gmx2y/0Zhkh96qv
         xgCp7C2M6s076tgXYH0LSzhYiw+HH/dZhR1DsRVhA+X3RzpgOLYLWc9b0OUunwBOJm
         5PKDF2Xrb8LmiBe6gEp2UwQx6F25hc4VvNGP+66U=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220610070815epcas5p475c7251b8e61e3f3c89dc12edc928610~3MKovvqBY0300703007epcas5p4D;
        Fri, 10 Jun 2022 07:08:15 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LKBrD1ByQz4x9Ps; Fri, 10 Jun
        2022 07:08:12 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6E.EC.09762.BDDE2A26; Fri, 10 Jun 2022 16:08:12 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220610070811epcas5p3c62ef9ad9c82092deac59ff9be896677~3MKlJaWKP2559525595epcas5p3S;
        Fri, 10 Jun 2022 07:08:11 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220610070811epsmtrp20254b3377146c11187baf87f3c2e2b2a~3MKlImCGS0032200322epsmtrp2L;
        Fri, 10 Jun 2022 07:08:11 +0000 (GMT)
X-AuditID: b6c32a4b-213ff70000002622-cf-62a2eddb6480
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8C.DB.08924.BDDE2A26; Fri, 10 Jun 2022 16:08:11 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220610070810epsmtip290a240d007d93f0c38a07a18332ccd4d~3MKjyNClE1143511435epsmtip2h;
        Fri, 10 Jun 2022 07:08:10 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        chanho61.park@samsung.com, pankaj.dubey@samsung.com,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH -next] phy: samsung-ufs: fix NULL pointer dereference
Date:   Fri, 10 Jun 2022 12:35:47 +0530
Message-Id: <20220610070547.71193-1-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIKsWRmVeSWpSXmKPExsWy7bCmuu6dt4uSDHr3Mlk8mLeNzeLyfm2L
        vhcPmS0u75rDZjFh1TcWi0Vbv7Bb7LxzgtmB3WPTqk42jzvX9rB5bF5S79G3ZRWjx+dNcgGs
        Udk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUBHKCmU
        JeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOy
        M86ceMxYMFGk4ufLpSwNjKsFuxg5OCQETCQ6uuS6GLk4hAR2M0o8brvNBuF8YpTY03KOFcL5
        zCjxc9YkdpiOhVPKuxg5geK7GCXunYiFqGlhkmg+dZ8VJMEmoC1xd/oWJhBbRMBeor33H9gg
        ZoHpjBIPF65kBkkIC7hKHNkzlx3EZhFQldi48iWYzStgI/FnzSOwZgkBeYnVGw4wgzRLCGxi
        l+ibtJ0VIuEi8WROMzuELSzx6vgWKFtK4vO7vWwQl3pILPojBRHOkHi7fD0jhG0vceDKHBaQ
        EmYBTYn1u/RBwswCfBK9v58wQXTySnS0CUFUq0o0v7vKAmFLS0zs7maFGX5rbiQkGGIlLjx9
        wTyBUWYWwswFjIyrGCVTC4pz01OLTQuM81LL4RGTnJ+7iRGclrS8dzA+evBB7xAjEwfjIUYJ
        DmYlEd6A24uShHhTEiurUovy44tKc1KLDzGaAgNpIrOUaHI+MDHmlcQbmlgamJiZmZlYGpsZ
        KonzCvxvTBISSE8sSc1OTS1ILYLpY+LglGpg4lfeUt6cne1bsc5qs/PtZZduvUtLtlkhF/fs
        8S8pn5ZvvKvXv3GYovyGVeLB5PPCEZlltesLJcNuPrH/ZXBSevZpE5uCRRtVd+290G9nwKor
        OV9eNLjgaqiA6e7KZfN2Kl97/rZi1eGavbEOXpzh67dKxDO+rLDW896xpe39760l6Z3pZ+80
        H25NX2Rv2NyUmdX2Ysrs3a2mBcwHbq/8fvXTpKjZU955qF58MN9f0Pz/AteFCX4nDmjteOd1
        cv45x5+l09gTd2SHzNDO75/291DwrkVfJJr6X6pfbrt/X2+Xm3mHbNv0ywwmO5l3uTNaRT0P
        ED/foHren9unvZ6n+BYzT/vHP4yTl5hdDzS+qcRSnJFoqMVcVJwIAAwulAPUAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLJMWRmVeSWpSXmKPExsWy7bCSvO7tt4uSDN4vVrZ4MG8bm8Xl/doW
        fS8eMltc3jWHzWLCqm8sFou2fmG32HnnBLMDu8emVZ1sHneu7WHz2Lyk3qNvyypGj8+b5AJY
        o7hsUlJzMstSi/TtErgyzpx4zFgwUaTi58ulLA2MqwW7GDk4JARMJBZOKe9i5OIQEtjBKHF7
        1nHmLkZOoLi0xPWNE9ghbGGJlf+es0MUNTFJ7HmxFqyITUBb4u70LUwgtoiAo8SX/z9ZQIqY
        BWYzSqxpWcMGkhAWcJU4smcu2CQWAVWJjStfgtm8AjYSf9Y8YoLYIC+xesMB5gmMPAsYGVYx
        SqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgSHkJbWDsY9qz7oHWJk4mA8xCjBwawkwhtw
        e1GSEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxSDUxbJbQk
        ZqRY/Fj8c2GlhvcrnVPZjPKhR9bvPP2rsuX4tILt8cGsqRHRfv97trI3ikY9/VvYpGJ+bm77
        Ne7MXYvkupyC3bnmG3++eOtYLcuHOBeTiZzsyh+5y56VL/G5cN1v7n8jTRZ5vrBuv4qpm8Mm
        K3LsODTl/zsTGf6kL8derPGIuh0jZ994f9tVhalzpvHL1exdL1VoLnb41zXe4mezZr9YVWFn
        n7H1e/PErqTyj6+X7rZW2VJz62utkP1V1qeLtqcwbYtmbj//d7JY+4ePeufir0SvnLCgv39l
        bpzdr0KxU5LaFspyLIkn1d7yX3zSeJ1V9mdWWPybk3ENoioTuK1Uz0nt3yLv4X88TUyJpTgj
        0VCLuag4EQBR0E+qkAIAAA==
X-CMS-MailID: 20220610070811epcas5p3c62ef9ad9c82092deac59ff9be896677
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220610070811epcas5p3c62ef9ad9c82092deac59ff9be896677
References: <CGME20220610070811epcas5p3c62ef9ad9c82092deac59ff9be896677@epcas5p3.samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit f86c1d0a58b1f63a ("phy: samsung: ufs: remove drvdata from struct
samsung_ufs_phy")

removes _drvdata_ initialization which resulting in NULL pointer
dereferencing in samsung_ufs_phy_wait_for_lock_acq(). Fix this by
initializing drvdata.

The said commit also duplicate "has_symbol_clk" both in drvdata struct
and in samsung_ufs_phy struct, let's go back and use only one
"has_symbol_clk".

Fixes: f86c1d0a58b1 phy: samsung: ufs: remove drvdata from struct samsung_ufs_phy
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/phy/samsung/phy-samsung-ufs.c | 6 +++---
 drivers/phy/samsung/phy-samsung-ufs.h | 1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/samsung/phy-samsung-ufs.c b/drivers/phy/samsung/phy-samsung-ufs.c
index 206a79c69a6c..6708877b20d7 100644
--- a/drivers/phy/samsung/phy-samsung-ufs.c
+++ b/drivers/phy/samsung/phy-samsung-ufs.c
@@ -207,7 +207,7 @@ static int samsung_ufs_phy_init(struct phy *phy)
 	ss_phy->lane_cnt = phy->attrs.bus_width;
 	ss_phy->ufs_phy_state = CFG_PRE_INIT;
 
-	if (ss_phy->has_symbol_clk) {
+	if (ss_phy->drvdata->has_symbol_clk) {
 		ret = samsung_ufs_phy_symbol_clk_init(ss_phy);
 		if (ret)
 			dev_err(ss_phy->dev, "failed to set ufs phy symbol clocks\n");
@@ -259,7 +259,7 @@ static int samsung_ufs_phy_exit(struct phy *phy)
 
 	clk_disable_unprepare(ss_phy->ref_clk);
 
-	if (ss_phy->has_symbol_clk) {
+	if (ss_phy->drvdata->has_symbol_clk) {
 		clk_disable_unprepare(ss_phy->tx0_symbol_clk);
 		clk_disable_unprepare(ss_phy->rx0_symbol_clk);
 		clk_disable_unprepare(ss_phy->rx1_symbol_clk);
@@ -327,8 +327,8 @@ static int samsung_ufs_phy_probe(struct platform_device *pdev)
 
 	drvdata = match->data;
 	phy->dev = dev;
+	phy->drvdata = drvdata;
 	phy->cfgs = drvdata->cfgs;
-	phy->has_symbol_clk = drvdata->has_symbol_clk;
 	memcpy(&phy->isol, &drvdata->isol, sizeof(phy->isol));
 
 	if (!of_property_read_u32_index(dev->of_node, "samsung,pmu-syscon", 1,
diff --git a/drivers/phy/samsung/phy-samsung-ufs.h b/drivers/phy/samsung/phy-samsung-ufs.h
index 854b53bdf347..b9144586daf5 100644
--- a/drivers/phy/samsung/phy-samsung-ufs.h
+++ b/drivers/phy/samsung/phy-samsung-ufs.h
@@ -125,7 +125,6 @@ struct samsung_ufs_phy {
 	const struct samsung_ufs_phy_drvdata *drvdata;
 	const struct samsung_ufs_phy_cfg * const *cfgs;
 	struct samsung_ufs_phy_pmu_isol isol;
-	bool has_symbol_clk;
 	u8 lane_cnt;
 	int ufs_phy_state;
 	enum phy_mode mode;

base-commit: ff539ac73ea559a8c146d99ab14bfcaddd30547a
-- 
2.25.1

