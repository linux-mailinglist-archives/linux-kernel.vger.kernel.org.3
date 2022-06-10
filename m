Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F86E54648E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 12:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348660AbiFJKs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 06:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347799AbiFJKrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:47:55 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28EF2D6A87
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 03:44:06 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220610104405epoutp02cf66446004e7200bdf819c5562a4b6e7~3PHFN0YAh1293812938epoutp02M
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 10:44:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220610104405epoutp02cf66446004e7200bdf819c5562a4b6e7~3PHFN0YAh1293812938epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654857845;
        bh=nNXXtCqzcW85fjUNT/01i9F7oXasj1yIMkAANF1CT/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HuAUPdn43HHgoWMV/BYXww3k46kGs8+8l2F7YxSArIR5yeV8dpxCkkDLO2qeYUxDR
         ywq45lG+2/Wd6GIzE5ezOaN7K+JReEy6wPe2U1L0URRhAFXJSb/XnFOyoZaycI77/t
         /FMQmlLjk2Yv/A6ffpyceEIwqjosGTydlZpxSIJ4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220610104404epcas5p34fe9da3fd256d4d36f334c079d87dadd~3PHEtM4d22015320153epcas5p3e;
        Fri, 10 Jun 2022 10:44:04 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LKHdD44Xbz4x9Pr; Fri, 10 Jun
        2022 10:44:00 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.7E.10063.07023A26; Fri, 10 Jun 2022 19:44:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220610104359epcas5p17a61f0254148bc1bdb15d91ff6b3f12c~3PG-9Gq7S0223302233epcas5p14;
        Fri, 10 Jun 2022 10:43:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220610104359epsmtrp2b495601972f59b74cd0887999368841f~3PG-8NQ313034730347epsmtrp2B;
        Fri, 10 Jun 2022 10:43:59 +0000 (GMT)
X-AuditID: b6c32a49-4cbff7000000274f-0a-62a320706bc7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9F.B0.11276.F6023A26; Fri, 10 Jun 2022 19:43:59 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220610104357epsmtip14d37b119d40aac5f21b3762fe1a64e31~3PG92RVTq1417514175epsmtip1M;
        Fri, 10 Jun 2022 10:43:57 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, chanho61.park@samsung.com,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        Bharat Uppal <bharat.uppal@samsung.com>
