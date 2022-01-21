Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86AE496431
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381851AbiAURl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:41:59 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:28192 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381848AbiAURlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:41:03 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220121174101epoutp013661c76cb1a7f1af92bdbcc029b5173a~MWfJb5VS41378513785epoutp01F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 17:41:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220121174101epoutp013661c76cb1a7f1af92bdbcc029b5173a~MWfJb5VS41378513785epoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642786861;
        bh=tTvMxHRo/g/5zSYbaTLoFVulyoDTWSTCAwMURVwztK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lp1MbxnSzqO+CmfyE3jScZGTxwA7NoD4l8fH99+U8nVD3g6kyM5UfZGhrG3TYOGfw
         hNs+Pny7z9J0Rmu0MP+LnliD7oMgVt16WW+cngzjG9lc/lmqRMcHcBTqcQbXXzIQEX
         af+pfe0LujRLR8qcMzBUP/voupa5ZziI1uMLnjd0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220121174100epcas5p1be21e87dce5cebfb14c2d2cbebace7d9~MWfIlxKF-2780827808epcas5p1Y;
        Fri, 21 Jan 2022 17:41:00 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JgRVt6yTVz4x9Pv; Fri, 21 Jan
        2022 17:40:54 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        99.8B.46822.54FEAE16; Sat, 22 Jan 2022 02:37:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220121174054epcas5p313db9c80af71592554a9c4a7b8d105ec~MWfCsUDbp2795427954epcas5p3X;
        Fri, 21 Jan 2022 17:40:54 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220121174054epsmtrp2e035cd3bf2f97f4e8875c93d26dbbaf1~MWfCq_M9O1824918249epsmtrp2q;
        Fri, 21 Jan 2022 17:40:54 +0000 (GMT)
X-AuditID: b6c32a4a-de5ff7000000b6e6-27-61eaef453315
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        4A.B7.08738.620FAE16; Sat, 22 Jan 2022 02:40:54 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220121174051epsmtip2fdd4121dc968de92ff5cf026055b143d~MWfAAp-lU2322623226epsmtip2i;
        Fri, 21 Jan 2022 17:40:51 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, sboyd@kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com,
        Arjun K V <arjun.kv@samsung.com>,
        Tauseef Nomani <tauseef.n@samsung.com>
Subject: [PATCH v3 08/16] clk: samsung: fsd: Add cmu_imem block clock
 information
