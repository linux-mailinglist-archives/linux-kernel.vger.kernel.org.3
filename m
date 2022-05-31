Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E258538997
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 03:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243389AbiEaBYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 21:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243359AbiEaBYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 21:24:08 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2A895485
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 18:24:02 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220531012400epoutp047ca86b822a62805a1b448ca22b07fffe~0DBNTdGu90100701007epoutp04K
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 01:24:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220531012400epoutp047ca86b822a62805a1b448ca22b07fffe~0DBNTdGu90100701007epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653960240;
        bh=9FxDnsW8IXKMof0NEUEZCmkFpifBVEu8a+pU1RMoX9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gk0q1S6U/NymqY9ceu7Wjw3TGWceEXyA3kZ1G1KXsXK+g+h+q8+z+/LaLaqzz2n+E
         bK/J874OFtPn1/xWEeOpZZWSk4rn4ozY7hl6bIG/nKk++d72IONxu7mMnS8F7V2iIN
         OQd04Rcj+z/ftBJqwiTNiXuFHs1mNnTu4rBm0DaE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220531012359epcas5p286b7883ccd43c0ef3b98e827f45b9a14~0DBMob8Ox1282112821epcas5p2E;
        Tue, 31 May 2022 01:23:59 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LBvgd1lT0z4x9QL; Tue, 31 May
        2022 01:23:57 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.06.09762.D2E65926; Tue, 31 May 2022 10:23:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220531012356epcas5p3cd6638d4d3eccb28a28d064c9f585a4f~0DBJ6eb_l0278302783epcas5p3-;
        Tue, 31 May 2022 01:23:56 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220531012356epsmtrp2a2343259f48e5fd9f8f8cd0e86a169b0~0DBJ5ave-2334523345epsmtrp2H;
        Tue, 31 May 2022 01:23:56 +0000 (GMT)
X-AuditID: b6c32a4b-213ff70000002622-ec-62956e2d6a0d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.E7.08924.C2E65926; Tue, 31 May 2022 10:23:56 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220531012354epsmtip2e196cfc9b9eaccacbcf04cc720ef3495~0DBHqNe8D0656506565epsmtip2T;
        Tue, 31 May 2022 01:23:54 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, chanho61.park@samsung.com,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com, Bharat Uppal <bharat.uppal@samsung.com>