Subject: [PATCH v4 6/6] ufs: host: ufs-exynos: add support for fsd ufs hci
Date:   Fri, 10 Jun 2022 16:11:19 +0530
Message-Id: <20220610104119.66401-7-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220610104119.66401-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdlhTQ7dAYXGSQf9NWYsH87axWbz8eZXN
        4trLC+wW0z78ZLa4vF/bYv6Rc6wWfS8eMltsenyN1eLyrjlsFhNWfWOx6L6+g81i+fF/TBaL
        tn5ht2jde4TdYuedE8wO/B6Xr3h7bFrVyeZx59oeNo/NS+o9Pj69xeLRt2UVo8fnTXIe7Qe6
        mQI4orJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4BO
        V1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoYGJkC
        FSZkZ+w79JS54IlFxYYV15gbGDfqdzFyckgImEjcPfuctYuRi0NIYDejxJ+ld5khnE+MEpsm
        PoLKfGOUWNV+hQWmZeKOdcwgtpDAXkaJrf90IYpamCRW7WxhB0mwCWhL3J2+hQkkISLQzChx
        sGMXmMMssJNJ4uLv6WDtwgJeEh+XLWYFsVkEVCVa/mwC6+YVsJF4teA4K8Q6eYnVGw6A1XMK
        2Eo8W38Z7CYJgakcEl8mvIIqcpE48uEn1H3CEq+Ob2GHsKUkPr/by9bFyAFke0gs+iMFEc6Q
        eLt8PSOEbS9x4MocFpASZgFNifW7wAHDLMAn0fv7CRNEJ69ER5sQRLWqRPO7q1CLpCUmdndD
        HeAhsXLmAWhoTWCU+NV3h3UCo+wshKkLGBlXMUqmFhTnpqcWmxYY5qWWw2MqOT93EyM4SWp5
        7mC8++CD3iFGJg7GQ4wSHMxKIrwBtxclCfGmJFZWpRblxxeV5qQWH2I0BQbZRGYp0eR8YJrO
        K4k3NLE0MDEzMzOxNDYzVBLnFfjfmCQkkJ5YkpqdmlqQWgTTx8TBKdXAJHfaOrK6sUxYrOnv
        4Q1a9z72db70PHVvB8vNPxvVN4RI1a1+9t7x0zrDtECrjbv5oiYEcT6yu+6YveaoglDIg8sq
        AtaPVYI+ZvmqX0rb8a0/L0mZb+UsgZaFTr4LlNyCDJj/iP9aWbV7nnattHN39bEP1ju04peU
        ZIWuOj19k//ykPL+uXKevf7XGQz/pq52lCqat+N2rsGCDTuls9fXKx1xXGaqd7wkm6V/tQev
        cdqXj2e+e61i1U3y9nZ9+kBmruuqsx+rdiyf0bTSWmFa3t7smv7UJzx2y9J+TapiPWt8X+mm
        wvrkmNNe67t2Lvg7Oz7O6OTkQ0liWXX/0ibcrzu0s/mZQvGxInuvmfJJSizFGYmGWsxFxYkA
        OV3KSBsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWy7bCSnG6+wuIkg1nNihYP5m1js3j58yqb
        xbWXF9gtpn34yWxxeb+2xfwj51gt+l48ZLbY9Pgaq8XlXXPYLCas+sZi0X19B5vF8uP/mCwW
        bf3CbtG69wi7xc47J5gd+D0uX/H22LSqk83jzrU9bB6bl9R7fHx6i8Wjb8sqRo/Pm+Q82g90
        MwVwRHHZpKTmZJalFunbJXBl7Dv0lLngiUXFhhXXmBsYN+p3MXJySAiYSEzcsY4ZxBYS2M0o
        0XbdCyIuLXF94wR2CFtYYuW/50A2F1BNE5PE29172UASbALaEnenb2ECsUUE2hkl7m9nAyli
        FjjKJLH81DGwqcICXhIfly1mBbFZBFQlWv5sApvKK2Aj8WrBcVaIDfISqzccAKvnFLCVeLb+
        MivERTYSizvOMU9g5FvAyLCKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4vLU0dzBu
        X/VB7xAjEwfjIUYJDmYlEd6A24uShHhTEiurUovy44tKc1KLDzFKc7AoifNe6DoZLySQnliS
        mp2aWpBaBJNl4uCUamDqLdFImB/wVfuR9qd1twpWbcsO6znBn5RsI+6spjw78Nmqj30RRxqP
        PWz35O7bd+PJ4vtlyyPkpt78dV3l2CPljy9ZouV1WC+edo/8uI234TuP08dj0b859cq+CAvv
        +3Nt79IdU3RMpawyvz33XKj0/W+YyaVT8yT8ftzZmumSbLt944p1J5X3nGBimX9Vb9GHnQzx
        7ElfmPYXNB/OjOBoLIqPq9qlzfngX86/OPn9tdeji26d2f8m//rZtb8kdV4XmJ86VvJeOPtO
        VMr1U5//X1KpUZz2qfto1vQduTlHHS//2mHC/Oq1kGsL7/0bQezeEgfKuiba9amsXhRzZI2Y
        idH+PWdsGZ70dOXpXG/iUWIpzkg01GIuKk4EALwTt5neAgAA
X-CMS-MailID: 20220610104359epcas5p17a61f0254148bc1bdb15d91ff6b3f12c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220610104359epcas5p17a61f0254148bc1bdb15d91ff6b3f12c
References: <20220610104119.66401-1-alim.akhtar@samsung.com>
        <CGME20220610104359epcas5p17a61f0254148bc1bdb15d91ff6b3f12c@epcas5p1.samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/ufs/host/ufs-exynos.c | 140 ++++++++++++++++++++++++++++++++++
 drivers/ufs/host/ufs-exynos.h |   1 +
 2 files changed, 141 insertions(+)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index cc128aff8871..69943069093a 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -146,6 +146,10 @@ enum {
 #define UNIPRO_DME_PWR_REQ_REMOTEL2TIMER1	0x0A8
 #define UNIPRO_DME_PWR_REQ_REMOTEL2TIMER2	0x0AC
 
+#define UNIPRO_DME_POWERMODE_REQ_REMOTEL2TIMER0	0x78B8
+#define UNIPRO_DME_POWERMODE_REQ_REMOTEL2TIMER1	0x78BC
+#define UNIPRO_DME_POWERMODE_REQ_REMOTEL2TIMER2	0x78C0
+
 /*
  * UFS Protector registers
  */
@@ -1474,6 +1478,99 @@ static int exynosauto_ufs_vh_init(struct ufs_hba *hba)
 	return 0;
 }
 
