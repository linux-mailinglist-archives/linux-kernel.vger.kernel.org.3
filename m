Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66521545D89
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 09:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346955AbiFJHdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 03:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346956AbiFJHcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:32:51 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A8212C974
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 00:32:33 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220610073231epoutp0228b9041e826da7ea704385360721e3fa~3Mf0jBhQX0393403934epoutp02C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 07:32:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220610073231epoutp0228b9041e826da7ea704385360721e3fa~3Mf0jBhQX0393403934epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654846351;
        bh=jfrCxOTspQsDYxBqpuM9Y+1S8WyqLthYpQvnJd8kMXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L0unyJRhhn8+7PA1FuxBGS6QQRgNQfkWRcZ5C+6rjuAJePpRmjjx9/5FhPfMTjx0b
         lnktaxE3IKzt1SVuOtbZkI++R7CQmi84acKki93cdARQXqXpgWRU6PIunF2RMZuabF
         GKRJkxGmo4+unjC8hiqm/3hNzLsHZiddYxauwNLE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220610073230epcas5p2da7d837aafd9b9bdfa6ee35e1b3b33b9~3MfzuKKbJ2725027250epcas5p2c;
        Fri, 10 Jun 2022 07:32:30 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LKCNB0t6jz4x9QB; Fri, 10 Jun
        2022 07:32:26 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DD.B2.09827.683F2A26; Fri, 10 Jun 2022 16:32:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220610073221epcas5p2307590d637c53e2a94b65b45a6fcb950~3Mfrlt0yi2709327093epcas5p2L;
        Fri, 10 Jun 2022 07:32:21 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220610073221epsmtrp2d9a72dcddc4aaf5d61a073ea0bf3b747~3Mfrkw4481530715307epsmtrp2P;
        Fri, 10 Jun 2022 07:32:21 +0000 (GMT)
X-AuditID: b6c32a4a-b51ff70000002663-a9-62a2f38691ea
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.4E.08924.583F2A26; Fri, 10 Jun 2022 16:32:21 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220610073218epsmtip15c39da440d169979a904aa6f992b1cb5~3Mfo23NJX3168331683epsmtip1a;
        Fri, 10 Jun 2022 07:32:18 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, chanho61.park@samsung.com,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        Bharat Uppal <bharat.uppal@samsung.com>
