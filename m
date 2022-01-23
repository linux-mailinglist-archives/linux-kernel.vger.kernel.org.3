Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85843497519
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 20:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239873AbiAWTUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 14:20:35 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:52643 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239906AbiAWTUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 14:20:19 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220123192017epoutp010881f2f6efb649eeed6d1c655f3dc70e~M-IZSpr9a2229922299epoutp01D
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 19:20:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220123192017epoutp010881f2f6efb649eeed6d1c655f3dc70e~M-IZSpr9a2229922299epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642965617;
        bh=qTVoMiSTH12K4fl+27xJQfTYoC4Gy70PZPpBFOYTktg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dGIDsE1QpDDs203+Uykt6f6EZeIaUuwljkUmz/LUlx+F1eLC58vgkZNREya7YEnA6
         5WRHMeYQdNOlM6F8cuMrblig6mkuAiBRIrB/+phdJvjL5IToJuvcx/BqGRYmD1KXev
         PPvma+Kq8WZq3DZgn5jDPkHpQ9SXlhZPWV/+4UGQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220123192017epcas5p3da79524118f8c1ef954361ec31a2c3a5~M-IYgor0_2905929059epcas5p33;
        Sun, 23 Jan 2022 19:20:17 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JhjcW6NTlz4x9Py; Sun, 23 Jan
        2022 19:20:11 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        62.FD.05590.B6AADE16; Mon, 24 Jan 2022 04:20:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220123192011epcas5p480912c2a3195d4caa34ed140cda09ac0~M-IS_h5wI0240502405epcas5p4g;
        Sun, 23 Jan 2022 19:20:11 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220123192011epsmtrp2af9b677aab81c3694415188237673fc9~M-IS9kQrm2018820188epsmtrp2e;
        Sun, 23 Jan 2022 19:20:11 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-e2-61edaa6bd3a3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        08.C9.08738.A6AADE16; Mon, 24 Jan 2022 04:20:11 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220123192008epsmtip1e8916b4ce5fbc1f9f56360220ce7e051~M-IQhGU_P0562405624epsmtip1P;
        Sun, 23 Jan 2022 19:20:08 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, sboyd@kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com,
        Smitha T Murthy <smitha.t@samsung.com>
Subject: [PATCH v4 09/16] clk: samsung: fsd: Add cmu_mfc block clock
 information
