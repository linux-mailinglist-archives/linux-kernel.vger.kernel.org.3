Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE0C49292F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 16:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345984AbiARPBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 10:01:55 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:46033 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345493AbiARPAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 10:00:54 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220118150051epoutp02d75aada0b1f49199af80133c88df6c99~LZXc7g_e72347523475epoutp02K
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 15:00:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220118150051epoutp02d75aada0b1f49199af80133c88df6c99~LZXc7g_e72347523475epoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642518051;
        bh=2cglEQoN9bU/HQP5eTa878YzkuABJh2Crj7ue2w3RSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ebvZMo5dqjJqldta27MWjF81p25BzKCsygjtceGASl8ezUZohgoawfbmMWyruCocI
         4WUaR+zx5hO9OiGFHCyOOuR1wtMS+OUXiQFly4R5DJpiZ16pSOx0vyFW4ix1giT65a
         AvDABeNEro2suVPP5QqPwsyI7goAj68kj+GmNraA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220118150051epcas5p4a069b2488e4a13e81cdf967cc1d963a1~LZXcO5PVd0382903829epcas5p4V;
        Tue, 18 Jan 2022 15:00:51 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JdX5T3ZRyz4x9Pv; Tue, 18 Jan
        2022 15:00:45 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        98.AE.46822.2C5D6E16; Tue, 18 Jan 2022 23:59:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220118150045epcas5p4e54922758fb7922b1fd8de0995d2127e~LZXWkiq8x1990519905epcas5p4F;
        Tue, 18 Jan 2022 15:00:45 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220118150045epsmtrp283dd76d5f7cdeb5b220e873a98f5ce55~LZXWji_M51935719357epsmtrp2h;
        Tue, 18 Jan 2022 15:00:45 +0000 (GMT)
X-AuditID: b6c32a4a-dfbff7000000b6e6-1c-61e6d5c2b435
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A4.F0.08738.C16D6E16; Wed, 19 Jan 2022 00:00:44 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220118150042epsmtip15c44cd7dbfd032f2a12d2412024983c4~LZXUDiaer0468004680epsmtip1a;
        Tue, 18 Jan 2022 15:00:42 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com, Arjun K V <arjun.kv@samsung.com>,
        Tauseef Nomani <tauseef.n@samsung.com>
Subject: [PATCH v2 08/16] clk: samsung: fsd: Add cmu_imem block clock
 information
