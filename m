Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D49492938
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 16:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345771AbiARPCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 10:02:03 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:26780 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345742AbiARPBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 10:01:03 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220118150101epoutp046ee135f9b25f3353e4065d7221364776~LZXmR-Gns1679416794epoutp04z
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 15:01:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220118150101epoutp046ee135f9b25f3353e4065d7221364776~LZXmR-Gns1679416794epoutp04z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642518061;
        bh=hPFsCr5uGHixwaTPZZs+M6uhKbY7FszPYRcuTll2uKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kGZdQk+YSNiBR5lKTIVfuaVUvsGWb+L34WP/PrzHi/4RaZtjX3vRlTsMxJl3xhEUo
         +SVKOZon9Wdph4kuWYznwVJa9/ivVqWhwp2NsZepskXNN3JBsqBNVN3Mdzu7fnH5gM
         zTwXmQRCYJbiRLXnX2oREQowgLjcH+tzrfkWZ2oA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220118150101epcas5p392feee7e29ab2d1a7048b3a9f7b84611~LZXliBHAJ0676106761epcas5p3m;
        Tue, 18 Jan 2022 15:01:01 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JdX5d2K6Wz4x9Pv; Tue, 18 Jan
        2022 15:00:53 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FC.AE.46822.AC5D6E16; Tue, 18 Jan 2022 23:59:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220118150052epcas5p12efa399d1a59fc2fb0595eef128ffdf9~LZXd1g3g00561905619epcas5p1d;
        Tue, 18 Jan 2022 15:00:52 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220118150052epsmtrp2f49caaeb66c47ec8b9d15d9f36a8b52a~LZXd0evlh2220222202epsmtrp2G;
        Tue, 18 Jan 2022 15:00:52 +0000 (GMT)
X-AuditID: b6c32a4a-dfbff7000000b6e6-32-61e6d5ca4eac
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EE.A1.29871.426D6E16; Wed, 19 Jan 2022 00:00:52 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220118150050epsmtip1d6a5d0d76f2b537e3f511d8574787357~LZXbYHtO01212912129epsmtip1q;
        Tue, 18 Jan 2022 15:00:50 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com, Sathyakam M <sathya@samsung.com>
Subject: [PATCH v2 10/16] clk: samsung: fsd: Add cam_csi block clock
 information
