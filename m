Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C52C492934
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 16:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345651AbiARPB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 10:01:59 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:29196 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345621AbiARPA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 10:00:58 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220118150056epoutp014055b8a3ea2edd71bc79ca98b7fe13d2~LZXg9vvet2790327903epoutp01K
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 15:00:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220118150056epoutp014055b8a3ea2edd71bc79ca98b7fe13d2~LZXg9vvet2790327903epoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642518056;
        bh=Jko0deM+aPRApDy9TUBoNh+lOEqNroF/M4fSY3mcIsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=trMQjr/eOOkftEJaPfq+IJYEk3HSyd9BA1geBSEbyW3gdrF7w+QvIQs/gEBeb1cMi
         EAHm1DvrihDSxF7ZsTvo10d9a0r6aD/fXhZwtG+xmXhree8HtJPmUmvaHZ09lYwNAI
         Nvu4sawxc4//ofciym6wxPAfN79MhlZ8nOwuN/nc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220118150055epcas5p35826f0390b2cd3705f513ed2982fd157~LZXgQ2V_10440604406epcas5p3l;
        Tue, 18 Jan 2022 15:00:55 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JdX5Y5rwmz4x9Py; Tue, 18 Jan
        2022 15:00:49 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FF.98.05590.126D6E16; Wed, 19 Jan 2022 00:00:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220118150048epcas5p3449136cf0dbc2186d91c4472e9df68e0~LZXaMsdXj0676106761epcas5p3Y;
        Tue, 18 Jan 2022 15:00:48 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220118150048epsmtrp270b97f3d37af3ab302d5d7a8c2c388e1~LZXaLxfOF2220222202epsmtrp2D;
        Tue, 18 Jan 2022 15:00:48 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-3b-61e6d6210bc0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9D.A1.29871.026D6E16; Wed, 19 Jan 2022 00:00:48 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220118150046epsmtip1ad0d0ce8195dccb6f2c6e2a9efc491c9~LZXXuZWj70761107611epsmtip1k;
        Tue, 18 Jan 2022 15:00:46 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com, Smitha T Murthy <smitha.t@samsung.com>
Subject: [PATCH v2 09/16] clk: samsung: fsd: Add cmu_mfc block clock
 information