Date:   Tue, 18 Jan 2022 20:18:43 +0530
Message-Id: <20220118144851.69537-9-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118144851.69537-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmuu6hq88SDd49tLF4MG8bm8XylbtY
        LP5OOsZu8X5ZD6PF/CPnWC02vv3BZDHlz3Imi02Pr7FafOy5x2rx8FW4xeVdc9gsZpzfx2Rx
        6vpnNotFW7+wW7TuPcJucfhNO6vF4+t/2CwunZzM4iDksWbeGkaP378mMXrMauhl89i0qpPN
        4861PWwem5fUe1w50cTq0bdlFaPHv6a57B6fN8kFcEVl22SkJqakFimk5iXnp2TmpdsqeQfH
        O8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAPaWkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8u
        sVVKLUjJKTAp0CtOzC0uzUvXy0stsTI0MDAyBSpMyM44tvsaU8HyZsaK7S96WBsY55V2MXJy
        SAiYSLyYMIW1i5GLQ0hgN6PEpje7mCCcT4wSy24cg8p8ZpR48uAhK0zL2vtTmCESuxglOh/8
        YYdwWpgk/u4/wQJSxSagLXF3+hYmEFtEwE3iRmMH2FxmgZ3MElPvvQErEhYIlvhy4i5YEYuA
        qsSM+VcZQWxeARuJm/O6mSHWyUus3nAAzOYUsJWY2jCVDWSQhMABDon7h1rYIYpcJE4eew3V
        ICzx6vgWqLiUxOd3e4EaOIDsbImeXcYQ4RqJpfOOsUDY9hIHrsxhASlhFtCUWL9LHyTMLMAn
        0fv7CRNEJ69ER5sQRLWqRPO7q1Cd0hITu7tZIUo8JJ5scAAJCwlMYJS49sBhAqPsLISZCxgZ
        VzFKphYU56anFpsWGOWllsMjKjk/dxMjOK1qee1gfPjgg94hRiYOxkOMEhzMSiK8UvXPEoV4
        UxIrq1KL8uOLSnNSiw8xmgIDbCKzlGhyPjCx55XEG5pYGpiYmZmZWBqbGSqJ855O35AoJJCe
        WJKanZpakFoE08fEwSnVwKRfKvstV/dCdHnPBgkpvxtFuvn8f5y29VwyWjur5KK4kQnjmw27
        /5yx28++cNujpAdnn55m067Vd8njON8bPImxJi216GbS20ABi4tGn+pELPW2RMwXNP46V+J9
        Nt+pqx4xv9ewzzV2vd9xy0LcIN3s7E2rrDANc/mAP2e6CpiFv8fpKm1ffmCSlZjp1n8snF2d
        69YU+TZrzHnyYq6ERyTTX9lV/gLvakteN84Xy5iuZnyv0KajrvDvfX69Hw7p7T5/4uRKdk1Z
        GvvvN1OIS/+bhpq1Hy/cO/kw+YfzzYnnLDN3H260ZD29tdF6izHL9+qIwjnb+no8W0KknEq3
        /xOyVrh//9s3Tl3x+9q2SizFGYmGWsxFxYkAX0wHIjQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOLMWRmVeSWpSXmKPExsWy7bCSnK7MtWeJBs23bSwezNvGZrF85S4W
        i7+TjrFbvF/Ww2gx/8g5VouNb38wWUz5s5zJYtPja6wWH3vusVo8fBVucXnXHDaLGef3MVmc
        uv6ZzWLR1i/sFq17j7BbHH7Tzmrx+PofNotLJyezOAh5rJm3htHj969JjB6zGnrZPDat6mTz
        uHNtD5vH5iX1HldONLF69G1Zxejxr2kuu8fnTXIBXFFcNimpOZllqUX6dglcGcd2X2MqWN7M
        WLH9RQ9rA+O80i5GTg4JAROJtfenMHcxcnEICexglDh/vJ0FIiEtcX3jBHYIW1hi5b/n7BBF
        TUwSV9btYwNJsAloS9ydvoUJxBYR8JBo+3cPbBKzwGlmid3bFoEVCQsESnRu38kIYrMIqErM
        mH8VzOYVsJG4Oa+bGWKDvMTqDQfAbE4BW4mpDVPBeoWAai6unMY8gZFvASPDKkbJ1ILi3PTc
        YsMCo7zUcr3ixNzi0rx0veT83E2M4LjQ0trBuGfVB71DjEwcjIcYJTiYlUR4peqfJQrxpiRW
        VqUW5ccXleakFh9ilOZgURLnvdB1Ml5IID2xJDU7NbUgtQgmy8TBKdXAxPf2p+ztRyf68qo3
        MeV2/Y9dqHRm8rzDNx3nHnXSPHImiuuG0BO/pAszq6oPLshLqbgslCH0oqW/oeXh8XdmE/yf
        drtvkdaQ1lf0ZWq4rPpJdU0kf6bc+VUfUuJk3Z48uH3koU6Isd7K/M62XtYJZsv8L4kfuN/5
        7r/wzoObfpdMqHryvfrm1MKJz3s3/ZkdXiH0bGPT1u4ViYvvMivEHivr8cl0n8fQcClvftOR
        z5p5U+a+WdXAzBGudJnl4tRth4O9U3nTfq3TzFvQZOn3Trlz6VWJx/bij1af/u6uGCYlGd2t
        L5hU+DXneTjv5bsnJh+ZYBq/41Sh15MpsxkPzxPc8HvCi/mLEo/JBFy8s1eJpTgj0VCLuag4
        EQDY+ywJ+gIAAA==
X-CMS-MailID: 20220118150045epcas5p4e54922758fb7922b1fd8de0995d2127e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220118150045epcas5p4e54922758fb7922b1fd8de0995d2127e
References: <20220118144851.69537-1-alim.akhtar@samsung.com>
        <CGME20220118150045epcas5p4e54922758fb7922b1fd8de0995d2127e@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds cmu_imem clock related code, imem block contains IPs
like WDT, DMA, TMU etc, these clocks are required for such
IP function.

Cc: linux-fsd@tesla.com
Signed-off-by: Arjun K V <arjun.kv@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Tauseef Nomani <tauseef.n@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/clk/samsung/clk-fsd.c | 283 ++++++++++++++++++++++++++++++++++
 1 file changed, 283 insertions(+)

diff --git a/drivers/clk/samsung/clk-fsd.c b/drivers/clk/samsung/clk-fsd.c
index 97973a629453..8c879f7cb6a9 100644
--- a/drivers/clk/samsung/clk-fsd.c
+++ b/drivers/clk/samsung/clk-fsd.c
@@ -1142,6 +1142,289 @@ static const struct samsung_cmu_info fsys1_cmu_info __initconst = {
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