Date:   Fri, 21 Jan 2022 22:58:32 +0530
Message-Id: <20220121172840.12121-9-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220121172840.12121-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMJsWRmVeSWpSXmKPExsWy7bCmlq7r+1eJBvfuGlo8mLeNzWL5yl0s
        Fn8nHWO3eL+sh9Fi/pFzrBYb3/5gspjyZzmTxabH11gtPvbcY7V4+Crc4vKuOWwWM87vY7I4
        df0zm8WirV/YLVr3HmG3OPymndXi37WNLBaPr/9hs7h0cjKLg7DHmnlrGD1+/5rE6DGroZfN
        Y9OqTjaPO9f2sHlsXlLvceVEE6tH35ZVjB7/muaye3zeJBfAFZVtk5GamJJapJCal5yfkpmX
        bqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQP0mZJCWWJOKVAoILG4WEnfzqYov7Qk
        VSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO2P174yCt82MFaefrGZuYLxf
        2sXIwSEhYCKx/rxBFyMXh5DAbkaJ7u2b2bsYOYGcT4wSm/dFQCQ+M0qc2bGdESQB0vD64Xp2
        iMQuRold2zewQTgtTBJ/j31hAaliE9CWuDt9CxOILSLgJnGjsQPMZhY4yyyxtMMHxBYWCJb4
        eOQQ2FQWAVWJE8fvsILYvAI2Em0d06C2yUus3nCAGcTmFLCVeH12HjPIMgmBAxwSl6+uZYUo
        cpH4fvwUlC0s8er4FnYIW0ri87u9bBB/Zkv07DKGCNdILJ13jAXCtpc4cGUOC0gJs4CmxPpd
        +hBn8kn0/n7CBNHJK9HRJgRRrSrR/O4qVKe0xMTubqilHhItK14xQwJuAqPEt8dyExhlZyEM
        XcDIuIpRMrWgODc9tdi0wCgvtRweS8n5uZsYwalVy2sH48MHH/QOMTJxMB5ilOBgVhLhLch/
        lSjEm5JYWZValB9fVJqTWnyI0RQYYhOZpUST84HJPa8k3tDE0sDEzMzMxNLYzFBJnPd0+oZE
        IYH0xJLU7NTUgtQimD4mDk6pBqYKX0Gr8qsbfum82f3jy8Yv664l3LM5oGRR4e4Vee7W+R+8
        m6evMbt/xC7p6B4Zmayc2a9f//yaFLn28cWzLwSY5/8/v7TxpM9WhyN575Y/YfTqDL+75L73
        U1v/s5m932aUrX7ucsHBUm7lSY/DL07YZj1++ZaJu23BYUkunfPV+V/+V71pnx0mpeYXtzrZ
        8fG8C8tshU+/m7/e+O6NecbGbuyKIRr5tZ+6O+a4TdR+GX9xmo5u89b35hX2zmdf1us+XX/5
        yPtXItY2s0JafWJ2FVw9JHt3ee7z/kMb2Lqn7pjDf2arfdBkrt2vnQ0yBW6e1/y9bVL4mSVR
        v3R5anivXpx5z+NhS+Ykc5Gqy583WCmxFGckGmoxFxUnAgDm56fANgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsWy7bCSvK7ah1eJBhc/8lg8mLeNzWL5yl0s
        Fn8nHWO3eL+sh9Fi/pFzrBYb3/5gspjyZzmTxabH11gtPvbcY7V4+Crc4vKuOWwWM87vY7I4
        df0zm8WirV/YLVr3HmG3OPymndXi37WNLBaPr/9hs7h0cjKLg7DHmnlrGD1+/5rE6DGroZfN
        Y9OqTjaPO9f2sHlsXlLvceVEE6tH35ZVjB7/muaye3zeJBfAFcVlk5Kak1mWWqRvl8CVsfp3
        RsHbZsaK009WMzcw3i/tYuTkkBAwkXj9cD17FyMXh5DADkaJWU0XWCAS0hLXN05gh7CFJVb+
        ew5V1MQkMWffTLAiNgFtibvTtzCB2CICHhJt/+4xgxQxC9xnltjUOhmsSFggUGJX0zOwIhYB
        VYkTx++wgti8AjYSbR3TGCE2yEus3nCAGcTmFLCVeH12HpgtBFTTPGsr0wRGvgWMDKsYJVML
        inPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYLjQ0trB+OeVR/0DjEycTAeYpTgYFYS4S3If5Uo
        xJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA1Poq2WBt3+8
        4XpvxbVJV7rbdOmh3acrv80zDbXQmnhv17SZr3z5jigGqNs8DFp//TKDwG89xvXpwaG8PHlm
        9xfvnfzg3pW4hSF3Q7bfsLGbxXVI1vKflbFjF7+I9ue/r18E6D5Un58vXbz+9911W3nyVe/c
        PvQknHl6o8LymiiP35+kDjDYMsqeCvxvc23fyT5mzr12Zp3TXk2IucfEtWKB6p7Iq3vSp7wx
        TZ59f11kS/rm5/2Kq7K5XvqcVei+t8iv8Ge2Sr4Ud4sig88W0/6E7/supNYKHPjYbSYx9XN7
        bEeyftLjU58qza7VtVtKBNVVmRis+ltW0NQ5a2ug8qZXqQIRvfI64k785tfYvZVYijMSDbWY
        i4oTATvVOZz+AgAA
X-CMS-MailID: 20220121174054epcas5p313db9c80af71592554a9c4a7b8d105ec
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220121174054epcas5p313db9c80af71592554a9c4a7b8d105ec
References: <20220121172840.12121-1-alim.akhtar@samsung.com>
        <CGME20220121174054epcas5p313db9c80af71592554a9c4a7b8d105ec@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds cmu_imem clock related code, imem block contains IPs
like WDT, DMA, TMU etc, these clocks are required for such
IP function.

Cc: linux-fsd@tesla.com
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Arjun K V <arjun.kv@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Tauseef Nomani <tauseef.n@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/clk/samsung/clk-fsd.c | 283 ++++++++++++++++++++++++++++++++++
 1 file changed, 283 insertions(+)

diff --git a/drivers/clk/samsung/clk-fsd.c b/drivers/clk/samsung/clk-fsd.c
index 95367d151ab6..d39ec207213e 100644
--- a/drivers/clk/samsung/clk-fsd.c
+++ b/drivers/clk/samsung/clk-fsd.c
@@ -1144,6 +1144,289 @@ static const struct samsung_cmu_info fsys1_cmu_info __initconst = {
 	.clk_name		= "dout_cmu_fsys1_shared0div4",
 };
 