Subject: [PATCH 5/6] ufs: host: ufs-exynos: add support for fsd ufs hci
Date:   Tue, 31 May 2022 06:52:19 +0530
Message-Id: <20220531012220.80563-6-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220531012220.80563-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmhq5u3tQkg4Y7bBYP5m1js3j58yqb
        xbWXF9gtpn34yWxxeb+2xfwj51gt+l48ZLbY9Pgaq8XDV+EWl3fNYbOYsOobi0X39R1sFsuP
        /2OyWLT1C7tF694j7BY775xgdhDwuHzF22PTqk42jzvX9rB5bF5S7/Hx6S0Wj74tqxg9/jXN
        Zff4vEnOo/1AN1MAZ1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqt
        kotPgK5bZg7QD0oKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScApMCveLE3OLSvHS9
        vNQSK0MDAyNToMKE7IxDS1czF6wxr+jd4tDA+EK3i5GTQ0LARGLZxynsXYxcHEICuxklvuxt
        YIFwPjFKnNzYwAThfGaUeNP4jB2mZeqzBcwQiV2MEs3v/jFCOC1MEl/a9rGAVLEJaEvcnb4F
        rF1EoJlR4mDHLjCHWeAck8SzvRuYQKqEBdwl/sw9D9bBIqAqMaN/LRuIzStgI9F3rZ0JYp+8
        xOoNB5hBbE4BW4nujafBBkkIzOSQWLH6CCtEkYvEhOMnoBqEJV4d3wJ1rJTE53d7gYZyANke
        Eov+SEGEMyTeLl/PCGHbSxy4MocFpIRZQFNi/S59kDCzAJ9E7+8nTBCdvBIdbUIQ1apAD19l
        gbClJSZ2d0Md4CFx89VxsOuFBCYwSuy5Wj6BUXYWwtAFjIyrGCVTC4pz01OLTQuM81LL4RGV
        nJ+7iRGcNLW8dzA+evBB7xAjEwfjIUYJDmYlEV6riKlJQrwpiZVVqUX58UWlOanFhxhNgSE2
        kVlKNDkfmLbzSuINTSwNTMzMzEwsjc0MlcR5Bf43JgkJpCeWpGanphakFsH0MXFwSjUw7euZ
        PUHxZ//3SbYNG04w39TK+aG6eMGtkrnpYb/e/5rLwHVna1mBvQ2DGuudla7vzL66TSz+9tGr
        M9Pm4mn9q3oaRrNOfZ5tPe/tm9YbR0o3Vx7sPGz6/PJenZLHmyNtf65nzL8q3fYrdv/Sq/wd
        ocYnT/84KrGk52C5591O5Q87pwUf7hK6apD/x63lfenLH1Hud+06HGTfFs613RzQrG1ZLHxu
        8cxlLTM5w+8VXJghZne5Qt7LRP7Y/QNKQpxin/su1974y8lcLH5c7kBj+JmCnSbi69ONqrZr
        Sm1+YbKsuaTtIGNV3dd/xy/1Jn2XP3v2wgSGrvXKIcmL1v97pPe9OeXSSmMFuxehftfNNyix
        FGckGmoxFxUnAgD3EZgHIwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsWy7bCSvK5O3tQkg+/f5S0ezNvGZvHy51U2
        i2svL7BbTPvwk9ni8n5ti/lHzrFa9L14yGyx6fE1VouHr8ItLu+aw2YxYdU3Fovu6zvYLJYf
        /8dksWjrF3aL1r1H2C123jnB7CDgcfmKt8emVZ1sHneu7WHz2Lyk3uPj01ssHn1bVjF6/Gua
        y+7xeZOcR/uBbqYAzigum5TUnMyy1CJ9uwSujENLVzMXrDGv6N3i0MD4QreLkZNDQsBEYuqz
        BcwgtpDADkaJ31cVIOLSEtc3TmCHsIUlVv57DmRzAdU0MUm8mbmaCSTBJqAtcXf6FjBbRKCd
        UeL+djYQm1ngDpPEqh4REFtYwF3iz9zzLCA2i4CqxIz+tWA1vAI2En3X2pkgFshLrN5wAOwI
        TgFbie6Np5kgDrKReHz/NcsERr4FjAyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGC
        g11LawfjnlUf9A4xMnEwHmKU4GBWEuG1ipiaJMSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJ
        eCGB9MSS1OzU1ILUIpgsEwenVAOTTO427fMsi1IqDyg5mU2emdT3OaFV8kyWV/b1mXv9j09Y
        XhdZp76L7V6zfTRL0H7X4+XcAXM818yTEJ783/oee6Nn7ibzxPXLpHzDEv6d38u7IWxhaZyW
        S623Dd9qVp7Nr8NCr8tv4tLLNP/zdnfmRbavc+J81rPpX9D6E/9hexaf9vWZiuvmeVyIirJU
        Y4/UTI5aubqkfRuvnN89xledZcH73HIq/XvjZz+8803nVrl7rCm/6zaD6LcrHR9K+T3lnxLF
        dfib+N/1SzwzcuwtvRSjBDIuGMVy7Tkayf8xS9slKjt52u5l9gz1693sPnuGX5y6O/Kv5O2q
        FdXskXuzBbMM2pefLohqXsYjpMRSnJFoqMVcVJwIABKdi9PlAgAA
X-CMS-MailID: 20220531012356epcas5p3cd6638d4d3eccb28a28d064c9f585a4f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220531012356epcas5p3cd6638d4d3eccb28a28d064c9f585a4f
References: <20220531012220.80563-1-alim.akhtar@samsung.com>
        <CGME20220531012356epcas5p3cd6638d4d3eccb28a28d064c9f585a4f@epcas5p3.samsung.com>
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

Adds support of UFS HCI which is found in Tesla
FSD SoC. FSD also have an addition bit for MPHY
APB clock which was not there (was reserved) for
previous exynos SoC.

