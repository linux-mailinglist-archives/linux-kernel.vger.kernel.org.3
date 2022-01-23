Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6687497517
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 20:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240041AbiAWTUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 14:20:32 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:41417 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239857AbiAWTUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 14:20:15 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220123192014epoutp0341c2200c19ba34fac60c228bca47c477~M-IV6Ylxr2561025610epoutp03s
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 19:20:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220123192014epoutp0341c2200c19ba34fac60c228bca47c477~M-IV6Ylxr2561025610epoutp03s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642965614;
        bh=u2GnqrC4b59hdzMO9jSPsOHHBdT+FQJdIyCW4QNFhns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OHE3z+kSR9ETfIq8miDrTl0N6k9AMn++fOTWyPklPaUgKPi7n+ARbctbwyexnnOwW
         L5syFLIKUcsdnOJ+JE36nk6LR4Jt1hPzHI4SAM9XCk3x08dj3EzZrz8MEnT3+WVe8V
         6psWqeuvT2Fwgj7MH7k6MM0z38rEf2tiNX5q3BL8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220123192013epcas5p2fe8bb6e1ddb881273f48b11bf55c39ce~M-IU_l0XI2307423074epcas5p2p;
        Sun, 23 Jan 2022 19:20:13 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JhjcS4ylGz4x9Pr; Sun, 23 Jan
        2022 19:20:08 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        52.47.06423.86AADE16; Mon, 24 Jan 2022 04:20:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220123192007epcas5p328e069a2d129705d3c9bf6afa965f0fb~M-IPfR0KN1076210762epcas5p3t;
        Sun, 23 Jan 2022 19:20:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220123192007epsmtrp1352a30c660408f0eb412ec6c7852d853~M-IPeQu-q3102531025epsmtrp1H;
        Sun, 23 Jan 2022 19:20:07 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-88-61edaa68c61f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        65.F7.29871.76AADE16; Mon, 24 Jan 2022 04:20:07 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220123192002epsmtip1a5829e979a23b6f8bd03404394b33969~M-IK45DpW0799407994epsmtip1E;
        Sun, 23 Jan 2022 19:20:02 +0000 (GMT)
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
Subject: [PATCH v4 08/16] clk: samsung: fsd: Add cmu_imem block clock
 information
