Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36C3498249
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239195AbiAXO37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:29:59 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:42002 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238815AbiAXO3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:29:36 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220124142934epoutp03434110ef15f77bcda49b48fe8b8b3c5e~NOz2bqc4w1357213572epoutp03O
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:29:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220124142934epoutp03434110ef15f77bcda49b48fe8b8b3c5e~NOz2bqc4w1357213572epoutp03O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643034574;
        bh=u2GnqrC4b59hdzMO9jSPsOHHBdT+FQJdIyCW4QNFhns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ifToIoVJLAzfmRg4zVbPD9w5ELbH0E4mZOPfUF0+EjhVc8cQ06xAxinM6PSXp3ltM
         jQBPU3HeE+1we7KuW+0oKFEiIK0P88zKO674nHieBRhh0kjs4Eie4berAsU89AKIDm
         NAytiFUO5Llu9JN8FgQqbcIwewZE55m83NVcdhiM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220124142934epcas5p49a4ed5c18a551e2048d6cbb8adedd706~NOz1uENwt0105201052epcas5p4S;
        Mon, 24 Jan 2022 14:29:34 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JjC6d0Z3cz4x9Pv; Mon, 24 Jan
        2022 14:29:29 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9E.24.05590.8C7BEE16; Mon, 24 Jan 2022 23:29:28 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220124142928epcas5p4cb956c77eac815ff4347e8e3b09bfb54~NOzwiuWbP0105201052epcas5p4F;
        Mon, 24 Jan 2022 14:29:28 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220124142928epsmtrp296b24db029d42a3f0851d6abeceb7636~NOzwhuvIj1656816568epsmtrp23;
        Mon, 24 Jan 2022 14:29:28 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-98-61eeb7c859cf
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        00.BB.08738.8C7BEE16; Mon, 24 Jan 2022 23:29:28 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220124142924epsmtip1652d38700a07aac63a05e78a816629e0~NOztJjOYK1678816788epsmtip11;
        Mon, 24 Jan 2022 14:29:24 +0000 (GMT)
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
Subject: [PATCH v5 08/16] clk: samsung: fsd: Add cmu_imem block clock
 information