Date:   Tue, 18 Jan 2022 20:18:44 +0530
Message-Id: <20220118144851.69537-10-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118144851.69537-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmuq7itWeJBl0tJhYP5m1js/g76Ri7
        xftlPYwW84+cY7XY+PYHk8WUP8uZLDY9vsZq8bHnHqvFw1fhFpd3zWGzmHF+H5PFqeuf2SwW
        bf3CbtG69wi7xeE37awWd/dsY7R4fP0Pm4Ogx5p5axg9fv+axOgxq6GXzWPTqk42jzvX9rB5
        bF5S73HlRBOrR9+WVYwe/5rmsnt83iQXwBWVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZg
        qGtoaWGupJCXmJtqq+TiE6DrlpkD9I+SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAl
        p8CkQK84Mbe4NC9dLy+1xMrQwMDIFKgwITtj6rszzAU7jCvOLvrG3sB4QqeLkYNDQsBE4tRc
        wy5GLg4hgd2MEn9aTrFBOJ8YJaa2d7FCON8YJfbs+AOU4QTrePvsDFRiL6PE4wcboVpamCQm
        fF3IBFLFJqAtcXf6FjBbRMBN4kZjB5jNLDCdWeLgknQQW1ggSOLrq52MIDaLgKrE5O+HwGxe
        AVuJz+0rWCC2yUus3nCAGcTmBIpPbZgKtkxCYAeHxNozr9khnnCR+H7WBaJeWOLV8S3sELaU
        xOd3e9kgSrIlenYZQ4RrJJbOOwY13l7iwJU5LCAlzAKaEut36UNcySfR+/sJE0Qnr0RHmxBE
        tapE87urUJ3SEhO7u1khbA+J3XM3sENCYQKjRH/nfrYJjLKzEKYuYGRcxSiZWlCcm55abFpg
        nJdaDo+m5PzcTYzgRKrlvYPx0YMPeocYmTgYDzFKcDArifBK1T9LFOJNSaysSi3Kjy8qzUkt
        PsRoCgyxicxSosn5wFSeVxJvaGJpYGJmZmZiaWxmqCTOeyp9Q6KQQHpiSWp2ampBahFMHxMH
        p1QDE/d0q38hE9bPTf53lonRT7R76bobryfMWy7nEbRLh9uygzOv+ujcuZMUA9XdjXSfO2x9
        12ftslXj9Zfra6QLWuIz24Vv3yl9z5VwwaJuWeeGWUufPNp4yrXS0uI7n+Xsswys39xXOJ1e
        IibqkSLzQ+L3wxkeK6QXrcjJPu7cH1Oa8GBHmX55gejRxztvfPF42mgZ+DT6h4vH8oa9xvIL
        +mKnfShQ2bLtV+LrV88UODfET5jS/7Bbef4T2+MrlrEvKtI5eNaw+qqjyJI5YTe5li5qzBBz
        mjj9ArtGnoFrosXWnSpTX4i2z3a8kzGvW1W8f1PSucgXNyeY/5W7tvhFWUPpZQfuaTs9qxdc
        PrxZ3F6JpTgj0VCLuag4EQAWgUgKLQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSnK7CtWeJBnOajSwezNvGZvF30jF2
        i/fLehgt5h85x2qx8e0PJospf5YzWWx6fI3V4mPPPVaLh6/CLS7vmsNmMeP8PiaLU9c/s1ks
        2vqF3aJ17xF2i8Nv2lkt7u7Zxmjx+PofNgdBjzXz1jB6/P41idFjVkMvm8emVZ1sHneu7WHz
        2Lyk3uPKiSZWj74tqxg9/jXNZff4vEkugCuKyyYlNSezLLVI3y6BK2PquzPMBTuMK84u+sbe
        wHhCp4uRk0NCwETi7bMzrCC2kMBuRonV23gh4tIS1zdOYIewhSVW/nsOZHMB1TQxSWxaeAis
        gU1AW+Lu9C1MILaIgIdE2797zCBFzALLmSUO7P3ODJIQFgiQ2LTuAguIzSKgKjH5+yFGEJtX
        wFbic/sKFogN8hKrNxwAq+cEik9tmMoGcZGNxMWV05gnMPItYGRYxSiZWlCcm55bbFhgmJda
        rlecmFtcmpeul5yfu4kRHAlamjsYt6/6oHeIkYmD8RCjBAezkgivVP2zRCHelMTKqtSi/Pii
        0pzU4kOM0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4pRqYZmYvef3p8MnQ6KPugT+tl3uu
        TLLb/GFS/PHSf4UX8zqLhC7caczTXRO7QMtQJmmmfNRzTw/7y7ln/y/N0Gj/8GiLjfuOpDcr
        v3P9vO+39KPI3Xp1z3Q9f5ftlk13Z5WqMOj63/6/j2nNswdLv91oeO6i23v66xs1awHd0Ixn
        J5cb7f6YJZTh/WtJkxMrc0xSmteLWf9P/hVifnWroupgi/bj3Ux/k+rvVW24nhG9duVfBZG5
        DOcXrKo5/7dIqMzO9MGVw9u1Tr/xV3/2PvLb9Ot3C/YnHbvByC8gX7P55KyJB9ISVr3NVWCe
        PvfMpTfXMs8V76uWzHmxakLMzt9/bx1gKji2r405w7r+05p28UNKLMUZiYZazEXFiQB31XzD
        8wIAAA==
X-CMS-MailID: 20220118150048epcas5p3449136cf0dbc2186d91c4472e9df68e0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220118150048epcas5p3449136cf0dbc2186d91c4472e9df68e0
References: <20220118144851.69537-1-alim.akhtar@samsung.com>
        <CGME20220118150048epcas5p3449136cf0dbc2186d91c4472e9df68e0@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds cmu_mfc clock related code, these clocks are
required for MFC IP.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/clk/samsung/clk-fsd.c | 121 ++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/drivers/clk/samsung/clk-fsd.c b/drivers/clk/samsung/clk-fsd.c
index 8c879f7cb6a9..72a2b38524a1 100644
--- a/drivers/clk/samsung/clk-fsd.c
+++ b/drivers/clk/samsung/clk-fsd.c
@@ -1425,6 +1425,124 @@ static void __init fsd_clk_imem_init(struct device_node *np)
 
 CLK_OF_DECLARE(fsd_clk_imem, "tesla,fsd-clock-imem", fsd_clk_imem_init);
 