Subject: [PATCH v3 6/6] ufs: host: ufs-exynos: add support for fsd ufs hci
Date:   Fri, 10 Jun 2022 12:59:24 +0530
Message-Id: <20220610072924.12362-7-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220610072924.12362-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnk+LIzCtJLcpLzFFi42LZdlhTU7ft86Ikg79NEhYP5m1js3j58yqb
        xbWXF9gtpn34yWxxeb+2xfwj51gt+l48ZLbY9Pgaq8XlXXPYLCas+sZi0X19B5vF8uP/mCwW
        bf3CbtG69wi7xc47J5gd+D0uX/H22LSqk83jzrU9bB6bl9R7fHx6i8Wjb8sqRo/Pm+Q82g90
        MwVwRGXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gCd
        rqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCnQK07MLS7NS9fLSy2xMjQwMDIF
        KkzIzljYcJe9YJdFxcplt9kaGNv1uxg5OSQETCR+flzP1MXIxSEksJtRYvLie2wQzidGiV33
        bkM5nxklrj14yQjT8mXtBaiWXYwSH/d8h6pqYZLYMPMsWBWbgLbE3elbwKpEBJoZJQ527AJz
        mAV2Mklc/D2dGaRKWMBLYv7fTrAOFgFVibuz9rF0MXJw8ArYSLx76g2xTl5i9YYDYOWcArYS
        Z/9vYAaZIyEwlUNiXmcLO0SRi8SxeUdZIGxhiVfHt0DFpSQ+v9vLBjJTQsBDYtEfKYhwhsTb
        5euh3rGXOHBlDthaZgFNifW7wAHDLMAn0fv7CRNEJ69ER5sQRLWqRPO7q1CLpCUmdnezwgw/
        cS4OEgwTGCW2NrewTmCUnYUwdAEj4ypGydSC4tz01GLTAqO81HJ4RCXn525iBKdILa8djA8f
        fNA7xMjEwXiIUYKDWUmEN+D2oiQh3pTEyqrUovz4otKc1OJDjKbAAJvILCWanA9M0nkl8YYm
        lgYmZmZmJpbGZoZK4rwC/xuThATSE0tSs1NTC1KLYPqYODilGpi8/9XsbHv3+eLiX2yXL3Cm
        Vr332rli4Q6tP7alGxlKX+z61h9eMHn9sYO7FSctlV/YvvC/g5P/JtZYfh6xRRfe9C6dvfp/
        +NcX89h9J5zZx/YgNJLnoIjaLUfB77FWxfMNKhoPnnlscXVWpdL7fem5OvdmHmc+pbuTscau
        4dS2x19V9qcrxbE+WTrnd+tHs/Ae7XPmjSzV7T73rRJ4F89Z/nBrimiU81XDzuoy/Yr5X/Y3
        nDR5s3RJ36PyxQrfgrcuV7a7kxt/i9v/6MNIz2kXONZ9fCy1hq+cteWGrLVU1vTOd9MU4/W9
        XrjWS9+/uNFeWX+zReddj7i6lMLKP/Obr1w5OI/P17El+snDqY/vKrEUZyQaajEXFScCABWa
        Pv4aBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWy7bCSnG7r50VJBheOqFg8mLeNzeLlz6ts
        FtdeXmC3mPbhJ7PF5f3aFvOPnGO16HvxkNli0+NrrBaXd81hs5iw6huLRff1HWwWy4//Y7JY
        tPULu0Xr3iPsFjvvnGB24Pe4fMXbY9OqTjaPO9f2sHlsXlLv8fHpLRaPvi2rGD0+b5LzaD/Q
        zRTAEcVlk5Kak1mWWqRvl8CVsbDhLnvBLouKlctuszUwtut3MXJySAiYSHxZe4Gpi5GLQ0hg
        B6PEknX3WSAS0hLXN05gh7CFJVb+e84OUdTEJDHl5XFmkASbgLbE3elbmEBsEYF2Ron729lA
        ipgFjjJJLD91DKxIWMBLYv7fTkYQm0VAVeLurH1AGzg4eAVsJN499YZYIC+xesMBsHJOAVuJ
        s/83MIOUCAGVvP6bN4GRbwEjwypGydSC4tz03GLDAqO81HK94sTc4tK8dL3k/NxNjODg1tLa
        wbhn1Qe9Q4xMHIyHGCU4mJVEeANuL0oS4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8kEB6
        YklqdmpqQWoRTJaJg1OqgWn9wv9T9T7Vnzw3Oz+3za31jfBesXzLuX6HlrY/CDTNP6LPeaq9
        U3LTu/tcAfocfx6+FiwIFFbYcUIiOGx+yJTPh/TOBa6rMTuvXPjFnn9BTa9G18YD73/Mtkni
        d1aXKSxi6Luzs9/b2swnRLZD7xE/X7zKNRkBnoD7e6/aLO495a7Rs6b5xwNexgSLV9ENBXzz
        9m1K2p7D9tGPzVnA/ejkF1s56p/ELGZc+/eulrDImu6TiapHbha47H8asufUEg3dyX1Sr1VV
        Ti02m7dYMS9eJnrqJe7Jfrq62j3tt3n2dBf7NHhfK57oejS33+3smRs1wXpZfq+X/UtPdPv0
        W/VhsG6o9GXBS7OUGuVklFiKMxINtZiLihMBfwAN6d0CAAA=
X-CMS-MailID: 20220610073221epcas5p2307590d637c53e2a94b65b45a6fcb950
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220610073221epcas5p2307590d637c53e2a94b65b45a6fcb950
References: <20220610072924.12362-1-alim.akhtar@samsung.com>
        <CGME20220610073221epcas5p2307590d637c53e2a94b65b45a6fcb950@epcas5p2.samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index cc128aff8871..19068605d9fe 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -146,6 +146,10 @@ enum {
 #define UNIPRO_DME_PWR_REQ_REMOTEL2TIMER1	0x0A8
 #define UNIPRO_DME_PWR_REQ_REMOTEL2TIMER2	0x0AC
 
+#define DME_POWERMODE_REQ_REMOTEL2TIMER0	0x78B8
+#define DME_POWERMODE_REQ_REMOTEL2TIMER1	0x78BC
+#define DME_POWERMODE_REQ_REMOTEL2TIMER2	0x78C0
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
+	unipro_writel(ufs, 12000, DME_POWERMODE_REQ_REMOTEL2TIMER0);
+	unipro_writel(ufs, 32000, DME_POWERMODE_REQ_REMOTEL2TIMER1);
+	unipro_writel(ufs, 16000, DME_POWERMODE_REQ_REMOTEL2TIMER2);
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

