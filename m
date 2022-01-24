Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50AA0498254
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239064AbiAXOae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:30:34 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:42164 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239197AbiAXO3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:29:46 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220124142943epoutp02c8fc9035dd2ea4329f8642e1b2575d3b~NOz_qWpza3235432354epoutp02g
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:29:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220124142943epoutp02c8fc9035dd2ea4329f8642e1b2575d3b~NOz_qWpza3235432354epoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643034583;
        bh=wZ7PtuZok47SxFdXeEhGgmrUkFf4vCwDm2YTZISZTCA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AagDkSzf7KCO8oaRSlEqPao0T5lH4X64MoCnucxGVNwnuv9WfhJtao2CWUSuPeIDO
         IRBgaihbN+ti060yjbaZGRgIHETUNTydBDvxaj8NlC9mrduMo4VK1k1SteYn3tl3QC
         LfnqyYQ5yATkbTrPA4+G91jsRWvcc0xJzhsuaA+8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220124142942epcas5p2b2d697e96f6820032568b88ebb924b3a~NOz9-ZT0J0974109741epcas5p2a;
        Mon, 24 Jan 2022 14:29:42 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JjC6p2m17z4x9Ps; Mon, 24 Jan
        2022 14:29:38 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B2.34.05590.2D7BEE16; Mon, 24 Jan 2022 23:29:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220124142937epcas5p3bdce50bbaa02bbd762cf000401e03ade~NOz5TOkOm0627406274epcas5p3I;
        Mon, 24 Jan 2022 14:29:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220124142937epsmtrp20939bafbe643ea32236849d9d5b789c9~NOz5RTsMo1656816568epsmtrp27;
        Mon, 24 Jan 2022 14:29:37 +0000 (GMT)
X-AuditID: b6c32a4b-739ff700000015d6-b3-61eeb7d2c406
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E6.EA.29871.1D7BEE16; Mon, 24 Jan 2022 23:29:37 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220124142934epsmtip162d1ff424a5d0ae82a7af703ad0d09c5~NOz2GJ6_m1063810638epsmtip1h;
        Mon, 24 Jan 2022 14:29:34 +0000 (GMT)
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
Subject: [PATCH v5 10/16] clk: samsung: fsd: Add cam_csi block clock
 information
