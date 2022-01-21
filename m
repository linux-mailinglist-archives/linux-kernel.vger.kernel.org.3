Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D199496442
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381831AbiAURnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:43:02 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:16396 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351839AbiAURlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:41:24 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220121174109epoutp0287ba3d4bd638993fadd99f779f0e0b85~MWfQ3bUYU0412704127epoutp02T
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 17:41:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220121174109epoutp0287ba3d4bd638993fadd99f779f0e0b85~MWfQ3bUYU0412704127epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642786869;
        bh=NrXch6p0sZBeoTX6DHfrqT5pb0Axdf8o6h4WRV9V9ek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U6ubCghQ4OwWe7Oa0oHC08Rm69N8DLn3liXPQypJasf8L8GiqETVr4p0nRvlfyO8L
         pleCCVoMyAJjie1avj0TTq0vaxq49rZgHd9+n4R8NBHlcpTQK/nloWAwSsSAIYyuQz
         rY6e1qAbiDztThq7gLGnFAoXKkbW8UsfQtw9T6Y4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220121174108epcas5p17d0f7eaccd425c39530b7af896bf5903~MWfQDgWQ-2780827808epcas5p1f;
        Fri, 21 Jan 2022 17:41:08 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JgRW26Qrcz4x9Pp; Fri, 21 Jan
        2022 17:41:02 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A3.30.06423.E20FAE16; Sat, 22 Jan 2022 02:41:02 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220121174102epcas5p32991b37e5be465e189ec5aeed32907bd~MWfJ_l6xx2795427954epcas5p3k;
        Fri, 21 Jan 2022 17:41:02 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220121174102epsmtrp238d2c07489a1ad62f18922576c26db8e~MWfJ8c5rv1824918249epsmtrp2t;
        Fri, 21 Jan 2022 17:41:02 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-d9-61eaf02ec70f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.B7.08738.D20FAE16; Sat, 22 Jan 2022 02:41:01 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220121174059epsmtip2069f9e3a28f4eca44204090340dc38b8~MWfHVBZ8X1230312303epsmtip2h;
        Fri, 21 Jan 2022 17:40:59 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, sboyd@kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com,
        Sathyakam M <sathya@samsung.com>
Subject: [PATCH v3 10/16] clk: samsung: fsd: Add cam_csi block clock
 information
