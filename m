Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E356E48D79D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbiAMMYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:24:17 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:33773 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbiAMMYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:24:01 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220113122358epoutp01c35394142de39e1dd4b7cbf4481effc3~J1AC5sOW11825518255epoutp01H
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:23:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220113122358epoutp01c35394142de39e1dd4b7cbf4481effc3~J1AC5sOW11825518255epoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642076638;
        bh=fzP7GwWtEDI5jGG6wFs5XyaMPs829NivdSgqTid+edE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gKkKUl5ieOWoQXe1sPn3Htwx3biOZt9Z/T4h1uVAUKdonfpIjGjfp4U4iAefausFk
         bnAyAREJH2ZV+tyUBV/Icj2F+iKR/ay02STPjpoE+d9gn+J5ezuqq7wWnTIv0iPhDH
         a3ru35YVTNzL4l1nwbEEA0kuOLUMzIjsm5jjxf4E=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220113122357epcas5p464ee61c2b96337c6a42975ff54679be5~J1AB_C_O43143231432epcas5p4o;
        Thu, 13 Jan 2022 12:23:57 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JZNrm4Drsz4x9Pv; Thu, 13 Jan
        2022 12:23:52 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        87.B6.06423.7D910E16; Thu, 13 Jan 2022 21:23:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220113122351epcas5p45f49a559af9f6d0c6ba573594f95561d~J0-75ZCWF3143231432epcas5p4a;
        Thu, 13 Jan 2022 12:23:51 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220113122351epsmtrp10f689a5eef907ae19acf0d8add9ae610~J0-758t6e1911119111epsmtrp1E;
        Thu, 13 Jan 2022 12:23:51 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-b1-61e019d71973
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5F.99.08738.6D910E16; Thu, 13 Jan 2022 21:23:50 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220113122348epsmtip2ac650a69adb0a9658f1cec68c74ef1c8~J0-5XOlk_1131511315epsmtip2F;
        Thu, 13 Jan 2022 12:23:48 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com, Sathyakam M <sathya@samsung.com>
Subject: [PATCH 09/23] clk: samsung: fsd: Add cam_csi block clock
 information