Date:   Mon, 24 Jan 2022 19:46:38 +0530
Message-Id: <20220124141644.71052-11-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220124141644.71052-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAJsWRmVeSWpSXmKPExsWy7bCmuu6l7e8SDaZcEbJ4MG8bm8XfScfY
        Ld4v62G0mH/kHKvFxrc/mCym/FnOZLHp8TVWi48991gtHr4Kt7i8aw6bxYzz+5gsTl3/zGax
        aOsXdovWvUfYLQ6/aWe1+HLkNaPFv2sbWSweX//D5iDksWbeGkaP378mMXrMauhl89i0qpPN
        4861PWwem5fUe1w50cTq0bdlFaPHv6a57B6fN8kFcEVl22SkJqakFimk5iXnp2TmpdsqeQfH
        O8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAPaWkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8u
        sVVKLUjJKTAp0CtOzC0uzUvXy0stsTI0MDAyBSpMyM44OO8fU8GJ+Ipfq3azNzB+C+li5OCQ
        EDCRePfJrouRi0NIYDejxPM//5ggnE+MEn8+zIByvjFKrPu6gLmLkROs4/Wp+8wQib2MEt9W
        f2KDcFqYJI7cnMoCUsUmoC1xd/oWJhBbRMBN4kZjB9goZoHFzBLvbs0ASwgLBEl8e3mAHcRm
        EVCVWPR/EhuIzStgK9E85R4rxDp5idUbDoCt5gSKz1v4DWyQhMABDolJc24yQnzhIvFrDi9E
        vbDEq+Nb2CFsKYnP7/ayQZRkS/TsMoYI10gsnXeMBcK2lzhwZQ4LSAmzgKbE+l36IGFmAT6J
        3t9PmCA6eSU62oQgqlUlmt9dheqUlpjY3Q11pIfEhjU7oGEygVHi/vEPLBMYZWchTF3AyLiK
        UTK1oDg3PbXYtMA4L7UcHk/J+bmbGMFJVct7B+OjBx/0DjEycTAeYpTgYFYS4a1KeZcoxJuS
        WFmVWpQfX1Sak1p8iNEUGGITmaVEk/OBaT2vJN7QxNLAxMzMzMTS2MxQSZz3VPqGRCGB9MSS
        1OzU1ILUIpg+Jg5OqQamHXyif2zEdvr8uXtQ9KaE26X7kzUa2FcEWMTd8FddPL+w6Z623v52
        04OmqbNX+U4IXBvX83Nz3FNGz85jWfFC0nMmCPSfYKi9k779zbz/ds5NTGJp562Pfr2b/G3H
        3oR84cASp1XBNm/1Y731L95etU/mlEfL5GL2KWrdnssUlj3kXfh1y5L/rK+lel9qT7S7qL6T
        +YP+Jv31ZqKX1lRH9B3N71X6lupa1Gv1q2P6ssWn7u+u+PH/l0PionTZ+Myk8hWfb0tYG27Y
        ebVt28O+nCWnmT/OMjevmaqQPevE3IUR4eJ7ZzxhLj5VmhwuK2lqcfZE8q9etxnT5N9Klyou
        6GNfYN9VZexlqs+s6ndZiaU4I9FQi7moOBEAau5JHjMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSnO7F7e8SDa5u07F4MG8bm8XfScfY
        Ld4v62G0mH/kHKvFxrc/mCym/FnOZLHp8TVWi48991gtHr4Kt7i8aw6bxYzz+5gsTl3/zGax
        aOsXdovWvUfYLQ6/aWe1+HLkNaPFv2sbWSweX//D5iDksWbeGkaP378mMXrMauhl89i0qpPN
        4861PWwem5fUe1w50cTq0bdlFaPHv6a57B6fN8kFcEVx2aSk5mSWpRbp2yVwZRyc94+p4ER8
        xa9Vu9kbGL+FdDFyckgImEi8PnWfuYuRi0NIYDejxITmr0wQCWmJ6xsnsEPYwhIr/z1nhyhq
        YpL4vfMAG0iCTUBb4u70LWANIgIeEm3/7oFNYhbYyizxef8XVpCEsECAxNKrv8EmsQioSiz6
        PwmsmVfAVqJ5yj1WiA3yEqs3HGAGsTmB4vMWfgMaygG0zUbi3G+VCYx8CxgZVjFKphYU56bn
        FhsWGOallusVJ+YWl+al6yXn525iBMeEluYOxu2rPugdYmTiYDzEKMHBrCTCW5XyLlGINyWx
        siq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGpov/ldmeB15wS5zJ
        7CdY6L35deuhu4ueqDdd4lgwr//PLG3WT2UmJWIukhmrIgIrdeLrWBQr2dIdNHv/XtTf+Sc9
        yU516uqWK1MPTt/1OWCLTfak2VN6e733c5w7c3yf3qTHzPwrxO45Hnz6WbKXzzeIdcXk3T6s
        Ry51iQolWKTWGLR+q1j974NqnWxHPP+mHdOtnzsskjjdVbBF202TbdrkE/FTg5Zd9bmpcyDz
        yqrJR1v7pfviJuouc7145v++d1dlnBx/fdg9abue3Ya3bwJ2bnz/Mlf6gsrzS8c2e7+8cULe
        oS1hx5THqec/nbbIWsF49kORsqv+1N6rJr8NWq3VdtwJKNhttrMgwTjol4MSS3FGoqEWc1Fx
        IgDnIR7M+AIAAA==
X-CMS-MailID: 20220124142937epcas5p3bdce50bbaa02bbd762cf000401e03ade
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220124142937epcas5p3bdce50bbaa02bbd762cf000401e03ade
References: <20220124141644.71052-1-alim.akhtar@samsung.com>
        <CGME20220124142937epcas5p3bdce50bbaa02bbd762cf000401e03ade@epcas5p3.samsung.com>
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
index f9c4b4c5e0cb..5d009c70e97d 100644
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
+	PLL_35XX_RATE(24 * MHZ, 1066000000U, 533, 12, 0),
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

