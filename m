Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E4B53CCA2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245598AbiFCPtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245744AbiFCPtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:49:24 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B756A50B0A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 08:49:13 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220603154912epoutp0160f03667741feb38b02855b8c07146c9~1Jwe2x7kK2387423874epoutp011
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 15:49:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220603154912epoutp0160f03667741feb38b02855b8c07146c9~1Jwe2x7kK2387423874epoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654271352;
        bh=nAAdczoptIQX9J/30j3O2d4sDcZFY4mw+TnQRCYPCGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VQF4GV+641u/Rm8bqquZvCr0V066I2mZtCOu7wgRQmlaHYx8QH+aokGgngqcHn6z1
         vGsvSNGIG/tBu1z6JUAABgiEf8wm9wWNDjFadbGxSMurOaFioeqXyCE2Qismzi8Nm3
         zMKrzLWCovK8Fv2XMSeXDgaF7CyWAOCrhhInHaiI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220603154910epcas5p148d91669558e981151e3073abb8ac73b~1JwdfiJKn1786817868epcas5p1B;
        Fri,  3 Jun 2022 15:49:10 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LF6kX1Kygz4x9Pq; Fri,  3 Jun
        2022 15:49:08 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        52.B8.10063.47D2A926; Sat,  4 Jun 2022 00:49:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220603154907epcas5p40d236cecf8d4a574d44d9a2b66f2caf0~1Jwar-PMu1859418594epcas5p4Y;
        Fri,  3 Jun 2022 15:49:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220603154907epsmtrp20192da1fc3c1e4f53f71341803909d33~1JwarMSwc0407504075epsmtrp2t;
        Fri,  3 Jun 2022 15:49:07 +0000 (GMT)
X-AuditID: b6c32a49-4b5ff7000000274f-56-629a2d74d45a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        78.6C.11276.37D2A926; Sat,  4 Jun 2022 00:49:07 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220603154905epsmtip17439279bb49f8fbbb6e799414e436980~1JwYkBDnR2493724937epsmtip1V;
        Fri,  3 Jun 2022 15:49:05 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, chanho61.park@samsung.com,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        Bharat Uppal <bharat.uppal@samsung.com>
Subject: [PATCH v2 6/7] ufs: host: ufs-exynos: add support for fsd ufs hci
Date:   Fri,  3 Jun 2022 21:17:13 +0530
Message-Id: <20220603154714.30532-7-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220603154714.30532-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplk+LIzCtJLcpLzFFi42LZdlhTU7dEd1aSwdEfLBYP5m1js3j58yqb
        xbWXF9gtpn34yWxxeb+2xfwj51gt+l48ZLbY9Pgaq8XlXXPYLCas+sZi0X19B5vF8uP/mCwW
        bf3CbtG69wi7xc47J5gd+D0uX/H22LSqk83jzrU9bB6bl9R7fHx6i8Wjb8sqRo/Pm+Q82g90
        MwVwRGXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gCd
        rqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCnQK07MLS7NS9fLSy2xMjQwMDIF
        KkzIztjw5DhrQZdRxcbzc9kaGC9odjFycEgImEj09zl2MXJxCAnsZpRY2fGXFcL5xCjRs6qP
        BcL5xigxq/0WUIYTrOPb90fsILaQwF5Gib1TIyGKWpgkGtfeZQJJsAloS9ydvoUJJCEi0Mwo
        cbBjF5jDLLCTSeLi7+nMIFXCAl4SM3Z1gnWwCKhKPDlxD2wFr4CNxPNzp9gg1slLrN5wgBnk
        WE4BW4mpp/kgwjM5JK6tYIKwXSRazm6HsoUlXh3fwg5hS0l8freXDeJPD4lFf6QgwhkSb5ev
        Z4Sw7SUOXJnDAlLCLKApsX6XPkiYWYBPovf3EyaITl6JjjYhiGpVieZ3V1kgbGmJid3d0CDx
        kDh59xc7JBgmMEq0HrnJNoFRdhbC1AWMjKsYJVMLinPTU4tNCwzzUsvh0ZScn7uJEZwetTx3
        MN598EHvECMTB+MhRgkOZiUR3rJ5M5OEeFMSK6tSi/Lji0pzUosPMZoCA2wis5Rocj4wQeeV
        xBuaWBqYmJmZmVgamxkqifMK/G9MEhJITyxJzU5NLUgtgulj4uCUamBa8+NC05cyvp3x8XuT
        /5jzHRNPaHU8K5K48rjNs0NBUXWMB7T5J/gohKx1mFZd8m2rTm7JnNspYilvbfdOiXn6+prk
        j4N3ez5KevO3n5iuJXWV4dGE3OtCl/7LftDOWCi2ZHLk4/9GGw5curTlcurzb+/vhez4vGrG
        5pvfA5f/6l5cuSlVau+9vwGOH5MkBcJC1Z1sjtvxxpk1MEdsu5W8mS3vaIWTKV/w2k6NLGHD
        J/Lb9vd+XPje613JGt/526RurineJt8u+n5iJf/vuwy7zje9dE6zu+T37D6Ho13cUeVlt3sZ
        YyZxlR5jC5mzqqiL+26Ts9LxHT31T8W4+Q3UPh13t5PdOWn7+4iSiI4KJZbijERDLeai4kQA
        FfhP6hgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWy7bCSnG6x7qwkg/8XVS0ezNvGZvHy51U2
        i2svL7BbTPvwk9ni8n5ti/lHzrFa9L14yGyx6fE1VovLu+awWUxY9Y3Fovv6DjaL5cf/MVks
        2vqF3aJ17xF2i513TjA78HtcvuLtsWlVJ5vHnWt72Dw2L6n3+Pj0FotH35ZVjB6fN8l5tB/o
        ZgrgiOKySUnNySxLLdK3S+DK2PDkOGtBl1HFxvNz2RoYL2h2MXJySAiYSHz7/oi9i5GLQ0hg
        N6PE7sWzGSES0hLXN05gh7CFJVb+ew5mCwk0MUmsvloKYrMJaEvcnb6FCcQWEWhnlLi/nQ1k
        ELPAUSaJ5aeOMYMkhAW8JGbs6gQrYhFQlXhy4h4riM0rYCPx/NwpNogF8hKrNxwAqufg4BSw
        lZh6mg9il43E9/P3WScw8i1gZFjFKJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7iREc3Fqa
        Oxi3r/qgd4iRiYPxEKMEB7OSCG/ZvJlJQrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJI
        TyxJzU5NLUgtgskycXBKNTAdiuuTrVBnu3xILvuu8e2HjaprFi3d1VAwIbWy/dokp5MTRLcp
        cvwN0wv4GqQge0Pv6N47lrtPGpnFuT2TDONgrF3+9fTUrdejV62a8XE1u/16rsSY3YEvec33
        Wsy9t1RYpKXlfrupnlMZN9/xfy3x34ynXeN7w+HT7dF5LDVog5djSOKFcxLM1/dl+//a8WK+
        4pYP/Lt2c8hfD436bzdbxovrwzI7j/qOwCeiOh8CX+8KWDbznnrCuYyEAzUbspjWcacpcG9L
        n7Yup/nnbMY7d2wSVEQ2Krddj2+T0+rU/5xu0xotxjN/jdUe20+rJ/pU9ETb5S7I8eCacOH8
        /4gSzU+7POVC5bNYi0013ymxFGckGmoxFxUnAgBxxtpR3QIAAA==