Date:   Thu, 13 Jan 2022 17:41:29 +0530
Message-Id: <20220113121143.22280-10-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220113121143.22280-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdlhTU/eG5INEgz55iwfztrFZvF/Ww2gx
        /8g5VouNb38wWUz5s5zJYtPja6wWH3vusVo8fBVucXnXHDaLGef3MVmcuv6ZzWLR1i/sFq17
        j7BbHH7Tzmrx5chrRovH1/+wOQh4rJm3htFjVkMvm8emVZ1sHneu7WHz2Lyk3uPKiSZWj74t
        qxg9/jXNZff4vEkugDMq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfV
        VsnFJ0DXLTMH6AklhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66
        Xl5qiZWhgYGRKVBhQnZG2+N77AWN8RWLnn1nbmDcEtLFyMkhIWAicW5fJ3sXIxeHkMBuRomP
        T+6xQTifGCXuTnnJCOF8ZpSY+6OfCablbVsvG4gtJLCLUWLaVT+IohYmiY6NR5lBEmwC2hJ3
        p28BaxARcJO40djBBFLELNDALNEy9x9YkbCAv8T6hVeAbA4OFgFViZfPK0HCvAK2EseXXGWF
        WCYvsXrDAbASTqD43VV5IGMkBJZySDQ3H2OHqHGReNf1gw3CFpZ4dXwLVFxK4mV/GztIr4RA
        tkTPLmOIcI3E0nnHWCBse4kDV+awgJQwC2hKrN+lDxJmFuCT6P39hAmik1eio00IolpVovnd
        VahOaYmJ3d1QR3pIrNz3lxUSChMYJb7fes4+gVF2FsLUBYyMqxglUwuKc9NTi00LDPNSy+HR
        lJyfu4kRnDK1PHcw3n3wQe8QIxMH4yFGCQ5mJRHe/qL7iUK8KYmVValF+fFFpTmpxYcYTYEB
        NpFZSjQ5H5i080riDU0sDUzMzMxMLI3NDJXEeU+nb0gUEkhPLEnNTk0tSC2C6WPi4JRqYJpg
        GN68bIbq0fc+C0q+hz29VBd1a0V4/Tk9rsqVLAd9VDeGtb4PMun8uVT1a5h4zzfRroq0KluR
        xz073Rmrd504/X1loodq+ITbN6/Vnk598PVgxOU5C1PCLezY0n7vnM99Q6JuYcYBkSN+YtHz
        XrcfWyQr9m1x+oN12cXeH0Izti2UnxDf90ZN+ctMzvqd57drfXmsqXfNvKfogN88zlwrd56m
        rCx50V2fs5L0bbg/Jmx+8+fX/7NFIW9s3lx/x3jk6TGlbKXg76rKkY0cor6vVzd1/UhzLEr5
        fq7fYlXznm8zf+WcZ+bXltXt4pnOfNtcvGH3llUxmsZGqjcnn2iMl7Cw/3D2aSNrIadhhxJL
        cUaioRZzUXEiAI6aHIsiBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsWy7bCSvO41yQeJBh87tS0ezNvGZvF+WQ+j
        xfwj51gtNr79wWQx5c9yJotNj6+xWnzsucdq8fBVuMXlXXPYLGac38dkcer6ZzaLRVu/sFu0
        7j3CbnH4TTurxZcjrxktHl//w+Yg4LFm3hpGj1kNvWwem1Z1snncubaHzWPzknqPKyeaWD36
        tqxi9PjXNJfd4/MmuQDOKC6blNSczLLUIn27BK6Mtsf32Asa4ysWPfvO3MC4JaSLkZNDQsBE
        4m1bL1sXIxeHkMAORomv34+yQySkJa5vnABlC0us/PecHaKoiUni1qlrzCAJNgFtibvTtzCB
        2CICHhJt/+4xgxQxC0xglvi/YQILSEJYwFfi9u3DQN0cHCwCqhIvn1eChHkFbCWOL7nKCrFA
        XmL1hgPMICWcQPG7q/JAwkICNhLnXq1nm8DIt4CRYRWjZGpBcW56brFhgVFearlecWJucWle
        ul5yfu4mRnDIa2ntYNyz6oPeIUYmDsZDjBIczEoivP1F9xOFeFMSK6tSi/Lji0pzUosPMUpz
        sCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYOqMClwg/85/U9L9H5eKIpqlXBRcPS+8bPzz
        +XoR+wm9XTWh7O1PGFn3ZO38PeHe3riZqTNVOGuXTmNbnj5/a+7WJ5Lqf59qpGxpsGcPYw39
        cJdH+ZJkO+dM8erPn2bpp9tsvdjNVMiwurftnM0fL86In28XBkivtJ62P8/iZVw/U2foogen
        +1b8n3ws2FzigsAN7nurr79lTDbfwNDDG8lR7zV767aNXDXnG76835LfaxQ/+cFheY35E6bp
        Cr1bXuF62TfVdmbludD1bmJFNgGRLywNuwRMXnffLj2dLWSxvpMv2cbdL0J2gi3f03LlpT3m
        6+InnJqm9P6i74KJXfmvT32R4/+zr8bk8Mx/k5VYijMSDbWYi4oTAV+RbaDoAgAA
X-CMS-MailID: 20220113122351epcas5p45f49a559af9f6d0c6ba573594f95561d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122351epcas5p45f49a559af9f6d0c6ba573594f95561d
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
        <CGME20220113122351epcas5p45f49a559af9f6d0c6ba573594f95561d@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds clocks for BLK_CAM_CSI block, this is needed for CSI to work.

Cc: linux-fsd@tesla.com
Signed-off-by: Sathyakam M <sathya@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/clk/samsung/clk-fsd.c | 207 ++++++++++++++++++++++++++++++++++
 1 file changed, 207 insertions(+)