+static int fsd_ufs_pre_link(struct exynos_ufs *ufs)
+{
+	int i;
+	struct ufs_hba *hba = ufs->hba;
+
+	ufshcd_dme_set(hba, UIC_ARG_MIB(PA_DBG_CLK_PERIOD),
+		       DIV_ROUND_UP(NSEC_PER_SEC,  ufs->mclk_rate));
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x201), 0x12);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x200), 0x40);
+
+	for_each_ufs_tx_lane(ufs, i) {
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0xAA, i),
+			       DIV_ROUND_UP(NSEC_PER_SEC, ufs->mclk_rate));
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x8F, i), 0x3F);
+	}
+
+	for_each_ufs_rx_lane(ufs, i) {
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x12, i),
+			       DIV_ROUND_UP(NSEC_PER_SEC, ufs->mclk_rate));
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x5C, i), 0x38);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x0F, i), 0x0);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x65, i), 0x1);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x69, i), 0x1);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x21, i), 0x0);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x22, i), 0x0);
+	}
+
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x200), 0x0);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(PA_DBG_AUTOMODE_THLD), 0x4E20);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(PA_DBG_OPTION_SUITE), 0x2e820183);
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
+	ufshcd_dme_get(hba, UIC_ARG_MIB(PA_TACTIVATE),
+			&peer_rx_min_actv_time_cap);    /* PA_TActivate */
+	ufshcd_dme_get(hba, UIC_ARG_MIB(PA_HIBERN8TIME),
+			&max_rx_hibern8_time_cap);      /* PA_Hibern8Time */
+
+	if (peer_rx_min_actv_time_cap >= hw_cap_min_tactivate)
+		ufshcd_dme_peer_set(hba, UIC_ARG_MIB(PA_TACTIVATE),
+					peer_rx_min_actv_time_cap + 1);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(PA_HIBERN8TIME), max_rx_hibern8_time_cap + 1);
+
+	ufshcd_dme_set(hba, UIC_ARG_MIB(PA_DBG_MODE), 0x01);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(PA_SAVECONFIGTIME), 0xFA);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(PA_DBG_MODE), 0x00);
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
+	ufshcd_dme_set(hba, UIC_ARG_MIB(PA_PWRMODEUSERDATA0), 12000);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(PA_PWRMODEUSERDATA1), 32000);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(PA_PWRMODEUSERDATA2), 16000);
+
+	unipro_writel(ufs, 12000, UNIPRO_DME_POWERMODE_REQ_REMOTEL2TIMER0);
+	unipro_writel(ufs, 32000, UNIPRO_DME_POWERMODE_REQ_REMOTEL2TIMER1);
+	unipro_writel(ufs, 16000, UNIPRO_DME_POWERMODE_REQ_REMOTEL2TIMER2);
+
+	return 0;
+}
+
 static struct ufs_hba_variant_ops ufs_hba_exynos_ops = {
 	.name				= "exynos_ufs",
 	.init				= exynos_ufs_init,
@@ -1596,6 +1693,47 @@ static struct exynos_ufs_drv_data exynos_ufs_drvs = {
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
+				  UFSHCD_QUIRK_SKIP_DEF_UNIPRO_TIMEOUT_SETTING |
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
@@ -1603,6 +1741,8 @@ static const struct of_device_id exynos_ufs_of_match[] = {
 	  .data	      = &exynosauto_ufs_drvs },
 	{ .compatible = "samsung,exynosautov9-ufs-vh",
 	  .data	      = &exynosauto_ufs_vh_drvs },
+	{ .compatible = "tesla,fsd-ufs",
+	  .data       = &fsd_ufs_drvs },
 	{},
 };
 
diff --git a/drivers/ufs/host/ufs-exynos.h b/drivers/ufs/host/ufs-exynos.h
index 0b0a3d530ca6..a4bd6646d7f1 100644
--- a/drivers/ufs/host/ufs-exynos.h
+++ b/drivers/ufs/host/ufs-exynos.h
@@ -22,6 +22,7 @@
 #define PA_DBG_RXPHY_CFGUPDT	0x9519
 #define PA_DBG_MODE		0x9529
 #define PA_DBG_SKIP_RESET_PHY	0x9539
+#define PA_DBG_AUTOMODE_THLD	0x9536
 #define PA_DBG_OV_TM		0x9540
 #define PA_DBG_SKIP_LINE_RESET	0x9541
 #define PA_DBG_LINE_RESET_REQ	0x9543
-- 
2.25.1