Date:   Fri, 21 Jan 2022 22:58:34 +0530
Message-Id: <20220121172840.12121-11-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220121172840.12121-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmhq7eh1eJBlPW6Vk8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNafDnymtHi37WNLBaPr/9hcxDyWDNvDaPH71+TGD1mNfSyeWxa1cnm
        cefaHjaPzUvqPa6caGL16NuyitHjX9Ncdo/Pm+QCuKKybTJSE1NSixRS85LzUzLz0m2VvIPj
        neNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOAnlJSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX
        2CqlFqTkFJgU6BUn5haX5qXr5aWWWBkaGBiZAhUmZGe8vXmfreB4fMW5TWUNjF9Duhg5OCQE
        TCSOrtLsYuTiEBLYzShx7fJjFgjnE6PEl1NLGSGcz4wS017eZ4fpWHa+CCK+i1Hiz98+Jgin
        hUni54MPQO2cHGwC2hJ3p29hArFFBNwkbjR2gBUxCyxmlnh3awYTyCRhgSCJpm2sICaLgKrE
        kisSIOW8ArYS7XcXs4HYEgLyEqs3HGAGsTmB4q/PzmOGiB/gkPgy0RLCdpFoe/mIBcIWlnh1
        fAs7hC0l8fndXjaIm7MlenYZQ4RrJJbOOwZVbi9x4MocFpASZgFNifW79EHCzAJ8Er2/nzBB
        dPJKdLQJQVSrSjS/uwrVKS0xsbubFcL2kNjwZB4rJBAmMEr82nuIeQKj7CyEqQsYGVcxSqYW
        FOempxabFhjmpZbD4yg5P3cTIziZannuYLz74IPeIUYmDsZDjBIczEoivAX5rxKFeFMSK6tS
        i/Lji0pzUosPMZoCA2wis5Rocj4wneeVxBuaWBqYmJmZmVgamxkqifOeTt+QKCSQnliSmp2a
        WpBaBNPHxMEp1cCUEfrifKMC9528SS5B7Nq7H1T+250pUrt/4mf/VScPV27qmd+Y/DfyQ9P6
        316L4iumHShs9GVf9qzvHofEojUTDB/IOIWIbPV6o9L/ZP7UMxw/v9T72hY+Oem8XSb0zvY5
        S9uySnuDZj2Py5kZkGBkX+w5wSv4T63mb9kDrWcZgvOd7tlvfdPP3dL/SH/5JK+0LTZXDkz3
        +DTHf/O1wvmP+ztNll7ZZN9rt76xV56xK6krv+SCwp2pujMOeexuvBRf/I3/uc4z0TVvIvfr
        RX1kL3nT2XxLVCy6x/eu4oSd/l1P6q7tW/X8rdyz1aFBidVZK7sjHq7oF7jqK9Eqe6559yfW
        7gf1v/r4U7zkLrUpsRRnJBpqMRcVJwIAIppPNC8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsWy7bCSvK7uh1eJBs+OWVo8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNafDnymtHi37WNLBaPr/9hcxDyWDNvDaPH71+TGD1mNfSyeWxa1cnm
        cefaHjaPzUvqPa6caGL16NuyitHjX9Ncdo/Pm+QCuKK4bFJSczLLUov07RK4Mt7evM9WcDy+
        4tymsgbGryFdjBwcEgImEsvOF3UxcnIICexglDhzKhzElhCQlri+cQI7hC0ssfLfcyCbC6im
        iUli3+dNrCAJNgFtibvTtzCB2CICHhJt/+4xgxQxC2xllvi8/wsryAJhgQCJt78EQUwWAVWJ
        JVckQMp5BWwl2u8uZoOYLy+xesMBZhCbEyj++uw8Zoh7bCSaZ21lmsDIt4CRYRWjZGpBcW56
        brFhgVFearlecWJucWleul5yfu4mRnAsaGntYNyz6oPeIUYmDsZDjBIczEoivAX5rxKFeFMS
        K6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYDpdfuDg6bYwgYWb
        3S8FLWLxdZBzmeDUEKCfLLVqtebtH+8LXawWps98OCvyzQTB35czfu8WDV3rYH/0RY3L6uvZ
        D3sKc6vXaymlqa/aF5p44Z3Sn6mGSxYFFuqFhyqlfRTT/yAXdP+5QDBja2B4kuL07zNZSlKK
        jqQ/u5+9t+4J78G5P6dVZh51Eg2ePHV++4lfRyXuiE9ZPaWGf6v0/mqfyZNcj0ks+/i/aELX
        i7tbZSM5l/pLxF89JzO7W4d/qc/37i2Zeszqklo2OVwrF77dan9G0WMDV6ZYRW6w3a33z+I/
        n5f5vyEvieesBfcllb8HGxQ+fuFceOKol+GhuX+Oi5/TzevxXpUvaP5NIV6JpTgj0VCLuag4
        EQBDSrN39AIAAA==
X-CMS-MailID: 20220121174102epcas5p32991b37e5be465e189ec5aeed32907bd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220121174102epcas5p32991b37e5be465e189ec5aeed32907bd
References: <20220121172840.12121-1-alim.akhtar@samsung.com>
        <CGME20220121174102epcas5p32991b37e5be465e189ec5aeed32907bd@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds clocks for BLK_CAM_CSI block, this is needed for CSI to work.

Cc: linux-fsd@tesla.com
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Sathyakam M <sathya@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/clk/samsung/clk-fsd.c | 207 ++++++++++++++++++++++++++++++++++
 1 file changed, 207 insertions(+)

diff --git a/drivers/clk/samsung/clk-fsd.c b/drivers/clk/samsung/clk-fsd.c
index a9c4424b29ff..4f88d71cb52e 100644
--- a/drivers/clk/samsung/clk-fsd.c
+++ b/drivers/clk/samsung/clk-fsd.c
@@ -1545,6 +1545,210 @@ static const struct samsung_cmu_info mfc_cmu_info __initconst = {
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
@@ -1576,6 +1780,9 @@ static const struct of_device_id fsd_cmu_of_match[] = {
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
2.25.1

