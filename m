Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B058C48D797
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbiAMMYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:24:12 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:59050 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbiAMMXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:23:53 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220113122352epoutp040d9549c7e37f44750f3b619ccd69c612~J0-88JI362463124631epoutp04t
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:23:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220113122352epoutp040d9549c7e37f44750f3b619ccd69c612~J0-88JI362463124631epoutp04t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642076632;
        bh=1iOMoe6wIQteiV98S5feZ8dgCERVEke1k/+vtPE9Pmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dNK1kQ8CiqCS0ve0F2EVHJmHQ7tQ0hhkYYc9jCAI7K3EhyhmVNqGJDQCmW2oZlrpf
         hkkqGmjfSH8q6ve9qTygLlsB8XmuphQUVQj4vs0HCtynFU+ZhFS4CrhodLCbrGpf7H
         OHqYzwpELp6gsqPCg+IBUCVijleQAEXTqVO0/Pts=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220113122351epcas5p44d6fb047c638ccb0f56ccc6b3a6bc2c8~J0-8YTFDe3143231432epcas5p4b;
        Thu, 13 Jan 2022 12:23:51 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JZNrb6c9tz4x9Q5; Thu, 13 Jan
        2022 12:23:43 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D7.11.46822.FC910E16; Thu, 13 Jan 2022 21:23:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220113122343epcas5p23831143e4e8fb92be8ad362f4817c03b~J0-0Yk4VB2479424794epcas5p2f;
        Thu, 13 Jan 2022 12:23:43 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220113122343epsmtrp18b3899c67c4ffe69eb6d2214a08f1cb0~J0-0W_H6U1911119111epsmtrp1_;
        Thu, 13 Jan 2022 12:23:43 +0000 (GMT)
X-AuditID: b6c32a4a-dfbff7000000b6e6-50-61e019cfa495
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.99.08738.EC910E16; Thu, 13 Jan 2022 21:23:42 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220113122340epsmtip24a687f32c1a61b3ca7cc0e7f91f54623~J0-xywX3y1245812458epsmtip2n;
        Thu, 13 Jan 2022 12:23:40 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com, Arjun K V <arjun.kv@samsung.com>,
        Tauseef Nomani <tauseef.n@samsung.com>
Subject: [PATCH 07/23] clk: samsung: fsd: Add cmu_imem block clock
 information