X-CMS-MailID: 20220603154907epcas5p40d236cecf8d4a574d44d9a2b66f2caf0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220603154907epcas5p40d236cecf8d4a574d44d9a2b66f2caf0
References: <20220603154714.30532-1-alim.akhtar@samsung.com>
        <CGME20220603154907epcas5p40d236cecf8d4a574d44d9a2b66f2caf0@epcas5p4.samsung.com>
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

Adds support of UFS HCI which is found in Tesla Full Self-Driving (FSD)
SoC.

Signed-off-by: Bharat Uppal <bharat.uppal@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/ufs/host/ufs-exynos.c | 138 ++++++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index cc128aff8871..7e0ab8a8662e 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -1474,6 +1474,102 @@ static int exynosauto_ufs_vh_init(struct ufs_hba *hba)
 	return 0;
 }
 
+static int fsd_ufs_pre_link(struct exynos_ufs *ufs)
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
+	ufshcd_dme_set(hba, UIC_ARG_MIB(PA_LOCAL_TX_LCC_ENABLE), 0x0);
+
+	exynos_ufs_establish_connt(ufs);
+
+	return 0;
+}
+
+static int fsd_ufs_post_link(struct exynos_ufs *ufs)
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
+static int fsd_ufs_pre_pwr_change(struct exynos_ufs *ufs,
+					struct ufs_pa_layer_attr *pwr)
+{
+	struct ufs_hba *hba = ufs->hba;
+
+	ufshcd_dme_set(hba, UIC_ARG_MIB(PA_TXTERMINATION), 0x1);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(PA_RXTERMINATION), 0x1);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(DL_FC0PROTTIMEOUTVAL), 8064);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(DL_TC0REPLAYTIMEOUTVAL), 28224);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(DL_AFC0REQTIMEOUTVAL), 20160);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(PA_PWRMODEUSERDATA0), 12000);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(PA_PWRMODEUSERDATA1), 32000);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(PA_PWRMODEUSERDATA2), 16000);
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
 static struct ufs_hba_variant_ops ufs_hba_exynos_ops = {
 	.name				= "exynos_ufs",
 	.init				= exynos_ufs_init,
@@ -1596,6 +1692,46 @@ static struct exynos_ufs_drv_data exynos_ufs_drvs = {
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
@@ -1603,6 +1739,8 @@ static const struct of_device_id exynos_ufs_of_match[] = {
 	  .data	      = &exynosauto_ufs_drvs },
 	{ .compatible = "samsung,exynosautov9-ufs-vh",
 	  .data	      = &exynosauto_ufs_vh_drvs },
+	{ .compatible = "tesla,fsd-ufs",
+	  .data       = &fsd_ufs_drvs },
 	{},
 };
 
-- 
2.25.1