Cc: linux-fsd@tesla.com
Signed-off-by: Bharat Uppal <bharat.uppal@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/ufs/host/ufs-exynos.c | 143 +++++++++++++++++++++++++++++++++-
 1 file changed, 142 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index a81d8cbd542f..b3efdc4caca2 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -52,11 +52,12 @@
 #define HCI_ERR_EN_DME_LAYER	0x88
 #define HCI_CLKSTOP_CTRL	0xB0
 #define REFCLKOUT_STOP		BIT(4)
+#define MPHY_APBCLK_STOP        BIT(3)
 #define REFCLK_STOP		BIT(2)
 #define UNIPRO_MCLK_STOP	BIT(1)
 #define UNIPRO_PCLK_STOP	BIT(0)
 #define CLK_STOP_MASK		(REFCLKOUT_STOP | REFCLK_STOP |\
-				 UNIPRO_MCLK_STOP |\
+				 UNIPRO_MCLK_STOP | MPHY_APBCLK_STOP|\
 				 UNIPRO_PCLK_STOP)
 #define HCI_MISC		0xB4
 #define REFCLK_CTRL_EN		BIT(7)
@@ -386,6 +387,104 @@ static int exynos7_ufs_post_pwr_change(struct exynos_ufs *ufs,
 	return 0;
 }
 