Date:   Thu, 13 Jan 2022 17:41:27 +0530
Message-Id: <20220113121143.22280-8-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220113121143.22280-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOJsWRmVeSWpSXmKPExsWy7bCmlu4FyQeJBk2bmCwezNvGZrF85S4W
        i/fLehgt5h85x2qx8e0PJospf5YzWWx6fI3V4mPPPVaLh6/CLS7vmsNmMeP8PiaLU9c/s1ks
        2vqF3aJ17xF2i8Nv2lktHl//w2Zx6eRkFgdBjzXz1jB6zGroZfPYtKqTzePOtT1sHpuX1Htc
        OdHE6tG3ZRWjx7+muewenzfJBXBGZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqY
        KynkJeam2iq5+AToumXmAL2ipFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwKdAr
        TswtLs1L18tLLbEyNDAwMgUqTMjOODnlLkvB8mbGih9TZ7A1MM4r7WLk5JAQMJG4fbCfvYuR
        i0NIYDejxOLF61hBEkICnxgllt1jhkh8ZpRY0jKFBabj6KMfbBCJXYwSEz/egHJamCTa/v1j
        B6liE9CWuDt9CxOILSLgJnGjsYMJpIhZYBWzxJu+o2AJYYEAiW3bj7GB2CwCqhK9s/aCNfMK
        2Ei8/PESap28xOoNB4Du4ODgFLCVuLsqD2SOhMBaDolP53YxQtS4SEw5tQbKFpZ4dXwLO4Qt
        JfGyv40dpFdCIFuiZ5cxRLhGYum8Y1Dj7SUOXJnDAlLCLKApsX6XPkiYWYBPovf3EyaITl6J
        jjYhiGpVieZ3V6E6pSUmdnezQtgeEi//rIOG4gRGiTc7+lknMMrOQpi6gJFxFaNkakFxbnpq
        sWmBUV5qOTyikvNzNzGCU6iW1w7Ghw8+6B1iZOJgPMQowcGsJMLbX3Q/UYg3JbGyKrUoP76o
        NCe1+BCjKTDEJjJLiSbnA5N4Xkm8oYmlgYmZmZmJpbGZoZI47+n0DYlCAumJJanZqakFqUUw
        fUwcnFINTH4f/aZu+P5BwmGPZ45K7r3aSRd+vBUq8J5keWPf6mKXTw/uf3wh+PzDLD8dXi+l
        T+VsJTlt4dwzlRn3eN6vrf1wJPDrkzlLPvrV8ioWPyvlWhn/ZPP1vQpaG7QV911TNV3NMknc
        KjfJatHkHj01BcH6ffFXFAVsvrTwK8ku05iyTPWf8T2TjSK9jWnsvIe477I17Na0naD6eeYy
        HoVFDt9eT07PT949Y/F+rvtBj7uVRXISnjy8ZK0g5e1ge06w/Ddbz52i8MzWHHfLkr2C+4J+
        f11y8c+uufrZc6/933DPuOXi93W3b57V+rHX5fGMV+dObg+c/kF/bvSHPZZZogL7D+znuBpV
        ufPdkYe9YU+VWIozEg21mIuKEwExtQxPKgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsWy7bCSvO45yQeJBsu7VSwezNvGZrF85S4W
        i/fLehgt5h85x2qx8e0PJospf5YzWWx6fI3V4mPPPVaLh6/CLS7vmsNmMeP8PiaLU9c/s1ks
        2vqF3aJ17xF2i8Nv2lktHl//w2Zx6eRkFgdBjzXz1jB6zGroZfPYtKqTzePOtT1sHpuX1Htc
        OdHE6tG3ZRWjx7+muewenzfJBXBGcdmkpOZklqUW6dslcGWcnHKXpWB5M2PFj6kz2BoY55V2
        MXJySAiYSBx99IOti5GLQ0hgB6NE765PbBAJaYnrGyewQ9jCEiv/PQezhQSamCSubhUGsdkE
        tCXuTt/CBGKLCHhItP27xwwyiFlgF7PEiv+rWUASwgJ+Ep83/wJrZhFQleidtRfM5hWwkXj5
        4yULxAJ5idUbDgA1c3BwCthK3F2VB7HLRuLcq/VsExj5FjAyrGKUTC0ozk3PLTYsMMpLLdcr
        TswtLs1L10vOz93ECA5/La0djHtWfdA7xMjEwXiIUYKDWUmEt7/ofqIQb0piZVVqUX58UWlO
        avEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTBaeoa4n5xvzutz3eLn2grq+00v1
        I+5rhNvt/wrbPX9rbC7g7Psi6/J5ib/e011+GE+WSTijPefeJv3PhXpLQr3cPzw1PTdJf63V
        hjea6bdfRlfZ9t2+kX1Q44CR9xOeDOvCjIxe98/7Jt210/32Z31zltzBu3JMW58FsryoNoji
        qzTZ3HAp/l6R3gee4tTu39fm969xLqi8Vm4X0mBup8jSmh+yIk/xWrSF9CouQ77SnlOHDOVV
        ciVOKtnWP3FSZfDlmb37fZvZ1qRl7+ctrX180yJc7eKkg2sau/VTvs86O3X5VjXnHDGmx90c
        J5+sPz1r4zzuUyv/N6/7NfVVe2DwnhV3VQIWvG7IvFBlp8RSnJFoqMVcVJwIAG8A4PLuAgAA
X-CMS-MailID: 20220113122343epcas5p23831143e4e8fb92be8ad362f4817c03b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122343epcas5p23831143e4e8fb92be8ad362f4817c03b
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
        <CGME20220113122343epcas5p23831143e4e8fb92be8ad362f4817c03b@epcas5p2.samsung.com>
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
index d06afab39d37..dc252e63099d 100644
--- a/drivers/clk/samsung/clk-fsd.c
+++ b/drivers/clk/samsung/clk-fsd.c
@@ -1184,6 +1184,289 @@ static const struct samsung_cmu_info fsys1_cmu_info __initconst = {
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
2.17.1