Date:   Mon, 24 Jan 2022 00:37:22 +0530
Message-Id: <20220123190729.1852-10-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220123190729.1852-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmlm72qreJBg1HDSwezNvGZvF30jF2
        i/fLehgt5h85x2qx8e0PJospf5YzWWx6fI3V4mPPPVaLh6/CLS7vmsNmMeP8PiaLU9c/s1ks
        2vqF3aJ17xF2i8Nv2lkt/l3byGJxd882RovH1/+wOQh5rJm3htHj969JjB6zGnrZPDat6mTz
        uHNtD5vH5iX1HldONLF69G1Zxejxr2kuu8fnTXIBXFHZNhmpiSmpRQqpecn5KZl56bZK3sHx
        zvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlATykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otL
        bJVSC1JyCkwK9IoTc4tL89L18lJLrAwNDIxMgQoTsjMmv7rEWvDfuOLWvRssDYxdul2MnBwS
        AiYSs1r72LsYuTiEBHYzSpz4u4QFwvnEKPF52X9WCOczo8Tin+2MMC2rlx6FqtrFKDHnRD8T
        hNPCJLGs5RgrSBWbgLbE3elbmEBsEQE3iRuNHWBFzAIrmSV6Z11iBkkICwRJHLt8EMxmEVCV
        OLhxFVgDr4CNRP+S08wQ6+QlVm84AGZzAsV7X30Au0lCYA+HxKEnH1kgilwkzr+9C3WfsMSr
        41vYIWwpic/v9rJ1MXIA2dkSPbuMIcI1EkvnHYNqtZc4cGUOC0gJs4CmxPpd+iBhZgE+id7f
        T5ggOnklOtqEIKpVJZrfXYXqlJaY2N3NCmF7SHS9OcwMCYd+RomLJ1rZJzDKzkKYuoCRcRWj
        ZGpBcW56arFpgXFeajk8ppLzczcxghOrlvcOxkcPPugdYmTiYDzEKMHBrCTCW5D/KlGINyWx
        siq1KD++qDQntfgQoykwyCYyS4km5wNTe15JvKGJpYGJmZmZiaWxmaGSOO+p9A2JQgLpiSWp
        2ampBalFMH1MHJxSDUxz+ReumpQz5bP2yW0zrAx/n/hmGhLwRmrJNL84w2CRRR8m7v4zNfv4
        tg9s/dk+r1Kju+7cnPxIbTfb9Okaz/8dUI25wHlwdz6DqbDr+4gXs1jv3lh46mQp529vu/dR
        P+YlLJI82qG35LC19/aMAO+HB74c4N3yrIXnnIzWmst6WrdlovJYknVDrKV89n84sp5j/9cf
        d0yu/PdimRNc2/C1zKVEamdWJ9+8A9d53xwXuexww3/Ki4N5ErEWMef2zDjCrHps+ua96ffs
        T/Qs4VQIKjpyICKk+cvHmze7jxVphIpnhH3+Nbc85Z+z5ReW/0bnJ0iekm55/cTKNXvB1rWb
        +Vm4/IQ6Z4k6tvd5znFXVWIpzkg01GIuKk4EACZPC181BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSnG72qreJBu/fM1k8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNa/Lu2kcXi7p5tjBaPr/9hcxDyWDNvDaPH71+TGD1mNfSyeWxa1cnm
        cefaHjaPzUvqPa6caGL16NuyitHjX9Ncdo/Pm+QCuKK4bFJSczLLUov07RK4Mia/usRa8N+4
        4ta9GywNjF26XYycHBICJhKrlx5l6WLk4hAS2MEocWL6JhaIhLTE9Y0T2CFsYYmV/56zQxQ1
        MUlc2wnUD5RgE9CWuDt9CxOILSLgIdH27x4zSBGzwG5miX2TF7KCJIQFAiQWfj0AZrMIqEoc
        3LgKrIFXwEaif8lpZogN8hKrNxwAszmB4r2vPgDVcwBts5aYcFRuAiPfAkaGVYySqQXFuem5
        xYYFRnmp5XrFibnFpXnpesn5uZsYwTGhpbWDcc+qD3qHGJk4GA8xSnAwK4nwFuS/ShTiTUms
        rEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qBKXWSuf312XNZH/o9
        rte80CO95qaCRf+JmbNc/1fUcbaGHDnX1pN3ePtuyZ86MTWSi87tT00Ty/ouJhT15XfAjmjV
        jMVLFMxKzkYIztbvq4i/tu9c+Jdut8L7S1oiJN13nvnT4q5codvh8taMrcBm1aVkhQOnE+s+
        KUXG/3/7jbn8h4aEgWTk0VvS8atWTF0+4czDSB3R/f7RHuGfavolswPX+fqoLVihGeVx47XZ
        y1zNKOYbxZ+ZF93nqtltUftYxDnLL/Ha8ZQZF2tuVwfsuvNg9jfmeTt+iMcdXNtadkHfRLwq
        6/G5G0WaYdUOv/4W7Di6LNJBRHrGpBxLOeE5AVkiBeEbNAwiz96bW8atxFKckWioxVxUnAgA
        lmM+JPgCAAA=
X-CMS-MailID: 20220123192011epcas5p480912c2a3195d4caa34ed140cda09ac0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220123192011epcas5p480912c2a3195d4caa34ed140cda09ac0
References: <20220123190729.1852-1-alim.akhtar@samsung.com>
        <CGME20220123192011epcas5p480912c2a3195d4caa34ed140cda09ac0@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds cmu_mfc clock related code, these clocks are
required for MFC IP.

Cc: linux-fsd@tesla.com
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/clk/samsung/clk-fsd.c | 121 ++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/drivers/clk/samsung/clk-fsd.c b/drivers/clk/samsung/clk-fsd.c
index f15b5b6b8eca..f9c4b4c5e0cb 100644
--- a/drivers/clk/samsung/clk-fsd.c
+++ b/drivers/clk/samsung/clk-fsd.c
@@ -1427,6 +1427,124 @@ static void __init fsd_clk_imem_init(struct device_node *np)
 
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
+	PLL_35XX_RATE(24 * MHZ, 666000000U, 111, 4, 0),
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
@@ -1455,6 +1573,9 @@ static const struct of_device_id fsd_cmu_of_match[] = {
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