+static inline int fsd_ufs_pre_link(struct exynos_ufs *ufs)
+{
+	int i;
+	struct ufs_hba *hba = ufs->hba;
+
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x9514), 1000000000L / ufs->mclk_rate);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x201), 0x12);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x200), 0x40);
+
+	for_each_ufs_tx_lane(ufs, i) {
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0xAA, i), 1000000000L / ufs->mclk_rate);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x8F, i), 0x3F);
+	}
+
+	for_each_ufs_rx_lane(ufs, i) {
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x12, i), 1000000000L / ufs->mclk_rate);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x5C, i), 0x38);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x0F, i), 0x0);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x65, i), 0x1);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x69, i), 0x1);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x21, i), 0x0);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x22, i), 0x0);
+	}
+
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x200), 0x0);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x9536), 0x4E20);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x9564), 0x2e820183);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x155E), 0x0);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x3000), 0x0);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x3001), 0x1);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x4021), 0x1);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x4020), 0x1);
+
+	return 0;
+}
+
+static inline int fsd_ufs_post_link(struct exynos_ufs *ufs)
+{
+	int i;
+	struct ufs_hba *hba = ufs->hba;
+	u32 hw_cap_min_tactivate;
+	u32 peer_rx_min_actv_time_cap;
+	u32 max_rx_hibern8_time_cap;
+
+	ufshcd_dme_get(hba, UIC_ARG_MIB_SEL(0x8F, 4),
+			&hw_cap_min_tactivate); /* HW Capability of MIN_TACTIVATE */
+	ufshcd_dme_get(hba, UIC_ARG_MIB(0x15A8),
+			&peer_rx_min_actv_time_cap);    /* PA_TActivate */
+	ufshcd_dme_get(hba, UIC_ARG_MIB(0x15A7),
+			&max_rx_hibern8_time_cap);      /* PA_Hibern8Time */
+
+	if (peer_rx_min_actv_time_cap >= hw_cap_min_tactivate)
+		ufshcd_dme_peer_set(hba, UIC_ARG_MIB(0x15A8),
+					peer_rx_min_actv_time_cap + 1);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x15A7), max_rx_hibern8_time_cap + 1);
+
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x9529), 0x01);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x15A4), 0xFA);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x9529), 0x00);
+
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x200), 0x40);
+
+	for_each_ufs_rx_lane(ufs, i) {
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x35, i), 0x05);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x73, i), 0x01);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x41, i), 0x02);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x42, i), 0xAC);
+	}
+
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x200), 0x0);
+
+	return 0;
+}
+
+static inline int fsd_ufs_pre_pwr_change(struct exynos_ufs *ufs,
+					struct ufs_pa_layer_attr *pwr)
+{
+	struct ufs_hba *hba = ufs->hba;
+
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x1569), 0x1);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x1584), 0x1);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x2041), 8064);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x2042), 28224);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x2043), 20160);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x15B0), 12000);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x15B1), 32000);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x15B2), 16000);
+
+	unipro_writel(ufs, 8064, 0x7888);
+	unipro_writel(ufs, 28224, 0x788C);
+	unipro_writel(ufs, 20160, 0x7890);
+	unipro_writel(ufs, 12000, 0x78B8);
+	unipro_writel(ufs, 32000, 0x78BC);
+	unipro_writel(ufs, 16000, 0x78C0);
+
+	return 0;
+}
+
 /*
  * exynos_ufs_auto_ctrl_hcc - HCI core clock control by h/w
  * Control should be disabled in the below cases
@@ -1595,6 +1694,46 @@ static struct exynos_ufs_drv_data exynos_ufs_drvs = {
 	.post_pwr_change	= exynos7_ufs_post_pwr_change,
 };
 
+static struct exynos_ufs_uic_attr fsd_uic_attr = {
+	.tx_trailingclks		= 0x10,
+	.tx_dif_p_nsec			= 3000000,	/* unit: ns */
+	.tx_dif_n_nsec			= 1000000,	/* unit: ns */
+	.tx_high_z_cnt_nsec		= 20000,	/* unit: ns */
+	.tx_base_unit_nsec		= 100000,	/* unit: ns */
+	.tx_gran_unit_nsec		= 4000,		/* unit: ns */
+	.tx_sleep_cnt			= 1000,		/* unit: ns */
+	.tx_min_activatetime		= 0xa,
+	.rx_filler_enable		= 0x2,
+	.rx_dif_p_nsec			= 1000000,	/* unit: ns */
+	.rx_hibern8_wait_nsec		= 4000000,	/* unit: ns */
+	.rx_base_unit_nsec		= 100000,	/* unit: ns */
+	.rx_gran_unit_nsec		= 4000,		/* unit: ns */
+	.rx_sleep_cnt			= 1280,		/* unit: ns */
+	.rx_stall_cnt			= 320,		/* unit: ns */
+	.rx_hs_g1_sync_len_cap		= SYNC_LEN_COARSE(0xf),
+	.rx_hs_g2_sync_len_cap		= SYNC_LEN_COARSE(0xf),
+	.rx_hs_g3_sync_len_cap		= SYNC_LEN_COARSE(0xf),
+	.rx_hs_g1_prep_sync_len_cap	= PREP_LEN(0xf),
+	.rx_hs_g2_prep_sync_len_cap	= PREP_LEN(0xf),
+	.rx_hs_g3_prep_sync_len_cap	= PREP_LEN(0xf),
+	.pa_dbg_option_suite		= 0x2E820183,
+};
+
+struct exynos_ufs_drv_data fsd_ufs_drvs = {
+	.uic_attr               = &fsd_uic_attr,
+	.quirks                 = UFSHCD_QUIRK_PRDT_BYTE_GRAN |
+				  UFSHCI_QUIRK_BROKEN_REQ_LIST_CLR |
+				  UFSHCD_QUIRK_BROKEN_OCS_FATAL_ERROR |
+				  UFSHCI_QUIRK_SKIP_RESET_INTR_AGGR,
+	.opts                   = EXYNOS_UFS_OPT_HAS_APB_CLK_CTRL |
+				  EXYNOS_UFS_OPT_BROKEN_AUTO_CLK_CTRL |
+				  EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR |
+				  EXYNOS_UFS_OPT_BROKEN_RX_SEL_IDX,
+	.pre_link               = fsd_ufs_pre_link,
+	.post_link              = fsd_ufs_post_link,
+	.pre_pwr_change         = fsd_ufs_pre_pwr_change,
+};
+
 static const struct of_device_id exynos_ufs_of_match[] = {
 	{ .compatible = "samsung,exynos7-ufs",
 	  .data	      = &exynos_ufs_drvs },
@@ -1602,6 +1741,8 @@ static const struct of_device_id exynos_ufs_of_match[] = {
 	  .data	      = &exynosauto_ufs_drvs },
 	{ .compatible = "samsung,exynosautov9-ufs-vh",
 	  .data	      = &exynosauto_ufs_vh_drvs },
+	{ .compatible = "tesla,fsd-ufs",
+	  .data       = &fsd_ufs_drvs },
 	{},
 };
 
-- 
2.25.1