Date:   Mon, 24 Jan 2022 00:37:21 +0530
Message-Id: <20220123190729.1852-9-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220123190729.1852-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGJsWRmVeSWpSXmKPExsWy7bCmpm7GqreJBq/eqVg8mLeNzWL5yl0s
        Fn8nHWO3eL+sh9Fi/pFzrBYb3/5gspjyZzmTxabH11gtPvbcY7V4+Crc4vKuOWwWM87vY7I4
        df0zm8WirV/YLVr3HmG3OPymndXi37WNLBaPr/9hs7h0cjKLg7DHmnlrGD1+/5rE6DGroZfN
        Y9OqTjaPO9f2sHlsXlLvceVEE6tH35ZVjB7/muaye3zeJBfAFZVtk5GamJJapJCal5yfkpmX
        bqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQP0mZJCWWJOKVAoILG4WEnfzqYov7Qk
        VSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO+PNh4tMBW+bGSvenN3A3MB4
        v7SLkZNDQsBE4mXra8YuRi4OIYHdjBKrpnxmh3A+MUr0P5wPlfnGKHGz5TArTMvJE6+gEnsZ
        JSbOmsUG4bQwSWx9t5QFpIpNQFvi7vQtTCC2iICbxI3GDjCbWeAss8TSDh8QW1ggWOLY+81A
        9RwcLAKqEt/vqIKEeQWsJa7M2sgOsUxeYvWGA8wgNqeAjUTvqw+sILskBE5wSHScfc0CUeQi
        Mb2jhxHCFpZ4dXwLVLOUxMv+NnaQ+RIC2RI9u4whwjUSS+cdg2q1lzhwZQ7YCcwCmhLrd+lD
        XMkn0fv7CRNEJ69ER5sQRLWqRPO7q1Cd0hITu7uhQeIh8WRHHzQU+hklrsw4yDiBUXYWwtQF
        jIyrGCVTC4pz01OLTQsM81LL4RGVnJ+7iRGcYLU8dzDeffBB7xAjEwfjIUYJDmYlEd6C/FeJ
        QrwpiZVVqUX58UWlOanFhxhNgSE2kVlKNDkfmOLzSuINTSwNTMzMzEwsjc0MlcR5T6dvSBQS
        SE8sSc1OTS1ILYLpY+LglGpgcqnk/8NZN3FKs6RsadiMifapXBPVt1YfNWqXSzX2fW8zy/99
        8Ncq9n2ZD80ehnG+nd1mcffrhujrLpMdHj2XMjxQxih20jooKepBa3zokUVvopb9epC3du/p
        r1e4JKUzXseEfp3C+oDVJO3aj9YllXNtVxjNYbs0IclU4PU5K/vFRjNCf9UYdvM/0t9yKOzR
        I5uLdxSmn3Se1Xmt6Ob/vP1T9RhempeKLf0pbZj3qC3F9v1LTv2EM/frt3Hvv8L3rDw7/0dI
        22yZr/tfv3Bykv+gKu8YsObEje3+1V9/J5QmWU41OTN790Yj4z6rz0G7m7XF0wskomaEmbPY
        WpiWhztY92v2hE6PfWcZpeSvxFKckWioxVxUnAgAK0s92TkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSnG76qreJBld38Fs8mLeNzWL5yl0s
        Fn8nHWO3eL+sh9Fi/pFzrBYb3/5gspjyZzmTxabH11gtPvbcY7V4+Crc4vKuOWwWM87vY7I4
        df0zm8WirV/YLVr3HmG3OPymndXi37WNLBaPr/9hs7h0cjKLg7DHmnlrGD1+/5rE6DGroZfN
        Y9OqTjaPO9f2sHlsXlLvceVEE6tH35ZVjB7/muaye3zeJBfAFcVlk5Kak1mWWqRvl8CV8ebD
        RaaCt82MFW/ObmBuYLxf2sXIySEhYCJx8sQrxi5GLg4hgd2MErcvt7JBJKQlrm+cwA5hC0us
        /PecHaKoiUlievMKRpAEm4C2xN3pW5hAbBEBD4m2f/eYQYqYBe4zS2xqnczSxcjBISwQKHHm
        hT2IySKgKvH9jipIOa+AtcSVWRuh5stLrN5wgBnE5hSwkeh99YEVpFwIqGbCUbkJjHwLGBlW
        MUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIEx4aW5g7G7as+6B1iZOJgPMQowcGsJMJb
        kP8qUYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQamQ44r
        VHclvhZYa3vMbsqjHzZ/PLq2KpRObD7tWzJhs91Op+m/FOvfBtlIOITyrGvvdb7Kc/vX8deH
        /D6rt7Vtn3DAt/s6b9jBG19mfC0yYSu+f4Qx7vAHsdz7zK66Hl63427Pvn95qcctdqcT+ydK
        nzHnmPwqT/bt7Ja58h/F2u2ynsvfjk/tr/ilfPRK0boaxaY/DHpcNle3nDyiwPb9XENDjsI8
        0dZ5VRf1ntxeuFfIVUHvzZ2oPa/dediOXd16y5Rz6d5YaeV0veWCNR6H7sgo/RZZfvjYFP+u
        upjSvy1SFecT7W4prj7y29cnbdsX//OtPJ790lqyf2OOLvZdyRUX6ZPmtyGztO+7/rM7SizF
        GYmGWsxFxYkAfDoBTPwCAAA=
X-CMS-MailID: 20220123192007epcas5p328e069a2d129705d3c9bf6afa965f0fb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220123192007epcas5p328e069a2d129705d3c9bf6afa965f0fb
References: <20220123190729.1852-1-alim.akhtar@samsung.com>
        <CGME20220123192007epcas5p328e069a2d129705d3c9bf6afa965f0fb@epcas5p3.samsung.com>
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