+/* Register Offset definitions for CMU_IMEM (0x10010000) */
+#define PLL_CON0_CLK_IMEM_ACLK				0x100
+#define PLL_CON0_CLK_IMEM_INTMEMCLK			0x120
+#define PLL_CON0_CLK_IMEM_TCUCLK			0x140
+#define DIV_OSCCLK_IMEM_TMUTSCLK			0x1800
+#define GAT_IMEM_IMEM_CMU_IMEM_IPCLKPORT_PCLK		0x2000
+#define GAT_IMEM_MCT_IPCLKPORT_OSCCLK__ALO		0x2004
+#define GAT_IMEM_OTP_CON_TOP_IPCLKPORT_I_OSCCLK		0x2008
+#define GAT_IMEM_RSTNSYNC_OSCCLK_IPCLKPORT_CLK		0x200c
+#define GAT_IMEM_TMU_CPU0_IPCLKPORT_I_CLK		0x2010
+#define GAT_IMEM_TMU_CPU0_IPCLKPORT_I_CLK_TS		0x2014
+#define GAT_IMEM_TMU_CPU2_IPCLKPORT_I_CLK		0x2018
+#define GAT_IMEM_TMU_CPU2_IPCLKPORT_I_CLK_TS		0x201c
+#define GAT_IMEM_TMU_GPU_IPCLKPORT_I_CLK		0x2020
+#define GAT_IMEM_TMU_GPU_IPCLKPORT_I_CLK_TS		0x2024
+#define GAT_IMEM_TMU_GT_IPCLKPORT_I_CLK			0x2028
+#define GAT_IMEM_TMU_GT_IPCLKPORT_I_CLK_TS		0x202c
+#define GAT_IMEM_TMU_TOP_IPCLKPORT_I_CLK		0x2030
+#define GAT_IMEM_TMU_TOP_IPCLKPORT_I_CLK_TS		0x2034
+#define GAT_IMEM_WDT0_IPCLKPORT_CLK			0x2038
+#define GAT_IMEM_WDT1_IPCLKPORT_CLK			0x203c
+#define GAT_IMEM_WDT2_IPCLKPORT_CLK			0x2040
+#define GAT_IMEM_ADM_AXI4ST_I0_IMEM_IPCLKPORT_ACLKM	0x2044
+#define GAT_IMEM_ADM_AXI4ST_I1_IMEM_IPCLKPORT_ACLKM	0x2048
+#define GAT_IMEM_ADM_AXI4ST_I2_IMEM_IPCLKPORT_ACLKM	0x204c
+#define GAT_IMEM_ADS_AXI4ST_I0_IMEM_IPCLKPORT_ACLKS	0x2050
+#define GAT_IMEM_ADS_AXI4ST_I1_IMEM_IPCLKPORT_ACLKS	0x2054
+#define GAT_IMEM_ADS_AXI4ST_I2_IMEM_IPCLKPORT_ACLKS	0x2058
+#define GAT_IMEM_ASYNC_DMA0_IPCLKPORT_PCLKM		0x205c
+#define GAT_IMEM_ASYNC_DMA0_IPCLKPORT_PCLKS		0x2060
+#define GAT_IMEM_ASYNC_DMA1_IPCLKPORT_PCLKM		0x2064
+#define GAT_IMEM_ASYNC_DMA1_IPCLKPORT_PCLKS		0x2068
+#define GAT_IMEM_AXI2APB_IMEMP0_IPCLKPORT_ACLK		0x206c
+#define GAT_IMEM_AXI2APB_IMEMP1_IPCLKPORT_ACLK		0x2070
+#define GAT_IMEM_BUS_D_IMEM_IPCLKPORT_MAINCLK		0x2074
+#define GAT_IMEM_BUS_P_IMEM_IPCLKPORT_MAINCLK		0x2078
+#define GAT_IMEM_BUS_P_IMEM_IPCLKPORT_PERICLK		0x207c
+#define GAT_IMEM_BUS_P_IMEM_IPCLKPORT_TCUCLK		0x2080
+#define GAT_IMEM_DMA0_IPCLKPORT_ACLK			0x2084
+#define GAT_IMEM_DMA1_IPCLKPORT_ACLK			0x2088
+#define GAT_IMEM_GIC500_INPUT_SYNC_IPCLKPORT_CLK	0x208c
+#define GAT_IMEM_GIC_IPCLKPORT_CLK			0x2090
+#define GAT_IMEM_INTMEM_IPCLKPORT_ACLK			0x2094
+#define GAT_IMEM_MAILBOX_SCS_CA72_IPCLKPORT_PCLK	0x2098
+#define GAT_IMEM_MAILBOX_SMS_CA72_IPCLKPORT_PCLK	0x209c
+#define GAT_IMEM_MCT_IPCLKPORT_PCLK			0x20a0
+#define GAT_IMEM_NS_BRDG_IMEM_IPCLKPORT_CLK__PSCO_IMEM__CLK_IMEM_D	0x20a4
+#define GAT_IMEM_NS_BRDG_IMEM_IPCLKPORT_CLK__PSCO_IMEM__CLK_IMEM_TCU	0x20a8
+#define GAT_IMEM_NS_BRDG_IMEM_IPCLKPORT_CLK__PSOC_IMEM__CLK_IMEM_P	0x20ac
+#define GAT_IMEM_OTP_CON_TOP_IPCLKPORT_PCLK		0x20b0
+#define GAT_IMEM_RSTNSYNC_ACLK_IPCLKPORT_CLK		0x20b4
+#define GAT_IMEM_RSTNSYNC_INTMEMCLK_IPCLKPORT_CLK	0x20b8
+#define GAT_IMEM_RSTNSYNC_TCUCLK_IPCLKPORT_CLK		0x20bc
+#define GAT_IMEM_SFRIF_TMU0_IMEM_IPCLKPORT_PCLK		0x20c0
+#define GAT_IMEM_SFRIF_TMU1_IMEM_IPCLKPORT_PCLK		0x20c4
+#define GAT_IMEM_SYSREG_IMEM_IPCLKPORT_PCLK		0x20c8
+#define GAT_IMEM_TBU_IMEM_IPCLKPORT_ACLK		0x20cc
+#define GAT_IMEM_TCU_IPCLKPORT_ACLK			0x20d0
+#define GAT_IMEM_WDT0_IPCLKPORT_PCLK			0x20d4
+#define GAT_IMEM_WDT1_IPCLKPORT_PCLK			0x20d8
+#define GAT_IMEM_WDT2_IPCLKPORT_PCLK			0x20dc
+
+static const unsigned long imem_clk_regs[] __initconst = {
+	PLL_CON0_CLK_IMEM_ACLK,
+	PLL_CON0_CLK_IMEM_INTMEMCLK,
+	PLL_CON0_CLK_IMEM_TCUCLK,
+	DIV_OSCCLK_IMEM_TMUTSCLK,
+	GAT_IMEM_IMEM_CMU_IMEM_IPCLKPORT_PCLK,
+	GAT_IMEM_MCT_IPCLKPORT_OSCCLK__ALO,
+	GAT_IMEM_OTP_CON_TOP_IPCLKPORT_I_OSCCLK,
+	GAT_IMEM_RSTNSYNC_OSCCLK_IPCLKPORT_CLK,
+	GAT_IMEM_TMU_CPU0_IPCLKPORT_I_CLK,
+	GAT_IMEM_TMU_CPU0_IPCLKPORT_I_CLK_TS,
+	GAT_IMEM_TMU_CPU2_IPCLKPORT_I_CLK,
+	GAT_IMEM_TMU_CPU2_IPCLKPORT_I_CLK_TS,
+	GAT_IMEM_TMU_GPU_IPCLKPORT_I_CLK,
+	GAT_IMEM_TMU_GPU_IPCLKPORT_I_CLK_TS,
+	GAT_IMEM_TMU_GT_IPCLKPORT_I_CLK,
+	GAT_IMEM_TMU_GT_IPCLKPORT_I_CLK_TS,
+	GAT_IMEM_TMU_TOP_IPCLKPORT_I_CLK,
+	GAT_IMEM_TMU_TOP_IPCLKPORT_I_CLK_TS,
+	GAT_IMEM_WDT0_IPCLKPORT_CLK,
+	GAT_IMEM_WDT1_IPCLKPORT_CLK,
+	GAT_IMEM_WDT2_IPCLKPORT_CLK,
+	GAT_IMEM_ADM_AXI4ST_I0_IMEM_IPCLKPORT_ACLKM,
+	GAT_IMEM_ADM_AXI4ST_I1_IMEM_IPCLKPORT_ACLKM,
+	GAT_IMEM_ADM_AXI4ST_I2_IMEM_IPCLKPORT_ACLKM,
+	GAT_IMEM_ADS_AXI4ST_I0_IMEM_IPCLKPORT_ACLKS,
+	GAT_IMEM_ADS_AXI4ST_I1_IMEM_IPCLKPORT_ACLKS,
+	GAT_IMEM_ADS_AXI4ST_I2_IMEM_IPCLKPORT_ACLKS,
+	GAT_IMEM_ASYNC_DMA0_IPCLKPORT_PCLKM,
+	GAT_IMEM_ASYNC_DMA0_IPCLKPORT_PCLKS,
+	GAT_IMEM_ASYNC_DMA1_IPCLKPORT_PCLKM,
+	GAT_IMEM_ASYNC_DMA1_IPCLKPORT_PCLKS,
+	GAT_IMEM_AXI2APB_IMEMP0_IPCLKPORT_ACLK,
+	GAT_IMEM_AXI2APB_IMEMP1_IPCLKPORT_ACLK,
+	GAT_IMEM_BUS_D_IMEM_IPCLKPORT_MAINCLK,
+	GAT_IMEM_BUS_P_IMEM_IPCLKPORT_MAINCLK,
+	GAT_IMEM_BUS_P_IMEM_IPCLKPORT_PERICLK,
+	GAT_IMEM_BUS_P_IMEM_IPCLKPORT_TCUCLK,
+	GAT_IMEM_DMA0_IPCLKPORT_ACLK,
+	GAT_IMEM_DMA1_IPCLKPORT_ACLK,
+	GAT_IMEM_GIC500_INPUT_SYNC_IPCLKPORT_CLK,
+	GAT_IMEM_GIC_IPCLKPORT_CLK,
+	GAT_IMEM_INTMEM_IPCLKPORT_ACLK,
+	GAT_IMEM_MAILBOX_SCS_CA72_IPCLKPORT_PCLK,
+	GAT_IMEM_MAILBOX_SMS_CA72_IPCLKPORT_PCLK,
+	GAT_IMEM_MCT_IPCLKPORT_PCLK,
+	GAT_IMEM_NS_BRDG_IMEM_IPCLKPORT_CLK__PSCO_IMEM__CLK_IMEM_D,
+	GAT_IMEM_NS_BRDG_IMEM_IPCLKPORT_CLK__PSCO_IMEM__CLK_IMEM_TCU,
+	GAT_IMEM_NS_BRDG_IMEM_IPCLKPORT_CLK__PSOC_IMEM__CLK_IMEM_P,
+	GAT_IMEM_OTP_CON_TOP_IPCLKPORT_PCLK,
+	GAT_IMEM_RSTNSYNC_ACLK_IPCLKPORT_CLK,
+	GAT_IMEM_RSTNSYNC_INTMEMCLK_IPCLKPORT_CLK,
+	GAT_IMEM_RSTNSYNC_TCUCLK_IPCLKPORT_CLK,
+	GAT_IMEM_SFRIF_TMU0_IMEM_IPCLKPORT_PCLK,
+	GAT_IMEM_SFRIF_TMU1_IMEM_IPCLKPORT_PCLK,
+	GAT_IMEM_SYSREG_IMEM_IPCLKPORT_PCLK,
+	GAT_IMEM_TBU_IMEM_IPCLKPORT_ACLK,
+	GAT_IMEM_TCU_IPCLKPORT_ACLK,
+	GAT_IMEM_WDT0_IPCLKPORT_PCLK,
+	GAT_IMEM_WDT1_IPCLKPORT_PCLK,
+	GAT_IMEM_WDT2_IPCLKPORT_PCLK,
+};
+
+PNAME(mout_imem_clk_imem_tcuclk_p) = { "fin_pll", "dout_cmu_imem_tcuclk" };
+PNAME(mout_imem_clk_imem_aclk_p) = { "fin_pll", "dout_cmu_imem_aclk" };
+PNAME(mout_imem_clk_imem_intmemclk_p) = { "fin_pll", "dout_cmu_imem_dmaclk" };
+
+static const struct samsung_mux_clock imem_mux_clks[] __initconst = {
+	MUX(0, "mout_imem_clk_imem_tcuclk", mout_imem_clk_imem_tcuclk_p,
+	    PLL_CON0_CLK_IMEM_TCUCLK, 4, 1),
+	MUX(0, "mout_imem_clk_imem_aclk", mout_imem_clk_imem_aclk_p, PLL_CON0_CLK_IMEM_ACLK, 4, 1),
+	MUX(0, "mout_imem_clk_imem_intmemclk", mout_imem_clk_imem_intmemclk_p,
+	    PLL_CON0_CLK_IMEM_INTMEMCLK, 4, 1),
+};
+
+static const struct samsung_div_clock imem_div_clks[] __initconst = {
+	DIV(0, "dout_imem_oscclk_imem_tmutsclk", "fin_pll", DIV_OSCCLK_IMEM_TMUTSCLK, 0, 4),
+};
+
+static const struct samsung_gate_clock imem_gate_clks[] __initconst = {
+	GATE(0, "imem_imem_cmu_imem_ipclkport_pclk", "mout_imem_clk_imem_aclk",
+	     GAT_IMEM_IMEM_CMU_IMEM_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_otp_con_top_ipclkport_i_oscclk", "fin_pll",
+	     GAT_IMEM_OTP_CON_TOP_IPCLKPORT_I_OSCCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_tmu_top_ipclkport_i_clk", "fin_pll",
+	     GAT_IMEM_TMU_TOP_IPCLKPORT_I_CLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_tmu_gt_ipclkport_i_clk", "fin_pll",
+	     GAT_IMEM_TMU_GT_IPCLKPORT_I_CLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_tmu_cpu0_ipclkport_i_clk", "fin_pll",
+	     GAT_IMEM_TMU_CPU0_IPCLKPORT_I_CLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_tmu_gpu_ipclkport_i_clk", "fin_pll",
+	     GAT_IMEM_TMU_GPU_IPCLKPORT_I_CLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_mct_ipclkport_oscclk__alo", "fin_pll",
+	     GAT_IMEM_MCT_IPCLKPORT_OSCCLK__ALO, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_wdt0_ipclkport_clk", "fin_pll",
+	     GAT_IMEM_WDT0_IPCLKPORT_CLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_wdt1_ipclkport_clk", "fin_pll",
+	     GAT_IMEM_WDT1_IPCLKPORT_CLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_wdt2_ipclkport_clk", "fin_pll",
+	     GAT_IMEM_WDT2_IPCLKPORT_CLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(IMEM_TMU_CPU0_IPCLKPORT_I_CLK_TS, "imem_tmu_cpu0_ipclkport_i_clk_ts",
+	     "dout_imem_oscclk_imem_tmutsclk",
+	     GAT_IMEM_TMU_CPU0_IPCLKPORT_I_CLK_TS, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(IMEM_TMU_CPU2_IPCLKPORT_I_CLK_TS, "imem_tmu_cpu2_ipclkport_i_clk_ts",
+	     "dout_imem_oscclk_imem_tmutsclk",
+	     GAT_IMEM_TMU_CPU2_IPCLKPORT_I_CLK_TS, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(IMEM_TMU_GPU_IPCLKPORT_I_CLK_TS, "imem_tmu_gpu_ipclkport_i_clk_ts",
+	     "dout_imem_oscclk_imem_tmutsclk",
+	     GAT_IMEM_TMU_GPU_IPCLKPORT_I_CLK_TS, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(IMEM_TMU_GT_IPCLKPORT_I_CLK_TS, "imem_tmu_gt_ipclkport_i_clk_ts",
+	     "dout_imem_oscclk_imem_tmutsclk",
+	     GAT_IMEM_TMU_GT_IPCLKPORT_I_CLK_TS, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(IMEM_TMU_TOP_IPCLKPORT_I_CLK_TS, "imem_tmu_top_ipclkport_i_clk_ts",
+	     "dout_imem_oscclk_imem_tmutsclk",
+	     GAT_IMEM_TMU_TOP_IPCLKPORT_I_CLK_TS, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_adm_axi4st_i0_imem_ipclkport_aclkm", "mout_imem_clk_imem_aclk",
+	     GAT_IMEM_ADM_AXI4ST_I0_IMEM_IPCLKPORT_ACLKM, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_adm_axi4st_i1_imem_ipclkport_aclkm", "mout_imem_clk_imem_aclk",
+	     GAT_IMEM_ADM_AXI4ST_I1_IMEM_IPCLKPORT_ACLKM, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_adm_axi4st_i2_imem_ipclkport_aclkm", "mout_imem_clk_imem_aclk",
+	     GAT_IMEM_ADM_AXI4ST_I2_IMEM_IPCLKPORT_ACLKM, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_ads_axi4st_i0_imem_ipclkport_aclks", "mout_imem_clk_imem_aclk",
+	     GAT_IMEM_ADS_AXI4ST_I0_IMEM_IPCLKPORT_ACLKS, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_ads_axi4st_i1_imem_ipclkport_aclks", "mout_imem_clk_imem_aclk",
+	     GAT_IMEM_ADS_AXI4ST_I1_IMEM_IPCLKPORT_ACLKS, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_ads_axi4st_i2_imem_ipclkport_aclks", "mout_imem_clk_imem_aclk",
+	     GAT_IMEM_ADS_AXI4ST_I2_IMEM_IPCLKPORT_ACLKS, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_async_dma0_ipclkport_pclkm", "mout_imem_clk_imem_tcuclk",
+	     GAT_IMEM_ASYNC_DMA0_IPCLKPORT_PCLKM, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_async_dma0_ipclkport_pclks", "mout_imem_clk_imem_aclk",
+	     GAT_IMEM_ASYNC_DMA0_IPCLKPORT_PCLKS, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_async_dma1_ipclkport_pclkm", "mout_imem_clk_imem_tcuclk",
+	     GAT_IMEM_ASYNC_DMA1_IPCLKPORT_PCLKM, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_async_dma1_ipclkport_pclks", "mout_imem_clk_imem_aclk",
+	     GAT_IMEM_ASYNC_DMA1_IPCLKPORT_PCLKS, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_axi2apb_imemp0_ipclkport_aclk", "mout_imem_clk_imem_aclk",
+	     GAT_IMEM_AXI2APB_IMEMP0_IPCLKPORT_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_axi2apb_imemp1_ipclkport_aclk", "mout_imem_clk_imem_aclk",
+	     GAT_IMEM_AXI2APB_IMEMP1_IPCLKPORT_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_bus_d_imem_ipclkport_mainclk", "mout_imem_clk_imem_tcuclk",
+	     GAT_IMEM_BUS_D_IMEM_IPCLKPORT_MAINCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_bus_p_imem_ipclkport_mainclk", "mout_imem_clk_imem_aclk",
+	     GAT_IMEM_BUS_P_IMEM_IPCLKPORT_MAINCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_bus_p_imem_ipclkport_pericclk", "mout_imem_clk_imem_aclk",
+	     GAT_IMEM_BUS_P_IMEM_IPCLKPORT_PERICLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_bus_p_imem_ipclkport_tcuclk", "mout_imem_clk_imem_tcuclk",
+	     GAT_IMEM_BUS_P_IMEM_IPCLKPORT_TCUCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(IMEM_DMA0_IPCLKPORT_ACLK, "imem_dma0_ipclkport_aclk", "mout_imem_clk_imem_tcuclk",
+	     GAT_IMEM_DMA0_IPCLKPORT_ACLK, 21, CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, 0),
+	GATE(IMEM_DMA1_IPCLKPORT_ACLK, "imem_dma1_ipclkport_aclk", "mout_imem_clk_imem_tcuclk",
+	     GAT_IMEM_DMA1_IPCLKPORT_ACLK, 21, CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, 0),
+	GATE(0, "imem_gic500_input_sync_ipclkport_clk", "mout_imem_clk_imem_aclk",
+	     GAT_IMEM_GIC500_INPUT_SYNC_IPCLKPORT_CLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_gic_ipclkport_clk", "mout_imem_clk_imem_aclk",
+	     GAT_IMEM_GIC_IPCLKPORT_CLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_intmem_ipclkport_aclk", "mout_imem_clk_imem_intmemclk",
+	     GAT_IMEM_INTMEM_IPCLKPORT_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_mailbox_scs_ca72_ipclkport_pclk", "mout_imem_clk_imem_aclk",
+	     GAT_IMEM_MAILBOX_SCS_CA72_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_mailbox_sms_ca72_ipclkport_pclk", "mout_imem_clk_imem_aclk",
+	     GAT_IMEM_MAILBOX_SMS_CA72_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(IMEM_MCT_PCLK, "imem_mct_ipclkport_pclk", "mout_imem_clk_imem_aclk",
+	     GAT_IMEM_MCT_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_ns_brdg_imem_ipclkport_clk__psco_imem__clk_imem_d",
+	     "mout_imem_clk_imem_tcuclk",
+	     GAT_IMEM_NS_BRDG_IMEM_IPCLKPORT_CLK__PSCO_IMEM__CLK_IMEM_D, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_ns_brdg_imem_ipclkport_clk__psco_imem__clk_imem_tcu",
+	     "mout_imem_clk_imem_tcuclk",
+	     GAT_IMEM_NS_BRDG_IMEM_IPCLKPORT_CLK__PSCO_IMEM__CLK_IMEM_TCU, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_ns_brdg_imem_ipclkport_clk__psoc_imem__clk_imem_p", "mout_imem_clk_imem_aclk",
+	     GAT_IMEM_NS_BRDG_IMEM_IPCLKPORT_CLK__PSOC_IMEM__CLK_IMEM_P, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_otp_con_top_ipclkport_pclk", "mout_imem_clk_imem_aclk",
+	     GAT_IMEM_OTP_CON_TOP_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_rstnsync_aclk_ipclkport_clk", "mout_imem_clk_imem_aclk",
+	     GAT_IMEM_RSTNSYNC_ACLK_IPCLKPORT_CLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_rstnsync_oscclk_ipclkport_clk", "fin_pll",
+	     GAT_IMEM_RSTNSYNC_OSCCLK_IPCLKPORT_CLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_rstnsync_intmemclk_ipclkport_clk", "mout_imem_clk_imem_intmemclk",
+	     GAT_IMEM_RSTNSYNC_INTMEMCLK_IPCLKPORT_CLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_rstnsync_tcuclk_ipclkport_clk", "mout_imem_clk_imem_tcuclk",
+	     GAT_IMEM_RSTNSYNC_TCUCLK_IPCLKPORT_CLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_sfrif_tmu0_imem_ipclkport_pclk", "mout_imem_clk_imem_aclk",
+	     GAT_IMEM_SFRIF_TMU0_IMEM_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_sfrif_tmu1_imem_ipclkport_pclk", "mout_imem_clk_imem_aclk",
+	     GAT_IMEM_SFRIF_TMU1_IMEM_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_tmu_cpu2_ipclkport_i_clk", "fin_pll",
+	     GAT_IMEM_TMU_CPU2_IPCLKPORT_I_CLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_sysreg_imem_ipclkport_pclk", "mout_imem_clk_imem_aclk",
+	     GAT_IMEM_SYSREG_IMEM_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_tbu_imem_ipclkport_aclk", "mout_imem_clk_imem_tcuclk",
+	     GAT_IMEM_TBU_IMEM_IPCLKPORT_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "imem_tcu_ipclkport_aclk", "mout_imem_clk_imem_tcuclk",
+	     GAT_IMEM_TCU_IPCLKPORT_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(IMEM_WDT0_IPCLKPORT_PCLK, "imem_wdt0_ipclkport_pclk", "mout_imem_clk_imem_aclk",
+	     GAT_IMEM_WDT0_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(IMEM_WDT1_IPCLKPORT_PCLK, "imem_wdt1_ipclkport_pclk", "mout_imem_clk_imem_aclk",
+	     GAT_IMEM_WDT1_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(IMEM_WDT2_IPCLKPORT_PCLK, "imem_wdt2_ipclkport_pclk", "mout_imem_clk_imem_aclk",
+	     GAT_IMEM_WDT2_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+};
+
+static const struct samsung_cmu_info imem_cmu_info __initconst = {
+	.mux_clks		= imem_mux_clks,
+	.nr_mux_clks		= ARRAY_SIZE(imem_mux_clks),
+	.div_clks		= imem_div_clks,
+	.nr_div_clks		= ARRAY_SIZE(imem_div_clks),
+	.gate_clks		= imem_gate_clks,
+	.nr_gate_clks		= ARRAY_SIZE(imem_gate_clks),
+	.nr_clk_ids		= IMEM_NR_CLK,
+	.clk_regs		= imem_clk_regs,
+	.nr_clk_regs		= ARRAY_SIZE(imem_clk_regs),
+};
+
+static void __init fsd_clk_imem_init(struct device_node *np)
+{
+	samsung_cmu_register_one(np, &imem_cmu_info);
+}
+
+CLK_OF_DECLARE(fsd_clk_imem, "tesla,fsd-clock-imem", fsd_clk_imem_init);
+
 /**
  * fsd_cmu_probe - Probe function for FSD platform clocks
  * @pdev: Pointer to platform device
-- 
2.25.1