diff --git a/drivers/clk/samsung/clk-fsd.c b/drivers/clk/samsung/clk-fsd.c
index 927b310ce4a4..1bed8c7eb605 100644
--- a/drivers/clk/samsung/clk-fsd.c
+++ b/drivers/clk/samsung/clk-fsd.c
@@ -1585,6 +1585,210 @@ static const struct samsung_cmu_info mfc_cmu_info __initconst = {
 	.nr_clk_regs		= ARRAY_SIZE(mfc_clk_regs),
 };
 
+/* Register Offset definitions for CMU_CAM_CSI (0x12610000) */
+#define PLL_LOCKTIME_PLL_CAM_CSI		0x0
+#define PLL_CON0_PLL_CAM_CSI			0x100
+#define DIV_CAM_CSI0_ACLK			0x1800
+#define DIV_CAM_CSI1_ACLK			0x1804
+#define DIV_CAM_CSI2_ACLK			0x1808
+#define DIV_CAM_CSI_BUSD			0x180c
+#define DIV_CAM_CSI_BUSP			0x1810
+#define GAT_CAM_CSI_CMU_CAM_CSI_IPCLKPORT_PCLK	0x2000
+#define GAT_CAM_AXI2APB_CAM_CSI_IPCLKPORT_ACLK	0x2004
+#define GAT_CAM_CSI_BUS_D_CAM_CSI_IPCLKPORT_CLK__SYSTEM__CLK_CSI0	0x2008
+#define GAT_CAM_CSI_BUS_D_CAM_CSI_IPCLKPORT_CLK__SYSTEM__CLK_CSI1	0x200c
+#define GAT_CAM_CSI_BUS_D_CAM_CSI_IPCLKPORT_CLK__SYSTEM__CLK_CSI2	0x2010
+#define GAT_CAM_CSI_BUS_D_CAM_CSI_IPCLKPORT_CLK__SYSTEM__CLK_SOC_NOC	0x2014
+#define GAT_CAM_CSI_BUS_D_CAM_CSI_IPCLKPORT_CLK__SYSTEM__NOC		0x2018
+#define GAT_CAM_CSI0_0_IPCLKPORT_I_ACLK		0x201c
+#define GAT_CAM_CSI0_0_IPCLKPORT_I_PCLK		0x2020
+#define GAT_CAM_CSI0_1_IPCLKPORT_I_ACLK		0x2024
+#define GAT_CAM_CSI0_1_IPCLKPORT_I_PCLK		0x2028
+#define GAT_CAM_CSI0_2_IPCLKPORT_I_ACLK		0x202c
+#define GAT_CAM_CSI0_2_IPCLKPORT_I_PCLK		0x2030
+#define GAT_CAM_CSI0_3_IPCLKPORT_I_ACLK		0x2034
+#define GAT_CAM_CSI0_3_IPCLKPORT_I_PCLK		0x2038
+#define GAT_CAM_CSI1_0_IPCLKPORT_I_ACLK		0x203c
+#define GAT_CAM_CSI1_0_IPCLKPORT_I_PCLK		0x2040
+#define GAT_CAM_CSI1_1_IPCLKPORT_I_ACLK		0x2044
+#define GAT_CAM_CSI1_1_IPCLKPORT_I_PCLK		0x2048
+#define GAT_CAM_CSI1_2_IPCLKPORT_I_ACLK		0x204c
+#define GAT_CAM_CSI1_2_IPCLKPORT_I_PCLK		0x2050
+#define GAT_CAM_CSI1_3_IPCLKPORT_I_ACLK		0x2054
+#define GAT_CAM_CSI1_3_IPCLKPORT_I_PCLK		0x2058
+#define GAT_CAM_CSI2_0_IPCLKPORT_I_ACLK		0x205c
+#define GAT_CAM_CSI2_0_IPCLKPORT_I_PCLK		0x2060
+#define GAT_CAM_CSI2_1_IPCLKPORT_I_ACLK		0x2064
+#define GAT_CAM_CSI2_1_IPCLKPORT_I_PCLK		0x2068
+#define GAT_CAM_CSI2_2_IPCLKPORT_I_ACLK		0x206c
+#define GAT_CAM_CSI2_2_IPCLKPORT_I_PCLK		0x2070
+#define GAT_CAM_CSI2_3_IPCLKPORT_I_ACLK		0x2074
+#define GAT_CAM_CSI2_3_IPCLKPORT_I_PCLK		0x2078
+#define GAT_CAM_NS_BRDG_CAM_CSI_IPCLKPORT_CLK__PSOC_CAM_CSI__CLK_CAM_CSI_D	0x207c
+#define GAT_CAM_NS_BRDG_CAM_CSI_IPCLKPORT_CLK__PSOC_CAM_CSI__CLK_CAM_CSI_P	0x2080
+#define GAT_CAM_SYSREG_CAM_CSI_IPCLKPORT_PCLK	0x2084
+#define GAT_CAM_TBU_CAM_CSI_IPCLKPORT_ACLK	0x2088
+
+static const unsigned long cam_csi_clk_regs[] __initconst = {
+	PLL_LOCKTIME_PLL_CAM_CSI,
+	PLL_CON0_PLL_CAM_CSI,
+	DIV_CAM_CSI0_ACLK,
+	DIV_CAM_CSI1_ACLK,
+	DIV_CAM_CSI2_ACLK,
+	DIV_CAM_CSI_BUSD,
+	DIV_CAM_CSI_BUSP,
+	GAT_CAM_CSI_CMU_CAM_CSI_IPCLKPORT_PCLK,
+	GAT_CAM_AXI2APB_CAM_CSI_IPCLKPORT_ACLK,
+	GAT_CAM_CSI_BUS_D_CAM_CSI_IPCLKPORT_CLK__SYSTEM__CLK_CSI0,
+	GAT_CAM_CSI_BUS_D_CAM_CSI_IPCLKPORT_CLK__SYSTEM__CLK_CSI1,
+	GAT_CAM_CSI_BUS_D_CAM_CSI_IPCLKPORT_CLK__SYSTEM__CLK_CSI2,
+	GAT_CAM_CSI_BUS_D_CAM_CSI_IPCLKPORT_CLK__SYSTEM__CLK_SOC_NOC,
+	GAT_CAM_CSI_BUS_D_CAM_CSI_IPCLKPORT_CLK__SYSTEM__NOC,
+	GAT_CAM_CSI0_0_IPCLKPORT_I_ACLK,
+	GAT_CAM_CSI0_0_IPCLKPORT_I_PCLK,
+	GAT_CAM_CSI0_1_IPCLKPORT_I_ACLK,
+	GAT_CAM_CSI0_1_IPCLKPORT_I_PCLK,
+	GAT_CAM_CSI0_2_IPCLKPORT_I_ACLK,
+	GAT_CAM_CSI0_2_IPCLKPORT_I_PCLK,
+	GAT_CAM_CSI0_3_IPCLKPORT_I_ACLK,
+	GAT_CAM_CSI0_3_IPCLKPORT_I_PCLK,
+	GAT_CAM_CSI1_0_IPCLKPORT_I_ACLK,
+	GAT_CAM_CSI1_0_IPCLKPORT_I_PCLK,
+	GAT_CAM_CSI1_1_IPCLKPORT_I_ACLK,
+	GAT_CAM_CSI1_1_IPCLKPORT_I_PCLK,
+	GAT_CAM_CSI1_2_IPCLKPORT_I_ACLK,
+	GAT_CAM_CSI1_2_IPCLKPORT_I_PCLK,
+	GAT_CAM_CSI1_3_IPCLKPORT_I_ACLK,
+	GAT_CAM_CSI1_3_IPCLKPORT_I_PCLK,
+	GAT_CAM_CSI2_0_IPCLKPORT_I_ACLK,
+	GAT_CAM_CSI2_0_IPCLKPORT_I_PCLK,
+	GAT_CAM_CSI2_1_IPCLKPORT_I_ACLK,
+	GAT_CAM_CSI2_1_IPCLKPORT_I_PCLK,
+	GAT_CAM_CSI2_2_IPCLKPORT_I_ACLK,
+	GAT_CAM_CSI2_2_IPCLKPORT_I_PCLK,
+	GAT_CAM_CSI2_3_IPCLKPORT_I_ACLK,
+	GAT_CAM_CSI2_3_IPCLKPORT_I_PCLK,
+	GAT_CAM_NS_BRDG_CAM_CSI_IPCLKPORT_CLK__PSOC_CAM_CSI__CLK_CAM_CSI_D,
+	GAT_CAM_NS_BRDG_CAM_CSI_IPCLKPORT_CLK__PSOC_CAM_CSI__CLK_CAM_CSI_P,
+	GAT_CAM_SYSREG_CAM_CSI_IPCLKPORT_PCLK,
+	GAT_CAM_TBU_CAM_CSI_IPCLKPORT_ACLK,
+};
+
+static const struct samsung_pll_rate_table pll_cam_csi_rate_table[] __initconst = {
+	PLL_35XX_RATE(24 * MHZ, 1066000000, 533, 12, 0),
+};
+
+static const struct samsung_pll_clock cam_csi_pll_clks[] __initconst = {
+	PLL(pll_142xx, 0, "fout_pll_cam_csi", "fin_pll",
+	    PLL_LOCKTIME_PLL_CAM_CSI, PLL_CON0_PLL_CAM_CSI, pll_cam_csi_rate_table),
+};
+
+PNAME(mout_cam_csi_pll_p) = { "fin_pll", "fout_pll_cam_csi" };
+
+static const struct samsung_mux_clock cam_csi_mux_clks[] __initconst = {
+	MUX(0, "mout_cam_csi_pll", mout_cam_csi_pll_p, PLL_CON0_PLL_CAM_CSI, 4, 1),
+};
+
+static const struct samsung_div_clock cam_csi_div_clks[] __initconst = {
+	DIV(0, "dout_cam_csi0_aclk", "mout_cam_csi_pll", DIV_CAM_CSI0_ACLK, 0, 4),
+	DIV(0, "dout_cam_csi1_aclk", "mout_cam_csi_pll", DIV_CAM_CSI1_ACLK, 0, 4),
+	DIV(0, "dout_cam_csi2_aclk", "mout_cam_csi_pll", DIV_CAM_CSI2_ACLK, 0, 4),
+	DIV(0, "dout_cam_csi_busd", "mout_cam_csi_pll", DIV_CAM_CSI_BUSD, 0, 4),
+	DIV(0, "dout_cam_csi_busp", "mout_cam_csi_pll", DIV_CAM_CSI_BUSP, 0, 4),
+};
+
+static const struct samsung_gate_clock cam_csi_gate_clks[] __initconst = {
+	GATE(0, "cam_csi_cmu_cam_csi_ipclkport_pclk", "dout_cam_csi_busp",
+	     GAT_CAM_CSI_CMU_CAM_CSI_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_axi2apb_cam_csi_ipclkport_aclk", "dout_cam_csi_busp",
+	     GAT_CAM_AXI2APB_CAM_CSI_IPCLKPORT_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_csi_bus_d_cam_csi_ipclkport_clk__system__clk_csi0", "dout_cam_csi0_aclk",
+	     GAT_CAM_CSI_BUS_D_CAM_CSI_IPCLKPORT_CLK__SYSTEM__CLK_CSI0, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_csi_bus_d_cam_csi_ipclkport_clk__system__clk_csi1", "dout_cam_csi1_aclk",
+	     GAT_CAM_CSI_BUS_D_CAM_CSI_IPCLKPORT_CLK__SYSTEM__CLK_CSI1, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_csi_bus_d_cam_csi_ipclkport_clk__system__clk_csi2", "dout_cam_csi2_aclk",
+	     GAT_CAM_CSI_BUS_D_CAM_CSI_IPCLKPORT_CLK__SYSTEM__CLK_CSI2, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_csi_bus_d_cam_csi_ipclkport_clk__system__clk_soc_noc", "dout_cam_csi_busd",
+	     GAT_CAM_CSI_BUS_D_CAM_CSI_IPCLKPORT_CLK__SYSTEM__CLK_SOC_NOC, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_csi_bus_d_cam_csi_ipclkport_clk__system__noc", "dout_cam_csi_busd",
+	     GAT_CAM_CSI_BUS_D_CAM_CSI_IPCLKPORT_CLK__SYSTEM__NOC, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(CAM_CSI0_0_IPCLKPORT_I_ACLK, "cam_csi0_0_ipclkport_i_aclk", "dout_cam_csi0_aclk",
+	     GAT_CAM_CSI0_0_IPCLKPORT_I_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_csi0_0_ipclkport_i_pclk", "dout_cam_csi_busp",
+	     GAT_CAM_CSI0_0_IPCLKPORT_I_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(CAM_CSI0_1_IPCLKPORT_I_ACLK, "cam_csi0_1_ipclkport_i_aclk", "dout_cam_csi0_aclk",
+	     GAT_CAM_CSI0_1_IPCLKPORT_I_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_csi0_1_ipclkport_i_pclk", "dout_cam_csi_busp",
+	     GAT_CAM_CSI0_1_IPCLKPORT_I_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(CAM_CSI0_2_IPCLKPORT_I_ACLK, "cam_csi0_2_ipclkport_i_aclk", "dout_cam_csi0_aclk",
+	     GAT_CAM_CSI0_2_IPCLKPORT_I_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_csi0_2_ipclkport_i_pclk", "dout_cam_csi_busp",
+	     GAT_CAM_CSI0_2_IPCLKPORT_I_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(CAM_CSI0_3_IPCLKPORT_I_ACLK, "cam_csi0_3_ipclkport_i_aclk", "dout_cam_csi0_aclk",
+	     GAT_CAM_CSI0_3_IPCLKPORT_I_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_csi0_3_ipclkport_i_pclk", "dout_cam_csi_busp",
+	     GAT_CAM_CSI0_3_IPCLKPORT_I_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(CAM_CSI1_0_IPCLKPORT_I_ACLK, "cam_csi1_0_ipclkport_i_aclk", "dout_cam_csi1_aclk",
+	     GAT_CAM_CSI1_0_IPCLKPORT_I_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_csi1_0_ipclkport_i_pclk", "dout_cam_csi_busp",
+	     GAT_CAM_CSI1_0_IPCLKPORT_I_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(CAM_CSI1_1_IPCLKPORT_I_ACLK, "cam_csi1_1_ipclkport_i_aclk", "dout_cam_csi1_aclk",
+	     GAT_CAM_CSI1_1_IPCLKPORT_I_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_csi1_1_ipclkport_i_pclk", "dout_cam_csi_busp",
+	     GAT_CAM_CSI1_1_IPCLKPORT_I_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(CAM_CSI1_2_IPCLKPORT_I_ACLK, "cam_csi1_2_ipclkport_i_aclk", "dout_cam_csi1_aclk",
+	     GAT_CAM_CSI1_2_IPCLKPORT_I_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_csi1_2_ipclkport_i_pclk", "dout_cam_csi_busp",
+	     GAT_CAM_CSI1_2_IPCLKPORT_I_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(CAM_CSI1_3_IPCLKPORT_I_ACLK, "cam_csi1_3_ipclkport_i_aclk", "dout_cam_csi1_aclk",
+	     GAT_CAM_CSI1_3_IPCLKPORT_I_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_csi1_3_ipclkport_i_pclk", "dout_cam_csi_busp",
+	     GAT_CAM_CSI1_3_IPCLKPORT_I_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(CAM_CSI2_0_IPCLKPORT_I_ACLK, "cam_csi2_0_ipclkport_i_aclk", "dout_cam_csi2_aclk",
+	     GAT_CAM_CSI2_0_IPCLKPORT_I_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_csi2_0_ipclkport_i_pclk", "dout_cam_csi_busp",
+	     GAT_CAM_CSI2_0_IPCLKPORT_I_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(CAM_CSI2_1_IPCLKPORT_I_ACLK, "cam_csi2_1_ipclkport_i_aclk", "dout_cam_csi2_aclk",
+	     GAT_CAM_CSI2_1_IPCLKPORT_I_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_csi2_1_ipclkport_i_pclk", "dout_cam_csi_busp",
+	     GAT_CAM_CSI2_1_IPCLKPORT_I_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(CAM_CSI2_2_IPCLKPORT_I_ACLK, "cam_csi2_2_ipclkport_i_aclk", "dout_cam_csi2_aclk",
+	     GAT_CAM_CSI2_2_IPCLKPORT_I_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_csi2_2_ipclkport_i_pclk", "dout_cam_csi_busp",
+	     GAT_CAM_CSI2_2_IPCLKPORT_I_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(CAM_CSI2_3_IPCLKPORT_I_ACLK, "cam_csi2_3_ipclkport_i_aclk", "dout_cam_csi2_aclk",
+	     GAT_CAM_CSI2_3_IPCLKPORT_I_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_csi2_3_ipclkport_i_pclk", "dout_cam_csi_busp",
+	     GAT_CAM_CSI2_3_IPCLKPORT_I_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_ns_brdg_cam_csi_ipclkport_clk__psoc_cam_csi__clk_cam_csi_d",
+	     "dout_cam_csi_busd",
+	     GAT_CAM_NS_BRDG_CAM_CSI_IPCLKPORT_CLK__PSOC_CAM_CSI__CLK_CAM_CSI_D, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_ns_brdg_cam_csi_ipclkport_clk__psoc_cam_csi__clk_cam_csi_p",
+	     "dout_cam_csi_busp",
+	     GAT_CAM_NS_BRDG_CAM_CSI_IPCLKPORT_CLK__PSOC_CAM_CSI__CLK_CAM_CSI_P, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_sysreg_cam_csi_ipclkport_pclk", "dout_cam_csi_busp",
+	     GAT_CAM_SYSREG_CAM_CSI_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_tbu_cam_csi_ipclkport_aclk", "dout_cam_csi_busd",
+	     GAT_CAM_TBU_CAM_CSI_IPCLKPORT_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+};
+
+static const struct samsung_cmu_info cam_csi_cmu_info __initconst = {
+	.pll_clks		= cam_csi_pll_clks,
+	.nr_pll_clks		= ARRAY_SIZE(cam_csi_pll_clks),
+	.mux_clks		= cam_csi_mux_clks,
+	.nr_mux_clks		= ARRAY_SIZE(cam_csi_mux_clks),
+	.div_clks		= cam_csi_div_clks,
+	.nr_div_clks		= ARRAY_SIZE(cam_csi_div_clks),
+	.gate_clks		= cam_csi_gate_clks,
+	.nr_gate_clks		= ARRAY_SIZE(cam_csi_gate_clks),
+	.nr_clk_ids		= CAM_CSI_NR_CLK,
+	.clk_regs		= cam_csi_clk_regs,
+	.nr_clk_regs		= ARRAY_SIZE(cam_csi_clk_regs),
+};
+
 /**
  * fsd_cmu_probe - Probe function for FSD platform clocks
  * @pdev: Pointer to platform device
@@ -1631,6 +1835,9 @@ static const struct of_device_id fsd_cmu_of_match[] = {
 	}, {
 		.compatible = "tesla,fsd-clock-mfc",
 		.data = &mfc_cmu_info,
+	}, {
+		.compatible = "tesla,fsd-clock-cam_csi",
+		.data = &cam_csi_cmu_info,
 	}, {
 	},
 };
-- 
2.17.1