Date:   Tue, 18 Jan 2022 20:18:45 +0530
Message-Id: <20220118144851.69537-11-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118144851.69537-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmlu6pq88SDQ6eMbZ4MG8bm8XfScfY
        Ld4v62G0mH/kHKvFxrc/mCym/FnOZLHp8TVWi48991gtHr4Kt7i8aw6bxYzz+5gsTl3/zGax
        aOsXdovWvUfYLQ6/aWe1+HLkNaPF4+t/2BwEPdbMW8Po8fvXJEaPWQ29bB6bVnWyedy5tofN
        Y/OSeo8rJ5pYPfq2rGL0+Nc0l93j8ya5AK6obJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMD
        Q11DSwtzJYW8xNxUWyUXnwBdt8wcoH+UFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUp
        OQUmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZE2ecZCpojK+4u+MhewPjlpAuRk4OCQETibeT
        X7N2MXJxCAnsZpQ4vvMbE4TziVHi8OGNLBDON0aJM20fWGFazs7YwgiR2MsoMXn2XyinhUni
        29sesCo2AW2Ju9O3MIHYIgJuEjcaO8DmMgtMZJbYtO0KI0hCWCBI4tjqC2A2i4CqxL/O2WAN
        vAK2EpPmvGCDWCcvsXrDAWYQmxMoPrVhKhvIIAmBLRwSc+dOYIYocpHY92snVIOwxKvjW9gh
        bCmJz+/2AsU5gOxsiZ5dxhDhGoml846xQNj2EgeuzGEBKWEW0JRYv0sfJMwswCfR+/sJE0Qn
        r0RHmxBEtapE87urUJ3SEhO7u6GB4iExbVkzNBwmMEo8PrCfdQKj7CyEqQsYGVcxSqYWFOem
        pxabFhjlpZbDYyo5P3cTIzidanntYHz44IPeIUYmDsZDjBIczEoivFL1zxKFeFMSK6tSi/Lj
        i0pzUosPMZoCg2wis5Rocj4woeeVxBuaWBqYmJmZmVgamxkqifOeTt+QKCSQnliSmp2aWpBa
        BNPHxMEp1cCk2PVunr0FX77B8VsHvU5yrjtc+Ez7TdYm6xMLWN+6LpI35UvV/3YlP2DN5FVJ
        jBY1GxRfH9ybsfLg2hXH5y7Y9KlvOZO4eGLKxMjqfc8vVsmevtR0f4/1YfOpEmbLWM9tkXiq
        NCtU9PpT765OOxEbD9EFfxJkqicfj02fmGD7a2mO65LUnc3dIQsa9/ww9Nwpvvx/d38tf8+N
        B4lv+q5/65z2hK+br/TkLzOl3iuvap/r7cqOSZwnIxrgt/Xgs4a5XouXbv/5yobxYEPGte+s
        U6MPFgszqM+4axCfc+7exqkpZ9eYrOSsqtioc3XDnN3vP72NTF7d1XJtctFGrm+5815rxXkF
        VXhsz0kK1jB0UmIpzkg01GIuKk4EAEpxQ6QwBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSnK7KtWeJBhMW6Vo8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNafDnymtHi8fU/bA6CHmvmrWH0+P1rEqPHrIZeNo9NqzrZPO5c28Pm
        sXlJvceVE02sHn1bVjF6/Guay+7xeZNcAFcUl01Kak5mWWqRvl0CV8bEGSeZChrjK+7ueMje
        wLglpIuRk0NCwETi7IwtjF2MXBxCArsZJfY+7meCSEhLXN84gR3CFpZY+e85O0RRE5PE6q+n
        wRJsAtoSd6dvAWsQEfCQaPt3jxnEZhZYyCzx9EQmiC0sECBx7/wPRhCbRUBV4l/nbLB6XgFb
        iUlzXrBBLJCXWL3hAFgvJ1B8asNUsLiQgI3ExZXTmCcw8i1gZFjFKJlaUJybnltsWGCYl1qu
        V5yYW1yal66XnJ+7iREcCVqaOxi3r/qgd4iRiYPxEKMEB7OSCK9U/bNEId6UxMqq1KL8+KLS
        nNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZODilGpgy1hUmh0sv+cP3bfqZtB8/pi/3
        PXtSe6bI9OrCX3VG8XsVCvhFS1Z+ZQ665tejGn7FSvTo9GW3jO5ezdnPcbi8b4ZzVnYAd/UX
        n98ewiuWXtcrLjsTsHx7yJ+F86wbni4+OO266yaNcv1fe7zn67Jz/TlyVe9cd8SsLT7RDjZG
        vf6xaVuXiIe6vtq61NLawKPnyr7w/V9X1y6b8/JwRrbJoUXJC8/YNbgazlCZGGmon3Lb/8mO
        xVq7vd+VR7ld+rhfunnFTZ56Ls9s0V632XN6GvI15k9YeLPl2yzdpw2WDW4rDnuLb9RYo7lA
        eu2+YLYH9qsnVnPmedu8f+lUuaSrPfqZ/1T+qVpFL6UUF/xTYinOSDTUYi4qTgQAh+mraPMC
        AAA=
X-CMS-MailID: 20220118150052epcas5p12efa399d1a59fc2fb0595eef128ffdf9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220118150052epcas5p12efa399d1a59fc2fb0595eef128ffdf9
References: <20220118144851.69537-1-alim.akhtar@samsung.com>
        <CGME20220118150052epcas5p12efa399d1a59fc2fb0595eef128ffdf9@epcas5p1.samsung.com>
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
index 72a2b38524a1..afac8760ebe1 100644
--- a/drivers/clk/samsung/clk-fsd.c
+++ b/drivers/clk/samsung/clk-fsd.c
@@ -1543,6 +1543,210 @@ static const struct samsung_cmu_info mfc_cmu_info __initconst = {
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
@@ -1574,6 +1778,9 @@ static const struct of_device_id fsd_cmu_of_match[] = {
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