+/* Register Offset definitions for CMU_MFC (0x12810000) */
+#define PLL_LOCKTIME_PLL_MFC					0x0
+#define PLL_CON0_PLL_MFC					0x100
+#define MUX_MFC_BUSD						0x1000
+#define MUX_MFC_BUSP						0x1008
+#define DIV_MFC_BUSD_DIV4					0x1800
+#define GAT_MFC_CMU_MFC_IPCLKPORT_PCLK				0x2000
+#define GAT_MFC_AS_P_MFC_IPCLKPORT_PCLKM			0x2004
+#define GAT_MFC_AS_P_MFC_IPCLKPORT_PCLKS			0x2008
+#define GAT_MFC_AXI2APB_MFC_IPCLKPORT_ACLK			0x200c
+#define GAT_MFC_MFC_IPCLKPORT_ACLK				0x2010
+#define GAT_MFC_NS_BRDG_MFC_IPCLKPORT_CLK__PMFC__CLK_MFC_D	0x2018
+#define GAT_MFC_NS_BRDG_MFC_IPCLKPORT_CLK__PMFC__CLK_MFC_P	0x201c
+#define GAT_MFC_PPMU_MFCD0_IPCLKPORT_ACLK			0x2028
+#define GAT_MFC_PPMU_MFCD0_IPCLKPORT_PCLK			0x202c
+#define GAT_MFC_PPMU_MFCD1_IPCLKPORT_ACLK			0x2030
+#define GAT_MFC_PPMU_MFCD1_IPCLKPORT_PCLK			0x2034
+#define GAT_MFC_SYSREG_MFC_IPCLKPORT_PCLK			0x2038
+#define GAT_MFC_TBU_MFCD0_IPCLKPORT_CLK				0x203c
+#define GAT_MFC_TBU_MFCD1_IPCLKPORT_CLK				0x2040
+#define GAT_MFC_BUSD_DIV4_GATE					0x2044
+#define GAT_MFC_BUSD_GATE					0x2048
+
+static const unsigned long mfc_clk_regs[] __initconst = {
+	PLL_LOCKTIME_PLL_MFC,
+	PLL_CON0_PLL_MFC,
+	MUX_MFC_BUSD,
+	MUX_MFC_BUSP,
+	DIV_MFC_BUSD_DIV4,
+	GAT_MFC_CMU_MFC_IPCLKPORT_PCLK,
+	GAT_MFC_AS_P_MFC_IPCLKPORT_PCLKM,
+	GAT_MFC_AS_P_MFC_IPCLKPORT_PCLKS,
+	GAT_MFC_AXI2APB_MFC_IPCLKPORT_ACLK,
+	GAT_MFC_MFC_IPCLKPORT_ACLK,
+	GAT_MFC_NS_BRDG_MFC_IPCLKPORT_CLK__PMFC__CLK_MFC_D,
+	GAT_MFC_NS_BRDG_MFC_IPCLKPORT_CLK__PMFC__CLK_MFC_P,
+	GAT_MFC_PPMU_MFCD0_IPCLKPORT_ACLK,
+	GAT_MFC_PPMU_MFCD0_IPCLKPORT_PCLK,
+	GAT_MFC_PPMU_MFCD1_IPCLKPORT_ACLK,
+	GAT_MFC_PPMU_MFCD1_IPCLKPORT_PCLK,
+	GAT_MFC_SYSREG_MFC_IPCLKPORT_PCLK,
+	GAT_MFC_TBU_MFCD0_IPCLKPORT_CLK,
+	GAT_MFC_TBU_MFCD1_IPCLKPORT_CLK,
+	GAT_MFC_BUSD_DIV4_GATE,
+	GAT_MFC_BUSD_GATE,
+};
+
+static const struct samsung_pll_rate_table pll_mfc_rate_table[] __initconst = {
+	PLL_35XX_RATE(24 * MHZ, 666000000, 111, 4, 0),
+};
+
+static const struct samsung_pll_clock mfc_pll_clks[] __initconst = {
+	PLL(pll_142xx, 0, "fout_pll_mfc", "fin_pll",
+	    PLL_LOCKTIME_PLL_MFC, PLL_CON0_PLL_MFC, pll_mfc_rate_table),
+};
+
+PNAME(mout_mfc_pll_p) = { "fin_pll", "fout_pll_mfc" };
+PNAME(mout_mfc_busp_p) = { "fin_pll", "dout_mfc_busd_div4" };
+PNAME(mout_mfc_busd_p) = { "fin_pll", "mfc_busd_gate" };
+
+static const struct samsung_mux_clock mfc_mux_clks[] __initconst = {
+	MUX(0, "mout_mfc_pll", mout_mfc_pll_p, PLL_CON0_PLL_MFC, 4, 1),
+	MUX(0, "mout_mfc_busp", mout_mfc_busp_p, MUX_MFC_BUSP, 0, 1),
+	MUX(0, "mout_mfc_busd", mout_mfc_busd_p, MUX_MFC_BUSD, 0, 1),
+};
+
+static const struct samsung_div_clock mfc_div_clks[] __initconst = {
+	DIV(0, "dout_mfc_busd_div4", "mfc_busd_div4_gate", DIV_MFC_BUSD_DIV4, 0, 4),
+};
+
+static const struct samsung_gate_clock mfc_gate_clks[] __initconst = {
+	GATE(0, "mfc_cmu_mfc_ipclkport_pclk", "mout_mfc_busp",
+	     GAT_MFC_CMU_MFC_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "mfc_as_p_mfc_ipclkport_pclkm", "mout_mfc_busd",
+	     GAT_MFC_AS_P_MFC_IPCLKPORT_PCLKM, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "mfc_as_p_mfc_ipclkport_pclks", "mout_mfc_busp",
+	     GAT_MFC_AS_P_MFC_IPCLKPORT_PCLKS, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "mfc_axi2apb_mfc_ipclkport_aclk", "mout_mfc_busp",
+	     GAT_MFC_AXI2APB_MFC_IPCLKPORT_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(MFC_MFC_IPCLKPORT_ACLK, "mfc_mfc_ipclkport_aclk", "mout_mfc_busd",
+	     GAT_MFC_MFC_IPCLKPORT_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "mfc_ns_brdg_mfc_ipclkport_clk__pmfc__clk_mfc_d", "mout_mfc_busd",
+	     GAT_MFC_NS_BRDG_MFC_IPCLKPORT_CLK__PMFC__CLK_MFC_D, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "mfc_ns_brdg_mfc_ipclkport_clk__pmfc__clk_mfc_p", "mout_mfc_busp",
+	     GAT_MFC_NS_BRDG_MFC_IPCLKPORT_CLK__PMFC__CLK_MFC_P, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "mfc_ppmu_mfcd0_ipclkport_aclk", "mout_mfc_busd",
+	     GAT_MFC_PPMU_MFCD0_IPCLKPORT_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "mfc_ppmu_mfcd0_ipclkport_pclk", "mout_mfc_busp",
+	     GAT_MFC_PPMU_MFCD0_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "mfc_ppmu_mfcd1_ipclkport_aclk", "mout_mfc_busd",
+	     GAT_MFC_PPMU_MFCD1_IPCLKPORT_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "mfc_ppmu_mfcd1_ipclkport_pclk", "mout_mfc_busp",
+	     GAT_MFC_PPMU_MFCD1_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "mfc_sysreg_mfc_ipclkport_pclk", "mout_mfc_busp",
+	     GAT_MFC_SYSREG_MFC_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "mfc_tbu_mfcd0_ipclkport_clk", "mout_mfc_busd",
+	     GAT_MFC_TBU_MFCD0_IPCLKPORT_CLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "mfc_tbu_mfcd1_ipclkport_clk", "mout_mfc_busd",
+	     GAT_MFC_TBU_MFCD1_IPCLKPORT_CLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "mfc_busd_div4_gate", "mout_mfc_pll",
+	     GAT_MFC_BUSD_DIV4_GATE, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "mfc_busd_gate", "mout_mfc_pll", GAT_MFC_BUSD_GATE, 21, CLK_IS_CRITICAL, 0),
+};
+
+static const struct samsung_cmu_info mfc_cmu_info __initconst = {
+	.pll_clks		= mfc_pll_clks,
+	.nr_pll_clks		= ARRAY_SIZE(mfc_pll_clks),
+	.mux_clks		= mfc_mux_clks,
+	.nr_mux_clks		= ARRAY_SIZE(mfc_mux_clks),
+	.div_clks		= mfc_div_clks,
+	.nr_div_clks		= ARRAY_SIZE(mfc_div_clks),
+	.gate_clks		= mfc_gate_clks,
+	.nr_gate_clks		= ARRAY_SIZE(mfc_gate_clks),
+	.nr_clk_ids		= MFC_NR_CLK,
+	.clk_regs		= mfc_clk_regs,
+	.nr_clk_regs		= ARRAY_SIZE(mfc_clk_regs),
+};
+
 /**
  * fsd_cmu_probe - Probe function for FSD platform clocks
  * @pdev: Pointer to platform device
@@ -1453,6 +1571,9 @@ static const struct of_device_id fsd_cmu_of_match[] = {
 	}, {
 		.compatible = "tesla,fsd-clock-fsys1",
 		.data = &fsys1_cmu_info,
+	}, {
+		.compatible = "tesla,fsd-clock-mfc",
+		.data = &mfc_cmu_info,
 	}, {
 	},
 };
-- 
2.25.1