Date:   Mon, 24 Jan 2022 19:46:36 +0530
Message-Id: <20220124141644.71052-9-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220124141644.71052-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCJsWRmVeSWpSXmKPExsWy7bCmuu6J7e8SDY58sbZ4MG8bm8XylbtY
        LP5OOsZu8X5ZD6PF/CPnWC02vv3BZDHlz3Imi02Pr7FafOy5x2rx8FW4xeVdc9gsZpzfx2Rx
        6vpnNotFW7+wW7TuPcJucfhNO6vFv2sbWSweX//DZnHp5GQWB2GPNfPWMHr8/jWJ0WNWQy+b
        x6ZVnWwed67tYfPYvKTe48qJJlaPvi2rGD3+Nc1l9/i8SS6AKyrbJiM1MSW1SCE1Lzk/JTMv
        3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoMyWFssScUqBQQGJxsZK+nU1RfmlJ
        qkJGfnGJrVJqQUpOgUmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsabDxeZCt42M1a8ObuBuYHx
        fmkXIyeHhICJxP39y9m7GLk4hAR2M0qcPrmCHSQhJPCJUeLCjyKIxGdGibfP77HDdTw/wQxR
        tItR4sqWLIiiFiaJW3sWgSXYBLQl7k7fwgRiiwi4Sdxo7ACzmQXOMkss7fABsYUFgiVeL+wD
        G8oioCrx/tIuNhCbV8BG4tOzI6wQy+QlVm84ADaTU8BWYt7Cb0wgyyQETnBIfL80gQ2iyEXi
        z/0VLBC2sMSr41ugLpWS+PxuL1ANB5CdLdGzyxgiXCOxdN4xqHJ7iQNX5rCAlDALaEqs36UP
        cSafRO/vJ0wQnbwSHW1CENWqEs3vrkJ1SktM7O6GutJDYs3Vb4yQIJnAKDHhstoERtlZCEMX
        MDKuYpRMLSjOTU8tNi0wzksth0dTcn7uJkZwctXy3sH46MEHvUOMTByMhxglOJiVRHirUt4l
        CvGmJFZWpRblxxeV5qQWH2I0BYbYRGYp0eR8YHrPK4k3NLE0MDEzMzOxNDYzVBLnPZW+IVFI
        ID2xJDU7NbUgtQimj4mDU6qBSdfWvGBWS2ye/OSJ8bY7up5X7WSUP/SF/0SFeLmJT3ecQD3H
        7RBuPXVZu8++1qZLvBMi2t0V304LllRZeUCpU7cm+nGrwPSCQ+8Tzu+tU45c8GlR+D/tL/2F
        MxftfGG4VFHxwyxm7aqTCSvXOuzrNc7+seDPoQ/Tvz3kO/2cbeaclvutPz3O/9qg8kL5SLJF
        eum9oqS21JUxWxbp9C6bVWryP3ta0B23xdGvWh+apf7SWbnEdeENtUX2druf3L5WMX//453W
        CRLzYzV/v1rb/+7ajjMHbOMmzJtx99euY+9W3uzPCFFX2bGitUN/p7fKnRcv7+l+LxH7ulu2
        4JSJ546Ob+H7tV7nNEfsfidRvE6JpTgj0VCLuag4EQDEC+wWNwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsWy7bCSnO6J7e8SDab8ELN4MG8bm8XylbtY
        LP5OOsZu8X5ZD6PF/CPnWC02vv3BZDHlz3Imi02Pr7FafOy5x2rx8FW4xeVdc9gsZpzfx2Rx
        6vpnNotFW7+wW7TuPcJucfhNO6vFv2sbWSweX//DZnHp5GQWB2GPNfPWMHr8/jWJ0WNWQy+b
        x6ZVnWwed67tYfPYvKTe48qJJlaPvi2rGD3+Nc1l9/i8SS6AK4rLJiU1J7MstUjfLoEr482H
        i0wFb5sZK96c3cDcwHi/tIuRk0NCwETi/vMTzF2MXBxCAjsYJQ4uPssKkZCWuL5xAjuELSyx
        8t9zdoiiJiaJ5gdTGEESbALaEnenb2ECsUUEPCTa/t0Dm8QscJ9ZYlPrZBaQhLBAoMSjM/eZ
        QWwWAVWJ95d2sYHYvAI2Ep+eHYHaJi+xesMBsBpOAVuJeQu/AQ3lANpmI3Hut8oERr4FjAyr
        GCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGC40NLawfjnlUf9A4xMnEwHmKU4GBWEuGt
        SnmXKMSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAOTaqvZ
        uegbap+Kd67l3ipbe/eulsHEXcd05RRmffl+OfT1boeMh+su7PsvMbN783L3orlMLdIcKR+E
        a3g1svrnLF6x73Vg4CWRJO5OjRnWB+bEpMXJ/FjvZSnHvLSp1dX93/pFb7s+3o88y/7MzMn8
        spLD93mpcseKV/gxXK/P+bW4dNJSn7qiSd9kHDa5nH/XuICfO/999skHeoGX2Daf2CfXnpTf
        +/qBrpeDLsNGI7Npe7ZV71ywtG39h/Wm5/1NvjuEKW9oXnhep5bn59rytze3F6s9/hiTbhX5
        7XRi3vmCrLKo3YXcOx0jWZYo5Zg/qJnreC7/uVC0/4tb95rb8vc8nna9tjf/1gWBjOIIJZbi
        jERDLeai4kQAAs1b2/4CAAA=
X-CMS-MailID: 20220124142928epcas5p4cb956c77eac815ff4347e8e3b09bfb54
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220124142928epcas5p4cb956c77eac815ff4347e8e3b09bfb54
References: <20220124141644.71052-1-alim.akhtar@samsung.com>
        <CGME20220124142928epcas5p4cb956c77eac815ff4347e8e3b09bfb54@epcas5p4.samsung.com>
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
index 19c3ea35a6ea..f15b5b6b8eca 100644
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

